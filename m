Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D73FD129
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787340911; cv=none; b=sKgjjEHfgkjc/kdmj42YglhKmh1zMEaPoUij7fotqzZXLIsARGMXVD1oIzgfNwmGQ7kHzV6hqpTdCBQItzQJ06blBCxxIbxq35MlJYssFYrbVMscb6pJsRbkgqnjB10usyCV89WlxpqHDQlit6kpvLTi0Yu87E2y2aTef3T4/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787340911; c=relaxed/simple;
	bh=bRSJ89K8K73/lfPTmQjl/e3hiGKByMp4oSrMZ6XtBYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KM8sXuQw+QUuDmaqw84fikbb8TrgQ5fKSibHeCJpThtGzNv8etruJagl9EGXQU4YMrwXm8svl6nIOkr2uL8hhvrzzjXJRr4FazsPL9vG+V6OhHVC3wtfeisQ5imLGvpe9/pDl7m8BUHn6Mht8EbQ6hiZBZ14LBgtv5eFbcxYqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nqlrWugl; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqlrWugl"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce8a76df2dso23729665ad.2
        for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787340909; x=1787945709; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4GMXnvq7D8YucUDG8E30c7kSwAfsqFKmqAniOaqKEfc=;
        b=nqlrWugljYr6lqgH4qdchuu/wf3qL/5OAmL9vKLfnVsPErIucPlqe1+k9nU8k8bcvy
         mV8THsIIVhsUcMBUY1cqCn+2vDAe15yvX3ejbt5SG0l7wApbzzl0m6zkiVB5vrMb+nMD
         B/B9FRJNOiwKA7EVOEHgdSb2/OoeirPhFkrj+/l2nkeesndzIicmDzgrzAUl26RXgAmg
         WC8C29QZp1UuuVGhaOdIvpIH9Z3vmMi2p34NzgkRGAmn/2H4tD/x7Idm9OK/p8Vq/DHS
         oJBbnXz/5CqSgSgoiVG2a0Erj8HYDEZUUCl0OOOC8O1pqACPJuu3QJah+ZLAdz4Cz1oy
         pj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787340909; x=1787945709;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4GMXnvq7D8YucUDG8E30c7kSwAfsqFKmqAniOaqKEfc=;
        b=MYLPPcGJnDsBRRrQE9BuORhlcQWiDA9ZMRdQdcA67Axm/lHtZq2Zxsu6HAXrEoEi2U
         XcW5T+yAsRZJV3+GxkSNRACozQyWXFn+dWFX8SYTbrU5vUgen4hSsnIGXU1er7H1O73z
         0FGWMIq1+RcdkNIO+86xGj8iGE/suRajBEWfWwaIfN5aYsAXUiaNNld+D71Bug2Wt85t
         J9/ywqG2LfpkY+G1nP2VsM/jRWomoHYtOOjclu1I8Z0vz1+XhG/K1ssXJ2WqOTsC5TQt
         PkEp73AhA1h5BDS9pvgK5BWSb6v1DabBpLlIA1yfIddMVLmVZ5Z+k7VufFtUxjWXlDNO
         heAw==
X-Forwarded-Encrypted: i=1; AHgh+RovO7E740u0DD/oQUiSW9AkHWIO2aWRZQMbLQio+atkHdcjk30nF+zdfHcIpu5htj7F0j0=@vger.kernel.org
X-Gm-Message-State: AFuF++nCK9m8gNVSC/Aarb1vmmwuy5X75XWz/Hu4+E4NX6VO9N2ODGJe
	Oq7FBDErhM0fYYlJu1LeyU0LFyNTwMHoyPf5r1zjDxi24P14jseMlk7Hr3IijME7SmHOKp37xsP
	cmUemrdUd/Q==
X-Received: from plks10.prod.google.com ([2002:a17:903:2ca:b0:2cb:d8fb:3da3])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec86:b0:2c6:9f66:d573
 with SMTP id d9443c01a7336-2d64ae3ac9emr164652355ad.2.1787340909050; Fri, 21
 Aug 2026 12:35:09 -0700 (PDT)
Date: Fri, 21 Aug 2026 12:35:01 -0700
In-Reply-To: <20260821193502.92431-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260821193502.92431-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260821193502.92431-2-vipinsh@google.com>
Subject: [RFC PATCH 1/1] selftests: vfio: Add mmap fault and device reset test
From: Vipin Sharma <vipinsh@google.com>
To: Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>
Cc: jrhilke@google.com, skhawaja@google.com, tatashin@google.com, 
	Will Deacon <will@kernel.org>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a selftest to verify VFIO PCI device reset on an mmapped and faulted
device. The test maps all available BARs on the device, faults them,
and triggers a device reset via the VFIO_DEVICE_RESET ioctl.

This exercise uncovers a circular locking dependency introduced in
commit f5b16b802174 ("PCI: Suspend iommu function prior to resetting a
device"), where pci_dev_reset_iommu_prepare() acquires group->mutex
under vfio's vdev->memory_lock.

Assisted-by: Jetski:gemini-3.1-pro
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  1 +
 .../selftests/vfio/vfio_pci_mmap_reset_test.c | 60 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_mmap_reset_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..17b3a2fe215c 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -13,6 +13,7 @@ TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
+TEST_GEN_PROGS += vfio_pci_mmap_reset_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_mmap_reset_test.c b/tools/testing/selftests/vfio/vfio_pci_mmap_reset_test.c
new file mode 100644
index 000000000000..b004867905de
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_mmap_reset_test.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/pci_regs.h>
+#include <linux/vfio.h>
+
+#include <libvfio.h>
+
+#include "kselftest_harness.h"
+
+static const char *device_bdf;
+
+FIXTURE(vfio_pci_mmap_reset_test) {
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_SETUP(vfio_pci_mmap_reset_test)
+{
+	self->iommu = iommu_init(MODE_IOMMUFD);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_mmap_reset_test)
+{
+	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
+}
+
+TEST_F(vfio_pci_mmap_reset_test, mmap_fault_and_reset)
+{
+	volatile char dummy;
+	bool has_mmap = false;
+	int i;
+
+	if (!(self->device->info.flags & VFIO_DEVICE_FLAGS_RESET))
+		SKIP(return, "Device does not support reset\n");
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		struct vfio_pci_bar *bar = &self->device->bars[i];
+
+		if (!bar->vaddr)
+			continue;
+
+		/* Touch BAR to trigger page fault under mmap_lock */
+		dummy = *(volatile char *)bar->vaddr;
+		(void)dummy;
+		has_mmap = true;
+	}
+
+	if (!has_mmap)
+		SKIP(return, "No mmapable BAR found on device\n");
+
+	/* Trigger device reset under memory_lock */
+	vfio_pci_device_reset(self->device);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.55.0.766.g2966f0265a-goog

