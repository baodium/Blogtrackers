class post_category_scorer:

    def __init__(self, text_node, text, node):
        self.text_node = text_node
        self.text = text
        self.node = node
    
    def total_score(self):

        # microformat rel="author" attribute check
        rel_attr = self.text_node.xpath('@rel').extract_first()
        xstr = lambda s: '' if s is None else str(s)
        rel_score = 1 if xstr(rel_attr).lower() in ['category','categories'] else 0


        # checking author keywords in attributes
        attributes = ''.join(self.text_node.xpath('@*').extract())
        category_keywords = ['category', 'categories']
        flag = 0
        for category_keyword in category_keywords:
            if(attributes.find(category_keyword) != -1):
                flag = 1
        attr_score = 1 if flag == 1 else 0


        # anchor category check
        link_score = 1 if (self.node == 'a') else 0


        # checking the character length
        len_score = 1 if len(self.text) <= 75 else 0


        score_list = [rel_score, attr_score, link_score, len_score]
        weights = [2,2,1,1]

        # calculating total score of each text
        total_score = 0

        for i in range(len(score_list)):
            total_score += score_list[i] * weights[i]

        return total_score