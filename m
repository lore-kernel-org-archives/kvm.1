Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174A92E03EA
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067790; cv=none; b=Cu5vX5asWgwIKQzYGfGNwjer7p8sJDNSFKatHF1Q6fBaeZH6PmfEKWBqg1I17XW5Am2QdVgkQNbqCYMX48I150vv2fZ4bo5VDJTkVYN8ea75EPyywVtyWKtBSPr3YxtXYye8h3SwjyI3MAv7Pcl4Jv2ueaBXDe0H6bygxCyDD90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067790; c=relaxed/simple;
	bh=dQOl++zTF+tc24552iJ1UnHlVOjvpBkcEeM8dxwaPuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xnde2ok0Ndj0PjhqobjV81IGmtcuO24RDIx8oLXO7qZUdGh0D/dJcVLDeIAYT69lyZxtWa5t2A/NzaMNPjlfK9QhJ4T9zuXfLVQPvY6ZSqlsKq0WGyTMUuuNz6pcPOoRZgNMIQ61MeXDGn6NqSFaYNpgsOTMBMNwb4ulQQ5tqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YvjPJKcS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YvjPJKcS"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b982ec27aso1407506a91.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067788; x=1780672588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eILrTa3RoIWHJYJJPAtoxPDx92OXb4mREmR4GXvO69Q=;
        b=YvjPJKcSgvXOn+1z+WtYVl63q3MY6qNVWfiNSIqp8LXWn9PBy8x4UC9RXSFKE4Vu6L
         RNBanWC1Avm2ZvoXChlAa70+iaS/jUFoGsTv7Ynq/t5Uhh0txMWvrRoqNsreG46mfP9H
         Wm58MYtnQdYSNEB7wefoajQQEiYbNe/xG45gmCY1JeLseogIduyyzn4tOh66ITn0LtE+
         QGSR0oNN4FHnCDuVE/RCXhWJo40i16L6SFh3HffuRMS4WMd4o2RGKE/4vAYjlzOO+5dM
         iRBM/LpixYq4JyKfV8FO3/zrS/0S1Q27wqYZQBzsA9BV+wFTmGfFK6v8sKyYRd+YvDKo
         F+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067788; x=1780672588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eILrTa3RoIWHJYJJPAtoxPDx92OXb4mREmR4GXvO69Q=;
        b=oHMngUFdSEFznqzIdmP5kJI3yUzU1Y8tq0s8CgrIbXyvkGOukFK1kcRDbXaSf+lOix
         cr4Wzk015pBB6Kis3cLFJEbn4C3tfOsAvhEgc4dgW9m914kkftwg+iloG6W6h017zJB8
         uaagy7Z9FyloD3b0EfGu7d0L+oNqRIbzkX2n6Pc9pYlFavyKIHsFbkXiwpT5BKmTHev5
         nXnjr9OZOkK2OLuf+DgQIFzHRAqSbBS29ZTTizUgiTiuct4mVWwJ3jWBI7c5WDWz3LHn
         z3HJqrNpB6twEQy7ht0aM7zcJ5eKtkfqBc0+zxtWQEpvjugaX0raGQTsEvTYwhFoZicC
         Lfag==
X-Forwarded-Encrypted: i=1; AFNElJ81cCN3MCIZ9SqIXwMcF2kQr2FLSKFSw33DcI1naW65AlTq1oK3YCEZdgeiSEoNIC57pBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwflejeOfwuonA/6fCe2LRFpfS/R/UDTvw31voDxOHp6HxS5C4e
	mOJlSoUdG9wq4ahiGoiSLQYdlPBHSYpGP94vcTD/qYP60on23MGOV9e05BFuy0urkAwOrff/+IQ
	uiAndFg==
X-Received: from pfbfp10.prod.google.com ([2002:a05:6a00:608a:b0:82f:c34b:9799])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1409:b0:3aa:ec27:e5f7
 with SMTP id adf61e73a8af0-3b41238088cmr4075196637.42.1780067788118; Fri, 29
 May 2026 08:16:28 -0700 (PDT)
Date: Fri, 29 May 2026 08:16:24 -0700
In-Reply-To: <20260512011502.53072-19-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512011502.53072-1-chang.seok.bae@intel.com> <20260512011502.53072-19-chang.seok.bae@intel.com>
Message-ID: <ahmtyMNsj2BCoEEo@google.com>
Subject: Re: [PATCH v4 18/21] KVM: x86: Expose APX foundation feature to guests
From: Sean Christopherson <seanjc@google.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, chao.gao@intel.com, 
	Peter Fang <peter.fang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 12, 2026, Chang S. Bae wrote:
