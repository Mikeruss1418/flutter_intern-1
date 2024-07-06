class ExpModel {
  String? job;
  String? company;
  String? summary;
  String? sedate;
  String? eedate;

  ExpModel({this.job, this.company, this.summary, this.sedate, this.eedate});

  ExpModel.fromJson(Map<String, dynamic> json) {
    job = json['job'];
    company = json['company'];
    summary = json['summary'];
    sedate = json['sedate'] ;
    eedate = json['eedate'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['job'] = job;
    data['company'] = company;
    data['summary'] = summary;
    data['sedate'] = sedate;
    data['eedate'] = eedate;
    return data;
  }

  void dispose() {}
}



