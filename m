Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB45207A32;
	Mon, 31 Aug 2026 05:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788152494; cv=none; b=b9Ft2zs0qhnIK7GbXUVqQZ93oK7Bs3WQ7bSCVGQjJCyTAPrhSo833gOym0AqTJSp1enU7IfK5014hSx4UcK/bdGAI1VuXinBHh+iEVgYf+eQBspRvzoAH8paveTAsTXcbTZpviMRVX8j8QtMs5AFh7YYP28PNrVcOrqYguRT+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788152494; c=relaxed/simple;
	bh=zMHU9Xj3SzM3xmHQSC2knuRRMmoVMv7BrIS9wMud8Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFegoim363N2JtaghSGXHmmki3re72e+adeNyxTY02O9yfKI02iGWw9IctJF3J+3tRYKMj0R4UQFpdxxX97ovHD9fTb89Jkjm0LDBufZukPy6J2m6hXugb3uSF/+dnsy5F0HJfCADROWlX/CaQIYLDmXqGJ6ZcHcdcAZgEHZFC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+e4mRZq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+e4mRZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788152492; x=1819688492;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zMHU9Xj3SzM3xmHQSC2knuRRMmoVMv7BrIS9wMud8Xc=;
  b=H+e4mRZqTsLMbTRl0+icIZysD8wEvhyG7+pIPrYYTXqm6lypbHg9DWQ1
   yaMm9NJaQxsUxGeeUUyqbk5VQ6APpcpq06XaIBUIJarO8TXRXMAgE/j1L
   nDGkzeATd+OTGcq6YKMCUyEo4mcO63jwH+CZllot3PzrrPn119dKOIxs8
   EUB9SnBZBX4PmL7VkbMDjKTAz8eokACU/xqzOn+mh6hxWlSj1LxQjVRLP
   2J/mj2QGDV8zU5gf3gNwlC2YBReqCE7GQQX832I8fMSK8/DXLiAPLo1w6
   78A1zdd2pLL18dk+1kXCSkr4KGCzFXmHM9HIaeFaVtNhYJSvLQeDPvfNl
   g==;
X-CSE-ConnectionGUID: LEzlPGJWTAq2F9O0g4gj7Q==
X-CSE-MsgGUID: rl4Q1lJ+T6+xeEPBNxDLkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="76094675"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="76094675"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 22:01:32 -0700
X-CSE-ConnectionGUID: QmEgMgowTGSdqlG9xkxmlA==
X-CSE-MsgGUID: P8+obPsxQ7e1jTK0LYsT9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="293500149"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 22:01:29 -0700
Message-ID: <f7a3b14b-d31c-4a46-99e0-055761d631a9@linux.intel.com>
Date: Mon, 31 Aug 2026 13:01:26 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
 <e2f8f7976ac6a54e0bbda0e65ed9990940d9fef3.camel@intel.com>
 <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
 <1deddc78d14326b378ddd62ad99c21d66da401e6.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <1deddc78d14326b378ddd62ad99c21d66da401e6.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/2026 12:58 AM, Edgecombe, Rick P wrote:
> On Fri, 2026-08-28 at 11:19 +0800, Binbin Wu wrote:
>>>
>>> But it isn't a kernel bug, so I'd think to punt on this and let TDX module
>>> figure out a solution if/when the time comes. Probably various opt-in knobs
>>> to allow for working around it.
>>
>> Do you mean on the old platforms, the according TDX module versions add opt-in
>> knobs to allow the "effective 1 -> directly configurable" change?
> 
> Yea. Or the other way. Forcing the old fixed-1 bits to 1 automatically. Could be
> like a quirk like config thing. User/admin can decide if they want migration
> flexible design, or backwards compatibility for existing TDs.

It's all about the new created TDs on the old platforms. For existing TDs, the
runtime TDX module update should not change the shape of the TDs.

> BUT, we could work
> out the details later if we think we have options.
> 
> I think I've convinced myself we have options and can close this one. Agreed?

Agree.

> 
> <snip>
>>
>>
>> If FRED support lands in KVM for non-TDX VMs before this
>> filtering/invalidation is in place, adding FRED to the hardcoded denylist
>> would work as a temporary solution.
> 
> This could easily happen.
> 
>>
>> But that only holds for a well-behaved userspace VMM. QEMU, for example, only
>> enables features supported by both KVM and TDX, so if FRED isn't supported in
>> KVM for non-TDX VMs, QEMU won't enable it for TDX either.
>>
>> A malicious userspace VMM, however, can set a feature regardless of KVM's
>> reported CPU capabilities, and could still cause trouble.
> 
> Right. It the problem I thought we would need an opt-in to avoid.
> 
>>
>>> Do we want it? Where would it get plugged in?
>>
>> So if the approach in this series is taken, I think we still need such an opt-
>> in interface to tell the TDX module that the VMM is now filtering the CPUID
>> bits so that the TDX module knows that it's safe to report new host state
>> clobbering features.
> 
> Yep. Can we think about what it would look like? Easiest would be a bit passed
> in TDH_SYS_CONFIG. But then arch/x86 is saying how KVM will behave. Ok to me,
> for the simplicity. Could come with a nice comment.

The TDX module is initialized before KVM is loaded. I guess the upstream kernel
doesn't support out of tree KVM code, so we can assume if the kernel has the code to
opt-in the new host state clobbering features, KVM must have implemented the TDX
CPUID filtering and validation?

Also, do you think it's reasonable to backport this patch series to stable/LTS
kernels as an alternative?

