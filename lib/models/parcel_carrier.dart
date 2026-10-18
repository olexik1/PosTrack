enum ParcelCarrier {
  novaPoshta("Нова пошта", "НП"),
  ukrPoshta("Укрпошта", "УП");

  final String label;
  final String abbreviation;

  const ParcelCarrier(this.label, this.abbreviation);
}