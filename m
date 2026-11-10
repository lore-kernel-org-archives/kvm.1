Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283732;
	b=oZdB+wj0qIWTPP9D9GdevUPT6o5HW6NsoFmGYjfUPGrCQYewBllsH+DZxZv3P8pWg3F8
	 nEa07zzW9b3JQS12EkLQFeAkjDlrvCy/ya/l6V4WU+A5l5xoBK8gJDgcoB+hRPmAD3laS
	 IeCl+RoIJzTeBamOlcjwZPP6ZjzFKxRxWu4S8LHYYeh92u0clI7nVazTiug4riphJ3u/i
	 hOqs4tLqgkZwKiz66l03wqQUZKI3zWjIZPSBGr0gPp7JpNES1WIa0dS5peEjtmvGrK48k
	 UnWgHzCOgclw3bxbVw6CRth2VSAk9vNHL5YqfDvzhm++aPZoMCSAvNbJjuXadZYfbeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=EsdqaN2nmvUvBJaffXB1+l6flmcLRk4HQeDZzNYHTF4=;
	b=2Je5l3EuBhL9ANFPqql0qvEmuHa8kU7Tpsbr5rCtUQy6au/PNuEaKrL5PtalejDmq86y
	 9ZBBbwtECz6ku/OBTjIWfC3LF53I0ggTiRPibfbyIer003S4usxs0oxc3DXQTtrYwllMl
	 O03QFST0cdTpIF5P1futZ+7MK8uaQbjRKmFLrJ/fikLj1KcxyLFxbJi1nWQKcNclIVVua
	 /Q7PICACioohI4P99G3fsunTR/WlJBxvMIKcyadxnOOKR2Kizjgtg02g7Y0TOIBmFxfMb
	 LnGeh/RBECLaVND03tfbIosIRFQ1VUUVMvQPWD0Hut5WVn6JqS+vyi2AfCMibxzou3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fYWyRVKK;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7297A606CC97
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 04:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7297A606CC97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fYWyRVKK
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a0522cdaf3so1333420b3a.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 20:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283731; x=1794888531; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EsdqaN2nmvUvBJaffXB1+l6flmcLRk4HQeDZzNYHTF4=;
        b=fYWyRVKKRdge7/EPeItNHAoech2zYooWWIe7gW5awU37EIqrJLIqAS4zUW+DppSUK5
         rV715W+dQniuC0ULkYTd7W2tbtprpkNDk/Mwny0lI7oCqNISWLvVA9eWgaaOD/khqQKz
         RGUqCt6lElw6iPsIFCbb9uVe4BZ2YI34bF86U1kfrSwXPMZgK9BagSUufZyzc/Cbc0lf
         ES7WUhS13uw8OG3Hx2GolDtY0AbZ6tdU22vBquU8dW7mBkWMVPFJbzBztCV5ct0dsLvv
         /t1E7VtLZdJyZz9PlUgvKzVmhJnV8jjK5LIBLER3d+0637ij1MFY1ujoEcHwEYyFkygQ
         SCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283731; x=1794888531;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EsdqaN2nmvUvBJaffXB1+l6flmcLRk4HQeDZzNYHTF4=;
        b=cKFffOmMz7O/Lslco5WVeV2CNyIy97IIjLKOpmGAJ2m/o/EFXhIZbrc/4bzibTiyeB
         OHd04ahD/yi/PGYjzocTXLZ8BKo6lnvMkqLLoId77qwk4NsCab3aSL3706mxOv12szgm
         L8OFvFGznBs9SHebQzSrR5SQILrqE5cexgKw1h2cykLRZebpVWZvBBh+44mm89WMrxon
         KRnYYZ3RoDMBhsXsChZNG+MT/jloZkiD4q2+GlGn6ByRF4uomx97DJhO5ty2uCVwNU9g
         /fEpzbYRkmgKdIOh+qISoctDQfKAxvaiNmTrJTCaO+CVizXno0jEUfKIkX7jM+vNeuJg
         Ze0Q==
X-Forwarded-Encrypted: i=1; AL+hErGgpzFNnvZOV3jNnRfLotRzHwnDaaZziYSWjDsmYCT4jdgCne07/mRlBNh0DEyn9VgU0Bg=@vger.kernel.org
X-Gm-Message-State: APuU4Z84itf65YHGP6wizMmGDV3UHVq60d2zwlYNDTbnQ05ka/uoiGiI
	tqJF075X2BkwLplNa/tpNSAda2fdjGLJEnn+/Rq1d8qOiez65YW+td7AkpxmoVPcyqzfv3CyQhZ
	j8sn4DDfXzHTR8g==
X-Received: from pgbcr10.prod.google.com ([2002:a05:6a02:410a:b0:cc7:e0b2:a5a2])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4492:b0:3eb:abb7:f924 with SMTP id adf61e73a8af0-3f18f4ac9f9mr1346250637.17.1794283730720;
 Mon, 09 Nov 2026 20:08:50 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:24 +0000
In-Reply-To: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110040828.1774343-19-skhawaja@google.com>
Subject: [PATCH v7 18/18] iommufd/selftest: Add test to verify iommufd preservation
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

On restore, the test verifies that neither the iommufd nor the vfio cdev
can be retrieved, as the iommufd restore is not supported yet, and that
the LUO session finish fails.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 tools/testing/selftests/iommu/Makefile        |  12 +
 .../iommu/iommufd_liveupdate_kexec_test.c     | 252 ++++++++++++++++++
 2 files changed, 264 insertions(+)
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
index 000000000000..7bd151ff7147
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test.c
@@ -0,0 +1,252 @@
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
+
+	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
+	ksft_assert(stage == 2);
+
+	session = luo_retrieve_session(luo_fd, iommufd_session);
+	if (session < 0)
+		fail_exit("luo_retrieve_session failed");
+
+	iommufd = luo_session_retrieve_fd(session, IOMMUFD_TOKEN);
+	if (iommufd >= 0)
+		fail_exit("iommufd should not be retrievable yet");
+
+	/* The cdev can only be retrieved together with its iommufd. */
+	cdev_fd = luo_session_retrieve_fd(session, CDEV_TOKEN);
+	if (cdev_fd >= 0)
+		fail_exit("cdev should not be retrievable without its iommufd");
+
+	/* Should fail */
+	if (luo_session_finish(session) == 0)
+		fail_exit("luo_session_finish should fail if iommufd is not restored");
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
2.56.0.506.g506a7eabc5-goog

