Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FF380FE7;
	Thu, 10 Sep 2026 02:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789008859; cv=none; b=IK2nqaHfX5/Fcm2IyWB1v8zAp9KE53yIaAQlriB/pJa5ce5JyM+oj1rEbdSlGxkqTjkx9boPwMpg3PRYGPIKQMu+0ZsbHDlC4sMtBjCfRInjJ/D0Ks0WsXFSvzTjnf+utAHlJ88yUvav+LDuepZB9z92xoP/BBTC6Vf0wyLMj/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789008859; c=relaxed/simple;
	bh=HGlDXlBt3pN8x4AkolGiec06428RJ9t20jtNntk0E1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOgWy4X4O3y25SUWcC9OdFHIX5WQZt0JNsSqMr6aVdtvTtJ4By5A0kJkhPenvSdHdk/1j6bMFWclvhuPhD30rW/uJOTThJ/xMWStvrbgn9s/hzyGkohsumm+ZuaZvrve5JgfzY+isu6yyR7Ix3MjNK/K+rHecM8MJSiecG8Bo7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DuvZaVD3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DuvZaVD3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789008858; x=1820544858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HGlDXlBt3pN8x4AkolGiec06428RJ9t20jtNntk0E1I=;
  b=DuvZaVD3CZu2cwZByhOfY4mRI7tNTcetZLIMB8copWkRHEXG57TnY2h7
   1s4IgGsiXVoNEEhWPDfQn3d2Rtc3Ur24Rb2S4XdXikleAuVlzMBcXYAoj
   Eg539Ymp2QsclW/99sCb09sA9FdkSB1oGfT1TDhPfONprO08YcrwH5Gp1
   9ULIrWRcn6xJNRIpDphBxVS4uULK2KNppH2+Y6bbq6e/23h1mELMehwrd
   pJqNYnDTdbhNr+cxhBQXaoC3zx/nE/jno8snk3IasVzw8kCM9gY0BjVAY
   TeEgjZf0hikt6du7/1qo4HpVITPnlxaSdQmEUVDadGyqfaZvIWmTdQbJm
   Q==;
X-CSE-ConnectionGUID: /dK0gpr8TyaOY1YW0PuvCA==
X-CSE-MsgGUID: HDyfk02/RWixwGAcpzixpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93140419"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="93140419"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 19:54:17 -0700
X-CSE-ConnectionGUID: mEJEYVcrTHChDWvBhq++4g==
X-CSE-MsgGUID: Rhzhej6vTyC+A5EngLnXQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="309749712"
Received: from unknown (HELO [10.238.2.139]) ([10.238.2.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 19:54:15 -0700
Message-ID: <b3132b8b-5f3e-442c-9346-16738f82722d@linux.intel.com>
Date: Thu, 10 Sep 2026 10:54:12 +0800
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
 <473c5507-045f-454c-b6d1-76d2a390f413@linux.intel.com>
 <b227e4b40c45b090eee627e6a4d8f314297996ff.camel@gmail.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <b227e4b40c45b090eee627e6a4d8f314297996ff.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/2026 7:20 PM, Artem Bityutskiy wrote:
> On Wed, 2026-09-09 at 16:48 +0800, Binbin Wu wrote:
>>> VMX:
>>>   VM entry = load guest state from guest-state area
>>>   VM exit  = save guest state into guest-state area,
>>>              load host state from host-state area
>>>
>>> TDX:
>>>   SEAMCALL = save host state into SEAM VMCS guest-state area,
>>>              load module state from SEAM VMCS host-state area
>>>   SEAMRET  = restore host state from SEAM VMCS guest-state area
>>>
>>> I may be reading the SDM wrong, let me know.
>>
>> That's my understanding too.
> 
> Good, thanks for confirming.
> 
>>>
>>> So there are differences, and I was hoping to:
>>> - Be corrected if I misinterpret the SDM and how things work.
>>> - Get comments on whether the proposal took this into account.
>>> - Get comments on how this affects, or does not affect, the proposal.
>>
>> For host state clobbering behavior, we cares about the values of the host (VMX
>> root mode) after SEAMRET.
>>
>> When there is a control/field for "load host state from host-state area", I
>> think there are two cases: 
>> - If there is the corresponding control/field for "load guest state from
>>   guest-state area", the TDX module could leverage it.
>> - If there is no such corresponding control/field for "load guest state from
>>   guest-state area", the TDX module could do it in software way to mimic it.
>>
>> So from the view of the VMM, it can have the aligned behavior on host state
>> clobbering behavior.
> 
> Now I see what you mean: make msr_preservation.pdf follow the same rule
> as the VMX host-state restore, and let the TDX module help where HW behaves
> differently (call this SW restore vs HW restore via VMCS).
> 
> That sounds good to me.
> 
> My only doubt is whether it can be guaranteed in every case. A HW restore
> happens after a SW restore.
> 
> E.g., IA32_DEBUGCTL - HW clears it on VM exit (SDM 30.5.1), so whatever
> TDX module puts there on the exit path, will be overwritten. Not that this
> is an issue today, just using this as an example.

But SEAMRET is actually a VM Entry, I think these special cases are during VM Exit.
For a VM entry, the TDX module should be able to set whatever valid values for host. 

> 
> But I'd guess there would be only few problematic cases (if any).
> 
> Then you wrote this:
> 
> <cite>
> FRED is a useful concrete example.  Under VMX, the FRED host state in
> IA32_FRED_CONFIG, IA32_FRED_STKLVLS, IA32_FRED_RSP1-3 and
> IA32_FRED_SSP1-3 is covered by the VMCS host-state area, so the TDX module
> is expected to restore these MSRs on TDH.VP.ENTER return.  IA32_FRED_RSP0
> and IA32_PL0_SSP (a.k.a. IA32_FRED_SSP0) are handled by software, so the
> TDX module is expected to clobber them on TDH.VP.ENTER return.
> </cite>
> 
> That one reads as obviously right to me. If VMX and TDX differed in how
> IA32_FRED_RSP0 and IA32_PL0_SSP are handled, that would be a red flag.
> 
> Did you go through all the MSRs and check that the VMX and TDX behavior
> matches today?

Not yet.
This topic is put in the cover letter for discussions.
And the patch series itself doesn't depend on conclusion of the discussions.

> 
> Thanks!

