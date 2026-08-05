Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CB9EEA8
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 04:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785903385; cv=none; b=oaWYqGfPtQieeuoIu7/WUgt6rA29A0fdKj0oUUVelxjJsJOVNHGcdSKSui0f4kTg8USjfq/lnZ2Tv7L+iSci4Qvoq4YBEthHw1gF51YEagoF6msoo00CtFvmjvUXDrdnMwEFcBcFB+iBI+nyUw/xpPb6ufrLYZSsSM79gVGLvIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785903385; c=relaxed/simple;
	bh=unJQYHAH6hDo54l3GGjfz1wcZg/tgXLXapLpNN6tdGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g03dCmh/w1qb7LXN0Rll5sDQu80cUIpVYnCmc+sTq6eDxRV3+nEzJTLPXV+DBn+VZv9DDdaODzWyCRrPRlx8NV94zA6S8/oCxiNuXFrAtF2ZZ60wOA47QuW8Fvdhr7IpKQEblBsNRA5QrTH1BtBpqqnr2I4amOiwgEZshkyt94I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGBP6wmf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGBP6wmf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785903384; x=1817439384;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=unJQYHAH6hDo54l3GGjfz1wcZg/tgXLXapLpNN6tdGI=;
  b=YGBP6wmfQJdG5pSmnYQVbSMIc4nbweXEz/unPCIj7aTUXsEeOb9D+zmy
   JhrF5+X1sJpcws4FywvVJvLPI/3U4k0LnRf9KjVktctajvyWseLE0AK3o
   sgXziGriXVNqmAXve6/UbKoJWWQvv2nnmNu9Md1d35HQKFaXvbwXb3sn2
   QfzIM2+3mx35V/chWyYE25mpxJWgtq13yXGNETBB01Mf6FmjDbZajsk6h
   /hWskOuukLoy6mc0drgZO6HMzWirHmfGWPF8PuQO7mHdqrF9K2tQ6kXHY
   256lQADiW/7B9RAHK5Fuy87QjeIr2KUcuwTSMGssTp0jx/sZ1AUI6H+hL
   w==;
X-CSE-ConnectionGUID: 3EQMvAdcRdu7MGPxHYFA4w==
X-CSE-MsgGUID: xwNe5xbDT2ahEazklgBFFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90281431"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90281431"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 21:16:23 -0700
X-CSE-ConnectionGUID: saPUjthZQEC+zZ44+8ENYw==
X-CSE-MsgGUID: Yb5wcbtWTjmrCl1Im0fBBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="286339715"
Received: from fuxiaogu-mobl1.ccr.corp.intel.com (HELO [10.238.208.47]) ([10.238.208.47])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 21:16:22 -0700
Message-ID: <cab386d6-ddd1-4768-952b-9b7c05087312@intel.com>
Date: Wed, 5 Aug 2026 12:16:19 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: TDX: Enable Notify VM exit
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
 <20260805031257.1844914-2-xiaoyao.li@intel.com>
 <20260805033851.38FAD1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260805033851.38FAD1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/2026 11:38 AM, sashiko-bot@kernel.org wrote:
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index 545b03d9d10b8..cdc0d24657acb 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
> [ ... ]
>> @@ -3157,6 +3160,13 @@ static int tdx_vcpu_init(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
>>   	td_vmcs_write64(tdx, POSTED_INTR_DESC_ADDR, __pa(&tdx->vt.pi_desc));
>>   	td_vmcs_setbit32(tdx, PIN_BASED_VM_EXEC_CONTROL, PIN_BASED_POSTED_INTR);
>>   
>> +	if (kvm_notify_vmexit_enabled(vcpu->kvm)) {
>> +		td_vmcs_setbit32(tdx, SECONDARY_VM_EXEC_CONTROL,
>> +				 SECONDARY_EXEC_NOTIFY_VM_EXITING);
> [Severity: High]
> Does this allow an unprivileged userspace process to trigger a host-side
> KVM_BUG_ON() and crash the host if panic_on_warn is enabled?
> 
> If KVM advertises KVM_CAP_X86_NOTIFY_VMEXIT globally based solely on CPU
> hardware support, userspace can enable it for a TDX VM. If the underlying
> TDX module (e.g., v1.0) does not support Notify VM Exiting, this write
> will fail.
> 
> When the TDX module write operation fails, the macro backing
> td_vmcs_setbit32() calls tdh_vp_wr_failed(), which triggers a KVM_BUG_ON():
> 
> arch/x86/kvm/vmx/tdx.c:tdh_vp_wr_failed() {
> 	KVM_BUG_ON(1, tdx->vcpu.kvm);
> 	pr_err("TDH_VP_WR[%s.0x%x]%s0x%llx failed: 0x%llx\n", ...);
> }
> 
> Should we verify that the loaded TDX module actually supports the Notify VM
> Exit feature before attempting to program these TD VMCS fields?

Every TDX module should support this feature and SEAMCALLs to set the TD 
VMCS will not fail as long as the hardware supports the feature. The 
hardware support is checked by KVM and reflected in 
kvm_caps.has_notify_vmexit.

If any TDX module doesn't allow to program the TD VMCS fields of Notify 
VM exit, it's just a bug of TDX module.
