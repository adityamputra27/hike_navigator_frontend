class Destination {
  static final List<Destination> samples = [
    Destination(
      name: 'Aspen, United States',
      duration: '1 stop · 6h 15m',
    ),
    Destination(
      name: 'Big Sur, United States',
      duration: 'Nonstop · 13h 30m',
    ),
    Destination(
      name: 'Khumbu Valley, Nepal',
      duration: 'Nonstop · 5h 16m',
    ),
    Destination(
      name: 'Machu Picchu, Peru',
      duration: '2 stops · 19h 40m',
    ),
    Destination(
      name: 'Malé, Maldives',
      duration: 'Nonstop · 8h 24m',
    ),
    Destination(
      name: 'Vitznau, Switzerland',
      duration: '1 stop · 14h 12m',
    ),
    Destination(
      name: 'Mexico City, Mexico',
      duration: 'Nonstop · 5h 24m',
    ),
    Destination(
      name: 'Mount Rushmore, United States',
      duration: '1 stop · 5h 43m',
    ),
    Destination(
      name: 'Singapore',
      duration: 'Nonstop · 8h 25m',
    ),
    Destination(
      name: 'Havana, Cuba',
      duration: '1 stop · 15h 52m',
    ),
    Destination(
      name: 'Cairo, Egypt',
      duration: 'Nonstop · 5h 57m',
    ),
    Destination(
      name: 'Lisbon, Portugal',
      duration: '1 stop · 13h 24m',
    ),
  ];

  final String name;

  final String duration;


  Destination({
    required this.name,
    required this.duration,
  });
}