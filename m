Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271319;
	b=tzgEk7IcKk62ELZbtpfWNsmz87/ZGGaop0J4b4mOEKq7fsOTnKr8nmRhCiAU/EB4YgN1
	 WGQAK2nQH84GYH8wtbK4OpWrq4xPMLLV0jXKNie8fTAB26a32tsMbTpnEHwVWCwxyyr3v
	 DSJ0o3NO3Hw2rKujhfQNcp2c1gkU5tLpqr4xgcweKL8tTAsPYqoS4k8arFsO0LG5WaPz3
	 4Rzw+nTB1KqWlkgKtBDMGMWyQtMSdVB0T7rPesO7SZvsdd7IkoaKhn83x8iYv/J7CY9sa
	 9SnahYNW5r0x/bV5onjsH6OmDe54geiQdtzEvGigjou9tho+RgVC7jaCJTHxO55Qsyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271319;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=KS3CHz1HyXxL41ZbBw00ADRpyBw17oL3axjjjtzyPRU=;
	b=uOq2BZH2TToaqOsZ0R2y7u5xxL/+4orGza825l7PfMA0xPbc9Q+YspYxMGZKONKExt2L
	 3c4JpqxNbyq90ITY+49C4DftRtjDdfEqqv+bIPgu742uMkp7UzpXIgplBQpMaXzRHd9r3
	 Nmyl5CHFBkRg8jdqHWYbl3ysQuAppAPS4NDEcmp3fHrXSH/pcLa0s2InqqSWngNrUBmbJ
	 DTDozEgey70bHUzq++cEzq1x1zLE44YsefEfft2c8LTz3pQwR3I6M04F3SxpFNgx81ij8
	 AKdCQa9RZdNtco3J1akDcnT2g1nodwSfidO/mZtBmRRgIzDuxGfyDjV5lu3aCizcfkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mqAetget;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0976606A321;
	Tue, 10 Nov 2026 00:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0976606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mqAetget
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794271317; x=1825807317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N1lyR087T12zQqlwX36X90Z9WK9rxY4dYwTOOiytRNU=;
  b=mqAetgetIR+iSOkVaFNs/Eh2DPSR5Rippj3Avhnypb0sz0/TtYerULEF
   VFjccJ9AVkLLrPNN/MN2ThyUExtSGInZMg/VS9lWkK7y9hdfSPBXdo1+G
   FWpP5pgd6kenSdoYuJsA8KYld+fClO4Fp0fkkPt0mZyrmRD1lToMfuwef
   9yrNXyXsSHMrGHfBBxiHbq+/FBId9CNLzCywqd54npK+Q0kFQIL6WesCK
   Wa3j0zW6lj16tiQfPLQemOSingd16hIAayKbnRLDg+vMEYELxyJqfAyKT
   /r2S0UbO/8o7NVq3w/bj8ahhyEmErd+Hzf+6zddvNGcnoJIygjrVsbwHT
   A==;
X-CSE-ConnectionGUID: OV8v/b+DS+ugJN0e94g+8A==
X-CSE-MsgGUID: +UxsAg7PR9uX1MiA4d+R5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3043559"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3043559"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 16:41:57 -0800
X-CSE-ConnectionGUID: k4v22akHQpK6aR2ztbSGKw==
X-CSE-MsgGUID: OA4Mi6sfT4e84EpQxTK1Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9787333"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 16:41:56 -0800
Message-ID: <508bc475-2162-4667-a6b8-8fe753042893@intel.com>
Date: Mon, 9 Nov 2026 18:41:55 -0600
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
Subject: Re: [PATCH v3 10/18] KVM: x86/pmu: Document GLOBAL_STATUS_RESET
 passthrough erratum
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-11-zide.chen@intel.com> <au40uLZo3C8a7fdg@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <au40uLZo3C8a7fdg@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/2026 2:14 PM, Yosry Ahmed wrote:
> On Thu, Nov 05, 2026 at 06:39:19PM -0700, Zide Chen wrote:
>> IA32_PERF_GLOBAL_STATUS_RESET, introduced in PerfMon version 4,
>> inherits the MSR address and architecturally defined bits from
>> IA32_PERF_GLOBAL_OVF_CTRL, while providing additional bits to clear
>> new indicators in IA32_PERF_GLOBAL_STATUS.
>>
>> From an emulation perspective, KVM handles it identically to the
>> OVF_CTRL MSR: reads return zero, and intercepted writes are guarded
>> against pmu->global_status_rsvd. No code changes are needed in KVM
>> to emulate this MSR.
>>
>> However, to reduce VM exits, KVM passes through this MSR in mediated
>> PMU mode when GLOBAL_STATUS is also passed through. Consequently,
>> writes to bits that are valid on the host but unvirtualized by KVM
>> will not trigger a #GP (unlike when the MSR is intercepted). Except
>> for the known limitation where host Intel PT in system mode can
>> assert Trace_ToPA_PMI (bit 55), unvirtualized status bits are not set
>> while the guest is running, so clearing them has no negative effects.
>>
>> Document this divergence in errata.rst.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v3:
>> - New patch prompted by Jim and Yosry's review on unvirtualized
>>   status bits.
>> ---
>>  Documentation/virt/kvm/x86/errata.rst | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/virt/kvm/x86/errata.rst b/Documentation/virt/kvm/x86/errata.rst
>> index a9cf0e004651..161ba6d1beb4 100644
>> --- a/Documentation/virt/kvm/x86/errata.rst
>> +++ b/Documentation/virt/kvm/x86/errata.rst
>> @@ -84,4 +84,12 @@ memory.
>>  
>>  Note, this erratum does not affect AMD CPUs, which fully virtualize CR0.CD in
>>  hardware, i.e. put the CPU caches into "no fill" mode when CR0.CD=1, even when
>> -running in the guest.
>> \ No newline at end of file
>> +running in the guest.
>> +
>> +IA32_PERF_GLOBAL_STATUS_RESET
>> +-----------------------------
>> +To reduce VM-exits on performance-critical paths, KVM passes through writes
>> +to IA32_PERF_GLOBAL_STATUS_RESET (0x390) in mediated PMU mode when the guest's
>> +counters match hardware, without injecting #GP on unvirtualized bits.
> 
> Might be worth clarifying that this refers to the number of counters
> matching, not the values in the counters.

Good point. Saying "counters match hardware" can easily be misread as
counter values matching. I'll reword this to "when all hardware counters
are exposed to the guest".

> 
>> +Because the MSR is read-as-zero and write-to-clear, this cannot leak
>> +host information to the guest.
> 
> It can let the guest clear host state tho, but I assume this isn't a
> problem because GLOBAL_STATUS is saved/restored on guest PMU load/put.
> Might be worth clarifying.

I can add "or clobber host state." at the end, and the whole text:

To reduce VM-exits on performance-critical paths, KVM passes through
writes to IA32_PERF_GLOBAL_STATUS_RESET (0x390) in mediated PMU mode
when all hardware counters are exposed to the guest, without injecting
#GP on unvirtualized bits.  Because the MSR is read-as-zero and
write-to-clear, this cannot leak host information or clobber host state.

> 
>> -- 
>> 2.56.0
>>

