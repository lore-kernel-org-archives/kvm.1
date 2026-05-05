Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F963494A18
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016525; cv=none; b=LvmvBL63q1/EMN55gRRHBV9rcr6OTmsh46Y0EsD0JJ+IfqtCvx4qpNAh5XesdeDXUEvsD2p6iCEJky+Ti0zdYQfXW4rlrq6EowpYwr64lrrhalnzNPQOYYnzj6f0ljhA0ZVWZ5KZaYCEjVaYcyerDcguOSeEBrv0ve1wwYL9Gew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016525; c=relaxed/simple;
	bh=haQ+V/eSVuPh98JTXE41z2vcTYc/ehzcvVHagcUNwEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cxr0AHE7suUO3bT2/kQU1tRKbflMyCP/9LW1tcyH/hWI8UQQXubZ+zcLQGfmwn7GL1QSnSK6J0RvkjJqfgAe3pi9GG+UIz4Y1VKDvkRsGJ6p+SpD1JvpSDP+OXA4N0VOvtsHoRQF44mC+1rCN4CO9qQMs5rz4omz1HbBbN7r1f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=piGxjUqk; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piGxjUqk"
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7dcc8f071b3so11448800a34.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 14:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778016522; x=1778621322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5unDfi3wJ1sRon+uGFErvJbzVefhiGwdX/c5VDstEAQ=;
        b=piGxjUqkHtI8JI6AaP6iPEv1m+1tt/AiHuC/b8s66Q3u3vhFM9SaS4q6WgZMrwbnSW
         KR+wsZqfsgxCXCE4JNZ0Xu1SeNa52YqW/EnbW48GgvZqmf4eGGvc3BaeqTMItA8C9EJW
         FQKfdig+z0oZh8KUXjcmDpAQ2qGCr39+KZnTgCo7EYW4Rzwmray1Qk63EdNuL1H0dBqX
         RSntPB1xi62Bs86AXBoZtbwOzg9mL/gFpDTGN9hxjuGhHO0rm2y+5WY1K2cnkDVqBIzA
         +4RY9ELI5RyIIafb3nh/J9rT6EI6OalPbTUgH2bQPA0yfIJ15px87bt2mOmnxXflcSf8
         kBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016522; x=1778621322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5unDfi3wJ1sRon+uGFErvJbzVefhiGwdX/c5VDstEAQ=;
        b=R7hwImPzjyKU1mP55cyJ3AcwUTLDJSW+PaOn5pSPtPmCmhBq4kPxTbKuZbxZdoz+kB
         MoL1207v/ZjfcBbrYmSOpS/TRVl8PcOvddOEhdhZLu4ROse5daxVxrnMW1iVnNSqSRz+
         Rl2BHEHiQO98/tEJ0EovnDrRDPlVM6d58MpOS5/DsTe33VstQOqB3AKlQnEYMp37NoBX
         u3LB3lEyX9vSbXPL0TdbtCFixu6TRkA9Az3NYJWusg2tszlnRlrtqtVNfgoNfqBqfDi6
         1lhUwB7cWDAK705HnV87fpFt/aLdtVnj6oEmyXbUYIkaZRQkoeQGTXQIk/EmAcl7TQEW
         YHNg==
X-Forwarded-Encrypted: i=1; AFNElJ8sa2aB/IlYQ6zrsTjQb1/mZ9Z3tvzp583wJhjc9t8pxUBNBH+mMYUL667/TjtOvsdbS1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjIyGf15a4uSkMQKgdZC0Yl8dyEh2NFTeMokp0ZoYl3pKC5PUI
	LeGw6nN0yJUsA+lUZgxBBS+/rQxzuM7oKPlXLprp2Ud3doxnCntw1Kzz8qngk04qvXfWpebuj8D
	bkkZL4rQrJA==
X-Received: from iobb8.prod.google.com ([2002:a05:6602:2188:b0:964:7981:da07])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:4c06:b0:694:914f:c18f
 with SMTP id 006d021491bc7-69998cbc0d4mr330922eaf.3.1778016522423; Tue, 05
 May 2026 14:28:42 -0700 (PDT)
Date: Tue,  5 May 2026 21:28:32 +0000
In-Reply-To: <20260505212838.1698034-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505212838.1698034-1-rananta@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505212838.1698034-3-rananta@google.com>
Subject: [PATCH v8 2/8] vfio: selftests: Introduce snprintf_assert()
From: Raghavendra Rao Ananta <rananta@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Vipin Sharma <vipinsh@google.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce snprintf_assert() to protect the users of snprintf() to fail
if the requested operation was truncated due to buffer limits. VFIO
tests and libraries, including a new sysfs library that will be introduced
by an upcoming patch, rely quite heavily on snprintf()s to build PCI
sysfs paths. Having a protection against this will be helpful to prevent
false test failures.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/assert.h         |  5 +++++
 .../selftests/vfio/lib/vfio_pci_device.c      |  8 +++----
 .../selftests/vfio/vfio_dma_mapping_test.c    |  6 +++---
 .../selftests/vfio/vfio_pci_device_test.c     | 21 ++++++++++---------
 4 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
