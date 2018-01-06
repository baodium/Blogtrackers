# Post_title_scorer class scores each chunk of text from the html 
# based on the patterns of a post-title
# returns the total score of the chunk

from difflib import SequenceMatcher
from urllib.parse import urlsplit
import re

class post_title_scorer:

    def __init__(self, response, text_node, text, node, node_depth):
        self.response = response
        self.text_node = text_node
        self.text = text
        self.node = node
        self.node_depth = node_depth
    
    def total_score(self):

        # checking if the parent node is h1
        h1_score = 1 if self.node == 'h1' else 0


        # checking if the attributes of parent node contains 'title' or any simillar words
        attributes = ''.join(self.text_node.xpath('@*').extract())
        title_words = ['title', 'headline', 'caption']
        flag = 0
        for title_word in title_words:
            if attributes.find(title_word) != -1:
                flag = 1
        attr_score = 1 if flag == 1 else 0


        # matching simillarity with text between title tags
        title_text = self.response.xpath('//title//text()').extract_first()
        title_score = SequenceMatcher(None, self.text, title_text).ratio()


        # matching simillarity with texts in resource path of url
        path = urlsplit(self.response.url).path
        path_text = re.sub(r'-|/',' ', path)
        path_score = SequenceMatcher(None, self.text, path_text).ratio()


        # checking the depth of node in html tree
        pos_score = 1 - self.node_depth


        # checking if the text ends with full stop(.)
        if self.text:
            punc_score = 0 if self.text[-1] == '.' else 1
        else:
            punc_score = 0


        # checking the character length
        len_score = 1 if len(self.text) <= 200 else 0



        patterns = [h1_score, attr_score, title_score, path_score, pos_score, punc_score, len_score]
        weights = [3, 3, 2, 2, 1, 1, 1]

        # calculating total score of each text
        total_score = 0

        for i in range(len(patterns)):
            total_score += patterns[i] * weights[i]

        return total_score
