Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695E53B19D5;
	Mon, 22 Jun 2026 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134121; cv=none; b=LeSrZ3pmSG6Iu9cnnPSRxbVLEnvx1BzWR2Up70k/eISoFOKENhjZYLcadPbO5FNIzDkCK5aR8L2sqKCLBxl50VNqyZM/ByFsuU1QP7wKJ3JLB2Rk9lc9bRXvZtaOUWtbwmwZ04ZBBbuZ63Ch0b4LjaAKH0NjJLTQIZ1t1vkIyW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134121; c=relaxed/simple;
	bh=5kJJ0jBEBcZgpsBD3iTZRct7s2YdiRXW58TdAFGGXNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hv6oN5ST8+eNM/B5GHsLFLIcDDOXU2SkWsAUnGDiuu5vWTp0UXjq3Na9uc49wyib4gXUMdUSME4eZ2swMndelCHf+R2qF4mPkskh1JZUsbwhF2RhnQqJgKnrIhSOTSTFQxqHZwcVmM1r0rwZE8GNn3aGxXZR8ZYRwCvLq7XXeJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/yb4eRN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/yb4eRN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782134121; x=1813670121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5kJJ0jBEBcZgpsBD3iTZRct7s2YdiRXW58TdAFGGXNs=;
  b=O/yb4eRNiXkoGX5infJnPnIf6yOmmJuTPNYxVWAoTqXtq4zrVroydX3M
   xBNSrCFAsVjLFxnQwyg8aETc3dJmQezMzjjfu9ywwwPKl31qYGZKb9ud6
   4KkknEBDWUIYgYn8vNsHVfKzNMTmKTUkp0WpbNhe99SNJeacwI0ed3K2Y
   mspZ6VvKZ4iE0j8bsl8FmUOOBy7tVCtbl1ymQN4kTseuLJKlCclh7xjvg
   EeS60Ig7tNqmFbO0xBDKrMbOlCBoUl9F3a6P+JpJhgVsttZWFNcoEv56U
   T+ARVvuCrIalVmibQrc3awWwp30CyyhUQnvAidv0rdCkUPVjkHMMuNBPQ
   Q==;
X-CSE-ConnectionGUID: AnCMHKiOReeE8sO3df9a2w==
X-CSE-MsgGUID: UaczPgJfQjC/gK3eBIJ+GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="81966611"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="81966611"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 06:15:20 -0700
X-CSE-ConnectionGUID: EQIh5x00RLeUoqQcAS7dUQ==
X-CSE-MsgGUID: O1Jx3ChjTTKcvtRqfJ++Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="254322008"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 22 Jun 2026 06:15:15 -0700
Date: Mon, 22 Jun 2026 21:15:14 +0800
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
Message-ID: <ajk1YuMEs4YCwVak@yilunxu-OptiPlex-7050>
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

I'm thinking the version is only needed for 3 SEAMCALLs. We don't have
to make version common for all 100+ SEAMCALLs. Besides the layout of
"struct tdx_module_args" correlates the fundamental assembly code of
__seamcall() in tdcall.S.

Could we make dedicated SEAMCALL wrappers for TDH_SYS_UPDATE similar to
other SEAMCALLs and wrapper the specific version handling there? I put
the diff in the end.

> 
> That gives args.version==0 in all the normal cases which just happens to
> be the exact behavior we want. It also avoids having to plumb version
> through all the seamcall*() wrappers.
> 
> But this is *exactly* the kind of thing that shouldn't be a part of an
> attestation patch series. This could very much have been a separate
> discussion and happened a month or a year ago. But now it is blocking
> this DICE thing from getting done <grumble>.

Sorry, I was thinking "don't keep version" was the conclusion...

--------8<--------

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 01fb01313077..b3b3540e431a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1757,18 +1757,12 @@ int tdx_module_shutdown(void)

 int tdx_module_run_update(void)
 {
-       u64 seamcall_fn = TDH_SYS_UPDATE_V0;
-       struct tdx_module_args args = {};
+       u64 err;
        int ret;

-       if (tdx_addon_feature0) {
-               args.r9 = tdx_addon_feature0;
-               seamcall_fn = TDH_SYS_UPDATE;
-       }
-
-       ret = seamcall_prerr(seamcall_fn, &args);
-       if (ret)
-               return ret;
+       err = tdx_sys_update(tdx_addon_feature0);
+       if (err)
+               return -EIO;

        ret = get_tdx_sys_info_version(&tdx_sysinfo.version);
        /*
@@ -2351,7 +2345,7 @@ u64 tdh_vp_init(struct tdx_vp *vp, u64 initial_rcx, u32 x2apicid)
                .r8 = x2apicid,
        };

-       return seamcall(TDH_VP_INIT, &args);
+       return seamcall(SEAMCALL_LEAF_VER(TDH_VP_INIT, 1), &args);
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_vp_init);

@@ -2463,3 +2457,16 @@ void tdx_sys_disable(void)
        if (ret && (ret & TDX_SW_ERROR) != TDX_SW_ERROR)
                pr_err("TDH.SYS.DISABLE failed: 0x%016llx\n", ret);
 }
+
+u64 tdx_sys_update(u64 features_enable0)
+{
+       struct tdx_module_args args = {
+               .r9 = features_enable0,
+       };
+       u64 fn = TDH_SYS_UPDATE;
+
+       if (features_enable0)
+               fn = SEAMCALL_LEAF_VER(TDH_SYS_UPDATE, 1);
+
+       return seamcall(fn, &args);
+}
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 32b13b0c85f9..f07e12552bf9 100644
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
@@ -61,8 +61,7 @@
 #define TDH_SYS_SHUTDOWN               52
-#define TDH_SYS_UPDATE_V0              53
-#define TDH_SYS_UPDATE                 SEAMCALL_LEAF_VER(TDH_SYS_UPDATE_V0, 1)
+#define TDH_SYS_UPDATE                 53
 #define TDH_EXT_INIT                   60
 #define TDH_EXT_MEM_ADD                        61
 #define TDH_SYS_DISABLE                        69

