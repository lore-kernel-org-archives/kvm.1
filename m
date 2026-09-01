Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A413B05A3;
	Tue,  1 Sep 2026 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273317; cv=none; b=jtztNMdunGY6Fl2Qvrnwbk4l/uBEMaDRMc0/yvmplYqJqGCXlMC3IyWQCFiVV58Iji3gE8EM4lVcgubz0ePdy/kcayLncQapTxsymysycJfiw007PjpdZORBuk7g8hluSPTOUMeicbBgWu+y0sT7SPJsap8pAHEA4HaPfZsr0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273317; c=relaxed/simple;
	bh=10qxOg1MT6XuMAd8B8PCnROxf2oXs4aNMchBl0JpzL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pht1t7hdHkTQ/CpufhRKuuCj3WuWcGitI08dAQuB8wDojjOIs4LSJsSg8nSc4EQu9Q/bbdUSee+Rd5921jvCnb2FxzW53ZNd3KD1tIsuKo9Ftm6rKuEAPAuzP864lWKU19uYqqRA6EuetB+GTU3vLctNnlvnlh3VLxaLO7p8rhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAwt93Nr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAwt93Nr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788273315; x=1819809315;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=10qxOg1MT6XuMAd8B8PCnROxf2oXs4aNMchBl0JpzL8=;
  b=YAwt93NrxtQpkRaMUbtPMvUfG9kt/745+xmz3aNSajhJC5xf/23quWFG
   qW6ZCD+4VvZkvfXCef8poaduxXfr/opzMSQTJonadXN3TPZ3LdAwUeUtM
   RjmKcGMpgAybtg73IBvl4EQUE8IW8hC74D018bHewcYYSdzuKa1daOKvw
   WVhrxsNs5Efbp1Co/cU7q24XkmlIvQPlpb6hcqsIqVS0a6x3bMVrioG7t
   kBpcha/vThJ6pTwRCJ6UT431mbI2fzSKGK6T+6uwIWsvfMEuvxK0Tx8Vn
   9fQBYAyjCNWbeS9L+9qI/amT6of7uTYjWC7NmKZ0oEIUkksR4Bhu5PNXd
   w==;
X-CSE-ConnectionGUID: A+u5yQBNRm24oJtDKvjc+g==
X-CSE-MsgGUID: 0jkRLcqiS5O/6V/7oVcRcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88716023"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="88716023"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 07:35:14 -0700
X-CSE-ConnectionGUID: LTvTmytkRR+FrZTs/kY5Vg==
X-CSE-MsgGUID: LHae2+5OQauLLpV9UyxW1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="272896245"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 07:35:12 -0700
Message-ID: <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
Date: Tue, 1 Sep 2026 22:35:09 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
 rick.p.edgecombe@intel.com, chao.gao@intel.com
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260827031837.2863609-2-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/2026 11:18 AM, Binbin Wu wrote:
> Add tdx_cpu_cfg_caps[] to track the subset of TDX directly configurable
> CPUID feature bits that KVM supports, and build the masks during TDX
> hardware setup via tdx_initialize_cpu_cfg_caps().
> 
> The TDX module reports the CPUID bits that the VMM can directly configure
> for a TD, but KVM cannot blindly expose all reported bits to userspace.
> Certain features imply additional architectural state, e.g. one or more
> MSRs, that KVM must explicitly manage across host/guest transitions to
> prevent host state corruption.
> 
> Today KVM relies on a hardcoded denylist, i.e. it clears a few known
> problematic bits, e.g. TSX and WAITPKG, and passes everything else through.
> A denylist is fundamentally fragile while an allowlist inverts the default,
> i.e. unknown configurable bits are hidden and not allowed to be enabled
> until KVM explicitly opts in.
> 
> Except for a few fixed-1 bits required for basic TDX support, host state
> clobbering features are either directly configurable or gated by TD
> ATTRIBUTES/XFAM.  

> Tracking only the directly configurable feature bits is
> therefore sufficient to serve the purpose while keeping the code footprint
> small.

