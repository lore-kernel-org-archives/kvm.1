Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999800;
	b=zDmlfzGTMDDok3EmamcdrgbI+VXzgJrBT80UH8iSOt8XixzfPO7xxbV22ekfj93SgCZt
	 Av6hobhi+jdp21JpS+kcAm8EGHu3Gs2vg2KeNfKneaiEJUU9d7zxK8c5Q8AM8UJgv8eJR
	 ibCcITN7wX3gPs+iAXj/UuoWUBiB7SPNIpuhMPvXTs/HNE19faKm+sU5MD5Hlu32GP74M
	 HA3KH5RazyVjqblafZ9Kv4yAj9axcaThwwBSfy979qZrngoWLRa3XAmE4RinFHMfNw6Yk
	 oxN1Pcboa/kUrP0pTIDdCVkTNCyLUVzeLWtNrTqSwJ7q6N61QxdXuG34Ee3y27CKKqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999800;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=O4oT9WjsnKSKstVjC6xepPmsJFnWbX3Rrq68PpATN1k=;
	b=rL43Nf/rWfiTzcHB9b4KYMecEbSLGE2veq4rtzptFdsx659pWoMyupSoyUEnymq6K4Ko
	 aXf25gIJB71Z+a8vX5+zD+8ow1kS7jfNHwAJnF4yjq/aJnmAfa5vfVlIDA6l3rCXoPr10
	 n+/FB8JGk/B+YEgXg1R9UdoX//KvzM4D0+FV+MEdHda3C2/A7kKIX/kh/wOE+c3t056uz
	 HvupIldwDN/TC38ngNw01IVUZzcnrfG4ZqoMaGT1bkKlP3Tx2+bglUB+MA3uEwF4MVVbb
	 wop/KN6dLP48dVQMn4+Bhc80rifggOq09P8xyDjq91a/H5W0r/VA3TsbRphUvRvgSPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hhjerrYN;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243AE606A32C;
	Fri,  6 Nov 2026 21:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 243AE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hhjerrYN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793999798; x=1825535798;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dRDaSIdAHmc9ZFp2pefcjBDq4ERtrnsmqsxEG4QiqD0=;
  b=hhjerrYN+s4q3NEPRyOmieGdo3Jdkozm5X414/Obi/tVW3TNHcrozqTL
   1R1fLtp9fNAJrgtq0ZXmpVXilbzhAdPuDMFm2lIRK3wTRVq/HA5PQWdJp
   xoBf2hN3E5QzKilPDLCTEVMsP0A7iYtxiwxs8BHh6REWgLv02bAGCap1o
   eu3Hf3HFalEcc3rOMo7hdq/BoEj06IK8AJno8p/91xyqQdI//sjSsPFK6
   iHztnH8TYwjrEqftcBzjSIsePY1WgQ/rP+17igSLV65+nagETr1bS99HQ
   Pa3dWr3jsw/1p1N1OpYP11A8Tpibb8GLXu188rD26U7xEgfx+mOEMTuum
   Q==;
X-CSE-ConnectionGUID: IkRbucG4T5GxCkLa4MI/Hg==
X-CSE-MsgGUID: Fht4RAN/TuyCRXFkVId/RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2921852"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2921852"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:16:37 -0800
X-CSE-ConnectionGUID: zreB1KstRSWymL3NIunppg==
X-CSE-MsgGUID: BxoBiPwHQe6ZVj1fLHo4og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7245091"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:16:36 -0800
Message-ID: <49798d13-f426-4834-9996-5d8f1f7dad4c@intel.com>
Date: Fri, 6 Nov 2026 15:16:35 -0600
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
Subject: Re: [PATCH v3 03/18] KVM: x86/pmu: Rename reserved_bits to
 eventsel_rsvd in kvm_pmu
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-4-zide.chen@intel.com> <au4dVD2cZbvoqEa4@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <au4dVD2cZbvoqEa4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>> @@ -214,9 +214,15 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>>  
>>  	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
>>  
>> -	pmu->reserved_bits = 0xfffffff000280000ull;
>> +	/*
>> +	 * AMD PerfEvtSeln registers do not support PinControl, and KVM does
>> +	 * not emulate AnyThread due to cross-VM information leakage on SMT
>> +	 * cores (as on the Intel side).
>> +	 */
>> +	pmu->eventsel_rsvd = GENMASK_ULL(63, 36) | ARCH_PERFMON_EVENTSEL_PIN_CONTROL |
>> +			     ARCH_PERFMON_EVENTSEL_ANY;
> 
> It's probably better if we diff against the generic pmu->eventsel_rsvd
> set by kvm_pmu_refresh(), and explicitly add/remove bits as needed here,
> like the Intel code. Then we also avoid re-iterating the AnyThread
> rationale here.
> 
> What do you think?


Yes, I think this is better. How about this:

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index fb5a298244ec..15d4b94826f8 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -213,12 +213,11 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
        pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;

/*
-      * AMD PerfEvtSeln registers do not support PinControl, and KVM does
-        * not emulate AnyThread due to cross-VM information leakage on SMT
-        * cores (as on the Intel side).
+        * AMD PerfEvtSeln registers do not support PinControl, but support
+        * a 12-bit EventSelect (bits 35:32 in addition to 7:0).
         */
-       pmu->eventsel_rsvd = GENMASK_ULL(63, 36) |
ARCH_PERFMON_EVENTSEL_PIN_CONTROL |
-                            ARCH_PERFMON_EVENTSEL_ANY;
+       pmu->eventsel_rsvd |= ARCH_PERFMON_EVENTSEL_PIN_CONTROL;
+       pmu->eventsel_rsvd &= ~AMD64_EVENTSEL_EVENT;
        if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) &&
kvm_vcpu_has_mediated_pmu(vcpu))
                pmu->eventsel_rsvd &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;

> 
> 
>>  	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) && kvm_vcpu_has_mediated_pmu(vcpu))
>> -		pmu->reserved_bits &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
>> +		pmu->eventsel_rsvd &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;

