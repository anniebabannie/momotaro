import React, { useEffect, useState } from 'react';
import ReactPaginate from 'react-paginate';

export default function Pagination({ pages, chapter, current, currentChapter }: {
  pages: any[],
  chapter: number,
  current: number,
  currentChapter: number
}) {
  const [currentPage, setCurrentPage] = useState<number>();
  let sortedPages = pages.sort((a, b) => a.data.page - b.data.page);
  return(
    <ul className="flex flex-wrap text-wrap">
      {sortedPages.map((page, index) => {
        const currentClass = page.data.page == current ? "font-black bg-blue-100 " : "";
        const currentChapterClass = currentChapter === chapter ? "" : " text-stone-500 ";
        return(
            <li>
              <a href={`/chapter-${chapter}/${page.data.page}`} 
              className={currentChapterClass + currentClass + " hover:bg-blue-100 rounded inline-block py-1 px-2"}>
                  {page.data.page}
              </a>
            </li>
        )
      })}
    </ul>
  )
}