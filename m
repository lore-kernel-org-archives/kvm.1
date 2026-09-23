Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953CFF507;
	Wed, 23 Sep 2026 00:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121847; cv=none; b=VtuZd9MZ19p7Y5bqCvk7IKwe+AWWK3W0gO3GvZc+DYj3r/qV8y4/Ad8Dqp92VYUFuiqfBvGA70lGESU83r6Njwm+E17HXKYANz9mxalaMSmtKWZ7xBXacCKip/WJtwnUfU38mqFvoaIXosx7l0PyzBcAG/4/06lSK08cc2wFe3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121847; c=relaxed/simple;
	bh=8tKEuCLmRQFdnPFHe6SE98eZqIUccDtzXWBe+Y5FBio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tML9TIUxLq2ghX7qcZnYcChQz0sq3xIPrH4HNwt5obbSc24rqm/IgHcbR7DY2cwPvU6/sgOEYoHCkF31bT7qdkIraAQT+jggHesuJXwmLXBWzf7YLEJveifTFPJFtrVQncVM6lDmMtGZsQ8HxWoMGTxM/pWke+hxFEwPIEXnBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2hDX9UE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2hDX9UE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790121846; x=1821657846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8tKEuCLmRQFdnPFHe6SE98eZqIUccDtzXWBe+Y5FBio=;
  b=Z2hDX9UEuHjDcb+gUBVbLyIXMTbLpJBL1BF2AbJy8rNfKTFWgpOao2Yy
   0wBC5z1aiXNOyxOqrflW+QNZmt3+Tf+2dKS/CBXrE9YMwJH8FPKWcdcmI
   E6ZoI+MK5G8TDKupMT+Hg9Ls1iZneYjp2iLukPQhUQKNhN55smRX7lSK2
   IXn+2yryz7Xv0aUXfpNU6nvPIabtpywfyni0PGcPBg1ZBI9HJan3vI1Hp
   mgp3P0Wf4k3fqcB+VV0fsx5UTd/kdG3YIdfZs5bX2I9r4aJ8dn3S9qYEE
   dxQn7+ZQJkxSS0rCHDsNg39kufc2tzuBZ5T4fZbMKgtQLBYlTvsxJhjle
   A==;
X-CSE-ConnectionGUID: X0h8tYx5TKWkRMePuWUAKQ==
X-CSE-MsgGUID: 58LpvCrqTlObRZc2WMPSdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="93272951"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="93272951"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:04:03 -0700
X-CSE-ConnectionGUID: WGMqdp18RxeBTTYM/hykGw==
X-CSE-MsgGUID: bngKGEPWStuMweu0rXZG6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="271937255"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:04:00 -0700
Message-ID: <1cc1a933-59e6-4e56-9b3d-3d556c8883dd@linux.intel.com>
Date: Wed, 23 Sep 2026 08:03:53 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] KVM: TDX: Report CORE_CAPABILITIES as configurable
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "Maloor, Kishen" <kishen.maloor@intel.com>,
 "dedekind1@gmail.com" <dedekind1@gmail.com>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
 <20260917072548.2314491-3-binbin.wu@linux.intel.com>
 <7c5543092453fd1509695e2e17024fe20e45ee9a.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <7c5543092453fd1509695e2e17024fe20e45ee9a.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/23/2026 5:11 AM, Edgecombe, Rick P wrote:
> On Thu, 2026-09-17 at 15:25 +0800, Binbin Wu wrote:
>> Add CORE_CAPABILITIES (CPUID.0x7.0.EDX[30]) to KVM's allowlist of TDX
>> directly configurable CPUID feature bits, even though KVM doesn't support
>> MSR_IA32_CORE_CAPS for TDX guests, to accommodate the legacy TDX module
>> definition and userspace's stale knowledge of it.
>>
>> Older TDX specifications define the CORE_CAPABILITIES CPUID bit as
>> fixed-1, so userspace may expect the bit to be enabled for TDs.  #VE
>> reduction turns it into a directly configurable bit, so leaving it out of
>> the allowlist would make the bit impossible to enable once KVM starts
>> validating userspace's CPUID input, i.e. would be a surprising behavior
>> change for such userspace.
> 
> Since #VE reduction is controlled from the guest side, this is a bit confusing.
> Turning on #VE reduction can't change CORE_CAPABILITIES configurability status
> because it's too late. You mean that this was changed from fixed-1 to
> configurable to support #VE reduction arch? (I'm not sure why though).

Yes, a fixed-1 bit was changed to directly configurable bit if it is a
#VE reduction bit, regardless the guest enables #VE reduction or not.

I.e. CORE_CAPABILITIES was fixed-1 bit, but now it's directly configurable
by the definition of the specs.
