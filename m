Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046526;
	b=4StUWJZfqRWZ8j8lgCu3FEIABoM8Vg8OTn5g2s7U6aVW2tCLDv7e0eAOimX5YMtiLKS3
	 8LpUM/SaayOP3q9A7t+PnQRZZZwcjaaTosO7Zm2LFlcHrSJe4MEw9sE/9IKR4nhoESCFH
	 dbl76two6Nv8w8RcyeFefLDiBV52IIJ3GjoNV+sNLqm1ZuegSJ3s5SB9dnNlFCEf7yp7o
	 ITcRaMkP0kxKsHTzydqGBKTLG+ujnpsvdVfwc/fnUla+M+zFv+4hLP+un+Et0GxvWAa7/
	 iBC6pK0nfoelLrNIwEnPL6VjgYh8C3njlJgEKtUeWeAyY+0NjlT3j6MeR5K0jjlwKRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Kf/xUikSTcSaNla9drEguiRcgIHVSZVJsfZjqN52TlM=;
	b=h9eL7paGJWLcSVV0BFhkepTSLqR0gLCbekdd9FAQmYWjQSbWQOJuKal0Ylu8QF1rnbRk
	 gdC/cUasEKeFsuREd1NqnEA4M9ZLKysElPKdEwxJX3wYXMBDa66he0Tg8GFreGyff4aXs
	 Li9OyFZVl1VvU8osBj74mt9y2hxOiJ1QokXtS0Fuye+BuEsK2JBO3z3fo3s4eGyf49W4b
	 Zy8ffCIL7u62Kv2fRhNI4HbujtnoutT6gM8b8Oo9c8dAINbdPzeWhJYtSgiqACqz/FQth
	 33wuzo9q5GMjO2ERjhIhe5booogQBuTpcKHuuM1cQ9qKs4WgM5dp9V6kVY91u3d+zvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VtBJYuvg;
	arc=none smtp.remote-ip=209.85.160.72
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E8660A5BCF
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 00:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37E8660A5BCF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VtBJYuvg
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-47cfa971c9eso561800fac.0
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 16:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795046525; x=1795651325; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kf/xUikSTcSaNla9drEguiRcgIHVSZVJsfZjqN52TlM=;
        b=VtBJYuvgE6DA9d3Trvx/CDub8htw+jY558C/tA57TBfxaym3OEt4DsJICNdZ/uVLf6
         mc8GBF3/065gwbz0TuxO1KVzcv1Q/RDXwyi2N7UQ0SPxhhwZDh0gnR1XB+MK6fwGq4z+
         2twqHMrB9fB9SKZy4PJXOY7OFSX+gDSqwizd8CkrTnlE2p6N9fb/NzGqIKi3nF2eaOtM
         WMQLuqVOM4uFXYKgdiZ7cS6D+If3wzvCvaG/iOaAWR+a58+XigEZXcI3cHGbvwgpJkmX
         hJq2QvYGnHdjy3h1fqkDRKX+NmFdvFOh4tn0jZA4GWbxMuOcqf2YLQBKiTLZhL1sWPQs
         wwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795046525; x=1795651325;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kf/xUikSTcSaNla9drEguiRcgIHVSZVJsfZjqN52TlM=;
        b=uB5TT0chXLx5JAmMb/BuCJNgpemzDCiogAZuAjmAnji77CZ8H2UdHjQxFLLux+HL0Y
         p7fF0BAm9Ax2j0nei5nvBvKSYvgG5N/lENI3DUOhJ/sZc4WVQS+E3NZJMY0O5YJv+AJt
         udg/+gUdDXdgbDxGIyA2/O/Ub/YZ/8hZ4iUYlKh49xOKf5RsR1Rgfp/W4bMHzXKr8KTD
         3sacaKfFBGKTOQvte/QMmq5l8TMUX+hIZInJoI9NJfoqG09uubz4QNLfv8cHgNTu2cyR
         4xPgprxnRdoOsFvawWa/x2P2yTt/t6YoiCc81/m/zbYLdpyMSTZtUTPIr3Ldq2Oj0hkO
         cY7g==
