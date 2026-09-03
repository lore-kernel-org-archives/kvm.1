Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D9F62809;
	Thu,  3 Sep 2026 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420528; cv=none; b=rRuiJqlT47O0XgSyDXt8THPU9XRAlM+HnsnTGF9aj0htngeLz/+4sJCdvFZp9WGb5eQzKsBFiAdbJ1xhacbzKHWutbRVG5tPLJhPOP9u3ZGKO7Wx+XyFdwczyCaVbgdM4y86m84zHIZl1cL5LLODfs7V+ALAULESFyEIMLZ0KXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420528; c=relaxed/simple;
	bh=qTsepFlsW+yq1s6Als/DhO9gITKNucANJwYs3LQkhk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nhn9HRigxAjDkkYCKTgKRQazrjoMIAfzov7DqSacI2zzD6DEwUfy3diD6ZyLdd+7JR7rzmoyk0YMXzILcB9PwerXk9OPN6kj6Cg182Cm/d5uwCv79JtnyAF/Mw3wWQua2utj73xniPoAQsG1md1L4efo8sY58YkvTd3P8nWS+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/QNLnMV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/QNLnMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788420526; x=1819956526;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qTsepFlsW+yq1s6Als/DhO9gITKNucANJwYs3LQkhk4=;
  b=a/QNLnMVnzhPnaeWeB6eKpj7RTBJnY6ZD2iqNXVCPpuufxOwvC+Fi+JW
   E/2WRK9itDjRrubl4qyH75focKupxzwnpTj5qxZPKVroJOphhiVasyLHI
   nq4LPAimvv788mbJQL5pqJeXoAaxsafcWeBCa8YNYVvSn/jIyQ2pbU2Zj
   /FqhCP0UEFJEj7lmV7S4T33TMTeo+RjfY9lShy6Xl2mdvSEQkiXSZVL2y
   kR9zg0OelCBwxRDV7yU9UYI9Mo3CD0PrllzxZRIjSeFZaUK+WKDLTjMMZ
   b3NVKZK9bSTyHrIQUcVRH5R2IPnYlFcO7x5V5BnxligvhTjHQqo9DViX4
   A==;
X-CSE-ConnectionGUID: mrzDlL5NS96h49faoE2M7A==
X-CSE-MsgGUID: PpbiJABTTBO67dz0KiImiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88738405"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88738405"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:28:46 -0700
X-CSE-ConnectionGUID: lE/Zqrs9R1u7QdyvQ/triA==
X-CSE-MsgGUID: ywZFoh0zRoueK7zsobd2LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273795688"
Received: from unknown (HELO [10.238.208.122]) ([10.238.208.122])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:28:44 -0700
Message-ID: <cfe57e67-49ce-47d7-b20b-a29e23fe16d4@intel.com>
Date: Thu, 3 Sep 2026 15:28:41 +0800
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
 <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
 <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/3/2026 12:19 AM, Binbin Wu wrote:
> On 9/2/2026 11:09 PM, Xiaoyao Li wrote:
>> On 9/2/2026 8:33 AM, Binbin Wu wrote:
>>>>> +static void __init tdx_initialize_cpu_cfg_caps(void)
>>>>> +{
>>>>> +    tdx_cpu_cfg_cap_init(CPUID_1_ECX,
>>>>> +        TDX_CFG_EXTRA_F(MWAIT),
>>>>> +        TDX_CFG_F(TSC_DEADLINE_TIMER),
>>>>> +        TDX_CFG_F(AVX),
>>>>> +        TDX_CFG_F(F16C),
>>>>> +    );
>>>> TDX 1.5.24 on SPR report configurable bits of CPUID_1_ECX as
>>>> 0x31044988, which have
>>>>
>>>> - bit 3        MWAIT
>>>> - bit 7        EST
>>>> - bit 8        TM2
>>>> - bit 11    SDBG
>>>> - bit 14    XTPR
>>>> - bit 18    DCA
>>>> - bit 24    TSC_DEADLINE_TIMER
>>>> - bit 28    AVX
>>>> - bit 29    F16C
>>>>
>>>> but EST/TM2/SDBG/XTPR/DCA are not list here. I guess the reason is kvm_cpu_cap[] doesn't support it. If so, it seems to guard twice:
>>>> 1. mentally/manually check if it a feature is supported in kvm_cpu_caps[]
>>>>
>>>> 2. kvm_cpu_caps guarding in tdx_cpu_cfg_cap_init().
>>>>
>>>> I think 1) is not necessary, we can rely on 2)
>>> In general, if a feature is not supported by the common KVM CPU caps, 
>> For kvm-intel.ko, kvm_cpu_caps[] just means the supported CPUID features
>> for VMX VMs. Treat it as the common KVM CPU caps is a bit arguable.
>>
>>> I prefer not
>>> to add it to the list to save a few lines of code, which probably is dead code,
>> I don't think it's dead code. It shows that these features are
>> virtualizable to TDs from the POV. of TDX.
> It depends on whether KVM allows userspace to set features for TDs that are not support
> for non-TDX VMs (,except for a few exceptions).
> 
> In this version, TDX_CFG_F() already check against kvm_cpu_caps[], if these features
> are not in kvm_cpu_caps[], it will not be exposed to userspace anyway.
>

I still think the reasoning that we omit them because they are not
contained in kvm_cpu_caps[] sounds not right. Based on it, so when we are
going to add a new feature for TDX, we need to first manually check the KVM
code to see if that feature is contained in kvm_cpu_caps[] already. If not,
we just don't add it to TDX's list. Then why need to cap the result
kvm_cpu_caps[] for TDX_CFG_F() again? Just for safety in case human make
mistake and misread the code of kvm_cpu_caps[]?

I think they are two independent steps:
1. list the CPUID features that KVM can support for TDs.
2. apply additional restrictions, e.g., if a feature is not allowed for
non-TDX VMs, it cannot be allowed for TDs.

>> In the end, they might be disallowed to be configured to TDs because KVM
>> doesn't allow them for VMX VMs. This is also the point I want to discuss.
>> Do we really want to make such restriction that KVM cannot enable/allow a
>> feature for TDs unless KVM first enables/allows it for VMX VMs? What's
>> reason behind it?
> Sean mentioned it that "generally speaking, KVM shouldn't allow features
> that KVM doesn't support for non-TDX VMs" in
> https://lore.kernel.org/kvm/aj1fi_0SBxMK5WOB@google.com/

For existing features, it might make some sense. But for new features, I
don't think so. It defines the enabling order for new features that we must
enable a feature for non-TDX VMs first and then TDs. And people might want
to bypass this rule by abusing the TDX_CFG_EXTRA_F() when only one line of
TDX_CFG_EXTRA_F() is enough to enable a feature for TDs but more effort
required to enable it for non-TDX VMs.

Maybe I miss somthing. I would like to see stronger reasons for such decision.

