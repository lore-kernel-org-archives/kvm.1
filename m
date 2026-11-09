Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267908;
	b=QgkU+13TkAznI5ZJ/ElJKitOkRhSP1aFb8uLm7IXzQGP+PiW1nJCJvzc5VHp+CKC/4xQ
	 eYMsA05t/h3iLEmc65SF2zNfvJ5K5ofyesW1ZfL2zvtfpkEbnExYox3S0u+eVhPZHEvGv
	 anS7HsA8R82PNqaBkLtXuLsi1cL3MdUiRzTjL/vps8MvoUtcrx2alrEDnX3/iNw9I/nZ9
	 PZHdUp6oIQPPz16DLzdreH9UATn7OKuq/bTsLGGKIfprr3vIrN3Ub7ouL2RmPcYQypqtt
	 UG6cKteg7GKk5SiM4LQTCi+PrTZnN/CNz/T0VTpj3x6qAfcKq9mhICHv+v7QbBBH2Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267908;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ARFzZMYbi8INs9UqTEW+/SstEKOn1k1E9h0yDC2zdqg=;
	b=OILCceh8PgcTaD+HD2rX0x9ykarhLPGaJqHWYD9CshIeWE6VBKe2g45RPLXpW4qHVcN5
	 cIwbPeSQxnkLk4We/pb17X0JzP02mflhxoVnoIvUq38x+73ZB+4oIlewwdjNqm4juilv9
	 3+LTGinEz6LBh4GzECAXcgnN1dtz7Pgx75JjRcrakCaNKqafgETEEsDUBfT6LU1YmMUOh
	 YPuQ1/bY9pB4oWmQ++OXuNiPDkI6hTG1361fsnhk9PM700m/r1CV4P+RmcuaoXPHXSuB4
	 seg1D9lWlNQ0YV+k7pd1xYNxtIy1usPFRQB/SxFPM5g7g2ublgBzKRYUT5y8WwwEPcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HUfB4O0A;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36375606A31C;
	Mon,  9 Nov 2026 23:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36375606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HUfB4O0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794267901; x=1825803901;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=P7pSRE/Bdy3ii9bQ2nejb/HYjJ8HUx8CzOOf5E5L+p0=;
  b=HUfB4O0AROHYJqXn5XPm+aOS6bluStG6zzy4eurRjv/z8i3omz/z2Njz
   frucyEF9tO0xHEpffmMNCvHGcne/L23FKtmUImaxYYH3oas3VV6Vgn1z5
   VWWksnbXcsiRbHCiUtKzVc7VtdLu39hBwJV5l4nTgibyBXdnmvigE0HMm
   Cjjptui0p/B6gWH/J5alB8vkhxGPu92l0/JLmdmildXdgxPHhfnf52B1X
   E4YqjjrF/8TlO3V2rDns9PW7a83j6JCwoM7ku0NVN6vPD7i53vgxlKFt+
   JJYwKOXyWRa51SkHbzfgTHWy9kkYOuf+kiZnUIXZs1nR4aQ7B2rwZM89T
   w==;
