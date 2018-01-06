 # -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy

class blogSpiderItem(scrapy.Item):
    # define the fields for your item here like:
    post_permalink = scrapy.Field()
    blog_name = scrapy.Field()
    post_title = scrapy.Field()
    post_auth = scrapy.Field()
    post_date = scrapy.Field()
    post_tags = scrapy.Field()
    post_categories = scrapy.Field()
    extracted_date = scrapy.Field()
    comment_count = scrapy.Field()
    post_content = scrapy.Field()
    post_length = scrapy.Field()
    num_outlinks = scrapy.Field()
    sentiment_score = scrapy.Field()
    post_lang = scrapy.Field()
    influence_score = scrapy.Field()
    post_content_html = scrapy.Field()
    data_quality = scrapy.Field()
    domain = scrapy.Field()