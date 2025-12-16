class BuyBoosterRequest {
  final String type;

  BuyBoosterRequest({required this.type});

  Map<String, dynamic> toJson() => {
        'type': type,
      };
}
