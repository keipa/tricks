            public static string RemoveLastOccurenceOf(this string source, string occurance)
            {
                return source.Remove(source.LastIndexOf(occurance, StringComparison.Ordinal), occurance.Length);
            }
