class Article:
    def __init__(self, pictUrl, path, title, date):
        self.pictUrl = pictUrl
        self.path = path
        self.title = title
        self.date = date
        self.content = ""

    def __repr__(self):
        return "pictUrl: {} \n path: {} \n title: {} \n date: {} \n article: {} \n".format(self.pictUrl, self.path, self.title, self.date, self.content)
    