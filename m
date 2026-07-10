Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8EB39B970;
	Fri, 10 Jul 2026 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670908; cv=none; b=S9qbVJBNlrOCgXOObLgKDibLT2rSMxjxf21eNK9/yaHoynBx5mSWSPEeGltWOPlInFlfM2mcgM3AA+x3CO+/3MFDu70X7ASsIihud5f+xnhThtyGfYcIGTNPSJ0vy5zuFSTjEzKZfuP/uSm+O4G4EGY81ncUpqVv7xexDqrLJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670908; c=relaxed/simple;
	bh=C6hJEAIJ0XruNCKkxi+daqc5SQqej3aCN7WrFQUSJ+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5L/WKhV4w7/9kNrNO74QLam4osP8+v3PxARuauRIG8tBdCawCeSnnGSqZA9SZBKrvBcZu9zyaSd0SqtbjsUlasDrgMDai9+ye/fGlWpftjF0v+o4H2ZKRMDI/9Z0+Ullz8vcRL+3RgGDKPzSF7PskeIKvvuN2yKCHl3TCJvovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7BLHWx4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7BLHWx4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783670907; x=1815206907;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C6hJEAIJ0XruNCKkxi+daqc5SQqej3aCN7WrFQUSJ+o=;
  b=M7BLHWx4u29qZvhpMQjrWo4auwA411lx+h8/ndpth4c3wR2a0zFLQCzq
   vS6W7mxtNPBLtc6at2OsV1QjANn5ial6JDuyOD9WbvWwiYs18t2fU7pk+
   4zIMkPNB1lEOl8RbPJ5QGPaEi0ID7RocQtDL5uymrYHsCxr6PHzmUfBd2
   3asDUaNFaQYS90X2VoFPl0cv4EPD7+5OJuauXRRp49IFVbXFednNFSyUx
   Tz5f7I36pf3KYqbG4K16GxmiwGPoxd36mC4GJnNSrzPNSIlNZQXWXjpaz
   BX25NzCkA5bWefaQ6T9jRCcQU63qV7/khObn4klj20Y89QzK+MnqfEs+z
   Q==;
X-CSE-ConnectionGUID: ojsxGAACQvCU2NROOz0HXA==
X-CSE-MsgGUID: faRyVJI5R4iYZLJ8bqyxgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="109913229"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="109913229"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:08:26 -0700
X-CSE-ConnectionGUID: dekCKHrlReOG24FqtQMnrw==
X-CSE-MsgGUID: oGzs6DWRRJWYyH3IBOnkuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="279235914"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:08:23 -0700
Message-ID: <5760cb18-739c-4907-b582-60933d11a72d@linux.intel.com>
Date: Fri, 10 Jul 2026 16:08:20 +0800
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
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CALMp9eQR4rFTSDMrOSHsLXsKvTdm9BbhorMEK329RqRk5Rr7Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/9/2026 8:35 PM, Jim Mattson wrote:
> On Mon, Jun 29, 2026 at 7:36 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 6/30/2026 7:19 AM, Zide Chen wrote:
>>> Add a test case to exercise IA32_PERF_METRICS, i.e. architectural
>>> support for Topdown (TMA) Level 1 metrics, enumerated by
>>> IA32_PERF_CAPABILITIES[15].
>>>
>>> Only check for non-zero metrics, as they are derived and depend on
>>> the workload, CPU model, and host scheduling, making precise
>>> expectations fragile.
>>>
>>> Extend the PMU selftest to cover Intel fixed counter 3 by bumping
>>> MAX_NR_FIXED_COUNTERS to 4 and validating basic functionality.
>>>
>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>> ---
>>> ...
>>> +static void __guest_test_perf_metrics(void)
>>> +{
>>> +     int retiring, bad_spec, fe_bound, be_bound, sum;
>>> +     u64 global_ctrl, metrics;
>>> +
>>> +     if ((guest_get_pmu_version() < 2) ||    /* Does guest have GLOBAL_CTRL? */
>>> +         !this_cpu_has(X86_FEATURE_PDCM) ||
>>> +         !(rdmsr(MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_PERF_METRICS))
>>> +             return;
>>> +
>>> +     wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
>>> +     wrmsr(MSR_CORE_PERF_FIXED_CTR3, 0);
>>> +     wrmsr(MSR_PERF_METRICS, 0);
>>> +
>>> +     /* Enable fixed ctr3 (TOPDOWN.SLOTS) and PERF_METRICS. */
>>> +     wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(3, FIXED_PMC_KERNEL));
>>> +     global_ctrl = FIXED_PMC_GLOBAL_CTRL_ENABLE(3) |
>>> +                   PERF_METRICS_GLOBAL_CTRL_ENABLE;
>>> +
>>> +     GUEST_RUN_PAYLOAD(MSR_CORE_PERF_GLOBAL_CTRL, global_ctrl, "");
>>> +
>>> +     /* Check test results. */
>>> +     metrics = rdmsr(MSR_PERF_METRICS);
>> Could we use rdpmc instead of rdmsr here? rdpmc is a preferred way to read
>> counter value.
> This is in-guest code, so the unintercepted RDMSR will be much faster
> than the emulated RDPMC.
>
> Should we rethink that preference, or add hardware support for
> selective RDPMC intercepts?

Hmm, in current most cases, rdpmc and rdmsr should share consistent
interception configuration for PERF_METRICS except host and guest have
different counters bitmap.

Considering this is a test case, the test coverage should be more important
than the performance, there should be at least a place to call rdpmc
against the PERF_METRICS, otherwise, that path won't be validated. 


