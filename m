Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F01D3F9FB;
	Tue, 11 Aug 2026 01:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786412685; cv=none; b=BjGEw7O2KuUiKCG7EO/OrpC8XVakN9pfR9DkJGj86zcWbYoJNSzczNyExMnpGfUQ8w/ls/XrvNmxf40HmSWfpN7+msoCusXZ4ApOQTvdXS5S6j0SBHQFxKUH7rqS9BaLjP2AhD2k232xkuzzBc/B9cc4xhLqZxcG5w2Tc0b/W90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786412685; c=relaxed/simple;
	bh=kwsV16Ea9koW28rdq/XhVS2W8hNBtgVPUbo+nA4TpAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVUjNxUSDMf3Cw+poCtx0w6z09E56xyBEvYb9jyNkMIVHNCiEQXQk9hhKVdcJ1/ApfduV2mmLn+6d1xO+mutSBFm/kf4NaiP4XtDQW2tUrQ6Yyl5O0G3ab75cUtjNyvO1Ah3mdeARnzwUyoZCi7WsXfapzG0RXovih0pEPcGeFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DY0izxqq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DY0izxqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786412683; x=1817948683;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kwsV16Ea9koW28rdq/XhVS2W8hNBtgVPUbo+nA4TpAA=;
  b=DY0izxqq/iHecYCbgQ+aUoa+XGSFwvOHV27Vpeb41BnsvqG9Vp9jM4eo
   7wNNCvYdkjxsfqHMQFktDNAZAgbfvyNVpqA5Xy5pv0Ou5w4+BbBhym/Th
   1SzJt5kiiw1rWK63M7QJQ8syWPnP0elxLza8ecgrnFzdk4AzIIsJ4a4fp
   6IuBkUcy34NLaBBtGy6NsyPxOVu7dloYdBPyhlLT8x19TH5ZDKqir8Qc/
   2dSa/XcU+1UMTDaqr+GcxwDnh57d9srPDjz593bp+U6AxXutPqwhin0xj
   uTxR5qGGNo1zKTSKKbxnUUVinC042OSYy3Ibf/CjFMCkHY/ogGtzM8+qz
   w==;
X-CSE-ConnectionGUID: J1XOe/9+RNebXUupMEu0vA==
X-CSE-MsgGUID: ykEYxBolRm+eMTqmlwKJOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="74471915"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="74471915"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 18:44:42 -0700
X-CSE-ConnectionGUID: eI4GrGmeT3e9Id99Mnu7dw==
X-CSE-MsgGUID: DCIgFoBlQ++NTz6VhKAcGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="259349751"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.248]) ([10.124.240.248])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 18:44:40 -0700
Message-ID: <88844d30-bd5a-40d6-9162-2129e026df08@intel.com>
Date: Tue, 11 Aug 2026 09:44:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] KVM: TDX: Enable Bus Lock VM exit
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "seanjc@google.com" <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kas@kernel.org" <kas@kernel.org>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
 <20260810112200.2326727-4-xiaoyao.li@intel.com>
 <fd9498858696baf30ab5b151f79fcf173d0fb0cd.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <fd9498858696baf30ab5b151f79fcf173d0fb0cd.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/2026 9:18 AM, Edgecombe, Rick P wrote:
> On Mon, 2026-08-10 at 19:22 +0800, Xiaoyao Li wrote:
>> Enable Bus Lock VM exit functionality for TDX guests.
>>
>> Userspace can enable KVM_BUS_LOCK_DETECTION_EXIT for TDX guests without
>> getting an error, but the feature is not actually enabled because KVM
>> does not yet program the TDX execution control or handle the resulting
>> exit.
> 
> A bit run-on to me. Why not break it up like it's explained in patch 1.

Will update it to way how patch 1 describes.

