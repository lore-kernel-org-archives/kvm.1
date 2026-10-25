Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894799;
	b=dXmrXeG3ogb3IhO02s/BmgakOc1+u41AXAapzJXgNqf8AABUygkTst8GtSKVr+zksPdd
	 Cp5YJEmKMUcURyOBIFdQ47PWrg2b3rAPmXZEYxTu1QURMvN6yE5XJC6IwXVKnJ2CD+kHz
	 7WxoPATdfWLu4+rm1e2g5m7WKGiAeUz0TwhKZzzJyQVmIamQ2bj+ZJrZiojm63O7zWm4o
	 EOojJFELTLrNJT/xqKHlP0pXXQTM1LYushSc2KMejAgSihd4EzvO1DaZhLOjlXedM9P09
	 UP1T/AprT/1J0pnsJXb35WtaJNJsFZcJRVXdLdXsbgpZ4hpi/YTrWMQMnd900xKeU0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=jfTqkHTNAVdeBbNAB2ZAPNmrXK45mQAy9lzoICGts/Y=;
	b=2JenR/MlGLnwmKfxamIA7aqe6mhdIzmpTgs1OqAkvUFB7OINud36zbQpvib8keKtxZpJ
	 MgoINGGwG7J6C61wXQ0OKicaP25pg2ay57sRacd2Wri6tayC2gUmAHIb99mEXhKir7mDb
	 eff9Ct3RGKdbpbIPUJaWIPVK1mxwsMnePgqGMNKW2ecymZM/mKSVWFccNnIKF3g27Dy/Q
	 f+z9kFi3HN1RS3MET21OA350rfWN+IaN4ppjyphdXHd/LW7eHVugc4zEzavZ6aeFY7ZLj
	 R/XOKSAMtKmkbn0iwReUghZWoCo/cAky/MavSYPVVZLldQ7hZbgsqN6SGP0KZ02hKLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rkCTRyoa;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2078A606E6A7
	for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 02:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2078A606E6A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rkCTRyoa
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e869e00005so30391735ad.2
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 19:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792894798; x=1793499598; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jfTqkHTNAVdeBbNAB2ZAPNmrXK45mQAy9lzoICGts/Y=;
        b=rkCTRyoaO0X2kLE2qlYY/OH0mOIaZdrYj1QbQwctC6TSALgR7HrkAiezUW/nlr3tZ1
         nGq2QoM9tbUvT2lBzoeZfb32QQgE7gScVve7QYFWi8vBAmrirOwjylelyFNM7kwR5YVe
         P+m64qRL5K3G/PFMfmi29IicoSh9orU2gC7p01/YBIOdQgzpeC34inW8SwBHSlGZQ/CQ
         RqRG/NEMayt4l5nsHPuzacEpfzhd2kgdsHP2M6pwzlNKcHYiIdVPBW8n6yVXKqyUzKlS
         IeduALKrBU5lJlfQ19JaZVqq7FtbnUCcmVlNbdUgqbulNO5aeFtGLNFFiw6VE5nEzsGu
         jRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894798; x=1793499598;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jfTqkHTNAVdeBbNAB2ZAPNmrXK45mQAy9lzoICGts/Y=;
        b=iZrtW8vQLzBEDB00sUtogo3uBU5WA8euaWmwZk2HLkrrFBAKxC9gdY7gLhnm82kIr8
         Llt82KKz7GvggJ2Dqx/5LxBN9Wh1z+ZXKnljeEXdLC/TPB+/wofqCwSEeLrZQ4RuwLGT
         G4TySzlIcqpGMiy+chcGV44bI8fNy9+RxgnEBqnYECtzFheyvoAViO9fnuLF8hGgP1NR
         XTmKgJSz4FQIT9u8s78U4syUnAqHcjjKFvZs9lzvGCba9RghOeyvyBBgJUoxaUPixo8+
         +j/Xn+T5dnhq2qxqHVKLOPGmQMbR+0EDhzmMs0QElezVgL5oOepFCkFnA6UV7IBRocKM
         ZPsA==
