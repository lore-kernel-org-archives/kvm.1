Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0253EA97B;
	Wed, 20 May 2026 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284433; cv=none; b=Vre+m3qVhxAssIPvr9ylO+9SQDc91zB0eOeZ/HovxPYA40HX3BgYaXkay0DSsP0pEmHRWRp+7i+2/UCfsIN0U0GumoVvFhsiruFBc+BhLCtqtNLNdM3kPAXD6+hENFst0QV2TSvAIZBXzxEazMszCES7YHBCJC1Az7qtO9MsbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284433; c=relaxed/simple;
	bh=XRVwVR2NLOG1LjcAaIrvI4Up3jDwgvxuJgeTqpfmaTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aX45OJfUI1r+KYlbC6KkazV8REzaKd0/8z7kcU8Ujdl2rJ4gRsdWEl6n6sm5P3xZn7lebLQsc+5q8PCvye658/8U5e37oXjeWmGOY2sP7EQ7mhBBHlqlbcUL0PAwZBf5MGILIcKl9QMNZT69VP6g2u/9X3v56+pohE0b15O89GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4sFg26k; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4sFg26k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284429; x=1810820429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XRVwVR2NLOG1LjcAaIrvI4Up3jDwgvxuJgeTqpfmaTI=;
  b=g4sFg26kCq3WZwNILxFEJE0yM/bbAVHXeXb37TRdfKgvyTGuClrpZf4X
   xINVUtErgB9N2lSYiU8vSaoPfGTjTpuisT8FLO/IVN9cfkyLMe7WhnQWt
   o6NQM5KgC/ble3gvUq0ppZ7cH58CoHfTAR5KuL2xHsUDQde0gX0fyYYpo
   dX5ELtsQUotyP9Xhm0f51jegWtCTh+VsmGeBD63QtAjMPmIYpsqATnVPQ
   ls1gh0Qq3N6rIRV2yTFR8l7wzpEddN+QowFsl8klspEmrenfHmm0rzlQe
   kcx/gQFUN6L2ZIW8gCiIsTHhUNqC/nazfvdjXg2cEDhkReiqpPCuDT/7R
   g==;
X-CSE-ConnectionGUID: RAZmKTSGR4uqa9Z9NScSIQ==
X-CSE-MsgGUID: XH56KSheT6qKHPawhKpkdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146554"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146554"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:23 -0700
X-CSE-ConnectionGUID: eDLnSouLTWuVa8WJR5V/Ag==
X-CSE-MsgGUID: oSWCP1WLRKeqrmVxnouTCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923931"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:21 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	dave.hansen@linux.intel.com,
	djbw@kernel.org,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	kas@kernel.org,
	nik.borisov@suse.com,
	paulmck@kernel.org,
	pbonzini@redhat.com,
	reinette.chatre@intel.com,
	rick.p.edgecombe@intel.com,
	sagis@google.com,
	seanjc@google.com,
	tony.lindgren@linux.intel.com,
	vannapurve@google.com,
	vishal.l.verma@intel.com,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v10 17/25] x86/virt/tdx: Reset software states during TDX module shutdown
Date: Wed, 20 May 2026 06:38:20 -0700
Message-ID: <20260520133909.409394-18-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520133909.409394-1-chao.gao@intel.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX module requires a one-time global initialization (TDH.SYS.INIT) and
per-CPU initialization (TDH.SYS.LP.INIT) before use. These initializations
are guarded by software flags to prevent repetition.

After TDX module updates, the new TDX module requires the same global and
per-CPU initializations, but the existing software flags prevent
re-initialization.

Reset all software flags guarding the initialization flows to allow the
global and per-CPU initializations to be triggered again after updates.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v9:
 - use a global structure for TDX global state and use memset to
 zero the whole structure [Dave]
---
 arch/x86/virt/vmx/tdx/tdx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 84d5df70a250..01d0087180a0 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1278,7 +1278,7 @@ int tdx_module_shutdown(void)
 {
 	struct tdx_sys_info_handoff handoff = {};
 	struct tdx_module_args args = {};
-	int ret;
+	int ret, cpu;
 
 	ret = get_tdx_sys_info_handoff(&handoff);
 	WARN_ON_ONCE(ret);
@@ -1288,7 +1288,21 @@ int tdx_module_shutdown(void)
 	 * module can produce and most likely supported by newer modules.
 	 */
 	args.rcx = handoff.module_hv;
-	return seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
+	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
+	if (ret)
+		return ret;
+
+	/*
+	 * Clear global and per-CPU initialization flags so the new module
+	 * can be fully re-initialized after a successful update.
+	 *
+	 * No locks needed as no concurrent accesses can occur here.
+	 */
+	memset(&tdx_module_state, 0, sizeof(tdx_module_state));
+	for_each_possible_cpu(cpu)
+		per_cpu(tdx_lp_initialized, cpu) = false;
+
+	return 0;
 }
 
 static bool is_pamt_page(unsigned long phys)
-- 
2.52.0

