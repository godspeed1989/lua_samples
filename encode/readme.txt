一般压缩可以将文本先使用Burrows–Wheeler transform生成局部相关性很好的序列，再使用MTF减少信息熵，最后再进行压缩。

bzip2使用Burrows-Wheeler transform将重复出现的字符序列转换成同样字母的字符串，然后用move-to-front transform进行处理，最后使用哈夫曼编码进行压縮。
