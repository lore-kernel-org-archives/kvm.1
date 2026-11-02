Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649989;
	b=gTZKpDNDXxblWbOMolgclZFQibviAm934E2PU8+ptrOof1mmwJa1gOfMDFmEylSMRvw1
	 O659+49Ycn4hKX3YBZzowz5ke9GC3JEy9w9SVzzRbc6Hk9AZfMP7unOVcLyYTHmOEbMsG
	 pB1RcZ7jokuaSP+nRU5VHIjfZUCuHkdfGp8UmAF2l+3/ETN80aKBpZcbc6HBUG0/4OSyd
	 2+n8HeIuqE6d2/QF6YSmYXXyJhnbtIxcLwKVtR1k0IK60aT6H2o6j7zqfRzZ+0+dx5zIo
	 1IF1533d/CiUbHZddgS0/RHsq9e1M6xibkdGvRjVQJRHqHjWREIRuMVpYebZ3CiY3Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=zNXiOAtCffaAA2fqTojb2+8iN0aPYzLlWRJ/9iKFuRk=;
	b=TYEiKlx1fpMDihR6as2ly//5m5BBcQPE7ZizgBZ6koR9AaUquo0oWNI+MpIEx3e7Ohlx
	 zbB529tQ4It5LYJ9L+hHWea0cG19C/D19ImKGAt9VZP65DOmM9j6Nt2vkkrXYcX7gQNo+
	 /qMpwWNsLMIVSrLsSIZ1iJa99yN/caEVvr4fDKZelgmiF/fNhtSxmZDQ3dLQxSO5hCryc
	 dvcahrtsI8uU6K33Iy9IfEzp54lqmstJxczKcZY3YkD9EjDWqTzAdSNaMp/Ps4SZgI6iV
	 ic7dhD7Hmbn0olweHpwZVbbQ8v4MiIXobC4mQW6glEMTIRfUECB3/LyVw3+35Lw5xjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h2tEebi8;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6DB606D821
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 20:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E6DB606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h2tEebi8
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a0592d4539so4747364b3a.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 12:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793649989; x=1794254789; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zNXiOAtCffaAA2fqTojb2+8iN0aPYzLlWRJ/9iKFuRk=;
        b=h2tEebi8FlhlcvgSGF+Nw/ZVewUA2y/5u0vJabVq7OkTIT3HMeELFE9IJdjSJCWHqL
         8bWvBIE0icLkBRS1dkuUxeXd1ZFPvyWKOg6SU/fCfEfSN8xoRfs0ZdDoJgDJAcmoORYb
         D+/OipMtTEeuyPRDjNy0D/5E7e/AyZgXuJZe7EzaVIVbWExIlJT/53qyXQRgz1c4R5c9
         KmFQ3sBY1LHQtnO0XDwp+JDuHwsknqQJaINYhagN8WR0EnTUr4rf892ZcnTKhFPeXHRt
         L9CSrjI7+nJNEWqPvrNd5ft3ixghCVbw3jpqySsZo/K5nB5WyCmh6DYeyyMtMwii5Rj8
         Retg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649989; x=1794254789;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zNXiOAtCffaAA2fqTojb2+8iN0aPYzLlWRJ/9iKFuRk=;
        b=jDidYHtkUd51y1dnygAHbjaJ2tybbjHyE4nL3evDejx0aK5dYz+W+jecUJdry9h6+U
         BwT5As8zbQyRqh5N9gsHTPNKRIARgxHnHCYsP9WvTXLHobKYCwmgjmxZzrU6F4e/dJau
         P3feMTP8ZyUSjpl0OHFhFuR6DJBtZUt8t0SmHbogFV4D0Hs5FYZ4ho179EDGsy/egcyr
         NyGFQoqM4SOYaa32rcayj9ECw+FKcHbLX5laZ46BHgsrsnWeKPMkE5Cawh74sk+yU+Rs
         PvYoawV0gu9aEGjSOm1mNG1g2AkIs2qfZTfiEKoINX7ca3gOqzfRqqgZbo9u1g0XNdHn
         uXxw==
X-Forwarded-Encrypted: i=1; AKwUvBzFyr106Z1aNDDL0w125mhz03n8x5J0sE2NyfHYc9+jEmiMlg4nmHosyZCIJWMachJVnWk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fTECiXUknSZF4qKLpEzeg5ZRML//phan4odPsKdfwV5vHxhl0
	Pqq3OEJ8B0alDYKTsnsJ84twD9YXpI381VQWJxPvBUN84xEZUyxVJcDISSrF5gBp+z9qji/E2ZX
	JwezTIrheV5hH8A==
X-Received: from pffl1-n2.prod.google.com ([2002:a05:6a00:c341:20b0:8a1:d11:a833])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:71c7:b0:89f:6989:cb9c with SMTP id d2e1a72fcca58-8acb218bb8cmr3588221b3a.13.1793649988443;
 Mon, 02 Nov 2026 12:06:28 -0800 (PST)
