Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08773DEAEB
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986141; cv=none; b=cT4ETp36BKTcZCQt9C+DLAI96CRMwd+4Es9RA/phZaTQLX4twT5Hu33OkZrcPo9aUFMTAUyj/wj4ywXW06PN4TfvF8LCOEUFQXueCEhSC0m3SKDXGInHeckZZ93/idB0wXOUlAwGSInSAfb9AR3I9Kf715DpERimIgjCb2yW5rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986141; c=relaxed/simple;
	bh=HVF2ECQB8nP6NMFVzEQBCqJIYHs7RftQXMQpbNjFucA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JJk+/KTvJCZBm8P95dk+e0Iy0OpeKlXc1FtQW2xV6n3BIvTks7alOMh4plmGLSGalTdAnOkM4ilW/BaGjD9j5Ns+Ich6oOWLh5CgQCIdmZoYnEEdySPVEZbypP4xbGBQxpQsvoRsuDFKhxY/fRfMfNO6N4cEniahy0u84Lx4bl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FTsm8HN9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FTsm8HN9"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c44bf176so7747337a91.0
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986140; x=1775590940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ka0uEckvF83qn5GmvpHw9HtNOmToQnEieGf8Vdd2qVw=;
        b=FTsm8HN9TVzchqrYla35SsWXdvo7IoqglnSVtv5bv061gPJfGn/+deScILta+sTMRS
         iD9prba9Z+jWop6C33OeaZWAbYf5t0YKMZJR32yi5hsQz1WigCVH+SqVRlSp8uPAlcyv
         NoQTGv5u5pe2MCXppESjelnNEUT5Dq/hsEGTs6brogb6YedPY0VJu0oNrFhTkd9dEqyQ
         tYYBR4YYZ0jYWKExhQdoD2iLOfY8IFRZoHJyENFO+hPMcABn+/zkTVqjT5H5yavCOm8S
         E07bhFcNCKlT3DdOAcmkoXf79AIddmLMxeu8kB8FXekpml5bZZSYs94UUD/Ba/M8UlSr
         nE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986140; x=1775590940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ka0uEckvF83qn5GmvpHw9HtNOmToQnEieGf8Vdd2qVw=;
        b=U4j6vjNYs/zi00363jxFHXXHIV20woMLM7WOboYwtNG5RcXaTRlITCfdjMtKU6R9fK
         SqShYy+6t6JC4nnV6fhmMUJe/3wKhX7OLAZYTMFoZ5mgOk5ZF8rYJIH79KkdRuIqgd8l
         yoeVyOQHKkZmhN0o/vjLM3PW8s58drKnReUupKhxyL6OCy08je7/JnTAt4o64Adtfxxr
         5TMUGhNTNTlPmScokzM/BEGqED/tfh9gQxFWtW51W+wxhahr/XHywLL5KUGPM10CJAY3
         zXsILnLd6NK2WoYh9s+1+WPqtX69FIozaTzEXXzAvc8HDtFlE37/jVeSS8fHRCIShzg9
         JyYw==
X-Gm-Message-State: AOJu0YzxpUPE+P9J1uplOKrt1py2kHnP0L5C7ciMNucWZ/vPNPRQANXl
	UINOsE9v4/NSyKVrF0cbHjhEmFaRpsllCv2pP9lPK2zeOfLbEZKcJ7DNhC7fziCUT2EvctoHI28
	zG0u34UrkQkJrEk+o31FhGXhxOqBg67t5B93uPZQHQHad/SV1+xsJUVzkxB6MRvXkHuKxb8uNlL
	ZC0SFNeIQekF1G70dbstpFBKMSbDSLwMKZh5TqJg==
X-Received: from pjblp17.prod.google.com ([2002:a17:90b:4a91:b0:35d:a80b:8d43])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cc2:b0:35b:e554:53a6
 with SMTP id 98e67ed59e1d1-35dc6ea1153mr570258a91.11.1774986139702; Tue, 31
 Mar 2026 12:42:19 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:41:57 -0700
In-Reply-To: <20260331194202.1722082-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194202.1722082-1-vipinsh@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194202.1722082-5-vipinsh@google.com>
Subject: [PATCH v4 4/9] KVM: selftests: Add option to save selftest runner
 output to a directory
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Cc: seanjc@google.com, pbonzini@redhat.com, borntraeger@linux.ibm.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, anup@brainfault.org, 
	atish.patra@linux.dev, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	chenhuacai@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	ajones@ventanamicro.com, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a command line flag, -o/--output, to selftest runner which enables
it to save individual tests output (stdout & stderr) stream to a
directory in a hierarchical way. Create folder hierarchy same as tests
hieararcy given by --testcases and --dirs.

Also, add a command line flag, --append-output-time, which will append
timestamp (format YYYY.M.DD.HH.MM.SS) to the directory name given in
--output flag.

Example:
  python3 runner --dirs test -o test_result --append_output_time

This will create test_result.2025.06.06.08.45.57 directory.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../testing/selftests/kvm/runner/__main__.py  | 34 +++++++++++++++--
 .../testing/selftests/kvm/runner/selftest.py  | 38 ++++++++++++++++---
 .../selftests/kvm/runner/test_runner.py       |  4 +-
 3 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/runner/__main__.py b/tools/testing/selftests/kvm/runner/__main__.py
index 82c543d11c34..5ea5ee8957c4 100644
--- a/tools/testing/selftests/kvm/runner/__main__.py
+++ b/tools/testing/selftests/kvm/runner/__main__.py
@@ -7,6 +7,8 @@ import argparse
 import logging
 import os
 import sys
+import datetime
+import pathlib
 
 from test_runner import TestRunner
 from selftest import SelftestStatus
