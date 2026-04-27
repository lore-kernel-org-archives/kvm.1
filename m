Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9E33B7757
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777333195; cv=none; b=K+b/JQBTMbCv4WJt6XVqnPxawbOrAsDNyu9MSwjOEfraykbncnUomiUyVG2wOatzBXII8ezdCGi2jrkYXGiBu9tnxuClOSt0XglF8O9STiOZHGD8F1S0kFT/kHj3atlGSzOxPweaoeMx+ybAt5+fjWut/TPWOAvrAWPczXK7cwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777333195; c=relaxed/simple;
	bh=xcjyL33lkZOTQPMEJTOcYt3d+VZ4V5k7rG3coXlIp9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VeHD+07Gg8biVVdYmIClX7Cevf/uzkZ4RrXIeWkzDWVz7oOkqPWkqzMv0hXKI6lMfLnDr9o/BpukNAiEaj5DiDrVPqfANcgB2C0G5vJnidwgLwybgLcYdKObVGXt4D9X5V69HzOPm3Yf6xv+QEXpBS6Nwvjcp3aUq4rdx73lJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGL9TdaH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGL9TdaH"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c799ee56bd6so2737157a12.2
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777333193; x=1777937993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8J/Wk3ohRqFL0ElINDYivXMB+84Zl+NPmQ/vauwbCY=;
        b=oGL9TdaHwSHphEaXFcUsewJwVjdJ3DH8NSaYRO3xRgZN0LzQ7+4QNhKx3ZOtTcbm/a
         1myX5pVFIKPYPOZph6Ed8MbWBQ/KoEHrnBX/kFAMdv9zFkZpETO3RZAznkAUaf7ccrCo
         iFZZoG30nTOdc8JC5xcXkt0DZffgQ0rCQxBpbUTWQ3a/W2cLXoV+F7okD78A99jJbZuJ
         mNjnocMNAVRzRu+wGrCVjmAxA2NNb7G9sFkanLL5Y/P/Busu6/5e6KtC3lqkckzzYMog
         wqfpcokEqnyqVCKPwkwEegZa4xDie15A7CahIytfKdCH9e8jsnGEaRLPdk/BYkxCChOl
         nN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777333193; x=1777937993;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T8J/Wk3ohRqFL0ElINDYivXMB+84Zl+NPmQ/vauwbCY=;
        b=TLo+6S8zPFw7rlZOM0wMkvCB5uEqbSxujBDJT3YCV2gq4ZzQrg0u+anLV5H+OrI7TO
         VN6OvLMSijU8Ho3TG0XhR9qMT00QFCo31tt/nssu+Xe7JelnOkPHdkkF17oGqvX4qx87
         sIF9pQAqJeULG3gSHV/I7GaR5ccX/AUgnPLbeJGBhjl0wndUnKBzrmraJOHO8Q54AWHH
         W5U/dgkLUq/DRhS/pbzZkZQjjAT1zkVvoWiE7reuMZc2VCB3yVFyIQkQuX2yTvISFUjX
         T18ZNXkmt1Ew8N/MipnPItqOBR0fsKBgkyUgnLjzg2Ghig+DLZou1EzlPnuPtBfH+Vs0
         g31w==
X-Forwarded-Encrypted: i=1; AFNElJ9YSYYW87yudqGnxjlVQj1s0Ya0kDRB8eBaTJQ1RWZcBmy5aQG3u0r5FhIJC89MIulm7aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyScGWa7AJyiiQ7xLLnM3wFmdVm7N+CtodJ7DrtJsNO60zi4HoT
	BqT62MUQMhDxWh+P24ii9QJx4402Pm6/wE40DP0fOWRnXSJiH6R6jMhxZgEUwe9mkX97srXex17
	KUQg5+g==