index f4ebd122d9b6f..77b68c7129a64 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
@@ -51,4 +51,9 @@
 	VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
 } while (0)
 
+#define snprintf_assert(_s, _size, _fmt, ...) do {                      \
+	int __ret = snprintf(_s, _size, _fmt, ##__VA_ARGS__);           \
+	VFIO_ASSERT_LT(__ret, _size);                                   \
+} while (0)
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_ASSERT_H */
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index fc75e04ef010c..efbf9ab63cea7 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -211,7 +211,7 @@ static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
 	unsigned int group;
 	int ret;
 
-	snprintf(sysfs_path, PATH_MAX, "%s/%s/iommu_group", PCI_SYSFS_PATH, bdf);
+	snprintf_assert(sysfs_path, PATH_MAX, "%s/%s/iommu_group", PCI_SYSFS_PATH, bdf);
 
 	ret = readlink(sysfs_path, dev_iommu_group_path, sizeof(dev_iommu_group_path));
 	VFIO_ASSERT_NE(ret, -1, "Failed to get the IOMMU group for device: %s\n", bdf);
@@ -231,7 +231,7 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	int group;
 
 	group = vfio_pci_get_group_from_dev(bdf);
-	snprintf(group_path, sizeof(group_path), "/dev/vfio/%d", group);
+	snprintf_assert(group_path, sizeof(group_path), "/dev/vfio/%d", group);
 
 	device->group_fd = open(group_path, O_RDWR);
 	VFIO_ASSERT_GE(device->group_fd, 0, "open(%s) failed\n", group_path);
@@ -302,7 +302,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 	cdev_path = calloc(PATH_MAX, 1);
 	VFIO_ASSERT_NOT_NULL(cdev_path);
 
-	snprintf(dir_path, sizeof(dir_path), "/sys/bus/pci/devices/%s/vfio-dev/", bdf);
+	snprintf_assert(dir_path, sizeof(dir_path), "/sys/bus/pci/devices/%s/vfio-dev/", bdf);
 
 	dir = opendir(dir_path);
 	VFIO_ASSERT_NOT_NULL(dir, "Failed to open directory %s\n", dir_path);
@@ -312,7 +312,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 		if (strncmp("vfio", entry->d_name, 4))
 			continue;
 
-		snprintf(cdev_path, PATH_MAX, "/dev/vfio/devices/%s", entry->d_name);
+		snprintf_assert(cdev_path, PATH_MAX, "/dev/vfio/devices/%s", entry->d_name);
 		break;
 	}
 
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index abb170bdcef7e..7d0de8c79de13 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -44,9 +44,9 @@ static int intel_iommu_mapping_get(const char *bdf, u64 iova,
 	FILE *file;
 	char *rest;
 
-	snprintf(iommu_mapping_path, sizeof(iommu_mapping_path),
-		 "/sys/kernel/debug/iommu/intel/%s/domain_translation_struct",
-		 bdf);
+	snprintf_assert(iommu_mapping_path, sizeof(iommu_mapping_path),
+			"/sys/kernel/debug/iommu/intel/%s/domain_translation_struct",
+			bdf);
 
 	printf("Searching for IOVA 0x%lx in %s\n", iova, iommu_mapping_path);
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 7c0fe8ce3a61f..93c11fd5e0818 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -39,16 +39,17 @@ FIXTURE_TEARDOWN(vfio_pci_device_test)
 	iommu_cleanup(self->iommu);
 }
 
-#define read_pci_id_from_sysfs(_file) ({							\
-	char __sysfs_path[PATH_MAX];								\
-	char __buf[32];										\
-	int __fd;										\
-												\
-	snprintf(__sysfs_path, PATH_MAX, "/sys/bus/pci/devices/%s/%s", device_bdf, _file);	\
-	ASSERT_GT((__fd = open(__sysfs_path, O_RDONLY)), 0);					\
-	ASSERT_GT(read(__fd, __buf, ARRAY_SIZE(__buf)), 0);					\
-	ASSERT_EQ(0, close(__fd));								\
-	(u16)strtoul(__buf, NULL, 0);								\
+#define read_pci_id_from_sysfs(_file) ({					\
+	char __sysfs_path[PATH_MAX];						\
+	char __buf[32];								\
+	int __fd;								\
+										\
+	snprintf_assert(__sysfs_path, PATH_MAX, "/sys/bus/pci/devices/%s/%s",	\
+			device_bdf, _file);					\
+	ASSERT_GT((__fd = open(__sysfs_path, O_RDONLY)), 0);			\
+	ASSERT_GT(read(__fd, __buf, ARRAY_SIZE(__buf)), 0);			\
+	ASSERT_EQ(0, close(__fd));						\
+	(u16)strtoul(__buf, NULL, 0);						\
 })
 
 TEST_F(vfio_pci_device_test, config_space_read_write)
-- 
2.54.0.545.g6539524ca2-goog