X-Forwarded-Encrypted: i=1; AKwUvByIbyJf0pudVwoPiauWaPHbvTeMbnYXc7jQ+cf3zksnMnlCwQzVxCFfe/X5RHqRRWbkbe0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIX2uBw+mls+RlT6AaHHoyB3515sG/FEQyxCZPIiRu6x4lcpsZq
	2MnnkpMGvmm/cN1UBPkmc/0H4vsP3WIjYfaiwOaUzQg7uG1Xy9CxuUkLhYl4+808fzJYk1WsJjj
	EsXgUe+k34zQU6A==
X-Received: from plbmf8.prod.google.com ([2002:a17:902:fc88:b0:2e5:ffbf:77d8])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ffcf:b0:2e8:3190:73a with SMTP id d9443c01a7336-2ea9c8c0eb9mr25247635ad.58.1792894798264;
 Sat, 24 Oct 2026 19:19:58 -0700 (PDT)
Date: Sun, 25 Oct 2026 02:19:29 +0000
In-Reply-To: <20261025021930.674647-1-skhawaja@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025021930.674647-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261025021930.674647-19-skhawaja@google.com>
Subject: [PATCH v6 18/18] iommufd/selftest: Add test to verify iommufd preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

Test iommufd preservation by setting up an iommufd and vfio cdev and
preserve it across live update. Test takes VFIO cdev path of a device
bound to vfio-pci driver and binds it to an iommufd being preserved. It
also preserves the vfio cdev so the iommufd state associated with it is
also preserved.

The restore path is tested by restoring the preserved vfio cdev only. On
restore, test verifies that the bind with a new iommufd fails as the
device is attached to the restored IOMMU domain. Also the LUO session
finish fails as the preserved iommufd is not restored.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 tools/testing/selftests/iommu/Makefile        |  12 +
 .../iommu/iommufd_liveupdate_kexec_test.c     | 262 ++++++++++++++++++
 2 files changed, 274 insertions(+)
 create mode 100644 tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c

diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 84abeb2f0949..ab35e8b21580 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -7,4 +7,16 @@ TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
 
+TEST_GEN_PROGS_EXTENDED += iommufd_liveupdate_kexec_test
+
 include ../lib.mk
