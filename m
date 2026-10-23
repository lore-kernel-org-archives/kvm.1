Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792724725;
	b=DWYyCeeQcV/f4zgQn/PXf0BodUgjAury2tFpw6XA3WMjaohUh54MWiXNR4IUGMVyR+3V
	 xTv35GHAAYQPfpsV2edGY6zC/il+Ttv2nOAgmbV3QZ6kIKw6rTyITrRhPKL1rSV+8kHzG
	 fi5XzZFHCRtxfY0ZMiZDpL8tOukWCD9KCJP8zwNUwofAtraqhUg8xJzGJm91ELzPDxCEz
	 VbzC+y02WX2QfziuRBP9ubueCjOxdtXc/yFVJgcOk1p0RiHGdZGr0Fhn85/uwcQ6Z0EHK
	 wNgWkKNGCdX9YCw+00nf1yuAhj/wSNZjy/ur/P+pEplnHs1n/LGWUdv+jVnoKEDpfWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792724725;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dhMnfcK1OZCkXS3jlKG9FO2BzWzDeHFEAl52uVGMzYQ=;
	b=WJaMFYEN1GnvJlzN1TFVMbqW/vFw6lePSKgXL1iNUKWanXQJ9V2u9HwI3Qfe69ipkHH4
	 BeAQVPLA20mlocWM7weT3Fi0xwEhrLWqAJCXvhY07fwYaBPpKYWKQg/I/0PCf1bIPuXi6
	 FHmKDpUUeN0H+M8qhKUgURd/gC9BQisdYY8Gsffeo4SnMHddSmik+TAp3VZqgQ2gxjHf3
	 P1pL9NAl6CmPA8Bkv5WHJBrTVcf9cL2KBBxIlTSJbNOeXKP6f1H0RmTN5Uy7io/OQzdY7
	 SoUQj5lo861/9Y0pYKKDoNDnX1xxbdCCwJ0ayEobTTee1KYI4DFhbWe41p/GJTYTCRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hfrTCGXX;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825FF606A31A;
	Fri, 23 Oct 2026 03:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 825FF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hfrTCGXX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792724725; x=1824260725;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m6kBOfHooZ1cfrqoSGRtQrUdWdak3kJ0IQfEZasphkQ=;
  b=hfrTCGXXO4qALU3MDtZeOD8Gckjslq4PUCeweGPEh3941FD8SiBH+ig2
   w5RcqRLMh5OoZtQmujnVDHeOJ+8XWAwqZu99zlBImpXP3t70olDKDQHSK
   h/+GXwOn6VbZTj/Ih2lvPDSwrGBzzlxk5b++ExvVhtROIxobV0EGo8lqU
   bz0iZzi1QgW6/XHq6iWn6dy3P/5LkxKzVmkghwnwhNj7w7VAC8oTZGFYA
   1aFJFdFcmoAXn529uvSfxMX5Ba7WlvPtWkwHCfI+Aa7/0kQMWPyVxRaaz
   faO0O79XK1uRbvf4oW7yXVMr29nE7VPfbDo8XONPs5B41e8xiw6I1/UFq
   Q==;
X-CSE-ConnectionGUID: 2jeqCt5wQqaUumTlCwDtIg==
X-CSE-MsgGUID: BK+hi7ExSqmdarmRl6DrYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1486351"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1486351"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 20:05:24 -0700
X-CSE-ConnectionGUID: VwG2/CpzQjGR2tAV6iiDaA==
X-CSE-MsgGUID: myojr/oLQWupJT3IFQPovg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3403331"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 20:05:21 -0700
Message-ID: <88de514b-8f83-4b04-82c8-caa6bd5ac976@linux.intel.com>
Date: Fri, 23 Oct 2026 11:05:16 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] KVM: TDX: Reject KVM_TDX_INIT_VM if indexed CPUID
 functions don't match
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, Changyuan Lyu <changyuanl@google.com>,
 Sashiko <sashiko-bot@kernel.org>
References: <20261022210134.612848-1-seanjc@google.com>
 <20261022210134.612848-4-seanjc@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20261022210134.612848-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/2026 5:01 AM, Sean Christopherson wrote:
> Reject KVM_TDX_INIT_VM if userspace doesn't configure the canonical CPUID
> entries correctly with respect to KVM_CPUID_FLAG_SIGNIFCANT_INDEX to fix a
> bug where userspace could bypass the TSX and WAITPKG checks by simply not
> marking a CPUID.0x7 entry as being indexed.  This also sets the stage for
> more in-depth validation of the incoming CPUID configuration.
> 
> This is obviously an ABI change and diverges from KVM's general approach of
> "let userspace do what it wants".  In practice, no "real" VMM that supports
> TDX misconfigures a TD's CPUID entries in this way, i.e. the probability of
> actually breaking userspace is basically nil.  And unlike normal VMs, where
> KVM has full control and thus can deal with bizarre CPUID input without too
> much fuss, TDX VMs require extra care due to the TDX Module also reacting
> to the CPUID configuration, i.e. KVM_TDX_INIT_VM needs to be more strict
> than KVM_SET_CPUID{,2} to avoid creating potentially dangerous-to-the-host
> setups.
> 
> Opportunistically rename the helper to make it more obvious that it's
> checking if the passed in @entry is unsupported, as opposed to returning a
> set of unsupported entries or something.
> 
> Fixes: 6d415778f106 ("KVM: TDX: Disable support for TSX and WAITPKG")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/kvm/20260604024927.E22311F00893@smtp.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/tdx.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 37d088f6f7a8..6abf92ffec24 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -151,8 +151,12 @@ static void tdx_clear_unsupported_cpuid(struct kvm_cpuid_entry2 *entry)
>  		clear_waitpkg(entry);
>  }
>  
> -static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
> +static bool tdx_is_unsupported_cpuid_entry(const struct kvm_cpuid_entry2 *entry)
>  {
> +	if (cpuid_function_is_indexed(entry->function) !=
> +	    !!(entry->flags & KVM_CPUID_FLAG_SIGNIFCANT_INDEX))
> +		return true;

Similar to patch 2, if cpuid_function_is_indexed(entry->function) misses some function,
the value of cpuid_function_is_indexed(entry->function) is not accurate.

For current code, it's OK, since all unsupported bits are in leaf 7.
In the future, with the TDX CPUID validation patch set
https://lore.kernel.org/all/20261016091422.3182216-6-binbin.wu@linux.intel.com/
It still allow userspace to by pass some check in theory.
> +
>  	return has_tsx(entry) || has_waitpkg(entry);
>  }
>  
> @@ -2393,7 +2397,7 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
>  		if (!entry)
>  			continue;
>  
> -		if (tdx_unsupported_cpuid(entry))
> +		if (tdx_is_unsupported_cpuid_entry(entry))
>  			return -EINVAL;
>  
>  		copy_cnt++;

