Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4458E3B6370;
	Tue,  2 Jun 2026 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385536; cv=none; b=NIwoSV0w0UhGBmGkpWZleEsT1yNZUuhOz9Yb8WPKDmK6xmTnV6eTBT5FzAdjDcvi/4PXZWK+NgYQKGKRpJGPuyJu7KsyDmKt/CoESpl6JEiMTGl7UcYHad+MRfPjZObPvtBQdYzNq4sP21P7ZQREYdjMXOI52lpBZkLnvHskrdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385536; c=relaxed/simple;
	bh=xWAu3VVZ72RMZzr5o5pGY+pdroKJLRXdqU8zwBhv+1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUh7NetGGDT9ouYrc8OfcMhyLu/yRhWcPfxV7inDd/w8SDX68pkA1pYDzzpiMCkfb0yQAW7S0FdU9Y6pZMrJLzqyHoUr4KOO18mhjXGesXpllnCYc7S363tgujuGKfG6qVHFWTEHRr2aX/SoqnHkVra39R01BqrO37oOl5R/3og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdrIvs9E; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdrIvs9E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780385531; x=1811921531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xWAu3VVZ72RMZzr5o5pGY+pdroKJLRXdqU8zwBhv+1Q=;
  b=PdrIvs9Efe1cv2g9vSU1OPHi2k4mktgt3fcbYdPjierv+4wRgrlf1V0f
   Yhnq+034VmKp2aCQNHcDxE0q3r1Br5+vSFA1x6AUNrJkc4s2kKe8HNebd
   Dkgcchzb2sC4uinUGAXddBoV5Dz2av2SCwrqfcrjiLQ4xC+LJtFrDv1MP
   LpG60RBUaAgaVDApuVsSesFQ0Pky/o0jIQR4xQ4f9TCSz9cp9njQWD9x6
   aDzXtuSbhMb4BWtAPXr1ZJD84jq0+K3SnEeTh2vcs0QO0SRtTivppNXI0
   c18orxavRC4jxu5AMFAUua191rGIQyWzxR4MOJUUHb358Asdll9c4vYhM
   g==;
X-CSE-ConnectionGUID: f831lnMCT2qvuUD8exofCQ==
X-CSE-MsgGUID: 0DBZw6CVROygmQK7XFIksA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81345100"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="81345100"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:32:10 -0700
X-CSE-ConnectionGUID: 7tb4JF13T8aQOuTUoG6CIQ==
X-CSE-MsgGUID: 7KGoIrU7Sp+o8mgG0yt5UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="242799706"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:32:07 -0700
Message-ID: <ea026e65-007f-4218-bf37-8ec002626d2f@linux.intel.com>
Date: Tue, 2 Jun 2026 15:32:05 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX
 cryptographic features
To: Ewan Hai <ewandevelop@gmail.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, tonywwang@zhaoxin.com
References: <20260528032234.1322565-1-ewandevelop@gmail.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260528032234.1322565-1-ewandevelop@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/2026 11:22 AM, Ewan Hai wrote:
> This series exposes five groups of Zhaoxin-specific CPUID 0xC0000001 EDX
> feature bits to KVM guests. Each group corresponds to a category of
> unprivileged cryptographic or RNG instructions that have been present in
> Zhaoxin processors but not yet advertised by KVM.
> 
> All instructions covered here are unprivileged (no CPL restriction) and
> available in all CPU modes (real / V86 / compat / protected / long), with
> no associated MSR control. Each feature is reported as a (X, X_EN) pair
> where the two bits are redundant by hardware design (set or cleared
> together), and both are CPUID-level reporting bits requiring no KVM
> emulation.
> 
> The five feature groups:
> 
> 1. SM2 (bits 0, 1): SM2 elliptic-curve public-key cryptography algorithm
>    per GM/T 0003-2012. Used for key generation, encryption/decryption,
>    digital signatures, and key exchange in Chinese cryptographic
>    standards.
> 
> 2. CCS (bits 4, 5): SM3 hash algorithm per GM/T 0004-2012 and SM4 block
>    cipher per GM/T 0002-2012 (supports ECB / CBC / CFB / OFB / CTR plus
>    CBC-MAC / CFB-MAC). Foundational primitives for Chinese cryptographic
>    protocols.
> 
> 3. RNG2 (bits 22, 23): Second-generation hardware RNG exposed via the
>    REP XRNG2 instruction. Two on-die RNG sources selectable per call,
>    with raw and post-processed output modes. Provides high-quality
>    entropy for cryptographic operations.
> 
> 4. PHE2 (bits 25, 26): SHA-384 and SHA-512 hardware acceleration per
>    FIPS 180-3, exposed via REP XSHA384 and REP XSHA512. Used by TLS,
>    SSH, file integrity, and signature schemes.
> 
> 5. RSA (bits 27, 28): Big-number modular exponentiation (REP XMODEXP,
>    A^B mod M) and modular multiplication (REP MONTMUL2, A*B mod M),
>    supporting operand sizes from 256 to 32768 bits. Used for RSA and
>    related public-key operations.
> 
> References:
>   The instruction encodings, control-word formats, and per-feature
>   semantics referenced in the individual patches are documented in:
>     - GMI Instruction Set Reference (SM2 / SM3 / SM4)
>     - PadLock Instruction Reference (XRNG2 / XSHA384 / XSHA512 /
>       XMODEXP / MONTMUL2)
>   Both available from https://kib.kiev.ua/x86docs/Zhaoxin/
> 
> Changes since v1:
> - Move the X86_FEATURE_xx definitions from arch/x86/kvm/reverse_cpuid.h
>   into arch/x86/include/asm/cpufeatures.h, filling the unused bit
>   positions in word 5 (which is reserved for CPUID 0xC0000001 EDX),
>   per Sean's review feedback.
> - Tighten wording in each commit message: "user-mode" -> "unprivileged
>   (no CPL restriction)", since the instructions execute at any CPL.
> 
> v1: https://lore.kernel.org/all/20260513124846.1622462-1-ewandevelop@gmail.com/
> 
> Ewan Hai (5):
>   KVM: x86: Expose Zhaoxin SM2 CPUID feature
>   KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
>   KVM: x86: Expose Zhaoxin RNG2 CPUID feature
>   KVM: x86: Expose Zhaoxin PHE2 CPUID feature
>   KVM: x86: Expose Zhaoxin RSA CPUID feature
> 
>  arch/x86/include/asm/cpufeatures.h | 10 ++++++++++
>  arch/x86/kvm/cpuid.c               | 10 ++++++++++
>  2 files changed, 20 insertions(+)

Two nits in patch 2 and patch 4.

Otherwise,
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> 
> 
> base-commit: 50897c955902c93ae71c38698abb910525ebdc89
> --
> 2.34.1
> 

