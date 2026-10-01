Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2254DE71E
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894812; cv=none; b=L8umKJxYbSNXVlagKBm4rV05NJGABgVSuQgJ9mTfSE/dKg2ahSO83tlOsC5+TUrOfzUk3CV+H4/DS84OvhjCnI8eHFuFR6K4/uqAqeZO+P1fqToBvw8ZMoxcw05hOE6O9pdm4yo/bmfq+gc4jQ3EKfZISdfHzF7uAPi2PB3T5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894812; c=relaxed/simple;
	bh=+ZrMyvypAMHMJwmzcIZVzfzQU/AIsNYo+KFbpNJHSEc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hOUdS69AHCWUcRcnaqn2MoBzaZxDnjge41eJXqhsOq+aa52rlrxz1+D0PJjITQG09juHf7aFs1ElWDBDRnbAEC7mJk2No675Rs0Uhquyte+jQl9JwpFORv15aDBMxVGkC1Is6zwExGI9N3U4AVyxVFSuY9afZgHCfx/DIWP061I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JxUvg7ef; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxUvg7ef"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-88629a452e0so2732165b3a.2
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 15:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790894809; x=1791499609; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OkzBth2K8luOc5hRw7dwkQ++Ts6T4OZjlz0I1Txn4EY=;
        b=JxUvg7efOSdmr3iDHJYrn13xO1zANliVqmp5CXf38vIll6iQqU69LzAnitl+tdcLuT
         hUEnN6kRRwZFEBanaejvqYEVbdlmWRrj8sfAMvktijO4WsCPaaqJBj+mJDRC5L8PTeU2
         pplAtafaugM9ZlYP8e63Ui3iCKUda+TieqhA1lNwKfIhegjN7J2Bi0NExbseeFjSd6xn
         29sXM21HzHndGofd/VbtPdo5Djr6mvLGRT65KrLdIc4W0xGpZK9mMuolIttzpWTOlqh7
         44A2YIyoOTDiSwC3+/3weiElklQRxx1G5T/Y17cr3BiA5LZdxoVYmz68f0EME5bSABUz
         i/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790894809; x=1791499609;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OkzBth2K8luOc5hRw7dwkQ++Ts6T4OZjlz0I1Txn4EY=;
        b=vSwyT0JvSBHLB8Zb+XHOlLKtsautXxW1nSBtwhiFJZr5AhLL1VyPW32sVS80IdzPHw
         pZBt/Tkp9xpwYVKEVqmugV4dPamblahXP3UBcjL/Am+VD6honIq7Cs314VOpIj2UL2az
         QGijcXlRMbjIw31FiU7HKYQJunr45HFY9BK1Dci7DaTBm/F4Jt2/kODSZw+wvJ9GSVZj
         jucjCuyqGwX+FLreUVjGmH94Y6bFG2iaTAFQsCGSwdalTUdw8BJkm4ATIp1vbczkjCXG
         pib8WHtQdvmevi/oUGi3ozsVyYRkTIubdrY1hM8laHcc4HAnNIV5hXLpoj602Gg6GbII
         5lPw==
X-Forwarded-Encrypted: i=1; AKwUvBwsMlDckGrv/mD6+Gp6NuvMSJ5PJlb9vsFz6B7MZxsLKuznajBCbIhZTy2Tbbr47FmE+TA=@vger.kernel.org
X-Gm-Message-State: AFuF++ltK+2rxu2Akl1aUK4zKxerUpbFmBXjVjMnFeHVuwl5gPI+V3ie
	Q/Luz8aCpjRvKdsefVAdria9WgER8FTAcwrkkdHQ6lwRc4wT5TGSBZEMGR+jAw6zLd780awX3eB
	Nhw==
X-Received: from pfbhu50.prod.google.com ([2002:a05:6a00:69b2:b0:887:3013:c8e7])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1888:b0:886:1119:2cbf
 with SMTP id d2e1a72fcca58-88af2687915mr858560b3a.5.1790894808625; Thu, 01
 Oct 2026 15:46:48 -0700 (PDT)
Date: Thu,  1 Oct 2026 22:45:31 +0000
In-Reply-To: <20261001224531.765278-1-praan@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001224531.765278-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001224531.765278-8-praan@google.com>
Subject: [RFC PATCH 7/7] vfio/selftests: Add observability test for IO page
 table usage
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Logan Odell <loganodell@google.com>, Pranjal Shrivastava <praan@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a new selftest, vfio_nr_pages_test, to validate the iommu-nr-pages
fdinfo metric across all IOMMU backends (Type 1 and IOMMUFD native/compat).

