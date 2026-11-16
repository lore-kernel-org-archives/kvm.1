Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827395;
	b=ojQKK3xpXFQkeC+v7MfxsHJkGPEe1JoGac0PnMxgetFt0+/INGckQBfuaFe1CTQaje8h
	 R9CGRUp/0CMQHbEQIN29CYJliAMO2NCw395p65B+tPxMwKfXb7pJXIdE8vJPHm5jYd6Dk
	 Dmz2mMWpJRQr44Q8cuhmk8CYedLIYnrgXE6wcHs3cvMRaTSsLhcEnGuNnDkAnDtiE8N4F
	 GgI9ijgULlxiojnQdyZUuz7mNApLIIqGPBlRBY4I98aCyd+lbA9EzpvX8aORNcfOG5V+r
	 HKfKq6p7GMdzbv9fJopkNx/ZR028WXe6w3uae64gOMHZxHD+1AUiMG6oAtKtF8bt/bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827395;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ea9lwwZqx0Fhut6tkttK1ey1EZJvZdhuW5q9l8B81uM=;
	b=lB2/PQibKL/Tj6D8FoOYpf1KowBU7az0HkMXnyLGovqrbd4lvsMyvDa2f26BhGjDlzno
	 k1yzzhFiDExFAS6DKhUIiu+iXrLpg8ml/oH/0VfV9IzITeBB+aF5P0lMa9sTIrakZVpCN
	 JH9dvHchIJZ0AoPBwZ4jVV7AprUAaHusRVcYaBMTLKnDE0EuynzgPwLhfyWecL0i6HqsP
	 3576Moe33yLs+pQ/CaW7Fxza8xwdCR0E+iOakvu/3R8ZOrKAN39kTfgSiCEmxaci1rixj
	 HLNmf1Mkwl0NoAaLGiviHpvwciKENS+LSUpb6M9wW+4abdjOMxrtt7bgGq3kLFEQP1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TVeRa0E4;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4C607D204;
	Mon, 16 Nov 2026 11:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23C4C607D204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TVeRa0E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794827395; x=1826363395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LXi3lqi7mwnIt0PeIoIaisI/1PD78k2CSvLXt+UxR2Q=;
  b=TVeRa0E4LcA4UQqrWMMx/cPLQ/HuD174A3QzF6nxw27jddLZHxLeks0Z
   aMk+EOSlAkBv/bOpl63BIKqjYAa2kfOKrBn3PTDuYzznpQJtRYtlTocIu
   p64vkwaI8DQBLY0Q7sFdWa7BAiiPkL3N71DXqg/lChQ9YKX69XDs1BAx6
   /oMe6FA9vU+VTUUNaoTQq2/ZtA0Q1ldt0l64gJjSkEXmIpC3Ob1rZ5zxZ
   /y89NCd1BeDZhOw6czB2/+HoqFtfSRZA9n3T7F59re35KnC75XJoDia6M
   ERnzscqavd5ot16wOFpVDFN2O3kT63GNGt0zN3u+N3ffpHYi/WB+82eaZ
   g==;
X-CSE-ConnectionGUID: aatFxhjQT3CfJlCQA9adsA==
X-CSE-MsgGUID: spPApCFkQ+O38pQUedNIOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3429616"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3429616"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:09:55 -0800
X-CSE-ConnectionGUID: K0wFedccTxSIlfX62SeNWQ==
X-CSE-MsgGUID: ZCBMM4UmSA6znCuN2PxlWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9848128"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:09:54 -0800
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
Subject: [RFC PATCH 4/7] coco/tdx-host: Pass a device info buffer to tdh_spdm_connect()
Date: Mon, 16 Nov 2026 03:10:22 -0800
Message-ID: <20261116111037.3478844-5-chao.gao@intel.com>
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

TDH.SPDM.CONNECT requires a host-provided buffer, into which the TDX
module writes information about the device.

TDs will use the information to attest the device, which is not
supported yet. The kernel doesn't use it for now, so treat it as opaque
data.

Take the buffer size from the TDX global metadata, and keep the buffer
for the lifetime of the SPDM session.

Based on work by Yilun.

