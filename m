Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1747442372;
	Fri,  4 Sep 2026 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559208; cv=none; b=d3IPySgIO1EaXxrh10qFejzP4EYHK9EdwvM7FXYSz2ts3yIWT1Wn5B/zj5Xl5n0KYhirjeZipDxeT63g73IF0cMXbp9q2+uAL22hb2zb1HLRdqZMUyHQH8eKiN66IvCVJxYBcy+JUA4YEVnIKOJ0gAKYZpHBj0B1H3dkUPJJd9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559208; c=relaxed/simple;
	bh=khFBOgii2vaksXfB+IB8qEqxvM/ZgrRJ8wQFT6sBMOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZ4QmnuxXgP4aeehSImkR77YuAWlutb5H9Uinqf4p+OGhfWXS4H8bKcpeA+oS8CvhA9orEnBjKPaM/xqiDDPNUKkNKL+Y0nkbg2XqZ+kGIHifK9Bj7ZXpclasO8o24+ReBZQGqKVH4xqLuiMuczZ5CKqBK+A3ECmTFYDY1BXcN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2LnN4Fp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2LnN4Fp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788559204; x=1820095204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=khFBOgii2vaksXfB+IB8qEqxvM/ZgrRJ8wQFT6sBMOg=;
  b=g2LnN4Fp+h7px8tGrbAUUdarOdIkGBDhn/zBA6FRHRNYkLF4p2rV8Qtq
   KdgLQODgTLQ50w2bEz1E7MV0mTR8WNUzZlE6vKrEMI9Dopavs9StiCAFW
   n3OGPekK8Hx86H/S89r5U719ZLLWfg3Ugkm+zlamERysLlTdUMtf/rOkx
   hjK+0zybv/vZD1GYBzBRyaBsVnCGcoHYE8gRJ+0+Frkev/GCtPl7955bG
   Pgsovod4jPrYhAOYukjcFeRsizOQf6Fq/FnR6m8hTfnFJtoWueVWenZ2z
   S6dxyy0cA80+P8ZbLC5nC6Cs3aJV7VNpbDietU1B2zkhlhgqdyXMGOQPD
   Q==;
X-CSE-ConnectionGUID: qK4aUcYFSuKG1mazUqRu+g==
X-CSE-MsgGUID: vHDXh7BETl6+WsBvgPa6EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="100224872"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="100224872"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 14:59:24 -0700
X-CSE-ConnectionGUID: m6Ajb7nfQn2gsuWVOehsLw==
X-CSE-MsgGUID: z/HQ6MQnQ5eVAfYeXzrnBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="270675049"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 14:59:24 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: bp@alien8.de,
	dave.hansen@intel.com,
	hpa@zytor.com,
	kas@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	tglx@kernel.org,
	vannapurve@google.com,
	x86@kernel.org,
	chao.gao@intel.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com,
	tony.lindgren@linux.intel.com,
	binbin.wu@intel.com,
	sohil.mehta@intel.com
Cc: rick.p.edgecombe@intel.com,
	Hongyu Ning <hongyu.ning@linux.intel.com>
Subject: [PATCH v11 09/11] x86/virt/tdx: Enable Dynamic PAMT
Date: Fri,  4 Sep 2026 14:58:39 -0700
Message-ID: <20260904215841.303070-10-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904215841.303070-1-rick.p.edgecombe@intel.com>
References: <20260904215841.303070-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Physical Address Metadata Table (PAMT) holds TDX metadata for
physical memory and must be allocated by the kernel during TDX module
initialization. Dynamic PAMT (DPAMT) is a TDX module feature that can
reduce this memory use by allocating part of the PAMT dynamically.

DPAMT's memory savings are significant enough to make it a good default
configuration. So turn it on whenever the TDX module reports support.

There is a TDX module bug where on unusual BIOS keyid configurations, the
TDX module reports DPAMT as supported even when it can't handle it. Expect
this not to be an issue in practice and don't attempt to work around it on
the kernel side.

The feature increases the kernel size by 2KB (when TDX is configured in the
build).

Based on a patch originally by Kiryl Shutsemau.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Vishal Annapurve <vannapurve@google.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
---
v11:
 - Drop kernel param (Dave)

v10:
 - Change "Dynamic PAMT" to "DPAMT" at the second reference in the
   logs. (Dave)
 - Adjust tdx_supports_dynamic_pamt() to check multiple conditions in a
   more tip style. (AI nit checker)
v8:
 - Order tdx_dpamt in kernel-parameters.txt (Sohil)
 - Make tdx_enable_dpamt static (Sashiko)
---
 arch/x86/include/asm/tdx.h  |  1 +
 arch/x86/virt/vmx/tdx/tdx.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 8c7839d61296d..e186dfe5bf885 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -36,6 +36,7 @@
 /* Bit definitions of TDX_FEATURES0 metadata field */
 #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
+#define TDX_FEATURES0_DYNAMIC_PAMT	BIT_ULL(36)
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index ff00ee6d5705a..063574ed86254 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1031,6 +1031,8 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
 	return ret;
 }
 
+#define TDX_SYS_CONFIG_DYNAMIC_PAMT	BIT(16)
+
 static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 				    u64 global_keyid)
 {
@@ -1059,6 +1061,12 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 	args.rcx = __pa(tdmr_pa_array);
 	args.rdx = tdmr_list->nr_consumed_tdmrs;
 	args.r8 = global_keyid;
+
+	if (tdx_supports_dynamic_pamt(&tdx_sysinfo)) {
+		pr_info("Enable Dynamic PAMT\n");
+		args.r8 |= TDX_SYS_CONFIG_DYNAMIC_PAMT;
+	}
+
 	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
 
 	/* Free the array as it is not required anymore. */
@@ -2046,8 +2054,7 @@ EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
 
 bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
 {
-	/* To be enabled when kernel is ready. */
-	return false;
+	return sysinfo->features.tdx_features0 & TDX_FEATURES0_DYNAMIC_PAMT;
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_supports_dynamic_pamt);
 
-- 
2.55.0

