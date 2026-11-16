Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847820;
	b=MVm8AF3psdeMBCt7DuPEZs1MBYtWvwqHMFbWc852nlgjOuwRgIcgQhlaEx4KWsrTKoND
	 KYYPgWTx+JzayhuHb+IfA1LbZeKkNl3kU7y5lE6YIOEG5+zWTclBGu75hqexTaWdLhTcb
	 qojeLw3vn19w1WXEdT0knZB5J2G8W8lrVueBuJ3BqDHVygKQneYRhaprXuQ3nlGbEZEMT
	 XpkYABxKU2ud82g8Ga5GzxoWuZXlvAxxq0zSVd8p0Y7AiRBNZuQcxKTkP5e5CvNxkvs8l
	 rP7ht0tZFmqOpSbbQ4XFQjqvn0i+/ffFPwwSI6aptFfqUQ4mpwpdilcNWVHkl3oz+Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847820;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=VZSzn4ITGSBB9Y8uZVgu3YecElXhFeIW1SMd8QUM9iY=;
	b=Z7vWHa1t9w2M7eBO66Qo13CdjQSHBmhzMxTD6EPQ3b5qpo5ws22jXVTPT3/xW1PXreT1
	 wvOS7ObMUFzSYUPJswhNokGKhSCyN+FPn4EoUPRzV+gNQ+hlnXE4WIyTmV2NtMHe3UNqX
	 +v876+5j9RJUAVkB6BfaFuSmk1dK9fokUpP0aqiAr1HL5EL+TPzhlR4/RCjvW8RKoBsug
	 LvccgBmtBL1KFGHRwhBEe1WX9ZeP0I/LaTpnc8zXbTe4lrwFzVcl7dWYkxJz+WGbgzmhE
	 ZjscYonNcm4EYOkki3U8bjfJpWMUCMAB26e1/cDtAoiM784zL9dCEEDINF9ni0YqIZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BA+LEjOr;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09D0606A322
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 16:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E09D0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BA+LEjOr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794847818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZSzn4ITGSBB9Y8uZVgu3YecElXhFeIW1SMd8QUM9iY=;
	b=BA+LEjOrSMu7MLEU5SgMo22ylqLwxS7ufG0+n7RLz9R+fns7Okma+V/INeFDA5qL+nLqpJ
	h60RhQhH0bMCTVgWyhS0l0Lq4FVYYvknFWs9JJQ8y7Y5xCm2W08geSAVN9ZrjBhFI8Gble
	tzgis7RC1LdA6oVP2e2z0hK/NAsMwgg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-l0QcV9AJN8mX-CotliXd1Q-1; Mon,
 16 Nov 2026 11:50:15 -0500
X-MC-Unique: l0QcV9AJN8mX-CotliXd1Q-1
X-Mimecast-MFC-AGG-ID: l0QcV9AJN8mX-CotliXd1Q_1794847812
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91B5819560B4;
	Mon, 16 Nov 2026 16:50:11 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CDB2A195B3C7;
	Mon, 16 Nov 2026 16:50:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	kvm@vger.kernel.org,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Fabiano Rosas <farosas@suse.de>,
	Alistair Francis <alistair.francis@wdc.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Stefan Weil <sw@weilnetz.de>,
	Peter Xu <peterx@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v2 1/7] debug/mem: add utility to name anonymous memory mappings
Date: Mon, 16 Nov 2026 11:49:56 -0500
Message-ID: <20261116165002.30939-2-jsnow@redhat.com>
In-Reply-To: <20261116165002.30939-1-jsnow@redhat.com>
References: <20261116165002.30939-1-jsnow@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add support to name mmap'd memory regions using
PR_SET_VMA_ANON_NAME. On unsupported platforms, these QEMU utility
functions are no-ops.

This is useful primarily for debugging and profiling QEMU; being able
to see and correlate each VMA segment with a specific use within QEMU.

Support for PR_SET_VMA_ANON_NAME was added in Linux 5.17, and requires
CONFIG_ANON_VMA_NAME=y to be set in the kernel configuration. Fedora
(and RHEL) do not enable this feature by default. See also
https://man7.org/linux/man-pages/man2/pr_set_vma.2const.html

Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/qemu/mmap-vma.h | 18 +++++++++++
 util/mmap-vma.c         | 71 +++++++++++++++++++++++++++++++++++++++++
 util/meson.build        |  1 +
 3 files changed, 90 insertions(+)
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
index 00000000000..7a50965d496
--- /dev/null
+++ b/util/mmap-vma.c
@@ -0,0 +1,71 @@
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
+    int rc;
+    va_list args;
+
+    va_start(args, fmt);
+    rc = qemu_vname_vma(ptr, sz, fmt, args);
+    va_end(args);
+
+    return rc;
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
2.56.1

