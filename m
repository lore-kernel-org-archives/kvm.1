Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C807E3D16EF;
	Thu,  3 Sep 2026 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422692; cv=none; b=D0y4NLH6nyW8c9Inw/gDSfOOVcxuYCr9Ko9AzZCieyF3EkCxWgWX3PC4HaI7cm0qx5NCwQp9XdpQe+t5cntPN0NqV59hpUgOfO1Hv2rKixHVNw/AOKXm4NAndD8rrnh1YRV1Ekd0FzgMWybzZAwaZlIkk0VEERDFyzsz/hwdJUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422692; c=relaxed/simple;
	bh=J0H1ntTGtYg44uznxXB+0iU3n5oks2/nKudUQvdbAt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PibWKu528x4USlOR0S6EI+FiWN9AW5AqLJKR+CenPGloAi/mTYZbl16ehiNYJkAJ0abfPXgm/CT6UjsRJxMqtYw941TeAhXDdwY7PbvCMhCuhBy56TC0mtMJFAArIL1853C/xjeayxBNN2hpwCf8IsJPZTtc2Uyi9oBVt1GobOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jT4yJ3h+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jT4yJ3h+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788422690; x=1819958690;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J0H1ntTGtYg44uznxXB+0iU3n5oks2/nKudUQvdbAt0=;
  b=jT4yJ3h+uf5JB+8hPIEG+k53fMjBgqwyGvtMtZNiaaNu2Q7l87qX2Mte
   8/4m6ie3p0FX+QyJkIpTv3l0ME9jyeWdhqIaU8BchQqPRpZDt6S2Aktf0
   agk8ogehGKQkyzAOdSDR7NRayJIrOT7buA2hhs5WxBBftj8htGDlWFF7F
   8bvpix9O6Yd/WKVH+//dBaBDRCqKXzfb0fN6eWSRio4civFURKFZ/F9AV
   6xpREUOyrKhF5MVd+S6VNuACgsTDSpj0JAemULTVQ8n5cEaMZqTN17xT5
   FORlnkkkjmeyEqqzaaxP9m7Es7CsgvIYVBNDUC3bryX0MeB82JOfZEA/u
   A==;
X-CSE-ConnectionGUID: Rj1V02FaQf+yXepIjphCsA==
X-CSE-MsgGUID: m/WtkAWLSgi8KzEpbPEfiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="87834644"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="87834644"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:04:49 -0700
X-CSE-ConnectionGUID: jsQ86n/NTfKqv/Ey7/z0CA==
X-CSE-MsgGUID: 9i/BnZhTSriwvUoyweDbYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="268319106"
Received: from unknown (HELO [10.238.208.122]) ([10.238.208.122])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:04:46 -0700
Message-ID: <96aaabba-678b-4dc9-bf96-a01c605dad04@intel.com>
Date: Thu, 3 Sep 2026 16:04:43 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] KVM: TDX: Filter configurable CPUID bits
To: Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
 rick.p.edgecombe@intel.com, chao.gao@intel.com
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-4-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260827031837.2863609-4-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/2026 11:18 AM, Binbin Wu wrote:
> Filter the directly configurable CPUID bits reported through
> KVM_TDX_CAPABILITIES against KVM's TDX allowlist, and drop the hardcoded
> denylist based filtering.
> 
> The TDX module reports all directly configurable CPUID bits that it
> supports for a TD, but KVM must not expose bits that it doesn't support,
> as blindly exposing a host state clobbering feature can lead to host state
> corruption.  The existing denylist, which clears only TSX and WAITPKG, is
> not fail-safe.
> 
> Add tdx_get_allowed_cfg_cpuid_mask() to get the mask of directly
> configurable bits allowed by KVM for a given CPUID register, covering both
> feature bits, which come from tdx_cpu_cfg_caps[], and non-feature bits,
> which are enumerated at runtime.  Apply the mask to every CPUID register
> reported through KVM_TDX_CAPABILITIES.
> 
> With the allowlist in place, newly introduced TDX directly configurable
> CPUID bits stay hidden from userspace until KVM explicitly opts in.
> 
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
> v3:
> - Handle non-feature leafs at runtime. (Sean)
> - Add CPUID.0x24.0.EBX[7:0] into allow list. There is a mismatch of the
>   description about CPUID.0x24.0.EBX[7:0], which is listed as
>   "XFAM & CPUID_Enabled & Native" but should be "XFAM & CPUID_Enabled &
>   Configured & Native".
> ---
>  arch/x86/kvm/vmx/tdx.c | 84 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 66 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index b020518717ac..e8951353de73 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -277,34 +277,76 @@ static bool has_tsx(const struct kvm_cpuid_entry2 *entry)
>  	       (entry->ebx & TDX_FEATURE_TSX);
>  }
>  
> -static void clear_tsx(struct kvm_cpuid_entry2 *entry)
> -{
> -	entry->ebx &= ~TDX_FEATURE_TSX;
> -}
> -
>  static bool has_waitpkg(const struct kvm_cpuid_entry2 *entry)
>  {
>  	return entry->function == 7 && entry->index == 0 &&
>  	       (entry->ecx & __feature_bit(X86_FEATURE_WAITPKG));
>  }
>  
> -static void clear_waitpkg(struct kvm_cpuid_entry2 *entry)
> +static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
>  {
> -	entry->ecx &= ~__feature_bit(X86_FEATURE_WAITPKG);
> +	return has_tsx(entry) || has_waitpkg(entry);
>  }
>  
> -static void tdx_clear_unsupported_cpuid(struct kvm_cpuid_entry2 *entry)
> +#define TDX_CPUID_ALL_ALLOWED_MASK	GENMASK_U32(31, 0)
> +
> +static u32 tdx_cfg_non_feature_mask(u32 function, u32 index, int reg)
>  {
> -	if (has_tsx(entry))
> -		clear_tsx(entry);
> +	/*
> +	 * For a leaf/subleaf/register that will never be repurposed to hold
> +	 * feature bits, it's safe to return TDX_CPUID_ALL_ALLOWED_MASK, i.e.
> +	 * leave the TDX module's CPUID config mask intact.
> +	 */

I don't think blindly return TDX_CPUID_ALL_ALLOWED_MASK, i.e. all-1s, is a
good idea. It's just like the current behavior that KVM doesn't gate
anything and allows userspace to set anything that is allowed by TDX
module. For example, ...

> +	switch (function) {
> +	case 1:
> +		if (reg == CPUID_EAX || reg == CPUID_EBX)
> +			return TDX_CPUID_ALL_ALLOWED_MASK;

... TDX module returns 0x0fff3fff for CPUID.1.EAX currently. If KVM makes
the mask as all-1s, then if in the future the reserved field [15:14] and
[31:28] are defined for new things and new TDX module starts to report them
as configurable, then the bits will be configurable by userspace on old
kernels while we don't know if its safe for KVM/kernel.

> +		return 0;
> +	case 4:
> +	case 0x18:
> +	case 0x1f:
> +		return TDX_CPUID_ALL_ALLOWED_MASK;
> +	case 0x24:
> +		if (index == 0 && reg == CPUID_EBX)
> +			return GENMASK_U32(7, 0);
> +		return 0;
> +	case 0x80000008:
> +		if (reg == CPUID_EAX)
> +			return TDX_CPUID_ALL_ALLOWED_MASK;
> +		return 0;
> +	default:
> +		return 0;
> +	}
> +}


