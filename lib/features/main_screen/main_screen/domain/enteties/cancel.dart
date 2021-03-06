class CancelModel {
  String? workoutId;
  String? workoutSportType;
  String? date;
  String? time;
  String? instructorName;
  String? instructorFcmToken;
  String? instructorPhoneNumber;
  String? status;
  static CancelModel fromJson(String id, cancelModelApi) {
    CancelModel cancelModel = CancelModel();
    cancelModel.workoutId = cancelModelApi['workout_id'];
    cancelModel.workoutSportType = cancelModelApi['workout_sportType'];
    cancelModel.date = cancelModelApi['date'];
    cancelModel.time = cancelModelApi['time'];
    cancelModel.instructorName = cancelModelApi['instructor_name'];
    cancelModel.instructorFcmToken = cancelModelApi['instructor_fcm_token'];
    cancelModel.instructorPhoneNumber = cancelModelApi['instructor_phone'];
    cancelModel.status=cancelModelApi['status'];
    return cancelModel;
  }
}
