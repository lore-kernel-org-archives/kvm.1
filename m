Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4DB38888B
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782234188; cv=none; b=TtrNWU8/fAsAwhOX1Q9T2r/ltEnBN48w/SYTajzxZ8WnLlmAFftCW5alf+vPre01lCgv/JR32gesYPt/cTuOS3EcTN56m4yzjp3XdrIH+yN12VdXzQExjW4jOXs9SA9IQmZOO93SUmvD0FbcJuYFNJqEh7DnmGQGBZnxZvvwVNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782234188; c=relaxed/simple;
	bh=p5D5+eVOCtrVJ8yz4z5xvvEMGDaLgkqOfEg/clcawJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3gSPRY/hK8mTONmhBkGLruApcmUKJnHgclBKikkfaLIpbAPqNlp7QyrYBViZAo9+sHSwJ82a4ZPM7sYraZwMl5Y1vx1XaK4JjqBh1bIa3zcAEibSU/k8g1jI+n76mbsXU39l27lc4pc0S39yZb2jBa/pbAqyEN8SgDMc0YGw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0bQVxCj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0bQVxCj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782234186; x=1813770186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p5D5+eVOCtrVJ8yz4z5xvvEMGDaLgkqOfEg/clcawJg=;
  b=m0bQVxCjEiYu6+MvpggAfdkBL2gHn55T5T45L1c/XKYxFq723m/flVtO
   0mlPlCaTLjKHscCdqMD5B+MD+cjNjJK0MXpoHw7CnykMXZ9o3iJJ0xPfs
   TxBLkr0xRRksb2XCYcLFRt1XbI4ReF/BSV1/2dBmaHdU9Lny0wiDaw0wY
   cHYMymUPjw3fTqUUjo0s7iRKa3BYktNKueIqgezP4jQEIRUOqXb2r0gu7
   Xx49YXdRc/5dd4nBMX7HDNuG0UMO+R/wTBv7kEVV4hE58TNnDSjbtYwDr
   Gzu7N+6xIM/O74SnoUxnW5sHvUZB6ouNDR7f0EXlerZ8VvZWx5ygQRWc/
   w==;
X-CSE-ConnectionGUID: XCm+OFlkR6qDKUFZqvgrdA==
X-CSE-MsgGUID: 914IWfQrR2Kpftw5uHAbuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82854336"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="82854336"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:03:05 -0700
X-CSE-ConnectionGUID: nQWGCC2TS2Cw77d6bPEmGA==
X-CSE-MsgGUID: JYLGJ577TNeskxwEI9+6xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="245441408"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 23 Jun 2026 10:03:00 -0700
Date: Wed, 24 Jun 2026 01:03:00 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@linux.intel.com,
	yilun.xu@intel.com, xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com, peter.fang@intel.com,
	dave.hansen@intel.com, dave.hansen@linux.intel.com,
	chao.gao@intel.com
Subject: Re: [PATCH v2 05/17] x86/virt/tdx: Make TDX module initialize the
 extensions
Message-ID: <ajq8RFjv2YFghvQp@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-6-yilun.xu@linux.intel.com>
 <20260618085431.B83541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618085431.B83541F000E9@smtp.kernel.org>

