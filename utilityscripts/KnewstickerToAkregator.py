#!/usr/bin/python

##############################################################################
#
# Copyright (C) 2005-2006 Kevin Deldycke - kevin@deldycke.com
#                         Martin Vidner  - http://vidner.net/martin/
#
# This program is Free Software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#
##############################################################################

"""
Description :
  This script parse the KNewsTicker configuration file of the current logged
  user to extract feeds references. Then the script generate a OPML/XML file
  that can be imported to Akregator.

Prerequisite :
  - KNewsTicker
  - Python
  - pyxml
"""


import ConfigParser, sys, os
from xml.dom import implementation
from xml.dom import EMPTY_NAMESPACE, XML_NAMESPACE
from xml.dom.ext import PrettyPrint
from commands import getstatusoutput



def getConfigFile():
  file_name = 'knewsticker_panelappletrc'

  # kde-config return the list of folder where kde config files are stored
  result = getstatusoutput("kde-config -path config")

  # Get the list (default sort : priority)
  if result[0] != 0:
    return None
  folder_list = result[1].split(':')
  if len(folder_list) <= 0:
    return None

  # Get the Knewsticker config file
  for folder in folder_list:
    knt_config_path = folder + file_name
    file_path = os.path.abspath(knt_config_path)
    if os.path.exists(file_path) and os.path.isfile(file_path):
      break
    else:
      file_path = None
  if file_path == None:
    return None
  return open(file_path, 'r')



def getFeeds(file):
  feed_list = {}

  # Define the mapping between KNewsTicker category ids and names
  cat = {  '0' : "Arts"
        ,  '1' : "Business"
        ,  '2' : "Computers"
        ,  '3' : "Games"
        ,  '4' : "Health"
        ,  '5' : "Home"
        ,  '6' : "Recreation"
        ,  '7' : "Reference"
        ,  '8' : "Science"
        ,  '9' : "Shopping"
        , '10' : "Society"
        , '11' : "Sports"
        , '12' : "Miscellaneous"
        , '13' : "Magazines"
        }

  # Parse the config file to get feeds info
  parser = ConfigParser.ConfigParser()
  parser.readfp(file)

  # Get the list of enabled feeds
  feeds_name_list = parser.get('KNewsTicker', 'news sources')

  # Parse every feed
  for section in feeds_name_list.split(','):
    if parser.has_option(section, 'source file'):
      # Get feed parameters
      feed = {}
      feed['url']  = parser.get(section, 'source file')
      feed['name'] = section
      # Get the category name
      category = 'Unknown'
      if parser.has_option(section, 'subject'):
        category_id = parser.get(section, 'subject')
        if category_id in cat.keys():
          category = cat[category_id]
      # Save the feed in the dictionnary
      caterory_feeds = [feed, ]
      if feed_list.has_key(category):
        caterory_feeds += feed_list[category]
      feed_list[category] = caterory_feeds

  return feed_list



def getAkregatorXml(feed_dict):
  # Create an empty DOM tree
  akregator_xml_type = implementation.createDocumentType("AkregatorXML", None, None)
  opml_doc = implementation.createDocument(EMPTY_NAMESPACE, "opml", akregator_xml_type)
  # Get the xml document root
  opml_root = opml_doc.documentElement

  # Create the opml container and body
  opml_root.setAttribute("version", "1.0")
  body = opml_doc.createElement("body")

  # Create a group for each category
  for category in feed_dict.keys():
    group = opml_doc.createElement("outline")
    group.setAttribute("isOpen", "true")
    group.setAttribute("text", category)
    # Transform each feed to XML
    for feed in feed_dict[category]:
      xml_feed = opml_doc.createElement("outline")
      xml_feed.setAttribute("xmlUrl", feed['url'])
      xml_feed.setAttribute("text", feed['name'])
      group.appendChild(xml_feed)
    # Save the group in the body
    body.appendChild(group)

  # Put the main container at the top of the DOM tree
  opml_root.appendChild(body)

  return opml_root



def writeXmlFile(dom_tree, file_name='feeds_to_import.xml'):

  # Save the file in the current folder
  out_file = os.path.join('./', file_name)
  out_path = os.path.abspath(out_file)
  out = open(out_path, 'w')

  # Print out the result
  out.write('<?xml version="1.0" encoding="UTF-8"?>')
  PrettyPrint(dom_tree, out)
  return out_file



if __name__ == "__main__":
  # Get the Knewsticker config file
  file_object = getConfigFile()
  if file_object == None:
    output("ERROR: KNewsTicker config file not found.")
    sys.exit()

  # Parse the config file to get all feeds
  knt_feeds = getFeeds(file_object)

  # Transform feeds data to XML
  xml_dom = getAkregatorXml(knt_feeds)

  # Save the file
  out_file = writeXmlFile(xml_dom)
  print "Feeds saved in " + out_file
