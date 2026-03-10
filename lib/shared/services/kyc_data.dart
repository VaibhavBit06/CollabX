import 'package:flutter/foundation.dart';

class KycSubmission {
  final String creatorName;
  final String handle;
  final String documentType; // 'Aadhaar Card' or 'PAN Card'
  final DateTime uploadDate;
  String status; // 'Pending', 'Approved', 'Rejected'

  KycSubmission({
    required this.creatorName,
    required this.handle,
    required this.documentType,
    required this.uploadDate,
    this.status = 'Pending',
  });
}

class KycData extends ChangeNotifier {
  // Singleton pattern
  KycData._privateConstructor();
  static final KycData instance = KycData._privateConstructor();

  // In-memory list of all KYC submissions
  final List<KycSubmission> _submissions = [];

  // Getter to get all submissions, ordered by most recent first
  List<KycSubmission> get submissions {
    final list = List<KycSubmission>.from(_submissions);
    list.sort((a, b) => b.uploadDate.compareTo(a.uploadDate));
    return list;
  }

  // Get only pending submissions (for the Admin queue)
  List<KycSubmission> get pendingSubmissions => 
      submissions.where((s) => s.status == 'Pending').toList();

  // For a creator to check their specific document status
  // Returns 'Not Submitted', 'Pending', 'Approved', or 'Rejected'
  String getDocumentStatus(String creatorName, String documentType) {
    try {
      final submission = _submissions.firstWhere(
        (s) => s.creatorName == creatorName && s.documentType == documentType,
      );
      return submission.status;
    } catch (e) {
      return 'Not Submitted';
    }
  }

  // Called when a creator uploads a document
  void submitKyc(String creatorName, String handle, String documentType) {
    // Check if one already exists
    try {
      final existing = _submissions.firstWhere(
        (s) => s.creatorName == creatorName && s.documentType == documentType,
      );
      // Update existing
      existing.status = 'Pending';
    } catch (e) {
      // Add new
      _submissions.add(
        KycSubmission(
          creatorName: creatorName,
          handle: handle,
          documentType: documentType,
          uploadDate: DateTime.now(),
        ),
      );
    }
    notifyListeners();
  }

  // Called by Admin to approve
  void approveKyc(String creatorName, String documentType) {
    try {
      final submission = _submissions.firstWhere(
        (s) => s.creatorName == creatorName && s.documentType == documentType,
      );
      submission.status = 'Approved';
      notifyListeners();
    } catch (e) {
      debugPrint("Could not find submission to approve");
    }
  }

  // Called by Admin to reject
  void rejectKyc(String creatorName, String documentType) {
    try {
      final submission = _submissions.firstWhere(
        (s) => s.creatorName == creatorName && s.documentType == documentType,
      );
      submission.status = 'Rejected';
      notifyListeners();
    } catch (e) {
      debugPrint("Could not find submission to reject");
    }
  }
}
