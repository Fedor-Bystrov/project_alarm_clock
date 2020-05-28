class Alarm {
  int id;
  DateTime time;
  String repeat;
  String label;
  bool enabled;

  Alarm(this.time, this.repeat, this.label, this.enabled);

  Alarm.copy(Alarm alarm) {
    this.id = alarm.id;
    this.time = alarm.time;
    this.repeat = alarm.repeat;
    this.label = alarm.label;
    this.enabled = alarm.enabled;
  }

  Alarm.fromJson(Map<String, dynamic> json)
      : time = DateTime.parse(json['time']),
        repeat = json['repeat'],
        label = json['label'],
        enabled = json['enabled'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'time': time.toIso8601String(),
        'repeat': repeat,
        'label': label,
        'enabled': enabled,
        'id': id,
      };

  @override
  String toString() {
    return 'Alarm{id: $id, time: $time, repeat: $repeat, label: $label, enabled: $enabled}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Alarm &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          repeat == other.repeat &&
          label == other.label &&
          enabled == other.enabled;

  @override
  int get hashCode =>
      id.hashCode ^ time.hashCode ^ repeat.hashCode ^ label.hashCode ^ enabled.hashCode;
}
