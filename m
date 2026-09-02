Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A31214A84;
	Wed,  2 Sep 2026 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309218; cv=none; b=NH9Q81UeWD9mU9vmYiGsixPYbld5YDBts2ne9HuERezz0ETXDhGmqfrrVOpCeLkJLfmR8pNtSdqh8/mwSmOX7tS2oqE/dc4UejDgcjTF/qhZo8G5mUR0Wb/zCCsheHPMmgWd2UCNtU8OroWFtHX5EVFG34X0yYlhlJnQFq5sKWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309218; c=relaxed/simple;
	bh=nPOZPqFnVNOpqkfobbzLDSKhfJhVpX1Pt8nUcT1QF+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8yA5yywnkfH+6uKEfh0JCaSq/svP6nEl9g15bUCx0184+FKBPbshzMqlcg+hs87eY2ID78AyUfGydwfpmOznSoqcm/idWTyxchqOPWovkMdP06DlxRy6okBguofqat3BQVd1FcbrPOZ+wp5QKhmreTJ9HqNX0yay1l2xYQNF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgLQL7wK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgLQL7wK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788309216; x=1819845216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nPOZPqFnVNOpqkfobbzLDSKhfJhVpX1Pt8nUcT1QF+I=;
  b=cgLQL7wK46qi6wP/nf7KxmO5hSCG0c8fR6x1KyhEnftSAmETwAqtsQ70
   jq7jw0wkF8DQeLxIkraKfFiJFczQHKA/3N+47r971B5ns2KQ5CEmVWf/M
   owaGQVXCz9KDiJlsZwWvtk0ATj2BNyxW4MRDLMPC0DzEwL26WgMCv3xlI
   SnVhBFquAh39rNGW7Yygi0iA8xiYqnCJ4P6wr36TU0qO5/12H95wd4ybh
   fF6AkBeYIKZgUTheOx/jtHmF0/kgs88nPrLYMi7uDqK3k7sFLFzAB/f1Y
   DGre1wrUslcOCphzau0lrvQXx1exwV8eFkrEYaOJR5dXrXUEYto9hsnIu
   Q==;
X-CSE-ConnectionGUID: CsT/Vs5RSf+5ZYvNDy8r2Q==
X-CSE-MsgGUID: j34P24w0RtusfLaOPeKKsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="99919717"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="99919717"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 17:33:35 -0700
X-CSE-ConnectionGUID: wWKB5KPoTI+yKhEtWHSZgA==
X-CSE-MsgGUID: 7My2q0XDRZCXZEAuK2NJyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="273432062"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 17:33:33 -0700
Message-ID: <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
Date: Wed, 2 Sep 2026 08:33:30 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
 rick.p.edgecombe@intel.com, chao.gao@intel.com
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
 <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/1/2026 10:35 PM, Xiaoyao Li wrote:
> On 8/27/2026 11:18 AM, Binbin Wu wrote:
>> Add tdx_cpu_cfg_caps[] to track the subset of TDX directly configurable
>> CPUID feature bits that KVM supports, and build the masks during TDX
>> hardware setup via tdx_initialize_cpu_cfg_caps().
>>
>> The TDX module reports the CPUID bits that the VMM can directly configure
>> for a TD, but KVM cannot blindly expose all reported bits to userspace.
>> Certain features imply additional architectural state, e.g. one or more
>> MSRs, that KVM must explicitly manage across host/guest transitions to
>> prevent host state corruption.
>>
>> Today KVM relies on a hardcoded denylist, i.e. it clears a few known
>> problematic bits, e.g. TSX and WAITPKG, and passes everything else through.
>> A denylist is fundamentally fragile while an allowlist inverts the default,
>> i.e. unknown configurable bits are hidden and not allowed to be enabled
>> until KVM explicitly opts in.
>>
>> Except for a few fixed-1 bits required for basic TDX support, host state
>> clobbering features are either directly configurable or gated by TD
>> ATTRIBUTES/XFAM.  
> 
>> Tracking only the directly configurable feature bits is
>> therefore sufficient to serve the purpose while keeping the code footprint
>> small.
> 
> I'm not clear how it is therefore sufficient. We at least need to explain that ATTRIBUTS/XFAM are validated separately by KVM already?

I was trying to say this by "gated by TD ATTRIBUTES/XFAM", I will describe it
more clearly.

