Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B203EFD1E
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151069; cv=none; b=oM5Jvw6Kc//W4IV6oVQ+SUGPcoAihFzOQWNPy6GjBcwF0VJjdm59tB5P0FWfl7DKMTdgQE1ZkTG68ulKImqJDk+Ge9Q0DzKQyj29SPh5ox+Pn1QleBn99b5UijoReUO20HSqTm9xsXafRg2yE7Z+rgmetKC1qYYNrOMvUAonax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151069; c=relaxed/simple;
	bh=xOg2XQUdu61sT+2G91062zQbfARrtgq/PaA7i+bKeuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b1IneiRD8IVd8I7eoF7xwnUu/dXdNk3zb1vBfN5n0hhlElZUXfZW+UCnjX+AxAjtlHlC4muOb7g2iYV8nBkE+b0kPdK27fIbMs0nBda/L56O7wViudlxuSE5F4sYlW3HOk7pHpT0RR9aDBrZs/Gp69rH+FqVwX1+y3fP/nyvyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gT67iBx2; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gT67iBx2"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-41c5c1675c9so1835775fac.2
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775151067; x=1775755867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9hf8Fj5Eo8Pp1WM7FCKHr9aIVKr8I/VqWCHYJtcPZw=;
        b=gT67iBx2dNIpWDDoSq5ugFfAg4gR54J1udZxPdJ/Zs4LdEV2rJSEPn4d66rRFvw1/v
         bOIgE8kyBjRK+aLKB5bztnYcQqp8QBdIx8WyIuDToukQ5oxIpKxbmsrrNw+pTrrXCn22
         3R3Pj6qfnUwK2HVH+5IR7N8pMpYZ7GAM0c+J0Dm2pj/PWwr3HTEYAaLh6iSjwcgHDkj7
         utJ+MXYq58PiQahhflIRBeoreUyq4RaNq9D1kTCG0hvP8VLh3pYS3q1yFHiqGfgXPFKY
         zh0TOvFHzb28gj9fsD0Cn/uZYRy0W9BTuDWrSYhpVBUjZzJT4v3XfKqId98dxJafhl2b
         X7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151067; x=1775755867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9hf8Fj5Eo8Pp1WM7FCKHr9aIVKr8I/VqWCHYJtcPZw=;
        b=OfpTsvKul05U4PuuGOQ2stIunay44g4KtQdGwitc3LvcW5fEWfjgrRc8cp7tvEHx1i
         UzLUqmBdN66soDM0l4hLs0n5fk/Fgrj8En3DFu9M2El4I0oDuHyMwtT2WW8HNpMiYHP2
         PweRERpmE5HPAZ5BjSR2r7Bc8Q+XDLNKt+b5kAhYsjZU5TbOGvMBByXC35QZjCcrf7Su
         qQrFQYPoemzLWv0eeK11mncOvFzBWJkRUZC6CaYfu21QBkMHYhIihcs4AL6H6klnc9Xa
         wwVZ2SOvhm6G25gIewoFN1IqtijHgfA3D+Ge/KVdzm99UO6a6B6EhQvXXf+L2j0Ah8rV
         m7mw==
X-Forwarded-Encrypted: i=1; AJvYcCWAy0SS/5wlRL//k8stIYxhh6krbCin4S1Dr9JdHUdtK0HryNUdtuWRMBOMQBJdMNLJJI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4OJJ/xSSvPICdVljBhGsV/mFh1oEQUl+54ZhUCPAGiYdVoBZ8
	cvfdXdCsbk2Kk2cVvdvAIT2jVGI7nctvTbA1JtPDqL3NGUGfGX1T0m8gPSNDZUiTZkaN28cNDUL
	US1k66PK9LQ==
X-Received: from jatx12.prod.google.com ([2002:a05:6638:248c:b0:5d6:6409:5c6])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:3092:b0:67e:2d12:c1ef
 with SMTP id 006d021491bc7-6822034eaecmr7830eaf.54.1775151065309; Thu, 02 Apr
 2026 10:31:05 -0700 (PDT)
Date: Thu,  2 Apr 2026 17:30:54 +0000
In-Reply-To: <20260402173059.1018805-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402173059.1018805-1-rananta@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402173059.1018805-4-rananta@google.com>
Subject: [PATCH v7 3/8] vfio: selftests: Introduce a sysfs lib
From: Raghavendra Rao Ananta <rananta@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Vipin Sharma <vipinsh@google.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a sysfs library to handle the common reads/writes to the
PCI sysfs files, for example, getting the total number of VFs supported
by the device via /sys/bus/pci/devices/$BDF/sriov_totalvfs. The library
will be used in the upcoming test patch to configure the VFs for a given
PF device.

