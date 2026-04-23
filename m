Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835C19AD5C
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776912081; cv=none; b=WmvOZBdZsXKPipa3fS1sgmu+CHNdB7bGt4++xaDTfOIKccQ76vR/7MLbNYOqYlWb92tW2ZHQM8ALuol4MkYuCQYpvSpzLI6uOyEv1GAtXPWgx2GQkhEi0njQ1adMFfs56sFCkllckRI72R1/i6gr+GYE7siGFuJcYuPeVMnLBNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776912081; c=relaxed/simple;
	bh=aD2RLbzrLKWETBDINCIi1h77eqnrq9tgJKrv1vYZiUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubhaXCwxT76VQV2a1WAiYyvbTgHE5CmLkm/GAg7FbIgNduKm/JRLVw65KkgIW4fxuzxuoxJ5Iy4ORPpNATJuRAQU8T7VDOaMJDu24m0bIRUGI9y3PeHknF3ocj3TQ6rfI82iE8Zl1vsLsE/uAc9u1gISNLzEsVatRblVPahP5BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqXVXXHv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqXVXXHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776912079; x=1808448079;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aD2RLbzrLKWETBDINCIi1h77eqnrq9tgJKrv1vYZiUY=;
  b=CqXVXXHvoGXhQpnkSz4f8EqA3dvXARcN+p60HiPqKflTqWWllKWk2tNv
   mOX/WmQcceTQ8DMP/5coY2zPxxEGOpQqN2XBTxars0jL+JUTWJrKLM/z4
   Ni+RXiW17EmhvD+7/MfJQl4Ml2XJOVWK5AtSjFvFWtnlHMFhXfUk7ltn6
   YdX5IJR6ItxQLeuA9sYxNTlG8UNMYjsnCn/QSO8/BELLT+0Xp2+Dhn2eK
   fu0du5wbEoniUWntmno4BSzSmW5fI8+1wyiHUCFFRqG78oNocdFxCkWZ+
   dzLCZnTbDRn68akuWNuIV9nYX7aSZNxIEWHBiRjKJ+bnEd+3MitJySKIY
   Q==;
X-CSE-ConnectionGUID: 4jmHLYFPTJSdKVQZn9JLDw==
X-CSE-MsgGUID: ydCqj5rBQDW78dtCDcRWdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="81737217"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="81737217"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 19:41:19 -0700
X-CSE-ConnectionGUID: 16QbutN6QcKXdX8Nvq1mTQ==
X-CSE-MsgGUID: JAYcH90WTlecQv7AGR1QPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="262916070"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 19:41:16 -0700
Message-ID: <e6b9b880-446f-465b-af57-9fad6ee97d81@linux.intel.com>
Date: Thu, 23 Apr 2026 10:41:14 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 23/27] KVM: x86: Account for runtime CPUID features in
 paranoid mode
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-24-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260417073610.3246316-24-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Below are responses to issues reported by sashiko. [1]
[1] https://sashiko.dev/#/patchset/20260417073610.3246316-1-binbin.wu%40linux.intel.com?part=23

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 2027230a1f426..af87b803572c0 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -498,6 +498,24 @@ static int do_cpuid_reg_paranoid_check(struct kvm *kvm,
>  	return -EINVAL;
>  }
>  
> +static u32 get_cpuid_reg_dynamic(struct kvm_vcpu *vcpu, u32 func, u32 index, int reg)
> +{
> +	switch (func) {
> +	case 1:
> +		if (reg == CPUID_ECX && kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE))
> +			return feature_bit(OSXSAVE);
Issue #1:
"Does this create a circular dependency that breaks VM migration?
KVM requires X86_FEATURE_XSAVE to be present in the guest CPUID before allowing
CR4.OSXSAVE to be set (via cr4_guest_rsvd_bits). Because of this, VMMs must call
KVM_SET_CPUID2 before KVM_SET_SREGS during VM restore.
However, get_cpuid_reg_dynamic() requires the vCPU's CR4 register to already have
the OSXSAVE bit set in order to include the OSXSAVE feature bit in the supported
mask.
If a VMM live-migrates a running VM and passes the current CPUID array (where
KVM has dynamically set OSXSAVE=1), will KVM_SET_CPUID2 falsely reject the array
with -EINVAL because the destination's CR4 is still at its reset value (0)?
This would mean CPUID needs CR4 to validate OSXSAVE, but CR4 needs CPUID to allow
OSXSAVE, breaking live migration when paranoid CPUID checks are enabled."

This should be a false positive.

If userspace needs to set CR4, it should use KVM_SET_{SREGS,SREGS2}, which doesn't
rely on the CPUID bit.

Actually userspace doesn't need to set OSXSAVE CPUID bit explicitly, KVM will take
care of it.

This helper exists to handle the scenario as following, which exists in KVM selftests:

E.g. in hyperv_features.c
guest_test_msrs_access
|   vm_create_with_one_vcpu
|   |   ...
|   |       vm_arch_vcpu_add
|   |       |   vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid())
|   |       |   vcpu_init_sregs
|   |       |   |   [kvm_cpu_has(X86_FEATURE_XSAVE)]
|   |       |   |       sregs.cr4 |= X86_CR4_OSXSAVE
|   |       |   |   ...
|   |       |   |   vcpu_sregs_set(vcpu, &sregs)
|   |       |   ...
|   |       |   vcpu_get_cpuid(vcpu)
|   ...
|   vcpu_set_cpuid(vcpu)  //OSXSAVE is set in CPUID.


> +		break;
> +	case 7:
> +		if (index == 0 && reg == CPUID_ECX && kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE))
> +			return feature_bit(OSPKE);
Issue #2:
"Could the same circular dependency issue also apply to OSPKE and CR4.PKE?"

Same as above.
