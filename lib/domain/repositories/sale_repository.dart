import 'package:hesabuapp/domain/entities/sale.dart';
import 'package:hesabuapp/domain/entities/sale_item.dart';
import 'package:hesabuapp/domain/enums/payment_method_enum.dart';
import 'package:hesabuapp/domain/enums/payment_status_enum.dart';

abstract class SaleRepository {
  Future<List<Sale>> getSales({
    int page = 1,
    int limit = 10,
  });
  
  Future<Sale> getSale(String saleId);
  
  Future<List<SaleItem>> getSaleItems(String saleId);
  
  Future<Sale> createSale({
    PaymentMethodEnum? paymentMethod,
    PaymentStatusEnum? paymentStatus,
    required double totalAmount,
    String? description,
    String? createdBy,
  });
  
  Future<SaleItem> addSaleItem({
    required String saleId,
    required String productId,
    required int quantity,
    required double unitPrice,
  });
  
  Future<SaleItem> updateSaleItem({
    required String itemId,
    required int quantity,
    required double unitPrice,
  });
  
  Future<void> deleteSaleItem(String itemId);
  
  Future<Sale> updateSale({
    required String saleId,
    PaymentMethodEnum? paymentMethod,
    PaymentStatusEnum? paymentStatus,
    double? totalAmount,
    String? description,
  });
  
  Future<void> deleteSale(String saleId);
}