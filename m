Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFACB211A09
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 03:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782270983; cv=none; b=KuDCS92/xp0RFJGKPD6yLFEAXGH7R2Fc06IgNTTMiz9nQTzwCzIAJbK92O5zQRUAYfYd7vBdxlzfSZOdipgqgUpTxxhnEDUMg1j03cgWjQE4HOoihsBEYhLYI2hjdRE19ygN4HaNRMN8AUyVLVfmcO/IkCtoZcVMhA+uORfGnzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782270983; c=relaxed/simple;
	bh=15Odll5aHJIRb6IFJ+qRYKwkGbg6A35jeWxfbNt0DTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EK+x60RS9w1Fe6i74ax/uh1ehcFXfONo/pgV74AF3WpnkJMcRoBxBksfwOMct3lr8Nx+Tm7zc6QV3SmFNeGbUfldsfXSX3aADQs6Z4AJU9ESIQMkm2qyCQ5nQ37JHjG8fMR2sHKh4zMYiNoUZ4aqEtgMQikJeG/Hi759kloI4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJW3Nmvb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJW3Nmvb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782270981; x=1813806981;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=15Odll5aHJIRb6IFJ+qRYKwkGbg6A35jeWxfbNt0DTw=;
  b=GJW3NmvbnvrI7/px8/5rbVEi1rou4FcP30ymRCUp9IOQxGZpQm9uDhhj
   TGLSp2xBXl63O7EAYsrXAQTgA3x0y3ziJCx86pGBwtqd83HHR9Mhiyw7S
   4JfSwxaGVSUwBnbPtHDb41u+JC8V4zBfXV2IX5MsColrPfaivwkn1LhVR
   lDjqoprTCsmoSLEnE4ALYBLm2WYgU1Us+os8CpYfz3nVUQXhoZQ4+bpvX
   Kllodj/quIctYxUEt1tVJM2FbIzt28ceplzEstEr7G6CftnGe2nom+TeC
   mr3hcrZU/nNf/ijhidWJHlaQF7OpJnmPiYSGpOzZB3Bt6V9gnMEg8HWVV
   g==;
X-CSE-ConnectionGUID: S0JR2DyKSSy6dfIqGUXQlg==
X-CSE-MsgGUID: PTgVXhPVRC20q77oWu5jPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82892553"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="82892553"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 20:16:20 -0700
X-CSE-ConnectionGUID: 9KqWf4kbQ22mcr2eUbItCA==
X-CSE-MsgGUID: 0WF2HMbsTQe58m223ih1Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="245558289"
Received: from bparkins-mobl.amr.corp.intel.com (HELO [10.246.164.236]) ([10.246.164.236])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 20:16:20 -0700
Message-ID: <92226edf-6943-485c-a127-dc2b1acd4a4d@intel.com>
Date: Tue, 23 Jun 2026 22:16:19 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/4] KVM: x86/pmu: Support PERF_METRICS MSR in mediated
 vPMU
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <20260623041927.178256-1-zide.chen@intel.com>
 <20260623041927.178256-4-zide.chen@intel.com>
 <20260623044826.592FF1F000E9@smtp.kernel.org>
 <bcbc4f64-60e9-46a8-bf63-19e7d9d30595@intel.com>
 <ajsXxXHz-oIcSXDE@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <ajsXxXHz-oIcSXDE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/23/2026 6:33 PM, Sean Christopherson wrote:
> On Tue, Jun 23, 2026, Zide Chen wrote:
>> On 6/22/2026 11:48 PM, sashiko-bot@kernel.org wrote:
>>>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>>>> index 59b7a90c79e12..2c3367f5e2dfb 100644
>>>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>>>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>>> [ ... ]
>>>> @@ -345,6 +347,11 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>>>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>>>>  		msr_info->data = pmu->fixed_ctr_ctrl;
>>>>  		break;
>>>> +	case MSR_PERF_METRICS:
>>>> +		if (!msr_info->host_initiated)
>>>> +			return 1;
>>>
>>> [Severity: High]
>>> If KVM needs to emulate a guest RDMSR instruction targeting MSR_PERF_METRICS,
>>> won't this unconditional return inject a #GP fault into the guest?
>>
>> I can't think of a case that KVM needs to emulate RDMSR/WRMSR on
>> MSR_PERF_METRICS.
> 
> If the literal emulator happens to emulate a RDMSR/WRMSR, KVM should behave
> correctly.  Even if that weren't the case, KVM's implementation should adhere to
> the architecture.  Assuming MSR_PERF_METRICS is read/write, KVM should emulate
> it as such.

Thanks! I can remove these from {get_set}_msr() handlers.

if (!msr_info->host_initiated)
	return 1;
