Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271328;
	b=oYZByuj8ZM69vH9F/ChQ+3MwYErhnaAZ2NBenXWOMgoCvwXdgEO7AR4V5xk0vjBhYHQi
	 lSAwqOX9b5rjoSGVl99mHVbxnhHZgqu6h2blwTWHdJYWf94dtwNJVmpL3wcQqbh7BDguL
	 57VTFWunj6wVpJFr3kuaLnqlkGEKsGcRENxLOooEjAeMEmnfyJN+5GWpcxZqNk1kkX6/7
	 xMc41LsPQ+J6at40Ke+GW+xRbN/CCFVngGr7KyX0ndfzEBG9gwu9UKFn7lqJjbW4k7Be1
	 jRLkttBCAFJVK46oD4ps4dMxNlqTZTBKUY+/sZDxrCXM7R/+7d5fVImltpkfZnOAfbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271328;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=QkkwAFQHohFN3MMtdm1q3jZttxO/j+fe5cVvGi3Xl6c=;
	b=YgU/RR9K5CvbIQceL+Xe91OE6zVeK31Yji/nz7g3hVzb7GGSWZyjAgiSLXgzWgIT2qaK
	 jJQaWroEAE9JNpkWEQclbyL3PT4tHhSO/Ot36DB+jggPO5ywnJ/8aeVnRtY7NnqMygMHv
	 fOTZnIvhmR+N/o9obIly1xqamY6va3c3puLig5zXOEQb0EyfkXerANGwIzleVOG2mqGlj
	 dDyerCEm5ZjQO3+eFco1cgO2b1MzGLtPifD6riXVLd8HCr0WXabq4gGOEQPGr4WTLcUVy
	 ldTBxYl/5demT4SX6jKnvqxRxhWW5kt4r3XmXGV9pkGJn3Vbc2yp8obkk08yrhTUulA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hAfZlOvp;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F638606A31A;
	Thu, 29 Oct 2026 10:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F638606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hAfZlOvp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793271328; x=1824807328;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QuCVJTSRuC+l8TTfanattdAyMrkAFWAplA63tjk/Ubc=;
  b=hAfZlOvp1RmtV47iSAy9QuJfiKnX+l4gbbxj6jECqTjnpacxc9mE4faq
   GKpDpggwEXYffFJnEMUoSDriMYu0NyQMjbXAuoydhGv8Fwn52PbYsc65e
   1Q0A2Uj6SQZ5qthnubO8qePkGgmoJ/dZ8ROAJWnKVe8Nq1jkMIvpZRIu7
   Zrb+hASRIDh17zVE2fUVN6upDNLkYzb3lMfs2iJ83v3rbXvjMbWgj51ts
   tMNuExDOop3HznnjAPu90VECzB9gd3gcV2O1VehhX2YgCi1sYyzc+ZlVC
   Xv6l/Mt6MUXE38kO+4DSyBoMXs9PjGPAx6Nj++HK58eAyIqdFmc00E+Yx
   w==;
X-CSE-ConnectionGUID: bnJQe9QeSTe13SFAw4aeEg==
X-CSE-MsgGUID: XiN9O3laR5Wc6iP1ROjqwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1899186"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1899186"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 03:55:26 -0700
X-CSE-ConnectionGUID: TCIFsRTITRCDp/Up5ewsjw==
X-CSE-MsgGUID: pxmLGcUrRe6SW/aUTpSCkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5208689"
Received: from unknown (HELO [10.238.2.205]) ([10.238.2.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 03:55:21 -0700
Message-ID: <2afe6fcd-eadc-4f9d-bbe4-0e6449479603@linux.intel.com>
Date: Thu, 29 Oct 2026 18:55:19 +0800
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
Subject: Re: [PATCH v10 14/28] KVM: VMX: Virtualize FRED event_data
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Shivansh Dhiman <shivansh.dhiman@amd.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>,
 David Matlack <dmatlack@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-15-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-15-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 94d684210cf6..e10ac6b280f6 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -431,9 +431,22 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,

kvm_deliver_exception_payload() returns early if !ex->has_payload.

For example, if a #PF is injected, kvm_deliver_exception_payload() sets
ex->event_data to cr2.
Later, if a #DB without payload is queued via KVM_GUESTDBG_INJECT_DB, the
event_data is not updated.
It seems the stale #PF event_data will be write to INJECTED_EVENT_DATA and
delivered to #DB handler in the guest.

>  		 * breakpoint), it is reserved and must be zero in DR6.
>  		 */
>  		vcpu->arch.dr6 &= ~BIT(12);
> +
> +		/*
> +		 * FRED #DB event data matches DR6, but follows the polarity of
> +		 * VMX's pending debug exceptions, not DR6.
> +		 */
> +		ex->event_data = ex->payload & ~BIT(12);
> +		break;
> +	case NM_VECTOR:
> +		ex->event_data = ex->payload;
>  		break;
>  	case PF_VECTOR:
>  		vcpu->arch.cr2 = ex->payload;
> +		ex->event_data = ex->payload;
> +		break;
> +	default:
> +		ex->event_data = 0;
>  		break;
>  	}
>  
