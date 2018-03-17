using System;
using ObjCRuntime;

namespace TinyConsolePlugin
{
    [Native]
    public enum TCWindowMode : ulong
    {
        Collapsed,
        Expanded
    }

    [Native]
    public enum TCAnchor : ulong
    {
        Top,
        Bottom
    }
}