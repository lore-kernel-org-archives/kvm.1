Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF6245090A;
	Wed,  1 Apr 2026 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053435; cv=none; b=MpTkHtOJldHbU28kuRFItFbNUhviuJI/mq01F6kP7LTsFuK67vECWiWRWC7cvMO6f9IJBPVZoS3ftLbJxgHBY9KtLSrw6d+JZ+8ACWRDmduOPac38TMiMA1a/yeeTRxi9paRRLULouFBdW9O8Pl/NVtqzLkov4x9f2JQIiYqbio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053435; c=relaxed/simple;
	bh=DryLhhG4NN71YimAfpuPlkKlSrpcP5IEAQgbutXVFjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UstHNIece61rjZt+ZjEX9NmcDw09zTbHR1YgNUqL3qfLc7wlzHpWv/yhVqJ5Dk8bgmC5X3p8XZJBTl2ulhrdkP8mNmn6pNl937gSlg8wJobAh4Ekbd7qrSO9cCtukCcRDz4tTINp9j14hlWSgkI7lotKcY1LF2ueLb1uAT0AesE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFlvsNSQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFlvsNSQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775053434; x=1806589434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DryLhhG4NN71YimAfpuPlkKlSrpcP5IEAQgbutXVFjQ=;
  b=kFlvsNSQouiUfjhvZ9rpisTmwbTsiDRdvBF0FDpwwLwfOgKMV/azFl11
   8XKXL1th7AFTdoWLhz75hGW9Z9fi9TKMa7OgE2V0p0zg/WZx+LFQjDg6j
   elDE2uZag1zVut0pdskQHCj+qhbb/ZqBPQNLYpQS9fsas5ScsQEl/6MzY
   kl1cPk5Pmoy5xvs/Be2dL6u/0ns3RjHyHPOvqQ1KWnwUQXmsrcg+1EnHP
   QxBX2bRbg4qgQ9qutMpmEpqHPTaZbW/96Mu86J19pkMz5yNkkvpVdvwwX
   m0SUq8gwRvE0nDbqoJNz0flpwo0ZwMMGeIXq6hM9+QCPqXrNJLKwcN0Bx
   w==;
X-CSE-ConnectionGUID: AzQfwiLbSva1j42wcui9ww==
X-CSE-MsgGUID: Im0LRQWBSyO3wDbe9A2M0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="79980416"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="79980416"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 07:23:53 -0700
X-CSE-ConnectionGUID: A4o2gcf+QSGnQ54UDaA6eQ==
X-CSE-MsgGUID: AS6L6CMYTbGOJTBlROViPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="226938217"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.95]) ([10.125.111.95])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 07:23:52 -0700
Message-ID: <eabf56d3-3b6b-478e-9901-8c639291d79a@intel.com>
Date: Wed, 1 Apr 2026 07:24:00 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Verma, Vishal L" <vishal.l.verma@intel.com>, "kas@kernel.org"
 <kas@kernel.org>
Cc: "seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "tglx@kernel.org" <tglx@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
 <20260323-fuller_tdx_kexec_support-v2-3-87a36409e051@intel.com>
 <acpiGUKS-WRmLoxp@thinkstation>
 <def1f4395865ad0d22be245647fbb75ab8698ab8.camel@intel.com>
 <acu4raBTjdFcfVlS@thinkstation>
 <b9aa84d76c131132b5268712a44200e804c31aeb.camel@intel.com>
 <944b3fe5fa8955319030a7dfc0ea164bb0266e68.camel@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <944b3fe5fa8955319030a7dfc0ea164bb0266e68.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 14:36, Edgecombe, Rick P wrote:
> On Tue, 2026-03-31 at 18:22 +0000, Verma, Vishal L wrote:
>>> I guess the actual behaviour is dependant on the return code. It is
>>> obviously going to be the case for TDX_SUCCESS. And from the discussion,
>>> I guess that's true for TDX_SYS_BUSY and TDX_INTERRUPTED_RESUMABLE.
>>>
>>> What about other cases? The spec draft also lists TDX_SYS_NOT_READY and
>>> TDX_SYS_SHUTDOWN.
>> I think these are safe too - TDX_SYS_SHUTDOWN means the module has
>> already been shutdown, which this seamcall would've done, so things
>> should be in the same state either way.
>>
>> TDX_SYS_NOT_READY means the module hasn't been initialized yet. This
>> seamcall should just exit, and the module is already blocking any
>> seamcall that need the module to be initialized. The seamcalls to
>> initialize the module will be allowed, as they are after a sys_disable
>> call anyway.
> Should the seamcall return success in the case where it would return
> TDX_SYS_NOT_READY? It is in basically a reset state right? The errors we care
> about are actual errors (TDX_SW_ERROR), so it makes no difference to the code in
> the patch. But it might be a nicer API for the seamcall?

The problem is that the module doesn't have *a* reset state.
TDX_SYS_NOT_READY gets returned before the module is initialized and
initialization is a long, arduous process.

For instance, I believe the module stays "not ready" in the middle of
giving it PAMT memory and a keyID and all that jazz.

TDX_SYS_NOT_READY is a way of saying it can't easily *make* it to the
actual reset state that TDH.SYS.DISABLE wants it to be in.

It's arguable that the module should be made more resilient to stop
returning TDX_SYS_NOT_READY. But it's not as simple as just changing a
return code in the module.

I'm OK with it continuing to return TDX_SYS_NOT_READY for now. I think
it's a useful indicator. Maybe the kernel can't do much with it, but
it's a little window into what went wrong.