[This patch will be reworked when the series moves to the CTLV
  attestation flow.]

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/include/asm/tdx_global_metadata.h  |  1 +
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  6 +++++
 drivers/virt/coco/tdx-host/main.c           | 27 +++++++++++++++++++--
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index 537e872eeb0e..30f3ca006e88 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -54,6 +54,7 @@ struct tdx_sys_info_ext {
 struct tdx_sys_info_connect {
 	u16 spdm_mt_page_count;
 	u16 iommu_mt_page_count;
+	u16 spdm_max_dev_info_pages;
 };
 
 struct tdx_sys_info {
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index f20e029f240b..cf747b0dc945 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -156,6 +156,12 @@ static __init int get_tdx_sys_info_connect(struct tdx_sys_info_connect *sysinfo_
 
 	sysinfo_connect->iommu_mt_page_count = val;
 
+	ret = read_sys_metadata_field(0x3000000100000007, &val);
+	if (ret)
+		return ret;
+
+	sysinfo_connect->spdm_max_dev_info_pages = val;
+
 	return 0;
 }
 
diff --git a/drivers/virt/coco/tdx-host/main.c b/drivers/virt/coco/tdx-host/main.c
index 86299658ae45..da56178eac2e 100644
--- a/drivers/virt/coco/tdx-host/main.c
+++ b/drivers/virt/coco/tdx-host/main.c
@@ -67,6 +67,8 @@ struct tdx_tsm_link {
 	struct page *out_msg;
 	unsigned int spdm_mt_nr_pages;
 	void *spdm_mt;
+	unsigned int dev_info_nr_pages;
+	void *dev_info;
 };
 
 static struct tdx_tsm_link *to_tdx_tsm_link(struct pci_tsm *tsm)
@@ -158,6 +160,7 @@ static int tdx_spdm_xfer_handler(struct tdx_tsm_link *tlink, u64 sret,
 static int tdx_spdm_session_connect(struct tdx_tsm_link *tlink)
 {
 	struct spdm_config_info_t *spdm_conf;
+	struct tdx_hpa_list_info info;
 	u64 sret, out_msg_sz;
 	int ret;
 
@@ -168,16 +171,23 @@ static int tdx_spdm_session_connect(struct tdx_tsm_link *tlink)
 
 	spdm_conf->certificate_slot_mask = 0xff;
 
+	ret = tdx_hpa_list_info_setup(&info, tlink->dev_info, tlink->dev_info_nr_pages);
+	if (ret)
+		goto out_free_spdm_conf;
+
 	do {
 		mutex_lock(&tdx_spdm_lock);
 		sret = tdh_spdm_connect(tlink->spdm_id,
 					virt_to_page(spdm_conf),
 					tlink->in_msg, tlink->out_msg,
-					NULL, &out_msg_sz);
+					&info, &out_msg_sz);
 		mutex_unlock(&tdx_spdm_lock);
 		ret = tdx_spdm_xfer_handler(tlink, sret, out_msg_sz);
 	} while (ret == -EAGAIN);
 
+	tdx_hpa_list_info_free(&info);
+
+out_free_spdm_conf:
 	kfree(spdm_conf);
 
 	return ret;
@@ -203,9 +213,11 @@ static int tdx_spdm_create(struct tdx_tsm_link *tlink)
 {
 	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
 	struct page *in_msg_page, *out_msg_page;
+	unsigned int dev_info_nr_pages;
 	struct tdx_hpa_list_info info;
 	unsigned int nr_pages;
 	u64 spdm_id, sret;
+	void *dev_info;
 	void *spdm_mt;
 	int ret;
 
@@ -222,11 +234,17 @@ static int tdx_spdm_create(struct tdx_tsm_link *tlink)
 		goto out_free_in_msg;
 
 	nr_pages = tdx_sysinfo->tdx_connect.spdm_mt_page_count;
+	dev_info_nr_pages = tdx_sysinfo->tdx_connect.spdm_max_dev_info_pages;
+
+	dev_info = alloc_pages_exact(dev_info_nr_pages * PAGE_SIZE,
+				     GFP_KERNEL | __GFP_ZERO);
+	if (!dev_info)
+		goto out_free_out_msg;
 
 	spdm_mt = alloc_pages_exact(nr_pages * PAGE_SIZE,
 				    GFP_KERNEL | __GFP_ZERO);
 	if (!spdm_mt)
-		goto out_free_out_msg;
+		goto out_free_dev_info;
 
 	ret = tdx_hpa_list_info_setup(&info, spdm_mt, nr_pages);
 	if (ret)
@@ -246,10 +264,14 @@ static int tdx_spdm_create(struct tdx_tsm_link *tlink)
 	tlink->in_msg = in_msg_page;
 	tlink->out_msg = out_msg_page;
 	tlink->spdm_mt_nr_pages = nr_pages;
+	tlink->dev_info = dev_info;
+	tlink->dev_info_nr_pages = dev_info_nr_pages;
 	return 0;
 
 out_free_spdm_mt:
 	free_pages_exact(spdm_mt, nr_pages * PAGE_SIZE);
+out_free_dev_info:
+	free_pages_exact(dev_info, dev_info_nr_pages * PAGE_SIZE);
 out_free_out_msg:
 	__free_page(out_msg_page);
 out_free_in_msg:
@@ -272,6 +294,7 @@ static void tdx_spdm_delete(struct tdx_tsm_link *tlink)
 	__free_page(tlink->in_msg);
 	__free_page(tlink->out_msg);
 	free_pages_exact(tlink->spdm_mt, tlink->spdm_mt_nr_pages * PAGE_SIZE);
+	free_pages_exact(tlink->dev_info, tlink->dev_info_nr_pages * PAGE_SIZE);
 }
 
 static int tdx_spdm_session_setup(struct tdx_tsm_link *tlink)
-- 
2.52.0

