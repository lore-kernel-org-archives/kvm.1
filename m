Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416789;
	b=qZEpN4JB8G1f/ePpWGAGTh1viC+tCm/Rn8tzc4WRZO3uz6BRgLtMKcXV+A3S3u0WSUT7
	 k6OdNlYl69mbRldy/vvU2tvGC7v2nFVbMHs5RrNy1tu5qmbjTNk8qQkjvzRM68BFJfMQq
	 GbCrHWJBkq1LnqqrGYtXsFvrb8y2E5VSiM2AM1WATmlLLvIwEP2SQ5n+hjXfKx9L9iAsH
	 8YpoCLXzY8+76J75J2VFErjUK7uAdbFpfBDsJu0lpUOAi5Bw5lOzVCEb5Zs3PHeb2UUGT
	 ZUn7KGl20E1rQF0lT/uDX5hOvyIHSBAaJz04ZAOo9TaeSsFEOIF496GV2XuIiT1o8sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416789;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=NGey3Omi6z4yZAlJlmwhtArC0oxzu/TMpBbxJQ8dcJ4=;
	b=Ti6pfrzUametwVIdz8t4eZrVVYJnViNqsdzL3eUNx8BhIYTEQfSaV5kHL9FCWjMkaenM
	 SoLXMW1am/qkXaiWv2LQgy3Voc4zPMytBW8+d38XlG+seWJVc5hoAQ8cfcKbMFTAU+51K
	 Jp67Tc4n/1vvPL1xQzRNt1+0le1kYy5e1gnqwm6PwKPggTZAX/BlDY8Mftt/wqUkQHO2x
	 xdTlHtD8frq/tBYJ4PL/8357/Ie7ZzC5H6dVETS5HLWv4nygbOz5YtudaeogWzwtQzTdz
	 d/EMmSv61tekXjodw6GCSeEgvnKxLWtBtqYrfQVVbMz9kukecD66hKXmuYX/YfoptHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J2+760uX;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF69606A8B8;
	Wed, 11 Nov 2026 17:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EF69606A8B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J2+760uX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794416788; x=1825952788;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z6yqldU9TL3Pun7S44OczIQNxBgmFcYEo2So+TJORmk=;
  b=J2+760uXque9SENXKIl5UnCk+hGZIOPoqueEgwoZr1iK/y6ZN07ilaOR
   SPLwU1sLoiD+jXjm7CWPq5Z1rZUrAYhT/lNVL1jXK9ECklW4lgZYgVcMG
   W0TZESIqRCY3uyo0pR08SFd4J1GFhr3yWqSyEcjLVLnICnQutY+UTWzn8
   fwNbF1BZsg6jlh8MrcLnqqZZD+9R3zfYywuyaTTWR7gc+/YjHFc2izKJV
   4KzOhfYAYHuuC4BSIofj0anB9RCznuZ1LhyhpCFu28Ar5mkoAjYIlC9yj
   vTp56Usm2oE43zLk905p+3hImrEGDEnv2XVqv6/G+WoYfn3y1QIGKOWs0
   Q==;
X-CSE-ConnectionGUID: ypvAf4hnS4e75ySYemT+Rw==
X-CSE-MsgGUID: 4s9FvyRdRzKa0V9Ef64Xjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3074739"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3074739"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 09:06:27 -0800
X-CSE-ConnectionGUID: V8sWW9WJRIGSJ1ekleoQXA==
X-CSE-MsgGUID: o349mci7Qr6Z+sxI6wpgXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8555094"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 09:06:26 -0800
Message-ID: <3d4804e9-3e5a-447e-8a54-8fa5d1c28f5b@intel.com>
Date: Wed, 11 Nov 2026 11:06:25 -0600
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
Subject: Re: [PATCH v3 13/18] KVM: x86/pmu: Populate CPUID.0AH:ECX
 fixed-counter bitmap
