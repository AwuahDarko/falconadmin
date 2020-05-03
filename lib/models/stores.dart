class Store {
  int storeId;
  String name;
  String street;
  String status;
  String email;
  int customerId;
  String direct1;
  String direct2;
  String cell;
  String mobile;
  String land;
  String area;
  String city;
  String country;
  String zamraNo;
  String hpczNo;
  String certIncImage;
  String zamraCertImage;
  String hpczFullImage;
  String hpczAnnualImage;
  String fullName;
  String logo;
  bool state = false;

  Store(
      {this.status,
      this.logo,
      this.cell,
      this.storeId,
      this.email,
      this.street,
      this.country,
      this.city,
      this.area,
      this.name,
      this.certIncImage,
      this.customerId,
      this.direct1,
      this.direct2,
      this.fullName,
      this.hpczAnnualImage,
      this.hpczFullImage,
      this.hpczNo,
      this.land,
      this.mobile,
      this.zamraCertImage,
      this.zamraNo});
}

/*
        "country": "Ghana",
        "zamra_licence_number": "ADDFFS22545636685",
        "hpcz_certificate_number": "5585KHYF25866",
        "cert_of_incoporation": "",
        "zamra_certificate": "",
        "hpcz_full_reg": "",
        "hpcz_annual": "",
        "first_name": "Farok",
        "last_name": "Lola",
        "phone": "+223545265498",
        "image_url": "uploads/images/store-logo/upload_a0d1ac75e10b073bcfdd45a5df8abd62",
        "username": "Lenz Pharmacy",
        "location": null
 */
