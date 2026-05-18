Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B6F1DD877;
	Mon, 18 May 2026 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092172; cv=none; b=YUuQ7ADPk6l46dl52j2FeFhdOgvz3EO56XetblYLRnAd2SkrF6gfdmWKvcKVRCyIkQJD1/lUDD174dVQcCqlH1AndvshlxiygAfCwoQmihYPj2e4PTH0KVzdkVeN8V7k3iChbzgGXKhadoebmLYcHm+l2LZnCE7vpPh3Ec3biq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092172; c=relaxed/simple;
	bh=ByqxVztiBsev4MnAG1v00ebe+k0YiFlO6ZLGQy+xEfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ru4yuqSi7UObh/9VssQ3sdatwr0DmPkbSKYDHyIHC/UjqsYT8ugXZqffLesHhrXB2IKzc4leWysxFlRdGJIlqdCrsqJg4px6PtTkI0nG9h1XI4QH58HVy0mIrKO9OzQud/a8aM2Ew7+oIxAT1BEM/vN/0x5wMlk5+mcLMGaTpYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzbea2xi; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzbea2xi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779092171; x=1810628171;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ByqxVztiBsev4MnAG1v00ebe+k0YiFlO6ZLGQy+xEfk=;
  b=bzbea2xik8lzV9E/ChlCxR6pfHx10eOWyv2SbYsgLN710mJ3pV9S4eO7
   vQMJcAz29eW0hPZMS66Uq9q5lml6pI+CsBn1GZTZhuBHX17qwpMEaEt8X
   WgzgjmQJ5YzPJ8tbyUeduUT+skQsWvshQYE+LqAyAedMbJYh6osJNNopt
   nDiz43i4K3ybkqxIqSq0Nh5aRZsUROZDMwjusfx9GlG7vSIc9tkFc/kZO
   CnGx8joz1wcTyjVTVvqHA/1k6khZDq/blnhH50QIx/qrh18vYQgAZau7b
   mBPEiAi2qLzdBGy9izlsS2ZPnC1+5GY3pCm7wgWw4fl+4Wj/IYr8R2SNo
   A==;
X-CSE-ConnectionGUID: UAUQZzsZSF6tca9aSkU44w==
X-CSE-MsgGUID: E8xDFJkCT7en5pINzgZCYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="82504511"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="82504511"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:16:10 -0700
X-CSE-ConnectionGUID: Gt/ytEMMRJKuzofn+ucshw==
X-CSE-MsgGUID: yZajSFm7S3qG21iwx8BM4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="239437294"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:16:08 -0700
Message-ID: <6c02a10f-c62b-4874-9632-62ee001c087c@linux.intel.com>
Date: Mon, 18 May 2026 16:16:05 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/kvm/vmx: Fix VMX vs hrtimer_rearm_deferred()
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>,
 Vishal L Verma <vishal.l.verma@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 Paolo Bonzini <bonzini@redhat.com>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.957351833@infradead.org>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260423155936.957351833@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/2026 11:56 PM, Peter Zijlstra wrote:
> Vishal reported that KVM unit test 'x2apic' started failing after commit
> 0e98eb14814e ("entry: Prepare for deferred hrtimer rearming").
> 
> The reason is that KVM/VMX is injecting interrupts while it has IRQs disabled,
> for a context that will enable IRQs, this means that regs->flags.X86_EFLAGS_IF
> == 0 and the irqentry_exit() will not DTRT.
> 
> Notably, irqentry_exit() must not call hrtimer_rearm_deferred() when the return
> context does not have IF set, because this will cause problems vs NMIs.
> 
> Therefore, fix up the state after the injection.
> 
> Fixes: 0e98eb14814e ("entry: Prepare for deferred hrtimer rearming")
> Reported-by: "Verma, Vishal L" <vishal.l.verma@intel.com>
> Closes: https://lore.kernel.org/r/70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel%40intel.com
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: "Verma, Vishal L" <vishal.l.verma@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/entry/common.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -2,6 +2,7 @@
>  
>  #include <linux/entry-common.h>
>  #include <linux/kvm_types.h>
> +#include <linux/hrtimer_rearm.h>
>  #include <asm/fred.h>
>  #include <asm/desc.h>
>  
> @@ -27,6 +28,18 @@ noinstr void x86_entry_from_kvm(unsigned
>  #else
>  		idt_entry_from_kvm(vector);
>  #endif
> +		/*
> +		 * Strictly speaking, only the NMI path requires noinstr.
> +		 */
> +		instrumentation_begin();
> +		/*
> +		 * KVM/VMX will dispatch from IRQ-disabled but for a context
> +		 * that will have IRQs-enabled. This confuses the entry code
> +		 * and it will not have reprogrammed the timer. Do so now.
> +		 */
> +		hrtimer_rearm_deferred();
> +		instrumentation_end();
> +
>  		return;
>  	}
>  
> 
> 
> 

