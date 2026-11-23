Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450938;
	b=a7PTI4N0erVpnkguNyR40RPbYh/7iQz29xqgAK+PywkyG9IKxydrCR5G7C8+9gGvSF0p
	 yRuC5j+Lan5RnCnHxF7XdnTF8hJeANt0+3s5APv40nEWAo/59sbQOmvhQfp3ReOW9z2SB
	 hp0rcQ3pT/ZI0NQDwg7AJHHY//rYnIpceJ34SB33n7fMvMZHS2dbm5m1iCjqcdrF1NHWM
	 UGuzrGS4/FouQVvbQeGUzBkKjLNBMJWcZTGoQXSDD2kdWJ7zVT9I6VHH3Fu+ZyabTzJZu
	 5kyc0Ghpgth+guJwuv99M99eMtD5k9TOfsv7bGWldV21/tg4OTDeHwcZQG3OaUgbjVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450938;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=RdLhN1eamxExbJbu4/qSOIa6yaHLlfsGuRxVn4aEuWE=;
	b=2+tQXYCbyHMq6r5lBSjQeTAIFkljz4Y0rhNKIx1NITI7GG+8L/SI7rzeJyuWZFMgcp3N
	 iTpKn8sVg+lHRB7TPKzYb5Rs0Z/q1vnuqZVDPuEjlrb5xa/dFhJspF+VtlQ6T6+95nke9
	 oTkNWSn0/7C/+7VrfgmhSrQWoJQ2ou9sE5m2pOxuaDgBSLMWQ+CdnR6r+9iH7m8hcDHnR
	 TASUeTGrGc860eMdS9nF4kykSr0Jl9T+bM9EwfuyzJmn/TImeFgBWlKGm6MfZEMWIIN1j
	 sPZmdaQAnj5TDB2gaGg08yIH6DZU1uC2XG896YZ8SD6+JLUATMXZ0Y/X8DJhhvXTzHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EfRJwHy2;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC725606A31E;
	Mon, 23 Nov 2026 16:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC725606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EfRJwHy2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795450938; x=1826986938;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vspBMUKIIx/bsZpecXncoJt88TctB/FDsjpVOqsp2dY=;
  b=EfRJwHy22XWeFFk5AECIpIugc87MWaqt86KwdWI/boj3VrzkSU9MhTkk
   fXRP8/02RDWi0K1bLraIu/NVsV/tc/OZsgDTR+vB1JGWGT0L9VjDhrxf3
   X2S6wA/DNUsJXHUdwt55hKtw6LaXvUkEG962MVkUdusr7OPUj7/57bPyo
   Kw6UnPDva2pEqp58rpU9HYy46WpDWU+sWuiv1d6ENJGsHAh3aHmT8lL/g
   3QD6GK9+f8Ov7O7TO3B8wBH6Csw57hmGbQ32vkeDLU4yZzTW5UyyZ+tbq
   CkEaYJyvhI9dojYf5h7I9dBx6mtlm//V8OmYE8irzTdJGd8W6a/9da1Ay
   Q==;
X-CSE-ConnectionGUID: AOkCV8WMQGekbumFU6Ikng==
X-CSE-MsgGUID: rxl6KD0kTCayTLzTaPdYsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4280009"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4280009"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 08:19:51 -0800
X-CSE-ConnectionGUID: eN02qLzrRlun2U1ZdB003w==
X-CSE-MsgGUID: klCLZtJSSQWGrFuPKqNJJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11421788"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.109.217]) ([10.125.109.217])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 08:19:51 -0800
Message-ID: <4c51d4e3-2628-4b51-94ef-60c941c09dd4@intel.com>
Date: Mon, 23 Nov 2026 08:19:50 -0800
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
Subject: Re: [PATCH 2/2] x86/cea: Index exception stacks by the ordering enum
To: Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Xin Li <xin@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Binbin Wu <binbin.wu@linux.intel.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Chao Gao <chao.gao@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261120235025.2809042-1-sohil.mehta@intel.com>
 <20261120235025.2809042-3-sohil.mehta@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20261120235025.2809042-3-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/26 15:50, Sohil Mehta wrote:
> +/* The exception stacks' physical storage. No guard pages required */
> +struct exception_stacks {
> +	char ESTACK_DF_stack [EXCEPTION_STKSZ];
> +	char ESTACK_NMI_stack[EXCEPTION_STKSZ];
> +	char ESTACK_DB_stack [EXCEPTION_STKSZ];
> +	char ESTACK_MCE_stack[EXCEPTION_STKSZ];
	/* The #VC stack storage is conditionally compiled out: */
> +	char ESTACK_VC_stack [VC_EXCEPTION_STKSZ];
> +	char ESTACK_VC2_stack[VC_EXCEPTION_STKSZ];
> +};

Please vertically align the [EXCEPTION_STKSZ] like I did ^. Also, please
add some kind of comment about why the VC stacks need to be different.

Honestly, though, looking at this, two #ifdefs would be perfectly
readable here.

struct exception_stacks {
	char ESTACK_DF_stack [EXCEPTION_STKSZ];
	char ESTACK_NMI_stack[EXCEPTION_STKSZ];
	char ESTACK_DB_stack [EXCEPTION_STKSZ];
	char ESTACK_MCE_stack[EXCEPTION_STKSZ];
#ifdef CONFIG_AMD_MEM_ENCRYPT
	char ESTACK_VC_stack [EXCEPTION_STKSZ];
	char ESTACK_VC2_stack[EXCEPTION_STKSZ];
#endif
};

Because, without it, we have to explain VC_EXCEPTION_STKSZ anyway.

> +/* The effective cpu entry area mapping with guard pages. */
> +struct cea_exception_stacks {
> +	struct {
> +		char stack_guard[PAGE_SIZE];
> +		char stack[EXCEPTION_STKSZ];
> +	} stacks[N_EXCEPTION_STACKS];
> +	char IST_top_guard[PAGE_SIZE];
> +};

I dislike the asymmetry here. I'd rather just have two explicit lists of
stacks. This also begs the question but doesn't offer an answer about
why it's OK to have EXCEPTION_STKSZ vs. VC_EXCEPTION_STKSZ in the
"exception_stacks" but have EXCEPTION_STKSZ for all in
"cea_exception_stacks".


