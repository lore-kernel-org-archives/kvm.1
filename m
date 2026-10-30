Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380814;
	b=Z7H/d8b7tNCKIFCwKeGHUnDcmybFl6DixZJburlHq1XfmIVIGS6+WPv2fzgES4LGszWX
	 I0m0tJOianiebIwBhlsVm3Xjs1vjxvDkG8UIfBHazAmRszTzv+Ht/BpmJrpegBoD/IjN3
	 krqcfrJPyj4qx4/cTk/JzAiTeLS0i9WgTSzfZSEOJFbTM+1ajn1q1I03Vvk1cxuHNn/vc
	 kYYc+1mmua7u3jdGs1ey1gcfoG5Iic7qQoMWFnl6xZrZGS2RcDBKKNowr+92R0djIus7p
	 J3dKmixqEK4T73dv2ba05YrjsiThpbpf3xUlkDyoDoFIAVcNUb6uRWrFo03UDaiVaCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380814;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=AcVyijD+6yLOeZt0UOcPVnuuFbFqdyuwknD/b0gv2JU=;
	b=UNM+EEJJKJYkj/4VarDb/4xDH4pYY1khRPVbeohU6caQ889d5gz65z2ORfYW1R+UgbyR
	 5HQhXRc/UYSyQxI+3oa8y6nvVgw/dyKYttZpGDBMv304Q3olLi8UJp9xe88lqluhr0ao4
	 hfFfRukKBfhGwQHIKssi+AKdzM4+ndgTV4qqvfsRvRWGhyTk7YFk+2KhUSEsjbwQjsQ/0
	 GH8dcT555teS6b/Q0JObj7WT5BRYIKTeGCoTJnYu86+HjxjyLlJ4Cdj/Gx/AXs2OoJdIM
	 teSip6Fkk4qC1Bi45aRjttwRw0SfwjoO1qCKxioYJF/xMGNi7h8Ln1V9IMtIqshJIeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DiH16WDS;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F339606A31A;
	Fri, 30 Oct 2026 17:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F339606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DiH16WDS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793380813; x=1824916813;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nqQ+D2b3NqIlF/gQ1YTZQUWKoENJnTQBcQkLuHa+snI=;
  b=DiH16WDSA+SglurdRWbPbLYsOD/XdOKcXtrSi601cDasia7lAcVpw7T8
   Y4uqRahd5LHkk5HMoRSdLNRKSX5THXt3kGt70Ot949mlAY7SdnBuZaVX1
   1hVDLhSc3y5Ao9HyAbjR5R6S8/C9T1qJLJFfv6EqrNRD08PWiHd94acQ5
   8DWTnKSMSVMgXalRZWIfGY9hCDtqvZC8bqG0DwFd2HHF04knP4VqH313v
   3I+IGkgetgEKnGCL7bEKQul9/ERU6KkWczkKjLlLa3DZTyJDBzFL30Ms5
   r54soU2XBzThHh+sN9dXFhi7BJM7oEuRwGxksc4YdRqj+dwSiFP0Fh0Ki
   g==;
X-CSE-ConnectionGUID: 2nC9O/YHQ96j68IK8pkXrQ==
X-CSE-MsgGUID: VRW6e2ASRCiN13XTNGlgQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2064175"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2064175"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:20:12 -0700
X-CSE-ConnectionGUID: Y7ZuUq3XS1mkbk4WNjuOUw==
X-CSE-MsgGUID: LWkz3+GhRj6n7DvpMfdMog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5571160"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:20:11 -0700
Message-ID: <dc0e6998-6b8c-4b0c-a04e-b6af0a1cf653@intel.com>
Date: Fri, 30 Oct 2026 12:20:10 -0500
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
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-12-zide.chen@intel.com>
 <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com>
 <b3dcb403-ec19-4d23-9bab-336e2eb344bd@intel.com>
 <CALMp9eTHRzXXm1gpKR3u1nzJU3i9M1a_wUjp9+bD8_r4eoPQ_Q@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eTHRzXXm1gpKR3u1nzJU3i9M1a_wUjp9+bD8_r4eoPQ_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/30/2026 6:55 AM, Jim Mattson wrote:
> On Thu, Oct 29, 2026 at 10:45 AM Chen, Zide <zide.chen@intel.com> wrote:
>> On 10/28/2026 4:24 PM, Jim Mattson wrote:
> [ ... ]
>>> As I pointed out in patch 04/16, we can't pass through the PMU global
>>> controls unless their reserved bits match hardware.
>>
>> Totally agree. Then the handling of bit 55 breaks this rule as well.
>>
>> if (vmx_pt_mode_is_host_guest())
>>         pmu->global_status_rsvd &= ~GLOBAL_STATUS_TRACE_TOPAPMI;
>>
>> Always intercepting GLOBAL_OVF_CTRL and GLOBAL_STATUS_SET can solve this
>> problem, but it may impair guest performance, especially for nested.
>>
>> Instead, I'd propal to have separate reserved masks:
>> - pmu->global_status_rsvd: unchanged, strictly tracking virtualized
>> guest state and preserving live migration validation.
>> - pmu->global_status_{clr,set}_rsvd: unmasking all architecturally valid
>> hardware bits for the corresponding MSRs on v4+.
>>
>> Any bits allowed by hardware but unvirtualized by KVM are
>> scrubbed/filtered in intel_mediated_pmu_{put,load}().
> 
> That is a terrible proposal. MSR bits that vanish at unpredictable
> times?!? No. If an MSR contains bits that aren't virtualized, that MSR
> can't be passed through. Full stop.

OK, I agree. I will intercept GLOBAL_STATUS_SET (0x391) and remove the
nested_vmx_merge_msr_bitmaps() for it.

However, I propose we keep GLOBAL_OVF_CTRL (0x390) passed through, even
though its reserved bits don't match hardware. Since it is
write-1-to-clear, it cannot manufacture unvirtualized state or leak host
data.

The only divergence is the lack of a #GP if the guest writes an
unvirtualized but hardware-valid bit. If we want to eliminate this
behavior by intercepting it, it will force an additional VM-exit on
every single guest PMI.

What do you think?
