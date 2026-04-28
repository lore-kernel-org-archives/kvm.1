Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B3D2C2349
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777339509; cv=none; b=ISmCs7/HGzJVeXIgbipCIFrn3QPR7CWyb4RioYZnHQzcrJHJbz3SYlyOEjcnYyXeRhhm4j1If0tQS5dto/F3jsJn/1NFIgTmsDKHi25Gys1J0AuyX76M062UOKSocCES+8HWiu5knQyT5jDIEHW+Q2tad7PNjRGrPW7eretaLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777339509; c=relaxed/simple;
	bh=CRVpVVy6IXwGlJPB1m/7OfTQOzQuRkuutrAQbzsGcdc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jEN+ASgzO+tUGVzwBZ4b9gK5DEE1WQ7nBzyv4aqgaOf3iHdvTY7tD+eUQkEa3dAJ4VIFSOV4CMeZHuqQCc9xiRq5mP+6ftJa9srr0PsVCg6gJQiznjzlaMYNCw9oNjrtQJoqUXXx0nGlWefPjIxORg0SJwg6kopzcT6zddymTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OrR3wDzr; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrR3wDzr"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c79907d4c57so3682496a12.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 18:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777339507; x=1777944307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZD7f5dkl1jAyNQxm+BbpZTZ07IPze5Ar/mE0RucBoYU=;
        b=OrR3wDzrBadgL62xBYptvE3p0sVJ/vZyzMa5XUXo/a/jPmD4WZiYetvkWqTv6QIDtR
         DRbRDK5m4gPbIjwD3bfjpsUnkAofzWuAOUEb5NtQkpxQ8VABgcunWsTT5QgZL5q3ye8C
         4dx45zpfLWZ3Ag+8aUz2MRPJqxm3S/a1tgzMBjH/uTYPfp4dfpELFOaCFNe6h6Acs2cr
         8pkjnGU+GAV5lvf4z0sNdrm0CXH6AesntUCKCpSAVzbmOFHI1FmNSMwcsccDrQb1GgFQ
         uOFB54q/9THSdEHZHdEeLBEf69JYlaeeJx4FrnD+fUJTGSZG4mt9qykk4kdv+9QG5/9p
         ywwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777339507; x=1777944307;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZD7f5dkl1jAyNQxm+BbpZTZ07IPze5Ar/mE0RucBoYU=;
        b=kuMUx35j4Tn5uOg4GIhYN9OBkl91kGX66CXvRQEFmbnSVvNIP6Qzo32wSIakR0RZOI
         cBLwu67k/rdW+sYx4Pe/XmqyrHdYsafcCBrNCVXG9M3mXztgOqN0xFIkW4QDCIMHUAS4
         wT++qQYtOCH6jVT4KkgL2bgBoC9W5Ht1l19y0LF6YwY16bW7rxi8iDvVjJg7dClNcgXE
         bBqfbeh7Eclxrdj8vQlW8IAtbcBOxZDua6UMVqQkUkEE3W0cYdO0nSZH5CdeH9J4jWAi
         pd6NKtz/5uEQIgYEOfplbYZJ+tPtWG3wdFOaVotoO/Pyd1g/XGnZPwhVXARJmheE83m7
         qPQw==
X-Gm-Message-State: AOJu0YzkROorhtDx9jL7sXMadhi3JWY4fp1m6sBBhN8NIb04gHqLwarc
	NQady49lHF3qveC0/RPIc/y7rV9dE9K91i1OZID5MZLjIwPRBM3mx42+mM/nvQ+1cNRZ4WdjC0J
	KZd2bjg==
