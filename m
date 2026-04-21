Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C44E3B19C2
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765904; cv=none; b=UpXHli6mJl6aF3YrEj8Hmq+1299F2G67NCXULS3ByuDRorpwkDL7MPEal5als4wbQ4i+NshmLdi55DTZOSv2how38utnPA4KqjNlm2D4ZJmfj34sHq6MXBg4VwUp8iJSt0b8tWdfuRuyFb/NKlLkJ12Y6blo0Oiyq71z7WeblQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765904; c=relaxed/simple;
	bh=yfBmJxKFE2B8sFZRFT6pz/Bmzuj/HOGPpJ9ua1lUQAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SvSHU+u+MdwMdPNQBRE3F7OpDUBkWq+Ezl/lb6dGU6tpoo7xR++klo0HSUjX1oCoDXQuc5wtGaAZ6Vidsj0EHwigjwcUGJdww+QWJJYxJvgCvfDnFVhGrdZGcfRWdiFKIRfF8ZQMHZ/Mdx4qZryEItLm2JTag7BsTWSulbRHFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INX8393X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOm74OKB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INX8393X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOm74OKB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776765902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gLpMq3bvSknPmfM0Vr8rolbKX4splOg+Lf8VMaqkFw8=;
	b=INX8393XdL1FijHodn9KvcG10GDQSx4h3+7mBDvp33Pa46tO22EkIWKtNhrpi97uP8+8R2
	DeqCNmqYkvdZkE4TpMQ8KGtxIST7xKxtKDQubNp4F9YBRsfveYthWxNSpjwSLvbgv1jowg
	QKNH7PBXrs0NTs6aV3jp7ROhE01ahhc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-mmbFOgP1P2aXhOHZID4MfQ-1; Tue, 21 Apr 2026 06:05:01 -0400
X-MC-Unique: mmbFOgP1P2aXhOHZID4MfQ-1
X-Mimecast-MFC-AGG-ID: mmbFOgP1P2aXhOHZID4MfQ_1776765900
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43fe4674d3eso4122056f8f.1
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 03:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776765900; x=1777370700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLpMq3bvSknPmfM0Vr8rolbKX4splOg+Lf8VMaqkFw8=;
        b=GOm74OKBfFxx/jNr2Vxll6gHIFxfZ19KdK9wGb/4i7epzStH/WuJyCEBVl/DuDNGRd
         ZvCT2yzkUYkKARj/ts9Qut90EOTh2bEJYP596jkaYIcXruqDYshRw+zWr4hOCwtVr62E
         JsL0NTvN6aCoLg/rldFsR8RfIqdRoMG7oszlN0H6EYBphEFsByPq9h5y6B4z9sENGCOT
         gDEj7Nrr514VMdOeQlovepiZZUsH8FUMiZ5WDh8xkzI6FMCF3hSOWD6VsIZkxTVR4eSQ
         17Iuj/Nz4ec8LXFdGeDOi+HE3UGcjFCKc8dycqK4A+v/mJaLTMd4N49883n6Nw+u9JLv
         eFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776765900; x=1777370700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLpMq3bvSknPmfM0Vr8rolbKX4splOg+Lf8VMaqkFw8=;
        b=D8xxbjeb61acoC0W1xeIiJoj/k0XSry+Sg0Gp9Dojsng7SDabR/PkTcuhpSL2qP3VJ
         wMQ6J1glWUREbZp7IUx9Cdx0I/Su9C0KXjWttN/V1Igz8x85VXuI3Vi1ZfJWmde8RChz
         4Z3IgfR38mss9BMqcWErFtwYClzSkak/MGGDdblst0nlYmVHbVXwaxTyEku09O+VoT1R
         cg+cTbNkfa0bFkNFxTpgt+Tiw2EzxihUDATVVoQbxaJlvTDFBR0Ez1ZF7wqniFlj6pw7
         8Cm48SvRw1yRqdnkbQktZ3FJhI9slLIsVLGCKg1OuCZaMGv8PGHjep85JNA6Ww/TVreK
         tlWw==
X-Forwarded-Encrypted: i=1; AFNElJ9mKHy6sq0a5QrLSZdY9o8n0ZvSCfg29LgwxxO9vW7t6f6IpC1g3oW9WKPYyqYk4ZP0HpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVklgOZ4Yxo+9Dl/U0AgJ/cmY88vuaQMxdOyEYz3E3rDJn/xf5
	6NCq3dZ5lYHOZU29K57r/fi5MspS9A0fqE72Hp4wty3gy4FdbmS5JV5fzizWjNvQGtLe77XgZaB
	l1FjL5mRnCHZN850nTqnMclOdGpdc/q8svZvDKk1z4b4nrcWMnCK/bA==
X-Gm-Gg: AeBDievovzDGjazqFv+Mz2G+qT8/NU/2QUFKu0OQGoXxMkurukHJGvDSdC07H5HoRVr
	CYuKP20FwDTHZjuI4YgWHQ2N+AT8YAiZRq1Ca8pUnnxK2qONN5iHGpAqxZ7XysCYu0RcIZOkSct
	ccNyZ8msdcJwyiWXVyDEMxj8HwVusrnEdEltxaLt85X4neO8nmqqp0JIy1QsFiJHCk/9uyOjq03
	e++ENiGa7+EJZDtnbv3xCNcb2QeNg+TvTpYwvrv3S7IHjh70qEbYTXjYdIVeg/KxbZtaekbKchK
	P2DBg68rzZzOZioC+eWKblGGHi9C0W9dDXQ20EXryEHztSYU2sQS3BhA/y2lLMNgCfZqF/y31JM
	4QPTabZhjcGr4HfGVCpyuaA/xotJuiPHK7lpjaEkwAPmkfEg4cxnZ+X0esi/oz4900VtEv1wfGf
	jvIUpD2US7fr2vSCsaCYQuXQSV3gWP+h0dyEk=
