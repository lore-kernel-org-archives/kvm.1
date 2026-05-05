Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D594963DD
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016526; cv=none; b=eDDThHlQzEJS0Qtrp60g9oN6JyeP414I0k97w8Kpcjm59JI5osEJxPIq9KQx0Vs+eBS9XaYGqkWO6+kxMMZmYkeaNcpkHVKKCtccr9r7xa7uYFFMrecQOj3F6cUWCYcFFLKjGQTl6rgpzrjLpTwRTAxrGy+KEThyoOt+mWL85CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016526; c=relaxed/simple;
	bh=IcgJrFNktyNPn1dfHtLJq09UgzpIZjt0gqU9505v6Hg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CWyQCb5dOVs2qtW6fBJrjbFHYcfx41dHOsCtK78tNbQceojE4vWmm5iVgBGcDE5I5go+LAoSNFT5deZhFwva16wk6FQrhevRw4tnIVpOOxsHCTED5U08/S0FTfRRwOXX5ePDu2+BZP5ClHffogoMyNEkihJ7z6ogiS8cm46zsik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBr3Bmt4; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBr3Bmt4"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-69677d248a4so9192451eaf.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 14:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778016523; x=1778621323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/NAaMUewODgHwyC7Y4Tcis2yg7tI8JXbAhWmt5KiHQ=;
        b=fBr3Bmt4GDKJ9UjU78mX7D+bFXVo28WbLicdFW/ZZqfR3GxfXNBGTa1CQ+1mrx8tbd
         px7QuNr3/yT5eHKoDkm8CnhNPwYOux+ckNKviwnjX+7MbcWhemO5thhptOFjPmtT9obL
         yuMrQHlyRgZ1cD2DCBEH+iTYfgN2Y56NB5H1WGF4YF/iy/5ghYShxV6ivGM+9Cc9Y1Mq
         YqJIQFIIWX8+Doa923bRQgJ9x8Tc9MwyUFZ+FR/h0XdT3z4dCN5q6ajc7h5yI6XDqgON
         oArHCU7OlRf6pUssMjVpRxd8pCpsiUhUlEnxqdFABDBX4mJscsJp4tj11AlmMwLcGzOJ
         afcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016523; x=1778621323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/NAaMUewODgHwyC7Y4Tcis2yg7tI8JXbAhWmt5KiHQ=;
        b=DFCWjY7q6GQJXpxog/rOnHdoeUpIZbIrR+ha/Q9MAYsTss9+d2JCtH9mOnipM2dEBq
         JXWrJWl8m+Oyj4Klj0GTDrfKFgJ5Kt4h0jm0IZsI/cMUAU1uI9HpkxCxUkh5X3nXARbD
         hF1o0c8vNv5vDYRD1/7oajQc+hQigHrcKU1ot5Mfjf02r8P/Y5/4WhXNy1wiAMS2mldr
         mC7DZH/1/Qg4tNKSLR3YauHWWTZSQ2A5wXAjfl2ns3UgOzHQI2bbp77ERT9/wCR/3Bap
         UJySw9oXeLJGoPFux0wceMmibdpO5e8fsbrXdtackevnb39LCbL2rfbZpiNGYcO/7jsJ
         mDcw==
X-Forwarded-Encrypted: i=1; AFNElJ+ioxr7RgOcDykI0IRETUCuOp8nPlxpC32ALXagV49D5sebuUEZhQNhQ0Ywr3DJ9jk6Eu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4hlC672Sa9xAMm0c83PO3iqSdKSzPUt96dw5oD1rRYKtlEE+F
	h0TUG+WJEQTp6yekagYehTM7GJqjZrJ/czoKExpWc+TE7MvYxVl5BJAxFOimJg0/MfekszcQ1HB
	jw1OeaC0Wyg==
X-Received: from ilaj28.prod.google.com ([2002:a05:6e02:219c:b0:4fb:4caf:c442])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:4dc4:b0:694:9b71:3745
 with SMTP id 006d021491bc7-69998d609b7mr345111eaf.57.1778016523340; Tue, 05
 May 2026 14:28:43 -0700 (PDT)
Date: Tue,  5 May 2026 21:28:33 +0000
In-Reply-To: <20260505212838.1698034-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505212838.1698034-1-rananta@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505212838.1698034-4-rananta@google.com>
Subject: [PATCH v8 3/8] vfio: selftests: Introduce a sysfs lib
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
index 0000000000000..c9ab1ea8f5a9c
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_SYSFS_H
+#define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_SYSFS_H
+
+int sysfs_sriov_totalvfs_get(const char *bdf);
+int sysfs_sriov_numvfs_get(const char *bdf);
+void sysfs_sriov_numvfs_set(const char *bdf, int numvfs);
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
index 0000000000000..11415448b2e29
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
+#define readlink_safe(_path, _buf) ({					\
+	int __ret;							\
+									\
+	_Static_assert(!__builtin_types_compatible_p(			\
+		__typeof__(_buf), char *),				\
+	    "readlink_safe: _buf must be an array, not a pointer");	\
+									\
+	__ret = readlink(_path, _buf, sizeof(_buf) - 1);		\
+	if (__ret != -1)						\
+		_buf[__ret] = 0;					\
+	__ret;								\
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
+	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/driver", bdf);
+	ret = readlink_safe(path, driver_path);
+	if (ret == -1) {
+		if (errno == ENOENT)
+			return NULL;
+
+		VFIO_FAIL("Failed to read %s\n", path);
+	}
+
+	out_driver = strdup(basename(driver_path));
+	VFIO_ASSERT_NOT_NULL(out_driver);
+
+	return out_driver;
+}
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index efbf9ab63cea7..80e8e5bebd7ca 100644
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
@@ -204,24 +202,6 @@ void vfio_pci_device_reset(struct vfio_pci_device *device)
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
@@ -230,7 +210,7 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	char group_path[32];
 	int group;
 
-	group = vfio_pci_get_group_from_dev(bdf);
+	group = sysfs_iommu_group_get(bdf);
 	snprintf_assert(group_path, sizeof(group_path), "/dev/vfio/%d", group);
 
 	device->group_fd = open(group_path, O_RDWR);
-- 
2.54.0.545.g6539524ca2-goog

