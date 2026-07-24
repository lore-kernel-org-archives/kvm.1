Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA633C2794;
	Fri, 24 Jul 2026 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926051; cv=none; b=D8f1Q410O+o5NZVfyut9JD9zHl6YUkD0XCXPgvWaNEcyJsKKOkBG3EVpSKJ6RxXO2RwkOvBrYHLzfqxT5w6WaWRAipNLaAPrTtht6S3AjiE6wrABAMMgJZ2qxlRJ62s6MeUb8RObKQVWuJk8BiGuAD81qNCz6G2YQFaVR7ySpL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926051; c=relaxed/simple;
	bh=DcjDbZAjOywT11msNPWY6LNKZJH3J614qhTv7/0OUIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYg3n22abBRmwwDszgmeZr6SkGHGmVKW/eIKdC2RASAs/UPKZ12P8MnMlSPjMllrzx2QmUi0KvpPCp2Th0A+aqSV3sYUBgwaVtoAllW8g77ZcOambksUYRbJXJVkyB6RUEdbITVA+ihLawkK0yjByWGpne95Uky3YsGEZFHypI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTQBBtxx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTQBBtxx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784926050; x=1816462050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DcjDbZAjOywT11msNPWY6LNKZJH3J614qhTv7/0OUIo=;
  b=fTQBBtxx3MnqmPq6R/j4K2ZvBHok+xe84fGSs99iFGvY5kq3wWAzsYY+
   AI8CpU1vlhUT4CLQSkhWdjBETQ/1trC/xUEietXOSqKYnydSkH9vX1DrH
   RnLXNyb7UAtoUwP4OAInzit98PtYBWik3Ib3ssK0C6iDKECYH7wWy6C2R
   EylMcqaMP3uCIrzxpFUYvyQRihYdq4ysWU+Qu41VdEYiE1TDwEK1JJUM8
   3fG2NyaJCHpf0s9UnRU+aF5cBy0j0Ii5wAT3MNMUh7aT3HvySf+wlCSzn
   nGiNcHlwLzZdtIy+GCAwIaJLpIpWnQsEpA4SkSVXW2Ht0uR2/3AUTB4NJ
   w==;
X-CSE-ConnectionGUID: LQeB58KDRCm6Xl3QWJlCGg==
X-CSE-MsgGUID: 4SY6msfRSnSQsupdn9v5cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85360411"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85360411"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 13:47:29 -0700
X-CSE-ConnectionGUID: sxXeixC4TC2ojCCZ4reTrg==
X-CSE-MsgGUID: bcoEZQdmSUyIEIO5vwBQdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="258247698"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 13:47:28 -0700
Message-ID: <e0862d9b-a1b5-4f99-bcd5-42f23b368a7c@intel.com>
Date: Fri, 24 Jul 2026 15:47:27 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in mediated
 vPMU
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Andi Kleen <ak@linux.intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-6-zide.chen@intel.com>
 <CALMp9eQv3Z8w2UoxDFMyb-zpSAD7RpL6Bzc9kfk=oGpDF7VySA@mail.gmail.com>
 <6fa18abe-4cb0-42e5-88f6-880a9ecaf769@intel.com>
 <CALMp9eSYcAoKR+ZiSe2R1-Oq1SAEfHJrHSXKzSvvyzcZUMTdHQ@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eSYcAoKR+ZiSe2R1-Oq1SAEfHJrHSXKzSvvyzcZUMTdHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/23/2026 10:15 PM, Jim Mattson wrote:
> On Thu, Jul 23, 2026 at 4:44 PM Chen, Zide <zide.chen@intel.com> wrote:
>> The SDM guidance that "fixed counter 3 must be restored before
>> PERF_METRICS" appears to apply only to a running PMU, which is not the
>> case here.
> 
> That's not my reading of the SDM. There are three bullet points about
> save/restore at the end of volume 3, section 22.3.9.3:
> 
> * PERF_METRICS and fixed-function performance-monitoring counter 3
> should be saved and restored together.
> * To ensure that PERF_METRICS and fixed-function
> performance-monitoring counter 3 remain synchronized,
> both should be disabled during both save and restore. Software should
> enable/disable them atomically, with a
> single write to IA32_PERF_GLOBAL_CTRL to set/clear both
> EN_PERF_METRICS[bit 48] and
> EN_FIXED_CTR3[bit 35].
> * On state restore, fixed-function performance-monitoring counter 3
> must be restored before PERF_METRICS,
> otherwise undefined results may be observed.
> 
> The second bullet contradicts your claim above.

Thanks for pointing this out. I followed up with an internal ucode
expert, and my earlier explanation was incorrect.

The ordering requirement is not dependent on whether the PMU is enabled.
The relevant recalculation happens on the WRMSR itself, so the SDM
guidance to restore fixed counter 3 before PERF_METRICS still applies
even when counting is disabled.

That said, for the code path being discussed, both PERF_METRICS and
fixed counter 3 are written with 0. I was advised that this specific
all-zero case still converges to the intended hardware state regardless
of write order, so the write ordering here does not affect the final result.

Sorry for the confusion, and thanks for the correction.
