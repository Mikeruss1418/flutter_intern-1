class OthersModel {
  String? project;
  String? descrip;
  String? organization;
  String? sdate;
  String? edate;
  String? association;

  OthersModel(
      {this.project,
      this.descrip,
      this.organization,
      this.sdate,
      this.edate,
      this.association, required Null Function(dynamic othersModel) onSubmit});

  OthersModel.fromJson(Map<String, dynamic> json) {
    project = json['project'];
    descrip = json['descrip'];
    organization = json['organization'];
    sdate = json['sdate'];
    edate = json['edate'];
    association = json['association'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['project'] = project;
    data['descrip'] = descrip;
    data['organization'] = organization;
    data['sdate'] = sdate;
    data['edate'] = edate;
    data['association'] = association;
    return data;
  }
}
