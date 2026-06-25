Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4026D31328E;
	Thu, 25 Jun 2026 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369244; cv=none; b=nirKTvAxdFFW2leMzoa/V/39R37DStrEu52+7PzuVXJBGcnxxBG4Rc027GGm5BhnPjfUHiSWUz3WMFCCBW4gTA/gGhX5TSAnOP99uMlFY+Vexs3KdTEIFIcMwZiU1LATc10oO5yYOOmK4QuHRtGm1WnhdEPZVx+kyGCJoZH0rTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369244; c=relaxed/simple;
	bh=yTW+2pnex5nkPADO6CvSxNrZzpX8ReEi1EuOZBv2vkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw/frloKWBEyfoC+rvarWtmauQnwji0OSCCqBliRt5ZhCkBpF9FFpFA/pSuNg76BR8919V9rxbUdeVfwczSdaM8ANZVBSNEmZt99tyPBui6rbKn7kjlvLqXdm6Z13pJt1rCZq8UKlwRPBB0mVGBOHvzVZRhCy0kf3Oql9sPlXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQBVNdRI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQBVNdRI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782369243; x=1813905243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yTW+2pnex5nkPADO6CvSxNrZzpX8ReEi1EuOZBv2vkY=;
  b=MQBVNdRIMFBiW0E8hxdWM+iUuvf+VHZSAohZo8JDOZPGSkPz/FVCtRPn
   70hGd8kpEG2mKudMAu7adMSS55viK+imoBkEIZV9JqHVXSFwyobT4k75x
   CQoi1rYbtYpt9BCS954PcB6htGj33/iHEXWsWmX1rEOfw2568jkC41DFN
   AMQGnXbOpSiPCt6FTwpcRDoXwRL/N1LEqC8B9sAH/7ILmBQ/9XIaM2L9E
   uP92ouHY+G1NnTsVlfT0cHs7Wmt0YR7C1m2JhSvWyAy7KGeKoL4PSFv6M
   sBVLioQpPIRbYL7JH/sFsawVvNgQqffeoNtw+FzwjwPfJK6W7a4BxTvKm
   g==;
X-CSE-ConnectionGUID: dcH6jb6fSW+Up3q67Ai6BA==
X-CSE-MsgGUID: +xeHR4tjQiWOitwWxKcfTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="93794068"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="93794068"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:34:03 -0700
X-CSE-ConnectionGUID: EMbBFf/TQIOEyY13Sj7ssQ==
X-CSE-MsgGUID: NJFkV2J8QxujSUOQH4dKZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="288495401"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 24 Jun 2026 23:33:59 -0700
Date: Thu, 25 Jun 2026 14:33:57 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
	kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, dave.hansen@linux.intel.com,
	seanjc@google.com
Subject: Re: [PATCH v2 02/17] x86/virt/tdx: Configure add-on features on TDX
 module init and update
Message-ID: <ajzL1aO7wtl5GEsU@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-3-yilun.xu@linux.intel.com>
 <4f4b0f29-424b-45ed-8cfd-c77da2ea390f@intel.com>
 <ajvG54UMcf3vbJez@yilunxu-OptiPlex-7050>
 <20260624221037.GD923079@pedri>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624221037.GD923079@pedri>

On Wed, Jun 24, 2026 at 03:10:37PM -0700, Peter Fang wrote:
> On Wed, Jun 24, 2026 at 08:00:39PM +0800, Xu Yilun wrote:
> > > There's also zero stopping us from putting version in args:
> > > 
> > > 	struct tdx_module_args args = {};
> > >   	int ret;
> > > 
> > > 	if (tdx_addon_feature0) {
> > > 		args.r9 = tdx_addon_feature0;
> > > 		args.version = 1;
> > > 	}
> > > 
> > > 	ret = seamcall_prerr(TDH_SYS_UPDATE, &args);
> > > 
> > > Eh?
> > > 
> > > That gives args.version==0 in all the normal cases which just happens to
> > > be the exact behavior we want. It also avoids having to plumb version
> > > through all the seamcall*() wrappers.
> > 
> > Ah, on 2nd reading, I'm pretty sure now I understand your logical argument in
> > patch 1 and 2. It's good to me. I append my diff at the end.
> > 
> 
> [ ... ]
> 
> > diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
> > index 016a2a1ec1d6..d1d3d40c5614 100644
> > --- a/arch/x86/virt/vmx/tdx/tdxcall.S
> > +++ b/arch/x86/virt/vmx/tdx/tdxcall.S
> > @@ -48,6 +48,14 @@
> >         /* Move Leaf ID to RAX */
> >         mov %rdi, %rax
> > 
> > +       /*
> > +        * Extract the version from 'struct tdx_module_args', append it to
> > +        * RAX[23:16]
> > +        */
> > +       movzbl  TDX_MODULE_version(%rsi), %ecx
> > +       shll    $16, %ecx
> > +       orq     %rcx, %rax
> > +
> >         /* Move other input regs from 'struct tdx_module_args' */
> >         movq    TDX_MODULE_rcx(%rsi), %rcx
> >         movq    TDX_MODULE_rdx(%rsi), %rdx
> 
> This approach looks much cleaner to me. Would it be better to have a
> small C helper to encode the final RAX value instead of operating on RAX
> directly in asm? Looking at the May 2026 edition of the ABI spec,
> SEAMCALL RAX encoding is starting to get quite complex. Just thinking
> about this from a readability standpoint.