X-Received: by 2002:a05:600c:a00c:b0:488:c51f:e04e with SMTP id 5b1f17b1804b1-488fb765e65mr233926825e9.13.1776765899885;
        Tue, 21 Apr 2026 03:04:59 -0700 (PDT)
X-Received: by 2002:a05:600c:a00c:b0:488:c51f:e04e with SMTP id 5b1f17b1804b1-488fb765e65mr233926275e9.13.1776765899402;
        Tue, 21 Apr 2026 03:04:59 -0700 (PDT)
Received: from [172.20.57.158] ([129.41.46.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb72d365sm172202905e9.1.2026.04.21.03.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:04:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	rostedt@goodmis.org,
	Marc Zyngier <maz@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] kernel: trace: do not generate undefsyms_base.c
Date: Tue, 21 Apr 2026 11:04:55 +0100
Message-ID: <20260421100455.324333-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code to autogenerate undefsyms_base.c in the Makefile is larger
than the file itself.

Remove the "echo" indirection that creates the file, which keeps
the build system sane and makes it much easier to edit it if/when
new situations arrive.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 kernel/trace/.gitignore       |  1 -
 kernel/trace/Makefile         | 35 ++++-------------------------------
 kernel/trace/undefsyms_base.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 32 deletions(-)
 delete mode 100644 kernel/trace/.gitignore
 create mode 100644 kernel/trace/undefsyms_base.c

diff --git a/kernel/trace/.gitignore b/kernel/trace/.gitignore
deleted file mode 100644
index 6adbb09d6deb..000000000000
--- a/kernel/trace/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-/undefsyms_base.c
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 4d4229e5eec4..1decdce8cbef 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -133,41 +133,14 @@ obj-$(CONFIG_TRACE_REMOTE) += trace_remote.o
 obj-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o
 obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
 
-#
 # simple_ring_buffer is used by the pKVM hypervisor which does not have access
 # to all kernel symbols. Fail the build if forbidden symbols are found.
-#
-# undefsyms_base generates a set of compiler and tooling-generated symbols that can
-# safely be ignored for simple_ring_buffer.
-#
-filechk_undefsyms_base = \
-	echo '$(pound)include <linux/atomic.h>'; \
-	echo '$(pound)include <linux/string.h>'; \
-	echo '$(pound)include <asm/page.h>'; \
-	echo 'static char page[PAGE_SIZE] __aligned(PAGE_SIZE);'; \
-	echo 'void undefsyms_base(void *p, int n);'; \
-	echo 'void undefsyms_base(void *p, int n) {'; \
-	echo '	char buffer[256] = { 0 };'; \
-	echo '	u32 u = 0;'; \
-	echo '	memset((char * volatile)page, 8, PAGE_SIZE);'; \
-	echo '	memset((char * volatile)buffer, 8, sizeof(buffer));'; \
-	echo '	memcpy((void * volatile)p, buffer, sizeof(buffer));'; \
-	echo '	cmpxchg((u32 * volatile)&u, 0, 8);'; \
-	echo '	WARN_ON(n == 0xdeadbeef);'; \
-	echo '}'
-
-$(obj)/undefsyms_base.c: FORCE
-	$(call filechk,undefsyms_base)
-
-clean-files += undefsyms_base.c
-
-$(obj)/undefsyms_base.o: $(obj)/undefsyms_base.c
 
+# Basic compiler and tooling-generated symbols that can safely be left
+# undefined. Ensure KASAN is enabled to avoid logic that may disable
+# FORTIFY_SOURCE when KASAN is not enabled. undefsyms_base.o does not
+# automatically get KASAN flags because it is not linked into vmlinux.
 targets += undefsyms_base.o
-
-# Ensure KASAN is enabled to avoid logic that may disable FORTIFY_SOURCE when
-# KASAN is not enabled. undefsyms_base.o does not automatically get KASAN flags
-# because it is not linked into vmlinux.
 KASAN_SANITIZE_undefsyms_base.o := y
 
 UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __x86_indirect_thunk \
diff --git a/kernel/trace/undefsyms_base.c b/kernel/trace/undefsyms_base.c
new file mode 100644
index 000000000000..e65baf58e6ff
--- /dev/null
+++ b/kernel/trace/undefsyms_base.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * simple_ring_buffer is used by the pKVM hypervisor which does not have access
+ * to all kernel symbols.  Whatever is undefined when compiling this file is
+ * compiler and tooling-generated symbols that can safely be ignored for
+ * simple_ring_buffer.
+ */
+
+#include <linux/atomic.h>
+#include <linux/string.h>
+#include <asm/page.h>
+
+void undefsyms_base(void *p, int n);
+
+static char page[PAGE_SIZE] __aligned(PAGE_SIZE);
+
+void undefsyms_base(void *p, int n)
+{
+	char buffer[256] = { 0 };
+
+	u32 u = 0;
+	memset((char * volatile)page, 8, PAGE_SIZE);
+	memset((char * volatile)buffer, 8, sizeof(buffer));
+	memcpy((void * volatile)p, buffer, sizeof(buffer));
+	cmpxchg((u32 * volatile)&u, 0, 8);
+	WARN_ON(n == 0xdeadbeef);
+}
-- 
2.53.0

