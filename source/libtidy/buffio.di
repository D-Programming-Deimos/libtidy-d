module libtidy.buffio;

public:

/** @file buffio.h - Treat buffer as an I/O stream.

  (c) 1998-2007 (W3C) MIT, ERCIM, Keio University
  See tidy.h for the copyright notice.

  CVS Info :

    $Author: arnaud02 $
    $Date: 2007/01/23 11:17:45 $
    $Revision: 1.9 $

  Requires buffer to automatically grow as bytes are added.
  Must keep track of current read and write points.

*/

import libtidy.platform;
import libtidy.tidy;

extern(C):

/** TidyBuffer - A chunk of memory */
struct TidyBuffer
{
    TidyAllocator* allocator;  /**< Memory allocator */
    byte* bp;           /**< Pointer to bytes */
    uint  size;         /**< # bytes currently in use */
    uint  allocated;    /**< # bytes allocated */
    uint  next;         /**< Offset of current input position */
}

/** Initialize data structure using the default allocator */
void tidyBufInit( TidyBuffer* buf );

/** Initialize data structure using the given custom allocator */
void tidyBufInitWithAllocator( TidyBuffer* buf, TidyAllocator* allocator );

/** Free current buffer, allocate given amount, reset input pointer,
    use the default allocator */
void tidyBufAlloc( TidyBuffer* buf, uint allocSize );

/** Free current buffer, allocate given amount, reset input pointer,
    use the given custom allocator */
void tidyBufAllocWithAllocator( TidyBuffer* buf,
                                                      TidyAllocator* allocator,
                                                      uint allocSize );

/** Expand buffer to given size.
**  Chunk size is minimum growth. Pass 0 for default of 256 bytes.
*/
void tidyBufCheckAlloc( TidyBuffer* buf,
                                              uint allocSize, uint chunkSize );

/** Free current contents and zero out */
void tidyBufFree( TidyBuffer* buf );

/** Set buffer bytes to 0 */
void tidyBufClear( TidyBuffer* buf );

/** Attach to existing buffer */
void tidyBufAttach( TidyBuffer* buf, byte* bp, uint size );

/** Detach from buffer.  Caller must free. */
void tidyBufDetach( TidyBuffer* buf );


/** Append bytes to buffer.  Expand if necessary. */
void tidyBufAppend( TidyBuffer* buf, void* vp, uint size );

/** Append one byte to buffer.  Expand if necessary. */
void tidyBufPutByte( TidyBuffer* buf, byte bv );

/** Get byte from end of buffer */
int  tidyBufPopByte( TidyBuffer* buf );


/** Get byte from front of buffer.  Increment input offset. */
int  tidyBufGetByte( TidyBuffer* buf );

/** At end of buffer? */
Bool tidyBufEndOfInput( TidyBuffer* buf );

/** Put a byte back into the buffer.  Decrement input offset. */
void tidyBufUngetByte( TidyBuffer* buf, byte bv );


/**************
   TIDY
**************/

/* Forward declarations
*/

/** Initialize a buffer input source */
void tidyInitInputBuffer( TidyInputSource* inp, TidyBuffer* buf );

/** Initialize a buffer output sink */
void tidyInitOutputBuffer( TidyOutputSink* outp, TidyBuffer* buf );

/*
 * local variables:
 * mode: c
 * indent-tabs-mode: nil
 * c-basic-offset: 4
 * eval: (c-set-offset 'substatement-open 0)
 * end:
 */
