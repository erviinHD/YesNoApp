enum FromWho { me, hers }

class Message {
  final String text;
  final String? imageUrl;
  final FromWho fromWho;
  final now = DateTime.now();

  Message({required this.text, this.imageUrl, required this.fromWho});
}
