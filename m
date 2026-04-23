Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58740241C8C
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776913383; cv=none; b=EyqYmdbrGlN0nFjRLgQRgYhD6fJn7YSInLpMIvJ0Z0GkEER/5M3YFPOWNIHcYUOQ4PhEgitu6vXWOSMPELKICCeGISUsP7ixGl2ftvpdVaTXpCZ24t3WgjMyA1HQssj8qxcsCaV4lXYYJ+n6UU5sOB+sc1Kv586dBOS983a/D1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776913383; c=relaxed/simple;
	bh=sVnvVkrbaStx8vuoSVTloJ5s9Sbv3jY+HH5jV0YzOXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5zdKPi3YjIJh87U8E+OdpO+rCtiZE6RWKtmDihudpigXruH3JVVTmVq0njZVXI/L1JqXLkcMDMM9V1eUPeiZbaa3VG/anaa4w98Z8Nk9RBo17huYwRXyQ5MdL0BQrIR+GoMB7TlSLlCwZ6dPplSCscUZPObCGtKxnEgUlJD1Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HoKxitWZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HoKxitWZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776913382; x=1808449382;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sVnvVkrbaStx8vuoSVTloJ5s9Sbv3jY+HH5jV0YzOXc=;
  b=HoKxitWZaOwOEG9qkSvv72fLEr3o2h8DQmFnRSqEGbGRBCpM5bzhzDVB
   JssXJnfzx9Crzs98SW4CbiCi/qjFMdTiaViXyDb4koJjYXofDeOZylGT2
   e6dYnPkt7YPqAOILuP84SH/X2sCYIpRn35SKV6h7rGfbtiMNjK7Hyh9/v
   cvUSZGm2lR0erQO5G6x5fHNYZ0azLLjattRJe0ehNW8IjW3wSCxZDvnw5
   GxHbGFymgekiY4rqFEmROYoIgzz5WYttzg3r9MYpTepP710y4Vj8Ma9MX
   wferDTZb2dent5Ellut4UU3WTyxvHrRc0Y4tbDXWkkbtIkBP8muCP0CIz
   w==;
X-CSE-ConnectionGUID: gO6V6VjMR8GdDzu+xL8i3w==
X-CSE-MsgGUID: VhonEBMsRFaqJcfgsX2XiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="78064841"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="78064841"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 20:03:00 -0700
X-CSE-ConnectionGUID: KYqjoDmYS2eheQ44V93sgQ==
X-CSE-MsgGUID: 2kWZcXRTTX2uWyOJ1HQDkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="232841753"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 20:02:58 -0700
Message-ID: <79fec7dc-e275-43f5-a5ba-f420ce61676a@linux.intel.com>
Date: Thu, 23 Apr 2026 11:02:55 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 24/27] KVM: x86: Skip paranoid CPUID check for KVM PV
 leafs when base is relocated
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-25-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260417073610.3246316-25-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Below are responses to issues reported by sashiko. [1]
[1] https://sashiko.dev/#/patchset/20260417073610.3246316-1-binbin.wu%40linux.intel.com?part=24


> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index af87b803572c0..e6f0ecadc290b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
[ ... ]
> @@ -524,6 +534,11 @@ static int cpuid_check_and_set_vcpu_caps(struct kvm_vcpu *vcpu,
>  	u32 input, supported;
>  	u32 leaf;
>  
> +	if (vcpu->kvm->arch.is_cpuid_paranoid_mode &&
> +	    (entry->function & 0xFFFF0000) == KVM_CPUID_SIGNATURE &&
> +	    kvm_get_hypervisor_cpuid(vcpu, KVM_SIGNATURE).base != KVM_CPUID_SIGNATURE)
> +		return kvm_check_pv_cpuid_relocated(vcpu, entry);
Issue #1:

"Does this unintentionally bypass validation for the entire hypervisor CPUID
range (0x4000xxxx)?
The condition (entry->function & 0xFFFF0000) == KVM_CPUID_SIGNATURE broadly
matches the entire 0x4000xxxx range. If the KVM signature is omitted
(yielding base == 0) or relocated, the check evaluates to true. For non-TDX
guests with paranoid mode enabled, kvm_check_pv_cpuid_relocated() returns 0,
causing an early return that skips the rest of the verification.
Can a VMM bypass paranoid checks to inject arbitrary, unverified hypervisor
CPUID leaves by simply omitting or relocating the KVM signature?"

This is intentionally bypass validation for hypervisor CPUID range if KVM
base is relocated for non-TDX guests. It is marked as TODO in
kvm_check_pv_cpuid_relocated() since I don't have a simple way to do it.


Issue #2:

"Also, does calling kvm_get_hypervisor_cpuid() here introduce an expensive
O(N^3) loop?
This code executes dynamically per CPUID entry during KVM_SET_CPUID2.
kvm_get_hypervisor_cpuid() performs a linear scan over 256 possible bases,
and calls kvm_find_cpuid_entry(), which linearly scans up to 256 CPUID
entries again.
Could the KVM CPUID base address be resolved once prior to iterating through
all the entries?"

There should be no too many hypervisor CPUID leafs. But yes, the KVM CPUID
base address could be resolved once prior to the iterating.


