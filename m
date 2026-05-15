Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57F1401A26;
	Fri, 15 May 2026 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834808; cv=none; b=rW2Te1LOEr1lG2cD6lQFoZeMKGGE13PvKSAm+YKsPpfvgXeBcpIqDWX0Hgs07nnTf0Qd/SeOtRxn9MAt3bi3l9yXEDNWQvrXw5Lj9cHIZTLWluiGo4rkf0X5lXK7kN53u8dy8gejXl7ObRy+5sGkxXK7D0MldWWeEhfelNFucyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834808; c=relaxed/simple;
	bh=6aPpmRKzkXyr87w23PMzNSnTcCf7Wa4ntAEH93nKHn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkZoU83BdL6j2Mx5M+y6JpYPXcu0KpUDK1Y1W+H878zuQ4pAwd+exDOLmUP0M9iDH+CM8ONiRssLdojcwjowj4Xd9HapdT6E8Zd+BECTC32qwPNkR9shWUZQMp7Wvl1rzUdM7OC94ThL+0/LU9sFUhCSQvEiBW4Ra0XoI2wq3FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O89fvzX8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O89fvzX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778834806; x=1810370806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6aPpmRKzkXyr87w23PMzNSnTcCf7Wa4ntAEH93nKHn8=;
  b=O89fvzX8zFU8J39kFk8mZjYuJ+c9KfJFhXphdDWZ21YNdpcZPMtdPvk4
   ZQp5eur7XKguDP0rmNADWCx8hvzFQRSWnSkA+RuDBXDIcKndfW9pFj6Hq
   s8bgx/L4LHou9ZSh9kXoHk2fgom9gNV0+YPYc1zHhWn1+AGz3zWhj7n8E
   rp2kAORCNarQCIFfgLjNzvbD+iA4taIq7kEPyPzQ+jom5M00iZIwfQSfl
   n4aE/Rc3st6hjHy2WkS6lTw4hkH7c2jwoK2ej2LO1p+Q7hXnOT1f8E+a5
   lLmKffbH9Er5mBY/z7TgWXSfxmDgxu3rHMmviGA4+8/jMnaRk/y6alznK
   w==;
X-CSE-ConnectionGUID: fntcyn5PROGmX8SUT3LuPg==
X-CSE-MsgGUID: +9dhYEbPTrCFevrfQBOW+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="97217666"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="97217666"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 01:46:46 -0700
X-CSE-ConnectionGUID: REnkdQa0Q5yxSwoLt8b2EA==
X-CSE-MsgGUID: Zzgr2jZpRCaixK65jFGKUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="237776254"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 01:46:41 -0700
Message-ID: <1e176571-17d4-480e-83a5-40b81519627c@linux.intel.com>
Date: Fri, 15 May 2026 16:46:39 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
 <20260514215355.1648463-9-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260514215355.1648463-9-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/2026 5:53 AM, Sean Christopherson wrote:
> Make kvm_<reg>_{read,write}() mode-aware (where the value is truncated to
> 32 bits if the vCPU isn't in 64-bit mode), and convert all the intentional
> "raw" accesses to kvm_<reg>_{read,write}_raw() versions.  To avoid
> confusion and bikeshedding over whether or not explicit 32-bit accesses
> should use the "raw" or mode-aware variants, add and use "e" versions, e.g.
> for things like RDMSR, WRMSR, and CPUID, where the instruction uses only
> only bits 31:0, regardless of mode.
   ^
  double "only"

> 
> No functional change intended (all use of "e" versions is for cases where
> the value is already truncated due to bouncing through a u32).
> 
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