+include ../liveupdate/lib/libliveupdate.mk
+
+CFLAGS += -I$(top_srcdir)/tools/include
+CFLAGS += -MD
+CFLAGS += $(EXTRA_CFLAGS)
+
+$(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBLIVEUPDATE_O)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBLIVEUPDATE_O) $(LDLIBS) -o $@
+
+EXTRA_CLEAN += $(LIBLIVEUPDATE_O)
diff --git a/tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c b/tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c
new file mode 100644
index 000000000000..cd05d894a309
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <limits.h>
+
+#define __EXPORTED_HEADERS__
+#include <linux/iommufd.h>
+#include <linux/types.h>
+#include <linux/vfio.h>
+#include <linux/sizes.h>
+#include <libliveupdate.h>
+
+#include "../kselftest.h"
+
+#define ksft_assert(condition) \
+	do { \
+		if (!(condition)) \
+			fail_exit("Failed: %s", #condition); \
+	} while (0)
+
+static const char *device_cdev_path;
+static char state_session[LIVEUPDATE_SESSION_NAME_LENGTH];
+static char iommufd_session[LIVEUPDATE_SESSION_NAME_LENGTH];
+
+static const uint64_t STATE_TOKEN;
+static const uint64_t IOMMUFD_TOKEN = 0x123456;
+static const uint64_t CDEV_TOKEN = 0x654321;
+static const uint64_t HWPT_TOKEN = 0x789012;
+static const uint64_t MEMFD_TOKEN = 0x890123;
+
+static int open_cdev(const char *vfio_cdev_path)
+{
+	int cdev_fd;
+
+	cdev_fd = open(vfio_cdev_path, O_RDWR);
+	if (cdev_fd < 0)
+		ksft_exit_skip("Failed to open VFIO cdev: %s\n", vfio_cdev_path);
+
+	return cdev_fd;
+}
+
+static int open_iommufd(void)
+{
+	int iommufd;
+
+	iommufd = open("/dev/iommu", O_RDWR);
+	if (iommufd < 0)
+		ksft_exit_skip("Failed to open /dev/iommu. IOMMUFD support not enabled.\n");
+
+	return iommufd;
+}
+
+static int create_memfd(size_t size)
+{
+	int fd, ret;
+
+	fd = memfd_create("buffer", 0);
+	if (fd < 0)
+		fail_exit("memfd_create failed");
+
+	ret = ftruncate(fd, size);
+	if (ret)
+		fail_exit("ftruncate failed");
+
+	return fd;
+}
+
+#define test_ioctl(fd, cmd, arg) \
+	do { \
+		if (ioctl(fd, cmd, arg)) \
+			fail_exit("ioctl(%s) failed", #cmd); \
+	} while (0)
+
+#define test_luo_session_preserve_fd(session, fd, token) \
+	do { \
+		if (luo_session_preserve_fd(session, fd, token)) \
+			fail_exit("luo_session_preserve_fd(%s) failed", #token); \
+	} while (0)
+
+#define test_luo_session_retrieve_fd(session, token) \
+	({ \
+		int _fd = luo_session_retrieve_fd(session, token); \
+		if (_fd < 0) \
+			fail_exit("luo_session_retrieve_fd(%s) failed", #token); \
+		_fd; \
+	})
+
+static uint32_t setup_iommufd(int iommufd, int memfd, int cdev_fd)
+{
+	struct vfio_device_bind_iommufd bind = {
+		.argsz = sizeof(bind),
+		.flags = 0,
+		.iommufd = iommufd,
+	};
+	struct iommu_ioas_alloc alloc_data = {
+		.size = sizeof(alloc_data),
+		.flags = 0,
+	};
+	struct iommu_hwpt_alloc hwpt_alloc = {
+		.size = sizeof(hwpt_alloc),
+		.flags = 0,
+	};
+	struct vfio_device_attach_iommufd_pt attach_data = {
+		.argsz = sizeof(attach_data),
+		.flags = 0,
+	};
+	struct iommu_hwpt_liveupdate_mark_preserve mark_preserve = {
+		.size = sizeof(mark_preserve),
+		.hwpt_token = HWPT_TOKEN,
+	};
+	struct iommu_ioas_map_file map_file = {
+		.size = sizeof(map_file),
+		.length = SZ_1M,
+		.flags = IOMMU_IOAS_MAP_WRITEABLE |
+				IOMMU_IOAS_MAP_READABLE |
+				IOMMU_IOAS_MAP_FIXED_IOVA,
+		.iova = SZ_4G,
+		.fd = memfd,
+		.start = 0,
+	};
+
+	test_ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
+
+	test_ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
+
+	hwpt_alloc.dev_id = bind.out_devid;
+	hwpt_alloc.pt_id = alloc_data.out_ioas_id;
+	test_ioctl(iommufd, IOMMU_HWPT_ALLOC, &hwpt_alloc);
+
+	attach_data.pt_id = hwpt_alloc.out_hwpt_id;
+	test_ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
+
+	map_file.ioas_id = alloc_data.out_ioas_id;
+	test_ioctl(iommufd, IOMMU_IOAS_MAP_FILE, &map_file);
+
+	map_file.iova = SZ_4G + SZ_1M;
+	map_file.start = SZ_1M;
+	test_ioctl(iommufd, IOMMU_IOAS_MAP_FILE, &map_file);
+
+	mark_preserve.hwpt_id = attach_data.pt_id;
+	test_ioctl(iommufd, IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE, &mark_preserve);
+
+	return alloc_data.out_ioas_id;
+}
+
+static void before_kexec(int luo_fd)
+{
+	struct iommu_ioas_unmap unmap = {
+		.size = sizeof(unmap),
+		.iova = SZ_4G + SZ_1M,
+		.length = SZ_1M,
+	};
+	int iommufd, cdev_fd, memfd, session;
+	uint32_t ioas_id;
+
+	create_state_file(luo_fd, state_session, STATE_TOKEN, /*next_stage=*/2);
+
+	session = luo_create_session(luo_fd, iommufd_session);
+	if (session < 0)
+		fail_exit("luo_create_session failed");
+
+	iommufd = open_iommufd();
+	memfd = create_memfd(SZ_2M);
+	cdev_fd = open_cdev(device_cdev_path);
+
+	ioas_id = setup_iommufd(iommufd, memfd, cdev_fd);
+
+	/* Cannot preserve cdev without iommufd */
+	if (!luo_session_preserve_fd(session, cdev_fd, CDEV_TOKEN))
+		fail_exit("Preserving cdev without iommufd should fail");
+
+	/* Cannot preserve iommufd without preserving memfd. */
+	if (!luo_session_preserve_fd(session, iommufd, IOMMUFD_TOKEN))
+		fail_exit("Preserving iommufd without memfd should fail");
+
+	if (fallocate(memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+		      SZ_1M, SZ_1M))
+		fail_exit("fallocate punch hole failed");
+
+	test_luo_session_preserve_fd(session, memfd, MEMFD_TOKEN);
+
+	/* Cannot preserve iommufd when mapped memfd pages have a hole punched. */
+	if (!luo_session_preserve_fd(session, iommufd, IOMMUFD_TOKEN))
+		fail_exit("Preserving iommufd with hole-punched pages should fail");
+
+	unmap.ioas_id = ioas_id;
+	test_ioctl(iommufd, IOMMU_IOAS_UNMAP, &unmap);
+
+	test_luo_session_preserve_fd(session, iommufd, IOMMUFD_TOKEN);
+	test_luo_session_preserve_fd(session, cdev_fd, CDEV_TOKEN);
+
+	close(session);
+	session = luo_create_session(luo_fd, iommufd_session);
+	if (session < 0)
+		fail_exit("luo_create_session failed");
+
+	test_luo_session_preserve_fd(session, memfd, MEMFD_TOKEN);
+	test_luo_session_preserve_fd(session, iommufd, IOMMUFD_TOKEN);
+	test_luo_session_preserve_fd(session, cdev_fd, CDEV_TOKEN);
+
+	close(luo_fd);
+	daemonize_and_wait();
+}
+
+static void after_kexec(int luo_fd, int state_session_fd)
+{
+	int iommufd, cdev_fd, session, stage;
+	struct vfio_device_bind_iommufd bind = {
+		.argsz = sizeof(bind),
+		.flags = 0,
+	};
+
+	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
+	ksft_assert(stage == 2);
+
+	session = luo_retrieve_session(luo_fd, iommufd_session);
+	if (session < 0)
+		fail_exit("luo_retrieve_session failed");
+
+	cdev_fd = test_luo_session_retrieve_fd(session, CDEV_TOKEN);
+
+	iommufd = luo_session_retrieve_fd(session, IOMMUFD_TOKEN);
+	if (iommufd >= 0)
+		fail_exit("iommufd should not be retrievable yet");
+
+	iommufd = open_iommufd();
+
+	bind.iommufd = iommufd;
+	if (ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind) == 0 || errno != EPERM)
+		fail_exit("Binding cdev to new iommufd should fail with EPERM");
+
+	/* Should fail */
+	if (luo_session_finish(session) == 0)
+		fail_exit("luo_session_finish should fail if iommufd is not restored");
+
+	close(iommufd);
+	close(cdev_fd);
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc < 2) {
+		printf("Usage: %s <vfio_cdev_path>\n", argv[0]);
+		return 1;
+	}
+
+	device_cdev_path = argv[1];
+	sprintf(iommufd_session, "iommufd-test-%s", "cdev");
+	sprintf(state_session, "state-%s", "iommufd-cdev");
+
+	return luo_test(argc, argv, state_session, before_kexec, after_kexec);
+}
-- 
2.56.0.257.gf7497c7d27-goog

