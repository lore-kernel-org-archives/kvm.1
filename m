Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DF64C955C
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042131; cv=none; b=hxtsRAcJAA6hbrkN2A58mSg6Q+4O/3ni4/GwYrj/bs7tsp7MyQjNTwDAUzmj5339DtB1C7zVNgfTdQNRvu9RhiDG+6JCDt0mQzoaSIVeVib2gSLYtjjUXKRtMTdg5YfVQ75Sdckqblqzkyc1FRTVN+hibIhgrfB1YOXfS+Ac3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042131; c=relaxed/simple;
	bh=+ruXTCO9gRYmmLH2Y2rM+2QpabS7Kd0bF79dd5M3NDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DNgoITuIObEBFiAAz0fHG61nA2yWV7n8nfm8Y174DvxoWFaYdqSfZN0f3vXJDdbdFcLgJmeHKfnSos/dzQOI1IFJYJuLOpdQhAREXwzbie4JFQ0Lf8cQT2dkQo1/fGjq9Nowiq2KPOnhcRlHpZaCVd/qDqCcIx8agrQIJpQ2w7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ql8ar7Sk; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ql8ar7Sk"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cefa1a2be6so4880845ad.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 08:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042128; x=1784646928; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M0/6OkiDA7soDeG3nK/kM6W+DTMONIYlLqtJZ7GmGRw=;
        b=Ql8ar7Sk3nnxrxubtlG3kuXL7q92+JVN60sdnMFTnt39qHvECD2br4viqvIYTko1O3
         wgja7/919i4Az0J/NPA8+fKLsjiHVWUi8pKRpnMTkVDOIosZltDaTYqe5P6KhPGcd6ef
         uysCK/hMncMvENtQZgkPNpWYK5ufI5FNRE5ZVMcDRKWMkR2PSeBvplOPg/pYzFbrP+/N
         KbOk+NoxgGBllQVEwNbuhL6lFCNMvGtOJQ+GNHmp/kVCUuISZ4MAxMaaMMc49Xv2cF0P
         VuYICq13x83zbhbPM4VcKUnfm+sukSss+TCAHtzwVBWZaekq0dnxWNCIYaIq9Gcfy3U+
         +VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042128; x=1784646928;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M0/6OkiDA7soDeG3nK/kM6W+DTMONIYlLqtJZ7GmGRw=;
        b=PLbTCg1xZTM3c/XjX83rjGqeRLIxor9LOMUVBtIdY4hSCy4OYjWdv48JGxYViZ+XEY
         X8qLxEqsN/jcGrsrjsBYaz+/6p0i9aX/sZd1AbDm2WhK1dLUu/sIwowE8dWRnRkehvOM
         YFmx1RHH74oSVebNEuBOFEsFOGLw1k4mdi2PHoPNOxZGr+KEPitMwQ9gYCxoU3vwOql0
         RD6yNN1fQZQn2xJgiAvNrulcoNG3GzB9vR9IDYKo6T+wTXjJH1KgVHlVDVNorlzUUbk0
         rwqeB1jNBFkSqEiE8mCtBlU9rSaA06vrKJNWDWB3Hua4rUN9MGthHjEZEa70kKSyUv9L
         r0aw==
X-Forwarded-Encrypted: i=1; AHgh+RrCkTSA0qNaLdnPTlehByv6KZ1ZLTs6p5hbI7m690hcgFtGf5yNokoZt3bxnthOzlhN2rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlD58IuuybNJceJPRiFrHZSyi2Uk88smi/oV032L9C+OkKZcs3
	VUTGCUl6xs0qUL/mL/EWms2i8OV/qpcxnYoR6ZXAJs90zkLMLanqq/iZwHoPNapvqtCDYqRPkc9
	B7N/B5qJuKA==
X-Received: from plei5.prod.google.com ([2002:a17:902:e485:b0:2cb:d8fb:3da3])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b08:b0:2ca:17a8:cfce
 with SMTP id d9443c01a7336-2ce9f2852b2mr140988325ad.29.1784042127310; Tue, 14
 Jul 2026 08:15:27 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:15:02 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-18-vipinsh@google.com>
