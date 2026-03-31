Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D833E1204
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986143; cv=none; b=dYqGg2R53L+Z2uQSJ0YsB4TralPxMLk/kgDtHe2q9sp2cgxK/TJ1+VYoJ7sH4mOpyPXQzlyEusdURXXhhhL4qArActFj5MJwusy8EZ316s5LJHXm9nC4f7tNjwMXcSh/S3TF5UsAWc8W0MxceDtf4ZdhU7TscCH5XTITKct+QIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986143; c=relaxed/simple;
	bh=uRGwlCdbCJpqu4TvOe2ZeIyK8FWSrRmeBgbYmEep5OQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QjMZc8SH83w2qnS0WxGvR5LcEerqx4BS5NfekHR8mAcyoQejCoFysLTKgMhr3a7zhEHYX1eGxms1VjnXaUi50FH6/LbXBGQhdQimpvmeYL8q+m+HgGlWU/CV2l0YriCl1RrLL/tROvu2Ma0G1bZ+tqQ6P5R/YgRF/OB9zesThFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQqHkl1m; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQqHkl1m"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76bb22a8ceso409461a12.2
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986142; x=1775590942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=moQABiS7cv82z1Yz7qoQD99nIXpPdwRqLpnQn6Ns6AY=;
        b=GQqHkl1mwRvHLnEych/IVa0GEI9jSlQvlKBDFuo7uIJEEjEYv/rTYz+lHiT1mCUfX+
         I4aVLiox6FcCfo7OtX6eqseMrZfh1+04QMqT1rax14wJT0CZXIwvHOCWpdaIY2z0oPI3
         B0lrs0kwIKJ/EwwWBv/UPir52WUjPiz0/oc4iYQLicCT3XwIBOApxRF08nIqQtYeI91J
         8NrsnGr0HaFhOU2E9SwhP0r9bcadSN6YqkMlgbnD/Z/S6Qie2YXyOHZ0Muh1KYzqjWN3
         UMAu7wcyMoS2pRZPf9aXQBJAWdDy+NFlt4RktesksGuc9783yfx3zaPjZcTN6e7cwmks
         PtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986142; x=1775590942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moQABiS7cv82z1Yz7qoQD99nIXpPdwRqLpnQn6Ns6AY=;
        b=Y5KghD/JKBnc5EBTxcjPKWuZ2TjhLiInKByKrS6Rel/KYB+7aKPs3sIbgG0y6NRwV5
         vmToMBtlg4FHByu5x8v0iNFXqzYZKSVAyzAW9XPr8Ct2+dcTE52+8GHO/HQwfnvlsgi6
         9QiDggO7y93Q/MSPa3f9YsZiRIb+QUO9hasrtwHm+n29Qm1uHj3Lu3ydfHgJZrgrJ/tn
         8X7jkTybcIIbT2eyjbOO7f3ePtjo1YjizDfjZkPStlRGaLSFibhVkwUm3hDl7dsdtH6S
         pYbbggyspaik5acx8+KLmZgdwJQ6iU3y7FmRengRMu1y1aDXbBt7GJd1BVGxU64LHdLy
         XmMQ==
X-Gm-Message-State: AOJu0Yyokm7ny6TrqeFS5pYEubJ+agef+p0h8LLh3wqSPvIOsVzsR5BT
	e2khlpJ+QA0f2zYTk9DGh7kQzcgdfPS/GDCN/gZ0quL2dTdYsmvbPjwd3wa2ArLOa1TdIakmAOs
	B8ozvh+NMeMKR/0EfFsU3hi0Av5LXWr/usN6wEZTQnmgFJ4qcD9ceIOXQb4TVk39G72ZdzAK9bs
	vInOlHoBGgTzKj5sjNDHaQF2WNuJS8NP4jjHcQWA==
X-Received: from pfbjf1.prod.google.com ([2002:a05:6a00:6e41:b0:821:82a1:fe7d])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:600d:b0:827:3946:a23c
 with SMTP id d2e1a72fcca58-82ce88d3bd7mr811773b3a.10.1774986141556; Tue, 31
 Mar 2026 12:42:21 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:41:58 -0700
In-Reply-To: <20260331194202.1722082-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194202.1722082-1-vipinsh@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194202.1722082-6-vipinsh@google.com>
Subject: [PATCH v4 5/9] KVM: selftests: Run tests concurrently in KVM
 selftests runner
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Cc: seanjc@google.com, pbonzini@redhat.com, borntraeger@linux.ibm.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, anup@brainfault.org, 
	atish.patra@linux.dev, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	chenhuacai@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	ajones@ventanamicro.com, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a command line argument, --jobs, to specify how many tests can
execute concurrently. Set default to 1.

Example:
  python3 runner --test-dirs tests -j 10

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../testing/selftests/kvm/runner/__main__.py  |  6 ++++
 .../selftests/kvm/runner/test_runner.py       | 28 +++++++++++++------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/runner/__main__.py b/tools/testing/selftests/kvm/runner/__main__.py
index 5ea5ee8957c4..96402c89aea9 100644
--- a/tools/testing/selftests/kvm/runner/__main__.py
+++ b/tools/testing/selftests/kvm/runner/__main__.py
@@ -54,6 +54,12 @@ def cli():
                         default=False,
                         help="Appends timestamp to the output directory.")
 
+    parser.add_argument("-j",
+                        "--jobs",
+                        default=1,
+                        type=int,
+                        help="Maximum number of tests that can be run concurrently. (Default: 1)")
+
     return parser.parse_args()
 
 
diff --git a/tools/testing/selftests/kvm/runner/test_runner.py b/tools/testing/selftests/kvm/runner/test_runner.py
index b9101f0e0432..92eec18fe5c6 100644
--- a/tools/testing/selftests/kvm/runner/test_runner.py
+++ b/tools/testing/selftests/kvm/runner/test_runner.py
@@ -4,6 +4,8 @@
 # Author: vipinsh@google.com (Vipin Sharma)
 
 import logging
+import concurrent.futures
+
 from selftest import Selftest
 from selftest import SelftestStatus
 
@@ -14,11 +16,16 @@ class TestRunner:
     def __init__(self, testcases, args):
         self.tests = []
         self.output_dir = args.output
+        self.jobs = args.jobs
 
         for testcase in testcases:
             self.tests.append(Selftest(testcase, args.path, args.timeout,
                                        args.output))
 
+    def _run_test(self, test):
+        test.run()
+        return test
+
     def _log_result(self, test_result):
         logger.info("*** stdout ***\n" + test_result.stdout)
         logger.info("*** stderr ***\n" + test_result.stderr)
@@ -28,12 +35,17 @@ class TestRunner:
     def start(self):
         ret = 0
 
-        for test in self.tests:
-            test.run()
-            self._log_result(test)
-
-            if (test.status not in [SelftestStatus.PASSED,
-                                    SelftestStatus.NO_RUN,
-                                    SelftestStatus.SKIPPED]):
-                ret = 1
+        with concurrent.futures.ProcessPoolExecutor(max_workers=self.jobs) as executor:
+            all_futures = []
+            for test in self.tests:
+                future = executor.submit(self._run_test, test)
+                all_futures.append(future)
+
+            for future in concurrent.futures.as_completed(all_futures):
+                test_result = future.result()
+                self._log_result(test_result)
+                if (test_result.status not in [SelftestStatus.PASSED,
+                                               SelftestStatus.NO_RUN,
+                                               SelftestStatus.SKIPPED]):
+                    ret = 1
         return ret
-- 
2.53.0.1118.gaef5881109-goog

