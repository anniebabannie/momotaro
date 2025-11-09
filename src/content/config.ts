// 1. Import utilities from `astro:content`
import { defineCollection, z } from 'astro:content';
// 2. Define your collection(s)
const chapter = defineCollection({ 
  type: 'data',
  schema: z.object({
    page: z.number(),
    alt: z.string(),
 })
})
// 3. Export a single `collections` object to register your collection(s)
//    This key should match your collection directory name in "src/content"
export const collections = {
  'chapter-1': chapter,
  'chapter-2': chapter,
  'chapter-3': chapter,
  'chapter-4': chapter,
  'chapter-5': chapter,
  'chapter-6': chapter,
  'chapter-7': chapter,
};