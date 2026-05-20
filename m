Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488373AA1B2;
	Wed, 20 May 2026 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284408; cv=none; b=oVxTeIFdI7vzq//f2bRHzUg3O9Iafgg48lSOeCDPS8MLHCcv4AZFP5zFrkCnMOo/+2VBeV+e4j9OR4+YGFNdE1KREFdadM4VpOnXsdFbiF6+y9QG7k+JDG3bnsrIQ+F0trgafcZ+tGE7gcsQtu8Ahut9prHO1Hhe7wBwCg10V60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284408; c=relaxed/simple;
	bh=pYwWR633SCu4170yEG3u38P71vF4aiFiBV8uRgld4Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WW3BEsjYE8w9v26eSSW82eQGD7/x4is0wsReefVvfw/tzgjDWVwzLGWuU+uLx+rvZSs43NhgZw3SDoa3Zwx2SfJhiAdi5tEYVNan+ueQLHi57or2qDPls8ExMm/tg3JbpEmjQjdz2uvf1dns5yco6i33XwIBl5vTahZ5tkroRzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhK7NxaE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhK7NxaE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284405; x=1810820405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pYwWR633SCu4170yEG3u38P71vF4aiFiBV8uRgld4Bk=;
  b=HhK7NxaEO6kFu145o9vajYDaUIf5ivKJiCqPFALSAuQJ7d7d4ThBK0GJ
   rCARWESi/pSp4f6BYtfY6Q6TA4HbhkrVx5NCxbOQVCTgIHajzgN6NmDGb
   0GT5J1GbHrqjX6Jf57xjfJFyQipOj1+27ZUrPQEARW9MfqIuoSh/9bH34
   5qYEVxCJ//EwgrJRwJiFss5rHJzoA9Zv+q7zUE2QD5xjRdIvVDcLd1hrn
   dqN61+APrrqOE94dZriLFAPCQuI1uAcO33gGxu9f8WKghkuamROATQfFn
   hrVw/zoOdAo7Dk4v0qZLlhNSUXNou9isGWyj01tYzRXt+MlDOcaNI66Us
   Q==;
X-CSE-ConnectionGUID: UE7u/h6eTWWul5DI0n8ZiQ==
X-CSE-MsgGUID: 8RPFRUkiTGqx+xWZHfXxGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146409"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146409"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:03 -0700
X-CSE-ConnectionGUID: N0cyFpTcQbSqoKy6pv3TTg==
X-CSE-MsgGUID: GsjXY3yJSP6voBnVDe6X6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923641"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:01 -0700
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
Subject: [PATCH v10 03/25] x86/virt/tdx: Consolidate TDX global initialization states
Date: Wed, 20 May 2026 06:38:06 -0700
Message-ID: <20260520133909.409394-4-chao.gao@intel.com>
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

The kernel uses several global flags to guard one-time TDX initialization
flows and prevent them from being repeated.

When the TDX module is updated, all of those states must be reset so that
the module can be initialized again. Today those states are kept as
separate global variables, which makes the reset path awkward and easy to
miss when a new state is added.

Group the states into a single structure so they can be reset together, for
example with memset(), and so a newly added state won't be missed.

Drop the __ro_after_init annotation from tdx_module_initialized because
the other two states do not have it. And with TDX module update support,
all the states need to be writable at runtime.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 40444a3c5cdd..71d39a79ef3f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -44,6 +44,13 @@
 #include <asm/virt.h>
 #include "tdx.h"
 
+struct tdx_module_state {
+	bool initialized;
+	bool sysinit_done;
+	int sysinit_ret;
+};
+
+static struct tdx_module_state tdx_module_state;
 static u32 tdx_global_keyid __ro_after_init;
 static u32 tdx_guest_keyid_start __ro_after_init;
 static u32 tdx_nr_guest_keyids __ro_after_init;
@@ -58,7 +65,6 @@ static struct tdmr_info_list tdx_tdmr_list;
 static LIST_HEAD(tdx_memlist);
 
 static struct tdx_sys_info tdx_sysinfo __ro_after_init;
-static bool tdx_module_initialized __ro_after_init;
 
 typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
 
@@ -106,8 +112,6 @@ static __always_inline int sc_retry_prerr(sc_func_t func,
 	sc_retry_prerr(__seamcall_ret, seamcall_err_ret, (__fn), (__args))
 
 static DEFINE_RAW_SPINLOCK(sysinit_lock);
-static bool sysinit_done;
-static int sysinit_ret;
 
 /*
  * Do the module global initialization once and return its result.
@@ -121,8 +125,8 @@ static int try_init_module_global(void)
 	raw_spin_lock(&sysinit_lock);
 
 	/* Return the "cached" return code. */
-	if (sysinit_done) {
-		ret = sysinit_ret;
+	if (tdx_module_state.sysinit_done) {
+		ret = tdx_module_state.sysinit_ret;
 		goto out;
 	}
 
@@ -139,8 +143,8 @@ static int try_init_module_global(void)
 		pr_err("module not loaded\n");
 
 	/* Save the return code for later callers. */
-	sysinit_done = true;
-	sysinit_ret = ret;
+	tdx_module_state.sysinit_done = true;
+	tdx_module_state.sysinit_ret = ret;
 out:
 	raw_spin_unlock(&sysinit_lock);
 	return ret;
@@ -1306,7 +1310,7 @@ static __init int tdx_enable(void)
 
 	register_syscore(&tdx_syscore);
 
-	tdx_module_initialized = true;
+	tdx_module_state.initialized = true;
 	pr_info("TDX-Module initialized\n");
 	return 0;
 }
@@ -1561,7 +1565,7 @@ void __init tdx_init(void)
 
 const struct tdx_sys_info *tdx_get_sysinfo(void)
 {
-	if (!tdx_module_initialized)
+	if (!tdx_module_state.initialized)
 		return NULL;
 
 	return (const struct tdx_sys_info *)&tdx_sysinfo;
-- 
2.52.0

