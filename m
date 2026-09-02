Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925E43955C1;
	Wed,  2 Sep 2026 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365982; cv=none; b=hYwJE2PJzrJfGJjFLtn7xC3V1iNze2YcGaBZ/dbAs2qtbhrBi2EHTJW+L/rKItP/Axrcl4pIQqafe1fvMNLMCfXdxvkpsn9pNgxSD7ROZ7AuafYkOi363KNWTE1Sq1He3Aw3fh75H73r2mOcWFc7SUnbozrJZ5yZm80K64tWWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365982; c=relaxed/simple;
	bh=3BBmes8xSovB/lspbQ81wgCI2fsXolHtlAzXULwDkr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tvq6/0kgekKRHuQg3bb/7IV2LJZrBnVOD03fHZB+IYIlmw2V8QIb/7ixFXpfLt1SfXh7D7hL9spBmy2XnV38E8cjNi/sR06BAXkR1yUwFzECQQTQQSAVD075DAlZphCfPe56spWU+oDulFEbw0Jt+FUHRMj8rVBgvTt1scEA8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfgFGmnb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfgFGmnb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788365980; x=1819901980;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3BBmes8xSovB/lspbQ81wgCI2fsXolHtlAzXULwDkr8=;
  b=nfgFGmnbI+t71+Y87wzwvb5LCbrmPc3UEg/dJ/GUipu8m9aAWxfBzUim
   4IwcNLbZPhAdofW5L5EY98f7f69PsUzx6Gk3q3RgUkVIhJoCH8C+9+KNW
   di0WbH/Ms3NVY2oNIMpJ1ehZV9MTVsGa0raETBhq3yogFDUuuIju7r3eO
   VvClX4F2nxz3Wof+qF27UQeLU8wveI6iM4uI2QFT9feWWPaJsmfhUBsnD
   GRm1n2fhGfg833eKO+DaXgdJgc6I655IHMhnsqTq98bycN+75hX5JZvR+
   2FJlprS8iySYbT8xXITapSU+CuY+gj2yeEMD1UhYgsIy9Ivg1Z95TQGYT
   A==;
X-CSE-ConnectionGUID: bPSC2N6hR2ixCtL78tbcDQ==
X-CSE-MsgGUID: TrJdzHmxQOS7rEt1KY4Weg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100346072"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="100346072"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 09:19:33 -0700
X-CSE-ConnectionGUID: SQdRLClwQ5OV4RYBwZiGnw==
X-CSE-MsgGUID: hG2J2EvFShiZdA5beuNLhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273620778"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 09:19:30 -0700
Message-ID: <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com>
Date: Thu, 3 Sep 2026 00:19:28 +0800
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
 <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
 <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/2026 11:09 PM, Xiaoyao Li wrote:
> On 9/2/2026 8:33 AM, Binbin Wu wrote:
>>>> +static void __init tdx_initialize_cpu_cfg_caps(void)
>>>> +{
>>>> +    tdx_cpu_cfg_cap_init(CPUID_1_ECX,
>>>> +        TDX_CFG_EXTRA_F(MWAIT),
>>>> +        TDX_CFG_F(TSC_DEADLINE_TIMER),
>>>> +        TDX_CFG_F(AVX),
>>>> +        TDX_CFG_F(F16C),
>>>> +    );
>>> TDX 1.5.24 on SPR report configurable bits of CPUID_1_ECX as
>>> 0x31044988, which have
>>>
>>> - bit 3        MWAIT
>>> - bit 7        EST
>>> - bit 8        TM2
>>> - bit 11    SDBG
>>> - bit 14    XTPR
>>> - bit 18    DCA
>>> - bit 24    TSC_DEADLINE_TIMER
>>> - bit 28    AVX
>>> - bit 29    F16C
>>>
>>> but EST/TM2/SDBG/XTPR/DCA are not list here. I guess the reason is kvm_cpu_cap[] doesn't support it. If so, it seems to guard twice:
>>> 1. mentally/manually check if it a feature is supported in kvm_cpu_caps[]
>>>
>>> 2. kvm_cpu_caps guarding in tdx_cpu_cfg_cap_init().
>>>
>>> I think 1) is not necessary, we can rely on 2)
>> In general, if a feature is not supported by the common KVM CPU caps, 
> 
> For kvm-intel.ko, kvm_cpu_caps[] just means the supported CPUID features
> for VMX VMs. Treat it as the common KVM CPU caps is a bit arguable.
> 
>> I prefer not
>> to add it to the list to save a few lines of code, which probably is dead code,
> 
> I don't think it's dead code. It shows that these features are
> virtualizable to TDs from the POV. of TDX.

It depends on whether KVM allows userspace to set features for TDs that are not support
for non-TDX VMs (,except for a few exceptions).

In this version, TDX_CFG_F() already check against kvm_cpu_caps[], if these features
are not in kvm_cpu_caps[], it will not be exposed to userspace anyway.

> 
> In the end, they might be disallowed to be configured to TDs because KVM
> doesn't allow them for VMX VMs. This is also the point I want to discuss.
> Do we really want to make such restriction that KVM cannot enable/allow a
> feature for TDs unless KVM first enables/allows it for VMX VMs? What's
> reason behind it?

Sean mentioned it that "generally speaking, KVM shouldn't allow features
that KVM doesn't support for non-TDX VMs" in
https://lore.kernel.org/kvm/aj1fi_0SBxMK5WOB@google.com/

> 
>> unless people find it too confusing.
>> I can add a comment to clarify this.
>>
>>> BTW, this seems also breaks the current userspace after this series.
>>> - Before, EST/TM2/SDBG/XTPR/DCA are allowed to be exposed to TD
>>> - After, they are not.
>> This does change the values returned by KVM_TDX_CAPABILITIES. However, my
>> understanding is that userspace is generally expected to only configure
>> features supported by both KVM and TDX, i.e. except for the features initialized
>> via TDX_CFG_EXTRA_F(), userspace is not expected to configure features not advertised
>> by kvm_cpu_caps[].
>> I can call this out in the changelog, and maybe also the doc for KVM_TDX_CAPABILITIES.
> 
> yeah. This changes KVM's behavior and we definitely need to call it out,
> and provide justification.
> 
>>> If we cares CORE_CAPABILITIES in patch 2, why EST/TM2/SDBG/XTPR/DCA don't matter?
>> Because CORE_CAPABILITIES was previously defined as fixed-1 in some old spec and
>> the QEMU marks it as fixed1. EST/TM2/SDBG/XTPR/DCA are not the case.
> 
> I see. You added patch 2 because without it QEMU breaks. While for
> EST/TM2/SDBG/XTPR/DCA, QEMU doesn't break after they are turned to
> non-configurable. QEMU cannot represent all the userspace VMM. It still has
> the potential to breaks other userspace VMMs.

I think the risk is pretty low.
I am not sure if Sean could provide some insight about this in google's userspace
VMM.

