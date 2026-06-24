Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829152472A2;
	Wed, 24 Jun 2026 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302447; cv=none; b=PFrXiu8gUqOpAZf3RW4hLRU/DiCOCI7j7n4W/Dd0SeX/mIEttOnSgBzVucXbN90rMAFJRWvoCHu8ZZ+L6AIFAslcJxyjo0GTAq380L7djFfbMXyIpE+52LaDTnUdM9PVKGaReoNKkv9nYFWI6d8tmeikCv7INd+WPqXe4Kek8gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302447; c=relaxed/simple;
	bh=I83ydL7GoRvAvfFaF7w9dJmdPFCCy7GY0CHYmIoyV5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyr2B84g22QLMq3cI+ucGZeo0hjqoUVKkYcmIyEO96ZQ4Ab7qyJEUMHJDQLBJMLE8tTdiVTAUs05ZXN4/C07SpfmnIVzouSlmI2sIdwULn8MaAuhEyvf9sQ6xNktoz+ufapSLCafNnuEEP2enTnEhiifyv56a87Q2fN6ANq2Eg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H54hn8Cq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H54hn8Cq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782302446; x=1813838446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I83ydL7GoRvAvfFaF7w9dJmdPFCCy7GY0CHYmIoyV5Y=;
  b=H54hn8CqOQsqpdIQs9mMo9gS+iavx6qzug576CCMa0zeIteWWb7iw6Tg
   nKuk4M7GFkisIWks+K/KmuzvHALlTNu4fCO8LbNmNrWTYEEPkOjFU2pOM
   UtIAPKUJ+o3WTy6x+BFg1I81Lm9s8+b7bDI5bAOWFrDPOX7Wm6k1z3bnl
   vqFvITOGyyQ5WWw8qc8qykvZzp03xW/OXeAdCImb3DZ/SuXm4n+UvVFzD
   GLeSv2Nmte9cmPm90WQsgmaJAMNy2utoYorzi0tr6WRCLrYtasD+vSmhX
   HD9vEOauF1Y01kEqnHx02ATcihMIJKfrfNZXXgCC1AItQENxVr+YXINVq
   g==;
X-CSE-ConnectionGUID: IU6XTx8iQZ+OBUrYcNS9+g==
X-CSE-MsgGUID: h6yZvoI2R+iGNp6axTgqyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83064586"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="83064586"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 05:00:45 -0700
X-CSE-ConnectionGUID: 3qyiB7AbSzu3FSHeUZdHvg==
X-CSE-MsgGUID: xZst1RRHRjGbdM0SKNhy7A==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 24 Jun 2026 05:00:40 -0700
Date: Wed, 24 Jun 2026 20:00:39 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	dave.hansen@linux.intel.com, seanjc@google.com
Subject: Re: [PATCH v2 02/17] x86/virt/tdx: Configure add-on features on TDX
 module init and update
Message-ID: <ajvG54UMcf3vbJez@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-3-yilun.xu@linux.intel.com>
 <4f4b0f29-424b-45ed-8cfd-c77da2ea390f@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f4b0f29-424b-45ed-8cfd-c77da2ea390f@intel.com>

> There's also zero stopping us from putting version in args:
> 
> 	struct tdx_module_args args = {};
>   	int ret;
> 
> 	if (tdx_addon_feature0) {
> 		args.r9 = tdx_addon_feature0;
> 		args.version = 1;
> 	}
> 
> 	ret = seamcall_prerr(TDH_SYS_UPDATE, &args);
> 
> Eh?
> 
> That gives args.version==0 in all the normal cases which just happens to
> be the exact behavior we want. It also avoids having to plumb version
> through all the seamcall*() wrappers.

Ah, on 2nd reading, I'm pretty sure now I understand your logical argument in
patch 1 and 2. It's good to me. I append my diff at the end.

> 
> But this is *exactly* the kind of thing that shouldn't be a part of an
> attestation patch series. This could very much have been a separate
> discussion and happened a month or a year ago. But now it is blocking
> this DICE thing from getting done <grumble>.

Sorry, I should have been more active in searching for the solution
rather than sticking to "kernel never keeps versions", when I've found
the problem that public modules are not available.

----8<----

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index f20e91d7ac35..972880910a5e 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -143,6 +143,8 @@ struct tdx_module_args {
        u64 rbx;
        u64 rdi;
        u64 rsi;
+       /* for RAX encoding */
+       u8  version;
 };

 /* Used to communicate with the TDX module */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 081816888f7a..b3c00ff4d819 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -95,6 +95,7 @@ static void __used common(void)
        OFFSET(TDX_MODULE_rbx, tdx_module_args, rbx);
        OFFSET(TDX_MODULE_rdi, tdx_module_args, rdi);
        OFFSET(TDX_MODULE_rsi, tdx_module_args, rsi);
