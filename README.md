# Task

Students will build a simple task tracking app to practice project planning, progress tracking, MVC separation, intermediate table view features, and swift delegates.
Students who complete this project independently are able to:

## Learning Objectives
* identify and build a simple navigation view hierarchy
* create a model object
* add staged data to a model object controller
* implement the UITableViewDataSource protocol
* implement a static UITableView
* create a custom UITableViewCell
* write a custom delegate protocol
* use a date picker as a custom input view
* wire up view controllers to model object controllers
* implement basic data persistence

Please make sure to fork and clone this project before you begin. Once you have cloned it, navigate into the repo via the terminal and switch to the starter branch with `git checkout starter`. If at any point in time you need to view the master code solutions, you can switch back to the main branch.

## View Hierarchy
1. Create a UITableViewController file called `TaskListTableViewController`
2. Add a UITableViewController scene to your `Main.storyboard` that will be used to list tasks. Class it as a `TaskListTableViewController`
3. Embed the scene in a UINavigationController and set it as your apps initial entry point
4. In your `TaskListTableViewController`, set your table view's prototype style to `basic` (_we will change this later to be a custom style_)
5. Give your cell a reuseIdentifier of `taskCell`
6. Add an `Add` system bar button item to the navigation bar
7. Create a UIViewController file called  `TaskDetailViewController` 
8. Add a UIViewController scene to your `Main.storyboard` that will be used to view and/or create a task. Class it as a `TaskDetailViewController`
9. Add a segue from the Add bar button item from the first scene to the second scene (_This segue will not pass data, and therfore will not need an identifier_)
10. Add a segue from the prototype cell in the first scene to the second scene (_This segue will pass data, so you must give it an identifier_)
11. In your `TaskDetailViewController` scene, and a `Save` bar button item in the right side of your navigation bar
12. Add the following view elements and constrain them how you would like:
    * UITextField (this is where the user will add the tasks name). Give the text field a placeholder text of "Enter task name..."
    * UITextView (this is where the user will add the tasks notes). Replace the default text with "Enter notes here..."
    * UIDatePicker (this is where the user will select the tasks due date)
13. Create the following IBOutlets from the above views:
    * `taskNameTextField`
    * `taskNotesTextView`
    * `taskDueDatePicker`
14. Create the following IBActions from the above views:
    * `saveButtonTapped`
    * `dueDatePickerDateChanged`
    
## Create a Task Model
1. Create a new swift file called `Task.swift` and inside that file create a `Task` class
2. Add the following properties to your model: name (String), notes (String?), dueDate (Date?), and isComplete (Bool)
3. Create your memberwise initializer and give isComplete a default value of false

## Create a TaskController
Create a TaskController model object controller that will manage and serve Task objects to the rest of the application.

1. Create a `TaskController.swift` file and define a new `TaskController` class inside
2. Create a `shared` property as a shared instance
3. Add a `tasks` property and set it to be an array of `Task` objects, with a default value of empty
4. Create the following CRUD function signatures:
    * `createTaskWith(name: String, notes: String?, dueDate: Date?)`
    * `update(task: Task, name: String, notes: String?, dueDate: Date?)`
    * `toggleIsComplete(task: Task)`
    * `delete(task: Task)`
5. Create your 3 persistence methods, `fileURL`, `saveToPersistentStorage`, `loadFromPersistentStorage` 
* _Hint: You may reference old projects or use a code snippet to do this. However, make sure to update the necessary code._
* _Hint 2: You will need to make your model codable._
6. Go through each CRUD function and build out the logic. Create should create a `Task` and append it to the `tasks` array. Update should update the passed in task with the new values that were passed in. ToggleIsComplete should simply flip the boolean status of a tasks `isComplete` property. Delete should first find the index of the given task (_Hint: You will need to implement equatable on your `Task` model for this to work_) and then remove the task at that index from the `tasks` array. Make sure to call your save function at the end of each CRUD function
* Step 6 might be tough. Use previous projects as a reference. If you are stuck for more than 20 minutes, reach out in the queue channel for support.

## TaskListTableViewController
Go to TaskListTableViewController.swift and finish setting up your views.

1. Implement the UITableViewDataSource functions using `TaskController.shared.tasks` as your source of truth
2. Setup your cells to display the name of the task (_We will change this later to be a custom cell_)
3. You will want your table view to reload each time it appears, so add the override function `viewWillAppear()` to your code and set your table view to reload its data
4. Add swipe-to-delete support for deleting tasks from the List View

Recall that you created two segues from the List View to the Detail View. The segue from the plus button will tell the TaskDetailTableViewController that it should create a new task. The segue from a selected cell will tell the TaskDetailTableViewController that it should display a previously created task and save any changes made to it.

5. Implement the prepare(for segue: UIStoryboardSegue, sender: Any?) function. Be sure to check the identifier of the segue, get the destination of the segue, then get the index path for the selected row and use that index path to pass the selected task to `TaskDetailViewController` (_Hint: To do this, you will need to go to your `TaskDetailViewController` and setup a landing pad property to receive the task_)

6. Make sure to call your `loadFromPersistenceStorage()` function in your `viewDidLoad()`

