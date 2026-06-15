Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D613B9D9B;
	Mon, 15 Jun 2026 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508420; cv=none; b=RrIdDj4P5Ze+79ak8vXJtyf4kg/9AKIHgJAKAHPwBlKCW+JOTrzXmLFH3XBiAM4c4TrUetl1lWwt8+SSFeYu06gcX9rr9FRaeDP+4N2VbC9asv+j+C/bKDke1vlm0Er+Fs4gsXpPi8BRnR34Mz1a3GMiW7WUmFBU2LrvA6qhjRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508420; c=relaxed/simple;
	bh=8JMRxa5Lty8uJvClxnFXKkmrDs6ukAVGg0BRiVu9pQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrp2vJ01HkFSeHF2KSVzNHR1sx79LvH/g/by5wtTculFohjAc2D0nA5Wjd0qd0yBE9gEidmkyUtTmVuV3zbO3dXWOVqrKIUF1zn09uNsgXUfxugjRhMo2LF6e57kSAF+r8zeN5QJkzAIszPHiGMMJ8FZpx/vm0iIwuHpmdfGJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXWbU1jg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXWbU1jg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781508418; x=1813044418;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8JMRxa5Lty8uJvClxnFXKkmrDs6ukAVGg0BRiVu9pQI=;
  b=IXWbU1jgmIzwlCVClFH2e1ewEzr03/PhLrNbA/wAlT2Yy0dV6dasV6s0
   R4/2Db8VUq4Q4H34bD+/OeGaRVe994Ziq58Q053kpbdKIfplc6zhbUMVC
   D4g4KHfnmfAeCTW6pjT7ZcfeTnaHhxCyY2iIMG6NJiOJJiu04uw1jsp1Q
   adIzmzf9rtLihBS3W7DDyY3OSzawfVc43rjY5Qf5zo5WTK5i2p/WH4h86
   qaDX0cKEdTJ2kwQD6Q7N+WJoDdufPzEQ1YEZRo4vLxHnx0bBFoR4Skile
   Q4/Co8ZSs7+Bau5Zg+/HcH/aCGwyWzBYBk+FzyaMW2SmLSrqIv4i3HhjN
   w==;
X-CSE-ConnectionGUID: LegXgQIwSwi4ObISV60DNA==
X-CSE-MsgGUID: Qs1SykAJTa2yfzVXujqjVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="93630142"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="93630142"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 00:26:56 -0700
X-CSE-ConnectionGUID: TFQ3GJUxQp2lTX/9LU4cPw==
X-CSE-MsgGUID: KKEcSZCdQROyoJMcfv9wSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="271086165"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 00:26:50 -0700
Message-ID: <f8de77ec-146f-4a2d-ad76-70e552e3015f@linux.intel.com>
Date: Mon, 15 Jun 2026 15:26:47 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/30] KVM: x86: Swap the include order between x86.h
 and mmu.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-8-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-8-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Invert the include ordering between x86.h and mmu.h, and move
> mmu_is_nested() to mmu.h where it belongs (mmu_is_nested()'s placement in
> x86.h was solely responsible for the existing ordering), so that x86.h is
> not included by most KVM internal headers (but includes them).
> 
> No functional change intended.
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
