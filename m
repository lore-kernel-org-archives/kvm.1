Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A4C432E85;
	Fri, 24 Jul 2026 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902763; cv=none; b=dX4kIgcFyrs3C/UjcMtqc8nhsn6nXaLOEogpPYpP6AC0h7pJXCKykhLgbioHNAWukzC37jozUKN840XRatHfIEjl65kKTB3aToeiAAUVnpZhXq5UkIuHp2hKJSmrbO1hQaOzTZdyYDU1eS1m0cpp3Ck9i8NSYc6+UDWoi3/SWpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902763; c=relaxed/simple;
	bh=10i5EvWAKrIKZG/5TYABM+/91AVrSm1aivuorzMif/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9N/pRnVDJec1G4ugRLXruoiP9Ru/2XVP8tKNDnvv8JtXwnysn7ANY4XGtRgVwTE8fRAAe/fjxDLt3EE/Kk3gLdMIvaO/1OI2xqg+/frnLk5/bvUavdba1+UiuZEbbZefbnmUgyYo0GiBvUBpkFuV0YjxN7Vp0UWlLzygMcofdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJgULsDP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJgULsDP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784902761; x=1816438761;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=10i5EvWAKrIKZG/5TYABM+/91AVrSm1aivuorzMif/c=;
  b=iJgULsDPW4bq13Cxqc6EcWJtAxQiMvuDeI5gGBzs2rfo5el791tCiMRK
   CcDAz1uW+K/kVafwDEWSLB3t7W46NKUODrVOK++m3EtgEwjYJAEzE5buw
   Qp2LyC16salg2a58HFH7FQNhiYks7GxDCnlAaMVLy8W6qR/qSu2O6RS49
   GcbdwVl+P86cf/3BWovaW8jtY2iSckcPy8DT66wQ81Ccbu2nia1y8MsjU
   oTxDskqJ/DFWCfclvTHsBt7aWodWm7UqU78QmX+U/RmKwT3UibXxftL2v
   vnfXkiSxOxtybBesqX/q943FM/VFzPCa3VGTPzBFNQnQrf0no8Z9udx+l
   A==;
X-CSE-ConnectionGUID: +c7xx0PNQYCimNCCpVxHjw==
X-CSE-MsgGUID: YQKfjd1lStK7Rme/GRChOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96718653"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="96718653"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 07:19:20 -0700
X-CSE-ConnectionGUID: EboXq4bNRHSFQ3hOcpjATQ==
X-CSE-MsgGUID: eqlqtQLSRNijLAQLRB3Zyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="282027002"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 07:19:19 -0700
Message-ID: <a852a4ef-719f-4a4e-aae7-83d365189494@intel.com>
Date: Fri, 24 Jul 2026 09:19:19 -0500
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
 <e7dd989d-c83f-45b0-9501-7e7a5bdd9fff@intel.com>
 <CALMp9eSd2TBixRrRTqfam8LFVG4__fy_H6XVa9Q_-kEdXoxe6w@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eSd2TBixRrRTqfam8LFVG4__fy_H6XVa9Q_-kEdXoxe6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/23/2026 10:20 PM, Jim Mattson wrote:
> On Thu, Jul 23, 2026 at 4:25 PM Chen, Zide <zide.chen@intel.com> wrote:
>>
>> Currently KVM always injects #GP when the AnyThread bit is set.
>>
>> kvm_pmu_refresh(): pmu->reserved_bits = 0xffffffff00200000ull;
>>
>> I understand the concern, but I'm not aware of a better solution for
>> PMUv3/4. Silently ignoring AnyThread would deviate from the
>> architectural behavior and, more importantly, may give the guest the
>> false impression that AnyThread is supported. Supporting AnyThread, on
>> the other hand, has cross-VM information leakage concerns.
> 
> Don't support versions 3 or 4; they aren't virtualizable. Hosts with
> PMU versions 3 or 4 just get vPMU version 2.

Yes, that sounds reasonable.

PMUv3/v4 platforms (Nehalem, Westmere, Sandy Bridge, and Ivy Bridge) are
quite old. In addition, the impact of exposing PMUv2 instead of PMUv3/v4
should be minimal.

