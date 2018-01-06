# Post_date_scorer class scores each chunk of text from the html 
# based on the patterns of a post-date
# returns the total score of the chunk
# import datefinder

class post_date_scorer:

    def __init__(self, text_node, text, node, node_depth):
        self.text_node = text_node
        self.text = text
        self.node = node
        self.node_depth = node_depth

    def total_score(self):

        # def dateExists(str):
        #     matches = datefinder.find_dates(str)
        #     matchList = [match for match in matches]
        #     if not matchList:
        #         return False
        #     else:
        #         return True
        
        # date_entity_score = 1 if dateExists(self.text) else 0

        # checking if text lies between time tags
        time_tag_score = 1 if self.node == 'time' else 0
        # texts[count] = text_node.xpath('@datetime').extract_first()


        # checking date keywords in attributes
        attributes = ''.join(self.text_node.xpath('@*').extract()).lower()
        time_keywords = ['date', 'time', 'datetime', 'timestamp', 'published', 'create', 'pageissuedate', 'clock']
        attr_score = 0
        for time_keyword in time_keywords:
            if(attributes.find(time_keyword) != -1):
                attr_score += 1
                # texts[count] = text_node.xpath('@title|content').extract_first()


        # matching simillarity with date format in resource path of url
        # path = urlsplit(response.url).path
        # d = re.search(r'([\./\-_]{0,1}(19|20)\d{2})[\./\-_]{0,1}(([0-3]{0,1}[0-9][\./\-_])|(\w{3,5}[\./\-_]))([0-3]{0,1}[0-9][\./\-]{0,1})?', path)
        # dd = ''.join(d.group())
        # url_date = re.sub(r'-|/',' ', dd)
        # url_score = SequenceMatcher(None, text, url_date).ratio()


        # checking the depth of node in html tree
        depth_score = 1 - self.node_depth


        # checking the character length
        length_score = 1 if len(self.text) <= 50 else 0

        patterns = [time_tag_score, attr_score, depth_score, length_score]
        weights = [2, 2, 1, 1]

        # calculating total score of each text
        total_score = 0

        for i in range(len(patterns)):
            total_score += patterns[i] * weights[i]

        return total_score
