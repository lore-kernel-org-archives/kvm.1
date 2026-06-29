Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0A635C19F;
	Mon, 29 Jun 2026 03:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782702161; cv=none; b=cYik/3mfdEITtxSscuX3kLzQWqk8WAlX7ICODE2GrCe2W9/FkBr6I/jvE/D59UvU/hhC7kihlVsSspqeh38Q63b6jPyR1ivimnUtrpcoVCDUF3CqXhzYM/mX7prftQKPZ7C6zjRxJ3uUs/TqIzQqwAQU3OGSMAqcVG3pDXsj134=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782702161; c=relaxed/simple;
	bh=hspIV54fnIbxjMFp1PDPmB0r5JQNCZ0wecm3UaXDQgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usppVnLskMt6XDhFMvkZi0I8r683Sr54wmTL3dzVSmuT1F1400Ge5Lt3JPNazGKU7dH3j7V/Qon6ZxmKtlCNTqSSo914TrkZD5WYM8UR5sTLd7XUV+K65CHAcXEw2UVbUtQzhrXNanow1cCSLU1BbKnzIO7zTYJ/xxidZxt5Ndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTi8cxEk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTi8cxEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782702161; x=1814238161;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hspIV54fnIbxjMFp1PDPmB0r5JQNCZ0wecm3UaXDQgc=;
  b=lTi8cxEk3MRIEWIpeFuIQ3rtdb3naUothc0/KT3RtMG/aOZPFOWuEB9k
   o9bsblm5cYhwMMosyQL4RdBnACVeQitBxdF2uLTIqZu+8RiF2x5bvBD9o
   Emkd5TeTYedyvrgNkQEN0WNVfCn+auk1lV9Vgily6JGbV+c74nS+rxZQg
   G+nuqi1V1cdqYjxSv4wnBlFiazVKlkW5sIfIumhuE/OayLepTS6POYHuv
   LMWvvcKdMqQawOslRuoPukkCW05Q0n0XmOQu3Iv2TP1DFmLav+y2MnDxg
   WgVSxImbjhyFxBTUHkgDSuVWf+JMXfuHfThDu2Ch5F6JQWXFtLB1Xj1Td
   w==;
X-CSE-ConnectionGUID: dkTgONH9T8alDAglHhIOiA==
X-CSE-MsgGUID: HRWpYnAJRTCvK0PSEP5Sbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="87076841"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="87076841"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 20:02:40 -0700
X-CSE-ConnectionGUID: hf9+ocMhRjavjBvf7N6NaQ==
X-CSE-MsgGUID: R1gyWsV/RyKDnppcnFf4dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="251965607"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.241.120]) ([10.124.241.120])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 20:02:38 -0700
Message-ID: <fc936b39-f6f7-4bc3-a1bb-491ebf88e6e3@linux.intel.com>
Date: Mon, 29 Jun 2026 11:02:35 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] KVM: x86: TDX: Validate directly configurable
 CPUID bits
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 rick.p.edgecombe@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com,
 kai.huang@intel.com
References: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
 <eba94468-2507-4c1a-8107-4d13182aed71@linux.intel.com>
 <aj1fqZEcApyd4sxi@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <aj1fqZEcApyd4sxi@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/26/2026 1:04 AM, Sean Christopherson wrote:
> On Mon, Jun 22, 2026, Binbin Wu wrote:
>> On 6/4/2026 10:33 AM, Binbin Wu wrote:
>>> Hi,
>>>
>>> A host state clobbering feature on new TDX modules/platforms can lead
>>> to host state corruption if KVM does not explicitly save and restore
>>> the related MSR(s) during host/guest transitions. If such a feature is
>>> blindly exposed to and used by TDs, it will result in unexpected behavior
>>> on the host.
>>>
>>> The v1 RFC [1] attempted to solve this by introducing a comprehensive
>>> CPUID paranoid verification framework across VMX, SVM, and TDX. However,
>>> as Sean pointed out in [2] and the discussion in the PUCK meeting, this
>>> approach was overly complex and bled too many TDX-specific details into
>>> common KVM code, creating an unnecessary maintenance burden.
>>>
>>> This v2 takes a significantly simpler, TDX-contained approach. It strictly
>>> validates only the TDX directly configurable CPUID bits—those reported by
>>> the TDX module in CPUID_CONFIG fields that the VMM can configure for a TD.
>>> This is sufficient to address the host clobbering issue, as no new host
>>> state clobbering features will be fixed-1. All filtering and validation
>>> logic is entirely isolated within TDX code.
>>>
>>> Feedback is highly appreciated, particularly on whether this contained
>>> approach strikes an acceptable balance regarding complexity.
>>
>> Hi Sean,
>>
>> Do you think this proposal is the direction to go?
> 
> Yeah, the basic gist looks good.
> 

Thanks for confirming this!
