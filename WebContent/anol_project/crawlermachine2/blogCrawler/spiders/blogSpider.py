# -*- coding: utf-8 -*-
import scrapy
from scrapy.spiders import CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor
from scrapy.crawler import CrawlerProcess
from blogCrawler.items import blogSpiderItem
# from scrapy_splash import SplashRequest


from urllib.parse import urlparse
import datetime
import pandas as pd
from newspaper import Article
from textblob import TextBlob

import os
import subprocess
import json
import pymysql

from custom.custom_func import *
from metadata.post_author import *
from metadata.post_title import *
from metadata.post_date import *
from metadata.post_cmnt_count import *
from metadata.post_tags import *
from metadata.post_categories import *
from sanity_check.sanity_check import *


import re

# from scrapy.utils.log import configure_logging
# import logging


# logging messages in a file
# configure_logging(install_root_handler = False)

# logging.basicConfig(filename = 'logfile.txt',
# 					format = '%(asctime)s [%(name)s] %(levelname)s: %(message)s',
# 					level = logging.INFO)


# The crawler starts here
class blogSpider(CrawlSpider):
    # for recursive crawling, rename class parameter as CrawlSpider, uncomment rules, change parse function as parse_item

    # name = 'blogSpider'

    # allowed_domains = ['21stcenturywire.com']

    # start_urls = ['http://21stcenturywire.com/2017/12/17/episode-214-worlds-interesting-man-special-guest-adam-garrie/']

    # def start_requests(self):
    #     for url in self.start_urls:
    #         yield SplashRequest(url, self.parse, meta={
    # 			'splash': {
    # 				'endpoint': 'render.html',
    # 				'args': {'wait': 0.5}
    # 			}
    # 		})

    # rules = (
    #     Rule(LinkExtractor(allow=['2017/12/17/episode-214-worlds-interesting-man-special-guest-adam-garrie']),
    #          callback='parse_item',
    #          follow=False),
    # )

    with open('../jsonFiles/2.json') as data_file:
    	user_input = json.load(data_file)

    name = 'blogSpider'

    allowed_domains = [urlparse(user_input["crawl_url"]).netloc]

    start_urls = [user_input["crawl_url"]]

    page_limit = user_input["pages"]

    if (page_limit=="1"):
    	rules = (
    		Rule(LinkExtractor(allow=[urlparse(user_input["crawl_url"]).path]),
    		callback = 'parse_item',
    		follow = False),
    		)

    elif (page_limit=="10"):
    	rules = (
    		Rule(LinkExtractor(allow=[user_input["keyword"]]),
    		process_links=lambda l: l[:10],
    		callback = 'parse_item',
    		follow = False),
    		)

    elif (page_limit=="25"):
    	rules = (
    		Rule(LinkExtractor(allow=[user_input["keyword"]]),
    		process_links=lambda l: l[:25],
    		callback = 'parse_item',
    		follow = False),
    		)

    elif (page_limit=="50"):
    	rules = (
    		Rule(LinkExtractor(allow=[user_input["keyword"]]),
    		process_links=lambda l: l[:50],
    		callback = 'parse_item',
    		follow = False),
    		)

    elif (page_limit=="100"):
    	rules = (
    		Rule(LinkExtractor(allow=[user_input["keyword"]]),
    		process_links=lambda l: l[:100],
    		callback = 'parse_item',
    		follow = False),
    		)
    else:
    	rules = (
    		Rule(LinkExtractor(allow=[user_input["keyword"]]),
    		callback = 'parse_item',
    		follow = True),
    		)
    data_file.close()
    # Custom parsing

    def parse_item(self, response):

        self.logger.info('Custom parsing started for %s', response.url)

        # Fetching all the nodes that contain text
        text_nodes = response.xpath('//text()[normalize-space()]/parent::*')

        # finding number of outlinks
        num_outlinks = len(response.xpath('//a'))

        # def cleanhtml(raw_html):
        #     cleanr = re.compile('<.*?>')
        #     cleantext = re.sub(cleanr, '', raw_html)
        #     return cleantext

        # auth = cleanhtml(response.xpath('//div[@class="entry"]/p[1]').extract_first())

        # daily_stormer = auth.split('\n')[0]

        # Initialzing 3 list for creation of dataframe further
        nodes, texts, title_scores, author_scores, date_scores, cmnt_cnt_scores, tag_scores, category_scores = ([
        ] for i in range(8))

        # looping through each node that contains text
        for count, text_node in enumerate(text_nodes):

            # inserting each text to 'texts' list
            text = ''.join(text_node.xpath('text()').extract()).strip()
            texts.append(text)

            # inserting the parent node for each text to 'nodes' list
            node = text_node.xpath('name()').extract_first()
            nodes.append(node)

            # counting and appending post-title score for each text node
            node_depth = count / len(text_nodes)
            post_title_score = post_title_scorer(
                response, text_node, text, node, node_depth)
            title_scores.append(post_title_score.total_score())

            # counting and appending post-author score for each text node
            post_author_score = post_author_scorer(text_node, text, node)
            author_scores.append(post_author_score.total_score())

            # counting and appending post-date score for each text node

            post_date_score = post_date_scorer(
                text_node, text, node, node_depth)
            date_scores.append(post_date_score.total_score())

            # counting and appending post-comment-count score for each text node
            post_cmnt_cnt_score = post_cmnt_cnt_scorer(text_node, text)
            cmnt_cnt_scores.append(post_cmnt_cnt_score.total_score())

            # counting and appending post-comment-count score for each text node
            post_tag_score = post_tag_scorer(text_node, text, node)
            tag_scores.append(post_tag_score.total_score())

            # counting and appending post-comment-count score for each text node
            post_category_score = post_category_scorer(text_node, text, node)
            category_scores.append(post_category_score.total_score())

        # creating dict with lists: nodes, texts and scores
        data = {'node': nodes,
                'text': texts,
                'title_score': title_scores,
                'author_score': author_scores,
                'date_score': date_scores,
                'cmnt_count_score': cmnt_cnt_scores,
                'tag_score': tag_scores,
                'category_score': category_scores
                }

        # creating pandas dataframe
        df = pd.DataFrame(data)

        # Post title extraction
        highest_rank_pt = max(df.title_score)
        post_title_block = df.loc[df['title_score']
                                  == highest_rank_pt, 'text'].values[0]

        # Post author extraction
        highest_rank_pa = max(df.author_score)
        post_author_block = df.loc[df['author_score']
                                   == highest_rank_pa, 'text'].values[0]

        # Post date extraction
        highest_rank_pd = max(df.date_score)
        post_date_block = df.loc[df['date_score']
                                 == highest_rank_pd, 'text'].values[0]
        if not post_date_block:
            post_date_block = post_date_check(response)

        # Post comment count extraction
        highest_rank_pcc = max(df.cmnt_count_score)
        post_comment_count_block = df.loc[df['cmnt_count_score']
                                          == highest_rank_pcc, 'text'].values[0]

        # Post tags extraction
        highest_rank_ptag = max(df.tag_score)
        post_tag_block = df.loc[df['tag_score'] ==
                                highest_rank_ptag, 'text'].values[0]

        # Post tags extraction
        highest_rank_pcat = max(df.category_score)
        post_category_block = df.loc[df['category_score']
                                     == highest_rank_pcat, 'text'].values[0]

        # rank = df.loc[df['score'] == hi,'score'].values[0]

        # Post content extraction
        article = Article(response.url)
        article.download()
        article.parse()
        post_content_block = article.text

        # sanity checks
        post_title = article.title if not post_title_block else remove_quotes(
            post_title_block)
        post_auth = post_author_block
        if not post_auth:
            post_auth = article.authors
        post_date = article.publish_date if not post_date_block else normalize_metadate(
            post_date_block)
        post_content = remove_quotes(post_content_block)
        comment_count = post_comment_count_check(post_comment_count_block)
        post_tags = remove_quotes(post_tag_block)
        post_categories = remove_quotes(post_category_block)

        post_length = len(post_content)
        post_permalink = response.url
        blog_name = urlparse(post_permalink).netloc
        extracted_date = '{0:%Y-%m-%d %H:%M:%S}'.format(
            datetime.datetime.now())

        # additons
        post_lang = ''
        sentiment_score = 0
        if (post_length > 3):
            blob = TextBlob(post_content)
            post_lang = blob.detect_language()
            if (post_lang != "en"):
                trans = str(blob.translate(to="en"))
                sentiment_score = trans.sentiment.polarity
            else:
                sentiment_score = blob.sentiment.polarity

        # calculation of influence score
        length_factor = 0
        num_inlinks = 0
        if (post_length <= 350):
            length_factor = 1
        else:
            length_factor = 2 if post_length <= 1500 else 3
        scaling_factor = length_factor
        outlinks_normalized = num_outlinks / length_factor
        influence_flow = (0.6 * comment_count) + \
            (0.7 * num_inlinks) - (0.3 * outlinks_normalized)
        influence_score = scaling_factor * influence_flow

        core_meta = [post_title, post_auth, post_date, post_content]
        feed = 0
        for meta in core_meta:
            if meta:
                feed += 1
        data_quality = feed / 4

        # post_content_html = str(response.body)

        domain = urlparse(post_permalink).netloc

        # Pushing to database
        conn = pymysql.connect('144.167.112.118', 'ukraine_super',
                               'summer2014', 'blogtrackers', charset="utf8", use_unicode=True)
        try:
            with conn.cursor() as cursor:
                cursor.execute("""INSERT INTO blogposts_auto
							(title, date, blogger, categories, post, post_length, num_outlinks, num_comments, permalink, tags, sentiment,
							language, influence_score) 
                            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""",
                               (post_title.encode('utf-8'),
                                post_date,
                                post_auth,
                                post_categories.encode('utf-8'),
                                post_content.encode('utf-8'),
                                post_length,
                                num_outlinks,
                                comment_count,
                                post_permalink.encode('utf-8'),
                                post_tags.encode('utf-8'),
                                sentiment_score,
                                post_lang,
                                influence_score
                                ))
                conn.commit()
        finally:
            conn.close()

        # entry = blogSpiderItem()
        # entry['post_permalink'] = post_permalink
        # entry['blog_name'] = blog_name
        # entry['post_auth'] = post_auth
        # entry['post_title'] = post_title
        # entry['post_date'] = post_date
        # entry['extracted_date'] = extracted_date
        # entry['comment_count'] = comment_count
        # entry['post_content'] = post_content
        # entry['post_tags'] = post_tags
        # entry['post_categories'] = post_categories
        # entry['post_length'] = post_length
        # entry['num_outlinks'] = num_outlinks
        # entry['sentiment_score'] = sentiment_score
        # entry['post_lang'] = post_lang
        # entry['influence_score'] = influence_score
        # entry['data_quality'] = data_quality
        # entry['post_content_html'] = post_content_html
        # entry['data_quality'] = data_quality
        # entry['domain'] = domain
        # yield entry


# Running spiders through the CrawlerProcess
process = CrawlerProcess()
process.crawl(blogSpider)
process.start()
# the script will block here until all crawling jobs are finished
# {'FEED_URI': 'export.json', }