+       OFFSET(TDX_MODULE_version, tdx_module_args, version);

        BLANK();
        OFFSET(BP_scratch, boot_params, scratch);
diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
index 016a2a1ec1d6..d1d3d40c5614 100644
--- a/arch/x86/virt/vmx/tdx/tdxcall.S
+++ b/arch/x86/virt/vmx/tdx/tdxcall.S
@@ -48,6 +48,14 @@
        /* Move Leaf ID to RAX */
        mov %rdi, %rax

+       /*
+        * Extract the version from 'struct tdx_module_args', append it to
+        * RAX[23:16]
+        */
+       movzbl  TDX_MODULE_version(%rsi), %ecx
+       shll    $16, %ecx
+       orq     %rcx, %rax
+
        /* Move other input regs from 'struct tdx_module_args' */
        movq    TDX_MODULE_rcx(%rsi), %rcx
        movq    TDX_MODULE_rdx(%rsi), %rdx
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index a6f8fd0a3df0..bc3aa1f78fc8 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1036,7 +1036,6 @@ static __init void set_tdx_addon_features(void)
 static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
                                    u64 global_keyid)
 {
-       u64 seamcall_fn = TDH_SYS_CONFIG_V0;
        struct tdx_module_args args = {};
        u64 *tdmr_pa_array;
        size_t array_sz;
@@ -1059,18 +1058,18 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
        for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++)
                tdmr_pa_array[i] = __pa(tdmr_entry(tdmr_list, i));

+       set_tdx_addon_features();
+
        args.rcx = __pa(tdmr_pa_array);
        args.rdx = tdmr_list->nr_consumed_tdmrs;
        args.r8 = global_keyid;

-       set_tdx_addon_features();
-
        if (tdx_addon_feature0) {
                args.r9 = tdx_addon_feature0;
-               seamcall_fn = TDH_SYS_CONFIG;
+               args.version = 1;
        }

-       ret = seamcall_prerr(seamcall_fn, &args);
+       ret = seamcall_prerr(TDH_SYS_CONFIG, &args);

        /* Free the array as it is not required anymore. */
        kfree(tdmr_pa_array);
@@ -1761,16 +1760,15 @@ int tdx_module_shutdown(void)

 int tdx_module_run_update(void)
 {
-       u64 seamcall_fn = TDH_SYS_UPDATE_V0;
        struct tdx_module_args args = {};
        int ret;

        if (tdx_addon_feature0) {
                args.r9 = tdx_addon_feature0;
-               seamcall_fn = TDH_SYS_UPDATE;
+               args.version = 1;
        }

-       ret = seamcall_prerr(seamcall_fn, &args);
+       ret = seamcall_prerr(TDH_SYS_UPDATE, &args);
        if (ret)
                return ret;

@@ -2353,6 +2351,7 @@ u64 tdh_vp_init(struct tdx_vp *vp, u64 initial_rcx, u32 x2apicid)
                .rcx = vp->tdvpr_pa,
                .rdx = initial_rcx,
                .r8 = x2apicid,
+               .version = 1,
        };

        return seamcall(TDH_VP_INIT, &args);
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 32b13b0c85f9..018988c25caa 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -44,7 +44,7 @@
 #define TDH_VP_CREATE                  10
 #define TDH_MNG_KEY_FREEID             20
 #define TDH_MNG_INIT                   21
-#define TDH_VP_INIT                    SEAMCALL_LEAF_VER(22, 1)
+#define TDH_VP_INIT                    22
 #define TDH_PHYMEM_PAGE_RDMD           24
 #define TDH_VP_RD                      26
 #define TDH_PHYMEM_PAGE_RECLAIM                28
@@ -58,11 +58,9 @@
 #define TDH_PHYMEM_CACHE_WB            40
 #define TDH_PHYMEM_PAGE_WBINVD         41
 #define TDH_VP_WR                      43
-#define TDH_SYS_CONFIG_V0              45
-#define TDH_SYS_CONFIG                 SEAMCALL_LEAF_VER(TDH_SYS_CONFIG_V0, 1)
+#define TDH_SYS_CONFIG                 45
 #define TDH_SYS_SHUTDOWN               52
-#define TDH_SYS_UPDATE_V0              53
-#define TDH_SYS_UPDATE                 SEAMCALL_LEAF_VER(TDH_SYS_UPDATE_V0, 1)
+#define TDH_SYS_UPDATE                 53
 #define TDH_EXT_INIT                   60
 #define TDH_EXT_MEM_ADD                        61
 #define TDH_SYS_DISABLE                        69

