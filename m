Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485AF3C0624
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848390; cv=none; b=dHSlgqC1PYkDuxvFkDTbBI1q9pVWyS6+lPHnW1G9LliFceWRP1Z3SkZq42lVYSFTEylTv0aaZKKDG3sQsfk657MGnM0lVwZJvMp6b6Vpn/YQ1K6jWZJsOw0LU2lqib/gg+y362H9yDyE0ZXAOwAWuru8e3hmgHSSvKpiXyeWvUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848390; c=relaxed/simple;
	bh=BDpkwmS7Ss1+tywQFmikr+msx+/dKPHRNjl0SAy5LZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9vB5Csxf+/Zsz26t5ay5Dck/iwKGD0nbNOWXm6/xldIwGN9HABzyexMIFufWDGY++72C3d/U8mCs+Kt7wnwwCivDb5N6ROQZwm/Qk+P3aYyGJWnY8k7xuKF4szFGULm3XbRphOK9UlAowqABKdlMTfKqa1FxAGyBBYImN2w1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmpPhPUC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmpPhPUC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776848388; x=1808384388;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BDpkwmS7Ss1+tywQFmikr+msx+/dKPHRNjl0SAy5LZ8=;
  b=QmpPhPUCADtd2NSaFVVpXcPXl80pFDDVQ3pG5FYRd987rcWrfR3sL+h0
   wahW4ziJDfRAaf2mXMACR4G71YhZXgrybDsyl4V4WiNfGNa03qDEqIMY/
   Vyh1gu5OQEf385ZASIwLCOroZVM4xM41+k98CZoCFnJV/QL5Wxq+5tU4t
   RlfXfVyoCNM0MshvM9xkBS6INrvGi4Xw6P5IMxmyH7Bs41Vpez3qTvCJ4
   IF2g9jgpCzA+M/NWWeUh+8Wadj83BZz9s+85D714njgFE0sK3JtqtWM/K
   mi3Fieq8ygVBGvax4d2VBDldGinBuBTeUGqUgR8JES0fBySAHLOSLXG1n
   w==;
X-CSE-ConnectionGUID: g32+x3N7TN6aorY5Zj1jFA==
X-CSE-MsgGUID: BZmYUaFoSdKGppL4EDWt/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77500501"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77500501"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:59:47 -0700
X-CSE-ConnectionGUID: lKoZ4/QJRHeHOfYT8/+ezQ==
X-CSE-MsgGUID: j4myfYXyQ7mZY1aXc0SX1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="236300212"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:59:45 -0700
Message-ID: <ce8ae1eb-77ae-43b3-973e-ef27cc0c6832@linux.intel.com>
Date: Wed, 22 Apr 2026 16:59:43 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 22/27] KVM: x86: Verify userspace CPUID inputs in
 paranoid mode
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-23-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260417073610.3246316-23-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Below are responses to issues reported by sashiko. [1]
[1] https://sashiko.dev/#/patchset/20260417073610.3246316-1-binbin.wu%40linux.intel.com?part=22

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 08f5bc1d26b10..2027230a1f426 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
[ ... ]
> +static int cpuid_check_and_set_vcpu_caps(struct kvm_vcpu *vcpu,
> +					 struct kvm_cpuid_entry2 *entry)
> +{
[ ... ]
> +		/*
> +		 * A vCPU has a feature if it's supported by KVM and is enabled
> +		 * in guest CPUID.  Note, this includes features that are
> +		 * supported by KVM but aren't advertised to userspace!
> +		 */
> +		vcpu->arch.cpu_caps[leaf] = supported;
> +		vcpu->arch.cpu_caps[leaf] &= cpuid_get_reg_unsafe(entry, reg);
> +	}
> +
> +	return 0;
> +}
> +
> +int kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> +{
[ ... ]
> +	/*
> +	 * If CPUID paranoid mode is enabled, KVM rejects userspace's guest
> +	 * CPUID definition if it contains any bits that aren't supported or
> +	 * unknown by KVM.  Otherwise, reset guest capabilities to userspace's
> +	 * guest CPUID definition, i.e. honor userspace's definition for
> +	 * features that don't require KVM or hardware management/support (or
> +	 * that KVM simply doesn't care about).
> +	 */
> +	for (int i = 0; i < vcpu->arch.cpuid_nent; i++) {
> +		r = cpuid_check_and_set_vcpu_caps(vcpu, &vcpu->arch.cpuid_entries[i]);

Issue #1:
"KVM_SET_CPUID2 allows userspace to pass an array of CPUID entries which may
include duplicates. Because this loop iterates sequentially over the entries,
if duplicates are provided, won't vcpu->arch.cpu_caps reflect the
capabilities of the last matching entry in the array?
KVM's guest CPUID emulation uses kvm_find_cpuid_entry(), which searches the
array sequentially and returns the first matching entry. Could this cause a
state mismatch where KVM enforces access controls and emulates behaviors using
the capabilities defined in the last entry, but the guest software makes
decisions based on the first entry?"

Indeed.

I am not sure whether CPUID paranoid mode should reject userspace's input
if there are duplicated entries.
There could be two options:
- Detect whether a vcpu cap has been set, if there is a duplicated entry,
  reject the whole input or ignore the later one.
- Split the cpuid paranoid check out.


> +		/*
> +		 * No need to worry about the changes having been made if any
> +		 * check fails, all the changes will be reverted when returning
> +		 * an error on the set CPUID patch.
> +		 */
> +		if (r)
> +			return r;

Issue #2:
"The comment mentions all changes will be reverted on error, but is
vcpu->arch.xen.cpuid fully restored if we fail here?
When kvm_set_cpuid() updates vcpu->arch.xen.cpuid with the Xen base and limit
from the new entries, it happens before calling kvm_vcpu_after_set_cpuid().
If this paranoid check fails and returns -EINVAL, the error recovery in
kvm_set_cpuid() restores the old CPUID entries and cpu_caps, but it appears
to miss vcpu->arch.xen.cpuid.
Could this leave vcpu->arch.xen.cpuid out-of-sync with the restored CPUID
array, potentially allowing a malicious VMM to expose Xen-specific emulations
at a ghost CPUID leaf?"

It's the same issue as below:
https://lore.kernel.org/kvm/1931c7d3-b21e-4704-9012-4a16597bbebf@linux.intel.com/

>  	}
>  
>  	kvm_update_cpuid_runtime(vcpu);

