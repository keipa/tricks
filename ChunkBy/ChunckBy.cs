        public static List<List<T>> ChunkBy<T>(this IEnumerable<T> source, int chunkSize)
        {
            return source.Select((x, i) => (index: i, value: x))
                .GroupBy(x => x.index / chunkSize)
                .Select(x => x.Select(v => v.value).ToList())
                .ToList();
        }
