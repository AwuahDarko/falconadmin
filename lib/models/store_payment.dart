class StorePayment {
  String storeName;
  String street;
  String email;
  String logo;
  String cell;
  String payment;
  int storeId;
  double amount;
  int earningId;
  String date;
  bool state;

  StorePayment(
      {this.payment,
      this.street,
      this.email,
      this.storeId,
      this.cell,
      this.logo,
      this.storeName,
      this.amount,
      this.earningId,
      this.date}) {
    if (this.payment == 'paid') {
      this.state = true;
    } else {
      this.state = false;
    }
  }
}

/*
* "earning_id": 2,
        "transaction_id": 4,
        "amount": 12.6,
        "created_at": "2020-05-27T22:08:01.000Z",
        "store_id": 7,
        "payment": "pending",
        "name": "Warner bros. inc",
        "street_name": "17th Lanez Avenue close",
        "email": "warner@gmail.com",
        "image_url": "uploads/images/store-logo/upload_443c04960af1fc366bf86ca6776202ba",
        "status": "approved",
        "customer_id": 10,
        "director_name1": "Lee Son Yin",
        "cell_number": "0243501473",
        "mobile_number": "",
        "landline": "",
        "area": "My area",
        "city": "my city"*/
