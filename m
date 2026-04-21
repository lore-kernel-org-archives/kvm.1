Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E8C38759B
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776753821; cv=none; b=VShnAaIGWL8rdfM5HRPHzp7V+R6d1PfGY2ZiDcBOSbJF89LK0UKZLbAJB7TPGCLf22FrwBPnDA+yXUQsTMy2Fjk6faSJ95Lg4u3sIu6LwGELPmB8k5mAl5hjrfbHgAU7cT46fKqn5JQtKvEFmak5PTN1uVN4EuTeem6ivZPfDiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776753821; c=relaxed/simple;
	bh=QSa38SwJjRr2PSXIaX3o/rWeQdS/kCsf6d9QDeAp2HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faDWR5Lh6YCdCAmz/vTp530uZ8R94i6GmddbsAbBlwQS9cxhC+o5hGb7ajW0Z4SFG0zqyzeF7ii9w1ivdSITwuKwrV/e8A9oZLB9fpSyzKBm3FdVIizqamRZPqK1OMbbanEO9fKWcE0bi7apmyMLX+EUrvYpltoXUwsiOBxPnp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNPV19ry; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNPV19ry"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776753820; x=1808289820;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QSa38SwJjRr2PSXIaX3o/rWeQdS/kCsf6d9QDeAp2HU=;
  b=eNPV19rym5Ca0Y2ZU66qCFDuY3kDInWKXwBxzCI5x1ERd2hRM8EMjjtx
   4a154kFNHbiqWrqnSGU9SrTS694s6Ow+NrMr3K52DbgIaSh/pYi+sD5bk
   Ka3vfxOLS4JUfBoYIr2sWpaIOShC7kWUBTZRsEbCFCGc3O2V+pM7UiDqB
   b1WGPMwalUcF9hIJgbd21eW6u3Or7RFx8NwKkjv89aOF0iX5NGZRH5VXB
   nn/UyOVcD3kpNlzOzuR8/HaTTPTwthEzTRFp/7SXo/JQw6WXLEX7CRxXS
   fp1eEJGtAfk5jmTMYKJ4C9Ee5u/X9SpJ7NBrjxQUS7WngtSes14iXMadZ
   A==;
X-CSE-ConnectionGUID: Zvyp5DTbRgy5byPXSujCrQ==
X-CSE-MsgGUID: L8mv7AjKRGyQgzdMgNjb9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="80266956"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="80266956"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 23:43:39 -0700
X-CSE-ConnectionGUID: N91A1N2BRZiGUXgzbnTZ5A==
X-CSE-MsgGUID: RA6+XrIwS8SRTkf9OGDQRQ==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 23:43:37 -0700
Message-ID: <cf3fdbaa-b026-48ef-9b0f-3cc5d6b5e47d@linux.intel.com>
Date: Tue, 21 Apr 2026 14:43:34 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/27] KVM: x86: Use vendor-specific overlay flags
 instead of F_CPUID_DEFAULT
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-11-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260417073610.3246316-11-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Below are responses to issues reported by sashiko. [1]
[1] https://sashiko.dev/#/patchset/20260417073610.3246316-1-binbin.wu%40linux.intel.com?part=10

Issue #1:
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 2c4e64aa14c47..71959f4918e78 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
[ ... ]
> @@ -983,7 +983,7 @@ void kvm_initialize_cpu_caps(void)
>  		/* MPX_MAWAU */
>  		F(RDPID, F_CPUID_DEFAULT | F_CPUID_TDX),
>  		/* KEY_LOCKER */
> -		F(BUS_LOCK_DETECT, F_CPUID_DEFAULT | F_CPUID_TDX),
> +		F(BUS_LOCK_DETECT, F_CPUID_VMX | F_CPUID_TDX),
>  		F(CLDEMOTE, F_CPUID_DEFAULT | F_CPUID_TDX),
>  		/* Reserved */
[ ... ]
> @@ -1022,7 +1022,7 @@ void kvm_initialize_cpu_caps(void)
>  		/* HYBRID_CPU */
>  		F(TSXLDTRK, F_CPUID_DEFAULT | F_CPUID_TDX),
>  		/* Reserved, PCONFIG, ARCH_LBR */
> -		F(IBT, F_CPUID_DEFAULT | F_CPUID_TDX),
> +		F(IBT, F_CPUID_VMX | F_CPUID_TDX),
>  		/* Reserved */
[ ... ]
> @@ -1075,7 +1075,7 @@ void kvm_initialize_cpu_caps(void)
>  
>  	kvm_cpu_cap_init(CPUID_7_1_ECX,
>  		/* MSR_IMM is reserved in TDX spec */
> -		SCATTERED_F(MSR_IMM, F_CPUID_DEFAULT),
> +		SCATTERED_F(MSR_IMM, F_CPUID_VMX),
>  	);
"Since IBT, BUS_LOCK_DETECT, and MSR_IMM are now initialized with
F_CPUID_VMX, they are never placed in the CPUID_OL_SVM overlay. 
Looking at the changes in arch/x86/kvm/svm/svm.c:"
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 2b4a17536580b..a21c500e1a91c 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
[ ... ]
> -	kvm_cpu_cap_clear(X86_FEATURE_IBT, F_CPUID_DEFAULT);
> +	kvm_cpu_cap_clear(X86_FEATURE_IBT, F_CPUID_SVM);
[ ... ]
> -	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT, F_CPUID_DEFAULT);
> -	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM, F_CPUID_DEFAULT);
> +	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT, F_CPUID_SVM);
> +	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM, F_CPUID_SVM);
"Doesn't this make these kvm_cpu_cap_clear() calls redundant dead code?
They are now attempting to clear bits from the SVM overlay that were never
set in the first place.
Additionally, if SVM support is added for these architectural features in
the future, wouldn't developers naturally remove these clear calls from
svm_set_cpu_caps(), only to find the features still disabled because of the
F_CPUID_VMX mask in cpuid.c?
Keeping F_CPUID_DEFAULT in cpuid.c and relying on the explicit clear calls
in svm_set_cpu_caps() seems like it would avoid this trap."

