Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EB13A255D
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986145; cv=none; b=lJ3UbqVo1tMpiVKbNXVubppM9FsDBXcotGo66ZSFof2xy3CTygCBMbJeevsIX2Xejr1nlJzd1FL1xqy5TBjJr6forcNb7uOCgCIKiNesijPeZHMhfl7mvXlQsz1ynU3OMfNQp0P7RzHEvamsjz2G3tQbKcqxslJTUnj9Jlvtwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986145; c=relaxed/simple;
	bh=xdX3vBGoe37S0Rnd2Z3ik/g1FT0bPLF7gcwO6eoaLdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJZyfMGZO0hEOU7BExeeexLEsc+BBdI5zm3cr/KmP1TOKYj8yX9dLq2TgYxFZKjGGcMup1oTvLolI91ZztbPMAAry8Lc1hKf5ojwxVgmnRTV1Etu0miIdqii2R1kYarUs426QnpRPu7RPtodd6NJzSO3CFNzMAZyAZOl0nYLPGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cXh5BNvy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXh5BNvy"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3568090851aso19113926a91.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986144; x=1775590944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmS1uHrhcJAkZ/77nv6KxNChDlZ5TAlHKr2qEzAIUF0=;
        b=cXh5BNvy1xs7+SQ425QfHhYvvY6gpQ4uMxfCKvrEJWy9GTfiDJpFrkPXQ9R2lYBEda
         QWhSHItO9gV+auBJJZsCXIdnyYE1KUlNMZCZTUlck512QUaGAveTLtN58cutqaRMdLp7
         eX27mCNDhwLBwoj5sqEvGjJruv1wv/YBek1B60Q4soplYwfMbkj7r2QlEI6mS5LGh93n
         rO1pMVOjXfw8SHB3wNXOkLiXE7mKOs77D9QdYIQCDlPmoR3984e78Ui5IdzwCtioADNh
         BVlkO0xIshgcu9PgAclYXe5D4QAvtvQmyDZvYUq2j302AMqxDo26JU/D7yjve2xd2CDB
         PzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986144; x=1775590944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmS1uHrhcJAkZ/77nv6KxNChDlZ5TAlHKr2qEzAIUF0=;
        b=j1+T6HoGlCtQA4ZpCmewmN79rMLeamIHxl5xBVZCprETOvCkgCQp1NAaBuj5gyWHTw
         4qvH6SfgHc0/zq5PECSdI+63RyjBxhYzhkle6TmgBV6nZJ6f2OWgvZUA4ogw/4jsziN0
         xWyiF1nDG6KPcUAsg/xLEd6KHHQZgtI5WVqhWcW0OWChd6/NGQYJcvS5xGCeampN7wj4
         uKTYJnVZDqwASNXN7R1N5twikcjwDcNRBZAFXs+cX6SKPcIdk/6nebpa3a1ljplPTbb9
         ki5CYZqm20NBkD+IWrCGd4alYabaSU0Bhr9Tzuv38Kc483FrLld9NayVwqfM25mEk3wS
         d4Ig==
X-Gm-Message-State: AOJu0YwZsVROt9KgoVK3p8vG82w4OoTGzm3zGyhv5h2KUKQovRmTLRVS
	L99eaRSSb5LppkCZ87dxXkvmXbOQI3h1OYVts6fM2ZiPecYO912heWX9E/Ekf575bwehTWYatB+
	GDdwM1f4weA5fBg0reyKblH4Xe811Gxap3vQ0gBfQyPX1dEUms7LM+kiAcwplazd+s6WRJ52/9h
	nuaxbGbSayuvX0TDfG0gDelRs73tWs+rv9pmOMqg==
X-Received: from pjbng13.prod.google.com ([2002:a17:90b:1a8d:b0:35c:23cf:b494])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ec4:b0:34c:904a:d92
 with SMTP id 98e67ed59e1d1-35dc6fdd803mr478428a91.26.1774986143568; Tue, 31
 Mar 2026 12:42:23 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:41:59 -0700
In-Reply-To: <20260331194202.1722082-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194202.1722082-1-vipinsh@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194202.1722082-7-vipinsh@google.com>
Subject: [PATCH v4 6/9] KVM: selftests: Add various print flags to KVM
 selftest runner
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Cc: seanjc@google.com, pbonzini@redhat.com, borntraeger@linux.ibm.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, anup@brainfault.org, 
	atish.patra@linux.dev, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	chenhuacai@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	ajones@ventanamicro.com, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add various print flags to selectively print outputs on terminal based
