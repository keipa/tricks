using System;
using System.Diagnostics;
using System.Threading;

public class Program
{
	public static void Main()
	{
		var stopWatch = new Stopwatch();
		stopWatch.Start();
		Thread.Sleep(2000);
		stopWatch.Stop();
		//if(stopWatch.Elapsed > new TimeSpan(0,0,15))
  	Console.WriteLine(stopWatch.Elapsed);
		stopWatch.Reset();
	}
}
