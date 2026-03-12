Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5833A26B971
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275387; cv=none; b=l2lDB+skZD731LPBei5cZmnUZDgD5b+1qMt+FOFveeya4cinTR2lja5Y58jhToBPsIRG70ywePdGKXQI6eLF1N3rm59HdNNpuXYorxSn/YUWlgs58KT/n5TV26CbCpakN2BXn2RW6uJWXf8VhyuukqpEJwVqGNvZtjYb9EjiKGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275387; c=relaxed/simple;
	bh=l22aFmWa1egHQONU1XIQ/XLq6E/9g8lw4DNm95RDwZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7R/7oBOscMbg2fp4/0+a47xGFaHJj9LmwUIUnj+fTiDLU+Jhg777Mx2q7nZZCEAXu/2sRfEGd+FzCLk5GCZHCgnLrcDCMl8jll2G+vZrg8Zgk2Y7PHzJIBHXMvxMfN9pApXmDbVfxQYKLdnho0sBEAujIFGPXAKEgPfYNGzkhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=noG0wLcF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="noG0wLcF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773275386; x=1804811386;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l22aFmWa1egHQONU1XIQ/XLq6E/9g8lw4DNm95RDwZ8=;
  b=noG0wLcF0qaKBswj5IHfPFN+jnITOZNrAUA0XxLuJCZlGAB8PRKxIwGJ
   evnzfr0X3i7psivE7iHGJo7BaflVlTEN7OzjHjbFgMlyok3fJ9Q1+UB7u
   +xkX5g0NaNgnuZHbjlL9Rjn8DTwL0S6/pc3JU+CptctQbDmyn25EB9bq0
   fXzRGazh9ggKFdlh6tEs/BROPBOWzfgHma9/oLio6mhn7LGwe4yU4c1oW
   IIoGZkZJOF5GxXC+e9IKH3TJUMcLFPCPAYGs4KwTi7f3+PsJiFNhu93Xg
   vwHxRfDAq6ozRERE0o9FSReY4sovJ+vKbGh3cJ3dUwRY7uMM3D9htZsJu
   w==;
X-CSE-ConnectionGUID: ZO9Ypvx2TgOZgAgYuQIiNQ==
X-CSE-MsgGUID: f18yv1i5SbqbR7B0W55OEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="91931919"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="91931919"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 17:29:46 -0700
X-CSE-ConnectionGUID: mU8GAQ7IRr2mTNCRkS55AA==
X-CSE-MsgGUID: /wVzh2drT/iuwKSjWLlZkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="217247616"
Received: from unknown (HELO [10.238.3.214]) ([10.238.3.214])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 17:29:43 -0700
Message-ID: <f4a37d32-26ef-4135-8ba3-c7324389f75c@linux.intel.com>
Date: Thu, 12 Mar 2026 08:29:41 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH v2 0/9] Upgrade intel vPMU version to 5
To: David Woodhouse <dwmw2@infradead.org>,
 "xiong.y.zhang@intel.com" <xiong.y.zhang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "like.xu.linux@gmail.com" <like.xu.linux@gmail.com>,
 "zhenyu.z.wang@intel.com" <zhenyu.z.wang@intel.com>,
 "kan.liang@intel.com" <kan.liang@intel.com>,
 "zhiyuan.lv@intel.com" <zhiyuan.lv@intel.com>,
 "seanjc@google.com" <seanjc@google.com>
References: <c6590d8d23f4b09be727d8745e2ebfd5a6ab002d.camel@amazon.co.uk>
 <81465dc2-6734-4a3a-a0c0-2eefd15866e4@linux.intel.com>
 <34f9ee431cdfd5e3df6dd5cdbe7214312e3fd75a.camel@infradead.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <34f9ee431cdfd5e3df6dd5cdbe7214312e3fd75a.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/12/2026 12:28 AM, David Woodhouse wrote:
> On Wed, 2026-03-11 at 09:37 +0800, Mi, Dapeng wrote:
>> On 3/10/2026 7:56 PM, Woodhouse, David wrote:
>>> On Thu, 21 Sep 2023 at 16:29:48 +0800, xiong.y.zhang@intel.com wrote:> Intel recent processors have supported Architectural Performance
>>>> Monitoring Version 5, while Intel vPMU still keeps on version 2. In order
>>>> to use new PMU features introduced in version 4 and 5, this patchset
>>>> upgrades vPMU version to 5.
>>> What happened to this series?
>> This implementation base on the legacy perf-based emulated vPMU has been
>> dropped. The support for higher PMU verion (5/6) would be re-implemented
>> base on the new mediated vPMU framework. Thanks.
> Thanks. A bit like this?
>
> https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/pmuv5

Just a little, only a little bit code would be reused and most of code
would be re-implemented base on the mediated vPMU. Thanks.

 

>
> David Woodhouse (1):
>       KVM: selftests: Add tests for PMU v4 GLOBAL_STATUS_SET and GLOBAL_INUSE MSRs
>
> Like Xu (1):
>       KVM: x86/pmu: Add Intel PMU supported fixed counters mask
>
> Xiong Zhang (7):
>       KVM: x86/pmu: Delay vLBR release to the vcpu next sched-in
>       KVM: x86/pmu: Don't release vLBR caused by vPMI
>       KVM: x86/pmu: Add Streamlined FREEZE_LBR_ON_PMI for vPMU v4
>       KVM: x86/pmu: Add PERF_GLOBAL_STATUS_SET MSR emulation
>       KVM: x86/pmu: Add MSR_CORE_PERF_GLOBAL_INUSE emulation
>       KVM: x86/pmu: Add fixed counter enumeration for pmu v5
>       KVM: x86/pmu: Upgrade pmu version to 5 on intel processor
>
>  arch/x86/include/asm/msr-index.h                   |   5 +
>  arch/x86/kvm/cpuid.c                               |   5 +-
>  arch/x86/kvm/pmu.c                                 |  14 +-
>  arch/x86/kvm/pmu.h                                 |  17 ++-
>  arch/x86/kvm/svm/pmu.c                             |   1 +
>  arch/x86/kvm/vmx/pmu_intel.c                       | 161 +++++++++++++++++++--
>  arch/x86/kvm/vmx/pmu_intel.h                       |   9 ++
>  arch/x86/kvm/vmx/vmx.c                             |  19 ++-
>  arch/x86/kvm/x86.c                                 |   3 +-
>  tools/arch/x86/include/asm/msr-index.h             |   6 +
>  .../testing/selftests/kvm/x86/pmu_counters_test.c  |  92 ++++++++++++
>  11 files changed, 301 insertions(+), 31 deletions(-)



>
