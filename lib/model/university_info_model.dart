class University_info_model {
  String? stateProvince;
  List<String>? domains;
  String? name;
  String? country;
  List<String>? webPages;
  String? alphaTwoCode;

  University_info_model(
      {this.stateProvince,
        this.domains,
        this.name,
        this.country,
        this.webPages,
        this.alphaTwoCode});

 factory University_info_model.fromJson(Map<String, dynamic> json) {
  return University_info_model(
    stateProvince : json['state-province']??'',
    domains : json['domains'].cast<String>(),
    name : json['name'],
    country : json['country'],
    webPages : json['web_pages'].cast<String>(),
    alphaTwoCode : json['alpha_two_code'],
   );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state-province'] = this.stateProvince;
    data['domains'] = this.domains;
    data['name'] = this.name;
    data['country'] = this.country;
    data['web_pages'] = this.webPages;
    data['alpha_two_code'] = this.alphaTwoCode;
    return data;
  }
}