I'm not clear how it is therefore sufficient. We at least need to 
explain that ATTRIBUTS/XFAM are validated separately by KVM already?
> Organize tdx_cpu_cfg_caps[] following kvm_cpu_caps[] so that the masks can
> be built with the similar feature-name based initializers.  CPUID registers
> that hold directly configurable non-feature (multi-bit) fields are handled
> separately.
> 
> The allowlist is consumed by later patches to filter KVM_TDX_CAPABILITIES
> and to reject unsupported CPUID input to KVM_TDX_INIT_VM, so that newly
> introduced TDX directly configurable CPUID feature bits stay hidden from
> userspace until KVM explicitly opts in.
> 
> Add comments as placeholders for HLE, RTM and WAITPKG, which KVM doesn't
> support for TDX yet.
> 
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
> v3:
> - Drop the new data structure in v2 and only track feature bits by
>    following the organization of kvm_cpu_caps[], handle non-feature
>    bits separately. (Sean)
> - Use two versions of macros (TDX_CFG_F() VS. TDX_CFG_EXTRA_F()) to
>    distinguish whether a supported TDX configurable CPUID bit should be
>    checked against KVM's common cpu capabilities.
> - Add AMX_COMPLEX since it has been defined in the CPUID virtualization doc.
> ---
>   arch/x86/kvm/vmx/tdx.c | 145 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 145 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index b272c20586a7..d4a3a42cfd9d 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -52,6 +52,149 @@
>   	__TDX_BUG_ON(__err, #__fn, __kvm, ", " #a1 " 0x%llx, " #a2 ", 0x%llx, " #a3 " 0x%llx", \
>   		     a1, a2, a3)
>   
> +static u32 tdx_cpu_cfg_caps[NR_KVM_CPU_CAPS] __ro_after_init;
> +static_assert(ARRAY_SIZE(tdx_cpu_cfg_caps) == ARRAY_SIZE(kvm_cpu_caps));
> +
> +#define TDX_VALIDATE_CPU_CAP_USAGE(name)			\
> +	BUILD_BUG_ON(__feature_leaf(X86_FEATURE_##name) !=	\
> +		     tdx_cpu_cap_init_in_progress)
> +
> +/* For feature bit that KVM advertised through kvm_cpu_caps[]. */

I would say it

For feature bit that needs to be cap'ed by kvm_cpu_caps[]

> +#define TDX_CFG_F(name)					\
> +({							\
> +	TDX_VALIDATE_CPU_CAP_USAGE(name);		\
> +	tdx_cfg_caps |= feature_bit(name);		\
> +})
> +
> +/*
> + * For feature bit KVM allows for TDX guests even though it is not advertised
> + * through kvm_cpu_caps[], e.g. MWAIT.
> + */
> +#define TDX_CFG_EXTRA_F(name)				\

EXTRA doesn't sound like a fit name, though

> +({							\
> +	TDX_VALIDATE_CPU_CAP_USAGE(name);		\
> +	tdx_cfg_extra_caps |= feature_bit(name);	\
> +})
> +
> +#define tdx_cpu_cfg_cap_init(leaf, feature_initializers...)		\
> +do {									\
> +	const u32 __maybe_unused tdx_cpu_cap_init_in_progress = leaf;	\
> +	u32 tdx_cfg_extra_caps = 0;					\
> +	u32 tdx_cfg_caps = 0;						\
> +									\
> +	feature_initializers						\
> +	tdx_cpu_cfg_caps[leaf] = (tdx_cfg_caps & kvm_cpu_caps[leaf]) |	\
> +				 tdx_cfg_extra_caps;			\
> +} while (0)
> +
> +/*
> + * Track only CPUID feature bits that are directly configurable by userspace.

the "by userspace" is misleading. It's just the directly configurable 
CPUID bits reported by TDX module.

> + * Features controlled by XFAM or ATTRIBUTES are excluded; userspace cannot
> + * enable them until KVM adds support for the corresponding control.
> + */

I don't like the comments. How about somthing

/*
  * Intialize tdx_cpu_cfg_caps[], which is list of CPUID features that
  * KVM supports for TDX. It only covers the directly configurable CPIUD
  * bits reported by TDX module. Features controlled by XFAM and
  * ATTRIBUTES are maintained separately.
  */

> +static void __init tdx_initialize_cpu_cfg_caps(void)
> +{
> +	tdx_cpu_cfg_cap_init(CPUID_1_ECX,
> +		TDX_CFG_EXTRA_F(MWAIT),
> +		TDX_CFG_F(TSC_DEADLINE_TIMER),
> +		TDX_CFG_F(AVX),
> +		TDX_CFG_F(F16C),
> +	);

TDX 1.5.24 on SPR report configurable bits of CPUID_1_ECX as
0x31044988, which have

- bit 3		MWAIT
- bit 7		EST
- bit 8		TM2
- bit 11	SDBG
- bit 14	XTPR
- bit 18	DCA
- bit 24	TSC_DEADLINE_TIMER
- bit 28	AVX
- bit 29	F16C

but EST/TM2/SDBG/XTPR/DCA are not list here. I guess the reason is 
kvm_cpu_cap[] doesn't support it. If so, it seems to guard twice:
1. mentally/manually check if it a feature is supported in kvm_cpu_caps[]

2. kvm_cpu_caps guarding in tdx_cpu_cfg_cap_init().

I think 1) is not necessary, we can rely on 2)

BTW, this seems also breaks the current userspace after this series.
- Before, EST/TM2/SDBG/XTPR/DCA are allowed to be exposed to TD
- After, they are not.

If we cares CORE_CAPABILITIES in patch 2, why EST/TM2/SDBG/XTPR/DCA 
don't matter?

(I don't check the following leafs..)
> +	tdx_cpu_cfg_cap_init(CPUID_1_EDX,
> +		TDX_CFG_F(MCE),
> +		TDX_CFG_F(MTRR),
> +		TDX_CFG_F(MCA),
> +		TDX_CFG_F(SELFSNOOP),
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
> +		TDX_CFG_F(AMX_COMPLEX),
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
>   bool enable_tdx __ro_after_init;
>   module_param_named(tdx, enable_tdx, bool, 0444);
> @@ -3481,6 +3624,8 @@ int __init tdx_hardware_setup(void)
>   		return r;
>   	}
>   
> +	tdx_initialize_cpu_cfg_caps();
> +
>   	KVM_SANITY_CHECK_VM_STRUCT_SIZE(kvm_tdx);
>   
>   	vt_x86_ops.vm_size = max_t(unsigned int, vt_x86_ops.vm_size, sizeof(struct kvm_tdx));

