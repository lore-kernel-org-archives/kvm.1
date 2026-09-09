Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60DC3ACEF3;
	Wed,  9 Sep 2026 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943712; cv=none; b=rI6Ic7xbMl1/Bc2gF9nLRxJZFl1tjsRSxzDbMLi3gLSeeJrwhwKWpD2vqBdXWkPaH5LbJLDSF26NcZ+TT4x9HOoY3OOFnijzZehVIrWhgMaJeTEnM3/JSlP8Ntj/3hEGwmcPNZ3TCMsVeVoXULKeYThNvT43sNm05ukP0YuJ7fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943712; c=relaxed/simple;
	bh=DCHInLOpuVYT2OPb99YcDwYJQo/A3HqChJTfUp9WlFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1pWlAFTpqwVzgwMYv72wuJbNFZJitsOo9+Y5WfChvjZElsVRR4nHGHiBU1yEAWAATScQizMSc9eXE4MKcev79nQrLmEkeaqNpeqLqfASsw1FKOdunWCikcPEaahw8ie9afgpTYSvZb0YYjIjbHoehqn7nER53cmM/WeTWI8nao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBWU5pIe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBWU5pIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788943711; x=1820479711;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DCHInLOpuVYT2OPb99YcDwYJQo/A3HqChJTfUp9WlFI=;
  b=jBWU5pIep5C72YJJajPSsvQoXeNukJiK5NnvL22mJkKzGJML5pgPinPG
   xXIt8OKpFs/cH4bHB2R/pvfdAwgq98OhA6ZUEWbfU4uHAKXlHyDYZNDFE
   dHKbBHgkybNcSXPxZlVhwX+K9Ha3z++VKvv03yiDXKizdx3FQLvP20H34
   Z7i7JM49qM756WmQEuSchF7Zd+H0gupLonudNUTBfQrBlBWYUL9t8sqvH
   OZyZ25rLGoDkL/iKZwJ6H8GCvTbLHASK5RLmW+CI/TgpExseZ/DZI6oZj
   Ri+pKDEqW1fq4WIvRReh/XFTfcML35NK1pExcAcXHmxkX9c3gW4beenGf
   A==;
X-CSE-ConnectionGUID: eEOutWsKQQ6pME588lvmkQ==
X-CSE-MsgGUID: IxtQZTs0SNCZuOyatXqT/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89379280"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89379280"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 01:48:30 -0700
X-CSE-ConnectionGUID: lBl90SwYTu2Y3bbZYE3nSQ==
X-CSE-MsgGUID: +QJIzFUjR9uKPvOU/ktOlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="271240166"
Received: from unknown (HELO [10.238.2.139]) ([10.238.2.139])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 01:48:28 -0700
Message-ID: <473c5507-045f-454c-b6d1-76d2a390f413@linux.intel.com>
Date: Wed, 9 Sep 2026 16:48:25 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
To: Artem Bityutskiy <dedekind1@gmail.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <32b51faabf60f6e87d9fdebbf2c3fe5a45fbff1c.camel@gmail.com>
 <58c185c82658819454a9950f37c6424226a098bb.camel@intel.com>
 <5faff363852572d59e34c876173d73c93734bd3c.camel@gmail.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <5faff363852572d59e34c876173d73c93734bd3c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/2026 2:52 PM, Artem Bityutskiy wrote:
> On Tue, 2026-09-08 at 22:31 +0000, Edgecombe, Rick P wrote:
>> We are kind of discussing what recommendations we should give about how
>> msr_preservation.pdf should be defined for new CPUID bit based features. So
>> saying to follow msr_preservation.pdf is self referential.
> 
> OK, thanks for elaborating. The e-mail was vague about that.
> 
>> Again, please do not treat the TDX specs as something to be handed down and
>> "followed". I think this is something to get used to for TDX. I mean, upstream
>> never wants to adapt to platform arch that fits awkwardly, but it's even tougher
>> to swallow when the arch is mostly SW defined. And further, the people working
>> on the TDX arch want to hear such requirements from upstream.
> 
> Agreed, that matches my understanding. Reminders are useful in general,
> but this was not that case.
> 
>> Here, the thing to discuss is how TDX should define new features that will
>> clobber host state (e.g. bits that would appear in msr_preservation.pdf as not
>> being preserved).
>>
>> There have been several PUCK discussions on the problem this series is tackling,
>> and actually several attempts to solve the problem during the base series. More
>> recently a host clobbering control was proposed that attempted to make it safe,
>> but it was not accepted. That proposal brought up the topic of whether having
>> select states clobbered was actually an unproven optimization.
>>
>> Now that we are moving back to an allow list type solution, what guidance should
>> we give on this other surfaced topic. Since TDX shares some save/restore logic
>> with normal VMs, we should have it work well with that code. So forgetting about
>> the performance optimization question, how to have it work in a sensible way
>> with the shared code paths.
> 
> Rick,
> 
> In general, the TDX case and the VMX case behaving the same way is
> best. I thought that consistency is always obviously a good thing,
> but let me acknowledge it explicitly.
> 
> I was trying to dig deeper into the proposal and analyze it.
> 
> <cite>
> The proposal is to have TDX simply match VMX behavior, i.e. on return
> from TDH.VP.ENTER, state that VMX would restore from the VMCS host
> fields is restored, and state that VMX would leave as the guest value
> is clobbered.  That keeps a single model for VMM, and means enabling a
> new feature for TDs requires the same work flow as enabling it for VMX.
> </cite>
> 
> My point was that hardware behaves differently for VMX guests and for
> the VMM<->TDX. This is not about following "boss specs", it is what the
> SDM describes.
> 
> For VMX, the VMCS host-state area is loaded by hardware on VM exit
> (SDM 27.5). For SEAMCALL and SEAMRET, the SDM seems to say they operate
> like an SMM VM exit and a VM entry returning from SMM (SDM 35.1), and
> those save state into the guest-state area of the transfer VMCS
> (SDM 34.15.2.2).
> 
> VMX:
>   VM entry = load guest state from guest-state area
>   VM exit  = save guest state into guest-state area,
>              load host state from host-state area
> 
> TDX:
>   SEAMCALL = save host state into SEAM VMCS guest-state area,
>              load module state from SEAM VMCS host-state area
>   SEAMRET  = restore host state from SEAM VMCS guest-state area
> 
> I may be reading the SDM wrong, let me know.

That's my understanding too.

> 
> So there are differences, and I was hoping to:
> - Be corrected if I misinterpret the SDM and how things work.
> - Get comments on whether the proposal took this into account.
> - Get comments on how this affects, or does not affect, the proposal.

For host state clobbering behavior, we cares about the values of the host (VMX
root mode) after SEAMRET.

When there is a control/field for "load host state from host-state area", I
think there are two cases: 
- If there is the corresponding control/field for "load guest state from
  guest-state area", the TDX module could leverage it.
- If there is no such corresponding control/field for "load guest state from
  guest-state area", the TDX module could do it in software way to mimic it.

So from the view of the VMM, it can have the aligned behavior on host state
clobbering behavior.

