Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B9277818
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 05:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784525274; cv=none; b=m7JWeT3A+Z1d/ilfdGHBncYfF1FPjgCdHnAGCJz8tFytdqYkeem4xirjJCzAoGXwWzu9/i11rfV9yUBlSQP3HLo4SrbvjVDe0u1e+c1Fo8le9GdlNIv2JhFvQZR0RiqbIbmzK48qMSV/mFsLfMzXmZDHzppIfmoUZgsRMdUBZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784525274; c=relaxed/simple;
	bh=cTZMKoFP0Sv+0rBETtStvOFK56Sr2woYNjhUdIXTON0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkKHRl1Ozo3k3yLQ9qhlr2An45F//qINZBmjMipdERCKk5S4Rno+3UGiGCxfEdi27jiYHG17Iwmn2SUrrSLZC3PoVU+6eltu/7Pwwyppc7jM7Kr2UjwpIOLx+KlwoEfmryHWg9RS8xCsMGZQ+TsH/pjSCsAc7ZgbiE1/iWRlcqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MT70i8v5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MT70i8v5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784525272; x=1816061272;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cTZMKoFP0Sv+0rBETtStvOFK56Sr2woYNjhUdIXTON0=;
  b=MT70i8v5oLcCM6lZ2krpGgfBiJi2CSmwYK6G6B043a6LDFIeJWFkAk4E
   Du5wSMhjleim6rx0AR9Hgg7XCObffzb+qaAN0ghj4HaQS/n+2im5+omh8
   4X+YW0DxrxLmbz2HmvDLmD+pU/LUtXCIMQAmFYDtolTrSn2FmnGZFFGje
   fQ4NULypug5DVYwhqcM51gTlqaSSbWzGjpc599E/Z1LMRf0bg4qPBNRsm
   jJj8z5/xejV8NCT+LAxCVKp4dFaRRcomTrIMg4p/krr5wVQCKLYWWyBw/
   w+ueGDez0HKgz1TBTvYL20XzdVttO4w7MEtTI+m4L0EZMh0ZODyW/JtEV
   g==;
X-CSE-ConnectionGUID: bR0uewVSSFK0bmrYHcwTnw==
X-CSE-MsgGUID: a8wZbeu8QeqfQn22vEatZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85134268"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="85134268"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 22:27:50 -0700
X-CSE-ConnectionGUID: nQI4SR5lQb639kwaOezhCA==
X-CSE-MsgGUID: PhL0tFPpTzS14ScIWepDTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="255581029"
Received: from unknown (HELO [10.238.2.244]) ([10.238.2.244])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 22:27:49 -0700
Message-ID: <a29e5f52-e6a8-4e1d-883a-6523662760e3@linux.intel.com>
Date: Mon, 20 Jul 2026 13:27:47 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v4] x86/lam: Allocate test page from
 AREA_LOW instead of AREA_NORMAL
To: Yexuan Yang <yexun@linux.alibaba.com>
Cc: kvm@vger.kernel.org, chao.gao@intel.com, seanjc@google.com,
 pbonzini@redhat.com
References: <20260716100716.1313-1-yexun@linux.alibaba.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260716100716.1313-1-yexun@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/2026 6:07 PM, Yexuan Yang wrote:
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
> Signed-off-by: Yexuan Yang <yexun@linux.alibaba.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
> v4: Change author information.
> v3: Change static_assert to assert.
>     https://lore.kernel.org/all/20260603015831.41664-1-yexun@linux.alibaba.com/
> v2: Assert vaddr instead of pfn.
>     https://lore.kernel.org/all/20260602060116.35206-1-yexun@linux.alibaba.com/
> v1: https://lore.kernel.org/all/20260601035401.39303-1-yexun@linux.alibaba.com/
> 
>  x86/lam.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/x86/lam.c b/x86/lam.c
> index 87efc5dd..63a36539 100644
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
> +	assert(((u64)vaddr & GENMASK(63, 47)) == 0UL);
>  
>  	/*
>  	 * Note, LAM doesn't have a global control bit to turn on/off LAM

