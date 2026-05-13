Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E647A0D8;
	Wed, 13 May 2026 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685099; cv=none; b=Od0ERNmlsRhDWcPd7ooeJoqiS04fqfOexfxZluAGVGyfk+9J3CKkmmXp8TrBmZSDB5fFjVz4iXPz4Ifx/YU9Tgj4dQ5GHAUXuqHCP7KkCEQ1jnzRMv3UnLNqNcFjMjlhHaOZx4Ii7fFmHd1wWK85uFGDgOW97lAsk3/gDCX8tKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685099; c=relaxed/simple;
	bh=Q8zn3+57xVhPeBvtlErti71SyryRapBvOpJGYi2Iikc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNGGRDajOfT553aLzye3kCuBVYnonj7uopfAU4Ncoj1T4m1nfKz++PqgkQZM79mxZZbffUuUS3TzAnsrfbCO/oaxZbHiqJYoQgl9voFGYRkG5C29J3vexQ4KaJSvEBm7XFZfU/qi5KGYxtygIHfhgFvziMdxMj7SfCkXtbHtMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLrbuqcf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLrbuqcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685098; x=1810221098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q8zn3+57xVhPeBvtlErti71SyryRapBvOpJGYi2Iikc=;
  b=FLrbuqcfgPuUoM5Aa3XlKI8jItNt5GvcPotoXZq+LciuhLPnQGzZIcAH
   CH8OpwN/R2n6CBOqKiZHN2BJ6VHYsINx610Xqj3ucZMSuNnNB2XTiFx33
   crIHNKhVsBAeePpInFS/xssC+LoH4gsAbqnbMsYkx+qE4VVzf+GvmWu1M
   crsbvhqPHYyttXnGOzHfM5cuOd73dzcrCpiFsYcMnzo6fBXXTHSx7zd4U
   vVo4QuEtEhT6bmGiIQGjp4nxQu6NrS9rYNBxQlfTWnRVZheQ97FBGFSCd
   DzO4H8BIRobcUI2XSM+LmroijLOy78OBWpNyoeG7kfmOTldqP5L4BKqLI
   g==;
X-CSE-ConnectionGUID: YKxWKhidSSaFFeyW8CtyVg==
X-CSE-MsgGUID: SGLrYdDmRMuofoSrpQJpGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89921581"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89921581"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:36 -0700
X-CSE-ConnectionGUID: gUe4APOGSDaDVrAFRgqSDg==
X-CSE-MsgGUID: EK3lNoAYSYyJplpO0ga00Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231716742"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:36 -0700
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
Subject: [PATCH v9 01/23] x86/virt/tdx: Consolidate TDX global initialization states
Date: Wed, 13 May 2026 08:09:44 -0700
Message-ID: <20260513151045.1420990-2-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513151045.1420990-1-chao.gao@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
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
the module can be initialized again. Today those states are kept as separate
global variables, which makes the reset path awkward and easy to miss when
a new state is added.

Group the states into a single structure so they can be reset together, for
example with memset(), and so a newly added state won't be missed.

Drop the __ro_after_init annotation from tdx_module_initialized because
the other two states do not have it. And with TDX module update support,
all the states need to be writable at runtime.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index c0c6281b08a5..0172b432f229 100644
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
 
@@ -113,30 +119,28 @@ static int try_init_module_global(void)
 {
 	struct tdx_module_args args = {};
 	static DEFINE_RAW_SPINLOCK(sysinit_lock);
-	static bool sysinit_done;
-	static int sysinit_ret;
 
 	raw_spin_lock(&sysinit_lock);
 
-	if (sysinit_done)
+	if (tdx_module_state.sysinit_done)
 		goto out;
 
 	/* RCX is module attributes and all bits are reserved */
 	args.rcx = 0;
-	sysinit_ret = seamcall_prerr(TDH_SYS_INIT, &args);
+	tdx_module_state.sysinit_ret = seamcall_prerr(TDH_SYS_INIT, &args);
 
 	/*
 	 * The first SEAMCALL also detects the TDX module, thus
 	 * it can fail due to the TDX module is not loaded.
 	 * Dump message to let the user know.
 	 */
-	if (sysinit_ret == -ENODEV)
+	if (tdx_module_state.sysinit_ret == -ENODEV)
 		pr_err("module not loaded\n");
 
-	sysinit_done = true;
+	tdx_module_state.sysinit_done = true;
 out:
 	raw_spin_unlock(&sysinit_lock);
-	return sysinit_ret;
+	return tdx_module_state.sysinit_ret;
 }
 
 /**
@@ -1299,7 +1303,7 @@ static __init int tdx_enable(void)
 
 	register_syscore(&tdx_syscore);
 
-	tdx_module_initialized = true;
+	tdx_module_state.initialized = true;
 	pr_info("TDX-Module initialized\n");
 	return 0;
 }
@@ -1554,7 +1558,7 @@ void __init tdx_init(void)
 
 const struct tdx_sys_info *tdx_get_sysinfo(void)
 {
-	if (!tdx_module_initialized)
+	if (!tdx_module_state.initialized)
 		return NULL;
 
 	return (const struct tdx_sys_info *)&tdx_sysinfo;
-- 
2.52.0

