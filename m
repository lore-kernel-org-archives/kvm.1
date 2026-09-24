Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23BB3FDBEA;
	Thu, 24 Sep 2026 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231786; cv=none; b=Pub37WQgL5FunDWuiA5XoGIb7artazTCzEM8ZwXjLImIxdqNWRFQy1j0LqpH/mktP5wSoDm7dPkuCz0+W+s8bqxY+rSpOABjf+YNfSQdyOVLk2OV51aG1nuefbIc3bKiDHljWLV4cm/loBWcJwQEUlOK69Qg8SC/ptPd0eVirBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231786; c=relaxed/simple;
	bh=w/0pJ31oDoOLCp3qYZaOQIseahl9+AosrfrncMVhNnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRADKHYLehT1bdLloEwSQFT4JcJyH6yVcVyJrGg45pYDEcQj9GqPwVZMj9lZG3MSvbt+LLvrXAAKRzTlF9orF7kKSyzHdSgLDvpB/uv5PozuvvhgAoiAd3qVUUA2vClusS1lOEh4i54LcmkR6h2rG28xtr9pUjMvu9bvGsNC5tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAbNxvp8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAbNxvp8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790231782; x=1821767782;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w/0pJ31oDoOLCp3qYZaOQIseahl9+AosrfrncMVhNnw=;
  b=CAbNxvp8afyoNZPj9CwjiEjxjdi/vedvaIHRS8EnfoCvAstcq08f+VS4
   QBRpPaA0n/sCFt2EK/jA3xD3gReeeaav9eptRIhLAu+DvsVwO2S5nQz4/
   OyPq7qga+lLCZyto5nyfFV2yTMAgWdUAXGn31WbjgAxlUSDrBNV528OOl
   VxU/QdW+o4lJjx27XC7qNdM+cbg8pCIJy6CsiiShHTgckNTsJ0Fd+2NQ0
   z1egmLosfyi6OrNwJ/zHEKnQBMyUmwXbKAzN9XlouiqlPjgiBbgdaAU5I
   Rl1AcqI6ie55ABqPsFP2DchVn1ZHnDtCBDhd5pSbLohFRSNuEnT7fKrYm
   g==;
X-CSE-ConnectionGUID: xhuEvujnTLqJDWI+z8vVrw==
X-CSE-MsgGUID: fpFJs3g3TY2FlZm4QoC0Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93884335"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="93884335"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:36:21 -0700
X-CSE-ConnectionGUID: hihaGJzERgyXRn0DQAjrjw==
X-CSE-MsgGUID: vP9sDjQsRV2WwdTkIZWS2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="5040742"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:36:18 -0700
Message-ID: <39047bbc-757d-4131-a25c-5a7743fd591a@intel.com>
Date: Thu, 24 Sep 2026 14:36:15 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
 rick.p.edgecombe@intel.com, chao.gao@intel.com,
 tony.lindgren@linux.intel.com, kishen.maloor@intel.com, dedekind1@gmail.com
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260917072548.2314491-2-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/2026 3:25 PM, Binbin Wu wrote:
> Add tdx_cpu_cfg_caps[] to track the subset of TDX directly configurable
> CPUID feature bits that KVM supports, and build the masks during TDX
> hardware setup via tdx_initialize_cpu_cfg_caps().
> 
> The TDX module reports the CPUID bits that the VMM can directly configure
> for a TD, but KVM cannot blindly expose all reported bits to userspace.
> Certain features imply additional architectural state, e.g. one or more
> MSRs, that KVM must explicitly manage across host/guest transitions to
> prevent host state corruption.  The existing hardcoded denylist cannot
> account for new host state clobbering features introduced by future TDX
> modules.
> 
> Except for a few fixed-1 bits required for basic TDX support, host state
> clobbering features are either directly configurable or gated by TD
> ATTRIBUTES/XFAM, which KVM already validates.  Tracking only the directly
> configurable bits to build an allowlist is therefore sufficient.
> 
> Organize tdx_cpu_cfg_caps[] following kvm_cpu_caps[] so that the masks can
> be built with similar feature-name based initializers.  Directly
> configurable non-feature bits will be handled separately.
> 
> The allowlist is prepared to be consumed by later patches to filter
> KVM_TDX_CAPABILITIES and to reject unsupported CPUID input to
> KVM_TDX_INIT_VM, so that newly introduced TDX directly configurable CPUID
> feature bits stay hidden from userspace until KVM explicitly opts in.
> 
> By default, intersect the allowlist with kvm_cpu_caps[] via TDX_CFG_F().
> Requiring support for non-TDX VMs avoids committing to TDX-specific
> behavior before general KVM support is established, and respects KVM's
> logic around disabling certain features, since the reasons for disabling
> them could apply to TDX as well.  Allow exceptions through
> TDX_CFG_EXTRA_F() only with sufficient justification.

