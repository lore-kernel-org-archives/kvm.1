Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71873BED61;
	Thu, 23 Jul 2026 23:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784849113; cv=none; b=ljR0mZgWZqHHjsTu5uyA1KJT0hO1q/bVVrgFsE/sKyuQeFJi2cs+pcuXVT3aEHoZFjZTg+xANTaEkRaMqG6ZxPvHO+qUBd4PPONq+Cmg3Y81MOvj2k8ZsJ/QovDCC1e4R3GJbcfPjXDuxFlsXs777K/FdpNJv/gpgoOtBAf/S+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784849113; c=relaxed/simple;
	bh=lTIUYXMK6wNGlxlf06XlaoczPhBoBm/Ryt1jGVb6pog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0Xp8KQdwoNFpnppaL58Yl1oyVcxeJKtwjLoO/fRBoc4ygfVYG7BTZt2aFxYYdKl2CJ0JIBGsIafb7B4uVNr2wwQfxFQjgfYhQNvIkfKHjTdlGBvJyDXO3UaoQxolYby3zPTGRMH7U8wd/XY7R8dEZmiWRiYFn8lMKIx7OrDtOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnFifDMJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnFifDMJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784849112; x=1816385112;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lTIUYXMK6wNGlxlf06XlaoczPhBoBm/Ryt1jGVb6pog=;
  b=bnFifDMJf4Kgy+JV86ajOZgXQgAuryHtA9Y61t/gdyOpDXiYUAQ2U4bY
   qtVUR8Ov7+pibB8JWGZOIk4eBPGHsH5rGBPfTSs7Tiv3aj6BH7zwXN+rS
   rhPCih/I3KdVbMZxuOFGlovy54/6/eeUvDdwwWoYO2n1njCHgo9bdb/42
   SVo7VuETlS8NfF4xZP/fq0r9AJKm8x73NUqz1lY/PtRB8j8lbod261M/I
   AhKbxMNNkIo6jXEJPZCzDMx9hxt6Z3ALWbtPUR1hn9rtAeu8OIvElW2p/
   XrdxXWsjJEotMDXqh9vzuWnPuPleed0wcumVBB5ymgv7aCejtDy75us7n
   A==;
X-CSE-ConnectionGUID: G/4g3epFSaSKo5ux5LkkCA==
X-CSE-MsgGUID: LWXncTLCT22TdQr1Iwxpgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85387666"
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="85387666"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 16:25:11 -0700
X-CSE-ConnectionGUID: o55pV26lQbeO/vQJge/HfA==
X-CSE-MsgGUID: nQHG9UtzQ4CEWeqkyrb7XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="258622373"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 16:25:10 -0700
Message-ID: <e7dd989d-c83f-45b0-9501-7e7a5bdd9fff@intel.com>
Date: Thu, 23 Jul 2026 18:25:09 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] KVM: x86/pmu: Advertise PerfMon version 5 on Intel
 hosts
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
 <20260707183405.15571-15-zide.chen@intel.com>
 <CALMp9eRWo+FA-qGiB3Bf-UQOK7hV4-pN62SjFgR5JYLkaMEcmQ@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eRWo+FA-qGiB3Bf-UQOK7hV4-pN62SjFgR5JYLkaMEcmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/23/2026 4:53 PM, Jim Mattson wrote:
> On Tue, Jul 7, 2026 at 11:44 AM Zide Chen <zide.chen@intel.com> wrote:
>>
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> KVM currently caps the guest PerfMon version at 2 for all Intel
>> platforms. Now that KVM emulates the basic architectural PMU features
>> introduced in PerfMon versions 3 through 5, raise the guest PerfMon
>> version to 5.  Features that require additional emulation support, e.g.
>> architectural LBR will be enabled separately.
>>
>> When enable_mediated_pmu is disabled or in the non-Intel paths, KVM
>> retains the existing cap of version 2.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/kvm/pmu.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 7d58f7a2a2db..83332e8ed1e0 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -176,7 +176,18 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
>>         }
>>
>>         memcpy(&kvm_pmu_cap, &kvm_host_pmu, sizeof(kvm_host_pmu));
>> -       kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
>> +
>> +       /*
>> +        * AnyThread counting is not supported by KVM due to cross-VM
>> +        * information leakage concerns on SMT cores. Therefore, AnyThread
>> +        * remains unavailable for PerfMon v3/v4 guests, where AnyThread
>> +        * deprecation is not enumerated.
>> +        */
>> +       if (is_intel && enable_mediated_pmu)
>> +               kvm_pmu_cap.version = min(kvm_pmu_cap.version, 5);
> 
> Our internal Sashiko says:
> 
> Does raising the version cap here expose guests with PMU versions 3 or 4 to
> a #GP-induced panic when they attempt to use the AnyThread feature?
> Since AnyThread is architecturally valid in PMU v3 and v4, a guest kernel
> detecting version 3 or 4 will enable AnyThread support. When the guest
> writes to MSR_P6_EVNTSELx with the AnyThread bit (bit 21) set, KVM
> intercepts it.
> Looking at arch/x86/kvm/vmx/pmu_intel.c:intel_pmu_refresh(), KVM includes
> the AnyThread bit in pmu->eventsel_rsvd, only clearing it for version >= 5:
>     if (pmu->version >= 5 && edx.split.anythread_deprecated)
>         pmu->eventsel_rsvd &= ~ARCH_PERFMON_EVENTSEL_ANY;
> Then, in intel_pmu_set_msr(), KVM injects a #GP because the eventsel_rsvd
> check triggers before any silent discard logic:
>     if (data & eventsel_rsvd)
>         return 1;
> Because the guest Linux kernel wrmsr path might lack exception handling for
> this MSR write, could this injected #GP cause an unhandled kernel exception
> and an immediate guest kernel panic?
> 

Currently KVM always injects #GP when the AnyThread bit is set.

kvm_pmu_refresh(): pmu->reserved_bits = 0xffffffff00200000ull;

I understand the concern, but I'm not aware of a better solution for
PMUv3/4. Silently ignoring AnyThread would deviate from the
architectural behavior and, more importantly, may give the guest the
false impression that AnyThread is supported. Supporting AnyThread, on
the other hand, has cross-VM information leakage concerns.

BTW, the comment seems a bit out of place here. It might fit better in
patch 13/15 which is specifically handling AnyThread .

