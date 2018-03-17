using System;
using UIKit;

#if DEBUG
using TinyConsolePlugin;
#endif

namespace TinyConsoleCSharpDemo
{
    public class DemoController : UITableViewController
    {
        public override void ViewDidLoad()
        {
            base.ViewDidLoad();
            this.Title = "Demo";
            this.TableView.RegisterClassForCellReuse(typeof(UITableViewCell), "cell");
        }

        public override nint NumberOfSections(UITableView tableView)
        {
            return 1;
        }

        public override nint RowsInSection(UITableView tableView, nint section)
        {
            return 30;
        }

        public override UITableViewCell GetCell(UITableView tableView, Foundation.NSIndexPath indexPath)
        {
            var cell = tableView.DequeueReusableCell("cell", indexPath);
            cell.TextLabel.Text = $"Row {indexPath.Row}";
            return cell;
        }

        public override void RowSelected(UITableView tableView, Foundation.NSIndexPath indexPath)
        {
#if DEBUG
            TinyConsole.PrintText($"Tapped on {indexPath.Row}");
#endif
        }
    }
}
