Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C03D7D96
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151067; cv=none; b=fFLIgbYvFc07r/w3NpJqoZyQK6kA+UQ/8/fsauH7LD17zipDyy6G2P2Gb1u39lQxwGyF1iUKfBpfENx4K0mNKR42XBVm6Ktkb9C6HHu3yyvRaMZaKSAHvdf0TAdQibcuKBhnhYj/oksjkCQpsYjCNs8uFb/Zzr4F0+Tom1sZ0nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151067; c=relaxed/simple;
	bh=8HVoR5cd52fPXzFWtfK66AFBeWL0bKkn7rRvDwCk50g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=InVWp9ZcW1EJZXDtI+wQj2kOefzoCiicIoTSebBzHSWRBckZ2wbbiDa6qWfRdVD/aDNGyRQFAFrU821GjaO3fQ2DWyqAjVf5UlKxKRBM63QWA9vFO+a8UOK6+i7RZ8igm9QlrNTIVrt8E2fN0EdLMo7X3FegEM2qsM9eRh+vKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPjsUJQ8; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPjsUJQ8"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-67c7f139d4aso3392712eaf.3
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775151064; x=1775755864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIFGgzex0DVn9nBXSWjs3Yu5GHhJ8YfSqgclQSiXhzQ=;
        b=tPjsUJQ8cWfOOrGvVD4R+gEZTX+AF/IY3GhiwwaiOuzcDOuGXi554llf3Mxiw1LdjS
         0JDcZ+FdQY9AojVCjMOd4SJ8jetCUkaYOB3yfBnJYpBeR8vjz3Pc5HqNEofIIZIW6jbF
         qFCnnAgyw3uTFul6bOSuKuRcf+Jyd3rW7wdZ6fZBy+QLcrVQo5nL3Y7gwSpgIYLt7Omf
         HCPk5gDcXI+SqzM/izdUMpz5U7sCBk7WTOiLsI8U03LilOJ8FkKNhC0s2/Ej9VVamnX6
         LgPXYnh/9jDt4Q0mx9/omVfPBvc9WhuwRtwuRWJEknSvje2K5PXqZnuke6yNuxY5y2um
         NbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151064; x=1775755864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIFGgzex0DVn9nBXSWjs3Yu5GHhJ8YfSqgclQSiXhzQ=;
        b=KDgC+gZHmTjoTdutGIj0nxO/rmrgMbLmK7NRIQ5zc7GRA2PNzS0AAcIO23ePZp5mD9
         T1sg3SrGyDf25IM0Kww2Rk03ykAEkePtc5o7ntG2/6XVZPB+M3nepQ9qmqEiXWupPxfj
         uqinp48s713z0aH7mKEv2FYeUCIlTPajxnvq+KPzcvhvniQDd9eDW4Am5MVSxO+T1ADy
         Y/vcRKwK/4/tgEnzuotiJF8VXIVSfQgqdnW9TVZS1wVo7qtriKsl/ujG0D7A+ct9t7+W
         jdnh47IZN3EtP/gUQEj00BOWe/XRFunZS/VeXAQAXPHWcYGQzvK6qkCR5y92FwupGscz
         QnCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXmlHkKjBEqfXF6da+YTdezyduYrV3NqUkC6gT0cOC7kVzndP1H+Pmw4t69RlJwzW1uQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8BBqTlUD+BBJaVeSwH9xJnHHyu0W3rPwmT8nk3lX8z+MbOpQ2
	Pqh1giLZAguFV2Dm/znpSA8YnWuZ0g7Fx1+oYTLIGUzww8kIDgO2ImwI3M0o1WARRja+3lJLPSr
	1PkKo6EY8ow==
X-Received: from jaan28-n2.prod.google.com ([2002:a05:6638:aadc:20b0:5d6:9ff5:de3a])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:c8d:b0:67b:decf:eef3
 with SMTP id 006d021491bc7-6821f57e22emr11803eaf.37.1775151064489; Thu, 02
 Apr 2026 10:31:04 -0700 (PDT)
Date: Thu,  2 Apr 2026 17:30:53 +0000
In-Reply-To: <20260402173059.1018805-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402173059.1018805-1-rananta@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402173059.1018805-3-rananta@google.com>
Subject: [PATCH v7 2/8] vfio: selftests: Introduce snprintf_assert()
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
index 4e5871f1ebc3b..1538d2b30ae59 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -209,7 +209,7 @@ static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
 	unsigned int group;
 	int ret;
 
-	snprintf(sysfs_path, PATH_MAX, "%s/%s/iommu_group", PCI_SYSFS_PATH, bdf);
+	snprintf_assert(sysfs_path, PATH_MAX, "%s/%s/iommu_group", PCI_SYSFS_PATH, bdf);
 
 	ret = readlink(sysfs_path, dev_iommu_group_path, sizeof(dev_iommu_group_path));
 	VFIO_ASSERT_NE(ret, -1, "Failed to get the IOMMU group for device: %s\n", bdf);
@@ -229,7 +229,7 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	int group;
 
 	group = vfio_pci_get_group_from_dev(bdf);
-	snprintf(group_path, sizeof(group_path), "/dev/vfio/%d", group);
+	snprintf_assert(group_path, sizeof(group_path), "/dev/vfio/%d", group);
 
 	device->group_fd = open(group_path, O_RDWR);
 	VFIO_ASSERT_GE(device->group_fd, 0, "open(%s) failed\n", group_path);
@@ -300,7 +300,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 	cdev_path = calloc(PATH_MAX, 1);
 	VFIO_ASSERT_NOT_NULL(cdev_path);
 
-	snprintf(dir_path, sizeof(dir_path), "/sys/bus/pci/devices/%s/vfio-dev/", bdf);
+	snprintf_assert(dir_path, sizeof(dir_path), "/sys/bus/pci/devices/%s/vfio-dev/", bdf);
 
 	dir = opendir(dir_path);
 	VFIO_ASSERT_NOT_NULL(dir, "Failed to open directory %s\n", dir_path);
@@ -310,7 +310,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
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
2.53.0.1213.gd9a14994de-goog