on test execution status (passed, failed, timed out, skipped, no run).

For each status provide further options (off, full, stderr, stdout,
status) to choose verbosity of their prints. Make "full" the default
choice.

Example: To print stderr for the failed tests and only status for the
passed test:

   python3 runner --test-dirs tests  --print-failed stderr \
   --print-passed status

Above command with disable print off skipped, timed out, and no run
tests.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../testing/selftests/kvm/runner/__main__.py  | 45 +++++++++++++++++++
 .../selftests/kvm/runner/test_runner.py       | 19 ++++++--
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/runner/__main__.py b/tools/testing/selftests/kvm/runner/__main__.py
index 96402c89aea9..13f4cbea1fa7 100644
--- a/tools/testing/selftests/kvm/runner/__main__.py
+++ b/tools/testing/selftests/kvm/runner/__main__.py
@@ -9,6 +9,7 @@ import os
 import sys
 import datetime
 import pathlib
+import textwrap
 
 from test_runner import TestRunner
 from selftest import SelftestStatus
@@ -60,6 +61,50 @@ def cli():
                         type=int,
                         help="Maximum number of tests that can be run concurrently. (Default: 1)")
 
+    status_choices = ["off", "full", "stdout", "stderr", "status"]
+    status_help_text = textwrap.dedent('''\
+                        Control output of the {} test (default is full).
+                        off   : dont print anything.
+                        full  : print stdout, stderr, and status of the test.
+                        stdout: print stdout and status of the test.
+                        stderr: print stderr and status of the test.
+                        status: only print the status of test execution and no other output.''');
+
+    parser.add_argument("--print-passed",
+                        default="full",
+                        const="full",
+                        nargs='?',
+                        choices=status_choices,
+                        help = status_help_text.format("passed"))
+
+    parser.add_argument("--print-failed",
+                        default="full",
+                        const="full",
+                        nargs='?',
+                        choices=status_choices,
+                        help = status_help_text.format("failed"))
+
+    parser.add_argument("--print-skipped",
+                        default="full",
+                        const="full",
+                        nargs='?',
+                        choices=status_choices,
+                        help = status_help_text.format("skipped"))
+
+    parser.add_argument("--print-timed-out",
+                        default="full",
+                        const="full",
+                        nargs='?',
+                        choices=status_choices,
+                        help = status_help_text.format("timed-out"))
+
+    parser.add_argument("--print-no-run",
+                        default="full",
+                        const="full",
+                        nargs='?',
+                        choices=status_choices,
+                        help = status_help_text.format("no-run"))
+
     return parser.parse_args()
 
 
diff --git a/tools/testing/selftests/kvm/runner/test_runner.py b/tools/testing/selftests/kvm/runner/test_runner.py
index 92eec18fe5c6..e8e8fd91c1ad 100644
--- a/tools/testing/selftests/kvm/runner/test_runner.py
+++ b/tools/testing/selftests/kvm/runner/test_runner.py
@@ -17,6 +17,13 @@ class TestRunner:
         self.tests = []
         self.output_dir = args.output
         self.jobs = args.jobs
+        self.print_stds = {
+            SelftestStatus.PASSED: args.print_passed,
+            SelftestStatus.FAILED: args.print_failed,
+            SelftestStatus.SKIPPED: args.print_skipped,
+            SelftestStatus.TIMED_OUT: args.print_timed_out,
+            SelftestStatus.NO_RUN: args.print_no_run
+        }
 
         for testcase in testcases:
             self.tests.append(Selftest(testcase, args.path, args.timeout,
@@ -27,10 +34,14 @@ class TestRunner:
         return test
 
     def _log_result(self, test_result):
-        logger.info("*** stdout ***\n" + test_result.stdout)
-        logger.info("*** stderr ***\n" + test_result.stderr)
-        logger.log(test_result.status,
-                   f"[{test_result.status.name}] {test_result.test_path}")
+        print_level = self.print_stds.get(test_result.status, "full")
+
+        if (print_level == "full" or print_level == "stdout"):
+            logger.info("*** stdout ***\n" + test_result.stdout)
+        if (print_level == "full" or print_level == "stderr"):
+            logger.info("*** stderr ***\n" + test_result.stderr)
+        if (print_level != "off"):
+            logger.log(test_result.status, f"[{test_result.status.name}] {test_result.test_path}")
 
     def start(self):
         ret = 0
-- 
2.53.0.1118.gaef5881109-goog

