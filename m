Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224516;
	b=y1fiWDxGiOORP5KgeInq9E2wfVTgOoRx8d6Ri4qyNMo1AVVbilc93qA07JCl8v/0M7TL
	 9axp+ZR+6JG3fyU3Nc35TzJdZPT7xCPKN9z+4NFeoVw+1aDhlnlG/asz7Ac5uWvqCnVS4
	 5+BYtwSxn06/ibvXgpFfPNdVNxgvVj2ebGphvhLopFjmxLeFa9xMSsXPoV6LQfjusarK6
	 WNFNm4I4OZn/nzUN9NhWdif/wIvdiR8vbnMMlaWfZQxpUsUmGb7KZVM8rty0jE5HAyC2a
	 f1a3yMzQjq2EjRp+mWJjKPRPbQpw7OtLdZ1rVXQ3T8CiuN1hbDE6iqV/ymyktRgPGxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224516;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Lfftdw1xrz3t9HNKvwNalUGhdSWwLj5xotvQehgMx3Y=;
	b=Ca7xOPmD63oABR3KYFAMp6Qn7WM21ISgptioaRHcoexcrPILAzgUl6p3ApvczBMlHSMl
	 kXb2jTIvJhBFzLLondWLmwVqKzYnCPaEivnK5j6izOhEfDVUB6rg8PuD8L/TK3Fqie6CU
	 dQ+8lapkQ57Iwm4mApZnEpxDTxYape2jcAYtVQb004gaHrV6KVFMpVwqYYsv0OVjJFtcZ
	 eZaryizgtJ8ZIWfC/RXQMTNAqW38poscupPerBY4gH0fN8FU8wa8roI2FdSni38hcUbhM
	 pBBH5fZv47iPvpWLUKj/ToV5IdqSaQUDbsbquL5+ixprmvDX4PNdZS+rOkeuPGRsIuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lYtZ3RT+;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05D5606A31E;
	Wed, 28 Oct 2026 21:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A05D5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lYtZ3RT+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793224515; x=1824760515;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gcK/HTGWbqZi7TqTm9gOD56I5jmdrbuXA3f0znXtwyw=;
  b=lYtZ3RT+AHqXFc3DJGHHLg4eBNupIL/WcrXXWLzHgKvSxaMKwDb5dqoS
   zuWgUwM2yjQzrlOc++4uRNHKNC1Jc6MbWjVJANQiFmqVJwZRYB2GTQiz7
   /PAtY3qfvfCINPUwzWKXlZIeaPPN6m1+yhAs5rNmG3ymjE/3OjzHfHzlY
   x0fCUCstH8bGBipg0jbK1TCIAitbzhQqldUPnhTyNpjdQsIZubP7BAIEH
   3xpFsJfqojPhGvrYNl2G9oBNNjW3cZoYxYwRSIrVPmuI4tp3IkTRsx9cE
   7L5xGHLohh+M9aeMv06/IAK847HQp9UaT1aADBGuQLIF54yCmY381xrJy
   Q==;
X-CSE-ConnectionGUID: EYhORc2rTEa7L3y139lb9Q==
X-CSE-MsgGUID: LQuGgMPCSNekYWe1Se5IlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1951088"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1951088"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 14:55:14 -0700
X-CSE-ConnectionGUID: CiUjfC0OR6+kjQtgDpWsDg==
X-CSE-MsgGUID: xs9HR9kyTaC7EdFAYbMUjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5081567"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 14:55:13 -0700
Message-ID: <330b725a-0ed5-4d08-bbce-2b4b39c9040d@intel.com>
Date: Wed, 28 Oct 2026 16:55:12 -0500
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
Subject: Re: [PATCH v2 12/16] KVM: x86/pmu: Populate CPUID.0AH:ECX
 fixed-counter bitmap
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-13-zide.chen@intel.com>
 <CALMp9eSz6eXpuR2R2dfU+fek8iYHOQNP07L3UZGxeRugyGKRng@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eSz6eXpuR2R2dfU+fek8iYHOQNP07L3UZGxeRugyGKRng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/28/2026 4:29 PM, Jim Mattson wrote:
> On Thu, Aug 27, 2026 at 3:48 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> PerfMon v5 adds a fixed-counter support bitmap in CPUID.0AH:ECX.
>> This is the superset of EDX[4:0] which indicates the contiguous
>> counters starting from 0. For backward compatibility, it's recommended
>> to use the following to determine if a fixed counter is supported:
>>
>> FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i);
>>
>> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/kvm/cpuid.c         | 5 ++++-
>>  arch/x86/kvm/vmx/pmu_intel.c | 3 +++
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 106e719e7aee..63201d4ea4a1 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -1547,7 +1547,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>
>>                 entry->eax = eax.full;
>>                 entry->ebx = kvm_pmu_cap.events_mask;
>> -               entry->ecx = 0;
>> +               if (kvm_pmu_cap.version >= 5)
>> +                       entry->ecx &= (u32)kvm_pmu_cap.fixed_cntr_mask64;
> 
> Is the '&' necessary?

You are right. kvm_pmu_cap.fixed_cntr_mask64 already reflects KVM's
supported fixed counters, so we can directly assign entry->ecx without
the & (matching how eax, ebx, and edx are populated). I will drop it in v3.