X-CSE-ConnectionGUID: 3FVg3yfDRB+t9OUvlqCIZw==
X-CSE-MsgGUID: EkyDXQjGSiW9tDSn6spTRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2890291"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2890291"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:45:00 -0800
X-CSE-ConnectionGUID: A+8GozaLQV+NoWRR/jVRAg==
X-CSE-MsgGUID: oD9iay6cQ4yk/Go6KrnHUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7986194"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:44:59 -0800
Message-ID: <6afef7f3-4b34-4598-8dab-98611aa0a6c7@intel.com>
Date: Mon, 9 Nov 2026 17:44:57 -0600
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
From: "Chen, Zide" <zide.chen@intel.com>
Subject: Re: [PATCH v3 11/18] KVM: x86/pmu: Emulate
 IA32_PERF_GLOBAL_STATUS_SET MSR
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-12-zide.chen@intel.com> <au44SIwBF52nsIkk@google.com>
Content-Language: en-US
In-Reply-To: <au44SIwBF52nsIkk@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/2026 2:35 PM, Yosry Ahmed wrote:
> On Thu, Nov 05, 2026 at 06:39:20PM -0700, Zide Chen wrote:
>> Intel PerfMon v4 introduces IA32_PERF_GLOBAL_STATUS_SET (0x391) to
>> allow software to set individual bits in the global status MSR. Reads
>> of IA32_PERF_GLOBAL_STATUS_SET always return zero.
>>
>> IA32_PERF_GLOBAL_STATUS_SET is not part of the VM state, so it doesn't
>> need to be advertised to userspace, nor saved and restored during live
>> migration.
>>
>> Always intercept IA32_PERF_GLOBAL_STATUS_SET to prevent the guest from
>> modifying status bits that are not virtualized by KVM.
>>
>> Bit 63 (CondChgd) stays unreserved in pmu->global_status_rsvd to
>> architecturally allow the guest to write this bit on STATUS_RESET (0x390)
>> to clear it, and allow userspace to set it on GLOBAL_STATUS (0x38E).
>>
>> However, bit 63 is architecturally reserved in STATUS_SET per the SDM.
>> Reject writes to bit 63, injecting #GP for guest writes. While older
>> processors had silicon errata that accepted writes without #GP (e.g.
>> SKX95), strictly enforce the architectural specification for
>> deterministic behavior across migrations.
>>
>> Platform-specific EDS clarifies that CondChgd indicates a change to
>> IA32_MISC_ENABLE[7], which KVM intercepts and keeps strictly read-only
>> for guests. This guarantees hardware will never assert CondChgd during
>> guest execution.
>>
>> Thus, the architectural asymmetry among these three MSRs is safe; being
>> unable to restore bit 63 to hardware via STATUS_SET is benign because
>> the guest will never legitimately observe CondChgd. Filter it out
>> defensively before writing to hardware in intel_mediated_pmu_load().
>>
>> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v3:
>> - Split from combined v2 patch into standalone GLOBAL_STATUS_SET patch.
>> - Always intercept IA32_PERF_GLOBAL_STATUS_SET to prevent passthrough of
>>   unvirtualized status bits. (Jim)
>> - Reject writing bit 63 (CondChgd) to IA32_PERF_GLOBAL_STATUS_SET. (Jim)
>> - Filter out bit 63 before writing to hardware in intel_mediated_pmu_load().
>> - Move validation for MSR_CORE_PERF_GLOBAL_STATUS_SET to pmu_intel.c rather
>>   than common pmu.c to avoid exposing the Intel MSR on AMD.
>>
>> v2:
>> - Add the missing vmcs02 updates for these two MSRs.
>> - Change "> 3" to ">= 4" to make the "v4-gated" more obvious and match
>>   the existing code style.
>> ---
>>  arch/x86/kvm/pmu.c           | 13 +++++++++++++
>>  arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++++++--
>>  2 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 27d6a9169821..2cb5bccc7044 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -855,6 +855,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
>>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>>  		msr_info->data = 0;
>>  		break;
>>  	default:
>> @@ -921,6 +922,18 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  		if (!msr_info->host_initiated)
>>  			pmu->global_status &= ~data;
>>  		break;
>> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>> +		/*
>> +		 * Bit 63 (CondChgd) is architecturally reserved in STATUS_SET.
>> +		 * Older CPUs errantly accepted writes without #GP (e.g. SKX95),
>> +		 * but KVM strictly enforces the architectural spec to ensure
>> +		 * consistent behavior across migrations.
>> +		 */
>> +		if (data & (pmu->global_status_rsvd | GLOBAL_STATUS_COND_CHG))
>> +			return 1;
> 
> Is it intentional to disallow userspace from writing
> GLOBAL_STATUS_COND_CHG through MSR_CORE_PERF_GLOBAL_STATUS_SET, even tho
> it's allowed through MSR_CORE_PERF_GLOBAL_STATUS?

Yes, this is intentionally, since bit 63 is architecturally reserved in
MSR 0x391.

