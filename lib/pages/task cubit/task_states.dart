abstract class TaskStates{}
class TaskInitialState extends TaskStates{}
class LoadingAllTasksFromDatabase extends TaskStates{}
class NewTaskAddedState extends TaskStates{}
class SelectingTimeState extends TaskStates{}
class SelectingDateState extends TaskStates{}
class RepeatingTimeState extends TaskStates{}
class ExistingTaskUpdatedState extends TaskStates{}
class RemoveTaskState extends TaskStates{}
class PickedDayTasksState extends TaskStates{}



