#user  nobody; # 用户权限
worker_processes  auto;  # 工作进程的数量
#worker_cpu_affinity auto;

#全局错误日志及PID文件
error_log  logs/error.log;  # 日志输出
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    #epoll是多路复用IO(I/O Multiplexing)中的一种方式,
    #use 设置用于复用客户端线程的轮询方法。如果你使用Linux 2.6+，你应该使用epoll。如果你使用*BSD，你应该使用kqueue。
    use   epoll; # IOCP[window] , kqueue[bsd] , epoll[linux]

    #单个后台worker process进程的最大并发链接数
    worker_connections  1024;

    #multi_accept 告诉nginx收到一个新连接通知后接受尽可能多的连接。
    multi_accept on;


    # 并发总数是 worker_processes 和 worker_connections 的乘积
    # 即 max_clients = worker_processes * worker_connections
    # 在设置了反向代理的情况下，max_clients = worker_processes * worker_connections / 4  为什么
    # 为什么上面反向代理要除以4，应该说是一个经验值
    # 根据以上条件，正常情况下的Nginx Server可以应付的最大连接数为：4 * 8000 = 32000
    # worker_connections 值的设置跟物理内存大小有关
    # 因为并发受IO约束，max_clients的值须小于系统可以打开的最大文件数
    # 而系统可以打开的最大文件数和内存大小成正比，一般1GB内存的机器上可以打开的文件数大约是10万左右
    # 我们来看看360M内存的VPS可以打开的文件句柄数是多少：
    # $ cat /proc/sys/fs/file-max
    # 输出 34336
    # 32000 < 34336，即并发连接总数小于系统可以打开的文件句柄总数，这样就在操作系统可以承受的范围之内
    # 所以，worker_connections 的值需根据 worker_processes 进程数目和系统可以打开的最大文件总数进行适当地进行设置
    # 使得并发总数小于操作系统可以打开的最大文件数目
    # 其实质也就是根据主机的物理CPU和内存进行配置
    # 当然，理论上的并发总数可能会和实际有所偏差，因为主机还有其他的工作进程需要消耗系统资源。
    # ulimit -SHn 65535
}