Since readlink() is quite commonly used in the lib, introduce and use
readlink_safe() to take care of potential buffer overrun errors and to
safely terminate the buffer with '\0'.

Opportunistically, move vfio_pci_get_group_from_dev() to this library as
it falls under the same bucket. Rename it to sysfs_iommu_group_get() to
align with other function names.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/libvfio.h      |   1 +
 .../vfio/lib/include/libvfio/sysfs.h          |  12 ++
 tools/testing/selftests/vfio/lib/libvfio.mk   |   1 +
 tools/testing/selftests/vfio/lib/sysfs.c      | 150 ++++++++++++++++++
 .../selftests/vfio/lib/vfio_pci_device.c      |  22 +--
 5 files changed, 165 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
 create mode 100644 tools/testing/selftests/vfio/lib/sysfs.c

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
index 1b6da54cc2cb7..07862b470777b 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
@@ -5,6 +5,7 @@
 #include <libvfio/assert.h>
 #include <libvfio/iommu.h>
 #include <libvfio/iova_allocator.h>
+#include <libvfio/sysfs.h>
 #include <libvfio/vfio_pci_device.h>
 #include <libvfio/vfio_pci_driver.h>
 
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
new file mode 100644
index 0000000000000..c1d945ea62a10
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_SYSFS_H
+#define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_SYSFS_H
+
+int sysfs_sriov_totalvfs_get(const char *bdf);
+int sysfs_sriov_numvfs_get(const char *bdf);
+void sysfs_sriov_numvfs_set(const char *bdfs, int numvfs);
+char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i);
+int sysfs_iommu_group_get(const char *bdf);
+char *sysfs_driver_get(const char *bdf);
+
+#endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_SYSFS_H */
diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index 9f47bceed16f4..b7857319c3f1f 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -6,6 +6,7 @@ LIBVFIO_SRCDIR := $(selfdir)/vfio/lib
 LIBVFIO_C := iommu.c
 LIBVFIO_C += iova_allocator.c
 LIBVFIO_C += libvfio.c
+LIBVFIO_C += sysfs.c
 LIBVFIO_C += vfio_pci_device.c
 LIBVFIO_C += vfio_pci_driver.c
 
diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/selftests/vfio/lib/sysfs.c
new file mode 100644
index 0000000000000..f1e6889556527
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/sysfs.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/limits.h>
+
+#include <libvfio.h>
+
+/* Enough to hold MODULE_NAME_LEN */
+#define DRIVER_NAME_SZ 64
+
+#define readlink_safe(_path, _buf) ({				\
+	int __ret = readlink(_path, _buf, sizeof(_buf) - 1);	\
+	if (__ret != -1)					\
+		_buf[__ret] = 0;				\
+	__ret;							\
+})
+
+static void readlink_base(const char *path, const char *data_fmt, void *out_data)
+{
+	char rl_path[PATH_MAX];
+	int ret;
+
+	ret = readlink_safe(path, rl_path);
+	VFIO_ASSERT_NE(ret, -1);
+
+	ret = sscanf(basename(rl_path), data_fmt, out_data);
+	VFIO_ASSERT_EQ(ret, 1);
+}
+
+static int sysfs_val_get_int(const char *component, const char *name,
+			     const char *file)
+{
+	char path[PATH_MAX];
+	char buf[32];
+	int ret;
+	int fd;
+
+	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/%s/%s/%s", component, name, file);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	VFIO_ASSERT_GT(read(fd, buf, ARRAY_SIZE(buf)), 0);
+	VFIO_ASSERT_EQ(close(fd), 0);
+
+	errno = 0;
+	ret = strtol(buf, NULL, 0);
+	VFIO_ASSERT_EQ(errno, 0, "sysfs path \"%s\" is not an integer: \"%s\"\n", path, buf);
+
+	return ret;
+}
+
+static void sysfs_val_set(const char *component, const char *name,
+			  const char *file, const char *val)
+{
+	char path[PATH_MAX];
+	int fd;
+
+	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/%s/%s/%s", component, name, file);
+	VFIO_ASSERT_GT(fd = open(path, O_WRONLY), 0);
+
+	VFIO_ASSERT_EQ(write(fd, val, strlen(val)), strlen(val));
+	VFIO_ASSERT_EQ(close(fd), 0);
+}
+
+static int sysfs_device_val_get(const char *bdf, const char *file)
+{
+	return sysfs_val_get_int("devices", bdf, file);
+}
+
+static void sysfs_device_val_set(const char *bdf, const char *file, const char *val)
+{
+	sysfs_val_set("devices", bdf, file, val);
+}
+
+static void sysfs_device_val_set_int(const char *bdf, const char *file, int val)
+{
+	char val_str[32];
+
+	snprintf_assert(val_str, sizeof(val_str), "%d", val);
+	sysfs_device_val_set(bdf, file, val_str);
+}
+
+int sysfs_sriov_totalvfs_get(const char *bdf)
+{
+	return sysfs_device_val_get(bdf, "sriov_totalvfs");
+}
+
+int sysfs_sriov_numvfs_get(const char *bdf)
+{
+	return sysfs_device_val_get(bdf, "sriov_numvfs");
+}
+
+void sysfs_sriov_numvfs_set(const char *bdf, int numvfs)
+{
+	sysfs_device_val_set_int(bdf, "sriov_numvfs", numvfs);
+}
+
+char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i)
+{
+	char path[PATH_MAX];
+	char *out_vf_bdf;
+
+	/* Fit "0000:00:00.0" */
+	out_vf_bdf = calloc(16, sizeof(char));
+	VFIO_ASSERT_NOT_NULL(out_vf_bdf);
+
+	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/virtfn%d", pf_bdf, i);
+	readlink_base(path, "%s", out_vf_bdf);
+
+	return out_vf_bdf;
+}
+
+int sysfs_iommu_group_get(const char *bdf)
+{
+	char path[PATH_MAX];
+	int group;
+
+	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/iommu_group", bdf);
+	readlink_base(path, "%d", &group);
+
+	return group;
+}
+
+char *sysfs_driver_get(const char *bdf)
+{
+	char driver_path[PATH_MAX];
+	char path[PATH_MAX];
+	char *out_driver;
+	int ret;
+
+	out_driver = calloc(DRIVER_NAME_SZ, sizeof(char));
+	VFIO_ASSERT_NOT_NULL(out_driver);
+
+	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/driver", bdf);
+	ret = readlink_safe(path, driver_path);
+	if (ret == -1) {
+		free(out_driver);
+
+		if (errno == ENOENT)
+			return NULL;
+
+		VFIO_FAIL("Failed to read %s\n", path);
+	}
+
+	strncpy(out_driver, basename(driver_path), DRIVER_NAME_SZ - 1);
+	return out_driver;
+}
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 1538d2b30ae59..82f255f0486dc 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -25,8 +25,6 @@
 #include "kselftest.h"
 #include <libvfio.h>
 
-#define PCI_SYSFS_PATH	"/sys/bus/pci/devices"
-
 static void vfio_pci_irq_set(struct vfio_pci_device *device,
 			     u32 index, u32 vector, u32 count, int *fds)
 {
@@ -202,24 +200,6 @@ void vfio_pci_device_reset(struct vfio_pci_device *device)
 	ioctl_assert(device->fd, VFIO_DEVICE_RESET, NULL);
 }
 
-static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
-{
-	char dev_iommu_group_path[PATH_MAX] = {0};
-	char sysfs_path[PATH_MAX] = {0};
-	unsigned int group;
-	int ret;
-
-	snprintf_assert(sysfs_path, PATH_MAX, "%s/%s/iommu_group", PCI_SYSFS_PATH, bdf);
-
-	ret = readlink(sysfs_path, dev_iommu_group_path, sizeof(dev_iommu_group_path));
-	VFIO_ASSERT_NE(ret, -1, "Failed to get the IOMMU group for device: %s\n", bdf);
-
-	ret = sscanf(basename(dev_iommu_group_path), "%u", &group);
-	VFIO_ASSERT_EQ(ret, 1, "Failed to get the IOMMU group for device: %s\n", bdf);
-
-	return group;
-}
-
 static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf)
 {
 	struct vfio_group_status group_status = {
@@ -228,7 +208,7 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	char group_path[32];
 	int group;
 
-	group = vfio_pci_get_group_from_dev(bdf);
+	group = sysfs_iommu_group_get(bdf);
 	snprintf_assert(group_path, sizeof(group_path), "/dev/vfio/%d", group);
 
 	device->group_fd = open(group_path, O_RDWR);
-- 
2.53.0.1213.gd9a14994de-goog

