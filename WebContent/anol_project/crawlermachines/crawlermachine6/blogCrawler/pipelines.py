# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html

# import sys
# import pymysql
# import hashlib
# from scrapy.exceptions import DropItem
# from scrapy.http import Request


# class BlogcrawlerPipeline(object):
#     def __init__(self):
#         self.conn = pymysql.connect(
#             '144.167.112.118', 'ukraine_super', 'summer2014', 'roy', charset="utf8", use_unicode=True)
#         self.cursor = self.conn.cursor()

#     def process_item(self, item, spider):
#         try:
#             self.cursor.execute("""INSERT INTO test_db (post_permalink, blog_name, post_title, post_auth, post_date, extracted_date, comment_count, post_content) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)""",
#                                 (item['post_permalink'].encode('utf-8'),
#                                 item['blog_name'].encode('utf-8'),
#                                 item['post_title'].encode('utf-8'),
#                                 item['post_auth'].encode('utf-8'),
#                                 item['post_date'].encode('utf-8'),
#                                 item['extracted_date'].encode('utf-8'),
#                                 item['comment_count'].encode('utf-8'),
#                                 item['post_content'].encode('utf-8')))

#             self.conn.commit()
#             return item

#         except Exception as e:
#             handle_unknown_pymysql_exception(e, func_b)







# from scrapy.exceptions import DropItem

# class blogSpiderPipeline(object):
#     def process_item(self, item, spider):
#         required_fields = [post_content] # your list of required fields
#         if all(field in item for field in required_fields):
#             return item
#         else:
#             raise DropItem("your reason")