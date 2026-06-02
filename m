Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084C13AB272;
	Tue,  2 Jun 2026 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385418; cv=none; b=FHAxh/i+eH9NTAAQaj3lXU+Y2m6WUmduD/bc3V+IVI7Vt50/k263XQPLXpOb/57FrdaOhtz97lJkEmjjN40KPaZMb2DU6eoV171qKVhLvxsfikeLaysKEY7CrvE32Y/Bv1kuoG8XMPvRnln1rqPxgKztm/DNhM//Ar2USN0HPXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385418; c=relaxed/simple;
	bh=l1LYk6vyPIfWINa6ASNHl+VpTxNZ3jBu8hKdqcuemaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rx+B0FpCtwWJCBoj5UI6rQfrFUGL6CXIhbr61PYnOfDbUVQ+tL+v5/gzSkmxIEZU9ipvpi+m4PslFWOkjk6SNBYG08MzR4ulSUxatMIw88v+daYaFjM3rSrJscg2QGV28Rk05Km+77by/s96PCRHGgNr870gx72vXnAKRAKOFJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5PBk6BV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5PBk6BV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780385411; x=1811921411;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l1LYk6vyPIfWINa6ASNHl+VpTxNZ3jBu8hKdqcuemaQ=;
  b=Z5PBk6BVfGsFoPX9VX861sm/clEtMUnCHmeuSunUbL9BC6Vra+r72F2K
   KR/kCM0GrhmSI/0SyvbqdwglOe5eb33iXRdzPaIOoxJLR2mU1v10YZmR0
   Rx3MguRU2EB8j7CsWMiClXa/vDv0IL7wJrwS0sqxcO9yL1GyBvV85mKFx
   6y/qPaF+Q5QyEGdy4g1+x7xU0nA1KvlTv0lMfAjvzvMJDOueNHyEOMsy5
   EX/6GmJSNy0gUqtXQRS4oPa8jBevGBmy9C4GNnX4khbRAukklVgaxxXut
   Co4/J8jGcO9tpK3p+8/DhEP4WeO14v8d1C6iW6y3UnLfMtKXHn3A4Y4Uu
   g==;
X-CSE-ConnectionGUID: c8oclzuVTR6JaDRX68bn5g==
X-CSE-MsgGUID: /4AMdvK6Tje9DiFyRVnojA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81344925"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="81344925"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:30:10 -0700
X-CSE-ConnectionGUID: y13MoXy0S6SGXxQKP/G/8A==
X-CSE-MsgGUID: ROdxTAZCQ2K9Mh8u0BV6CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="242799324"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:30:07 -0700
Message-ID: <8890aa54-b119-4040-a508-e71706405ae2@linux.intel.com>
Date: Tue, 2 Jun 2026 15:30:04 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID
 feature
To: Ewan Hai <ewandevelop@gmail.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, tonywwang@zhaoxin.com
References: <20260528032234.1322565-1-ewandevelop@gmail.com>
 <20260528032234.1322565-3-ewandevelop@gmail.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260528032234.1322565-3-ewandevelop@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/2026 11:22 AM, Ewan Hai wrote:
> Advertise the Zhaoxin CCS (Chinese Cryptography Standard) feature to
> guests via CPUID 0xC0000001 EDX bits 4 (CCS) and 5 (CCS_EN). CCS groups
> two user-mode instructions for Chinese national cryptographic
         ^
Nit: 
It's supposed to be replaced?

> primitives, documented in the Zhaoxin GMI Instruction Set Reference,
> chapter 2 ("CCS instruction group"):
> 
>   - SM3 (encoding F3 0F A6 E8, subsection 2.1) implements the SM3 hash
>     algorithm specified in GM/T 0004-2012. It supports two modes
>     selected by RAX: auto-padding stream mode (RAX=0) and pre-padded
>     block mode (RAX=-1).
> 
>   - SM4 (encoding F3 0F A7 F0, subsection 2.2) implements the SM4 block
>     cipher specified in GM/T 0002-2012, supporting ECB / CBC / CFB /
>     OFB / CTR modes via a control word in RAX, and CBC-MAC / CFB-MAC
>     when RAX bit[11] is set.
> 
> Both instructions are unprivileged (no CPL restriction) and available
> in all CPU modes, with no associated MSR control. The CCS and CCS_EN
> bits are redundant by hardware design (set or cleared together) and
> both serve purely as CPUID-level feature-presence reporting flags
> requiring no KVM emulation. Both bits are advertised because different
> software may probe either one when checking for CCS availability.
> 
> Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 2 ++
>  arch/x86/kvm/cpuid.c               | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 20b33413189c..276e4ef90bd0 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -140,6 +140,8 @@
>  #define X86_FEATURE_SM2_EN		( 5*32+ 1) /* "sm2_en" SM2 enabled */
>  #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) */
>  #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */
> +#define X86_FEATURE_CCS			( 5*32+ 4) /* "ccs" SM3 + SM4 instructions */
> +#define X86_FEATURE_CCS_EN		( 5*32+ 5) /* "ccs_en" CCS enabled */
>  #define X86_FEATURE_XCRYPT		( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt) */
>  #define X86_FEATURE_XCRYPT_EN		( 5*32+ 7) /* "ace_en" on-CPU crypto enabled */
>  #define X86_FEATURE_ACE2		( 5*32+ 8) /* "ace2" Advanced Cryptography Engine v2 */
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 1eb4b88aaa80..8aaa3f20670e 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1276,6 +1276,8 @@ void kvm_initialize_cpu_caps(void)
>  		F(SM2_EN),
>  		F(XSTORE),
>  		F(XSTORE_EN),
> +		F(CCS),
> +		F(CCS_EN),
>  		F(XCRYPT),
>  		F(XCRYPT_EN),
>  		F(ACE2),

