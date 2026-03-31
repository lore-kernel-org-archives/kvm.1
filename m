Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEAC3E3D9D
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986147; cv=none; b=acsX1aiIF6ckV3rmk2yTqc/4H/Vtsy9o+d82yqkxwlDt9QhHBER7U12wGrSy7/gfycYAkNZl/Z3zWDJPytrsk/HQeff0arXzUfC7GYRW9xDYwAmA4J+E9AKqsW15MYU+/LokgDKBBCIpS8a9kkF3LfNXCU9U01mCOHKsNkiqCgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986147; c=relaxed/simple;
	bh=n4fhcjg0fQb/2J9WY6YgHfApmfQaurJyvDnXjYmfZLg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FtqfHQuDjyaA/Qw+q9nRD5F1MwPWsGvtPgRcGrltTN0qUOwC97b+haUjCWYc4T+8jLNren3gSnEKxFwUPOHyStYBQpsJ7BesmJQf0kjyoWlNC/JZnnD9J56yNk+qijhZcRiHHKpWowMgHGruKMH/2gYrBImZmOy0HT0n9ebZGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SVabiZzE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVabiZzE"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a6906e35fso183209b3a.0
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986146; x=1775590946; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EDxS3RLGSrG2H/pkS7vidJMr8Di538wm6I+VqwzPhms=;
        b=SVabiZzE2my2phCalmgQnrEYFpYntiF2vjSdUD9gYReMoQhpDFKOUyvw1A5JAc/28T
         vltrN8hchRclXwzaF6ic2a35mpXtZtmmFF5Gq6y/yVcd/PFhaxcte4KnXQ+ud4D88yXK
         /aAftkemZ/oNyM27pcrvYV3NWew8EEJj5tFzmUdJHk5D2s7qKAfmGdEaiXR+Ch8G3yRZ
         bWmZuYQh81azbt8PjuT/4m/Su+npPxgK5e5ddRLtDI1dSosphGzAcNsO2v3fS84BvsMg
         o7T7mDrgQDnWKW2nmjP0PBn4KkmupKc1ijPe7eKjAz8O6mbF5VncBoQ+eolWigCE6l5R
         BBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986146; x=1775590946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDxS3RLGSrG2H/pkS7vidJMr8Di538wm6I+VqwzPhms=;
        b=J93c3h38TKrkae4PtUX+6p1v7RTJa6g/3Xx4ve45O+NaYu9E67PlMC4u2SyxCy9Lp5
         3Ts0N6bg1xxpPvbrTWQG7Z2WrWJXFEO1Qoxix3vudKkg4hxkvyfbMM019tP98bjDkLsl
         YBjmqcnZV/eh7aldoa+dRdo8bP0ETl6fffqFkeNKrdpms4ROWVeg8ZlgNReeqwLMfm8m
         ncqumlRxkSK+LrT+Wdv9enO8/thnFo+ns/8qgFvm0bIIvzRd6LPGitUw5TpmRUqJ/aaT
         Wdx5o2/UF8CFKNsE5Sz8C8qkc/QEzEdZTy+HYAeDEeetxZefxr87q+rWlhHoPlCWM1jr
         2aYg==
X-Gm-Message-State: AOJu0YwMW5dtRTqLnyXA8e/y90cqlo/8DsSepwD0S+cbKTkAqEXaQUaf
	pVaT1n/ITgKl/+8Gzo0BKUhPee4djxSORZ9a/XCXneLYQk5aRHdUBI3lkrMF54A0YlDKBFfMjdQ
	CU+7viLvEAlMCvsspnweNRqmb+KOgr7qwiu+2n8JiFFgMShHMqA9whvJEVcfhoC7MGmobogfdBO
	CYfkjv3Luhj3p4gU7oGkKpmMvG+3imgFJrdQZzYg==
