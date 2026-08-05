import '../models/location_models.dart';

/// Demo fixture matching the backend schema (SDD §4) — used for the "Try a
/// demo" button on the search screen and for widget development/tests when
/// no backend is reachable.
const LocationSearchCandidate mockCandidate = LocationSearchCandidate(
  locationId: '11.940_108.458',
  name: 'Da Lat',
  formattedAddress: 'Da Lat, Lam Dong, Vietnam',
  lat: 11.9404,
  lng: 108.4583,
  countryCode: 'VN',
  country: 'Vietnam',
);

LocationResponse buildMockLocationResponse() {
  final now = DateTime.now().toUtc();

  ChildItem item({
    required String id,
    required String label,
    required String source,
    required String summary,
    String detail = '',
    List<String> sources = const [],
    String? warning,
  }) =>
      ChildItem(
        id: id,
        label: label,
        source: source,
        summary: summary,
        detail: detail,
        sources: sources,
        updatedAt: now,
        warning: warning,
      );

  return LocationResponse(
    location: LocationInfo(
      id: mockCandidate.locationId,
      name: mockCandidate.name,
      lat: mockCandidate.lat,
      lng: mockCandidate.lng,
      countryCode: mockCandidate.countryCode,
      country: mockCandidate.country,
    ),
    cachedAt: now,
    groups: [
      Group(id: 'explore', label: 'Explore', children: [
        item(
          id: 'places',
          label: 'Nearby places',
          source: 'api',
          summary: '12 places nearby',
          detail: '- Xuan Huong Lake (4.6★)\n- Dalat Flower Gardens (4.5★)\n- Datanla Waterfall (4.3★)',
        ),
        item(
          id: 'food',
          label: 'Local food',
          source: 'llm',
          summary: 'Known for strawberries, artichoke tea, and bánh tráng nướng.',
          detail: 'Da Lat\'s cool climate makes it famous for fresh produce — strawberries, avocados, and artichokes. Try bánh tráng nướng (Vietnamese "pizza") from street stalls, and sữa đậu nành (soy milk) on a cold evening.',
          sources: ['https://example.com/dalat-food'],
        ),
        item(
          id: 'best_time',
          label: 'Best time to visit',
          source: 'llm',
          summary: 'December–March: dry, cool, and sunny.',
          detail: 'The dry season from December to March offers the most comfortable weather. The rainy season (June–September) brings afternoon showers but lush scenery.',
          sources: ['https://example.com/dalat-weather'],
        ),
      ]),
      Group(id: 'practical', label: 'Practical', children: [
        item(id: 'weather', label: 'Weather', source: 'api', summary: '18°C, light fog', detail: 'Feels like 17°C, humidity 85%, wind 2 m/s'),
        item(
          id: 'transport',
          label: 'Getting around',
          source: 'llm',
          summary: 'Motorbike rental or Grab are most convenient.',
          detail: 'Da Lat is hilly, so walking long distances is tiring. Motorbike rentals (~150,000 VND/day) or the Grab app are the most practical options for tourists.',
          sources: ['https://example.com/dalat-transport'],
        ),
        item(
          id: 'power',
          label: 'Power & SIM',
          source: 'llm',
          summary: '220V, type A/C/G sockets. eSIM widely supported.',
          detail: 'Vietnam uses 220V with type A, C, and G sockets. Prepaid tourist SIMs and eSIMs (Viettel, Mobifone) are available at the airport.',
        ),
        item(id: 'currency', label: 'Currency & payments', source: 'llm', summary: 'Vietnamese Dong (VND). Cash preferred outside cities.', detail: 'Cards are accepted at hotels and larger restaurants, but small vendors and markets are cash-only. ATMs are widely available.'),
        item(id: 'timezone', label: 'Timezone', source: 'static', summary: 'Asia/Ho_Chi_Minh (UTC+07:00)', detail: 'Local time now reflects UTC+7 year-round (no daylight saving).'),
      ]),
      Group(id: 'safety', label: 'Safety & Health', children: [
        item(id: 'safety_level', label: 'Safety', source: 'llm', summary: 'Generally safe; watch for petty theft in tourist areas.', detail: 'Da Lat is considered one of the safer cities in Vietnam for tourists. Standard precautions against pickpocketing in crowded markets are recommended.'),
        item(id: 'health', label: 'Healthcare', source: 'llm', summary: 'Lam Dong General Hospital is the main facility.', detail: 'Lam Dong General Hospital provides emergency care. For serious issues, many travelers head to Ho Chi Minh City.'),
        item(id: 'water', label: 'Drinking water', source: 'llm', summary: 'Tap water is not recommended for drinking.', detail: 'Stick to bottled or filtered water, widely available and inexpensive.'),
        item(
          id: 'insurance',
          label: 'Travel insurance',
          source: 'llm',
          summary: 'Recommended for all visitors.',
          detail: 'Travel insurance covering medical evacuation is recommended, especially for outdoor activities like canyoning near Datanla Waterfall.',
          warning: 'Coverage requirements vary by nationality and visa type — verify with your insurer and destination\'s official sources.',
        ),
        item(id: 'emergency', label: 'Emergency numbers', source: 'static', summary: 'General emergency: 112', detail: 'Police: 113 · Ambulance: 115 · Fire: 114'),
      ]),
      Group(id: 'culture', label: 'Culture', children: [
        item(id: 'language', label: 'Language', source: 'llm', summary: 'Vietnamese. English spoken in tourist areas.', detail: 'Vietnamese is the official language. Hotel staff and tour guides generally speak conversational English.'),
        item(id: 'etiquette', label: 'Etiquette', source: 'llm', summary: 'Dress modestly at religious sites; remove shoes indoors.', detail: 'Remove shoes when entering homes and some guesthouses. Dress modestly when visiting pagodas.'),
        item(id: 'tipping', label: 'Tipping culture', source: 'llm', summary: 'Not mandatory, but appreciated for good service.', detail: 'Tipping isn\'t customary but rounding up or a small tip (5-10%) at restaurants and for tour guides is appreciated.'),
        item(id: 'holidays', label: 'Local holidays', source: 'llm', summary: 'Tết (Lunar New Year) is the biggest holiday.', detail: 'Tết typically falls in late January or February; many businesses close for several days.'),
      ]),
      Group(id: 'entry_stay', label: 'Entry & Stay', children: [
        item(
          id: 'visa',
          label: 'Visa',
          source: 'llm',
          summary: 'Many nationalities get visa-free entry for short stays.',
          detail: 'Vietnam offers visa exemptions or e-visas for many nationalities. Requirements change — check the official immigration portal before booking.',
          warning: 'Visa rules change often and vary by nationality — verify with the destination\'s official immigration/embassy website before travel.',
        ),
        item(id: 'airport', label: 'Nearest airport', source: 'api', summary: 'Lien Khuong Airport (DLI)', detail: '~30km south of Da Lat city center'),
        item(id: 'stay', label: 'Where to stay', source: 'llm', summary: 'Near Xuan Huong Lake for walkability.', detail: 'The area around Xuan Huong Lake and the central market puts most attractions within walking distance.'),
        item(id: 'cost', label: 'Cost of living', source: 'llm', summary: 'Budget: \$20-30/day. Mid-range: \$50-80/day.', detail: 'Da Lat is affordable by international standards. Street food meals cost \$1-3; a mid-range hotel room runs \$25-50/night.'),
      ]),
    ],
  );
}