One name just crosses my mind. How about TDX_CFG_INDEP_F()? where INDEP stands
for independent.

- TDX_CFG_F() for features that are dependent on kvm_cpu_caps[]
- TDX_CFG_INDEP_F() for features not dependent on kvm_cpu_caps[]

> Add comments as placeholders for HLE, RTM, WAITPKG and FRED, which KVM
> doesn't support for TDX yet.

1. why add comments for them? Because implementation wise, they are possible to
be supported by KVM but just current KVM doesn't have code to support them yet?

If so, are the others the features that are concluded to be impossible to be
supported by KVM?

2. We don't need to talk about FRED, which is even not suppported for normal VMs
yet. Unless we are trying to enable FRED for TDs specifically.

> Allow MWAIT, XTPR, and HT through TDX_CFG_EXTRA_F(), as these bits are
> not advertised in kvm_cpu_caps[].  The remaining directly configurable
> feature bits outside kvm_cpu_caps[] are left out of the allowlist:
> 
>   - Features forced to zero when #VE is reduced, or lacking KVM support
>     for the associated MSRs: EST, TM2, SDBG, DCA, ACPI, ACC (TM), RDT_A,
>     RDT_M, TME, PCONFIG, and CORE_CAPABILITIES.  Handle CORE_CAPABILITIES
>     in a subsequent patch.

why not split into two category? Because they are overlapped?

  - Features forced to zero when #VE is reduced
  - Features lack KVM support

As for "features forced to zero when #VE is reduced", do you mean when TDX
module supports "#VE reduction" feature, the features becomes fixed0? or when
guest enables "reduce #VE", the guest see a 0 value even though the feature is
still configurable to host userspace and host userspace configure it to 1?

>   - Features tied to IA32_MISC_ENABLE bits that a TD cannot set when
>     TDCS.TD_CTLS.REDUCE_VE is set: CID and PBE.

What is CID?
and Is PBE related to any bit of IA32_MISC_ENABLE? Did you mean PEBS instead?

I don't understand what this category. It talks about something when
TDCS.TD_CTLS.REDUCE_VE is set, which depends on guest TD's behavior. So what if
the guest TD doesn't set TDCS.TD_CTLS.REDUCE_VE?

>   - Features that can clobber host state and lack KVM support for TDX:
>     FRED.
> 
>   - Unsupported features: PREFETCHWT1 (Xeon Phi only), PSN (absent from
>     TDX-capable CPUs), AMX-TRANSPOSE (never implemented on an Intel
>     platform), and RAO_INT (defined only for future processors).

PREFETCHWT1 (if the name is correct) is not supported by the kernel right? For
such unknown features, it's straightforward to not support it.

AMX-TRANSPOSE has been turned into reserved, and kernel never supports it. I
think we don't need to mention it at all.

RAO_INT is fixed 0 for TDX 1.5?

At last, I think we can just classify all of the above as 3 types:

- Features that are directly configurable by TDX and in kvm_cpu_caps[].
  use TDX_CFG_F()

- Features that are directly configurable by TDX and KVM actually supports them
  or KVM can support them but not in kvm_cpu_caps[]. Use TDX_CFG_EXTRA_F().
  For example, MWAIT, XTPR, and HT.

- Features that are directly configurable by TDX but KVM or kenrel doesn't
  support them.
  For example, RDT_A, RDT_M, PREFETCHWT1, PSN,

