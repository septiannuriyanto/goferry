class Ekspedisi {
  String? urutan;
  String? periode;
  String? tanggal;
  String? namaEkspedisi;
  String? nopol;
  String? jenisEkspedisi;
  String? muatan;
  String? manifest;
  String? driverName;
  String? asal;
  String? inputter;
  String? remark;

  Ekspedisi({
    this.urutan,
    this.periode,
    this.tanggal,
    this.namaEkspedisi,
    this.nopol,
    this.jenisEkspedisi,
    this.muatan,
    this.manifest,
    this.driverName,
    this.asal,
    this.inputter,
    this.remark,
  });

  Ekspedisi.fromJsonData(List<dynamic> jsonData) {
    urutan = jsonData[0];
    periode = jsonData[1];
    tanggal = jsonData[2];
    namaEkspedisi = jsonData[3];
    nopol = jsonData[4];
    jenisEkspedisi = jsonData[5];
    muatan = jsonData[6];
    manifest = jsonData[7];
    driverName = jsonData[8];
    asal = jsonData[9];
    inputter = jsonData[10];
    remark = jsonData[11];
  }
}
