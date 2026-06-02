Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC23D75A1
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395074; cv=none; b=d+n0S5DJMEBbgHRFR/fET638bZPedFzfH2B5PVqG0EycpFt/wJlYGA+qp8Rc4cjZ+3jql63/8IjF7Sog2zbBSWGc8cT7MA6COgwhU3NMMLmrUPSwH3J9b3kfnry+THxvDR6gCi1ftVWEPjZJINZcmdaRQ5dqyRY1635ZG7mhLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395074; c=relaxed/simple;
	bh=4HHmcNcFiFlZfxsZJ4yS1AIHeBQqoP6l/x/Fk6ajWso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kxw0w0QL3twrdmjmCJaF4PFirk447itJvBMd9qs18MFHGBVUsBSU1BobhUqgX20WqJ/j+QV+e7FG5/T0wzLKyw0Qux6cYrMcWwjIzJ9kaZpLo4fUXHQ+fkU5dUzbxhpZEgygM0yJA3nZP4fM1AxXFs8POu3C5OHFNfnIOW7zj2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMi5k5jK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMi5k5jK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780395074; x=1811931074;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4HHmcNcFiFlZfxsZJ4yS1AIHeBQqoP6l/x/Fk6ajWso=;
  b=CMi5k5jKyvNKmVD+dZF+5Pm5BYR2gVNypzSjaRdGIeeB13TcLUgqsjeg
   s0esYetUEg3Cia0Ae77zeGIBXpNRtJOr5vUPEf3Zkm1ar/S4J94827zsn
   795GZRtCsIEE1DsenU55lM4jdS68hNt4yAfrvfbZWbyFXNuWK/hyl8fCY
   l7Dl3tzS1QiUHBMYjI+Xbc1RFmQdA+z0z8OMyiDiFUeBMvynJjLWmCFa+
   IgfclN+iqvQjvc7syyNDNS3FNU3TBh9FPUMDCYw4g9BG138pnHYFO/9dY
   Quhbz94sJvp1cWsdo37UUZ+SOiPWoDBxlX0QTWyKIoEYKnWeHGetlErA0
   Q==;
X-CSE-ConnectionGUID: fGPnwh/OQHWBTuoRHauf8A==
X-CSE-MsgGUID: mIBNoJJYSFyWudnGSHywhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81076790"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81076790"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:11:13 -0700
X-CSE-ConnectionGUID: cT7ZUV4pTFG2fHINoQIefA==
X-CSE-MsgGUID: UV2Pi1QmQymaAB8n3+1zHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="243701388"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:11:11 -0700
Message-ID: <e565f91e-e41d-458b-939b-c2efe22111db@linux.intel.com>
Date: Tue, 2 Jun 2026 18:11:08 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2] x86/lam: Allocate test page from
 AREA_LOW instead of AREA_NORMAL
To: yexun <yexun@linux.alibaba.com>
Cc: kvm@vger.kernel.org, chao.gao@intel.com, seanjc@google.com,
 pbonzini@redhat.com
References: <20260602060116.35206-1-yexun@linux.alibaba.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260602060116.35206-1-yexun@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/2/2026 2:01 PM, yexun wrote:
> The lam test does not set a guest memory size in x86/unittests.cfg, so
> QEMU falls back to the default of 128 MiB. AREA_NORMAL starts at PFN
> BIT(36-12), i.e. physical 64 GiB, which is never initialized in a
> 128 MiB guest. As a result, alloc_pages_flags(0, AREA_NORMAL) returns
> NULL and test_lam_user() ends up running its LAM checks against a NULL
> pointer, which is semantically meaningless even if the metadata-bit
> arithmetic happens to succeed.
> 
> Allocate from AREA_LOW instead. AREA_LOW_PFN is BIT(24-12) (16 MiB),
> well within a 128 MiB guest, and bits 63..47 of the resulting linear
> address are still zero, so the LAM48/LAM57 metadata-bit checks remain
> valid. Update the adjacent comment accordingly.
> 
> Fixes: 0164d7595c85 ("x86: Add test cases for LAM_{U48,U57}")
> Signed-off-by: yexun <yexun@linux.alibaba.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
> v2: assert vaddr instead of pfn
> v1: https://lore.kernel.org/all/20260601035401.39303-1-yexun@linux.alibaba.com/
> 
>  x86/lam.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/x86/lam.c b/x86/lam.c
> index 87efc5dd..33772ecb 100644
> --- a/x86/lam.c
> +++ b/x86/lam.c
> @@ -231,13 +231,13 @@ static void test_lam_user(void)
>  	bool has_lam = this_cpu_has(X86_FEATURE_LAM);
>  
>  	/*
> -	 * The physical address of AREA_NORMAL is within 36 bits, so that using
> +	 * The physical address of AREA_LOW is within 36 bits, so that using
>  	 * identical mapping, the linear address will be considered as user mode
>  	 * address from the view of LAM, and the metadata bits are not used as
>  	 * address for both LAM48 and LAM57.
>  	 */
> -	vaddr = alloc_pages_flags(0, AREA_NORMAL);
> -	static_assert((AREA_NORMAL_PFN & GENMASK(63, 47)) == 0UL);
> +	vaddr = alloc_pages_flags(0, AREA_LOW);
> +	static_assert((vaddr & GENMASK(63, 47)) == 0UL);
>  
>  	/*
>  	 * Note, LAM doesn't have a global control bit to turn on/off LAM