X-Received: from pfbbj12.prod.google.com ([2002:a05:6a00:318c:b0:82f:b322:30fb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d22:b0:82f:1d38:f68f
 with SMTP id d2e1a72fcca58-834ddbe64f0mr513532b3a.31.1777333192887; Mon, 27
 Apr 2026 16:39:52 -0700 (PDT)
Date: Mon, 27 Apr 2026 16:39:51 -0700
In-Reply-To: <20260427204313.50741-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427204313.50741-1-rick.p.edgecombe@intel.com>
Message-ID: <ae_zx9cRf8HQwvpX@google.com>
Subject: Re: [PATCH] KVM: selftests: Include linux version of mman.h
From: Sean Christopherson <seanjc@google.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: pbonzini@redhat.com, ackerleytng@google.com, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026, Rick Edgecombe wrote:
> Fix a selftest build error by switching a mman.h header include from the
> "sys" version to the "linux" one.
>=20
> Recently a reference to MADV_COLLAPSE was added to guest_memfd_test.c.
> This works fine if the system libc has this definition, but against older
> libcs, it leads to build errors like:
>   In file included from include/kvm_util.h:8,
>                    from guest_memfd_test.c:21:
>   guest_memfd_test.c: In function =E2=80=98test_collapse=E2=80=99:
>   guest_memfd_test.c:219:47: error: =E2=80=98MADV_COLLAPSE=E2=80=99 undec=
lared (first use in this function); did you mean =E2=80=98MADV_COLD=E2=80=
=99?
>       219 |         TEST_ASSERT_EQ(madvise(mem, pmd_size, MADV_COLLAPSE),=
 -1);
>           |                                               ^~~~~~~~~~~~~
>     include/test_util.h:62:16: note: in definition of macro =E2=80=98TEST=
_ASSERT_EQ=E2=80=99
>        62 |         typeof(a) __a =3D (a);                               =
             \
>           |                ^
>     guest_memfd_test.c:219:47: note: each undeclared identifier is report=
ed only once for each function it appears in
>       219 |         TEST_ASSERT_EQ(madvise(mem, pmd_size, MADV_COLLAPSE),=
 -1);
>           |                                               ^~~~~~~~~~~~~
>     include/test_util.h:62:16: note: in definition of macro =E2=80=98TEST=
_ASSERT_EQ=E2=80=99
>        62 |         typeof(a) __a =3D (a);                               =
             \
>           |                ^
>=20
> The problem is the test is pulling in the libc version of mman.h instead =
of
> the Linux one. Switch it to the Linux one so MADV_COLLAPSE will be
> guaranteed to be present (if the user installs the headers).
>=20
> Fixes: 9830209b4ae8 ("KVM: selftests: Test MADV_COLLAPSE on guest_memfd")
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>=20
> Hi,
>=20
> I'm not sure if there is standard official version of the header to inclu=
de
> for the selftests, but the KVM selftests no longer build for me. This fix=
es
> it.

KVM selftests (well, selftests in general, actually) are intended to use wh=
atever
kernel headers have have been installed for selftests.  E.g. for my setups,=
 that
means the headers from the git tree I'm building.

However, for mman.h, we actually need both.  linux/mman.h provides the blee=
ding
header flags and definitions, but sys/mman.h proves the syscall wrappers th=
at
selftests expect/use.  The below builds because sys/mman.h is getting inclu=
ded
elsewhere, more than likely by tools/testing/selftests/kvm/include/test_uti=
l.h.

Rather than updating individual tests on an ad hoc basis, what if we try ou=
r
best to handle this once?

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
index b099b09cbae3..79dd3f91f1ae 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -14,10 +14,10 @@
 #include <linux/bitmap.h>
 #include <linux/falloc.h>
 #include <linux/sizes.h>
-#include <linux/mman.h>
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

base-commit: 5c96e184e344065813e652e1ca0571e448e160fb
--=20

>  tools/testing/selftests/kvm/guest_memfd_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index ec7644aae999..7c113b8c4f75 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -14,7 +14,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/falloc.h>
>  #include <linux/sizes.h>
> -#include <sys/mman.h>
> +#include <linux/mman.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> =20
> --=20
> 2.54.0
>=20
