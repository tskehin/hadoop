from mrjob.job import MRJob
from mrjob.protocol import JSONValueProtocol
from mr3px.csvprotocol import CsvProtocol
import re 

WORD_RE = re.compile("[\w']+")

class calculateScore(MRJob):

	INPUT_PROTOCOL = JSONValueProtocol
	#INPUT_PROTOCOL.delimiter = "\u0001"

	def mapper(self, _, json):
		
		for word in WORD_RE.findall(json["Body"]):
			yield (json["OwnerUserId"], json["Id"], word), 1
			
if __name__ == '__main__':
	calculateScore.run()