> > +/* Initialize TDX module extensions for extension SEAMCALLs */
> > +static __init int tdx_ext_init(void)
> > +{
> > +	struct tdx_module_args args = {};
> > +	u64 r;
> > +
> > +	do {
> > +		r = seamcall(TDH_EXT_INIT, &args);
> > +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> > +
> > +	if (r != TDX_SUCCESS)
> > +		return -EFAULT;
> 
> [Severity: Medium]
> Does this code silently discard the 64-bit hardware error code?
> 
> When TDH_EXT_INIT fails, replacing the return value with -EFAULT means
> the caller only logs a generic initialization failure without details.
> Other TDX initialization functions use seamcall_prerr_ret() to preserve
> and log the hardware error.
> 
> Could this be updated to use seamcall_prerr_ret() to ensure the exact
> firmware failure reason is logged?

No, it can't use seamcall_prerr_ret() directly. TDX_INTERRUPTED_RESUMABLE
can't be handled in a unified way for all SEAMCALLs so can't embed in
fundamental seamcall wrappers. I see 2 conventions:

  1. Host should set a resume=1 parameter on retry, such as,
     TDH_PHYMEM_CACHE_WB, and several migration SEAMCALLs,
     TDH.EXPORT.MEM, TDH.EXPORT.STATE.XXX

  2. Host just refills the previous args (may have been modified by seamcall
     output) on retry. Much more examples, TDH_EXT_INIT, TDH_EXT_MEM_ADD,
     TDH_QUOTE_INIT, TDH_QUOTE_GET...

So I think there is a need the callers have to:

  1. call seamcall() or seamcall wrappers (tdh_xxx)
  2. specific handling of raw SEAMCALL return code
  3. do a standard TDX error logging and Linux errno conversion.

seamcall_prerr_ret() does 1 & 2 & 3, but can't customize step 2.

I tried to add some TDX error logging & errno conversion helpers, most of
the code are abstracted from seamcall_prerr_ret(), see below.

But I'm not sure if it worths the churn.

----8<----


diff --git a/arch/x86/virt/vmx/tdx/seamcall_internal.h b/arch/x86/virt/vmx/tdx/seamcall_internal.h
index be5f446467df..f838715c9446 100644
--- a/arch/x86/virt/vmx/tdx/seamcall_internal.h
+++ b/arch/x86/virt/vmx/tdx/seamcall_internal.h
@@ -78,12 +78,10 @@ static inline void seamcall_err_ret(u64 fn, u64 err,
                        args->r9, args->r10, args->r11);
 }

-static __always_inline int sc_retry_prerr(sc_func_t func,
-                                         sc_err_func_t err_func,
-                                         u64 fn, struct tdx_module_args *args)
+static inline int sc_errno_prerr(sc_err_func_t err_func,
+                                u64 fn, u64 sret,
+                                struct tdx_module_args *args)
 {
-       u64 sret = sc_retry(func, fn, args);
-
        if (sret == TDX_SUCCESS)
                return 0;

@@ -100,10 +98,25 @@ static __always_inline int sc_retry_prerr(sc_func_t func,
        return -EIO;
 }

+static __always_inline int sc_retry_prerr(sc_func_t func,
+                                         sc_err_func_t err_func,
+                                         u64 fn, struct tdx_module_args *args)
+{
+       u64 sret = sc_retry(func, fn, args);
+
+       return sc_errno_prerr(err_func, fn, sret, args);
+}
+
 #define seamcall_prerr(__fn, __args)                                           \
        sc_retry_prerr(__seamcall, seamcall_err, (__fn), (__args))

 #define seamcall_prerr_ret(__fn, __args)                                       \
        sc_retry_prerr(__seamcall_ret, seamcall_err_ret, (__fn), (__args))

+#define seamcall_errno_prerr(__fn, __sret, __args)                             \
+       sc_errno_prerr(seamcall_err, (__fn), (__sret), (__args))
+
+#define seamcall_errno_prerr_ret(__fn, __sret, __args)                         \
+       sc_errno_prerr(seamcall_err_ret, (__fn), (__sret), (__args))
+
 #endif /* _X86_VIRT_SEAMCALL_INTERNAL_H */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 826504fbcdc7..637ff01ed0f1 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1403,10 +1403,7 @@ static int tdx_ext_init(void)
                r = seamcall(TDH_EXT_INIT, &args);
        } while (r == TDX_INTERRUPTED_RESUMABLE);

-       if (r != TDX_SUCCESS)
-               return -EFAULT;
-
-       return 0;
+       return seamcall_errno_prerr(TDH_EXT_INIT, r, &args);
 }

 #define HPA_LIST_INFO_FIRST_ENTRY      GENMASK_U64(11, 3)
@@ -1438,10 +1435,7 @@ static __init int tdx_ext_mem_add(struct page *hpa_list_page,
                r = seamcall_ret(TDH_EXT_MEM_ADD, &args);
        } while (r == TDX_INTERRUPTED_RESUMABLE);

-       if (r != TDX_SUCCESS)
-               return -EFAULT;
-
-       return 0;
+       return seamcall_errno_prerr_ret(TDH_EXT_MEM_ADD, r, &args);
 }
