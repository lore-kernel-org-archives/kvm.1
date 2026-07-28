Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3523B9D91
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222813; cv=none; b=jXszsMHtyNjhV6OjJeuRt2wBXJ+4dk+cACB8hV0sB4Rs5403xtfAcCO5woYHuNNdPtRq1OZu58Hd6SPvPgK7ls69s+MmYzEOQbMGoJosmcQCTiMJIPFWQ4RCWzlROgYUBplTJv6KHOMun5bZIeNvrGD7+oZ02qxpH20WQxocE/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222813; c=relaxed/simple;
	bh=p0+mzkzhxuTGLEHy5Fuv3uADA/Kn+EL0V9rln/ca8CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ih3U4ZA+iqs7GdMH11QUCP+kOx8A7Nlj2E4L3nEuDf5Az4cQdYXP+fuLXxW1u1qKnWHZiPgVxuEt0u9bt/FYJrtw/IsTOe5MAb5dFGByo5GB1IEbTN9kH1+9HakaW9EMVaiEHBloUMBnV4LKBbxPdNscnv28NGuBEetmV50j1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PI1fBm4/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PI1fBm4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785222810; x=1816758810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p0+mzkzhxuTGLEHy5Fuv3uADA/Kn+EL0V9rln/ca8CQ=;
  b=PI1fBm4/eiQS23zxquWr9HtbjfUYe9pe8PgBDsU5cpcGRSbBD3LD2biQ
   cdLGjUE/IcnKsA/kUokBdTfKrTQBtR8uusQG5LTi/xJ8ADGA+/w4KFZJa
   eZlYRMJrWH+8mPL0WQ73U7m2egbgdVVKNt6kLhfKiXzPiUgYUn+nawD1Z
   GMSG9cxTKDT6LjuoYxNp9ZaFcrJNeg6xVTFwJFUNOEeROvgw8u5PkRvkC
   //gzZ3dNV6XMqW+jlDBrDuWIkoP3Cb0+e7TpaiMtk1KqeIvUUHFotNtSA
   QBXk/ga546rj/4n3KxbT8sNVRfSGALW1uS141kaqJK3Hs2Gdr68xIpWwP
   Q==;
X-CSE-ConnectionGUID: zIckcGvXSUeXOQLDKn288Q==
X-CSE-MsgGUID: iRmcVwTNQ36x7qFAVSJZTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89692022"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="89692022"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 00:13:30 -0700
X-CSE-ConnectionGUID: g2ZHx9fsS8eyD8qgc8g79A==
X-CSE-MsgGUID: itOgOCrqSlCeMfjr1HAYuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="289582187"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.241.120]) ([10.124.241.120])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 00:13:29 -0700
Message-ID: <23f8315c-29da-45b5-8a75-798a54a0978f@linux.intel.com>
Date: Tue, 28 Jul 2026 15:13:26 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] KVM: VMX: Bury all of the VMX preemption timer
 code under CONFIG_X86_64=y
To: Jim Mattson <jmattson@google.com>
Cc: seanjc@google.com, pbonzini@redhat.com, chao.gao@intel.com,
 kvm@vger.kernel.org
References: <20260724234914.987987-1-jmattson@google.com>
 <20260724234914.987987-2-jmattson@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260724234914.987987-2-jmattson@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/2026 7:49 AM, Jim Mattson wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Double down on using the VMX preemption timer only for 64-bit kernels, and
> bury the setup and runtime adjustment code, and all global variables, under
> CONFIG_X86_64=y.  This will allow addressing various Intel erratum without
Nit:                                                            ^
erratum -> errata.

But "various Intel erratum" sounds like there are multiple distinct bugs to me.
How about align the term with patch 2, i.e. "a widespread Intel erratum"

> running afoul of unused-but-set-variable and __udivdi3() warnings/errors on
> 32-bit kernels.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>


