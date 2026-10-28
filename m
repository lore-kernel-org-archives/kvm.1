Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208281;
	b=sTdCt2wrWMg+u5JmN83rW6Ih0p0++1/z9xpbczQ/KPcWFjlPXpL5zAxnCiOzQnyzMCQ/
	 BIFr6yz5qnfPw/C6WAIAdY9+Re6f1ewuDOgYvdgba5MAn+oWrU3JUf2kWeILajfE4ihgC
	 FNuBC4IoohrHekMeoGGi3WiaI6wl14qeFlfEXBgItxfUWQKTcGCQRAyKCXMfKUSQbuqjd
	 1YMCZuYtqceIYpTHwDcn+kD5aVeU/ShDkigIaFwt5R29rJ6zZmDMftdiJyJzpVkuBKgXf
	 s8bqKCzJgY1Rjnp/l+q3S7TRqigXl/u4rf9KxBiCKLpnWMr5SUkKbfJrOc7L+CiFFxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208281;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=RA66YBmGNKgUK8XzlgiU2huD/uB0ixeOMHaKer0sa7U=;
	b=LFDMtCL1c15nFoRsaYJWcFgEKIqagqQz8EiJ5aIFkBT5PMbXew/UucV2Bh3y/HM4TFST
	 XeHaTn8TcnAghhy3UJLO9k0IsrjGGjaP4uT7s8kwxgCfcb9Ae1HTTz+sLnt43kNje7BdR
	 ixK1Lv6AVtv0yvA6uYmJVEX/qUMWIP5hQII6EZ3KN1I2nSoRvTuJEv4Ab3RxHgTElctLL
	 dENe0HZYfQVjcebdLGC3mLND4esAu3cCgmRzmB2fhmfP/8ojMJOi99GSdxMsMeqpKnCxJ
	 bl3rNJoJRjhngdJb8yQIUUXn88YgQgaGjIMzHnn8U5Iq/D/bW0RNnsiVjQnuYc+2tfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KIckdC4T;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7433606A31A;
	Wed, 28 Oct 2026 17:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7433606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KIckdC4T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793208280; x=1824744280;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UzMJ9Snt5Khu9cExhTaooZ2u6408LhF70IpYcfPgfuY=;
  b=KIckdC4TDcxUmwlA5bwxp1r0EyR1i7HoAFMpdbqk0GmfjU/q3NAnMTEk
   S5J/Z/wrjZnN2r08NuRdelkBODDPbBU3bBU1ne+QMqENAUe2Pi1jJr+Vo
   NIG6FUqj9sJGZ1XlpaRITtAVL+GkJUa0aHBB3g1tmxnn4TOcDeVyam2sc
   +/NhCtWvQ33Xb/kwZLGxPlzqd0jDOd3mQE4NptkGVUQs1lCWyrBXTc7bv
   zdWKoLAEhSZeWTspvzNf/fUPe1XpPLcxYftV6kWsRwEGnbLYQQF0/nUxK
   9DCIxOvM8gb/l2WYjlZ5vnz81nYqPUGL45CltrSnb3rwhat7ZeFcjGiF+
   g==;
X-CSE-ConnectionGUID: Ca6961A5S723sWk5IrNaMA==
X-CSE-MsgGUID: laBjqMxeRHmcaOArH6g6Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1953565"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1953565"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 10:24:39 -0700
X-CSE-ConnectionGUID: 6zyU+4oHQomjzuGykKxWlg==
X-CSE-MsgGUID: ed5JSSllRXGZmmNNDq/aRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="4882940"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 10:24:38 -0700
Message-ID: <074a327f-5560-43d4-bb7f-960f5549ced6@intel.com>
Date: Wed, 28 Oct 2026 12:24:37 -0500
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] KVM: x86/pmu: Add PMC bitmap accessor helpers
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-6-zide.chen@intel.com>
 <CALMp9eQ4uBX69=jZSx83t1xeO-3Jd0qsLOV=9ok+qGB+UnfRSg@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eQ4uBX69=jZSx83t1xeO-3Jd0qsLOV=9ok+qGB+UnfRSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/28/2026 9:32 AM, Jim Mattson wrote:
> On Thu, Aug 27, 2026 at 3:48 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> pmu->nr_arch_{gp,fixed}_counters is not able to represent that a PMU
>> may include non-contiguous GP or fixed counters.
>>
>> pmu->pmc_exists already holds a bitmap indicating both fixed and
>> general-purpose counters, and loops over valid counters can be done via
>> pmu->pmc_exists alone. Extend it to a union so that the u64 alias is
>> available for convenient mask arithmetic operations.
>>
>> Add the necessary helpers to prepare for bitmap-based PMC counter
>> implementation.
>>
>> No functional change intended.
>>
>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v2:
>> - Rename kvm_{gp,fixed}_pmc_supported() to kvm_is_{gp,fixed}_pmc_supported()
>>   and simplify them by removing the temporary bitmap. (Sean)
>> - Split kvm_for_each_set_pmc_idx() to kvm_for_each_gp_counter()
>>   and kvm_for_each_fixed_counter(). (Sean)
>> ---
>>  arch/x86/include/asm/kvm_host.h |  5 +++-
>>  arch/x86/kvm/pmu.h              | 53 +++++++++++++++++++++++++++++----
>>  2 files changed, 51 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 90d80483df7f..49a8a2e9cee0 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -594,7 +594,10 @@ struct kvm_pmu {
>>                 DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
>>                 atomic64_t __reprogram_pmi;
>>         };
>> -       DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
>> +       union {
>> +               DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
>> +               u64 pmc_exists64;
>> +       };
> 
> Is it worth adding:
> 
> BUILD_BUG_ON(sizeof(pmu->pmc_exists) != sizeof(pmu->pmc_exists64));

Good idea! I can add this:

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 1dac6ae2cbc2..41eaefeea429 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1051,6 +1051,8 @@ void kvm_pmu_init(struct kvm_vcpu *vcpu)
 {
        struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);

+       BUILD_BUG_ON(sizeof(pmu->pmc_exists) != sizeof(pmu->pmc_exists64));
+
        memset(pmu, 0, sizeof(*pmu));
        kvm_pmu_call(init)(vcpu);
 }

> 
> Either way,
> 
> Reviewed-by: Jim Mattson <jmattson@google.com>

