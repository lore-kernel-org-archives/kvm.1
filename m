Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230883603DB
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 03:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786504839; cv=none; b=Ftp2liA6r/gOLVso13oCilvnHft6BSLUx6ZavJlOzhmnQ9u6qEUXNcZikZPkm881uBRT2oPC2EV1Qu+1k+UPKqXPevOm+sxUjGA0YynIahr+42DEi3b0gIE/riLPS3Zi6M7386WMzF/9Fj/ycmM8cEqrxqYrpOSKr0LlxsnmhHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786504839; c=relaxed/simple;
	bh=pf1Izqmm8qMk1Rs8eYqGQ2WUItGOSWftP7N2H8ZXY2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7OOh1t59D+mFxJ3hPS4j1VjpOV2w2MXo1q41yXdiz0InB0+PfZkfnVPzTmauGUjS9l9ObdoVCLUbUJ+CRyv7M3NypWbjJjimNo9eO73n0t2LkLl1PaiWdO0dd8ksjimTdkqKGa/wef6D4T1KOctdT590oFiauqn8ZAGz0RoXPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/SjMQG0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/SjMQG0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786504837; x=1818040837;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pf1Izqmm8qMk1Rs8eYqGQ2WUItGOSWftP7N2H8ZXY2A=;
  b=Y/SjMQG0AlOrNbgsWRyy+XNCBraeMyu8xxdnbWiUijzjLwSq/HUtDzrt
   Bd3AtUFVID86oqw+FfrgIy0nXfxTWNyrvAA616Z1lwneMKNj1SUBLFaJE
   d/igdv5dgbTEJYHDMljTXc3KBW2xO+r5ao1ljKC+I2T5aVdmpmeL56YbL
   riLy/z1GRTFJDYnlbPt1Ok0WAH0frZSxnNLu2vvPFLYi5jdfJddbA+Fja
   zdbMrIDCLcJycxQjpbU2kZy072uxjvoETu7VdgPauknqBPo28oCUqaM0z
   37R/CmhkNbklg0epalP2yhogqxCL65uwHqmJQPsOUDuaPJrJEKyIkKl68
   A==;
X-CSE-ConnectionGUID: oPc8KWKtTyioOSXU1HK5hQ==
X-CSE-MsgGUID: EZyi2mAcS1+zoBWdThXhJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="109837449"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="109837449"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 20:20:36 -0700
X-CSE-ConnectionGUID: avSV+OqBTNCyyKyBuLc8ng==
X-CSE-MsgGUID: 9YYSkj2nR72Spn6FHTlGlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="268662293"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 20:20:34 -0700
Message-ID: <95d81370-3244-43c8-a6fb-6c2146d24dda@intel.com>
Date: Wed, 12 Aug 2026 11:20:31 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
 <20260810112200.2326727-3-xiaoyao.li@intel.com>
 <20260810113924.4ACBE1F000E9@smtp.kernel.org>
 <13ea6279-a342-493b-a0f8-15ac5b4c59ad@intel.com>
 <anplcWfYReCMeu1A@google.com> <anpnFAK6EZToizbZ@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <anpnFAK6EZToizbZ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/2026 8:04 AM, Sean Christopherson wrote:
> On Mon, Aug 10, 2026, Sean Christopherson wrote:
>> On Mon, Aug 10, 2026, Xiaoyao Li wrote:
>>> On 8/10/2026 7:39 PM, sashiko-bot@kernel.org wrote:
>>>>> @@ -2147,7 +2156,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
>>>>>    	struct vcpu_tdx *tdx = to_tdx(vcpu);
>>>>>    	*reason = tdx->vt.exit_reason.full;
>>>>> -	if (*reason != -1u) {
>>>>> +	if (tdx->vt.exit_reason.basic != -1) {
>>>> [Severity: Medium]
>>>> Will this check always evaluate to true due to C integer promotion rules?
>>>>
>>>> The basic field in union vmx_exit_reason is a 16-bit unsigned bitfield. When
>>>> comparing it to -1, the unsigned 16-bit value is promoted to a signed 32-bit
>>>> integer. If the value was set to -1 (65535), the comparison evaluates as
>>>> 65535 != -1, which is always true.
>>>>
>>>
>>> Well, how about something below on top of this patch?
>>
>> No, we need to not rely on magic exit_reason.basic values.  Can't this be?
>>
>> 	if ((tdx->vp_enter_ret & TDX_SW_ERROR) != TDX_SW_ERROR) {
> 
> This would arguably be a bug fix as well, because the "real" EXIT_REASON_EPT_MISCONFIG
> path gets a false negative.  E.g. when getting information for an EPT Misconfig
> for the tracepoint, KVM really should print all information, not zeros.
> 
> At a glance, this exact change can probably be a separate patch too.

Yeah, this issue can be fixed by the patch which turns real 
EPT_MISCONFIG to TDX_SW_ERROR.

Side topic, tdx_to_vmx_exit_reason() can change EXIT_REASON_TDCALL to 
other Exit Reason. Do we want to print TDCALL instead of the transformed 
reason here?

>> 		<read values>
>> 	} else {
>> 		<zero values>
>> 	}
>>
>> We'd need to use the unsafe version if we go with my suggestion[*], but other
>> than that wrinkle, the above seems like the obviously correct fix (maybe too
>> obvious)?
>>
>> [*] https://lore.kernel.org/all/anXxBzO41_5eaaOI@google.com

