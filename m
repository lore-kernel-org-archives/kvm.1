Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F83A6B76;
	Tue,  2 Jun 2026 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385399; cv=none; b=XuKdrT3bQLfK7dDFKj8bXOJMUKXHDMTskzU9B/OmcuEnvwWl+casfck1uiKoVwaAFRNwIS4C7upq3a5ikkJm72V2nolGwcr3tiXXMyxEruMsfYDuuSgrHWsjZP3Ekt7oT3jbLAtzeUs4mT4ERclF8afhdVOKqVg8m0JTS3EsKL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385399; c=relaxed/simple;
	bh=JZNBRPPyX2qt0TJya4MKKs4bh2zt3azxqxZdOZ3RXm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqknVQeb3LF9BiTrPyH98vGGSsMPBQuVR5GWjVv16K9bKacAG46TOiadWpLAHOYUKDXDFp/1Vf6QSPpcsM1eblby7XkQmx5SaZJjQ+I08e8JCCjRlTJTkiNklUn9z506XuPeLjztHlXoOZ5/K1mAs5VqpUWH578All9WXqxeeEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9OUcfSx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9OUcfSx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780385397; x=1811921397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JZNBRPPyX2qt0TJya4MKKs4bh2zt3azxqxZdOZ3RXm0=;
  b=T9OUcfSxwbVFEiaIKnTlP6bAYfdayxOvsSOIlUOJIHtLqU9TgM1te2Jp
   8mZh6fDvpeww470uh93Wpi+e/KUpXC99uzA0g0ic4MkHRSk9upGcp7U+2
   YkAWqfYznb9YqQFNaz4uoCnzMDUpz17UmFD7l3KZL4kiJM3tkmQp5nil4
   VRVAE8reryH4x3E42I0XEf0fp9yiXD/IlLQzr0DZV7Gw+Z0Md3z5vH/HJ
   O3hvhCvdw3j25wmEuA8nxW87iXMZMY1zuOvjP+0qseOJkp2v3ejhls51k
   +qqRG6H+ryR3Kns9VTFtwxCkhpyrpnJrRnb7eXHvWOwVUcv6kdmhN+Tyi
   Q==;
X-CSE-ConnectionGUID: 5lGv+LplSPulntLViaIziA==
X-CSE-MsgGUID: 0WGbMqYjSN25JOqo+eJQaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81344904"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="81344904"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:29:56 -0700
X-CSE-ConnectionGUID: Ixeeo6B2TTitt/SOgetOHg==
X-CSE-MsgGUID: BKL+rHD7QEmzb17gBHFu6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="242799106"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:29:52 -0700
Message-ID: <afd9979a-4036-499e-9ec1-b30ec30dafec@linux.intel.com>
Date: Tue, 2 Jun 2026 15:29:50 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] KVM: x86: Expose Zhaoxin PHE2 CPUID feature
To: Ewan Hai <ewandevelop@gmail.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, tonywwang@zhaoxin.com
References: <20260528032234.1322565-1-ewandevelop@gmail.com>
 <20260528032234.1322565-5-ewandevelop@gmail.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260528032234.1322565-5-ewandevelop@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/2026 11:22 AM, Ewan Hai wrote:
> Advertise the Zhaoxin PadLock Hash Engine v2 to guests via CPUID
> 0xC0000001 EDX bits 25 (PHE2) and 26 (PHE2_EN). PHE2 extends the
> PadLock hash family with SHA-384 and SHA-512 support per FIPS 180-3,
> complementing the existing PHE feature (SHA-1 and SHA-256).
> 
> Two user-mode instructions are exposed, documented in the Zhaoxin
         ^
Nit: 
It's supposed to be replaced?

> PadLock Instruction Reference, chapter 3 ("Hash Engine"):
> 
>   - REP XSHA384 (encoding F3 0F A6 D8, subsection 3.3)
>   - REP XSHA512 (encoding F3 0F A6 E0, subsection 3.4)
> 
> Both consume software-padded 128-byte blocks (RCX = block count, RSI =
> input, RDI = state) and produce hash output in the state buffer.
> 
> Both instructions are unprivileged (no CPL restriction) and available
> in all CPU modes, with no associated MSR control. The PHE2 and PHE2_EN
> bits are redundant by hardware design (set or cleared together) and
> both serve purely as CPUID-level feature-presence reporting flags
> requiring no KVM emulation. Both bits are advertised because different
> software may probe either one when checking for PHE2 availability.
> 
> Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 2 ++
>  arch/x86/kvm/cpuid.c               | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index e264758d58e2..3702d7a30ae6 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -152,6 +152,8 @@
>  #define X86_FEATURE_PMM_EN		( 5*32+13) /* "pmm_en" PMM enabled */
>  #define X86_FEATURE_RNG2		( 5*32+22) /* "rng2" RNG v2 */
>  #define X86_FEATURE_RNG2_EN		( 5*32+23) /* "rng2_en" RNG2 enabled */
> +#define X86_FEATURE_PHE2		( 5*32+25) /* "phe2" PadLock Hash Engine v2 */
> +#define X86_FEATURE_PHE2_EN		( 5*32+26) /* "phe2_en" PHE2 enabled */
>  
>  /* More extended AMD flags: CPUID level 0x80000001, ECX, word 6 */
>  #define X86_FEATURE_LAHF_LM		( 6*32+ 0) /* "lahf_lm" LAHF/SAHF in long mode */
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 087c41341240..3fb81f7a6107 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1288,6 +1288,8 @@ void kvm_initialize_cpu_caps(void)
>  		F(PMM_EN),
>  		F(RNG2),
>  		F(RNG2_EN),
> +		F(PHE2),
> +		F(PHE2_EN),
>  	);
>  
>  	/*