Subject: [PATCH v5 17/20] vfio: selftests: Add vfio_pci_liveupdate_kexec_test
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Add a selftest to exercise preserving a vfio-pci device across a Live
Update. For now the test is extremely simple and just verifies that the
device file can be preserved and retrieved. In the future this test will
be extended to verify more parts about device preservation as they are
implemented.

This test is added to TEST_GEN_PROGS_EXTENDED since it must be run
manually along with a kexec.

To run this test manually:

 $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
 $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 1 0000:00:04.0

 $ kexec ...   # NOTE: Exact method will be distro-dependent

 $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
 $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 2 0000:00:04.0

The second call to setup.sh is necessary because preserved devices are
not bound to a driver after Live Update. Such devices must be manually
bound by userspace after Live Update via driver_override.

This test is considered passing if all commands exit with 0.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  4 +
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 89 +++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 591f1a52c310..a2f0a459e1f4 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -15,6 +15,10 @@ TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
 TEST_GEN_PROGS += vfio_pci_liveupdate_uapi_test
 
+# This test must be run manually since it requires the user/automation to
+# perform a kexec during the test.
+TEST_GEN_PROGS_EXTENDED += vfio_pci_liveupdate_kexec_test
+
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
 TEST_FILES += scripts/run.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
new file mode 100644
index 000000000000..15b3e3af91d1
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <libliveupdate.h>
+#include <libvfio.h>
+
+static const char *device_bdf;
+
+static char state_session[LIVEUPDATE_SESSION_NAME_LENGTH];
+static char device_session[LIVEUPDATE_SESSION_NAME_LENGTH];
+
+enum {
+	STATE_TOKEN,
+	DEVICE_TOKEN,
+};
+
+static void before_kexec(int luo_fd)
+{
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	int session_fd;
+	int ret;
+
+	iommu = iommu_init("iommufd");
+	device = vfio_pci_device_init(device_bdf, iommu);
+
+	create_state_file(luo_fd, state_session, STATE_TOKEN, /*next_stage=*/2);
+
+	session_fd = luo_create_session(luo_fd, device_session);
+	VFIO_ASSERT_GE(session_fd, 0);
+
+	printf("Preserving device in session\n");
+	ret = luo_session_preserve_fd(session_fd, device->fd, DEVICE_TOKEN);
+	VFIO_ASSERT_EQ(ret, 0);
+
+	close(luo_fd);
+	daemonize_and_wait();
+}
+
+static void after_kexec(int luo_fd, int state_session_fd)
+{
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	int session_fd;
+	int device_fd;
+	int stage;
+
+	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
+	VFIO_ASSERT_EQ(stage, 2);
+
+	session_fd = luo_retrieve_session(luo_fd, device_session);
+	VFIO_ASSERT_GE(session_fd, 0);
+
+	printf("Finishing the session before retrieving the device (should fail)\n");
+	VFIO_ASSERT_NE(luo_session_finish(session_fd), 0);
+
+	printf("Retrieving the device FD from LUO\n");
+	device_fd = luo_session_retrieve_fd(session_fd, DEVICE_TOKEN);
+	VFIO_ASSERT_GE(device_fd, 0);
+
+	printf("Finishing the session before binding to iommufd (should fail)\n");
+	VFIO_ASSERT_NE(luo_session_finish(session_fd), 0);
+
+	printf("Binding the device to an iommufd and setting it up\n");
+	iommu = iommu_init("iommufd");
+
+	/*
+	 * This will invoke various ioctls on device_fd such as
+	 * VFIO_DEVICE_GET_INFO. So this is a decent sanity test
+	 * that LUO actually handed us back a valid VFIO device
+	 * file and not something else.
+	 */
+	device = __vfio_pci_device_init(device_bdf, iommu, device_fd);
+
+	printf("Finishing the session\n");
+	VFIO_ASSERT_EQ(luo_session_finish(session_fd), 0);
+
+	vfio_pci_device_cleanup(device);
+	iommu_cleanup(iommu);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+
+	sprintf(device_session, "device-%s", device_bdf);
+	sprintf(state_session, "state-%s", device_bdf);
+
+	return luo_test(argc, argv, state_session, before_kexec, after_kexec);
+}
-- 
2.55.0.795.g602f6c329a-goog

