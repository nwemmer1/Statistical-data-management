// Aleksandar Drobnjak - 4027591
// HCI - PA2
// Date: 10/02/2018

using System;
using System.Threading;

namespace PA2___Aleksandar_Drobnjak
{
    class Program
    {
        const double PI = 3.14;
        private static bool finished = false;
        private static bool interrupted = false;

        static void Main(string[] args)
        {            
            var userInput = "";
            finished = false;

            //Loop set to run until user specified to quit
            while (!finished)
            {
                interrupted = false;
                Console.WriteLine("Please enter an integer or \'q\' tp quit.");
                userInput = Console.ReadLine();

                int tryParseInt;

                //Tries to parse the string into an int value
                if (int.TryParse(userInput, out tryParseInt))
                {
                    //If greater than 0, two threads are created and the computation is ran
                    if (tryParseInt > 0)
                    {
                        Console.WriteLine("You have asked to compute the square root of PI " + tryParseInt + " times:");
                        Thread t1 = new Thread(() => threadCalculation(tryParseInt));
                        Thread t2 = new Thread(gracefulInterruption);
                        t1.Start();
                        t2.Start();
                        t1.Join();
                        t2.Join();
                        finished = false;
                    }
                    //If the number is less than 0
                    else
                        Console.WriteLine("Please enter a number >0");
                }
                //If user types q to quit the loop is broken out of
                else if (userInput.ToLower() == "q")
                    break;
                //If anything else is entered into the keyboard, the loop is just ran again
            }
        }

        //Loop which calculates the sqrt of pi
        static void threadCalculation(int iterations)
        {
            double final = 0;
            interrupted = false;
            finished = false;

            for (var i = 1; i <= iterations; ++i)
            {
                if (interrupted == true)
                    break;
                Console.WriteLine(i);
                final = Math.Sqrt(PI);
            }
            finished = true;
            Console.WriteLine("The square root of PI is " + "{0:G3}",final);

        }

        //Allows the user to gracefully interrupt the main loop
        static void gracefulInterruption()
        {
            while(!finished)
            {
                //Looks to read a key from the keyboard, if the k ey is s, then the computation is stopped
                if (Console.KeyAvailable && Console.ReadKey(true).Key == ConsoleKey.S)
                    interrupted = true;
            }
        }
    }
}
