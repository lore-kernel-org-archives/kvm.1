Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD1533263B
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298151; cv=none; b=rpwbBoK0iNQpirvOaHUJKyQ4/fkmvDmynP/bZnMxcN8pj664Jmw7+J+2SdxG4HDrZFMl/SUkr4++VoVfY5p0sUxoETvclZDJK94Qdh2cyjOlHzwK2CwnWYf9DYI2FTYif1KlPP9XdET7ROyqKeEFWiIJ4YfpgYSVe5t26g47Upo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298151; c=relaxed/simple;
	bh=80lQ7K3atYAtEeWgo1wJE35QAUa9IT6gUFUbqhZSVko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDkAd7HRB27MjBCGWwZs3SMwxLUAbcNQWjkE+RIO/SKVMNGJeiRDJ+AEriNPd6Jv3OqpmMh9GCNv/tZOq1rFg1hLyto64nMNkeqRdxw2uCXZlSY9ORNuznXQY2a6LfsZSbd4iGoBDVVgJYoTfVnMUvKe6YHOkj1mRqjRNP6n0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5Ua8cfZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5Ua8cfZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780298149; x=1811834149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=80lQ7K3atYAtEeWgo1wJE35QAUa9IT6gUFUbqhZSVko=;
  b=k5Ua8cfZChCmo0E8EgSFbVDXlFFc2ze61iLPp+wQeRNqLL0lKwKEkhHo
   gzgqANdvFpyXnAL5aKK7oLJm/HYWvw1WH2pAR0NL16RnZyuaXU3MWifeQ
   vPcTNhMp6UM4+PmOkCFUWNnF/ImMWjeqWxEh60LlZt4pNSqq1OqW2/47L
   VXUURamCJ3rpZWloUfz/eWG0/zngtFvc+N42IG7QYQnF4OGm5yQBLktDM
   IH7xmJ8zu8P6i+T0jRPrpFKAceFoYPD1zi+e2h8vJqOl6cvH7zzTR0+FT
   l2WZW2yPwKKDs2qqcNxlxxLUVriaSEyHyd/zdzdM/t+Q26smT48r5KLAR
   g==;
X-CSE-ConnectionGUID: +RmP9HYwRW+v87UlyE7sfg==
X-CSE-MsgGUID: ztXznZHoSJe8+UfRgnziKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="83624904"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="83624904"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 00:15:49 -0700
X-CSE-ConnectionGUID: BFZNUQk9R5uQFMQCOtRhzg==
X-CSE-MsgGUID: E+YwHOPiTsCGGf5Tpi9nNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="281617007"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 00:15:48 -0700
Message-ID: <8f155587-07b8-4315-9015-3d104ddfb34e@linux.intel.com>
Date: Mon, 1 Jun 2026 15:15:45 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH] x86/lam: Allocate test page from AREA_LOW
 instead of AREA_NORMAL
To: yexun <yexun@linux.alibaba.com>
Cc: kvm@vger.kernel.org, chao.gao@intel.com, seanjc@google.com,
 pbonzini@redhat.com
References: <20260601035401.39303-1-yexun@linux.alibaba.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260601035401.39303-1-yexun@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/1/2026 11:54 AM, yexun wrote:
> The lam test does not set a guest memory size in x86/unittests.cfg, so
> QEMU falls back to the default of 128 MiB. AREA_NORMAL starts at PFN
> BIT(36-12), i.e. physical 64 GiB, which is never initialized in a
> 128 MiB guest. As a result, alloc_pages_flags(0, AREA_NORMAL) returns
> NULL 

Oops, thanks for catching this.

> and test_lam_user() ends up running its LAM checks against a NULL
> pointer, which is semantically meaningless even if the metadata-bit
> arithmetic happens to succeed.

From the LAM hardware perspective, NULL pointer is treated as a
userspace virtual address, so the LAM hardware feature validation still
works.

But it's not intended to use a NULL pointer, so it's a bug that needs
to be fixed.

> 
> Allocate from AREA_LOW instead. AREA_LOW_PFN is BIT(24-12) (16 MiB),
> well within a 128 MiB guest, and bits 63..47 of the resulting linear
> address are still zero, so the LAM48/LAM57 metadata-bit checks remain
> valid. Update the adjacent comment accordingly.
> 
> Fixes: 0164d7595c85 ("x86: Add test cases for LAM_{U48,U57}")
> Signed-off-by: yexun <yexun@linux.alibaba.com>
> ---
>  x86/lam.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/x86/lam.c b/x86/lam.c
> index 87efc5dd..b2dcf7f8 100644
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
> +	static_assert((AREA_LOW_PFN & GENMASK(63, 47)) == 0UL);

Although the error exists in the original code, the GENMASK(63, 47) is an address
mask, it's not right to mask a PFN.


>  
>  	/*
>  	 * Note, LAM doesn't have a global control bit to turn on/off LAM

