Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3453CE49E
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223359; cv=none; b=BX7ipEbuppCk3HQ1V5fcJv3RrL3XlDUAD9B7nkbj2xq1tIePObvnwHrNyr07gIOyaNPPuyKx1E+t9uSEYK5EC1KS6ErGX9KdHwHikl4cZZJWOciDEVya5n6uRJHUFF+Gum+6p69+ZUI21QC08exoUMw1XPvjv+furOPa6JwXV4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223359; c=relaxed/simple;
	bh=FUqs8L3bscbKoBzXb72QG01OB6gYnDN6yoNeRE50P4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=km8jgLx3afveHN2d8s8YVdvosU32rsdv3PK66CoqafV4OAj/+V5JhiBn2GSYkCASZz8OtnwwmP/bkqNjLryVB/Mgqz2UQzamt0noHsqZAKfUMPsQz61FHmUcsAnT0GrJDmCA+mPWluHQ99VDlIzGbribsmaZRQXa58lqjRQhfTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1QiCm4h; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1QiCm4h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785223357; x=1816759357;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FUqs8L3bscbKoBzXb72QG01OB6gYnDN6yoNeRE50P4w=;
  b=m1QiCm4hMsyYnk50BS9ul2I9+Hwep53dnAAooKfQlr76Dk/R5Md1QrP8
   /9FNDQzXw0Sj7EdADa+Iu9n6/m+TmY6dmFxIXxaL+/cDYzJa0Te0fQMaL
   5q29e96l0LFxh44KArRKv2uvu6LLyZu/YEmCpERyVDOd/kI94k4s1dSrb
   wICWFmBiinpAK8mvkyszCVkW6JHJ/afjn9+hYfX56nhl7P+xg3ysGyi/d
   IEB1AGtH6npsDXOJBk4H0mVbiIlfAbg8WpD7YBIM+SS+aB+FXO5K1KErf
   qiFNty47mUDbqt2GwV+DBmmzVey9yd/FsCNz5DgC+ZaSzhjGe25Tfsw8C
   w==;
X-CSE-ConnectionGUID: wC3nqDT/RZuKdLfLeNGMFg==
X-CSE-MsgGUID: UFd6qq8USQi0kdnqFX0MPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89692722"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="89692722"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 00:22:36 -0700
X-CSE-ConnectionGUID: RyHtugYcTDGFPXdJPT721A==
X-CSE-MsgGUID: mF2fWi1HS0yRaCVPuI7Pig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="289584052"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.241.120]) ([10.124.241.120])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 00:22:35 -0700
Message-ID: <2460343d-9975-4eb8-b743-cb0097d957b7@linux.intel.com>
Date: Tue, 28 Jul 2026 15:22:32 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] KVM: VMX: Cap VMX preemption timer to work around
 Intel erratum
To: Jim Mattson <jmattson@google.com>
Cc: seanjc@google.com, pbonzini@redhat.com, chao.gao@intel.com,
 kvm@vger.kernel.org
References: <20260724234914.987987-1-jmattson@google.com>
 <20260724234914.987987-3-jmattson@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260724234914.987987-3-jmattson@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/2026 7:49 AM, Jim Mattson wrote:
> Due to a widespread Intel erratum (e.g. EMR158), programming the
> VMX-preemption timer with certain large values may cause the timer to
> expire earlier than expected.  The recommended workaround is to cap the
> VMX-preemption timer value to strictly less than 2^25 * CPUID.15H:EBX[31:0]
> / CPUID.15H:EAX[31:0].
> 
> Calculate preemption_timer_limit during hardware setup based on CPUID 15H
> when available, and return -ERANGE in vmx_set_hv_timer() if the shifted
> delta_tsc reaches or exceeds preemption_timer_limit.
> 
> Use preemption_timer_limit - 1 instead of 0xffffffff when soft-disabling
> the timer and when checking the timer frequency limit in hardware setup.
> 
> Reported-by: Sean Christopherson <seanjc@google.com>
> Closes: https://lore.kernel.org/all/Zn9X0yFxZi_Mrlnt@google.com/
> Suggested-by: Chao Gao <chao.gao@intel.com>
> Assisted-by: Gemini:Gemini-Next
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

