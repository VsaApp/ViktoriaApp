/// All tags of the current user
class Tags {
  // ignore: public_member_api_docs
  Tags({
    this.group,
    this.grade,
    this.selected,
    this.exams,
    this.cafetoriaLogin,
  });

  /// Creates the tags model from json map
  factory Tags.fromJson(Map<String, dynamic> json) {
    if (json.keys.isEmpty) {
      return Tags();
    }
    return Tags(
      grade: json['grade'],
      group: json['group'],
      cafetoriaLogin: CafetoriaTags.fromJson(json['cafetoria']),
      exams: json['exams'].map<Exam>((json) => Exam.fromJson(json)).toList(),
      selected: json['selected']
          .map<SelectionValue>((json) => SelectionValue.fromJson(json))
          .toList(),
    );
  }

  /// The user grade
  final String grade;

  /// The user group (pupil/developer/teacher)
  final int group;

  /// Map of blocks and course ids
  final List<SelectionValue> selected;

  /// Map of subjects and writing option
  final List<Exam> exams;

  /// Cafetoria login data
  final CafetoriaTags cafetoriaLogin;

  /// Checks if the user is already initialized in the server
  bool get isInitialized => grade != null;
}

/// Describes a device
class Device {
  // ignore: public_member_api_docs
  Device(
      {this.os,
      this.name,
      this.appVersion,
      this.deviceSettings,
      this.firebaseId});

  /// Creates a device from json map
  factory Device.fromJson(Map<String, dynamic> json) => Device(
        os: json['os'],
        name: json['name'],
        appVersion: json['appVersion'],
        deviceSettings: DeviceSettings.fromJson(json['settings']),
        firebaseId: json['firebaseId'],
      );

  // ignore: public_member_api_docs
  final String os;
  // ignore: public_member_api_docs
  final String name;
  // ignore: public_member_api_docs
  final String appVersion;
  // ignore: public_member_api_docs
  final DeviceSettings deviceSettings;
  // ignore: public_member_api_docs
  final String firebaseId;

  /// Convert a device to a json map
  Map<String, dynamic> toMap() => {
        'os': os,
        'name': name,
        'appVersion': appVersion,
        'firebaseId': firebaseId,
        'settings': deviceSettings.toMap(),
      };
}

/// Describes all settings to sync for this device
class DeviceSettings {
  // ignore: public_member_api_docs
  const DeviceSettings(
      {this.spNotifications, this.axfNotifications, this.cafNotifications});

  // ignore: public_member_api_docs
  factory DeviceSettings.fromJson(Map<String, dynamic> json) => DeviceSettings(
        spNotifications: json['spNotifications'],
        axfNotifications: json['axfNotifications'],
        cafNotifications: json['cafNotifications'],
      );

  /// Receiving substitution plan notifications
  final bool spNotifications;

  /// Receiving aixformation notifications
  final bool axfNotifications;

  /// Receiving cafetoria notifications
  final bool cafNotifications;

  /// Converts the device settings to a json map
  Map<String, dynamic> toMap() => {
        'spNotifications': spNotifications,
        'axfNotifications': axfNotifications,
        'cafNotifications': cafNotifications,
      };
}

/// Describes the cafetoria tags
class CafetoriaTags {
  // ignore: public_member_api_docs
  CafetoriaTags({this.id, this.password, this.timestamp});

  /// Creates cafetoria tags from json map
  factory CafetoriaTags.fromJson(Map<String, dynamic> json) => CafetoriaTags(
      id: json['id'],
      password: json['password'],
      timestamp: DateTime.parse(json['timestamp']));

  // ignore: public_member_api_docs
  final String id;
  // ignore: public_member_api_docs
  final String password;

  /// Last updated timestamp
  final DateTime timestamp;

  /// Converts cafetoria tags to json map
  Map<String, dynamic> toMap() => {
        'id': id,
        'password': password,
        'timestamp': timestamp.toIso8601String()
      };
}

/// Describes a user selection
class SelectionValue {
  // ignore: public_member_api_docs
  const SelectionValue({this.block, this.courseID, this.timestamp});

  // ignore: public_member_api_docs
  factory SelectionValue.fromJson(Map<String, dynamic> json) => SelectionValue(
        block: json['block'],
        courseID: json['courseID'],
        timestamp: DateTime.parse(json['timestamp']),
      );

  /// The block identifier
  final String block;

  /// The course identifier
  final String courseID;

  /// The last changed timestamp
  final DateTime timestamp;

  /// Converts the device settings to a json map
  Map<String, dynamic> toMap() => {
        'block': block,
        'courseID': courseID,
        'timestamp': timestamp.toIso8601String(),
      };
}

/// Describes all settings to sync for this device
class Exam {
  // ignore: public_member_api_docs
  const Exam({this.subject, this.writing, this.timestamp});

  // ignore: public_member_api_docs
  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        subject: json['subject'],
        writing: json['writing'],
        timestamp: DateTime.parse(json['timestamp']),
      );

  /// The subject identifier
  final String subject;

  /// The writing option
  final bool writing;

  /// The last changed timestamp
  final DateTime timestamp;

  /// Converts the device settings to a json map
  Map<String, dynamic> toMap() => {
        'subject': subject,
        'writing': writing,
        'timestamp': timestamp.toIso8601String(),
      };
}
