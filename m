Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0218C3B2FE3;
	Thu, 18 Jun 2026 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771951; cv=none; b=DXrQahDUKbNMHwYRXbyy6FQj4eaIw4OWzD8t8CAuYUEvJyKtJ3zVNuEgFiXxNmqHIgLFen320KYYvESnbcUZmDMjWMNApzOeVOMhOYC5SECU4m4o7oGhd2JTIE/dCkWW+h5vyOj+Klq/yflwhqs11Ptuxr46df7kmgX4ph60JCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771951; c=relaxed/simple;
	bh=jALD5JuBbc7jPW9AH/GNRYzqXX4FFPLMN38BBRy1SCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u3GZBkevJn13g8MAnV13EK0CdL3mcePJqVpar1d0xK3UC2T/IwSAgr4vhDRo+oV8zoopPDZG6P+faxYrJBMWlcbFBHe//T8psPCnUGEur3j2lhQEriU5ERV9u1uEIxxYpHQCF+kejKAJMSvMAPdu40GD5VUvQrd1Gm+Fn353XGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZfNZ7X5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZfNZ7X5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781771950; x=1813307950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jALD5JuBbc7jPW9AH/GNRYzqXX4FFPLMN38BBRy1SCc=;
  b=EZfNZ7X5ktddo0T9nvdEz1t1nYm5lMr6n9Zwd0XOWjpJ1poWCiv6ZWRl
   UXowIYgwgMWYqOK04U3wDQmutKoglmpJmkN9nVdsRNpPdXu2kExXNfr5r
   yhFbCbasdNNwcmOovtkm8MqKrLhYP67e40e1//FwubO7N4rJyis7Fans0
   UiShdplkFFPTI++Zn3WZ12djy3CK8WRF8qkzaI3IEk8YJrCeMZO3QgDs4
   SRUka1KCZCq6EDk4B2KFv+UHEVh1KXHmG/NtjMTpDWcYFCucMnzbvzlNH
   hkTiY7KEKUpE4qHeuWVBzem39mkYeP3oIALoH3MR0IZY1V8+dYBOXdt8j
   Q==;
X-CSE-ConnectionGUID: tWbp4qfARRGJF96/OUrfMg==
X-CSE-MsgGUID: dKjPRCzkTkGFdlKCs+IMKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584620"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584620"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:39:09 -0700
X-CSE-ConnectionGUID: WC27EmvlQqK9XybcwetbTQ==
X-CSE-MsgGUID: n2Mk+hjBQO2UK1yA6pPMnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392157"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:39:05 -0700
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
Subject: [PATCH v2 02/17] x86/virt/tdx: Configure add-on features on TDX module init and update
Date: Thu, 18 Jun 2026 16:13:40 +0800
Message-Id: <20260618081355.3253581-3-yilun.xu@linux.intel.com>
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

In addition to basic TDX functionalities, TDX module provides add-on
features that can be progressively enabled as the kernel supports them.
The kernel should explicitly configure these features at boot or
post-update initialization time. Configuring an add-on feature, such as
TDX Quoting, that uses extension SEAMCALLs is the prerequisite for
initializing TDX module extensions. TDX Quoting is the target feature to
enable but defer it for now until full kernel support is in place.

TDX module extends TDH.SYS.CONFIG and TDH.SYS.UPDATE with new bitmap
input parameters to specify which add-on features to configure. The
bitmap uses the same definitions as TDX_FEATURES0.

For runtime update, Linux applies a policy that no newer features should
be added after update to avoid disrupting live TDX operations. To adhere
to this, TDH.SYS.UPDATE must configure the same features as the
TDH.SYS.CONFIG. Record the kernel required add-on feature bitmap in a
global var so that both phases can use it.

TDX module advances the version of TDH.SYS.CONFIG and TDH.SYS.UPDATE for
the change, so use the latest version (v1) for add-on feature enabling.
But supporting existing modules which only support v0 is still necessary
until they are deprecated. In fact, it is unlikely that TDH.SYS.CONFIG
ever needs to change again and the code would stay in v1. So there is
little value in worrying about deprecating v0 to save a couple lines of
code in 5-7 years when these original TDX platforms sunset.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.h |  6 ++++--
 arch/x86/virt/vmx/tdx/tdx.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index fbb520704662..a47e872480c7 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -58,9 +58,11 @@
 #define TDH_PHYMEM_CACHE_WB		40
 #define TDH_PHYMEM_PAGE_WBINVD		41
 #define TDH_VP_WR			43
-#define TDH_SYS_CONFIG			45
+#define TDH_SYS_CONFIG_V0		45
+#define TDH_SYS_CONFIG			SEAMCALL_LEAF_VER(TDH_SYS_CONFIG_V0, 1)
 #define TDH_SYS_SHUTDOWN		52
-#define TDH_SYS_UPDATE			53
+#define TDH_SYS_UPDATE_V0		53
+#define TDH_SYS_UPDATE			SEAMCALL_LEAF_VER(TDH_SYS_UPDATE_V0, 1)
 #define TDH_SYS_DISABLE			69
 
 /* TDX page types */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 2a03152796e6..92305b5ea90d 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -57,6 +57,7 @@ static struct tdx_module_state tdx_module_state;
 static u32 tdx_global_keyid __ro_after_init;
 static u32 tdx_guest_keyid_start __ro_after_init;
 static u32 tdx_nr_guest_keyids __ro_after_init;
+static u64 tdx_addon_feature0 __ro_after_init;
 
 static DEFINE_IDA(tdx_guest_keyid_pool);
 
@@ -1004,9 +1005,18 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
 	return ret;
 }
 
+static __init void set_tdx_addon_features(void)
+{
+	/*
+	 * To add DICE-based TDX Quoting feature bit in tdx_addon_feature0 when
+	 * kernel is ready.
+	 */
+}
+
 static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 				    u64 global_keyid)
 {
+	u64 seamcall_fn = TDH_SYS_CONFIG_V0;
 	struct tdx_module_args args = {};
 	u64 *tdmr_pa_array;
 	size_t array_sz;
@@ -1032,7 +1042,15 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 	args.rcx = __pa(tdmr_pa_array);
 	args.rdx = tdmr_list->nr_consumed_tdmrs;
 	args.r8 = global_keyid;
-	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
+
+	set_tdx_addon_features();
+
+	if (tdx_addon_feature0) {
+		args.r9 = tdx_addon_feature0;
+		seamcall_fn = TDH_SYS_CONFIG;
+	}
+
+	ret = seamcall_prerr(seamcall_fn, &args);
 
 	/* Free the array as it is not required anymore. */
 	kfree(tdmr_pa_array);
@@ -1314,10 +1332,16 @@ int tdx_module_shutdown(void)
 
 int tdx_module_run_update(void)
 {
+	u64 seamcall_fn = TDH_SYS_UPDATE_V0;
 	struct tdx_module_args args = {};
 	int ret;
 
-	ret = seamcall_prerr(TDH_SYS_UPDATE, &args);
+	if (tdx_addon_feature0) {
+		args.r9 = tdx_addon_feature0;
+		seamcall_fn = TDH_SYS_UPDATE;
+	}
+
+	ret = seamcall_prerr(seamcall_fn, &args);
 	if (ret)
 		return ret;
 
-- 
2.25.1