To: Sean Christopherson <seanjc@google.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Yosry Ahmed <yosry@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-14-zide.chen@intel.com> <au491iiV7koeP0t6@google.com>
 <f20b59bb-a3c6-4129-ba61-5cec4d975601@intel.com>
 <f12bcb27-9c17-4b8c-b48c-c36a17e70ab6@linux.intel.com>
 <5f129d63-10c6-414b-86a9-a604e42038ce@intel.com>
 <51089074-1be0-47e3-8d53-732ca33f29a2@intel.com>
 <fceb4f61-621a-4d62-a648-a1cdd0de1671@linux.intel.com>
 <970e231b-c3ce-4159-ab27-ac371426500c@intel.com>
 <avSLss14zigMfUww@seanjc-mac.roam.internal>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <avSLss14zigMfUww@seanjc-mac.roam.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/2026 9:37 AM, Sean Christopherson wrote:
> On Tue, Nov 10, 2026, Zide Chen wrote:
>>>>> KVM's principle of "not policing guest CPUID" means KVM allows userspace
>>>>> to configure an arbitrary guest CPUID without rejecting the ioctl or
>>>>> mutating the vCPUID entries.
>>>>>
>>>>> However, KVM's internal vCPU state (pmu->version) tracks the "effective
>>>>> PMU version" that KVM can actually virtualize.
>>>>>
>>>>> This distinction is documented in commit 4f1bd6b16074 ("KVM: selftests:
>>>>> Test Intel PMU architectural events on gp counters"):
>>>>>
>>>>> "KVM only officially supports up to version 2, but the behavior of the
>>>>> counters is backwards compatible, i.e. KVM shouldn't do something
>>>>> completely different for a higher, architecturally-defined vPMU version.
>>>>> Verify KVM behavior against the effective vPMU version, e.g. dvertising
>>>>> vPMU 5 when KVM only supports vPMU 2 shouldn't magically unlock vPMU 5
>>>>> features."
>>>>>
>>>>> pmu_counters_test itself explicitly mentions this rule:
>>>>>
>>>>> /*
>>>>>  * Return the effective PMU version, i.e. the minimum between what KVM
>>>>>  * supports and what is enumerated to the guest.  The host deliberately
>>>>>  * advertises a PMU version to the guest beyond what is actually
>>>>>  * supported by KVM to verify KVM doesn't freak out and do something
>>>>>  * bizarre with an architecturally valid, but unsupported, version.
>>>>>  */
> 
> ...
> 
>>>>> Without a PMU version cap, guest resource validation could become
>>>>> increasingly complicated as more advanced PMU features are supported, as
>>>>> KVM would need to allow the guest to access PMU resources only when it
>>>>> satisfies both the vPMU version and the KVM capability.
>>>> The above sounds reasonable at first glance, but in practice it is
>>>> problematic because it arbitrarily masks out features that can be 100%
>>>> emulated in software even when there is zero host hardware dependency:
>>>>
>>>> - Features that can be emulated entirely in software (e.g. there is no
>>>> problem emulating the PerfMon v5 AnyThread deprecation, or emulating
>>>> MSRs like GLOBAL_STATUS_SET or GLOBAL_INUSE on a v2/v3 host). Clamping
>>>> the version unnecessarily prevents the guest from using features that
>>>> correspond to its configured PMU version.
> 
> Just because we *can* do something in KVM doesn't mean we *should* do that thing
> in KVM.    

Got it.

>>>> - Features that actually need host hardware support need to be checked
>>>> against both guest and host PMU capabilities.
>>>>
>>>> I'd propose something like this instead, leaving pmu->version unclamped:
> 
> Why?  What real world use case is there for KVM actively supporting a PMU version
> "greater" than the underlying hardware?  E.g. emulating AnyThread deprecation is
> (presumably) easy, emulating *all* of v5 on a v3 host, not so much...

Got it. I can think of a few discrepancies:

For example, the guest is supposed to handle Freeze_LBRs_On_PMI (legacy
vs. streamlined) based on the guest PMU version. If KVM emulates the
legacy behavior, but a v4+ guest expects the streamlined one, it may
run into issues.

Similarly, for v4+ MSRs like 0x391 and 0x392, if KVM emulates them
based on the effective (clamped) PMU version, the guest will receive
unexpected #GPs for accesses that should architecturally succeed under
its configured version.

By clamping the PMU version, we either have to accept these
discrepancies, or it may be troublesome to decouple the emulation of
these cases from pmu->version.

If we don't clamp the PMU version, we can gate the emulation of a higher
PMU version feature with kvm_pmu_has_version(), which seemed easier.

Please let me know your thoughts on these trade-offs, and I will align
the patches accordingly.