X-Gm-Message-State: APuU4Z+mqByt6B2BgFJLxmpMAEtUd4LNjfBmxVVXIbvJZiU+pAmaIN6b
	B7AayfBUPqGFUP2E0RRQwHl14kveU8BnaqaWeroC5OH7n3H9WkJ3gQDikLvS1VbNkLSxMbXLvdy
	we+sLL6xHFXOab4FMMSzV3eLG9buJw16xd2zDuv8lY7h+4qFGbY3w3y6eMxpRRgdeaurLW60hBC
	3FncOvvkCfsFKqMJ6HLV6YIGW7RfUzFcbTVt05WTh/cUk=
X-Received: from ilbdz27-n1.prod.google.com ([2002:a05:6e02:441b:10b0:54b:28b4:c3d5])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2385:b0:4c2:e32c:1ee2 with SMTP id 5614622812f47-57907050044mr339534b6e.22.1795046524477;
 Wed, 18 Nov 2026 16:02:04 -0800 (PST)
Date: Thu, 19 Nov 2026 00:01:49 +0000
In-Reply-To: <20261119000151.442543-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119000151.442543-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119000151.442543-8-dmatlack@google.com>
Subject: [PATCH v2 7/8] vfio: selftests: Add helpers to print kernel warnings
 from /dev/kmsg
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add kmsg_open() and kmsg_print_warnings() to the library. kmsg_open()
opens /dev/kmsg positioned after the last message in the kernel log, and
kmsg_print_warnings() prints any kernel messages at KERN_WARNING or
higher priority that have been logged since.

Bound how much kmsg_print_warnings() reads and prints, since other
processes (e.g. tests running in parallel) may log a large number of
messages, and note in the output when messages were lost because the
kernel log wrapped. If /dev/kmsg cannot be opened, kmsg_open() prints a
message saying that kernel warnings will not be printed, so that callers
do not each need to.

This will be used in a subsequent commit to print kernel warnings to
the test log when a test triggers one, so the failure can be debugged
from the test log.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/libvfio.h      |   1 +
 .../selftests/vfio/lib/include/libvfio/kmsg.h |   8 ++
 tools/testing/selftests/vfio/lib/kmsg.c       | 134 ++++++++++++++++++
 tools/testing/selftests/vfio/lib/libvfio.mk   |   1 +
 4 files changed, 144 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/kmsg.h
 create mode 100644 tools/testing/selftests/vfio/lib/kmsg.c

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
index 07862b470777..dca9a9af961e 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
@@ -5,6 +5,7 @@
 #include <libvfio/assert.h>
 #include <libvfio/iommu.h>
 #include <libvfio/iova_allocator.h>
