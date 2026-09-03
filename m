Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99320314B63;
	Thu,  3 Sep 2026 01:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400298; cv=none; b=lE2e0doJigXuS5M5xr7FJYDEe8ujx6dg4Lur+XGEVfV/OXmCg5VLuYzsGk5547XWcQ4xYcfBJNgZoaS9kJGVRPwTMqks+OQkcSL+uhc+QUHedNgxtUBi+K0GmrJ/7GdnPXtIUNzaYprqXV/K3FDzl+te7X4V8y7cOx6SXyYKFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400298; c=relaxed/simple;
	bh=dtu1ggg5VIypqWoDzB4J7tyX0oD/kIqG7vXK2qDzpJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smakK/7tnf1OUsRT1EOE3Ozbw/17XhEzruekWk4tlaLhrG4vJIIRtxGi3XCs3Ay2RkBEK/nRwE8jFk9ycTTvfGEB5PiMD2MHMODbWbce5DHdNFYEIcAZF8XJMO4esqWv/HsgJwjzGMV3CCxBfKh29P7oR4g4djDz9p9roe7oEN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKgH04P5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKgH04P5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788400296; x=1819936296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dtu1ggg5VIypqWoDzB4J7tyX0oD/kIqG7vXK2qDzpJE=;
  b=aKgH04P5aTG0XMYUqGhGHMXwpc069Y3lTUPYGlH88P03oJzkMlz1XjH2
   KuXk7L0gRKYeouL+s+g0VF37qGVyKyH7QIHnOEhoCDtpgWGIyIMRoYft4
   L6sgkcqhbFXuxYJylYxz1FGk+Zcolzy1obwuJ/XKcolZ9AfTj+65fgmXW
   WbKeZ9wq8jK64bxDmH8MbsWf7MoOBWmeQOWVXUn4AYlXuMeyOjmOXIu5d
   zNOmGVVqhpEt8tA8CssDTVuHgysevkU+3lUQMvKSFZ80qIuXqxjmceky9
   IMD4yafjKpXQJ9HPcrdDD/CxxrudCuyGYMh0ydxCWzoLd957a15i23apN
   g==;
X-CSE-ConnectionGUID: P1ZWqpjZRk2sgWU0OOoYsA==
X-CSE-MsgGUID: 4xVhqUdgQL+dq/4LjOjHDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99469184"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99469184"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:51:24 -0700
X-CSE-ConnectionGUID: S0y2GxwPSI6AMG6uNKS59g==
X-CSE-MsgGUID: fVqLM6QtTWq1a7Bjr3cajQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307770238"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:51:22 -0700
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
Subject: [PATCH v10 09/11] x86/virt/tdx: Enable Dynamic PAMT
Date: Wed,  2 Sep 2026 18:51:11 -0700
Message-ID: <20260903015113.93343-10-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
References: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
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

The TDX module exposes whether DPAMT is supported via a bit in the
'features0' metadata. Unfortunately, the TDX module exposes the feature as
supported even when it does not support using it with the number of keyids
currently configured in the BIOS. Since no TDX modules exist today with
that issue fixed, make the feature default off to prevent users from
upgrading their kernel and encountering TDX erroring out when trying to
enable DPAMT.

For the decision of whether to make it a boot time option and/or compile
time option, consider that DPAMT's memory savings are significant enough
to make it a good default configuration. That is most TDX users should
want it unless they have strange keyid configurations.

The feature increases the kernel size by 2KB (when TDX is configured in the
build).

All pieces are in place to enable DPAMT if it is supported and the user
passes a kernel parameter.

AI was used to review code. It made a style suggestion.

Based on a patch originally by Kiryl Shutsemau.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Vishal Annapurve <vannapurve@google.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Change "Dynamic PAMT" to "DPAMT" at the second reference in the
   logs. (Dave)
 - Adjust tdx_supports_dynamic_pamt() to check multiple conditions in a
   more tip style. (AI nit checker)
v8:
 - Order tdx_dpamt in kernel-parameters.txt (Sohil)
 - Make tdx_enable_dpamt static (Sashiko)

v7:
 - Add kernel parameter following some twists and turns, deriving
   originally from a comment by (Chao)
---
 .../admin-guide/kernel-parameters.txt         |  7 ++++++
 arch/x86/include/asm/tdx.h                    |  1 +
 arch/x86/virt/vmx/tdx/tdx.c                   | 23 +++++++++++++++++--
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd24..f32aa58f744a1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7582,6 +7582,13 @@ Kernel parameters
 
 	tdfx=		[HW,DRM]
 
+	tdx_dpamt=
+			[X86] Controls whether TDX will use Dynamic PAMT
+			to save memory, when supported.
+
+			Valid parameters: "on", "off"
+			Default: "off"
+
 	test_suspend=	[SUSPEND]
 			Format: { "mem" | "standby" | "freeze" }[,N]
 			Specify "mem" (for Suspend-to-RAM) or "standby" (for
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
index ff00ee6d5705a..3daa8c63f9c51 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -50,6 +50,8 @@
 /* Number of DPAMT pages to be provided to TDX module per 2MB region of PA */
 #define TDX_DPAMT_ENTRY_PAGE_CNT 2
 
+static bool tdx_enable_dpamt __ro_after_init;
+
 struct tdx_module_state {
 	bool initialized;
 	bool sysinit_done;
@@ -1031,6 +1033,8 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
 	return ret;
 }
 
+#define TDX_SYS_CONFIG_DYNAMIC_PAMT	BIT(16)
+
 static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 				    u64 global_keyid)
 {
@@ -1059,6 +1063,12 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
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
@@ -2046,8 +2056,10 @@ EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
 
 bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
 {
-	/* To be enabled when kernel is ready. */
-	return false;
+	if (!tdx_enable_dpamt)
+		return false;
+
+	return sysinfo->features.tdx_features0 & TDX_FEATURES0_DYNAMIC_PAMT;
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_supports_dynamic_pamt);
 
@@ -2308,6 +2320,13 @@ void tdx_free_control_page(struct page *page)
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_free_control_page);
 
+static int __init tdx_dpamt_setup(char *str)
+{
+	return kstrtobool(str, &tdx_enable_dpamt) == 0;
+}
+
+__setup("tdx_dpamt=", tdx_dpamt_setup);
+
 void tdx_sys_disable(void)
 {
 	struct tdx_module_args args = {};
-- 
2.55.0

