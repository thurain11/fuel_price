import 'package:lucide_icons/lucide_icons.dart';
import 'package:market_price/pages/fuel_price/fuel_prices_page.dart';
import 'package:market_price/pages/setting/setting_page.dart';

import '../../global.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Market Prices',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: theme.iconTheme.color),
            onPressed: () {
              context.to(SettingPage());
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildPriceCard(
            type: 1,
            context,
            icon: LucideIcons.fuel,
            iconColor: Colors.blueAccent,
            title: 'Petrol Price',
            subText: '+0.02% today',
            price: '\$1.45',
            unit: '/ liter',
            change: '+0.003',
            changeColor: Colors.green,
          ),
          _buildPriceCard(
            type: 2,
            context,
            icon: LucideIcons.truck,
            iconColor: Colors.orangeAccent,
            title: 'Petrol Price (Wholesale)',
            subText: '+0.15% today',
            price: '\$150.20',
            unit: '/ barrel',
            change: '+0.22',
            changeColor: Colors.green,
          ),
          _buildPriceCard(
            type: 3,
            context,
            icon: LucideIcons.gauge,
            iconColor: Colors.blueGrey,
            title: 'MOPS Price',
            subText: '+0.11% today',
            price: '\$148.75',
            unit: '',
            change: '+0.16',
            changeColor: Colors.green,
          ),
          _buildPriceCard(
            type: 4,
            context,
            icon: LucideIcons.coins,
            iconColor: Colors.amber,
            title: 'Gold Price',
            subText: '-0.002% today',
            price: '\$2,350.50',
            unit: '/ ounce',
            change: '-0.05',
            changeColor: Colors.redAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subText,
    required String price,
    required String unit,
    required String change,
    required Color changeColor,
    required int type,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: const Offset(0, 3),
                  blurRadius: 6,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
      ),
      child: ListTile(
        onTap: () {
          if (type == 1) {
            context.to(FuelPricesPage());
          }
        },
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(isDark ? 0.25 : 0.15),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          subText,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$price $unit',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              change,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: changeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
