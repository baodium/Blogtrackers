# Post_date_scorer class scores each chunk of text from the html 
# based on the patterns of post comments content
# returns the total score of the chunk

class post_cmnt_cnt_scorer:

    def __init__(self, text_node, text):
        self.text_node = text_node
        self.text = text

    def total_score(self):

        #checking if the attributes of parent node contains 'title' or any simillar words
        attributes = ''.join(self.text_node.xpath('@*').extract())
        comment_count_words = ['comment', 'comments', 'count', 'number', 'comment_count',
                               'comment-count', 'number_of_comments', 'number-of-comments',
                               'discussion', 'remark', 'remarks']
        flag = 0
        for comment_count_word in comment_count_words:
            if(attributes.find(comment_count_word) != -1):
                flag = 1
        attr_score = 1 if flag == 1 else 0

        # checking the character length
        len_score = 1 if len(self.text) <= 15 else 0



        patterns = [attr_score, len_score]
        weights = [3, 1]

        # calculating total score of each text
        total_score = 0

        for i in range(len(patterns)):
            total_score += patterns[i] * weights[i]

        return total_score