I'm also good to it. I made some diff for your proposal, Some additional
effort here is to update some comments and parameter names, to reflect
the differences between "function/func/fn" (the unversioned number) and
the final composite "fn_code" for RAX.

-----8<-------

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index f20e91d7ac35..c26eca18fded 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -143,6 +143,8 @@ struct tdx_module_args {
 	u64 rbx;
 	u64 rdi;
 	u64 rsi;
+	/* for leaf encoding */
+	u8  version;
 };
 
 /* Used to communicate with the TDX module */
diff --git a/arch/x86/virt/vmx/tdx/seamcall.S b/arch/x86/virt/vmx/tdx/seamcall.S
index 6854c52c374b..5cf3993e98f4 100644
--- a/arch/x86/virt/vmx/tdx/seamcall.S
+++ b/arch/x86/virt/vmx/tdx/seamcall.S
@@ -10,8 +10,8 @@
  *
  * __seamcall() function ABI:
  *
- * @fn   (RDI)  - SEAMCALL Leaf number, moved to RAX
- * @args (RSI)  - struct tdx_module_args for input
+ * @fn_code (RDI)  - SEAMCALL composite leaf code, moved to RAX
+ * @args    (RSI)  - struct tdx_module_args for input
  *
  * Only RCX/RDX/R8-R11 are used as input registers.
  *
@@ -29,8 +29,8 @@ SYM_FUNC_END(__seamcall)
  *
  * __seamcall_ret() function ABI:
  *
- * @fn   (RDI)  - SEAMCALL Leaf number, moved to RAX
- * @args (RSI)  - struct tdx_module_args for input and output
+ * @fn_code (RDI)  - SEAMCALL composite leaf code, moved to RAX
+ * @args    (RSI)  - struct tdx_module_args for input and output
  *
  * Only RCX/RDX/R8-R11 are used as input/output registers.
  *
@@ -51,8 +51,8 @@ SYM_FUNC_END(__seamcall_ret)
  *
  * __seamcall_saved_ret() function ABI:
  *
- * @fn   (RDI)  - SEAMCALL Leaf number, moved to RAX
- * @args (RSI)  - struct tdx_module_args for input and output
+ * @fn_code (RDI)  - SEAMCALL composite leaf code, moved to RAX
+ * @args    (RSI)  - struct tdx_module_args for input and output
  *
  * All registers in @args are used as input/output registers.
  *
diff --git a/arch/x86/virt/vmx/tdx/seamcall_internal.h b/arch/x86/virt/vmx/tdx/seamcall_internal.h
index be5f446467df..bb17d965b453 100644
--- a/arch/x86/virt/vmx/tdx/seamcall_internal.h
+++ b/arch/x86/virt/vmx/tdx/seamcall_internal.h
@@ -11,17 +11,28 @@
 #ifndef _X86_VIRT_SEAMCALL_INTERNAL_H
 #define _X86_VIRT_SEAMCALL_INTERNAL_H
 
+#include <linux/bitfield.h>
 #include <linux/printk.h>
 #include <linux/types.h>
 #include <asm/archrandom.h>
 #include <asm/processor.h>
 #include <asm/tdx.h>
 
-u64 __seamcall(u64 fn, struct tdx_module_args *args);
-u64 __seamcall_ret(u64 fn, struct tdx_module_args *args);
-u64 __seamcall_saved_ret(u64 fn, struct tdx_module_args *args);
+u64 __seamcall(u64 fn_code, struct tdx_module_args *args);
+u64 __seamcall_ret(u64 fn_code, struct tdx_module_args *args);
+u64 __seamcall_saved_ret(u64 fn_code, struct tdx_module_args *args);
 
-typedef u64 (*sc_func_t)(u64 fn, struct tdx_module_args *args);
+typedef u64 (*sc_func_t)(u64 fn_code, struct tdx_module_args *args);
+
+#define SEAMCALL_VERSION_MASK		GENMASK_U64(23, 16)
+
+static __always_inline u64 __seamcall_fn_encoding(sc_func_t func, u64 fn,
+						  struct tdx_module_args *args)
+{
+	FIELD_MODIFY(SEAMCALL_VERSION_MASK, &fn, args->version);
+
+	return func(fn, args);
+}
 
 static __always_inline u64 __seamcall_dirty_cache(sc_func_t func, u64 fn,
 						  struct tdx_module_args *args)
