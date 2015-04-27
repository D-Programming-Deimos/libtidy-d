import libtidy.tidy;
import libtidy.buffio;
import libtidy.tidyenum;
import std.c.stdio;

int main(string[] args)
{
  const char* input = "<title>Foo</title><p>Foo!";
  TidyBuffer output;
  TidyBuffer errbuf;
  int rc = -1;
  Bool ok;

  TidyDoc tdoc = tidyCreate();                     // Initialize "document"
  tidyBufInit(&output);
  tidyBufInit(&errbuf);
  printf("Tidying:\t%s\n", input );

  ok = tidyOptSetBool(tdoc, TidyOptionId.TidyXhtmlOut, Bool.yes );  // Convert to XHTML
  if (ok )
    rc = tidySetErrorBuffer(tdoc, &errbuf );      // Capture diagnostics
  if (rc >= 0 )
    rc = tidyParseString(tdoc, input );           // Parse the input
  if (rc >= 0 )
    rc = tidyCleanAndRepair(tdoc );               // Tidy it up!
  if (rc >= 0 )
    rc = tidyRunDiagnostics(tdoc );               // Kvetch
  if (rc > 1 )                                    // If error, force output.
    rc = (tidyOptSetBool(tdoc, TidyOptionId.TidyForceOutput, Bool.yes) ? rc : -1 );
  if (rc >= 0 )
    rc = tidySaveBuffer(tdoc, &output );          // Pretty Print

  if (rc >= 0 )
  {
    if (rc > 0 )
      printf("\nDiagnostics:\n\n%s", errbuf.bp );
    printf("\nAnd here is the result:\n\n%s", output.bp );
  }
  else
    printf("A severe error (%d) occurred.\n", rc );

  tidyBufFree(&output );
  tidyBufFree(&errbuf );
  tidyRelease(tdoc );
  return rc;
}
