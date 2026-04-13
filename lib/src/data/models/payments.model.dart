class BranchPayment{
  final String id;
  final String branchId;
  final String branchName;
  final double amount;
  final String? note;
  final String title;
  final DateTime createdAt;
  final String createdBy;

  BranchPayment({
    required this.id,
    required this.title,
    this.note,
    required this.branchId,
    required this.branchName,
    required this.amount,
    required this.createdAt,
    required this.createdBy,  
  });


  
}