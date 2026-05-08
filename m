Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7AC2571C7;
	Fri,  8 May 2026 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778230598; cv=none; b=pSJ6JsJD2Wo/M0mSVGixhz7xuXD7pSCokOC3ECkutcoAW2+2p7BL5pSEOQehmvQmuQURAeSOgK1BKV0Coh9gvXAbZNSz/2sVY3nO6dHRsfPtWz/l+lZYu/56213Vma6Yi4PUqC0FrqNpovcB60UiO33pRWuPNQFk/f8TpJcYT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778230598; c=relaxed/simple;
	bh=5JdVxPl/SGkb0GN/gDo8NgGrwkahNCADVnpqZkS2/Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVxMLBeJChpBCzKNRBhuWWUTOVQ9B4Tj5XA79hCQs2gd5JCdXIL0vhB5cYpHNE5ngZ1b3xEr/PwlI+whZkRs5Me7wP34LZfke4b4CW5jGn8qMTi1yvjO0kpSP9uNNu9fayEM6XzxxwkUcM/Vw3/w7gUc35xtPc61/YjsNsXK87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WmrT+4nl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WmrT+4nl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778230596; x=1809766596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5JdVxPl/SGkb0GN/gDo8NgGrwkahNCADVnpqZkS2/Mg=;
  b=WmrT+4nlsqprnkjst7cckbVilAcHuX94H7HIjWIGPfjVxhMq3nx8/8Q9
   DsIEOxxmiBQ4MC8ShyrI2c9xvq2x3c09KqtUCG0z8gHuJdIp3PQXbPPRh
   /AI7qCvFQEQC2CQXk7SOMFTmNFUrgNf7LSQi8o4hqhVKawOVkq8B3Zg8w
   H4A5B7a0Yy2iMuxkSBQ4WRdE/XcugDUIda4ahHxmEfIgvcC6EgGZ3cbFT
   ABxTBIB14vQgInber95vHuMa/7xq5SfFR7DOZy4j8NaNvUXTgL7G9+Ap/
   7do45n0df9Sk4bJreqVpi96S6GyqvC0To7Sq8aTUTCfckwyeSaK/suiN7
   A==;
X-CSE-ConnectionGUID: strLlC+jRMqpli0cevq4gg==
X-CSE-MsgGUID: Z97lhO3bR0aYDXZyU91cHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79132441"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79132441"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:56:35 -0700
X-CSE-ConnectionGUID: dBAywbSATISXK55b6wH7mA==
X-CSE-MsgGUID: ViREBiE3QHiv7TFsL0vC/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="235882392"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:56:33 -0700
Message-ID: <f8d70706-4e87-4e87-88d7-5b37eb6637fa@linux.intel.com>
Date: Fri, 8 May 2026 16:56:30 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
 x86 core
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>,
 Vishal L Verma <vishal.l.verma@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 Paolo Bonzini <bonzini@redhat.com>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.843498069@infradead.org>
 <20260501203717.GH1026330@noisy.programming.kicks-ass.net>
 <719c6275-c4b9-49f1-877e-05dd079b984e@linux.intel.com>
 <20260508085354.GM3126523@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260508085354.GM3126523@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/8/2026 4:53 PM, Peter Zijlstra wrote:
> On Fri, May 08, 2026 at 02:09:09PM +0800, Binbin Wu wrote:
>> On 5/2/2026 4:37 AM, Peter Zijlstra wrote:
> 
>>> +noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int vector)
>>> +{
>>> +	if (event_type == EVENT_TYPE_EXTINT) {
>>> +#ifdef CONFIG_X86_64
>>> +		/*
>>> +		 * Use FRED dispatch, even when running IDT. The dispatch
>>> +		 * tables are kept in sync between FRED and IDT, and the FRED
>>> +		 * dispatch works well with CFI.
>>> +		 */
>>> +		fred_entry_from_kvm(event_type, vector);
>>> +#else
>>> +		idt_entry_from_kvm(vector);
>>> +#endif
>>> +		return;
>>> +	}
>>> +
>>> +	WARN_ON_ONCE(event_type != EVENT_TYPE_NMI);
>>
>> Not sure if it's OK to use WARN_ON_ONCE() here.
>> If the warning is triggered, it could unblock NMI due to handling of #UD.
> 
> If that ever triggers you've got bigger problems.

Agree. :)

> 
>>> --- a/arch/x86/include/asm/desc.h
>>> +++ b/arch/x86/include/asm/desc.h
>>> @@ -438,6 +438,10 @@ extern void idt_setup_traps(void);
>>>  extern void idt_setup_apic_and_irq_gates(void);
>>>  extern bool idt_is_f00f_address(unsigned long address);
>>>  
>>> +extern void idt_do_interrupt_irqoff(unsigned int vector);
>>
>> In idt_entry_from_kvm() below, gate_offset() returns 'unsigned long', but here
>> it uses 'unsigned int'. It's not safe since there is no guarantee that the
>> address is within 32 bits for x86_64.
>>
> 
> Right you are, 'unsigned long address' it is.

