Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827392;
	b=oTwrQ05HScw7lo2ay3oYQRnlattxeIxR4KUNkV6VGP9Z0XS4+IiNzHaCz2eNlmwrEps9
	 XWsgX1U4MFwgjaLOASZx+YwVKtb+khi9JZOCYLKkThPITWo+msNyE6FptS43EGSSiu5e/
	 pyL0fDGf4GAzkgFEcpCt3FCUalbLWAGF2EZiFP6XT63XK1yufmDoNoE6o40hpZIg3PXrY
	 uRaAD6TaugK8fRZPLnqM6iJfxX9UnkrcYuVx12hz3SkcGJxqFQdL8T+7ct0hnzqgru2qq
	 ISbtM9yjtyNPNrzunruCKqt4hCWCgC4djN9/zWDeeb7NPeJbNg7bgORe8yQXBAo/agw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827392;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bWZrsX7aWlMbwvlLKJqbJrwnBhxG4JV+WqMba30KTxI=;
	b=aTWdsz5/yY56WrFizkb+RgyBc5eCTbp6dSyLubYTC+yS5LxpioSikVt3f4+yLXe3f/N4
	 UoqpuSUcbRUNL4/cvuvvCgQbgT92rpEU6tT/kv/xvVu7TNWUQ67kW7cDdBk9GxmIuLnZO
	 Y1a8CjVx3cdB0VdGp6ICUXVPnoJhbZVdBJYd1P8mOVrGqgdb04ZhvYzFvhMFOTOzOF9eH
	 jzoXkFDOYy9GqSJiJhHnDm0AmcQhYr6y85zqy1KDKOoil9PsOXHtCCdlbSZqaaFMoPUee
	 L3CU4RJeMvy5yB6FrI30jpVHeLvB2UhhslmCVVrk25nFQS/khqdb3KLEtZ7SMDpSoAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mzZVjiAC;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77131607BDAE;
	Mon, 16 Nov 2026 11:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77131607BDAE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mzZVjiAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794827393; x=1826363393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9lxGVvT3vxsJLouzD6uoqq/ubjW0JxIDBomkq69iZzc=;
  b=mzZVjiACHdTMTQcvX6vauMQdSHfQta7JSvbovbjzwJq8C5NtX6ydIGQd
   tECxFPicdQwixdUACmSDTXpLRFwhvBWN9J8hnyixXtCT5NsAREG/O2Aga
   eXyYo6/r9C7hmSssSfogeozZ+iGq4lAni/0FHDjMNBbIQw6dU6j0sBl8Y
   n+a2qPlz4Dru1pIA7lGR4NqAUkStiu4u3e93vAtQoapoDyurnyiXAt6yL
   joYsnaQwPeojAwCY2W6wY9OhZfuoN2KwsbRosUJAY3tmrPEvp0dUI29JK
   lwGI0JHMhfN6dJn0ypn5wcIbHabkxVcSfbVXSdl/1z+Uw7PxcJE9Pr8oN
   g==;
X-CSE-ConnectionGUID: DMfKerVgQwOqKa2EISIpBQ==
X-CSE-MsgGUID: iOczUZUFRva+74eqBJdgvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3429600"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3429600"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:09:52 -0800
X-CSE-ConnectionGUID: GnjyuEbnSVKCTGS2ir7Ulg==
X-CSE-MsgGUID: WWcnUJP/SLqjthyP2XC2og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9848119"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:09:52 -0800
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: rick.p.edgecombe@intel.com,
	kevin.tian@intel.com,
	yilun.xu@intel.com,
	chao.p.peng@intel.com,
	baolu.lu@linux.intel.com,
	chao.gao@intel.com,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [RFC PATCH 1/7] coco/tdx-host: Create metadata for an SPDM session
Date: Mon, 16 Nov 2026 03:10:19 -0800
Message-ID: <20261116111037.3478844-2-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261116111037.3478844-1-chao.gao@intel.com>
References: <20261116111037.3478844-1-chao.gao@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX module talks to the device over a Security Protocol and Data
Model (SPDM) session. It needs host memory for each session's metadata,
and reports the number of pages required in its global metadata.

When setting up an SPDM session, allocate the memory and hand it to the
TDX module with TDH.SPDM.CREATE. Keep the returned session ID for later
SEAMCALLs. When tearing the session down, reclaim the memory with
TDH.SPDM.DELETE. If that fails, leak the memory, as the TDX module may
still be using it.

Based on work by Yilun and Zhenzhong.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/include/asm/tdx_global_metadata.h  |   1 +
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |   6 ++
 drivers/virt/coco/tdx-host/main.c           | 104 +++++++++++++++++++-
 3 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index e5e54159ad36..537e872eeb0e 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -52,6 +52,7 @@ struct tdx_sys_info_ext {
 };
 
 struct tdx_sys_info_connect {
+	u16 spdm_mt_page_count;
 	u16 iommu_mt_page_count;
 };
 
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 9b46f34cb469..f20e029f240b 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -144,6 +144,12 @@ static __init int get_tdx_sys_info_connect(struct tdx_sys_info_connect *sysinfo_
 	int ret;
 	u64 val;
 
+	ret = read_sys_metadata_field(0x3000000100000002, &val);
+	if (ret)
+		return ret;
+
+	sysinfo_connect->spdm_mt_page_count = val;
+
 	ret = read_sys_metadata_field(0x3000000100000003, &val);
 	if (ret)
 		return ret;
diff --git a/drivers/virt/coco/tdx-host/main.c b/drivers/virt/coco/tdx-host/main.c
index a815dbe5127a..919e77ae2326 100644
--- a/drivers/virt/coco/tdx-host/main.c
+++ b/drivers/virt/coco/tdx-host/main.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2025 Intel Corporation
  */
 
+#include <linux/bitfield.h>
 #include <linux/device/faux.h>
 #include <linux/firmware.h>
 #include <linux/module.h>
@@ -26,8 +27,30 @@ static const struct x86_cpu_id tdx_host_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, tdx_host_ids);
 
