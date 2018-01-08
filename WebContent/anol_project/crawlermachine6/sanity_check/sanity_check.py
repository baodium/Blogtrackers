# sanity check for post-title
def rmv_spcl_chars(text):
    return re.sub('[^a-zA-Z0-9-_*.]', ' ', text)

def remove_quotes(word):
    newWord = word.strip(".,!?;:&*'=-></#@)(") 
    newword2 = newWord.strip('.,!?;:&*"=-></#@)(')
    return newword2
    

# sanity check for post-author
from nltk.tag import pos_tag

def post_author_check(chunk):

    tagged_sent = pos_tag(chunk.split())
    # [('Michael', 'NNP'), ('Jackson', 'NNP'), ('likes', 'VBZ'), ('to', 'TO'), ('eat', 'VB'), ('at', 'IN'), ('McDonalds', 'NNP')]

    proper_nouns = [word for word,pos in tagged_sent if pos == 'NNP']
    # ['Michael','Jackson', 'McDonalds']

    named_entity = ' '.join(map(str,proper_nouns))
    return named_entity


# sanity check for post date
import dateparser

from urllib.parse import urlsplit
import re

def normalize_metadate(datetime):
    dateObj = dateparser.parse(datetime)
    date = dateObj.strftime('%Y-%m-%d %H:%M:%S') if dateObj is not None else ''
    return date

class post_date_check:

    def __init__(self, res):
        self.res = res

    def post_date_checker(self):

        # checking meta tags containing name attribute
        for meta in res.xpath('//meta[@name]'):
            if meta.xpath('@name').extract_first().lower() in ['pubdate', 'publishdate', 'timestamp', 'dc.date.issued', 
                                                               'date', 'sailthru.date', 'article.published', 
                                                               'published-date', 'article.created', 'article_date_original', 
                                                               'cxenseparse:recs:publishtime', 'date_published']:
                date_block = meta.xpath('@content').extract_first().strip()
                break

                    
        # checking meta tags containing property attribute
        if not date_block:
            for meta in res.xpath('//meta[@property]'):
                if meta.xpath('@property').extract_first().lower() in ['article:published_time']:
                    date_block = meta.xpath('@content').extract_first().strip()
                    break


        # checking meta tags containing itemprop attribute			
        if not date_block:
            for meta in res.xpath('//meta[@itemprop]'):
                if meta.xpath('@itemprop').extract_first().lower() in ['datepublished', 'datecreated']:
                    date_block = meta.xpath('@content').extract_first().strip()
                    break


        # checking meta tags containing http-equiv attribute			
        if not date_block:
            for meta in res.xpath('//meta[@http-equiv]'):
                if meta.xpath('@http-equiv').extract_first().lower() in ['date', 'last-modified']:
                    date_block = meta.xpath('@content').extract_first().strip()
                    break		
        
        if not date_block:
            url_path = urlsplit(response.url).path
            url_date = re.search(r'([\./\-_]{0,1}(19|20)\d{2})[\./\-_]{0,1}(([0-3]{0,1}[0-9][\./\-_])|(\w{3,5}[\./\-_]))([0-3]{0,1}[0-9][\./\-]{0,1})?', url_path)
            date_block = ''.join(url_date.group())


        return date_block


def post_comment_count_check(str):
    list_of_digits = [int(s) for s in str.split() if s.isdigit()]
    if not list_of_digits:
        return 0
    else:
        return list_of_digits[0]