## TaskDetailViewController
1. If you haven't already, delete any boiler-plate code, including the navigation section
2.  If you haven't already, create an optional landing pad property to receive a task from your `TaskListTableViewController`. (_Consider naming this `task`_)
3. Add a property, `var date: Date?`. This will be used to capture the users selected due date
4. Build out your `saveButtonTapped` IBAction. Make sure to pop the view controller after your code has been executed. (_Note: If your `task` landing pad is nil, this button should create a new task. If your `task` has a value, then the save button should update your existing task. Make sure, in both instances, to pass the task name, notes, and date (from the `date` variable you created._)
5. In your `dueDatePickerDateChanged` IBAction, set the `date` variable you created to the date value of your `taskDueDatePicker`

Your Detail View should follow the ‘updateViews’ pattern for updating the view elements with the details of a model object.

6. Add an `updateViews()` function. In the body of the function, make sure a task exists. If one does, update all the view elements to reflect the necessary data (task name, task notes, task due date) 

Give your app a test run. You should be able to create a new task and then see it on your `TaskListTableViewController`. You should also be able to click on a cell to see the details of a task as well as be able to update those details. If you have any issues, spend 20 minutes debugging, and if you are unable to find a resolution, send a message in the queue channel.

## Custom Table View Cell
Build a custom table view cell to display tasks. The cell should display the task name and have a button that acts as a checkmark to display and toggle the completion status of the task.

1. Add a new file called `TaskTableViewCell.swift` as a subclass of UITableViewCell (delete the `awakeFromNib()` and `setSelected()` functions)
2. Assign the new class to the prototype cell on the `TaskListTableViewController` Scene in `Main.storyboard`
3. Change the prototype cell's style from basic to custom and design the prototype cell with a label on the left and a square button on the right
    * Note: If you are using a stack view, constrain the aspect ratio of the button to 1:1 to force the button into a square that gives the remainder of the space to the label
    * note: Use the image edge inset to shrink the image to not fill the entire height of the content view, you can adjust the image edge insets in the Size Inspector of the UIButton
4. Remove text from the button, but add an image of an empty checkbox
    * note: Use the ‘complete’ and ‘incomplete’ image assets included in the project folder
5. Create an IBOutlet for the label named `taskNameLabel`
6. Create an IBOutlet for the button named `completionButton`
7. Create an IBAction for the button named `completionButtonTapped` which you will implement using a custom protocol in the next step

## Implement the update views pattern on the TaskTableViewCell

1. On your `TaskTableViewCell`, create an optional task variable in order for the `TaskListTableViewController` to pass a specific task to the cell
2. Add a `didSet` property observer to the task variable that you just created (leave the body blank for now)
3. Add an `updateViews()` function. In the body of this function first make sure that you have a task, then assign the task's name to you `taskNameLabel`, and check you task's `isComplete` status. If your status is true, set the `completionButton` to have a background of the complete image (in your assets). If the status is false, set it to have a background of the incomplete image.
4. Go back to the body of your `didSet` on your `task` variable, and call `updateViews()`
5. We will come back to the `completionButtonTapped` IBAction shortly. For now, update your `cellForRowAt` data source function in your `TaskListTableViewController` to cast your cell as a `TaskTableViewCell`, and then to pass a given task over to the cell.
* _Step 5 is a tough one. Give it your best shot. If you cannot work it out after 20 minutes, reach out in the queue channel for assistance._ 

## Custom Protocol
In this next section, you will write a protocol for the `TaskTableViewCell` to delegate handling a button tap to the `TaskListTableViewController`, adopt the protocol, and use the delegate method to mark the task as complete and reload the cell.

1. Add a protocol named `TaskCompletionDelegate` to the top of your `TaskTableViewCell.swift` file (above the class)
2. In the body of your protocol, define a required `taskCellButtonTapped(_ sender: TaskTableViewCell)` function (keep in mind, you only need a function signature, no body)
* _Hint: Don't forget to conform your protocol to `AnyObject`_
3. Add an optional `delegate` property on the `TaskTableViewCell`
* _Hint: remember to make this a weak var_
4. Update the `completionButtonTapped` IBAction to check if a delegate is assigned, and if so, call the delegate protocol function
5. Adopt the protocol in the `TaskListTableViewController` class
* _Hint: I recommend you do this via an extension_
6. Implement the `taskCellButtonTapped` delegate function, guard to make sure you have a task, and then call your `toggleIsComplete` function on your `TaskController`. After that, re-call your `updateViews()` function on the sender.
7. One final step, your cell needs to know who it's delegate is. To do this, got to your `cellForRowAt` function on your `TaskListTableViewController` and assign the cell's `delegate` property to the value of `self`.

At this point you should be able to run your project and toggle tasks directly from the tasks list. Test your app. Make sure there are no bugs. Do not forget to test persistence. If you have any issues, spend 20 minutes debugging, and then send a message via the queue channel.

# Copyright
Copyright © 2020 Strayer University. Unauthorized use and/or duplication of this material without express and written permission from Strayer University is strictly prohibited. To see Devmountain's privacy policy, please visit https://devmountain.com/privacy