@@ -39,7 +50,7 @@ static __always_inline u64 __seamcall_dirty_cache(sc_func_t func, u64 fn,
 	 */
 	this_cpu_write(cache_state_incoherent, true);
 
-	return func(fn, args);
+	return __seamcall_fn_encoding(func, fn, args);
 }
 
 static __always_inline u64 sc_retry(sc_func_t func, u64 fn,
diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
index 016a2a1ec1d6..b0f7867bcd1c 100644
--- a/arch/x86/virt/vmx/tdx/tdxcall.S
+++ b/arch/x86/virt/vmx/tdx/tdxcall.S
@@ -24,7 +24,7 @@
  *-------------------------------------------------------------------------
  * Input Registers:
  *
- * RAX                        - TDCALL/SEAMCALL Leaf number.
+ * RAX                        - TDCALL/SEAMCALL composite Leaf code.
  * RCX,RDX,RDI,RSI,RBX,R8-R15 - TDCALL/SEAMCALL Leaf specific input registers.
  *
  * Output Registers:
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 6a1c4fe202bb..8c1a5b7f603a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1019,7 +1019,6 @@ static __init void set_tdx_addon_features(void)
 static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 				    u64 global_keyid)
 {
-	u64 seamcall_fn = TDH_SYS_CONFIG_V0;
 	struct tdx_module_args args = {};
 	u64 *tdmr_pa_array;
 	size_t array_sz;
@@ -1042,18 +1041,18 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 	for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++)
 		tdmr_pa_array[i] = __pa(tdmr_entry(tdmr_list, i));
 
+	set_tdx_addon_features();
+
 	args.rcx = __pa(tdmr_pa_array);
 	args.rdx = tdmr_list->nr_consumed_tdmrs;
 	args.r8 = global_keyid;
 
-	set_tdx_addon_features();
-
 	if (tdx_addon_feature0) {
 		args.r9 = tdx_addon_feature0;
-		seamcall_fn = TDH_SYS_CONFIG;
+		args.version = 1;
 	}
 
-	ret = seamcall_prerr(seamcall_fn, &args);
+	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
 
 	/* Free the array as it is not required anymore. */
 	kfree(tdmr_pa_array);
@@ -1515,16 +1514,15 @@ int tdx_module_shutdown(void)
 
 int tdx_module_run_update(void)
 {
-	u64 seamcall_fn = TDH_SYS_UPDATE_V0;
 	struct tdx_module_args args = {};
 	int ret;
 
 	if (tdx_addon_feature0) {
 		args.r9 = tdx_addon_feature0;
-		seamcall_fn = TDH_SYS_UPDATE;
+		args.version = 1;
 	}
 
-	ret = seamcall_prerr(seamcall_fn, &args);
+	ret = seamcall_prerr(TDH_SYS_UPDATE, &args);
 	if (ret)
 		return ret;
 
@@ -2112,6 +2110,7 @@ u64 tdh_vp_init(struct tdx_vp *vp, u64 initial_rcx, u32 x2apicid)
 		.rcx = vp->tdvpr_pa,
 		.rdx = initial_rcx,
 		.r8 = x2apicid,
+		.version = 1,
 	};
 
 	return seamcall(TDH_VP_INIT, &args);
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 2deb0a5c902e..1f43d2eb2345 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -2,7 +2,6 @@
 #ifndef _X86_VIRT_TDX_H
 #define _X86_VIRT_TDX_H
 
-#include <linux/bitfield.h>
 #include <linux/bits.h>
 
 /*
@@ -12,18 +11,6 @@
  * architectural definitions come first.
  */
 
-/*
- * SEAMCALL leaf:
- *
- * Bit 15:0	Leaf number
- * Bit 23:16	Version number
- */
-#define SEAMCALL_LEAF			GENMASK(15, 0)
-#define SEAMCALL_VER			GENMASK(23, 16)
-
-#define SEAMCALL_LEAF_VER(l, v)		(FIELD_PREP(SEAMCALL_LEAF, l) | \
-					 FIELD_PREP(SEAMCALL_VER, v))
-
 /*
  * TDX module SEAMCALL leaf functions
  */
@@ -44,7 +31,7 @@
 #define TDH_VP_CREATE			10
 #define TDH_MNG_KEY_FREEID		20
 #define TDH_MNG_INIT			21
-#define TDH_VP_INIT			SEAMCALL_LEAF_VER(22, 1)
+#define TDH_VP_INIT			22
 #define TDH_PHYMEM_PAGE_RDMD		24
 #define TDH_VP_RD			26
 #define TDH_PHYMEM_PAGE_RECLAIM		28
@@ -58,11 +45,9 @@
 #define TDH_PHYMEM_CACHE_WB		40
 #define TDH_PHYMEM_PAGE_WBINVD		41
 #define TDH_VP_WR			43
-#define TDH_SYS_CONFIG_V0		45
-#define TDH_SYS_CONFIG			SEAMCALL_LEAF_VER(TDH_SYS_CONFIG_V0, 1)
+#define TDH_SYS_CONFIG			45
 #define TDH_SYS_SHUTDOWN		52
-#define TDH_SYS_UPDATE_V0		53
-#define TDH_SYS_UPDATE			SEAMCALL_LEAF_VER(TDH_SYS_UPDATE_V0, 1)
+#define TDH_SYS_UPDATE			53
 #define TDH_EXT_INIT			60
 #define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69


