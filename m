Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743421;
	b=UfFZZG7c1SkgD5Q4raZVWFcj/XfRG7xPu6SoFs08IQ5EBUuJwQrlPsFoz765BVkFqP/I
	 0b4OqbRR+SWat6SksgUi3TWCbiKP56UtNLIHtIa1EXG4WddndBu8603GkV57GywwWHPUo
	 TjYg9eh5NxI1TEhhA0M8UBcEVFNUslNbGyNi0G0POXemxseioNmmkmgr9Ze/CgiPQSJZR
	 1+LdZ22gfQgeFShljxJKaks6FdhFRWgK2uyXG7bFfcmTjDWi54ct8c8Sz39H9cacvAY55
	 I/hBou8pLSAGcFSmeu+dRia0FUjPhdFnj/GqfdPWv+WUVrHL7RPJK1PWixkMIdGWnhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=lT95gwxqijZuWNZmAFyry0p0ILAiPcgM7CWPA1WXiYY=;
	b=itUbuh4kvC3tka22gkEFQxGmFlF1OYSAjfgvzneNika7w3J4R2NlrfmmIIJkCgxz4n/U
	 xeiE5VJ+sBSpEQok90eVVnpwh7heuHuyK1Y4KrmeTwr5jSmbSkrOlGN/IiChVws+sXFZk
	 4B2hNcSYvO5jZjsVTnxn3qUmlOckXWRA6+ppyIo5PGCgMsjm6SelWC7Ae6WkIXUeW8QDL
	 4huBDd6JVNFVAUwM9cgkZKgHx6b3j0rH6WOF1zioAWzKNqzYDL4RtpGtPE4EKzjT2JB0m
	 EGoVbuMshJ6qyEAUl9jLInT3tcEQ5QS5m1n2j+HjoEHE4MXpaF9CisFn5GseJm4eU7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Drx3/q69";
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513FD606A32F
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 22:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 513FD606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Drx3/q69
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ada6ccd402so91168a91.2
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 14:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793743421; x=1794348221; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lT95gwxqijZuWNZmAFyry0p0ILAiPcgM7CWPA1WXiYY=;
        b=Drx3/q697RAG8GJwAL4vdlcy35CqUij62vlkFFuPQtFthDv4O93OtI/eX0+eiJg2Id
         JVBR5dyBO9fbqsO3+NmmK8eg2EQnvMSbBTKZZNkVOH9LvSbOIYfuyYcaNJGO9OiEPr02
         6cqZDa8J52yq3METTbCX9TKCv8QTSnBiQRwgjqkTCM3pGdPQnGE4e0YpoBvs1O4xdyq5
         eG2LciuLtDmCcUnEbXReSXZvqnUVOnJHfHB81/CsrEsBjnEP2xAuEJHln8vdYUIiv7Uj
         gpQFmiPrR0GO1sUA9p+hwW3nICewz3xtL753K0dbVMFFZyyH175bu06OwW7CCKRwcqDI
         Hksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793743421; x=1794348221;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lT95gwxqijZuWNZmAFyry0p0ILAiPcgM7CWPA1WXiYY=;
        b=XlhmMUT1W+gJrItfISX+TFX6AP+i10BMhfxdN2z49zQHHywR6Oi5TnLNUFkaNsLIiU
         5Utye1gDi7EhhZSKjU2B9fzYwGA9foiflKxDIqFnooQMhRehl9VhLhYBh+IdxLrcMY8t
         HkJZWjb/NB8GmLXKAWDYcLrI98sE5Mpstthw7wtQdZDPlZSZpsHswqxilMUDHJmt50LC
         +WYgwjSFMbU0Sse5LPKh9xqpmCd8iZ276DOW9gZa864oJfPm55+VrwfJ8TNgJ1wtVmfy
         3foXaIvO/yLYoUPHNI22qVQoJD6tEI2i7+u7SeI8I+e+mcxq76xI2zh8bsuas9yteBXN
         H/lQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3N1RuiLcbPNuV9i2uo4BnwE9zVElctI87k1BT+ZP82M7Mi6bewHSL9Zp2MuOjh6nTtYg=@vger.kernel.org
X-Gm-Message-State: APuU4Z93fdVO5G1f6hqr7zPWGEze5j9fSmRq/uGj/4PMt9M60HtQbD/X
	ljy0FzOIibrMce9FOm5/tbIvwfZuNduVWOOur15U0QrE4QXypZ6/Qn2u2ANbOyOKJ2lUwGAq9QN
	xHKLCXfFZ/VDSQg==
X-Received: from pgbdw19.prod.google.com ([2002:a05:6a02:4493:b0:cc9:f793:b980])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e397:b0:3b0:96ce:104f with SMTP id 98e67ed59e1d1-3b096ce1144mr146764a91.5.1793743420343;
 Tue, 03 Nov 2026 14:03:40 -0800 (PST)
Date: Tue,  3 Nov 2026 22:03:37 +0000
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
Message-ID: <20261103220337.3578111-1-skhawaja@google.com>
Subject: [PATCH v3] vfio: selftests: Remove libuuid dependency
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>
Cc: Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Replace libuuid with a minimal uuid_t and uuid_parse() in libvfio, and
drop -luuid from the build. libvfio only uses libuuid to parse VF
tokens, so pulling in an external library is not worth it.

libuuid is often missing from cross-compilation sysroots, which causes
the VFIO selftests to fail to link:

  ld: cannot find -luuid: No such file or directory

It also complicates building against glibc alternatives such as musl, see
https://lore.kernel.org/kvm/c2f7e904-2646-4b01-864d-d185221c7f56@gmail.com/

Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---

v3:
- Reword the changelog and drop the testing note from it (David)
- Move the libuuid comment to uuid.h and explain how it differs from
  the kernel API (David)

v2: https://lore.kernel.org/all/20261102200624.1570562-1-skhawaja@google.com/
- Move the parser to lib/uuid.c and lib/include/libvfio/uuid.h (David)
- Drop the vfio_ prefixes and add a uuid_t (David)
- Mention musl in the commit message (David)

v1: https://lore.kernel.org/all/20260925013110.3447626-1-skhawaja@google.com/
---
 .../selftests/vfio/lib/include/libvfio.h      |  1 +
 .../selftests/vfio/lib/include/libvfio/uuid.h | 16 +++++++
 tools/testing/selftests/vfio/lib/libvfio.mk   |  3 +-
 tools/testing/selftests/vfio/lib/uuid.c       | 42 +++++++++++++++++++
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
index 000000000000..5c4ebe5ae3d3
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/uuid.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_UUID_H
+#define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_UUID_H
+
+/*
+ * Minimal replacement for libuuid's uuid_t and uuid_parse(). These mirror
+ * the libuuid API, not the kernel's: uuid_t is a byte array (not a struct)
+ * and uuid_parse() fills it in place (it does not take a uuid_t pointer).
+ */
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
index 000000000000..906a5db70ce1
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/uuid.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <string.h>
+
+#include <libvfio.h>
+
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

