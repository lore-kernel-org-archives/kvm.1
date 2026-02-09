Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA82324B35;
	Mon,  9 Feb 2026 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770631405; cv=none; b=EzCfY3dOsSv93zep8JVrdHE44S6VTg3S6U/VUL1l9XvH0Qy3mc58DAjzkRAdSUzeQ/D6+cT5htSHKXoX8JjGDTY0Ua622SgQ55ZWkFQJUjlh4XmBZOKRb6WdNvrNIqshJgSHFIaVeFw8OmjU0qDnDPixuHQkuCR4uEA1B7SQ7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770631405; c=relaxed/simple;
	bh=lxSkJSP1K/mVh6ZPoAz1ZXdfGuhrsRieaQPVkq9qGbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioS+mlIlcqACXa8FgF/J421jXjBBPcDPldPCrVIcDha408iHJvnIardbaV2XlrgMGZijcUleycMm7CebCBHnSK2xLj4l7h803lhVLIgxdO2KPAEbIZSEUoPZZKP6d5Om0tfwfMu6GiuYx9Utq45pH8I1bo8Klb0xZlGyeatIvec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTisszjz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTisszjz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770631405; x=1802167405;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lxSkJSP1K/mVh6ZPoAz1ZXdfGuhrsRieaQPVkq9qGbg=;
  b=WTisszjzciV/bM+d74Z1xqLuMbMJhnC6A81pu8BtNxsAvg+wukv/4ih4
   eN/NTTW9PJtRGpsl96F+RFj1y05YBJ8omPW9zix5Xyv65vPgLUG4+mFU7
   QeHBcp6VEgWwtPQn7050+/YtYhhwPnFjVTsyKpCBiFI5XS1nzyOS+HjON
   znIe32Rh516L2NeeF7RDZK8ftKuctT0D39lcm/K1+S31sDFBRoKwSQ27t
   7GcjyT/W4mcAFB3BMnBVjGL83JK20m8SAkmvpNAMh34cr/T/ixlBKvtOK
   PQ+0JnVLTh8Vcuw5sPz+n6vrZPocHsHcO89T7jICvW1NDXvEVMcB6CQd9
   w==;
X-CSE-ConnectionGUID: ctuc9/blQ/qjpI7Eu5UT/g==
X-CSE-MsgGUID: vh9LpRD5Tz2S2M18o7WOmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83111057"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="83111057"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 02:03:24 -0800
X-CSE-ConnectionGUID: Sgl0g87tTYqKhHSinGpClQ==
X-CSE-MsgGUID: +1zI4a6nSuiIfDIJFlZ1iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="210729044"
Received: from unknown (HELO [10.238.1.231]) ([10.238.1.231])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 02:02:59 -0800
Message-ID: <3afa5004-412a-4ab8-b0b9-46bd3982438d@linux.intel.com>
Date: Mon, 9 Feb 2026 18:02:56 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: synthesize TSA CPUID bits via SCATTERED_F()
To: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, seanjc@google.com
Cc: bp@alien8.de, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
References: <20260208164233.30405-1-clopez@suse.de>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260208164233.30405-1-clopez@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/9/2026 12:42 AM, Carlos López wrote:
> KVM incorrectly synthesizes TSA_SQ_NO and TSA_L1_NO when running
> on AMD Family 19h CPUs by using SYNTHESIZED_F(), which unconditionally
> enables features for KVM-only CPUID leaves (as is the case with
> CPUID_8000_0021_ECX), regardless of the kernel's synthesis logic in
> tsa_init(). This is due to the following logic in kvm_cpu_cap_init():
> 
>     if (leaf < NCAPINTS)
>         kvm_cpu_caps[leaf] &= kernel_cpu_caps[leaf];

Since TSA_SQ_NO and TSA_L1_NO are defined in CPUID_8000_0021_ECX, and
CPUID_8000_0021_ECX > NCAPINTS, the code above doesn't take effect.

The code makes the two bits set unconditionally is:
    SYNTHESIZED_F() sets kvm_cpu_cap_synthesized
and later
    kvm_cpu_caps[leaf] &= (raw_cpuid_get(cpuid) |
                           kvm_cpu_cap_synthesized);

> 
> This can cause an unexpected failure on Family 19h CPUs during SEV-SNP
> guest setup, when userspace issues SNP_LAUNCH_UPDATE, as setting these
> bits in the CPUID page on vulnerable CPUs is explicitly rejected by SNP
> firmware.
> 
> Switch to SCATTERED_F(), so that the bits are only set if the features
> have been force-set by the kernel in tsa_init(), or if they are reported
> in the raw CPUID.

When you switch to SCATTERED_F(), if the two bits are not in raw cpuid, the two
bits will not be set to kvm_cpu_caps[CPUID_8000_0021_ECX], regardless the
setting initialized in tsa_init().

TSA_SQ_NO and TSA_L1_NO are conditional kernel synthesis bits, should
SYNTHESIZED_F() check that the related bit is actually synthesized into
boot_cpu_data before setting to kvm_cpu_cap_synthesized?

> 
> Fixes: 31272abd5974 ("KVM: SVM: Advertise TSA CPUID bits to guests")
> Signed-off-by: Carlos López <clopez@suse.de>
> ---
>  arch/x86/kvm/cpuid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 88a5426674a1..819c176e02ff 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1230,8 +1230,8 @@ void kvm_set_cpu_caps(void)
>  	);
>  
>  	kvm_cpu_cap_init(CPUID_8000_0021_ECX,
> -		SYNTHESIZED_F(TSA_SQ_NO),
> -		SYNTHESIZED_F(TSA_L1_NO),
> +		SCATTERED_F(TSA_SQ_NO),
> +		SCATTERED_F(TSA_L1_NO),
>  	);
>  
>  	kvm_cpu_cap_init(CPUID_8000_0022_EAX,
> 
> base-commit: 0de4a0eec25b9171f2a2abb1a820e125e6797770