@@ -42,10 +44,20 @@ def cli():
                         type=int,
                         help="Timeout, in seconds, before runner kills the running test. (Default: 120 seconds)")
 
+    parser.add_argument("-o",
+                        "--output",
+                        nargs='?',
+                        help="Dumps test runner output which includes each test execution result, their stdouts and stderrs hierarchically in the given directory.")
+
+    parser.add_argument("--append-output-time",
+                        action="store_true",
+                        default=False,
+                        help="Appends timestamp to the output directory.")
+
     return parser.parse_args()
 
 
-def setup_logging():
+def setup_logging(args):
     class TerminalColorFormatter(logging.Formatter):
         reset = "\033[0m"
         red_bold = "\033[31;1m"
@@ -72,12 +84,26 @@ def setup_logging():
     logger = logging.getLogger("runner")
     logger.setLevel(logging.INFO)
 
+    formatter_args = {
+        "fmt": "%(asctime)s | %(message)s",
+        "datefmt": "%H:%M:%S"
+    }
+
     ch = logging.StreamHandler()
-    ch_formatter = TerminalColorFormatter(fmt="%(asctime)s | %(message)s",
-                                          datefmt="%H:%M:%S")
+    ch_formatter = TerminalColorFormatter(**formatter_args)
     ch.setFormatter(ch_formatter)
     logger.addHandler(ch)
 
+    if args.output != None:
+        if (args.append_output_time):
+            args.output += datetime.datetime.now().strftime(".%Y.%m.%d.%H.%M.%S")
+        pathlib.Path(args.output).mkdir(parents=True, exist_ok=True)
+        logging_file = os.path.join(args.output, "log")
+        fh = logging.FileHandler(logging_file)
+        fh_formatter = logging.Formatter(**formatter_args)
+        fh.setFormatter(fh_formatter)
+        logger.addHandler(fh)
+
 
 def fetch_testcases_in_dirs(dirs):
     testcases = []
@@ -98,7 +124,7 @@ def fetch_testcases(args):
 
 def main():
     args = cli()
-    setup_logging()
+    setup_logging(args)
     testcases = fetch_testcases(args)
     return TestRunner(testcases, args).start()
 
diff --git a/tools/testing/selftests/kvm/runner/selftest.py b/tools/testing/selftests/kvm/runner/selftest.py
index e3924ee40ab3..76c3e6d463ee 100644
--- a/tools/testing/selftests/kvm/runner/selftest.py
+++ b/tools/testing/selftests/kvm/runner/selftest.py
@@ -7,6 +7,7 @@ import pathlib
 import enum
 import os
 import subprocess
+import contextlib
 
 class SelftestStatus(enum.IntEnum):
     """
@@ -29,7 +30,7 @@ class Selftest:
     Extract the test execution command from test file and executes it.
     """
 
-    def __init__(self, test_path, path, timeout):
+    def __init__(self, test_path, path, timeout, output_dir):
         test_command = pathlib.Path(test_path).read_text().strip()
         if not test_command:
             raise ValueError("Empty test command in " + test_path)
@@ -39,15 +40,14 @@ class Selftest:
         self.test_path = test_path
         self.command = test_command
         self.timeout = timeout
+        if output_dir is not None:
+            output_dir = os.path.join(output_dir, test_path.lstrip("./"))
+        self.output_dir = output_dir
         self.status = SelftestStatus.NO_RUN
         self.stdout = ""
         self.stderr = ""
 
-    def run(self):
-        if not self.exists:
-            self.stderr = "File doesn't exist."
-            return
-
+    def _run(self, output=None, error=None):
         run_args = {
             "universal_newlines": True,
             "shell": True,
@@ -70,4 +70,30 @@ class Selftest:
             out, err = e.stdout, e.stderr
 
         self.stdout = out.decode("utf-8", "replace") if isinstance(out, bytes) else (out or "")
+        if output is not None:
+            output.write(self.stdout)
+
         self.stderr = err.decode("utf-8", "replace") if isinstance(err, bytes) else (err or "")
+        if error is not None:
+            error.write(self.stderr)
+
+    def run(self):
+        if not self.exists:
+            self.stderr = "File doesn't exist."
+            return
+
+        if self.output_dir is not None:
+            pathlib.Path(self.output_dir).mkdir(parents=True, exist_ok=True)
+
+        output = None
+        error = None
+        with contextlib.ExitStack() as stack:
+            if self.output_dir is not None:
+                output_path = os.path.join(self.output_dir, "stdout")
+                output = stack.enter_context(
+                    open(output_path, encoding="utf-8", mode="w"))
+
+                error_path = os.path.join(self.output_dir, "stderr")
+                error = stack.enter_context(
+                    open(error_path, encoding="utf-8", mode="w"))
+            return self._run(output, error)
diff --git a/tools/testing/selftests/kvm/runner/test_runner.py b/tools/testing/selftests/kvm/runner/test_runner.py
index bea82c6239cd..b9101f0e0432 100644
--- a/tools/testing/selftests/kvm/runner/test_runner.py
+++ b/tools/testing/selftests/kvm/runner/test_runner.py
@@ -13,9 +13,11 @@ logger = logging.getLogger("runner")
 class TestRunner:
     def __init__(self, testcases, args):
         self.tests = []
+        self.output_dir = args.output
 
         for testcase in testcases:
-            self.tests.append(Selftest(testcase, args.path, args.timeout))
+            self.tests.append(Selftest(testcase, args.path, args.timeout,
+                                       args.output))
 
     def _log_result(self, test_result):
         logger.info("*** stdout ***\n" + test_result.stdout)
-- 
2.53.0.1118.gaef5881109-goog

