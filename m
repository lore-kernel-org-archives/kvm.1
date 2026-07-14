Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5009934CFCF
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042128; cv=none; b=SFctcQe/MWOlCK/HJoI8pBQbFj9mBVhv+2Bd6Nv9g7bWQEmXYSp3mToSfri+9XjtxfBudy6QF7LPZntRkjo/gUjM06Q8asK8MJHO+3b0jpf0UIvDRiIp+8h3cAPUmyyb8CrWCGB7b+kx24LCy80zB9x+z0YHD5QJQKUjjh0hbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042128; c=relaxed/simple;
	bh=23AOW+ibIYHlba5Hxvem4H4THwWt1BCwNsb6ZEVk/Zs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D5XYAVAb5v0xrCRG6iO29c1HRCKU/0S3p6qxmojkVScGyoZ05cgwt25HWHoalKlNR+FtfwkLHKUCz0qcTD45d/6AyX6NH6h5olAR6PCDuEYQO3/atcRE+pZRqzkkx7bFxasz4hVsJg3j88ESzOuC7LNTwfYOLe7S1y1DjkVS8oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gKDJVSiw; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gKDJVSiw"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-847a00bcbd0so5876631b3a.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042124; x=1784646924; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKj/zyluhYMMwtYKfEtevhbjKc1OLf8e8hVjMJ10va8=;
        b=gKDJVSiwckvNFlqZqnXWEemG3VuCHtNqgnc2Or1Rrhdx4WZJALFFsNDP/w4+GN4YdX
         66cNRj3Ivt1B6lzQHGbowlZTxWGUQ8iuPlRP1W8o9LaQ3eifb2x0SAMKQNc/8++FKA3F
         cXAcepvzpqF26KpdVbJJWrXM2gDqqDu3e9uF4hI5NueF/bs0ceRijxcEA1swsungekVS
         028IwB32vzDSY+7aN9zGukSQCaI56Endr1BBm9HbrIa0/ySWjbVeNMLL4lCprUa8ovVI
         L2F9R9b8Gt5OQ+00Yp2r8yQceJnnbrYkblAw1r69nKEx2C8S/Xd1FYuvgQ2VqxRbs/kA
         rmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042124; x=1784646924;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gKj/zyluhYMMwtYKfEtevhbjKc1OLf8e8hVjMJ10va8=;
        b=ruQlp0uNNNzR9wllWcsDVmgw66RAfv84ItRwj0E1AnzvFADU3HGwlqcqICDOkpcxWO
         9n+PU1lliU5MtSBDmTt9GRs3BkqVkCMqeEMMOv+KbRiA4zYillESc6KjSNOl2uoHfK08
         MK05/jX9ApjOe2yoB7nkb3euGbphw4V11N1mqllgGJkhSfZM7YkFvUmy3WyEL+KnUgvo
         i0+i9jthWbgeFr6Yt7+HO99oGHOzDPt78mh5sjRUMlhQOtAVHLIfJmJTzWFNxv6LhB6q
         2XDIlatjjqMAhnmT0Wlh2fcpKyU1nTSBhDso0KEMJFd2CxikUNWGH72sLJ6yJMG101jJ
         r8Mg==
X-Forwarded-Encrypted: i=1; AHgh+Rqpc+0zcZmaaqClUJBfWOe5wPleW/TBve741sOOICpT4gtuuh5ZF97QAD6Vfn5KZhWXyVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9NyC3xbsaHE0o+RjUHNgqVzFHM+9ztNHDUY2vionJlQPmChFn
	J74CJ+bsNCNEjNxjUa2VgSy+LOK6PwqDd9WEcbK2g2HpPzhVE3K3tZpH4Y6UKhxJniEIkm8arwK
	gTzzWJXVAfQ==
X-Received: from pfbhx15.prod.google.com ([2002:a05:6a00:898f:b0:845:e683:1287])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b50:b0:848:6698:2d5a
 with SMTP id d2e1a72fcca58-84889659202mr12144241b3a.20.1784042124125; Tue, 14
 Jul 2026 08:15:24 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:59 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-15-vipinsh@google.com>
Subject: [PATCH v5 14/20] vfio: selftests: Add vfio_pci_liveupdate_uapi_test
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

From: David Matlack <dmatlack@google.com>

Add a selftest to exercise preserving various VFIO files through
/dev/liveupdate. Ensure that VFIO cdev device files can be preserved and
everything else (group-based device files, group files, and container
files) all fail.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  1 +
 .../vfio/vfio_pci_liveupdate_uapi_test.c      | 97 +++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 4c8a30f950c4..dc06fddcf855 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -13,6 +13,7 @@ TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
+TEST_GEN_PROGS += vfio_pci_liveupdate_uapi_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
new file mode 100644
index 000000000000..f81c8ab21db3
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <libliveupdate.h>
+#include <libvfio.h>
+#include <kselftest_harness.h>
+
+static const char *device_bdf;
+
+FIXTURE(vfio_pci_liveupdate_uapi_test) {
+	int luo_fd;
+	int session_fd;
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_VARIANT(vfio_pci_liveupdate_uapi_test) {
+	const char *iommu_mode;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode)			\
+FIXTURE_VARIANT_ADD(vfio_pci_liveupdate_uapi_test, _iommu_mode) {	\
+	.iommu_mode = #_iommu_mode,					\
+}
+
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
+#undef FIXTURE_VARIANT_ADD_IOMMU_MODE
+
+FIXTURE_SETUP(vfio_pci_liveupdate_uapi_test)
+{
+	self->luo_fd = luo_open_device();
+	ASSERT_GT(self->luo_fd, 0);
+
+	self->session_fd = luo_create_session(self->luo_fd, "session");
+	ASSERT_GT(self->session_fd, 0);
+
+	self->iommu = iommu_init(variant->iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_liveupdate_uapi_test)
+{
+	if (self->device)
+		vfio_pci_device_cleanup(self->device);
+	if (self->iommu)
+		iommu_cleanup(self->iommu);
+	if (self->session_fd > 0)
+		close(self->session_fd);
+	if (self->luo_fd > 0)
+		close(self->luo_fd);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_device)
+{
+	int ret;
+
+	ret = luo_session_preserve_fd(self->session_fd, self->device->fd, 0);
+
+	/* Preservation should only be supported for VFIO cdev files. */
+	ASSERT_EQ(ret, self->iommu->iommufd ? 0 : -ENOENT);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_group_fails)
+{
+	int ret;
+
+	if (self->iommu->iommufd)
+		SKIP(return, "iommufd-mode does not have group files");
+
+	ret = luo_session_preserve_fd(self->session_fd, self->device->group_fd, 0);
+	ASSERT_EQ(ret, -ENOENT);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_container_fails)
+{
+	int ret;
+
+	if (self->iommu->iommufd)
+		SKIP(return, "iommufd-mode does not have container files");
+
+	ret = luo_session_preserve_fd(self->session_fd, self->iommu->container_fd, 0);
+	ASSERT_EQ(ret, -ENOENT);
+}
+
+int main(int argc, char *argv[])
+{
+	int fd;
+
+	fd = luo_open_device();
+	if (fd < 0)
+		ksft_exit_skip("open(%s) failed: %s, skipping\n",
+			       LUO_DEVICE, strerror(errno));
+
+	close(fd);
+
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.55.0.795.g602f6c329a-goog

