import 'dart:convert';

BlockchainExplorerResponse blockchainExplorerResponseFromJson(String str) =>
    BlockchainExplorerResponse.fromJson(json.decode(str));

String blockchainExplorerResponseToJson(BlockchainExplorerResponse result) =>
    json.encode(result.toJson());

class BlockchainExplorerResponse {
  BlockchainExplorerResponse(
      {required this.result, required this.status, required this.message});

  final List<BlockchainExplorer> result;
  final String status;
  final dynamic message;

  factory BlockchainExplorerResponse.fromJson(Map<String, dynamic> json) =>
      BlockchainExplorerResponse(
          result: List<BlockchainExplorer>.from(
              json["result"].map((x) => BlockchainExplorer.fromJson(x))),
          status: json["status"],
          message: json["message"]);

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "status": status,
        "message": message
      };
}

class BlockchainExplorer {
  BlockchainExplorer(
      {required this.from,
      required this.to,
      required this.value,
      required this.gasUsed,
      required this.hash,
      required this.input,
      required this.timeStamp,
      required this.gasPrice});

  final String from;
  final String to;
  final String value;
  final String gasUsed;
  final String hash;
  final String input;
  final String timeStamp;
  final String gasPrice;

  factory BlockchainExplorer.fromJson(Map<String, dynamic> json) =>
      BlockchainExplorer(
          from: json["from"],
          to: json["to"],
          value: json["value"],
          gasUsed: json["gasUsed"],
          hash: json["hash"],
          input: json["input"],
          timeStamp: json["timeStamp"],
          gasPrice: json["gasPrice"]);

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "value": value,
        "gasUsed": gasUsed,
        "hash": hash,
        "input": input,
        "timeStamp": timeStamp,
        "gasPrice": gasPrice
      };
}
