Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633839;
	b=0ISrPfaqPXy6d2o9Ss0yuFFeFV2WZKcv3aFn2TNCzyQou3rLrrvX/G+16aSjmZ077hX8
	 qvCyNhbtnpGH6KwZDkNkEbMsj91xpzNYzy2vdMRTr/6LEZn1j+mV3y+i+PpRU+NKR4NDJ
	 I8i/TeXhJiUYx4QX4FL3fbqlOge6Jw4ey4a7qpACuJxYnD1hQ3jLEkK/tBwTfWyowHtCF
	 P9LeD+kZwEk8yW1MucHKoDRVU4yCxNeSbScmyFTB0OxP+FKY57aoHVu/XNjMay9xw8j+T
	 dSB0t39wdnjCEr8HXyxxc3VJX5mZlaU+89xnXbHDrvQYT4cQp08BFIzILNSAqQW+MgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=xs0C+G7zjdZllGuTbQSqQheVXxWPk9ZHdH8YJo8R+C0=;
	b=hKt27BBBnO/nW2vmpkcJxeFipn90nIn5lH+yH9sa7R/t0/ZCmr2C2kNEqWI0j98F0DB2
	 JlLCYXFzz715k+ytoJYgfJgyeTASr760d2j7P1i/rmfb0eQNrcDZJEZMBWe5ZHbh05g1z
	 z5WVUWLlgamOAyu7cP3WT0E4UVCgrz2OdpFR6SdlNuiEd2O/Um+x6+DHPJXnFqizfLg09
	 4ewGd5FkOUB+C9GfqN/Ljm0TGZmrX/8+rt6TbgTd56gFPRAaFa3CWtDrYuHIgpP8D1hvw
	 H2pqtiDBCEFFG19mEBeRu+NZslfk/MqklXZZsnko6tajYeP9FGF4D+W5XjtcXVgyU+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gSEQHn4+;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E89460E408F
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E89460E408F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gSEQHn4+
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd67e98f68fso3422554a12.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633838; x=1794238638; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xs0C+G7zjdZllGuTbQSqQheVXxWPk9ZHdH8YJo8R+C0=;
        b=gSEQHn4+giolmmxb06w49f8gwQb4Hw6xUmYno5iGPS/7VrDSZusjyW4c/X7tzC9pBm
         da6NblMhUG3X6TAe6MtQY3mkfc72i56MGVPxkgrmHbBHIXSlOg/tnXh35RP8Uv5rNxFX
         1sybx0WobbdwcU2uK8wq7z3LNjgn1r0VpnKZQWzhbaDvSVdMi+gw3bj3DPxPWp3mEAnu
         xek+at6jdJuN61cZtWCw2wWzpYOI6bahEHmbdnWKDILRyWIkrkJgFrZGRqBxXXvvIpR6
         6jAJY7UghFzsqVs2STfTGxIuW10DsxvgYeddNzI2Orv1nhMrqOwe6NfgFSuSaW4LBYNe
         pxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633838; x=1794238638;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xs0C+G7zjdZllGuTbQSqQheVXxWPk9ZHdH8YJo8R+C0=;
        b=Vca6/HIN84NpwlNlZl9+dPKWLbVDQzNsysyRczGoUM+3bEYelRcM3M6qbX3i+jiQR1
         rb6l64s78A6zYoA3xngaAQ3tMnzikVBPhVG+3tn8ajSplOGF8ugkX//CfHjywKvL68OM
         sIuIMizAUOfJeniekz5CaNbv/2JiSI1pS5H3ixwQyNCVyC7uYHPeVTGptAaF/mKassQN
         cNve0pDlvVfZt4GJqeMphc+DJguwoRnIrPHccHPRFjQ1igSBAgAqkhy9/b0tQr7Qwb7c
         QUj1lGvwac0z48ZQAU4ZMI/cTtMlivFBgJ9aRvGO9US73jBS1z3hPw0auo7BVdKevRLU
         V8iQ==
X-Forwarded-Encrypted: i=1; AKwUvBzl54/v9RMiB0qNR63BsBzWuc4vTIvd2alDE+2X8SDtKe+uDlSFm533r96KWUNl9CpyFck=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UGVocwvcD5MEu3uh8kK5APOAGEU2hEQx9ythuRaSEO/gqlsSS
	N1VsJ8xPiu3Sy/hDorXyFkspwZ6AmJ6jtqNIETuBU4CWT23eAdCuNhAYGJx+0f0zegxtJtG0Rvv
	vUTdhVDAwMQ==
X-Received: from plko2.prod.google.com ([2002:a17:902:6b02:b0:2e8:bfd5:b889])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f542:b0:2e9:9263:a5f
 with SMTP id d9443c01a7336-2eb36493707mr97418395ad.17.1793633838083; Mon, 02
 Nov 2026 07:37:18 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:46 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-18-vipinsh@google.com>
Subject: [PATCH v6 17/27] vfio: selftests: Add vfio_pci_liveupdate_uapi_test
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add a selftest to exercise preserving various VFIO files through
/dev/liveupdate. Only the VFIO cdev files of devices in noiommu mode can
be preserved. Ensure that preserving the cdev file of a device that is
not in noiommu mode fails, and that everything else (group-based device
files, group files, and container files) fails too.

In FIXTURE_SETUP, probe luo_session_preserve_fd() on the bound cdev FD
in a temporary session for iommufd variants and skip if LUO returns
-ENOENT, so the test skips cleanly when CONFIG_VFIO_PCI_LIVEUPDATE=n or
when the target device does not support VFIO PCI Live Update (e.g. an
SR-IOV VF).

Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Vipin Sharma <vipinsh@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/vfio_pci_liveupdate_uapi_test.c      | 126 ++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 55e1e1843090..c2764fcef31d 100644
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
index 000000000000..da25ea4e2b1e
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
@@ -0,0 +1,126 @@
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
+/*
+ * LUO fails with -ENOENT if no file handler accepts a file. For the bound VFIO
+ * cdev file of a device, that means that the kernel lacks VFIO PCI Live Update
+ * support (CONFIG_VFIO_PCI_LIVEUPDATE=n) or that vfio-pci does not support
+ * preserving the device (e.g. an SR-IOV VF).
+ */
+static bool device_preserve_supported(int luo_fd, int device_fd)
+{
+	int session_fd;
+	int ret;
+
+	session_fd = luo_create_session(luo_fd, "probe");
+	VFIO_ASSERT_GE(session_fd, 0);
+
+	ret = luo_session_preserve_fd(session_fd, device_fd, 0);
+
+	/* Closing the session unpreserves the device. */
+	VFIO_ASSERT_EQ(close(session_fd), 0);
+
+	return ret != -ENOENT;
+}
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
+
+	if (self->iommu->iommufd &&
+	    !device_preserve_supported(self->luo_fd, self->device->fd))
+		SKIP(return, "Live Update of %s is not supported", device_bdf);
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
+	/*
+	 * Only VFIO cdev files of devices in noiommu mode can be preserved;
+	 * device files obtained through a VFIO group never can.
+	 */
+	ASSERT_EQ(ret, self->iommu->iommufd ? -EOPNOTSUPP : -ENOENT);
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
2.56.0.317.g454f8302e1-goog