> Filtering KVM_TDX_CAPABILITIES in a subsequent patch will intentionally
> stop advertising the excluded bits as configurable, as the corresponding
> features are unsupported or cannot be properly virtualized.
> 
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
> v4:
> - Add XTPR and HT to the allowlist.
> - Explain in the changelog why some directly configurable bits are not
>   added to the allowlist.
> - Improve comments/changelog. (Xiaoyao)
> - Fix the bug that AMX_COMPLEX should be added for CPUID_1E_1_EAX instead
>   of CPUID_7_1_EDX.
> 
> v3:
> - Drop the new data structure in v2 and only track feature bits by
>   following the organization of kvm_cpu_caps[], handle non-feature
>   bits separately. (Sean)
> - Use two versions of macros (TDX_CFG_F() vs. TDX_CFG_EXTRA_F()) to
>   distinguish whether a supported TDX configurable CPUID bit should be
>   checked against KVM's common cpu capabilities.
> - Add AMX_COMPLEX since it has been defined in the CPUID virtualization doc.
> ---
>  arch/x86/kvm/vmx/tdx.c | 164 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 8a3f88b79b83d..2b51a85c998e8 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -52,6 +52,168 @@
>  	__TDX_BUG_ON(__err, #__fn, __kvm, ", " #a1 " 0x%llx, " #a2 ", 0x%llx, " #a3 " 0x%llx", \
>  		     a1, a2, a3)
>  
> +static u32 tdx_cpu_cfg_caps[NR_KVM_CPU_CAPS] __ro_after_init;
> +static_assert(ARRAY_SIZE(tdx_cpu_cfg_caps) == ARRAY_SIZE(kvm_cpu_caps));
> +
> +#define TDX_VALIDATE_CPU_CAP_USAGE(name)			\
> +	BUILD_BUG_ON(__feature_leaf(X86_FEATURE_##name) !=	\
> +		     tdx_cpu_cap_init_in_progress)
> +
> +/* For a feature bit that needs to be cap'ed by kvm_cpu_caps[]. */
> +#define TDX_CFG_F(name)					\
> +({							\
> +	TDX_VALIDATE_CPU_CAP_USAGE(name);		\
> +	tdx_cfg_caps |= feature_bit(name);		\
> +})
> +
> +/*
> + * For a feature bit that KVM allows for TDX guests even though it isn't
> + * advertised through kvm_cpu_caps[], e.g. MWAIT.  Use this version only when
> + * there is a justification.
> + */
> +#define TDX_CFG_EXTRA_F(name)				\
> +({							\
> +	TDX_VALIDATE_CPU_CAP_USAGE(name);		\
> +	tdx_cfg_caps_extra |= feature_bit(name);	\
> +})
> +
> +#define tdx_cpu_cfg_cap_init(leaf, feature_initializers...)		\
> +do {									\
> +	const u32 __maybe_unused tdx_cpu_cap_init_in_progress = leaf;	\
> +	u32 tdx_cfg_caps_extra = 0;					\
> +	u32 tdx_cfg_caps = 0;						\
> +									\
> +	feature_initializers						\
> +	tdx_cpu_cfg_caps[leaf] = (tdx_cfg_caps & kvm_cpu_caps[leaf]) |	\
> +				 tdx_cfg_caps_extra;			\
> +} while (0)
> +
> +/*
> + * Initialize tdx_cpu_cfg_caps[], the list of CPUID features that KVM
> + * supports for TDX guests.  It covers only the directly configurable CPUID
> + * bits reported by the TDX module; features controlled by XFAM and
> + * ATTRIBUTES are handled separately.
> + */
> +static void __init tdx_initialize_cpu_cfg_caps(void)
> +{
> +	tdx_cpu_cfg_cap_init(CPUID_1_ECX,
> +		/*
> +		 * KVM allows userspace to enumerate MONITOR+MWAIT support to
> +		 * the guest, but the MWAIT feature flag is never advertised
> +		 * to userspace for non-TDX VMs.
> +		 */
> +		TDX_CFG_EXTRA_F(MWAIT),
> +		/*
> +		 * XTPR can be exposed to a TD, but it never takes effect in
> +		 * the underlying hardware when the TD changes
> +		 * IA32_MISC_ENABLE[23].
> +		 */
> +		TDX_CFG_EXTRA_F(XTPR),
> +		TDX_CFG_F(TSC_DEADLINE_TIMER),
> +		TDX_CFG_F(AVX),
> +		TDX_CFG_F(F16C),
> +	);
> +
> +	tdx_cpu_cfg_cap_init(CPUID_1_EDX,
> +		TDX_CFG_F(MCE),
> +		TDX_CFG_F(MTRR),
> +		TDX_CFG_F(MCA),
> +		TDX_CFG_F(SELFSNOOP),
> +		/*
> +		 * HT is a topology enumeration bit that KVM doesn't care
> +		 * about, but userspace may want to expose it to the guests.
> +		 */
> +		TDX_CFG_EXTRA_F(HT),
> +	);
> +
> +	tdx_cpu_cfg_cap_init(CPUID_7_0_EBX,
> +		TDX_CFG_F(BMI1),
> +		/* HLE */
> +		TDX_CFG_F(BMI2),
> +		TDX_CFG_F(ERMS),
> +		/* RTM */
> +		TDX_CFG_F(AVX512F),
> +		TDX_CFG_F(AVX512DQ),
> +		TDX_CFG_F(ADX),
> +		TDX_CFG_F(AVX512IFMA),
> +		TDX_CFG_F(AVX512PF),
> +		TDX_CFG_F(AVX512ER),
> +		TDX_CFG_F(AVX512CD),
> +		TDX_CFG_F(AVX512BW),
> +		TDX_CFG_F(AVX512VL),
> +	);
> +
> +	tdx_cpu_cfg_cap_init(CPUID_7_ECX,
> +		TDX_CFG_F(UMIP),
> +		/* WAITPKG */
> +		TDX_CFG_F(AVX512_VBMI2),
> +		TDX_CFG_F(GFNI),
> +		TDX_CFG_F(VAES),
> +		TDX_CFG_F(VPCLMULQDQ),
> +		TDX_CFG_F(AVX512_VNNI),
> +		TDX_CFG_F(AVX512_BITALG),
> +		TDX_CFG_F(AVX512_VPOPCNTDQ),
> +		TDX_CFG_F(LA57),
> +		TDX_CFG_F(RDPID),
> +		TDX_CFG_F(CLDEMOTE),
> +	);
> +
> +	tdx_cpu_cfg_cap_init(CPUID_7_EDX,
> +		TDX_CFG_F(AVX512_4VNNIW),
> +		TDX_CFG_F(AVX512_4FMAPS),
> +		TDX_CFG_F(FSRM),
> +		TDX_CFG_F(AVX512_VP2INTERSECT),
> +		TDX_CFG_F(SERIALIZE),
> +		TDX_CFG_F(TSXLDTRK),
> +	);
> +
> +	tdx_cpu_cfg_cap_init(CPUID_7_1_EAX,
> +		TDX_CFG_F(SHA512),
> +		TDX_CFG_F(SM3),
> +		TDX_CFG_F(SM4),
> +		TDX_CFG_F(AVX_VNNI),
> +		TDX_CFG_F(AVX512_BF16),
> +		TDX_CFG_F(CMPCCXADD),
> +		TDX_CFG_F(FZRM),
> +		TDX_CFG_F(FSRS),
> +		TDX_CFG_F(FSRC),
> +		/* FRED */
> +		TDX_CFG_F(LKGS),
> +		TDX_CFG_F(WRMSRNS),
> +		TDX_CFG_F(AMX_FP16),
> +		TDX_CFG_F(AVX_IFMA),
> +		TDX_CFG_F(LAM),
> +		TDX_CFG_F(MOVRS),
> +	);
> +
> +	tdx_cpu_cfg_cap_init(CPUID_7_1_EDX,
> +		TDX_CFG_F(AVX_VNNI_INT8),
> +		TDX_CFG_F(AVX_NE_CONVERT),
> +		TDX_CFG_F(AVX_VNNI_INT16),
> +		TDX_CFG_F(PREFETCHITI),
> +		TDX_CFG_F(AVX10),
> +	);
> +
> +	tdx_cpu_cfg_cap_init(CPUID_7_2_EDX,
> +		TDX_CFG_F(DDPD_U),
> +		TDX_CFG_F(MCDT_NO),
> +	);
> +
> +	tdx_cpu_cfg_cap_init(CPUID_1E_1_EAX,
> +		TDX_CFG_F(AMX_COMPLEX_ALIAS),
> +		TDX_CFG_F(AMX_FP8),
> +		TDX_CFG_F(AMX_TF32),
> +		TDX_CFG_F(AMX_AVX512),
> +		TDX_CFG_F(AMX_MOVRS),
> +	);
> +
> +	tdx_cpu_cfg_cap_init(CPUID_8000_0008_EBX,
> +		TDX_CFG_F(WBNOINVD),
> +	);
> +}
> +
> +#undef TDX_CFG_F
> +#undef TDX_CFG_EXTRA_F
>  
>  bool enable_tdx __ro_after_init;
>  module_param_named(tdx, enable_tdx, bool, 0444);
> @@ -3487,6 +3649,8 @@ int __init tdx_hardware_setup(void)
>  		return r;
>  	}
>  
> +	tdx_initialize_cpu_cfg_caps();
> +
>  	KVM_SANITY_CHECK_VM_STRUCT_SIZE(kvm_tdx);
>  
>  	vt_x86_ops.vm_size = max_t(unsigned int, vt_x86_ops.vm_size, sizeof(struct kvm_tdx));

