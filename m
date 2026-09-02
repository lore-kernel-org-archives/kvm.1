Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E44372EDB;
	Wed,  2 Sep 2026 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361765; cv=none; b=VCj4l5RH6LjNePik6007g6hYsOl9O2F3rUWkbtvzYSQAwmfqdQPOvIR5HMRrL/L/smMc9TyGqaub3nm0bKL7Sd+I0iPdGokhlTC5CJ02V7xIZZj9a0olzjPdulwU5tVEt/DXXE/0fHukmtQS0PBp2ma/rO4zdkpFfrPAOkanLkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361765; c=relaxed/simple;
	bh=H3j5nF4TmlSYPKfTyb8977B5+QpR60ZF5BUApcbj1sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CD3xR3433IQXIMFJp3iKAYSbKG3pcSDIUzk4qlyLNgpEbLhmWPWnCzhZrzzqmquEUY7AGSx3h2sognjVOmr5CfZw77QYhLzD4w3mUWnQeTse94icXqL7cXClDsw+SJ8B2Cl+OIsfrmR4x3T0bdhQxpqxjq7qQCX8dBLzB92w4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyUJ31hh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyUJ31hh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788361762; x=1819897762;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H3j5nF4TmlSYPKfTyb8977B5+QpR60ZF5BUApcbj1sM=;
  b=EyUJ31hh4TTD1hzT8fqgzHt9U0RWF3duT52m72Ul/CXRuLU3qbInZ9RT
   PkrjI75kQvssG05mESeqMy6XroGCYDdh35QlEzxiul2Ef146uAlnJd7DY
   EdcL/QQJ0QNfiSzW7RSGDjMEayR2EPmlWaU2V52iWgpiR8MY2JR1SKs4Y
   l4lodLC4YQd1j0MqnDOWRi+uFqyD/hM1KKles82gXJ4rNBAmLaVH+fLyJ
   rsUsPykvI5PcTKmKDLkJdHUgq2/6gb9HyIXQ6ANFisl3N93LXdKC+Bqk2
   WMN28Z2FgkEBMAOonlD0C1gRk1faR0N248F5Dw+TEXQ0tVhkVFPTSRkHo
   w==;
X-CSE-ConnectionGUID: Cfo6eOtRQFqIlvY6tFZSxA==
X-CSE-MsgGUID: 708ce3DeTruDD8oiVLgsqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92643064"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92643064"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:09:18 -0700
X-CSE-ConnectionGUID: 1CdeLdG3TSurM6JZ1pKiag==
X-CSE-MsgGUID: 648WL4ejRxe8j5LURuOVUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="266839021"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:09:12 -0700
Message-ID: <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
Date: Wed, 2 Sep 2026 23:09:09 +0800
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
 <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
 <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/2026 8:33 AM, Binbin Wu wrote:
>>> +static void __init tdx_initialize_cpu_cfg_caps(void)
>>> +{
>>> +    tdx_cpu_cfg_cap_init(CPUID_1_ECX,
>>> +        TDX_CFG_EXTRA_F(MWAIT),
>>> +        TDX_CFG_F(TSC_DEADLINE_TIMER),
>>> +        TDX_CFG_F(AVX),
>>> +        TDX_CFG_F(F16C),
>>> +    );
>> TDX 1.5.24 on SPR report configurable bits of CPUID_1_ECX as
>> 0x31044988, which have
>>
>> - bit 3        MWAIT
>> - bit 7        EST
>> - bit 8        TM2
>> - bit 11    SDBG
>> - bit 14    XTPR
>> - bit 18    DCA
>> - bit 24    TSC_DEADLINE_TIMER
>> - bit 28    AVX
>> - bit 29    F16C
>>
>> but EST/TM2/SDBG/XTPR/DCA are not list here. I guess the reason is kvm_cpu_cap[] doesn't support it. If so, it seems to guard twice:
>> 1. mentally/manually check if it a feature is supported in kvm_cpu_caps[]
>>
>> 2. kvm_cpu_caps guarding in tdx_cpu_cfg_cap_init().
>>
>> I think 1) is not necessary, we can rely on 2)
> In general, if a feature is not supported by the common KVM CPU caps, 

For kvm-intel.ko, kvm_cpu_caps[] just means the supported CPUID features
for VMX VMs. Treat it as the common KVM CPU caps is a bit arguable.

> I prefer not
> to add it to the list to save a few lines of code, which probably is dead code,

I don't think it's dead code. It shows that these features are
virtualizable to TDs from the POV. of TDX.

In the end, they might be disallowed to be configured to TDs because KVM
doesn't allow them for VMX VMs. This is also the point I want to discuss.
Do we really want to make such restriction that KVM cannot enable/allow a
feature for TDs unless KVM first enables/allows it for VMX VMs? What's
reason behind it?

> unless people find it too confusing.
> I can add a comment to clarify this.
> 
>> BTW, this seems also breaks the current userspace after this series.
>> - Before, EST/TM2/SDBG/XTPR/DCA are allowed to be exposed to TD
>> - After, they are not.
> This does change the values returned by KVM_TDX_CAPABILITIES. However, my
> understanding is that userspace is generally expected to only configure
> features supported by both KVM and TDX, i.e. except for the features initialized
> via TDX_CFG_EXTRA_F(), userspace is not expected to configure features not advertised
> by kvm_cpu_caps[].
> I can call this out in the changelog, and maybe also the doc for KVM_TDX_CAPABILITIES.

yeah. This changes KVM's behavior and we definitely need to call it out,
and provide justification.

>> If we cares CORE_CAPABILITIES in patch 2, why EST/TM2/SDBG/XTPR/DCA don't matter?
> Because CORE_CAPABILITIES was previously defined as fixed-1 in some old spec and
> the QEMU marks it as fixed1. EST/TM2/SDBG/XTPR/DCA are not the case.

I see. You added patch 2 because without it QEMU breaks. While for
EST/TM2/SDBG/XTPR/DCA, QEMU doesn't break after they are turned to
non-configurable. QEMU cannot represent all the userspace VMM. It still has
the potential to breaks other userspace VMMs.
