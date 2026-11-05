Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793855800;
	b=OLXuwRgp9WxqpuyQOJtUeLDTiOYGsvogKsyEZiwQE9gWdlHJJx1ckbwHphWJV0NwadsL
	 FZQx2WWhW1zrdFttTtuAXozezQ0xbiF4mRGbCPBW7Kmrghh9s/lRoXnaOuRJ9LjozMp33
	 NfHNQHp4Z3UkJNa4LoQpcQdrtx2OHWp2nvnoBkjU+se/yUSHVUxOcJEbaFICYzlMLAhDQ
	 cKIu6fqeqtehcdGXaVJbrPk7UucCWDNDMx4mB7PKtfUN81EnVTnJZGQOC3GiJavyAuYWU
	 htbBnOMJXzRB7mwaJ5Eu8hiwrDy5ZqZzfCxh1uwRT8TpQKv/LEkEJSH6iJprVioAcWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855800;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7T4yHCCp457ZSKeJuycOZpdN2Q/hAUKNLPVO2oSYggo=;
	b=ZyJhn5bMPO4lnRsP5nYeher3eB+P512JPLQPxxCaaz3tOwLkHi7jH4CVdfz/vZU+TFUv
	 LbPcGKcydI34wFu9ThYe8ZnHvXCUdLOKlBaQemGF30HLSABHyIKejLl7fscn/6Q8UD0/F
	 xPieO3rNApMptVDc1gy38TdECweQW8K1q2dg/TSgrAChDrJv9IprebIDMYbhykLwe7bIw
	 3QvvaA8XZiFMslY4naApcKkf5Or0wxOts+9NE3cixSlTXub4Jb1YioHf5YVvYr304Ai++
	 k+eT3HfqJdUYxLFjbBzWU0G2TvA8yN539uTEmskVHZ/EWRSY9gGxzpCYFRjPZPccuXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PMqwSwT1;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9641D606A326;
	Thu,  5 Nov 2026 05:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9641D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PMqwSwT1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793855799; x=1825391799;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iqOwHCYP9RY0nl5Y1J3CpFGbCCNkCkf7pz8yuuWp1rg=;
  b=PMqwSwT1eiCd+nVG0Eu0N9t+M7BW947IJqO8LoD+bRqc4NMKB1fWgPz0
   hYD5/KATp9dSS405cHF2b/mBWSAhS33APf8JUPbyHrbXCrwrwXNU/Bd8w
   p8D+kBanaoNYUC0iUato8pPOZopb180TKAugx5XVBBVlaYr51qs4Z1r6A
   7S27RWMZ8ksusCnIyf7XchpvyjdfvHAxgw0C8XjMq1pyk7bJ8r9hDG1yc
   ibxub38eEcDMBwWizmVSCwgeNF80+LWhqUnQ7+RTnPGpYEG8920gK8YBY
   VuNhN0O6ULDIx8fXibm+Qr6LMDc2r/OoKZp4vCB8Lh1SvErKPn+X6mZWd
   A==;
X-CSE-ConnectionGUID: Oq01XyhURwSxWozHKrAu7Q==
X-CSE-MsgGUID: tjH6AACMTnywhRi1k4UJBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2532886"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2532886"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 21:16:39 -0800
X-CSE-ConnectionGUID: 1vUCQSjAREmGCZBFc2L9Hw==
X-CSE-MsgGUID: VYrNVF0/TjuLDSZIFZvvgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6810132"
Received: from unknown (HELO [10.238.2.205]) ([10.238.2.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 21:16:32 -0800
Message-ID: <e4faa073-9cb6-4809-bf00-c4c4f669dbd0@linux.intel.com>
Date: Thu, 5 Nov 2026 13:16:30 +0800
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
Subject: Re: [PATCH v10 11/28] KVM: x86: Add a helper to detect if FRED is
 enabled for a vCPU
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
 David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-12-sohil.mehta@intel.com>
 <f7f84b44-e2fc-4d8c-b2e5-e5327086d026@linux.intel.com>
 <60f7934b-5271-4207-b071-6240b5d36cc5@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <60f7934b-5271-4207-b071-6240b5d36cc5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/2026 4:01 AM, Sohil Mehta wrote:
> On 10/23/2026 2:21 AM, Binbin Wu wrote:
>> On 9/12/2026 5:36 AM, Sohil Mehta wrote:
>>> +/*
>>> + * It's enough to check just CR4.FRED (X86_CR4_FRED) to tell if
>>> + * a vCPU is running with FRED enabled, because:
>>> + * 1) CR4.FRED can be set to 1 only _after_ IA32_EFER.LMA = 1.
>>> + * 2) To leave IA-32e mode, CR4.FRED must be cleared first.
>>
>> It seems KVM doesn't enforce it in kvm_set_cr0() for 2).
>>
> 
> I think the comment is slightly misleading. The spec doesn't directly
> enforce leaving IA-32e mode with CR4.FRED. It is just expected to be
> unreachable.
> 
> 1) Based on FRED spec section 4.2 Enabling in CR4, setting CR4.FRED
> prevents compatibility mode entry while CPL = 0.
> 
> 2) But leaving IA-32e can only happen when CR0.PG is cleared which can
> only be done in compatibility mode while CPL = 0.
> 

Right, on bare metal, if CR4.FRED = 1, it is impossible to enter compatibility
mode while CPL = 0. 

> Currently, for KVM, the CPU enforces the first one and the second one is
> enforced by kvm_set_cr0().
> 
> Is the suggestion to add an explicit check in kvm_set_cr0() that
> mirrors the PCIDE one? But there isn't a fault specified by the spec for
> this case.

Had a second thought. As you mentioned below, if em_{jmp,call,ret}_far() is
triggered and CS.L is cleared on ring 0, even KVM doesn't check FRED status on
far transitions, the next VM entry would fail.  So I think it's not needed
to mirror the PCIDE for FRED in kvm_set_cr0().

> 
> Sean also requested negative tests for things like leaving 64-bit mode
> with FRED=1. But, I am not sure how to test this.

Maybe it can use KVM_FEP to force the instruction emulation in kvm sefltest
when force_emulation_prefix for KVM.

> 
> AI tells me such a mode change can happen with emulated far transfer
> through an MMIO far pointer. "em_jmp_far(), em_call_far(), em_ret_far()
> and __load_segment_descriptor() have no FRED checks, so none of them
> raise the #GP that FRED spec 8.2 requires."
> 
> Chao had brought up enhancing emulator code and making it FRED aware
> [1]. I am wondering if we should revisit it?

Without the check the next VM-entry fails the guest-state check according to
FRED spec 11.5.2.3 ("If the DPL value in the SS attributes field is 0, the L
bit in the CS attributes field (bit 13) must be 1") VS. With the check, raise
#GP instead.

Not sure about the maintainers' preference. But a check on FRED in
__load_segment_descriptor() looks simple though.

> 
> [1]: https://lore.kernel.org/all/aapnI6KN7Flal8kg@intel.com/
> 
> Please let me know if I misunderstood something.