Date: Mon,  2 Nov 2026 20:06:24 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261102200624.1570562-1-skhawaja@google.com>
Subject: [PATCH v2] vfio: selftests: Remove libuuid dependency
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>
Cc: Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Libvfio depends on an external dependency libuuid for parsing vf_tokens.
Building it in cross compilation environments gives the following error,

 ld: cannot find -luuid: No such file or directory

It also complicates building with glibc alternatives like musl, see
https://lore.kernel.org/kvm/c2f7e904-2646-4b01-864d-d185221c7f56@gmail.com/

As it is only used for parsing vf_tokens, remove the dependency by
adding a minimal uuid_t and uuid_parse() to libvfio.

Tested by running vfio_pci_sriov_uapi_test selftest.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
v2:
- Move the parser to lib/uuid.c and lib/include/libvfio/uuid.h (David)
- Drop the vfio_ prefixes and add a uuid_t (David)
- Mention musl in the commit message (David)

v1: https://lore.kernel.org/all/20260925013110.3447626-1-skhawaja@google.com/
---
 .../selftests/vfio/lib/include/libvfio.h      |  1 +
 .../selftests/vfio/lib/include/libvfio/uuid.h | 11 +++++
 tools/testing/selftests/vfio/lib/libvfio.mk   |  3 +-
 tools/testing/selftests/vfio/lib/uuid.c       | 47 +++++++++++++++++++
 .../selftests/vfio/lib/vfio_pci_device.c      |  2 -
 5 files changed, 60 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/uuid.h
 create mode 100644 tools/testing/selftests/vfio/lib/uuid.c

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
index 07862b470777..e9d513c3a08e 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
@@ -6,6 +6,7 @@
 #include <libvfio/iommu.h>
 #include <libvfio/iova_allocator.h>
 #include <libvfio/sysfs.h>
+#include <libvfio/uuid.h>
 #include <libvfio/vfio_pci_device.h>
 #include <libvfio/vfio_pci_driver.h>
 
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/uuid.h b/tools/testing/selftests/vfio/lib/include/libvfio/uuid.h
new file mode 100644
index 000000000000..52406f3409b7
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/uuid.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_UUID_H
+#define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_UUID_H
+
+#define UUID_SIZE	16
+
+typedef unsigned char uuid_t[UUID_SIZE];
+
+int uuid_parse(const char *in, uuid_t uu);
+
+#endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_UUID_H */
diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index eff95828719e..d1d1b2b05af1 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -7,6 +7,7 @@ LIBVFIO_C := iommu.c
 LIBVFIO_C += iova_allocator.c
 LIBVFIO_C += libvfio.c
 LIBVFIO_C += sysfs.c
+LIBVFIO_C += uuid.c
 LIBVFIO_C += vfio_pci_device.c
 LIBVFIO_C += vfio_pci_driver.c
 
@@ -30,8 +31,6 @@ $(LIBVFIO_O_DIRS):
 
 CFLAGS += -I$(LIBVFIO_SRCDIR)/include
 
-LDLIBS += -luuid
-
 $(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c | $(LIBVFIO_O_DIRS)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
diff --git a/tools/testing/selftests/vfio/lib/uuid.c b/tools/testing/selftests/vfio/lib/uuid.c
new file mode 100644
index 000000000000..378904d9340a
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/uuid.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <string.h>
+
+#include <libvfio.h>
+
+/*
+ * Minimal replacement for libuuid's uuid_parse(). libuuid is part of
+ * util-linux and is routinely absent from cross-compilation sysroots, which
+ * makes the vfio selftests unbuildable for non-native architectures.
+ */
+#define UUID_STRING_LEN	36
+
+static int hexval(char c)
+{
+	if (c >= '0' && c <= '9')
+		return c - '0';
+	if (c >= 'a' && c <= 'f')
+		return c - 'a' + 10;
+	if (c >= 'A' && c <= 'F')
+		return c - 'A' + 10;
+	return -1;
+}
+
+int uuid_parse(const char *in, uuid_t uu)
+{
+	const char *p = in;
+	int i, hi, lo;
+
+	if (strlen(in) != UUID_STRING_LEN)
+		return -1;
+
+	for (i = 0; i < UUID_SIZE; i++) {
+		if (i == 4 || i == 6 || i == 8 || i == 10) {
+			if (*p++ != '-')
+				return -1;
+		}
+
+		hi = hexval(*p++);
+		lo = hexval(*p++);
+		if (hi < 0 || lo < 0)
+			return -1;
+
+		uu[i] = (hi << 4) | lo;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 4063a0e2b3df..4ae6ac1f8ed8 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -23,8 +23,6 @@
 #include <linux/types.h>
 #include <linux/vfio.h>
 
-#include <uuid/uuid.h>
-
 #include "kselftest.h"
 #include <libvfio.h>
 

base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
-- 
2.56.0.385.gac671c819a-goog

