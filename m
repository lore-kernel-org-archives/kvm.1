Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6C23C8A0
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407584; cv=none; b=OZwYlWVk30/RbvJwKoOKMFzMWbHmiKCYJ2SwUON61VuSwYXBMDh+QSNesWgLQmZCYzRIS09G+63mw4Pmja9nPKgMT2e67txF8JHEf9epNQEP2WyPTuhESbwT9vymn65Tg8nsL5FiP/HNxRnkgMvJe03W2P9XRydSOqKRrCJwOrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407584; c=relaxed/simple;
	bh=U66L/gSSF6ngUPOZrEqZedSLeI0tHxIkX04NsxIq5Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5qeuy1H5RGmtIUBQZWUHYUGPv30v7VtUgWu5RSH6DakGcO/35xI8v1GFP8R9v9a1senpYXBstaoqNHc3WLvkxHR771bKlhM1LT1l2ZLerxVcjJkyGX/I1VmXaEj4NvnGpNUPkIkzI1aJnoio7LurD0lWxgQWeUEsTUasgaBo1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=He4vDi/c; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="He4vDi/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786407581; x=1817943581;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U66L/gSSF6ngUPOZrEqZedSLeI0tHxIkX04NsxIq5Oo=;
  b=He4vDi/c41xD3uWC8e9OkrUdhy5WzXvNqxE4b5x9p8YoK2rHo3pNrok5
   KutEy41SKJhia/H+IFmRNFe7mx6sFrii+UfX13a/Mx79kwoaZw4Y+n0jS
   S1EP7uDk6Cya/m/O4IU6x9P70eZ3TCRx6NEJuIHNIZeZbMMF7ujlKtLRI
   WXDQQwK2SO/eMndzSFOiA0dEe9EZBiyeS8/l6CWXut58yP/f4FEsIr5wD
   Ekk349ypMzvRpIRvNGc4Ko3g6dDRxtgJ+OncWVsxZ1tY8HoEEaBVor/+P
   xooAfyJe5k2wwElIf8Mov/DFAV1Md6J2HenxhxrBT+CzZ3h4aCOn01Vim
   w==;
X-CSE-ConnectionGUID: Wjqh/Qh5TnWAZHm8X7Eayw==
X-CSE-MsgGUID: yUPBvpjpRM2aa+hegZeUVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="90747209"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="90747209"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 17:19:40 -0700
X-CSE-ConnectionGUID: SiDjlxTFTW+eL2+BBTuAHQ==
X-CSE-MsgGUID: P7z0nwhJQaum795k3EHlNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="259879762"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.248]) ([10.124.240.248])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 17:19:38 -0700
Message-ID: <07df932f-ca83-463d-b830-aa10a8fa11f2@intel.com>
Date: Tue, 11 Aug 2026 08:19:34 +0800
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
 <anplcWfYReCMeu1A@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <anplcWfYReCMeu1A@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/2026 7:57 AM, Sean Christopherson wrote:
> On Mon, Aug 10, 2026, Xiaoyao Li wrote:
>> On 8/10/2026 7:39 PM, sashiko-bot@kernel.org wrote:
>>>> @@ -2147,7 +2156,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
>>>>    	struct vcpu_tdx *tdx = to_tdx(vcpu);
>>>>    	*reason = tdx->vt.exit_reason.full;
>>>> -	if (*reason != -1u) {
>>>> +	if (tdx->vt.exit_reason.basic != -1) {
>>> [Severity: Medium]
>>> Will this check always evaluate to true due to C integer promotion rules?
>>>
>>> The basic field in union vmx_exit_reason is a 16-bit unsigned bitfield. When
>>> comparing it to -1, the unsigned 16-bit value is promoted to a signed 32-bit
>>> integer. If the value was set to -1 (65535), the comparison evaluates as
>>> 65535 != -1, which is always true.
>>>
>>
>> Well, how about something below on top of this patch?
> 
> No, we need to not rely on magic exit_reason.basic values.  Can't this be?
> 
> 	if ((tdx->vp_enter_ret & TDX_SW_ERROR) != TDX_SW_ERROR) {

I think the reason of checking if (*reason != -1u) in the original 
commit 095b71a03f49 ("KVM: TDX: Add a place holder to handle TDX VM 
exit") was that, -1u means there is no valid Exit Reason in the lower 32 
bits in vp_enter_ret.

Change it to check TDX_SW_ERROR, doesn't look correct to me. Set the 
EPT_MISCONFIG magic handling aside, TDX_SW_ERROR only means the SEAMCALL 
instruction faults, e.g., hitting #UD, #GP, or VMFAILINVALID. Just a 
small subset of the cases where there is no valid Exit Reason.

> 		<read values>
> 	} else {
> 		<zero values>
> 	}
> 
> We'd need to use the unsafe version if we go with my suggestion[*], but other
> than that wrinkle, the above seems like the obviously correct fix (maybe too
> obvious)?
> 
> [*] https://lore.kernel.org/all/anXxBzO41_5eaaOI@google.com