>> Organize tdx_cpu_cfg_caps[] following kvm_cpu_caps[] so that the masks can
>> be built with the similar feature-name based initializers.  CPUID registers
>> that hold directly configurable non-feature (multi-bit) fields are handled
>> separately.
>>
>> The allowlist is consumed by later patches to filter KVM_TDX_CAPABILITIES
>> and to reject unsupported CPUID input to KVM_TDX_INIT_VM, so that newly
>> introduced TDX directly configurable CPUID feature bits stay hidden from
>> userspace until KVM explicitly opts in.
>>
>> Add comments as placeholders for HLE, RTM and WAITPKG, which KVM doesn't
>> support for TDX yet.
>>
>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>> ---
>> v3:
>> - Drop the new data structure in v2 and only track feature bits by
>>    following the organization of kvm_cpu_caps[], handle non-feature
>>    bits separately. (Sean)
>> - Use two versions of macros (TDX_CFG_F() VS. TDX_CFG_EXTRA_F()) to
>>    distinguish whether a supported TDX configurable CPUID bit should be
>>    checked against KVM's common cpu capabilities.
>> - Add AMX_COMPLEX since it has been defined in the CPUID virtualization doc.
>> ---
>>   arch/x86/kvm/vmx/tdx.c | 145 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 145 insertions(+)
>>
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index b272c20586a7..d4a3a42cfd9d 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
>> @@ -52,6 +52,149 @@
>>       __TDX_BUG_ON(__err, #__fn, __kvm, ", " #a1 " 0x%llx, " #a2 ", 0x%llx, " #a3 " 0x%llx", \
>>                a1, a2, a3)
>>   +static u32 tdx_cpu_cfg_caps[NR_KVM_CPU_CAPS] __ro_after_init;
>> +static_assert(ARRAY_SIZE(tdx_cpu_cfg_caps) == ARRAY_SIZE(kvm_cpu_caps));
>> +
>> +#define TDX_VALIDATE_CPU_CAP_USAGE(name)            \
>> +    BUILD_BUG_ON(__feature_leaf(X86_FEATURE_##name) !=    \
>> +             tdx_cpu_cap_init_in_progress)
>> +
>> +/* For feature bit that KVM advertised through kvm_cpu_caps[]. */
> 
> I would say it
> 
> For feature bit that needs to be cap'ed by kvm_cpu_caps[]
> 
>> +#define TDX_CFG_F(name)                    \
>> +({                            \
>> +    TDX_VALIDATE_CPU_CAP_USAGE(name);        \
>> +    tdx_cfg_caps |= feature_bit(name);        \
>> +})
>> +
>> +/*
>> + * For feature bit KVM allows for TDX guests even though it is not advertised
>> + * through kvm_cpu_caps[], e.g. MWAIT.
>> + */
>> +#define TDX_CFG_EXTRA_F(name)                \
> 
> EXTRA doesn't sound like a fit name, though

I also struggled with naming this macro and couldn't come up with a better one.
Any suggestion?

> 
>> +({                            \
>> +    TDX_VALIDATE_CPU_CAP_USAGE(name);        \
>> +    tdx_cfg_extra_caps |= feature_bit(name);    \
>> +})
>> +
>> +#define tdx_cpu_cfg_cap_init(leaf, feature_initializers...)        \
>> +do {                                    \
>> +    const u32 __maybe_unused tdx_cpu_cap_init_in_progress = leaf;    \
>> +    u32 tdx_cfg_extra_caps = 0;                    \
>> +    u32 tdx_cfg_caps = 0;                        \
>> +                                    \
>> +    feature_initializers                        \
>> +    tdx_cpu_cfg_caps[leaf] = (tdx_cfg_caps & kvm_cpu_caps[leaf]) |    \
>> +                 tdx_cfg_extra_caps;            \
>> +} while (0)
>> +
>> +/*
>> + * Track only CPUID feature bits that are directly configurable by userspace.
> 
> the "by userspace" is misleading. It's just the directly configurable CPUID bits reported by TDX module.
> 
>> + * Features controlled by XFAM or ATTRIBUTES are excluded; userspace cannot
>> + * enable them until KVM adds support for the corresponding control.
>> + */
> 
> I don't like the comments. How about somthing
> 
> /*
>  * Intialize tdx_cpu_cfg_caps[], which is list of CPUID features that
>  * KVM supports for TDX. It only covers the directly configurable CPIUD
>  * bits reported by TDX module. Features controlled by XFAM and
>  * ATTRIBUTES are maintained separately.
>  */
> 
Thanks, it reads better.

>> +static void __init tdx_initialize_cpu_cfg_caps(void)
>> +{
>> +    tdx_cpu_cfg_cap_init(CPUID_1_ECX,
>> +        TDX_CFG_EXTRA_F(MWAIT),
>> +        TDX_CFG_F(TSC_DEADLINE_TIMER),
>> +        TDX_CFG_F(AVX),
>> +        TDX_CFG_F(F16C),
>> +    );
> 
> TDX 1.5.24 on SPR report configurable bits of CPUID_1_ECX as
> 0x31044988, which have
> 
> - bit 3        MWAIT
> - bit 7        EST
> - bit 8        TM2
> - bit 11    SDBG
> - bit 14    XTPR
> - bit 18    DCA
> - bit 24    TSC_DEADLINE_TIMER
> - bit 28    AVX
> - bit 29    F16C
> 
> but EST/TM2/SDBG/XTPR/DCA are not list here. I guess the reason is kvm_cpu_cap[] doesn't support it. If so, it seems to guard twice:
> 1. mentally/manually check if it a feature is supported in kvm_cpu_caps[]
> 
> 2. kvm_cpu_caps guarding in tdx_cpu_cfg_cap_init().
> 
> I think 1) is not necessary, we can rely on 2)

In general, if a feature is not supported by the common KVM CPU caps, I prefer not
to add it to the list to save a few lines of code, which probably is dead code,
unless people find it too confusing.
I can add a comment to clarify this.

> 
> BTW, this seems also breaks the current userspace after this series.
> - Before, EST/TM2/SDBG/XTPR/DCA are allowed to be exposed to TD
> - After, they are not.

This does change the values returned by KVM_TDX_CAPABILITIES. However, my
understanding is that userspace is generally expected to only configure
features supported by both KVM and TDX, i.e. except for the features initialized
via TDX_CFG_EXTRA_F(), userspace is not expected to configure features not advertised
by kvm_cpu_caps[].
I can call this out in the changelog, and maybe also the doc for KVM_TDX_CAPABILITIES.

> 
> If we cares CORE_CAPABILITIES in patch 2, why EST/TM2/SDBG/XTPR/DCA don't matter?

Because CORE_CAPABILITIES was previously defined as fixed-1 in some old spec and
the QEMU marks it as fixed1. EST/TM2/SDBG/XTPR/DCA are not the case.