> 
>> +		if (!msr_info->host_initiated)
>> +			pmu->global_status |= data;
>> +		break;
>>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>>  		if (!msr_info->host_initiated)
>>  			pmu->global_status |= data & ~pmu->global_status_rsvd;
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index ce668ea08da5..e81a3f8b9b02 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -197,6 +197,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>>  		return kvm_pmu_has_perf_global_ctrl(pmu);
>> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>> +		return pmu->version >= 4;
>>  	case MSR_IA32_PEBS_ENABLE:
>>  		ret = vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PEBS_FORMAT;
>>  		break;
>> @@ -827,8 +829,16 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
>>  	toggle = pmu->global_status ^ global_status;
>>  	if (global_status & toggle)
>>  		wrmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, global_status & toggle);
>> -	if (pmu->global_status & toggle)
>> -		wrmsrq(MSR_CORE_PERF_GLOBAL_STATUS_SET, pmu->global_status & toggle);
>> +
>> +	/*
>> +	 * CondChgd is architecturally reserved in GLOBAL_STATUS_SET. Unless
>> +	 * set by malicious userspace, this bit should never be set in
>> +	 * pmu->global_status; filter it out defensively to protect against
>> +	 * a host #GP.
> 
> IIUC, this will ignore bit 63 completely when written by userspace,
> should KVM be doing this?

Yes, if userspace writes GLOBAL_STATUS (0x38E) with bit 63 set, it would
be silently dropped here before writing to hardware.

Because KVM always intercepts IA32_MISC_ENABLE, bit 63 is not supposed
to be set for guest GLOBAL_STATUS.

The case you mention should not happen in reality, but theoretically it
exists and this sounds not clean enough.

I'm thinking of doing it differently: similar to the CTR_Frz bit, KVM
can keep bit 63 CondChgd reserved, and provide a backdoor to allow
writing this bit to 0x390:

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 393068093757..1429da7148bd 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -925,9 +925,11 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct
msr_data *msr_info)
        case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
-               if (data & pmu->global_status_rsvd)
+               if (data & (pmu->global_status_rsvd &
~GLOBAL_STATUS_COND_CHG))
                        return 1;
                fallthrough;
        case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
@@ -935,13 +937,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct
msr_data *msr_info)
                        pmu->global_status &= ~data;
                break;
        case MSR_CORE_PERF_GLOBAL_STATUS_SET:
-               if (data & (pmu->global_status_rsvd |
GLOBAL_STATUS_COND_CHG))
+               if (data & pmu->global_status_rsvd)
                        return 1;
                if (!msr_info->host_initiated)
                        pmu->global_status |= data;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 117ff54d4aea..0f426634373e 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -652,7 +652,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
        pmu->global_ctrl_rsvd = counter_rsvd;

        pmu->global_status_rsvd = pmu->global_ctrl_rsvd
-                       & ~(GLOBAL_STATUS_BUFFER_OVF |
GLOBAL_STATUS_COND_CHG);
+                       & ~GLOBAL_STATUS_BUFFER_OVF;
        if (vmx_pt_mode_is_host_guest())
                pmu->global_status_rsvd &= ~GLOBAL_STATUS_TRACE_TOPAPMI;

@@ -892,13 +892,7 @@ static void intel_mediated_pmu_load(struct kvm_vcpu
*vcpu)
        if (global_status & toggle)
                wrmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, global_status &
toggle);

-       /*
-        * CondChgd is architecturally reserved in GLOBAL_STATUS_SET. Unless
-        * set by malicious userspace, this bit should never be set in
-        * pmu->global_status; filter it out defensively to protect against
-        * a host #GP.
-        */
-       set_bits = (pmu->global_status & toggle) & ~GLOBAL_STATUS_COND_CHG;
+       set_bits = pmu->global_status & toggle;
        if (set_bits)
                wrmsrq(MSR_CORE_PERF_GLOBAL_STATUS_SET, set_bits);

>> +	 */
>> +	if ((pmu->global_status & toggle) & ~GLOBAL_STATUS_COND_CHG)
> 
> Maybe store this in a variable as it's used in wrmsrq() as well?

Yes, thought about it. One more variable vs cleaner code. Will do.

> 
>> +		wrmsrq(MSR_CORE_PERF_GLOBAL_STATUS_SET,
>> +		       (pmu->global_status & toggle) & ~GLOBAL_STATUS_COND_CHG);
>>  
>>  	wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl_hw);
>>  }
>> -- 
>> 2.56.0
>>

