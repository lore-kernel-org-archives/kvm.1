Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E60B35F61A
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752297; cv=none; b=tJEG2APIjm4LobMoKKyqjDJEOskwz+kpFdwBfSwiSl7R5XT48y7NVbZ04gCHkfUImoyMc2CUBII5NyxQG+4uvb7c8qvD5E1aA89giAIhOjCiP1E6iWZbArEJR8UdsIHh2dPHcRfgHrjwvnJND/xDllCT9XLJlJgK6MKtsLhe+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752297; c=relaxed/simple;
	bh=Lt6CLqucIEBhg3jt7wlbbE0v1sLjAZ7iP9tkFkVMKvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuC576YY5HszJ7QdcfqqsoxYboMUMkAt1EDwTzaaI1F96i0/65wpbYm0m5ik89wfQ14+WKGZ+hHSQt7vyYphQBSc3DqfiwTgU6KzxYgwdwWl5xfBOO1s2MYnupFO/5gxeSV+1OsEZx9aaoiCnzVCmQY2phDRLcSoq6UdZzcEGIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtATr2BB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtATr2BB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776752296; x=1808288296;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Lt6CLqucIEBhg3jt7wlbbE0v1sLjAZ7iP9tkFkVMKvY=;
  b=WtATr2BBgyEdrAmENRIoYzuX0bAGYCigHZ+wdReDRETPFm0+Ji5/W6wZ
   hEwTpFpjEFrsaLRGb1/Ift2AiaO8IggkAA4LYWDk/zNpn85+L2uoGr43n
   AmxU6wnLlQsI0xCehfN9FdPBVTMLYXMHmTMi4qhNouI3FyGA0hD/mzaZY
   9PFweHeXLoxjzOrl7gM72r/SenNRmgTvy1sfM/VmFhKrf5mCK1tC27vw9
   bXR/+9cKu6rHH+/87a0DhAqPcyPffdKTvLp/xaHqWXLxR+09LwSCHws+T
   rGl3TvbwZsMlg6VVcsHA3AUJe5cmipPee/36KZ0GluCEO3FN0UzCs+jfe
   g==;
X-CSE-ConnectionGUID: Eh5KWAPdTQWktWWucV6CdA==
X-CSE-MsgGUID: 4IUJi4a+SlqVTQS3EK+zcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89148383"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="89148383"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 23:18:15 -0700
X-CSE-ConnectionGUID: IuTketUKRAmEQilikOdeSQ==
X-CSE-MsgGUID: 85PuuKiASi+LHPLm81CWQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="232220395"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 23:18:14 -0700
Message-ID: <a8cf84f0-b2e8-4c64-8a11-afceee864754@linux.intel.com>
Date: Tue, 21 Apr 2026 14:18:11 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/27] KVM: x86: Thread @kvm to KVM CPU capability
 helpers
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-9-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260417073610.3246316-9-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Below are responses to issues reported by sashiko. [1]

[1] https://sashiko.dev/#/patchset/20260417073610.3246316-1-binbin.wu%40linux.intel.com?part=8

>  
> diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
> index fa41d036acd4..302f7953b939 100644
> --- a/arch/x86/kvm/vmx/hyperv.c
> +++ b/arch/x86/kvm/vmx/hyperv.c
> @@ -38,7 +38,7 @@ uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu)
>  	 * Note, do not check the Hyper-V is fully enabled in guest CPUID, this
>  	 * helper is used to _get_ the vCPU's supported CPUID.
>  	 */
> -	if (kvm_cpu_cap_get(X86_FEATURE_VMX) &&
> +	if (kvm_cpu_cap_get(NULL, X86_FEATURE_VMX) &&
>  	    (!vcpu || to_vmx(vcpu)->nested.enlightened_vmcs_enabled))
>  		return (KVM_EVMCS_VERSION << 8) | 1;
>  

"
Will this hardcoded NULL bypass the VM-specific capability overlay when the
vcpu pointer is available?
Since the patch prepares KVM to select CPUID overlays based on the VM type,
passing NULL here will cause it to fall back to the host's global capability.
If a specific VM type's overlay disables VMX, could this result in KVM
improperly advertising Enlightened VMCS support in the vCPU's Hyper-V CPUID?
Would it be better to respect the VM-specific capability overlay while
preserving support for the global ioctl where vcpu is NULL, for example
by calling kvm_cpu_cap_get(vcpu ? vcpu->kvm : NULL, X86_FEATURE_VMX)?
"

VMX overlay is used here since this function assumes the vcpu is VMX vcpu if
it's not NULL. However, currently, KVM doesn't check whether the vcpu is VMX
in the code paths for EVMCS, e.g. nested_enable_evmcs(). If userspace
requests KVM_CAP_HYPERV_ENLIGHTENED_VMCS on a TDX vCPU, it could corrupt the
TDX vcpu (it's benign for now since the offset of nested.enlightened_vmcs_enabled
is not defined in struct vcpu_tdx, but it could cause problem in the future if
struct vcpu_tdx is extended).

So I am wondering KVM should reject the code paths for EVMCS if the vcpu is TDX.

