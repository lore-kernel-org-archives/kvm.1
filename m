Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250763;
	b=YyEOYxR9/lXjwjw8oVc2iq4h5Hov8IGIt6PI/zlz92wNA9SJ0LxOtW9FcuM7p2lHYpHM
	 B4xfi3a9fcGrqeWSx/e9uy1kKSLduxrX3FhQ16kxXk4sgDnq0jT9RONe4eI3vs7QkKZOv
	 jkTyXY7l8MaIM7DmNyb0tfJ+BqAiS2OEf9jDB32qK8m9LgKbFFEmoUGEW1QYA7lSuT55s
	 oxhAt7WL5i9vnep3A4R9XNhe/q6sHl8df0V+Vff54vyALuNhdua2rF3qDmmkI5DCArLsm
	 BvHRwnDhbOxDMoTxBEnVVioVgMcL1UhjJ1DEHjb2PcbjOyULQYNFUSVaVd5rVLn448A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250763;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=p/W6/kz7VuD287OKmOjU7aNE//F1vy6wR+oe/2sb3P4=;
	b=cuQIVYLie7qDsJb5uAmixekFHY5fhfMBLBiq+V8bHVsBkUf6IFV9vx6wfFBRF/XCRQLO
	 ptP0VCJ/D0bIwVbpGcKhKev0itArh9cuPHSfFcVMU8IbnddGSoXyr9ZR8NJeLaI/HNz+s
	 Xu86juWKHMzzyHZB10hiZbzO8iYCkm8ulGaqAzrUNrm4d0Wt1A9+l0KZlfd5OZq3FmaEu
	 Uk6lmXUT7QCDlD7YWKadZTiq8ixtM/Th7vtwydQ1PXGBbCI5kXPUaDynUBFQssfVROK2k
	 w7fNtb5l6FgffA7YPrzVcHz/IsLYF1HUxZ7xNYZZaVAP07Br/uscOFDvP0y/Ox2uKsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bt5GGm6Y;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28987606A321
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 18:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28987606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bt5GGm6Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794250762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/W6/kz7VuD287OKmOjU7aNE//F1vy6wR+oe/2sb3P4=;
	b=Bt5GGm6YRhyY/07GZWh+Ide2NzmiGyG/AY2u1VHdQFCGl6H1ZA6tRgdGmiagELA3M9my7P
	ASGNsed1MR00y2LaWhGBxg0/aSUSZ0qLMoOHHkHfmgLVmYZ0EsA5f6C2xi4DjE1FOkgNYg
	+H74o6UNzQtHyE8yUgpQ56+Owhsco7Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-Uu7lIUJtOUmgZqlUQ2aYAw-1; Mon,
 09 Nov 2026 13:59:18 -0500
X-MC-Unique: Uu7lIUJtOUmgZqlUQ2aYAw-1
X-Mimecast-MFC-AGG-ID: Uu7lIUJtOUmgZqlUQ2aYAw_1794250757
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 043061800660;
	Mon,  9 Nov 2026 18:59:16 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 017891956089;
	Mon,  9 Nov 2026 18:59:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Alistair Francis <alistair.francis@wdc.com>,
	Stefan Weil <sw@weilnetz.de>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 1/7] debug/mem: add utility to name anonymous memory mappings
Date: Mon,  9 Nov 2026 13:59:01 -0500
Message-ID: <20261109185907.3220584-2-jsnow@redhat.com>
In-Reply-To: <20261109185907.3220584-1-jsnow@redhat.com>
References: <20261109185907.3220584-1-jsnow@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add support to name mmap'd memory regions using
PR_SET_VMA_ANON_NAME. On supported platforms, the QEMU utility
functions are no-ops.

This is useful primarily for debugging and profiling QEMU; beind able
to see and correlate each VMA segment with a specific use within QEMU.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/qemu/mmap-vma.h | 18 +++++++++++
 util/mmap-vma.c         | 67 +++++++++++++++++++++++++++++++++++++++++
 util/meson.build        |  1 +
 3 files changed, 86 insertions(+)
 create mode 100644 include/qemu/mmap-vma.h
 create mode 100644 util/mmap-vma.c

diff --git a/include/qemu/mmap-vma.h b/include/qemu/mmap-vma.h
new file mode 100644
index 00000000000..763ea5a5cab
--- /dev/null
+++ b/include/qemu/mmap-vma.h
@@ -0,0 +1,18 @@
+/*
+ * Utility for naming VMA allocations in linux
+ *
+ * Copyright (c) Red Hat, Inc 2026
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef __QEMU_MMAP_VMA_H
+#define __QEMU_MMAP_VMA_H
+
+#include <stddef.h>
+#include "osdep.h"
+
+int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
+    G_GNUC_PRINTF(3, 4);
+
+#endif
diff --git a/util/mmap-vma.c b/util/mmap-vma.c
new file mode 100644
index 00000000000..7dcef3b7455
--- /dev/null
+++ b/util/mmap-vma.c
@@ -0,0 +1,67 @@
+/*
+ * Utility for naming VMA allocations in linux
+ *
+ * Copyright (c) Red Hat, Inc 2026
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#include "qemu/mmap-vma.h"
+#include "qemu/osdep.h"
+
+#include <errno.h>
+#include <stddef.h>
+#include <stdio.h>
+
+#if defined(__linux__)
+#include <sys/prctl.h>
+#endif
+
+#define VMA_PREFIX " qemu: "
+#define VMA_MAXLEN 80
+
+/*
+ * Give a human-readable name to a previously mmap'd memory segment.
+ * This feature is only available on Linux >= 5.17, and only when the
+ * kernel was configured with CONFIG_ANON_VMA_NAME=y.
+ *
+ * For systems without this option, prctl() will return -1 and set
+ * errno to EINVAL, and can be safely ignored.
+ *
+ * For systems with this option, these human-readable names will be
+ * visible in /proc/$pid/[s]maps, pmap output, etc.
+ */
+G_GNUC_PRINTF(3, 0)
+static int qemu_vname_vma(void *ptr, size_t sz, const char *fmt, va_list args)
+{
+    int rc = 0;
+
+#if defined(PR_SET_VMA_ANON_NAME)
+    char strbuf[VMA_MAXLEN];
+
+    assert(sizeof(VMA_PREFIX) < sizeof(strbuf));
+    strncpy(strbuf, VMA_PREFIX, sizeof(strbuf));
+    rc = vsnprintf(strbuf + sizeof(VMA_PREFIX),
+                   sizeof(strbuf) - sizeof(VMA_PREFIX), fmt, args);
+    if (rc < 0) {
+        return -errno;
+    } else if (rc >= (sizeof(strbuf) - sizeof(VMA_PREFIX))) {
+        sprintf(strbuf + sizeof(strbuf) - 4, "...");
+    }
+
+    rc = prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr, sz, strbuf);
+    if (rc) {
+        return -errno;
+    }
+#endif
+
+    return rc;
+}
+
+G_GNUC_PRINTF(3, 4)
+int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
+{
+    va_list args;
+
+    va_start(args, fmt);
+    return qemu_vname_vma(ptr, sz, fmt, args);
+}
diff --git a/util/meson.build b/util/meson.build
index fa174c07a57..861ee228d5b 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -1,5 +1,6 @@
 util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
 util_ss.add(files('thread-context.c'), numa)
+util_ss.add(files('mmap-vma.c'))
 if host_os != 'windows'
   util_ss.add(files('aio-posix.c'))
   util_ss.add(files('fdmon-poll.c'))
-- 
2.56.0