>>
>> Enable Bus Lock VM exit for TDX guests by programming the
>> BUS_LOCK_DETECTION control in the TD VMCS and by adding the exit handler.
>> Clear the bus_lock_detected bit to avoid being counted multiple times if
>> it needs to return early for wait_for_sept_zap case in tdx_vcpu_run().
>> Since the wait_for_sept_zap case is expected to be rare, just do the
>> clearing of bus_lock_detected unconditionally.
>>
>> Note, there is no enumeration bit for this feature by TDX module because
>> all TDX modules support it, and allow to set the TD VMCS as long as the
>> hardware supports the feature.
>>
>> Fixes: 161d34609f9b ("KVM: TDX: Make TDX VM type supported")
>> Cc: stable@vger.kernel.org
>> Originally-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes in v2:
>> - Don't overwrite the negative return value to 0. (Sashiko)
>> - Clear the bus_lock_detected bit when it returns early for
>>    wait_for_sept_zap case.
>> - Add a note to clarify the feature is always supported by the TDX
>>    module, to make Sashiko happy.
> 
> Ha! This is probably just being a bit funny. But let's treat AI review as
> suggestions only. If it is a good feedback, it can stand on it's own.

yeah. Mostly for funny. I think the clarification itself makes sense.

>> ---
>>   arch/x86/kvm/vmx/tdx.c | 28 ++++++++++++++++++++++++++--
>>   arch/x86/kvm/vmx/vmx.c |  2 +-
>>   arch/x86/kvm/vmx/vmx.h |  1 +
>>   3 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index a89885d550c9..ac3f71643cd5 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
>> @@ -1080,8 +1080,10 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
>>   	 * allowing vCPU entry to avoid contention with tdh_vp_enter() and
>>   	 * TDCALLs.
>>   	 */
>> -	if (unlikely(READ_ONCE(to_kvm_tdx(vcpu->kvm)->wait_for_sept_zap)))
>> +	if (unlikely(READ_ONCE(to_kvm_tdx(vcpu->kvm)->wait_for_sept_zap))) {
>> +		vt->exit_reason.bus_lock_detected = 0;
>>   		return EXIT_FASTPATH_EXIT_HANDLED;
>> +	}
> 
> Hmm. Why is this the only part of exit_reason that we care about in this
> scenario?

Because it's the only path on TDX that it returns without updating the 
vt->exit_reason. All the other cases go to tdx_vcpu_enter_exit() and 
tdx_vcpu_enter_exit() updates the vt->exit_reason.

> I went and looked for similar scenarios on the VMX side to see what it did, and
> didn't find any. Same for you?

VMX can return early without reaching vmx_vcpu_enter_exit() as well. But 
VMX ensures vt->exit_reason is updated when it returns early.

>>   
>>   	trace_kvm_entry(vcpu, run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT);
>>   
>> @@ -2037,7 +2039,7 @@ int tdx_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
>>   }
>>   
>>   
>> -int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
>> +static int __tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
>>   {
>>   	struct vcpu_tdx *tdx = to_tdx(vcpu);
>>   	u64 vp_enter_ret = tdx->vp_enter_ret;
>> @@ -2138,6 +2140,8 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
>>   	case EXIT_REASON_NOTIFY:
>>   		/* NMI blocking state is handled by TDX module */
>>   		return __vmx_handle_notify(vcpu, vmx_get_exit_qual(vcpu));
>> +	case EXIT_REASON_BUS_LOCK:
>> +		return handle_bus_lock_vmexit(vcpu);
>>   	default:
>>   		break;
>>   	}
>> @@ -2147,6 +2151,22 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
>>   	return 0;
>>   }
>>   
>> +int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
>> +{
>> +	int ret = __tdx_handle_exit(vcpu, fastpath);
>> +
>> +	/* Exit to user space when bus lock was detected */
>> +	if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
>> +		if (ret > 0) {
>> +			vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
>> +			ret = 0;
>> +		}
>> +
>> +		vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
>> +	}
>> +	return ret;
>> +}
> 
> Ok, so the plan is to consolidate this duplication on top of the backportable
> fix.

yes. The consolidation also requires to first fix the VMX part[1]. So 
this series only contains the necessary things that need to be 
backported to stable kernels.

[1] 
https://lore.kernel.org/all/20260806111923.1990562-2-xiaoyao.li@intel.com/
