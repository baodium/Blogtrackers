class post_author_scorer:

    def __init__(self, text_node, text, node):
        self.text_node = text_node
        self.text = text
        self.node = node
    
    def total_score(self):

        # microformat rel="author" attribute check
        rel_attr = self.text_node.xpath('@rel').extract_first()
        xstr = lambda s: '' if s is None else str(s)
        rel_score = 1 if xstr(rel_attr).lower() == 'author' else 0


        # checking author keywords in attributes
        attributes = ''.join(self.text_node.xpath('@*').extract())
        auth_keywords = ['author', 'byline', 'source', 'courtesy', 'writer', 'written', 
                        'published by', 'published', 'by', 'contributor', 'originator', 
                        'creator', 'builder', 'editor']
        flag = 0
        for auth_keyword in auth_keywords:
            if(attributes.find(auth_keyword) != -1):
                flag = 1
        attr_score = 1 if flag == 1 else 0


        # meta author tag check
        node_score = 1 if (self.node == 'author') else 0


        # anchor tag check
        link_score = 1 if (self.node == 'a') else 0


        # checking the character length
        len_score = 1 if len(self.text) <= 50 else 0

        score_list = [rel_score, attr_score, node_score, link_score, len_score]
        weights = [4,3,3,1,1]

        # calculating total score of each text
        total_score = 0

        for i in range(len(score_list)):
            total_score += score_list[i] * weights[i]

        return total_score