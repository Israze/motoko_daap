actor {
  stable var funds: TrieMap<Text, Nat> = TrieMap.empty();

  public shared(msg) func createFund() : async Text {
    let fundId = "fund_" # Int.toText(TrieMap.size(funds));
    funds.put(fundId, 0);
    return fundId;
  };

  public shared(msg) func invest(fundId: Text, amount: Nat) : async Bool {
    switch (funds.get(fundId)) {
      case (?balance) {
        funds.put(fundId, balance + amount);
        return true;
      };
      case null { return false; }
    }
  };

  public shared(msg) func getBalance(fundId: Text) : async Nat {
    switch (funds.get(fundId)) {
      case (?balance) { return balance; };
      case null { return 0; }
    }
  };
}