The test performs a sparse mapping to force the underlying IOMMU driver
to allocate a deep page table hierarchy. It then asserts that the
nr_pages metric increases and proves the 'sticky' reclamation behavior
by verifying the page count does not drop immediately upon unmapping.

The test is skipped when the IOMMU driver does not account its page
table memory, in which case the metric is not reported.

Co-developed-by: Logan Odell <loganodell@google.com>
Signed-off-by: Logan Odell <loganodell@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/vfio_nr_pages_test.c       | 119 ++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_nr_pages_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..140ef273e36b 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -13,6 +13,7 @@ TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
+TEST_GEN_PROGS += vfio_nr_pages_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
diff --git a/tools/testing/selftests/vfio/vfio_nr_pages_test.c b/tools/testing/selftests/vfio/vfio_nr_pages_test.c
new file mode 100644
index 000000000000..aef6b1dd8e19
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_nr_pages_test.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stdio.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <linux/sizes.h>
+
+#include <libvfio.h>
+
+#include "../kselftest_harness.h"
+
+static const char *device_bdf;
+
+static long read_nr_pages(struct iommu *iommu)
+{
+	char path[256];
+	char line[128];
+	FILE *f;
+	long val = -1;
+	int fd = iommu->container_fd != -1 ? iommu->container_fd : iommu->iommufd;
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", fd);
+	f = fopen(path, "r");
+	if (!f)
+		return -1;
+
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "iommu-nr-pages: %ld", &val) == 1)
+			break;
+	}
+
+	fclose(f);
+	return val;
+}
+
+FIXTURE(vfio_nr_pages_test) {
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_VARIANT(vfio_nr_pages_test) {
+	const char *iommu_mode;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_name) \
+FIXTURE_VARIANT_ADD(vfio_nr_pages_test, _name) { \
+	.iommu_mode = #_name, \
+}
+
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
+
+FIXTURE_SETUP(vfio_nr_pages_test)
+{
+	self->iommu = iommu_init(variant->iommu_mode);
+	if (!self->iommu)
+		SKIP(return, "IOMMU mode %s not supported", variant->iommu_mode);
+
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+	if (!self->device) {
+		iommu_cleanup(self->iommu);
+		SKIP(return, "Failed to initialize VFIO device");
+	}
+}
+
+FIXTURE_TEARDOWN(vfio_nr_pages_test)
+{
+	if (self->device)
+		vfio_pci_device_cleanup(self->device);
+	if (self->iommu)
+		iommu_cleanup(self->iommu);
+}
+
+TEST_F(vfio_nr_pages_test, sparse_mapping_sticky_reclamation)
+{
+	long nr_pages_initial, nr_pages_mapped, nr_pages_final;
+	struct dma_region region1 = {0};
+	struct dma_region region2 = {0};
+
+	if (!self->iommu || !self->device)
+		SKIP(return, "Fixture setup failed");
+
+	nr_pages_initial = read_nr_pages(self->iommu);
+	if (nr_pages_initial < 0)
+		SKIP(return, "iommu-nr-pages not reported by this IOMMU");
+
+	/* Map a page at start */
+	region1.size = SZ_4K;
+	region1.vaddr = mmap_reserve(region1.size, region1.size, 0);
+	ASSERT_NE(MAP_FAILED, region1.vaddr);
+	region1.iova = 0x100000;
+	iommu_map(self->iommu, &region1);
+
+	/* Map another page far away (1GB stride) to force deep page tables */
+	region2.size = SZ_4K;
+	region2.vaddr = mmap_reserve(region2.size, region2.size, 0);
+	ASSERT_NE(MAP_FAILED, region2.vaddr);
+	region2.iova = 0x100000 + SZ_1G;
+	iommu_map(self->iommu, &region2);
+
+	nr_pages_mapped = read_nr_pages(self->iommu);
+	ASSERT_GT(nr_pages_mapped, nr_pages_initial);
+
+	/* Unmap both regions */
+	iommu_unmap(self->iommu, &region1);
+	iommu_unmap(self->iommu, &region2);
+
+	nr_pages_final = read_nr_pages(self->iommu);
+
+	/* Page tables should remain allocated */
+	ASSERT_EQ(nr_pages_final, nr_pages_mapped);
+
+	munmap(region1.vaddr, region1.size);
+	munmap(region2.vaddr, region2.size);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

