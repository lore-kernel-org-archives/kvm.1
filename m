Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72FC3B3C13;
	Thu, 18 Jun 2026 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771955; cv=none; b=qx2LX0glKiFYd+o1VRS75WII3sJNJKTglVRFUSBfj5VDFppivhzEs7CgoYBl63LnMrftagnpCptfBmHteHK1IR54ZPUpwg0XRaxc7y/v/lp1nEatwHrLcK7mf+UdTjtZY9AwWqSqyGPygWd+AHR88nnC2Fe7Iobvf2TJr6DYzEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771955; c=relaxed/simple;
	bh=iMlGK4AO3+nR1VQWfoojE9PNs8GC6uRIJAlCiJDQhbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTL4Se/MNaRgnmzbLzzTssirbSYPX6lqmvSPpekCkp7Uqiq3hlEiny3vdIsFf6KF302eMhNOSURkkf4wy6p2tAOKbcrQamnq0uCZ4eXp+BQFpCkq74MWcM9DigVy34XZiUep5yKCQb2LOR7Tj7fTLrPqP3t0MSd9Rk3QyO85i18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RShK8wJC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RShK8wJC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781771954; x=1813307954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iMlGK4AO3+nR1VQWfoojE9PNs8GC6uRIJAlCiJDQhbw=;
  b=RShK8wJCiCLLWdPszOZWCM6JLxAbzKHGIVvv3Hl6avVyMmcvLs5aJEzY
   e/eQoopUSGc9W3GvwiJkQA0NNpcD/ZKITX3AtMN/iftczx0++1e+Ykmav
   6qMAS/8IdM+83OWBVfrHPtWZICitmCjTIpTWF5qCmKihERLJ2qQntgODn
   kG+PLVE9ARpQupQC3PZ1BicnBy4/iaBoyp3m+xF7cCpEwYg+DrVWszAAQ
   WXLZkWIXUUmHxE5Yecc2xI4JHhvHCKo+ZQuy/V/xn4s0njgi0bjURFrF2
   NKyG5shqZFeLfzkFDcXYeM9geRBXFnEYlGfqc7hdjDEhpJ/kIQ+Y05nEc
   g==;
X-CSE-ConnectionGUID: 9qzaLZzeQ1WAx9hhguLmZg==
X-CSE-MsgGUID: kdyuPPmYQTqL3rH8ilMVhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584627"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584627"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:39:14 -0700
X-CSE-ConnectionGUID: fLEY11wOQma1AKmR5aB8MQ==
X-CSE-MsgGUID: dv5RO86ERKubDJcFR3fKRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392180"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:39:09 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: djbw@kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	sohil.mehta@intel.com,
	adrian.hunter@intel.com,
	kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com,
	peter.fang@intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	seanjc@google.com
Subject: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions initialization is required
Date: Thu, 18 Jun 2026 16:13:41 +0800
Message-Id: <20260618081355.3253581-4-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX module extensions support extension SEAMCALLs that are preemptible
and resumable, unlike normal SEAMCALLs that run to completion while
monopolizing the CPU. This allows for higher-level API constructions,
so better supports some add-on features that implement higher order
security protocols.

Add infrastructure to initialize TDX module extensions. Introduce the
initial step of this process by detecting if the extensions are required
by checking:

  1. If the extensions are supported via TDX_FEATURES0_EXT.
  2. If any TDX add-on feature needs the extensions via a boolean
     metadata field ext_required.

Currently all metadata fields are read at the very beginning of basic
TDX initialization and stored in a global var. However, ext_required is
only valid after the add-on feature configuration, making it
incompatible with the existing metadata reading method.

To resolve this lifetime conflict, add a dedicated runtime metadata
reading interface for the extensions, call it when the extensions
initialization starts, and leave the field out of the global var. In
this way, there is no confusion of when the metadata should be read.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h                  |  1 +
 arch/x86/include/asm/tdx_global_metadata.h  |  4 ++++
 arch/x86/virt/vmx/tdx/tdx.c                 | 25 +++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 14 ++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index e5a9cf656c07..5fbf89d5317c 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -35,6 +35,7 @@
 /* Bit definitions of TDX_FEATURES0 metadata field */
 #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
+#define TDX_FEATURES0_EXT		BIT_ULL(39)
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index 41150d546589..83fc657a438e 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -52,4 +52,8 @@ struct tdx_sys_info {
 	struct tdx_sys_info_td_conf td_conf;
 };
 
+struct tdx_sys_info_ext {
+	bool ext_required;
+};
+
 #endif
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 92305b5ea90d..6f3596f11d25 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1166,6 +1166,27 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
 	return 0;
 }
 
+static __init int init_tdx_module_extensions(void)
+{
+	struct tdx_sys_info_ext sysinfo_ext;
+	int ret;
+
+	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
+		return 0;
+
+	ret = get_tdx_sys_info_ext(&sysinfo_ext);
+	if (ret)
+		return ret;
+
+	/* Skip if no feature requires TDX module extensions. */
+	if (!sysinfo_ext.ext_required)
+		return 0;
+
+	/* TODO: add the extensions enabling steps here */
+
+	return 0;
+}
+
 static __init int init_tdx_module(void)
 {
 	int ret;
@@ -1220,6 +1241,10 @@ static __init int init_tdx_module(void)
 	if (ret)
 		goto err_reset_pamts;
 
+	ret = init_tdx_module_extensions();
+	if (ret)
+		goto err_reset_pamts;
+
 	pr_info("%lu KB allocated for PAMT\n", tdmrs_count_pamt_kb(&tdx_tdmr_list));
 
 out_put_tdxmem:
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index e49c300f23d4..b9e1c011a990 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -131,3 +131,17 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 
 	return ret;
 }
+
+static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
+{
+	int ret;
+	u64 val;
+
+	ret = read_sys_metadata_field(0x3100000000000001, &val);
+	if (ret)
+		return ret;
+
+	sysinfo_ext->ext_required = val;
+
+	return 0;
+}
-- 
2.25.1

