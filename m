Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885EF38333A;
	Tue,  8 Sep 2026 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851455; cv=none; b=s/S9rDASnN9zWSq0yDHr5Nwmaxt/bZ1h7fEScXdwnRysESmQffeYWFN5DjruneyxreDWVt4ZdqOsz5vQOQKFOw6gSHaLHZZn9rMKwTP8lrHe46vVwksJC71JkdnTzVOJvXb71Tl5uJf4TRYzFY3fZMpOVtnZr3QLC21VVr7anFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851455; c=relaxed/simple;
	bh=mdWavgnh/x/AJO4uF1VDhCNX+mR1zYzu/G1GpTBRe8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaoVOaM2Q6cD2TBFOW3wjeLhXP+/F7dAdOEOOHgFX4Y7xCT2oaJZ8QBWPbJL04xiUuTLSqTn8oHcRKQgxdCWgTL2V3h85R0UTjcsGmmyIVrQYTzuX0bQzyWRtgWK7dNT/v/OWrfac22rTrx31EI3tUdPsq7Y0I7rmm96dm7PvH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkHvieVw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkHvieVw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788851454; x=1820387454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mdWavgnh/x/AJO4uF1VDhCNX+mR1zYzu/G1GpTBRe8g=;
  b=EkHvieVw/1VVb3AeIbe+eNtg5gcrWh8Qv5Y3f27UocpqXPsBjp2E7egA
   srd0zUNX4gdKhgxOpAD5pZ2RrgJ0GmOjs80FUOWVtI1prULeplaV2BWAC
   Dj/uxeIq5KMnm+lU4r+BvMSMLGcpCb+l3aII7ttTt4BbgLYeDov6wNME6
   1s6EcxwkQ7727dS4BCERU8B4yg3iZPgaU4TkTy9Yd2FVrFLpAjwDaVbYO
   DQhKPjPePSN36J2IVGP/RRaaSJZ2Xatjxchha5CgY0JhX3fPDM+m/SnKO
   X4DB9MALNu0ZPcrs72guVkYqbeXsuTytCpFEnAkMgapr+u4WKxbp1vdH8
   A==;
X-CSE-ConnectionGUID: hZct/MPPS/+lYi4fv1tZgw==
X-CSE-MsgGUID: GIEeHpkMQt2A3Nq8FSOoLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89261917"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="89261917"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 00:10:53 -0700
X-CSE-ConnectionGUID: GaW/K/4mQPCAaDXJAQ150g==
X-CSE-MsgGUID: dF7gKv5FReGETBuTzKqxhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="268333197"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa008.fm.intel.com with ESMTP; 08 Sep 2026 00:10:50 -0700
Date: Tue, 8 Sep 2026 15:10:49 +0800
From: "zhao1.liu" <zhao1.liu@intel.com>
To: Hao Xiang <hao.xiang@linux.alibaba.com>
Cc: kvm <kvm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	"xianghao.xiang" <xianghao.xiang@alibaba-inc.com>,
	seanjc <seanjc@google.com>, pbonzini <pbonzini@redhat.com>,
	"shannon.zhao" <shannon.zhao@linux.alibaba.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] i386/cpu: Rename CPUID feature bit AVX10_VNNI_INT to
 AVX10_V1_AUX
Message-ID: <ap+0+e0MKHdOC/bW@intel.com>
References: <45146bc1-0d78-46de-8bd8-cb1ecba49fe2.hao.xiang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45146bc1-0d78-46de-8bd8-cb1ecba49fe2.hao.xiang@linux.alibaba.com>

On Tue, Sep 08, 2026 at 02:13:17PM +0800, Hao Xiang wrote:
> Date: Tue, 08 Sep 2026 14:13:17 +0800
> From: Hao Xiang <hao.xiang@linux.alibaba.com>
> Subject: [PATCH] i386/cpu: Rename CPUID feature bit AVX10_VNNI_INT to
>  AVX10_V1_AUX
> X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5ForWebDing][Chrome]
> 
> CPUID feature bit AVX10_VNNI_INT is renamed to AVX10_V1_AUX to account
> for additional AVX10.2 isntructions sep-arated to have ”OR” sensitivity

nits:

s/isntructions/instructions/ - though it's a typo in spec :-(.
s/sep-arated/separated/ - there are no line breaks here.

> for platforms which may not support all of AVX10.2[*]. This CPUID bit now
> applies to the following VNNI instructions: VPDPB[SU,UU,SS]D[,S]
> VPDPW[SU,US,UU]D[,S], as well as the following convert in-structions:

s/in-structions/instructions/

> VCVT[,2]PH2[B,H]F8[,S], VCVT2PS2PHX, VCVT-BIASPH2[B,H]F8[,S],
> VCVTHF82PH.
> 
> [*]: Intel® Advanced Vector Extensions 10.2 Architecture Specification
>       (rev 7.0).
> 
> Signed-off-by: Hao Xiang <hao.xiang@linux.alibaba.com>
> ---
>   arch/x86/kvm/cpuid.c         | 2 +-
>   arch/x86/kvm/reverse_cpuid.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

I hadn't renamed it before because I thought this bit's name is not
exposed to user space, and it's enough to refer to it simply as
"this bit". But, semantically speaking, VNNI_INT is indeed no longer
correct. As noted in your commit message, the feature represented by
this bit now includes more convert instructions. And more accurate
naming is better, as it makes it easier to look up the spec.

This name change looks good to me, so

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

And BTW, the prefix of subject should be "KVM: x86:", referring
"Shortlog" section of Documentation/process/maintainer-kvm-x86.rst.

Thanks,
Zhao

