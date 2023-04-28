#!/usr/bin/env python

from LaunchServices import LSSetDefaultHandlerForURLScheme
from LaunchServices import LSSetDefaultRoleHandlerForContentType

# 0x00000002 = kLSRolesViewer
# see https://developer.apple.com/library/mac/#documentation/Carbon/Reference/LaunchServicesReference/Reference/reference.html#//apple_ref/c/tdef/LSRolesMask
LSSetDefaultRoleHandlerForContentType("public.html",
                                      0x00000002,
                                      "company.thebrowser.Browser")
LSSetDefaultRoleHandlerForContentType("public.xhtml",
                                      0x00000002,
                                      "company.thebrowser.Browser")
LSSetDefaultHandlerForURLScheme("http", "company.thebrowser.Browser")
LSSetDefaultHandlerForURLScheme("https", "company.thebrowser.Browser")
