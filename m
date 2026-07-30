Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D367124886A;
	Thu, 30 Jul 2026 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785382234; cv=none; b=Ak5VcOlaDvNaSc1VEKZMC7RnAJMGWZa+yCdkktsixe9q4cpp57mW2GKUfvThfdxXtoTCjWG4J4b5bA0xK5EW0AJklNaWaWpDNLpETbW/n5zILtJkavft4wvjcsx62Jip5wSILXSTTs14epSN0D8wiVisPAS42BEN6pkbxB8QRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785382234; c=relaxed/simple;
	bh=gCTrrUDehFFRU2bjd6W5FNde2DxwF0ZfjLb+CU52n2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EX1O6wO2M+Nu0ztfUXpgdPN+TjfQUkaXrmJIluHmJ0j5ldA5R9iDrS2fcu+j4id+c9wwUM1h8Zl9gkEGcfVkfX4jhtquOO9yMImzbgz4F4dX+V5P2K6AS5M3yDbmk1/ouJISK9WKVPKogZAS/FoxJqg4IKUro9aH3w3YqJezxUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGdeMeIz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGdeMeIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785382233; x=1816918233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gCTrrUDehFFRU2bjd6W5FNde2DxwF0ZfjLb+CU52n2c=;
  b=nGdeMeIz1oVy3ci6/PxBln3FmL825ZqQCMK3cLjjscwxzKWs5SOt5AaG
   MC7eynCx4RiiAR7YT6cthmYX4D9b/w1uHimAlSfEALJug5A/O3OuDhSG5
   8LFCcC0maKblSbTqKv+ra3u3ep1BbDwI1Q7St6Bcwxol7RLpcTcS5Gwjr
   uhm3jVWkkWMwB/CrRQLt4tQLFmWGOCFIetZw+1roDr4voaVc7AzFuvNuN
   qx9OJ8tCOw80snwqKXTCQTnItI3B+DyTSfFpgufbR+fYc9LB37T3i9h7o
   mXJz85b4LOtY2GWP9NoNnmM5qxNcL7sV6XjoAN1B2jFKyv18I7g/p1h2w
   w==;
X-CSE-ConnectionGUID: 0yhw1DMPSweED5Pc1vnuew==
X-CSE-MsgGUID: 4SwAChuzQBuKBO2Gr4zG5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="89676224"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="89676224"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 20:30:32 -0700
X-CSE-ConnectionGUID: 9LMoqUA1Qo2yOqnwdihLLg==
X-CSE-MsgGUID: 10pBEWnyRYqiTAW+6FqJxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="260238610"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.178]) ([10.124.241.178])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 20:30:29 -0700
Message-ID: <7c3262e9-323c-4f50-be92-141d4e15878a@linux.intel.com>
Date: Thu, 30 Jul 2026 11:30:27 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] KVM: x86/pmu: Advertise PerfMon version 5 on Intel
 hosts
To: "Chen, Zide" <zide.chen@intel.com>, Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
 <20260707183405.15571-15-zide.chen@intel.com>
 <CALMp9eRWo+FA-qGiB3Bf-UQOK7hV4-pN62SjFgR5JYLkaMEcmQ@mail.gmail.com>
 <e7dd989d-c83f-45b0-9501-7e7a5bdd9fff@intel.com>
 <CALMp9eSd2TBixRrRTqfam8LFVG4__fy_H6XVa9Q_-kEdXoxe6w@mail.gmail.com>
 <a852a4ef-719f-4a4e-aae7-83d365189494@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <a852a4ef-719f-4a4e-aae7-83d365189494@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/24/2026 10:19 PM, Chen, Zide wrote:
>
> On 7/23/2026 10:20 PM, Jim Mattson wrote:
>> On Thu, Jul 23, 2026 at 4:25 PM Chen, Zide <zide.chen@intel.com> wrote:
>>> Currently KVM always injects #GP when the AnyThread bit is set.
>>>
>>> kvm_pmu_refresh(): pmu->reserved_bits = 0xffffffff00200000ull;
>>>
>>> I understand the concern, but I'm not aware of a better solution for
>>> PMUv3/4. Silently ignoring AnyThread would deviate from the
>>> architectural behavior and, more importantly, may give the guest the
>>> false impression that AnyThread is supported. Supporting AnyThread, on
>>> the other hand, has cross-VM information leakage concerns.
>> Don't support versions 3 or 4; they aren't virtualizable. Hosts with
>> PMU versions 3 or 4 just get vPMU version 2.
> Yes, that sounds reasonable.

Yeah, that is our original implementation. It would be simpler. 


>
> PMUv3/v4 platforms (Nehalem, Westmere, Sandy Bridge, and Ivy Bridge) are
> quite old. In addition, the impact of exposing PMUv2 instead of PMUv3/v4
> should be minimal.
>
