Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCAE32937A;
	Tue, 14 Jul 2026 05:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006893; cv=none; b=d2kWEGXaJlCHdHCOR0LRZY0ktZO3gzAN0QMEjw0riylfQhAfi1FIwJdHP2eXwqpfMDxOfEhzZcPVXpGKW1BAxjl9CqmoM1MYza7hUsusgiG1sBuYvFy10oU6EqTPlvuItNQlizvqI94AT3q9nDSPJQfWZ9cDcN9RfHDY5MJOQB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006893; c=relaxed/simple;
	bh=rxF2ZPwEcLUjmzWN7LNbEAcEr6iY437bDdZ5V2zlGXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+H9tv+QOPHyaqqugGBrxpO+MH5kjCdz+siF1/edakXLTefvgCg0k8FDR0+gz0eBzzStggw6IKOzMXkeKFgDREJxRzJuUgm0+9Xg+1UXHU/8qsJz8rGOgDSenk2tiQm7a8i/Q4MekFG+gU9J2iYuu1EBtX1vlakxAuuZWsHlbgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQEWDDHa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQEWDDHa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784006891; x=1815542891;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rxF2ZPwEcLUjmzWN7LNbEAcEr6iY437bDdZ5V2zlGXc=;
  b=VQEWDDHaRb54CX3fR7XVU4RIjMwkHPfygG9dma0TY4Z40nH+rXGVEcV5
   ag60gOmsOPdR+bRpncfWD0jU0LywcylCEPhUJ2gq/BKigs9gwRDc0jvx7
   KMFlN5F75uuR+nFXgeyrSuNDTh9YEoB9uiW+hqW+Z4VLaYJUvNVA2+YN7
   q7cFv/2usxoX87nMvNgfjaULUzyOyf7DPH6o2erpXz2nHvDWE41vA1U/e
   y0bt25xdBSbzUnMEb5Ee/fzbuqTXzIvnWIykWBaFM3K/nMAWXl94kgWqV
   YPUuXxZWLVgI56L8jsW8L/Ne18h8KciABbKWMg3QHLN2x3XZZirM7Pmwq
   g==;
X-CSE-ConnectionGUID: dviGjtIxQ0m6hOIbtdT8Wg==
X-CSE-MsgGUID: 0mNwamEQQfSUb5uzop8z/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="72144969"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="72144969"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 22:28:10 -0700
X-CSE-ConnectionGUID: d+pV0auzSfOYukVkVHSpkQ==
X-CSE-MsgGUID: ljJkCMdJSj2Waq34yefq2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="252366307"
Received: from unknown (HELO [10.238.3.181]) ([10.238.3.181])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 22:28:07 -0700
Message-ID: <dc8adc2b-ca9f-4ac6-9f15-e9e954e90b15@linux.intel.com>
Date: Tue, 14 Jul 2026 13:28:05 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] KVM: selftests: Add PERF_METRICS and fixed counter
 3 tests
To: Jim Mattson <jmattson@google.com>
Cc: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-9-zide.chen@intel.com>
 <32a1e1d2-c437-4cd1-8455-43fa9082cb50@linux.intel.com>
 <CALMp9eQR4rFTSDMrOSHsLXsKvTdm9BbhorMEK329RqRk5Rr7Og@mail.gmail.com>
 <5760cb18-739c-4907-b582-60933d11a72d@linux.intel.com>
 <CALMp9eTs1A73DUDQwO_mHDQF8UfJQG2B_GgJczdu2uxdazG+KQ@mail.gmail.com>
 <212b058b-5804-4a00-a95a-67f58546fd9a@linux.intel.com>
 <CALMp9eQGTde_nbCtHN5E4GiuBKrcKC+Sq_6O_JoyHZCaf+S=rw@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CALMp9eQGTde_nbCtHN5E4GiuBKrcKC+Sq_6O_JoyHZCaf+S=rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/14/2026 1:11 PM, Jim Mattson wrote:
> On Mon, Jul 13, 2026 at 12:12 AM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>
>> rdpmc is the preferable way to read PMU counters since the better
>> performance than rdmsr, and most of current code regardless of kernel or
>> user-space already use rdpmc to read PMC counters. If we set the rdpmc to
>> interception by default, then it may cause extra performance hit.
>>
>> Currently I didn't hear there is any plan to extend the rdpmc to support
>> more types for Intel platforms ...
> Is Intel willing to commit to that?

I'm afraid not. :( 

rdpmc is still possible to be extended to support more types in the future,
but recently we don't see such requirements. 