> @@ -1441,7 +1445,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  	switch (function) {
>  	case 0:
>  		/* Limited to the highest leaf implemented in KVM. */
> -		entry->eax = min(entry->eax, 0x24U);
> +		entry->eax = min(entry->eax, 0x29U);
>  		break;
>  	case 1:
>  		cpuid_entry_override(entry, CPUID_1_EDX);
> @@ -1712,6 +1716,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		}
>  		break;
>  	}
> +	/* APX sub-features */
> +	case 0x29: {

Curly braces are unnecessary, now and in the next patch.

> +		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
> +		break;
> +	}
>  	case KVM_CPUID_SIGNATURE: {
>  		const u32 *sigptr = (const u32 *)KVM_SIGNATURE;
>  		entry->eax = KVM_CPUID_FEATURES;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 85d4087ea927..84496bc0508d 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5554,6 +5554,7 @@ static __init void svm_set_cpu_caps(void)
>  	 */
>  	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
>  	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
> +	kvm_cpu_cap_clear(X86_FEATURE_APX);
>  
>  	kvm_setup_xss_caps();
>  	kvm_finalize_cpu_caps();
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index f5f27e7b00b6..fc0924389398 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -219,10 +219,16 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_nr_uret_msrs);
>  static u32 __read_mostly kvm_uret_msrs_list[KVM_MAX_NR_USER_RETURN_MSRS];
>  static DEFINE_PER_CPU(struct kvm_user_return_msrs, user_return_msrs);
>  
> +#ifndef CONFIG_KVM_APX
> +#undef  XFEATURE_MASK_APX
> +#define XFEATURE_MASK_APX 0
> +#endif

Eww.

> +
>  #define KVM_SUPPORTED_XCR0     (XFEATURE_MASK_FP | XFEATURE_MASK_SSE \
>  				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
>  				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
> -				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE)
> +				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE \
> +				| XFEATURE_MASK_APX)

Rather than the funky #undef, I vote to move KVM_SUPPORTED_XCR0 into
kvm_x86_vendor_init() as a "const u64".  That way kvm_x86_vendor_init() can
further manipulate kvm_caps.supported_xcr0 based on CONFIG_KVM_APX without
having to use iffdefery, and without having to worry about other KVM code
treating KVM_SUPPORTED_XCR0 as 100% authoritative.

E.g. slot this in as a prep patch:

---
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:13:30 -0700
Subject: [PATCH] KVM: x86: Move KVM_SUPPORTED_{XCRO,XSS} into
 kvm_x86_vendor_init()

Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init() as "const u64"
values so that KVM's initialization code can further manipulate the set of
support XCR0/XSS features without need ugly #ifdeffery and without risking
other code treating KVM_SUPPORTED_{XCR0,XSS} as 100% authoritative.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c |  2 +-
 arch/x86/kvm/x86.c   | 25 +++++++++++++------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e69156b54cff..ea1b9a2f9116 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -253,7 +253,7 @@ static u32 kvm_apply_cpuid_pv_features_quirk(struct kvm_vcpu *vcpu)
 
 /*
  * Calculate guest's supported XCR0 taking into account guest CPUID data and
- * KVM's supported XCR0 (comprised of host's XCR0 and KVM_SUPPORTED_XCR0).
+ * KVM's supported XCR0 (the host's actual XCR0 masked by what KVM supports).
  */
 static u64 cpuid_get_supported_xcr0(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 48f259015ce4..cffbfe5ff116 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -219,19 +219,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_nr_uret_msrs);
 static u32 __read_mostly kvm_uret_msrs_list[KVM_MAX_NR_USER_RETURN_MSRS];
 static DEFINE_PER_CPU(struct kvm_user_return_msrs, user_return_msrs);
 
-#define KVM_SUPPORTED_XCR0     (XFEATURE_MASK_FP | XFEATURE_MASK_SSE \
-				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
-				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
-				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE)
-
 #define XFEATURE_MASK_CET_ALL	(XFEATURE_MASK_CET_USER | XFEATURE_MASK_CET_KERNEL)
-/*
- * Note, KVM supports exposing PT to the guest, but does not support context
- * switching PT via XSTATE (KVM's PT virtualization relies on perf; swapping
- * PT via guest XSTATE would clobber perf state), i.e. KVM doesn't support
- * IA32_XSS[bit 8] (guests can/must use RDMSR/WRMSR to save/restore PT MSRs).
- */
-#define KVM_SUPPORTED_XSS	(XFEATURE_MASK_CET_ALL)
 
 bool __read_mostly allow_smaller_maxphyaddr = 0;
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(allow_smaller_maxphyaddr);
@@ -10074,6 +10062,19 @@ static void kvm_x86_check_cpu_compat(void *ret)
 
 int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 {
+	const u64 KVM_SUPPORTED_XCR0 = XFEATURE_MASK_FP | XFEATURE_MASK_SSE |
+				       XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS |
+				       XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 |
+				       XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE;
+       /*
+	* Note, KVM supports exposing PT to the guest, but does not support
+	* context switching PT via XSTATE (KVM's PT virtualization relies on
+	* perf; swapping PT via guest XSTATE would clobber perf state), i.e.
+	* KVM doesn't support IA32_XSS[bit 8] (guests can/must use RDMSR/WRMSR
+	* to save/restore PT MSRs).
+	*/
+	const u64 KVM_SUPPORTED_XSS = XFEATURE_MASK_CET_ALL;
+
 	u64 host_pat;
 	int r, cpu;
 

base-commit: b7fbe9a1bf9ee6c967ef77d366ca58c35fcf1887
--