This is addressed in the next patch (i.e. 11/27).

Issue #2:
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1049,11 +1049,11 @@ void kvm_initialize_cpu_caps(void)
>  	if (boot_cpu_has(X86_FEATURE_AMD_IBPB_RET) &&
>  	    boot_cpu_has(X86_FEATURE_AMD_IBPB) &&
>  	    boot_cpu_has(X86_FEATURE_AMD_IBRS))
> -		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL, F_CPUID_DEFAULT);
> +		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL, F_CPUID_SVM);
>  	if (boot_cpu_has(X86_FEATURE_STIBP))
> -		kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP, F_CPUID_DEFAULT);
> +		kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP, F_CPUID_VMX);
>  	if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
> -		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD, F_CPUID_DEFAULT);
> +		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD, F_CPUID_SVM);
[ ... ]
> @@ -1217,26 +1217,26 @@ void kvm_initialize_cpu_caps(void)
>  	 * record that in cpufeatures so use them.
>  	 */
>  	if (boot_cpu_has(X86_FEATURE_IBPB)) {
> -		kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB, F_CPUID_DEFAULT);
> +		kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB, F_CPUID_SVM);
>  		if (boot_cpu_has(X86_FEATURE_SPEC_CTRL) &&
>  		    !boot_cpu_has_bug(X86_BUG_EIBRS_PBRSB))
> -			kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET, F_CPUID_DEFAULT);
> +			kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET, F_CPUID_SVM);
>  	}
>  	if (boot_cpu_has(X86_FEATURE_IBRS))
> -		kvm_cpu_cap_set(X86_FEATURE_AMD_IBRS, F_CPUID_DEFAULT);
> +		kvm_cpu_cap_set(X86_FEATURE_AMD_IBRS, F_CPUID_SVM);
>  	if (boot_cpu_has(X86_FEATURE_STIBP))
> -		kvm_cpu_cap_set(X86_FEATURE_AMD_STIBP, F_CPUID_DEFAULT);
> +		kvm_cpu_cap_set(X86_FEATURE_AMD_STIBP, F_CPUID_SVM);
>  	if (boot_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
> -		kvm_cpu_cap_set(X86_FEATURE_AMD_SSBD, F_CPUID_DEFAULT);
> +		kvm_cpu_cap_set(X86_FEATURE_AMD_SSBD, F_CPUID_SVM);
>  	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
> -		kvm_cpu_cap_set(X86_FEATURE_AMD_SSB_NO, F_CPUID_DEFAULT);
> +		kvm_cpu_cap_set(X86_FEATURE_AMD_SSB_NO, F_CPUID_SVM);
>  	/*
>  	 * The preference is to use SPEC CTRL MSR instead of the
>  	 * VIRT_SPEC MSR.
>  	 */
>  	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) &&
>  	    !boot_cpu_has(X86_FEATURE_AMD_SSBD))
> -		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD, F_CPUID_DEFAULT);
> +		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD, F_CPUID_SVM);

"Does restricting these cross-vendor mitigation features to specific vendor
overlays break cross-vendor live migration?
KVM previously synthesized equivalent cross-vendor hardware mitigation
features (like X86_FEATURE_AMD_IBPB) into both overlays using
F_CPUID_DEFAULT. This allowed an AMD guest model running on an Intel host
to see the AMD-specific CPUID bits, as KVM_GET_SUPPORTED_CPUID returns the
active overlay for the physical host.
By changing these to F_CPUID_SVM, the AMD mitigation features will be
completely missing from the VMX overlay. Will this cause userspace to
silently drop these security mitigations or refuse to launch cross-vendor
VMs, leaving guests vulnerable to speculative execution attacks?"

This is false positive since these features are AMD only features.
And it seems the AI misunderstand the reason of using F_CPUID_DEFAULT in
previous patches. Also, launching cross-vendor VMs is not supported by
KVM.




