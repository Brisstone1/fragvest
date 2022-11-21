class MessangerModel {
  final int id;
  final String name;
  MessangerModel({this.id, this.name});
}

class DummyMessageModel {
  final MessangerModel sender;
  final String time;
  final String description;
  final String ticket;
  final String status;

  DummyMessageModel(
      {this.sender, this.time, this.description, this.ticket, this.status});
}

final MessangerModel currentUser = MessangerModel(
  id: 0,
  name: 'Current User',
);

final MessangerModel james = MessangerModel(
  id: 1,
  name: 'James',
);

List<DummyMessageModel> messages = [
  DummyMessageModel(
    sender: james,
    time: '5:30 pm',
    description: 'Hello',
    status: 'Closed',
  ),
  DummyMessageModel(
    sender: currentUser,
    time: '6:30 pm',
    description: 'Hi',
    status: 'Closed',
  ),
  DummyMessageModel(
    sender: james,
    time: '6:30 pm',
    description: 'it been long tile bro',
    ticket: 'dfmsdkfmsd',
    status: 'Closed',
  ),
  DummyMessageModel(
    sender: currentUser,
    time: '6:30 pm',
    description: 'Hmmm!! my bro ther na workoo',
    ticket: 'dsmfksdmfskd',
    status: 'Closed',
  ),
  DummyMessageModel(
    sender: currentUser,
    time: '6:30 pm',
    description: 'How na?',
    ticket: 'dfmsdkfmsd',
    status: 'Closed',
  ),
  DummyMessageModel(
    sender: james,
    time: '7:30 pm',
    description: 'Are you around?',
    ticket: 'dfmsdkfmsd',
    status: 'Closed',
  ),
  DummyMessageModel(
    sender: currentUser,
    time: '8:30 pm',
    description:
        'I am at home, but will be leaving any moment from now. I would like to visit your by week end',
    ticket: 'dfmsdkfmsd',
    status: 'Progress',
  ),
];
