Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB0737D123;
	Wed, 13 May 2026 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668569; cv=none; b=a2aTzv/n+npHBqm5zNYu3Fd2Qhp6ptAOLSzvZMpCmH02sb4TEnrW5hxzPobfEJ62WmkFGoP9ryh6XxXhTx9C+QrorUX8lLIf7M89K4K3uSgMA7YJXmP+Al2XBD9KHL6pwlPyJafgqnpxEo7QgpQnAKM3isokvn0MiFPego00J3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668569; c=relaxed/simple;
	bh=TEeo/lpIlI1AaVXaoiQR2jNUHttRsSeZ2U0qxL5WFzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDxFqKw4B5U9KbmvyjQn8hqHFKel6aPYgyK8iqHVNRI0XcFN4RIh0Cp+7+Bzw52nmF2ByBjoHUDAe0wVPdXBN4k5xnGNLf8Yg66aTUbsRIjTS+WAlpLVa0Ae89ful/XCLZxdKWKrSGTQGGHiPpHYxUhlZ5M0F5Z+7pMkRa/u5P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODK6O/jq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODK6O/jq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778668568; x=1810204568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TEeo/lpIlI1AaVXaoiQR2jNUHttRsSeZ2U0qxL5WFzA=;
  b=ODK6O/jqEg8UHq4u/8zDcDYFbSItIAYu5EZubsnO5kB8PV9GE+l+Wi/s
   Oz6we5vlskB+rUaKjB/T3AekLg2kToZWM5/hFtUZrTQiHUFnr97VxRNhZ
   rh3EOwrQCtV/jnjEwM1BJc7tsEoAl6XpKQLIcqz794Xh0NFl5mkS72tIY
   HsJ1EhPeerc/ArPqorz92+YNWt1gcUYnJJeEzm4kUzTqsRFBg4D1zT5yF
   M5YZVD1mi3v10ey1ljqZgJ88CA/WRo5nClUasyzyKIZQesKDISqjouN7t
   FyXGxm+xrisrMvJgx77U0c5YZNJXUM6dVjBNLP/GeJwRmM7mkwh8JSZU+
   Q==;
X-CSE-ConnectionGUID: 8mvVvHgkTkOO/OKJuB9fcg==
X-CSE-MsgGUID: FzYfGNQ8T1O6ZnUyyyklpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83463953"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="83463953"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 03:36:07 -0700
X-CSE-ConnectionGUID: m3QBzEjfRR2877nCaBHBFQ==
X-CSE-MsgGUID: 42R+6qXdRReOzVjO/JStHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="233597605"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 03:36:04 -0700
Message-ID: <2e73a7c5-82db-463f-9665-94280402913a@linux.intel.com>
Date: Wed, 13 May 2026 18:36:01 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
To: Ewan Hai <ewandevelop@gmail.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 cobechen@zhaoxin.com, tonywwang@zhaoxin.com
References: <20260513093633.1608334-1-ewandevelop@gmail.com>
 <20260513093633.1608334-2-ewandevelop@gmail.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260513093633.1608334-2-ewandevelop@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/2026 5:36 PM, Ewan Hai wrote:
> Advertise the Zhaoxin SM2 instruction support to guests via CPUID
> 0xC0000001 EDX bits 0 (SM2) and 1 (SM2_EN).
> 
> The SM2 instruction (encoding F2 0F A6 C0) implements the SM2
> elliptic-curve public-key cryptography algorithm specified in
> GM/T 0003-2012; the hardware-level behavior is documented in the
> Zhaoxin GMI Instruction Set Reference, chapter 1 ("SM2"). The
> instruction multiplexes its sub-functions on the RDX[5:0] control
> word: encryption (subsection 1.1), decryption (1.2), signing (1.3),
> signature verification (1.4), the three key-exchange sub-operations
> of section 1.5 (1.5.1 SM2 key-pair generation, which the spec also
> uses for the initiator's ephemeral key; 1.5.2 responder shared-key
> derivation; 1.5.3 initiator shared-key derivation), and two
> preprocess steps for identity and message hashing (1.6.1 and 1.6.2).
> 
> The instruction is user-mode and available in all CPU modes, with no
> associated MSR control. The SM2 and SM2_EN bits are redundant by
> hardware design (set or cleared together) and both serve purely as
> CPUID-level feature-presence reporting flags requiring no KVM
> emulation. Both bits are advertised because different software may
> probe either one when checking for SM2 availability.
> 
> Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
> ---
>  arch/x86/kvm/cpuid.c         | 2 ++
>  arch/x86/kvm/reverse_cpuid.h | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index e69156b54cff..1eb4b88aaa80 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1272,6 +1272,8 @@ void kvm_initialize_cpu_caps(void)
>  		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
>  
>  	kvm_cpu_cap_init(CPUID_C000_0001_EDX,
> +		F(SM2),
> +		F(SM2_EN),
>  		F(XSTORE),
>  		F(XSTORE_EN),
>  		F(XCRYPT),
> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
> index 657f5f743ed9..7b55110cc046 100644
> --- a/arch/x86/kvm/reverse_cpuid.h
> +++ b/arch/x86/kvm/reverse_cpuid.h
> @@ -76,6 +76,10 @@
>  #define KVM_X86_FEATURE_TSA_SQ_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 1)
>  #define KVM_X86_FEATURE_TSA_L1_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 2)
>  
> +/* Zhaoxin/Centaur sub-features, CPUID level 0xC0000001 (EDX) */
> +#define X86_FEATURE_SM2			KVM_X86_FEATURE(CPUID_C000_0001_EDX, 0)
> +#define X86_FEATURE_SM2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 1)

Are these new bits really KVM-only feature bits?

KVM_X86_FEATURE() is used for the features either scattered by cpufeatures.h
or features that are 100% KVM-only.

Kernel already has a feature word CPUID_C000_0001_EDX defined for
CPUID 0xC0000001 (EDX). I think these new feature bits should be put together
with the existing ones (i.e. X86_FEATURE_XSTORE, ..., X86_FEATURE_PMM_EN) in
cpufeatures.h.

Same for the other patches.


> +
>  struct cpuid_reg {
>  	u32 function;
>  	u32 index;