X-Received: from pfud21.prod.google.com ([2002:a05:6a00:10d5:b0:82a:1d94:6f65])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ca8:b0:82a:15a1:14d
 with SMTP id d2e1a72fcca58-82ceaa5635emr441207b3a.14.1774986145378; Tue, 31
 Mar 2026 12:42:25 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:42:00 -0700
In-Reply-To: <20260331194202.1722082-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194202.1722082-1-vipinsh@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194202.1722082-8-vipinsh@google.com>
Subject: [PATCH v4 7/9] KVM: selftests: Print sticky KVM selftests runner
 status at bottom
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Cc: seanjc@google.com, pbonzini@redhat.com, borntraeger@linux.ibm.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, anup@brainfault.org, 
	atish.patra@linux.dev, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	chenhuacai@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	ajones@ventanamicro.com, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Print current state of the KVM selftest runner during its execution.
Show it as the bottom most line, make it sticky and colored. Provide
the following information:
- Total number of tests selected for run.
- How many have executed.
- Total for each end state.

Example:

Total: 3/3 Passed: 1 Failed: 1 Skipped: 0 Timed Out: 0 No Run: 1

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../selftests/kvm/runner/test_runner.py       | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/kvm/runner/test_runner.py b/tools/testing/selftests/kvm/runner/test_runner.py
index e8e8fd91c1ad..66a3c3711a8a 100644
--- a/tools/testing/selftests/kvm/runner/test_runner.py
+++ b/tools/testing/selftests/kvm/runner/test_runner.py
@@ -15,6 +15,7 @@ logger = logging.getLogger("runner")
 class TestRunner:
     def __init__(self, testcases, args):
         self.tests = []
+        self.status = {x: 0 for x in SelftestStatus}
         self.output_dir = args.output
         self.jobs = args.jobs
         self.print_stds = {
@@ -33,9 +34,19 @@ class TestRunner:
         test.run()
         return test
 
+    def _sticky_update(self):
+        print(f"\r\033[1mTotal: {self.tests_ran}/{len(self.tests)}" \
+                f"\033[32;1m Passed: {self.status[SelftestStatus.PASSED]}" \
+                f"\033[31;1m Failed: {self.status[SelftestStatus.FAILED]}" \
+                f"\033[33;1m Skipped: {self.status[SelftestStatus.SKIPPED]}"\
+                f"\033[91;1m Timed Out: {self.status[SelftestStatus.TIMED_OUT]}"\
+                f"\033[34;1m No Run: {self.status[SelftestStatus.NO_RUN]}\033[0m",
+                end="\r", flush=True)
+
     def _log_result(self, test_result):
         print_level = self.print_stds.get(test_result.status, "full")
 
+        print("\033[2K", end="\r", flush=True)
         if (print_level == "full" or print_level == "stdout"):
             logger.info("*** stdout ***\n" + test_result.stdout)
         if (print_level == "full" or print_level == "stderr"):
@@ -43,8 +54,16 @@ class TestRunner:
         if (print_level != "off"):
             logger.log(test_result.status, f"[{test_result.status.name}] {test_result.test_path}")
 
+        self.status[test_result.status] += 1
+        # Sticky bottom line
+        self._sticky_update()
+
     def start(self):
         ret = 0
+        self.tests_ran = 0
+
+        # Show initial progress
+        self._sticky_update()
 
         with concurrent.futures.ProcessPoolExecutor(max_workers=self.jobs) as executor:
             all_futures = []
@@ -54,9 +73,11 @@ class TestRunner:
 
             for future in concurrent.futures.as_completed(all_futures):
                 test_result = future.result()
+                self.tests_ran += 1
                 self._log_result(test_result)
                 if (test_result.status not in [SelftestStatus.PASSED,
                                                SelftestStatus.NO_RUN,
                                                SelftestStatus.SKIPPED]):
                     ret = 1
+        print("\n")
         return ret
-- 
2.53.0.1118.gaef5881109-goog

