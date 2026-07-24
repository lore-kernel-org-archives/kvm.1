Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D9342146;
	Fri, 24 Jul 2026 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784934007; cv=none; b=cfbU6rxbvYvOALoxxRn0mywub/kkvEcIb/CMzW/zpH2WDH0f3rgVBERYMe5xHQO8MDUb9EPO6Sp5AXmFha2AHBpZE2uotk9wkP7I8Oj367SOpKCoODXpaRdWCY5bXtvd8gARVKFBFta+xapVTC0qG9gcm/qWdn+LhHng/Nnrme0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784934007; c=relaxed/simple;
	bh=jF0M6OY/xJkOP+SAE1MPKL7PgD22vv2kJTpPyV4hfzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=en12Yuo5+tomZ6l/lGnGbV9jCkSyhwPXD4mh+4QKRxbmtAhE56EnvkbTlxNxJYpyvnj9GSexwuGfwIyx6DS5XTcXBhXUJeuetr1sKsLXul/xKRjuQj3KTozzsZk91bfOWHfz1DRTaMFWNbFmih+TQVINkAQrFgjkZDxfKZH3Eq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jaz10faB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jaz10faB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784934003; x=1816470003;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jF0M6OY/xJkOP+SAE1MPKL7PgD22vv2kJTpPyV4hfzw=;
  b=Jaz10faBnaME27uIS5TWctH09tnUbL25NF/4hh22LvggQW6stf6Rk1PR
   dLmDwBOs0V7vHodCkQezZuPpqKGkDZlkw3T/o6eLT0VBzQ5whY4EodgQr
   QY8ovJC0OSjTTwVSJwUbI75qcDdLHt50Q+spZ9oYDxWwPvPqXjVecarUi
   BkoSzojbZ2Ae6zoG23CuCmpEBbXUIlm6cBw+o5ktsbrOfCymDOp4cyIWg
   EG1KTlMwgWWkSKSyxYn63IZ/+r9clYXJO+jOQIDE5UrClUApZ2UIqvEAu
   B0Vf2hn20XpH5CJ4vS/fcrt6xQR48JpVo20DOy8CK/SlBZE04OoPXZ756
   Q==;
X-CSE-ConnectionGUID: KIIe03Q3R0u4JOW+zIwbQA==
X-CSE-MsgGUID: Hk/l8V+GQzKG9QPHmwc29Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85456543"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85456543"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 16:00:01 -0700
X-CSE-ConnectionGUID: MNS+SZCOSn+WpptrYHg3gQ==
X-CSE-MsgGUID: aQw/ShnzRsKSNW0wMP1Sjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="262622555"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 16:00:00 -0700
Message-ID: <98d89bcd-d058-4ede-a94b-65c1da1d7a75@intel.com>
Date: Fri, 24 Jul 2026 17:59:59 -0500
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
 <e0862d9b-a1b5-4f99-bcd5-42f23b368a7c@intel.com>
 <CALMp9eR5nDOgJoLh14Q_t_w2Ea25QP-74DdgJ93J2=CAS3O8Gw@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eR5nDOgJoLh14Q_t_w2Ea25QP-74DdgJ93J2=CAS3O8Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/24/2026 4:37 PM, Jim Mattson wrote:
> On Fri, Jul 24, 2026 at 1:47 PM Chen, Zide <zide.chen@intel.com> wrote:
>>
>>
>>
>> On 7/23/2026 10:15 PM, Jim Mattson wrote:
>>> On Thu, Jul 23, 2026 at 4:44 PM Chen, Zide <zide.chen@intel.com> wrote:
>>>> The SDM guidance that "fixed counter 3 must be restored before
>>>> PERF_METRICS" appears to apply only to a running PMU, which is not the
>>>> case here.
>>>
>>> That's not my reading of the SDM. There are three bullet points about
>>> save/restore at the end of volume 3, section 22.3.9.3:
>>>
>>> * PERF_METRICS and fixed-function performance-monitoring counter 3
>>> should be saved and restored together.
>>> * To ensure that PERF_METRICS and fixed-function
>>> performance-monitoring counter 3 remain synchronized,
>>> both should be disabled during both save and restore. Software should
>>> enable/disable them atomically, with a
>>> single write to IA32_PERF_GLOBAL_CTRL to set/clear both
>>> EN_PERF_METRICS[bit 48] and
>>> EN_FIXED_CTR3[bit 35].
>>> * On state restore, fixed-function performance-monitoring counter 3
>>> must be restored before PERF_METRICS,
>>> otherwise undefined results may be observed.
>>>
>>> The second bullet contradicts your claim above.
>>
>> Thanks for pointing this out. I followed up with an internal ucode
>> expert, and my earlier explanation was incorrect.
>>
>> The ordering requirement is not dependent on whether the PMU is enabled.
>> The relevant recalculation happens on the WRMSR itself, so the SDM
>> guidance to restore fixed counter 3 before PERF_METRICS still applies
>> even when counting is disabled.
>>
>> That said, for the code path being discussed, both PERF_METRICS and
>> fixed counter 3 are written with 0. I was advised that this specific
>> all-zero case still converges to the intended hardware state regardless
>> of write order, so the write ordering here does not affect the final result.
>>
>> Sorry for the confusion, and thanks for the correction.
> 
> At the very least, the reliance on an undocumented exception to the
> requirement stated in the SDM warrants an explicit comment.

Yes, will do.
