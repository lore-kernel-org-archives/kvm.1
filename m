Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C5A4048A3
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339273; cv=none; b=DnGvbGAemjyhwYHLyirhz3tklVYX+VIzGYQ34tdHSpm9oIXISWZPW0wcuGjljEQ6UmPyPdup0ueZrLYBTsEchwZzZKxQ3sWONpfC+3aoL6IZ8QqupKyFarue0vUU6HJlLSw+fKrbeb1d655C3isgLEF3FRQXo5lXyTJ2NaGsvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339273; c=relaxed/simple;
	bh=jBzFtgen7iTpJBOavrfxkbrYfUx67m1pcHpfrOMUV8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ABzHxJLc8I0pZDblyvJ7wA381x+nZKuf3MLJpByUQVHxAt9iWnjLo6+B5+6EprBfkBWXDDUiRU8es9gyYwB/lINes3Nq3aw5rRnMflCwXeJZvSG+BBnTk5mBtQGw4wudJpjlAsfTVQgih4AqZVLRd9Z9ewUUWaY8l1N3xXAC2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KboropXc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KboropXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788339271; x=1819875271;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=jBzFtgen7iTpJBOavrfxkbrYfUx67m1pcHpfrOMUV8o=;
  b=KboropXcRrbJIsDCNJlCjBbcnYyslZ40hgBpQoe7lH0TYeYIbTbcyMcW
   POsR3AkQxC0zZuNBv1w4Zkk+JiYzZArEe/Ca49I6Gxv2HNfhGe0XxVNFy
   priRLWEBlPcLbW1EY30PA0fsU2bkrops0b8VUzYMDvZb/Cwn1xfghrc3G
   99HFnDrKrUH1gfNJmynOFZPAUAMpBqsFauxBQPnay7Wg9cfMZ5mey706Q
   dLyM+P1dSfncnG6qBiKXtUCeptxPDsUlIqHyywDsk/wLdcS+2Kcla2/da
   s5uBKwPYN0lQQnek+b2R2j5fGfALjqDelqCDdTf7dyXd1qPV3jassCqkO
   A==;
X-CSE-ConnectionGUID: sFvqatD1RLiq4oHNXuFonw==
X-CSE-MsgGUID: 6wZZsvo2RKiwUxy1knA8fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92658850"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="92658850"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 01:54:31 -0700
X-CSE-ConnectionGUID: QlspN4ZnR5qQxswlva3bHw==
X-CSE-MsgGUID: w9iy/6VMS9GhuFRR1XDmng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="265054296"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 01:54:30 -0700
Received: from [10.238.3.26] (unknown [10.238.3.26])
	by linux.intel.com (Postfix) with ESMTP id 3B17820BF392;
	Wed,  2 Sep 2026 01:54:29 -0700 (PDT)
Message-ID: <d34494c0-1b87-48e6-aadc-0ecaf35ba554@linux.intel.com>
Date: Wed, 2 Sep 2026 16:54:28 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-unit-tests] x86/vmx: Skip LAM CR3 bits in 32-bit guest
 reserved bit tests
To: Xudong Hao <xudong.hao@intel.com>, pbonzini@redhat.com
References: <20260707070240.78295-1-xudong.hao@intel.com>
Content-Language: en-US
Cc: kvm@vger.kernel.org
From: "Hao, Xudong" <xudong.hao@linux.intel.com>
In-Reply-To: <20260707070240.78295-1-xudong.hao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/7/2026 3:02 PM, Xudong Hao wrote:
> According to Intel SDM 4.4.1 "Linear-Address Masking" (LAM), CR3 bits
> 61 (LAM_U57) and 62 (LAM_U48) are LAM control bits, not reserved. Skip
> the LAM control bits in the CR3 reserved-bit loops when LAM is
> supported for vmx_pae_test and vmx_pse_test.
> 
> Fixes: 55b77db1 ("vmx: add a test for 32-bit guest PAE paging PDPTEs")
> Fixes: feef9d92 ("vmx: add test for 32-bit non-PAE guest")
> 
> Signed-off-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   x86/vmx_tests.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> index 16f8a648..2c0feca0 100644
> --- a/x86/vmx_tests.c
> +++ b/x86/vmx_tests.c
> @@ -5896,6 +5896,11 @@ static void test_vmx_guest_pdptes(u64 cr3, u64 *pdpt)
>   	}
>   
>   	for (b = cpuid_maxphyaddr(); b < 64; b++) {
> +		/* CR3 bits 61 and 62 are LAM control bits, not reserved. */
> +		if (this_cpu_has(X86_FEATURE_LAM) &&
> +		    (b == X86_CR3_LAM_U57_BIT || b == X86_CR3_LAM_U48_BIT))
> +			continue;
> +
>   		vmx_32bit_guest_init_common(cr3 | (1ull << b), pdpt);
>   		test_guest_state("CR3 reserved bit", true, (1ull << b), "bit");
>   	}
> @@ -5979,6 +5984,11 @@ static void vmx_pse_test(void)
>   	}
>   
>   	for (b = cpuid_maxphyaddr(); b < 64; b++) {
> +		/* CR3 bits 61 and 62 are LAM control bits, not reserved. */
> +		if (this_cpu_has(X86_FEATURE_LAM) &&
> +		    (b == X86_CR3_LAM_U57_BIT || b == X86_CR3_LAM_U48_BIT))
> +			continue;
> +
>   		vmx_32bit_guest_init_common(cr3 | (1ull << b), NULL);
>   		test_guest_state("CR3 reserved bit", true, (1ull << b), "bit");
>   	}

Hi Paolo,

Can you help to review this patch?

-Xudong