+#include <libvfio/kmsg.h>
 #include <libvfio/sysfs.h>
 #include <libvfio/vfio_pci_device.h>
 #include <libvfio/vfio_pci_driver.h>
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/kmsg.h b/tools/testing/selftests/vfio/lib/include/libvfio/kmsg.h
new file mode 100644
index 000000000000..9b9e89129b8f
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/kmsg.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_KMSG_H
+#define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_KMSG_H
+
+int kmsg_open(void);
+void kmsg_print_warnings(int fd);
+
+#endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_KMSG_H */
diff --git a/tools/testing/selftests/vfio/lib/kmsg.c b/tools/testing/selftests/vfio/lib/kmsg.c
new file mode 100644
index 000000000000..a25770d2247a
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/kmsg.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <syslog.h>
+#include <unistd.h>
+
+#include <libvfio.h>
+
+/* Large enough to hold any single /dev/kmsg record. */
+#define KMSG_RECORD_MAX 8192
+
+/* Limit how much is printed if the kernel logs a flood of warnings. */
+#define KMSG_PRINT_MAX 512
+
+/*
+ * Limit how many records are read, so that this terminates even if other
+ * processes are logging messages faster than they can be read.
+ */
+#define KMSG_READ_MAX 65536
+
+/**
+ * kmsg_open() - Open /dev/kmsg to read kernel messages logged from now on
+ *
+ * Open /dev/kmsg positioned after the last message currently in the kernel
+ * log, so that kmsg_print_warnings() only prints messages logged after this
+ * call. If /dev/kmsg cannot be opened, e.g. because the caller is not allowed
+ * to read the kernel log, print a message saying that kernel warnings will not
+ * be printed.
+ *
+ * Return: A file descriptor on success, or a negative errno on failure.
+ */
+int kmsg_open(void)
+{
+	int fd, ret;
+
+	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK | O_CLOEXEC);
+	if (fd < 0) {
+		ret = -errno;
+		goto out_err;
+	}
+
+	if (lseek(fd, 0, SEEK_END) < 0) {
+		ret = -errno;
+		close(fd);
+		goto out_err;
+	}
+
+	return fd;
+
+out_err:
+	fprintf(stderr,
+		"# kmsg: Failed to open /dev/kmsg (%s), kernel warnings will not be printed\n",
+		strerror(-ret));
+	return ret;
+}
+
+/**
+ * kmsg_print_warnings() - Print kernel warnings logged since kmsg_open()
+ * @fd: File descriptor returned by kmsg_open().
+ *
+ * Print all kernel messages at KERN_WARNING or higher priority that have been
+ * logged since kmsg_open() (or since the last call to this function), e.g. to
+ * provide context for a test failure caused by a kernel warning.
+ *
+ * Messages may be missing if the kernel log wrapped since they were logged,
+ * and output is limited if the kernel logged a large number of messages. A
+ * note is printed in either case.
+ */
+void kmsg_print_warnings(int fd)
+{
+	char buf[KMSG_RECORD_MAX];
+	bool truncated = true;
+	bool lost = false;
+	int printed = 0;
+	int omitted = 0;
+	int i;
+
+	for (i = 0; i < KMSG_READ_MAX; i++) {
+		char *text, *end;
+		ssize_t len;
+		int prio;
+
+		len = read(fd, buf, sizeof(buf) - 1);
+		if (len < 0 && errno == EPIPE) {
+			/* Messages were overwritten before being read. */
+			lost = true;
+			continue;
+		}
+
+		/* Stop at EAGAIN (no more messages) or on any other error. */
+		if (len <= 0) {
+			truncated = false;
+			break;
+		}
+
+		buf[len] = '\0';
+
+		/*
+		 * Each record is "<prio>,<seq>,<ts>,<flags>;<message>\n",
+		 * optionally followed by " KEY=VALUE\n" lines. See
+		 * Documentation/ABI/testing/dev-kmsg.
+		 */
+		text = strchr(buf, ';');
+		if (!text || sscanf(buf, "%d,", &prio) != 1)
+			continue;
+
+		text++;
+		end = strchr(text, '\n');
+		if (end)
+			*end = '\0';
+
+		if (LOG_FAC(prio) != LOG_FAC(LOG_KERN) || LOG_PRI(prio) > LOG_WARNING)
+			continue;
+
+		if (printed < KMSG_PRINT_MAX) {
+			fprintf(stderr, "# kmsg: %s\n", text);
+			printed++;
+		} else {
+			omitted++;
+		}
+	}
+
+	if (omitted)
+		fprintf(stderr, "# kmsg: (%d more messages omitted)\n", omitted);
+
+	if (lost)
+		fprintf(stderr, "# kmsg: (some messages were lost, see the kernel log)\n");
+
+	if (truncated)
+		fprintf(stderr, "# kmsg: (stopped reading, see the kernel log)\n");
+}
diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index eff95828719e..f8af0c14c3d0 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -5,6 +5,7 @@ LIBVFIO_SRCDIR := $(selfdir)/vfio/lib
 
 LIBVFIO_C := iommu.c
 LIBVFIO_C += iova_allocator.c
+LIBVFIO_C += kmsg.c
 LIBVFIO_C += libvfio.c
 LIBVFIO_C += sysfs.c
 LIBVFIO_C += vfio_pci_device.c
-- 
2.56.1.708.g77570a6a1d-goog