+#define TDISP_FUNC_ID		GENMASK(15, 0)
+#define TDISP_FUNC_ID_SEGMENT		GENMASK(23, 16)
+#define TDISP_FUNC_ID_SEG_VALID		BIT(24)
+
+static inline u32 tdisp_func_id(struct pci_dev *pdev)
+{
+	u32 func_id;
+
+	func_id = FIELD_PREP(TDISP_FUNC_ID_SEGMENT, pci_domain_nr(pdev->bus));
+	if (func_id)
+		func_id |= TDISP_FUNC_ID_SEG_VALID;
+	func_id |= FIELD_PREP(TDISP_FUNC_ID,
+			      PCI_DEVID(pdev->bus->number, pdev->devfn));
+
+	return func_id;
+}
+
 struct tdx_tsm_link {
 	struct pci_tsm_pf0 pci;
+	u32 func_id;
+
+	u64 spdm_id;
+	unsigned int spdm_mt_nr_pages;
+	void *spdm_mt;
 };
 
 static struct tdx_tsm_link *to_tdx_tsm_link(struct pci_tsm *tsm)
@@ -35,21 +58,97 @@ static struct tdx_tsm_link *to_tdx_tsm_link(struct pci_tsm *tsm)
 	return container_of(tsm, struct tdx_tsm_link, pci.base_tsm);
 }
 
+static int tdx_spdm_create(struct tdx_tsm_link *tlink)
+{
+	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
+	struct tdx_hpa_list_info info;
+	unsigned int nr_pages;
+	u64 spdm_id, sret;
+	void *spdm_mt;
+	int ret;
+
+	if (!tdx_sysinfo)
+		return -ENXIO;
+
+	nr_pages = tdx_sysinfo->tdx_connect.spdm_mt_page_count;
+
+	spdm_mt = alloc_pages_exact(nr_pages * PAGE_SIZE,
+				    GFP_KERNEL | __GFP_ZERO);
+	if (!spdm_mt)
+		return -ENOMEM;
+
+	ret = tdx_hpa_list_info_setup(&info, spdm_mt, nr_pages);
+	if (ret)
+		goto out_free_spdm_mt;
+
+	sret = tdh_spdm_create(tlink->func_id, &info, &spdm_id);
+
+	tdx_hpa_list_info_free(&info);
+
+	if (sret) {
+		ret = -EIO;
+		goto out_free_spdm_mt;
+	}
+
+	tlink->spdm_id = spdm_id;
+	tlink->spdm_mt = spdm_mt;
+	tlink->spdm_mt_nr_pages = nr_pages;
+	return 0;
+
+out_free_spdm_mt:
+	free_pages_exact(spdm_mt, nr_pages * PAGE_SIZE);
+	return ret;
+}
+
+static void tdx_spdm_delete(struct tdx_tsm_link *tlink)
+{
+	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
+	u64 sret;
+
+	sret = tdh_spdm_delete(tlink->spdm_id);
+	if (sret) {
+		/* leak the metadata pages */
+		pci_err(pdev, "fail to delete spdm 0x%llx\n", sret);
+		return;
+	}
+
+	free_pages_exact(tlink->spdm_mt, tlink->spdm_mt_nr_pages * PAGE_SIZE);
+}
+
+static int tdx_spdm_session_setup(struct tdx_tsm_link *tlink)
+{
+	return tdx_spdm_create(tlink);
+}
+
+static void tdx_spdm_session_teardown(struct tdx_tsm_link *tlink)
+{
+	tdx_spdm_delete(tlink);
+}
+
 static int tdx_tsm_link_connect(struct pci_dev *pdev)
 {
+	struct tdx_tsm_link *tlink = to_tdx_tsm_link(pdev->tsm);
 	int ret;
 
 	ret = tdx_iommu_get(pdev);
 	if (ret)
 		return ret;
 
-	/* TDISP connect is not implemented yet. */
+	ret = tdx_spdm_session_setup(tlink);
+	if (ret)
+		goto out_iommu_put;
+	return 0;
+
+out_iommu_put:
 	tdx_iommu_put(pdev);
-	return -ENXIO;
+	return ret;
 }
 
 static void tdx_tsm_link_disconnect(struct pci_dev *pdev)
 {
+	struct tdx_tsm_link *tlink = to_tdx_tsm_link(pdev->tsm);
+
+	tdx_spdm_session_teardown(tlink);
 	tdx_iommu_put(pdev);
 }
 
@@ -66,6 +165,7 @@ static struct pci_tsm *tdx_tsm_link_pf0_probe(struct tsm_dev *tsm_dev,
 	if (rc)
 		return NULL;
 
+	tlink->func_id = tdisp_func_id(pdev);
 	return &no_free_ptr(tlink)->pci.base_tsm;
 }
 
-- 
2.52.0