http {
    include       mime.types; #设定mime类型,类型由mime.type文件定义
    default_type  application/octet-stream;

    #设定日志格式
    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #设置nginx是否将存储访问日志。关闭这个选项可以让读取磁盘IO操作更快
    #access_log  logs/access.log  main;

     #sendfile 指令指定 nginx 是否调用 sendfile 函数（zero copy 方式）来输出文件，
    #对于普通应用，必须设为 on,
    #如果用来进行下载等应用磁盘IO重负载应用，可设置为 off，
    #以平衡磁盘与网络I/O处理速度，降低系统的uptime.
    # 高效文件传输
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;

    # types_hash_max_size 影响散列表的冲突率。types_hash_max_size越大，就会消耗更多的内存，但散列key的冲突率会降低，检索速度就更快。types_hash_max_size越小，消耗的内存就越小，但散列key的冲突率可能上升。
    types_hash_max_size 2048;

    #连接超时时间
    #keepalive_timeout  0;
    keepalive_timeout  65;

    gzip  on;
    gzip_disable "MSIE [1-6].";
    gzip_comp_level  6;
    gzip_min_length  1000; #置对数据启用压缩的最少字节数。如果一个请求小于1000字节，我们最好不要压缩它，因为压缩这些小的数据会降低处理此请求的所有进程的速度。
    gzip_proxied     expired no-cache no-store private auth;
    gzip_types       text/plain application/x-javascript text/xml text/css application/xml;

    #Buffers：另一个很重要的参数为buffer，如果buffer太小，Nginx会不停的写一些临时文件，这样会导致磁盘不停的去读写，现在我们先了解设置buffer的一些相关参数：
    #client_body_buffer_size:允许客户端请求的最大单个文件字节数
    #client_header_buffer_size:用于设置客户端请求的Header头缓冲区大小，大部分情况1KB大小足够
    #client_max_body_size:设置客户端能够上传的文件大小，默认为1m
    #large_client_header_buffers:该指令用于设置客户端请求的Header头缓冲区大小
    #设定请求缓冲
    client_body_buffer_size 10K;
    client_header_buffer_size 1k;
    client_max_body_size 8m;
    large_client_header_buffers 2 1k;


    map $http_user_agent $outdated {  # 判断浏览器版本
            default                    0;
            "~MSIE [6-9].[0-9]"        1;
            "~MSIE 10.0"               1;
    }

    # weight：轮询权值，默认值为1。
    # down：表示当前的server暂时不参与负载。
    # max_fails：允许请求失败的次数，默认为1。当超过最大次数时，返回 proxy_next_upstream 模块定义的错误。
    # fail_timeout：有两层含义，一是在fail_timeout时间内最多容许max_fails次失败；二是在经历了max_fails次失败以后，30s时间内不分配请求到这台服务器。
    # backup ： 备份机器。当其他所有的非 backup 机器出现故障的时候，才会请求backup机器，因此这台机器的压力最轻。
    # max_conns： 限制同时连接到某台后端服务器的连接数，默认为 0。即无限制。
    # proxy_next_upstream ： 这个指令属于 http_proxy 模块的，指定后端返回什么样的异常响应

    #负载均衡
    #upstream DataBase {
    #    ip_hash; # 每个请求按访问ip的hash结果分配，这样每个访客固定访问一个后端服务器，可以解决session的问题。
    #    server 10.xx.xx.xx weight=1 max_fails=2 fail_timeout=30s;
    #    server 10.xx.xx.xx;
    #    server 10.xx.xx.xx;
    #}

    server {
        listen       80; #端口号
          server_name  v.fpdiov.com; #域名


        location /api {  #代理API
            proxy_pass   http://api.fpdiov.com:8090;
        #    proxy_set_header Host      $host;
        #    proxy_set_header X-Real-IP $remote_addr; #在web服务器端获得用户的真实ip
        #   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_redirect     off;
            proxy_connect_timeout 600; #nginx跟后端服务器连接超时时间(代理连接超时)
            proxy_read_timeout 600; #连接成功后，后端服务器响应时间(代理接收超时)
            proxy_send_timeout 600; #后端服务器数据回传时间(代理发送超时)
            proxy_buffer_size 32k; #设置代理服务器（nginx）保存用户头信息的缓冲区大小
            proxy_buffers 4 32k; #proxy_buffers缓冲区，网页平均在32k以下的话，这样设置
            proxy_busy_buffers_size 64k; #高负荷下缓冲大小（proxy_buffers*2）
            proxy_temp_file_write_size 64k; #设定缓存文件夹大小，大于这个值，将从upstream服>务器传
            keepalive_requests 500;
            proxy_http_version 1.1;
            proxy_ignore_client_abort on;
        }

        location ^~ / {
            root /mnt/www/fpd-car-manage-frontend; #启动根目录
            if ($outdated = 1){
                rewrite ^ http://oisbyqrnc.bkt.clouddn.com redirect;  #判断浏览器版本跳转
            }
            index index.html; #默认访问页面
            try_files $uri $uri/ /index.html;
        }
    }


    #server {
    #    listen       80; #侦听80端口
    #    server_name  localhost; #访问域名

        #charset koi8-r; # 字符集

        #access_log  logs/host.access.log  main;

        #location / {
        #    root   html;
        #    index  index.html index.htm;
        #}

        #error_page  404              /404.html; #　错误页面

        # redirect server error pages to the static page /50x.html
        #
        #error_page   500 502 503 504  /50x.html;
        #location = /50x.html {
        #    root   html;
        #}

        #静态文件，nginx自己处理
        #location ~ ^/(images|javascript|js|css|flash|media|static)/ {

            #过期30天，静态文件不怎么更新，过期可以设大一点，
            #如果频繁更新，则可以设置得小一点。
        #   expires 30d;
        #}

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    #}


    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}


    # HTTPS server
    #
    #server {
    #启用 https, 使用 http/2 协议, nginx 1.9.11 启用 http/2 会有bug, 已在 1.9.12 版本中修复.
    #    listen       443 ssl;
    #    server_name  localhost;
    #     ssl on;
    #    ssl_certificate      cert.pem; #证书路径;
    #    ssl_certificate_key  cert.key; #私钥路径;

    #    ssl_session_cache    shared:SSL:1m;
    #    ssl_session_timeout  5m;

    #    ssl_ciphers  HIGH:!aNULL:!MD5; #指定的套件加密算法
    #    ssl_prefer_server_ciphers  on; # 设置协商加密算法时，优先使用我们服务端的加密套件，而不是客户端浏览器的加密套件。
    #    ssl_session_timeout 60m;  #缓存有效期
    #    ssl_session_cache shared:SSL:10m;  #储存SSL会话的缓存类型和大小
    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}

}
