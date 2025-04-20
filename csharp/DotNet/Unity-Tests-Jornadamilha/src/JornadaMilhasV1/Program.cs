 
Console.WriteLine("Valor:");
Console.WriteLine(new Solution().NumberOfSubstrings("abcabc"));

public class Solution
{
    public int NumberOfSubstrings(string s)
    {
        int number = 0;
        for(int i = 0; i < s.Length; i++)
        {
            string substring = s.Substring(i);
            for(int j = 3; j <= substring.Length; j++)
            {
                string value = new string(substring.Take(j).ToArray());
                if(value.Contains('a') && value.Contains('b') && value.Contains('c'))
                {
                    number += substring.Length - j + 1;
                    break;
                }
            }
        }
        return number;
    }




    public string LongestPalindrome(string s)
    {
        if (string.IsNullOrEmpty(s)) return "";

        int start = 0, maxLength = 0;

        for (int i = 0; i < s.Length; i++)
        {
            ExpandAroundCenter(s, i, i, ref start, ref maxLength);     // Odd length
            ExpandAroundCenter(s, i, i + 1, ref start, ref maxLength); // Even length
        }

        return s.Substring(start, maxLength);
    }

    private void ExpandAroundCenter(string s, int left, int right, ref int start, ref int maxLength)
    {
        while (left >= 0 && right < s.Length && s[left] == s[right])
        {
            left--;
            right++;
        }

        int len = right - left - 1;
        if (len > maxLength)
        {
            start = left + 1;
            maxLength = len;
        }
    }

    public int[][] KClosest(int[][] points, int k)
    {

        Tuple<int, double>[] distances = new Tuple<int, double>[points.Length];

        for (int i = 0; i < points.Length; i++)
        {
            var distance = CalculateDistance(points[i]);
            distances[i] = new Tuple<int, double>(i, distance);
        }

        var ordenedArray = distances.OrderBy(distance => distance.Item2).ToArray();

        var selecteds = ordenedArray.Take(k);

        return selecteds.Select(s => points[s.Item1]).ToArray();
    }

    private double CalculateDistance(int[] point)
    {
        return Math.Sqrt(Math.Pow(point[0], 2) + Math.Pow(point[1], 2));
    }
}