X-Received: from pgbfq1.prod.google.com ([2002:a05:6a02:2981:b0:bac:6acd:818b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d83:b0:3a3:171f:6b23
 with SMTP id adf61e73a8af0-3a39bcaa7b1mr1309174637.0.1777339507282; Mon, 27
 Apr 2026 18:25:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 27 Apr 2026 18:25:03 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428012503.1213654-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Include sys/mman.h *and* linux/mman.h, via kvm_syscalls.h
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Include both linux/mman.h (the kernel provided version) and sys/mman.h (the
libc provided version) throughout KVM selftests, by way of kvm_syscalls.h
(which should have been including sys/mman.h anyways).  Pulling in the
kernel's version fixes compilation errors with the guest_memfd test on
older versions of libc due to a recent commit adding MADV_COLLAPSE testing.

  In file included from include/kvm_util.h:8,
                   from guest_memfd_test.c:21:
  guest_memfd_test.c: In function =E2=80=98test_collapse=E2=80=99:
  guest_memfd_test.c:219:47: error: =E2=80=98MADV_COLLAPSE=E2=80=99 undecla=
red (first use in this function); did you mean =E2=80=98MADV_COLD=E2=80=99?
      219 |         TEST_ASSERT_EQ(madvise(mem, pmd_size, MADV_COLLAPSE), -=
1);
          |                                               ^~~~~~~~~~~~~
    include/test_util.h:62:16: note: in definition of macro =E2=80=98TEST_A=
SSERT_EQ=E2=80=99
       62 |         typeof(a) __a =3D (a);                                 =
           \
          |                ^
    guest_memfd_test.c:219:47: note: each undeclared identifier is reported=
 only once for each function it appears in
      219 |         TEST_ASSERT_EQ(madvise(mem, pmd_size, MADV_COLLAPSE), -=
1);
          |                                               ^~~~~~~~~~~~~
    include/test_util.h:62:16: note: in definition of macro =E2=80=98TEST_A=
SSERT_EQ=E2=80=99
       62 |         typeof(a) __a =3D (a);                                 =
           \
          |                ^

Route the includes through kvm_syscalls.h to try and avoid a future game
of whack-a-mole, i.e. so that future expansion of test coverage doesn't run
into the same problem.

To discourage use of sys/mman.h, opportunistically include the kernel's
version of mman.h in test_util.h as it only needs MAP_SHARED, i.e. only
needs the full set of kernel defs, not the libc syscall wrappers.

Fixes: 9830209b4ae8 ("KVM: selftests: Test MADV_COLLAPSE on guest_memfd")
Reported-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Closes: https://lore.kernel.org/all/20260427204313.50741-1-rick.p.edgecombe=
@intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/access_tracking_perf_test.c  |  2 +-
 tools/testing/selftests/kvm/guest_memfd_test.c         |  2 +-
 tools/testing/selftests/kvm/include/kvm_syscalls.h     | 10 ++++++++++
 tools/testing/selftests/kvm/include/test_util.h        |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c             |  2 +-
 tools/testing/selftests/kvm/memslot_perf_test.c        |  2 +-
 .../testing/selftests/kvm/s390/shared_zeropage_test.c  |  3 +--
 tools/testing/selftests/kvm/s390/tprot.c               |  2 +-
 tools/testing/selftests/kvm/set_memory_region_test.c   |  2 +-
 9 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tool=
s/testing/selftests/kvm/access_tracking_perf_test.c
index e5bbdb5bbdc3..4415c94b2866 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -41,10 +41,10 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <pthread.h>
-#include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
=20
+#include "kvm_syscalls.h"
 #include "kvm_util.h"
 #include "test_util.h"
 #include "memstress.h"
diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing=
/selftests/kvm/guest_memfd_test.c
index d6528c6f5e03..79dd3f91f1ae 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -14,10 +14,10 @@
 #include <linux/bitmap.h>
 #include <linux/falloc.h>
 #include <linux/sizes.h>
-#include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
=20
+#include "kvm_syscalls.h"
 #include "kvm_util.h"
 #include "numaif.h"
 #include "test_util.h"
diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/tes=
ting/selftests/kvm/include/kvm_syscalls.h
index 843c9904c46f..067a4c9cf452 100644
--- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -2,8 +2,18 @@
 #ifndef SELFTEST_KVM_SYSCALLS_H
 #define SELFTEST_KVM_SYSCALLS_H
=20
+/*
+ * Include both the kernel and libc versions of mman.h.  The kernel provid=
es
+ * the most up-to-date flags and definitions, while libc provides the sysc=
all
+ * wrappers tests expect.
+ */
+#include <linux/mman.h>
+
+#include <sys/mman.h>
 #include <sys/syscall.h>
=20
+#include <test_util.h>
+
 #define MAP_ARGS0(m,...)
 #define MAP_ARGS1(m,t,a,...) m(t,a)
 #define MAP_ARGS2(m,t,a,...) m(t,a), MAP_ARGS1(m,__VA_ARGS__)
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testin=
g/selftests/kvm/include/test_util.h
index d9b433b834f1..a56271c237ae 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -19,9 +19,9 @@
 #include <errno.h>
 #include <unistd.h>
 #include <fcntl.h>
-#include <sys/mman.h>
 #include "kselftest.h"
=20
+#include <linux/mman.h>
 #include <linux/types.h>
=20
 #define msecs_to_usecs(msec)    ((msec) * 1000ULL)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/sel=
ftests/kvm/lib/kvm_util.c
index 2a76eca7029d..e08967ef7b7b 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -5,13 +5,13 @@
  * Copyright (C) 2018, Google LLC.
  */
 #include "test_util.h"
+#include "kvm_syscalls.h"
 #include "kvm_util.h"
 #include "processor.h"
 #include "ucall_common.h"
=20
 #include <assert.h>
 #include <sched.h>
-#include <sys/mman.h>
 #include <sys/resource.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testin=
g/selftests/kvm/memslot_perf_test.c
index 3d02db371422..e977e979470f 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -15,7 +15,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/mman.h>
 #include <time.h>
 #include <unistd.h>
=20
@@ -23,6 +22,7 @@
 #include <linux/sizes.h>
=20
 #include <test_util.h>
+#include <kvm_syscalls.h>
 #include <kvm_util.h>
 #include <processor.h>
 #include <ucall_common.h>
diff --git a/tools/testing/selftests/kvm/s390/shared_zeropage_test.c b/tool=
s/testing/selftests/kvm/s390/shared_zeropage_test.c
index a9e5a01200b8..478381e6f84e 100644
--- a/tools/testing/selftests/kvm/s390/shared_zeropage_test.c
+++ b/tools/testing/selftests/kvm/s390/shared_zeropage_test.c
@@ -4,11 +4,10 @@
  *
  * Copyright (C) 2024, Red Hat, Inc.
  */
-#include <sys/mman.h>
-
 #include <linux/fs.h>
=20
 #include "test_util.h"
+#include "kvm_syscalls.h"
 #include "kvm_util.h"
 #include "kselftest.h"
 #include "ucall_common.h"
diff --git a/tools/testing/selftests/kvm/s390/tprot.c b/tools/testing/selft=
ests/kvm/s390/tprot.c
index 8054d2b178f0..d86179827a18 100644
--- a/tools/testing/selftests/kvm/s390/tprot.c
+++ b/tools/testing/selftests/kvm/s390/tprot.c
@@ -4,8 +4,8 @@
  *
  * Copyright IBM Corp. 2021
  */
-#include <sys/mman.h>
 #include "test_util.h"
+#include "kvm_syscalls.h"
 #include "kvm_util.h"
 #include "kselftest.h"
 #include "ucall_common.h"
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/t=
esting/selftests/kvm/set_memory_region_test.c
index 9b919a231c93..e639a9db51ee 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -8,11 +8,11 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
-#include <sys/mman.h>
=20
 #include <linux/compiler.h>
=20
 #include <test_util.h>
+#include <kvm_syscalls.h>
 #include <kvm_util.h>
 #include <processor.h>
=20

base-commit: 39f1c201b93f4ff71631bac72cff6eb155f976a4
--=20
2.54.0.545.g6539524ca2-goog

