import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/course.dart';
import '../theme/app_theme.dart';

class PaymentScreen extends StatefulWidget {
  final Course course;

  const PaymentScreen({super.key, required this.course});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _method = 0; // 0: card, 1: paypal, 2: apple pay
  final _cardNumber = TextEditingController();
  final _expiry = TextEditingController();
  final _cvv = TextEditingController();
  final _name = TextEditingController();
  bool _processing = false;

  // Example: fake tax
  double get _tax => widget.course.price * 0.08;
  double get _total => widget.course.price + _tax;

  Future<void> _pay() async {
    // TODO: Backend integration — call your payment API here
    // 1. Create payment intent / order
    // 2. Send card token to backend
    // 3. On success, enroll user in the course
    setState(() => _processing = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _processing = false);

    _showSuccess();
  }

  void _showSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded,
                  color: Colors.green, size: 42),
            ),
            const SizedBox(height: 16),
            const Text(
              'Payment Successful!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'You are now enrolled in\n"${widget.course.title}".',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textGrey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // back to detail
              },
              child: const Text('Start Learning'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cardNumber.dispose();
    _expiry.dispose();
    _cvv.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _courseSummary(),
            const SizedBox(height: 24),
            const Text('Payment Method',
                style:
                TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            _methodTile(0, 'Credit / Debit Card', Icons.credit_card_rounded),
            _methodTile(1, 'PayPal', Icons.account_balance_wallet_rounded),
            _methodTile(2, 'Apple Pay', Icons.apple_rounded),
            const SizedBox(height: 20),
            if (_method == 0) _cardForm(),
            const SizedBox(height: 24),
            _priceSummary(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _processing ? null : _pay,
              child: _processing
                  ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                    strokeWidth: 2.4, color: Colors.white),
              )
                  : Text('Pay \$${_total.toStringAsFixed(2)}'),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                '🔒 Secure checkout — 30-day money-back guarantee',
                style: TextStyle(fontSize: 11, color: AppColors.textGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _courseSummary() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: widget.course.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => Container(
                  width: 80, height: 80, color: Colors.grey.shade300),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.course.category.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.course.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'By ${widget.course.instructor}',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _methodTile(int index, String label, IconData icon) {
    final selected = _method == index;
    return GestureDetector(
      onTap: () => setState(() => _method = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.grey.shade300,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                color:
                selected ? AppColors.primary : AppColors.textGrey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: selected ? AppColors.primary : AppColors.textDark,
                ),
              ),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected ? AppColors.primary : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardForm() {
    return Column(
      children: [
        TextField(
          controller: _name,
          decoration: const InputDecoration(
            hintText: 'Cardholder name',
            prefixIcon: Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _cardNumber,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: '1234 5678 9012 3456',
            prefixIcon: Icon(Icons.credit_card),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _expiry,
                decoration: const InputDecoration(hintText: 'MM / YY'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _cvv,
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'CVV'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _priceSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _row('Course price',
              '\$${widget.course.price.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _row('Tax', '\$${_tax.toStringAsFixed(2)}'),
          const Divider(height: 24),
          _row('Total', '\$${_total.toStringAsFixed(2)}', bold: true),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
            color: bold ? AppColors.textDark : AppColors.textGrey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
            fontSize: bold ? 16 : 14,
            color: bold ? AppColors.primary : AppColors.textDark,
          ),
        ),
      ],
    );
  }
}