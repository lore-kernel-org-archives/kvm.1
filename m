Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64CF1C5D7D
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091765; cv=none; b=ET8aisWkKVF39YhLQAst3+fcOO/QDClv/XpMR25M86IrRvgB3FSRYaUdxFSfajrEPBezJ/itU9zaWFJa5eZgnyZMVSY9yfb6nfd23k9FDViJglW5Nx/3A5mzmn93ZmV0rk68ujpgZ2l7l4ImGxJZ3BNFmsFIMCOpKj6D60ZA/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091765; c=relaxed/simple;
	bh=KLQfImQyy3KPHCroV9ZWV1AFR/Bjp6Xr/sLUIwKBNaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqCQBD8Rk8krNbA50LRIkTVZaahTQ5NYbsUqdCggB2GiUKD5+DHwxF/HKNb2oK/ivBb4tny9uTqqQl35H+9SsmdURTcetndY1zFraFPO4SQ2mmVpJXQ0HongqKfRCdxSMzNYhEQvv79xhoJdF+rY4uDd5Ha9t4i/8+iRF65xAY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fraT+kB2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fraT+kB2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779091762; x=1810627762;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KLQfImQyy3KPHCroV9ZWV1AFR/Bjp6Xr/sLUIwKBNaI=;
  b=fraT+kB2fK3wAF5nfKpLNnD8r8sAGTP/2+x4WFEX4Cbk6UYvwkuaUiBa
   TcN28TzlPTAwJgIBVdj+GB1sgbKmUtmvem4JyDoxkOnYKiB17P7MQ98P4
   kWyzxVL3vYyc/+nsCULgG4EbwiZHr4/gs/ndYkeiC9HKGcPmC7e+VFlI3
   0pGVKaspL1tMYj4YdA9lDYm6UqU+uNHJ3D4E7rScC+mT9J7PAvW6ciTQ2
   DdenjIHWwPCbZOwnKamuP+NFsg/LiNz/bUxt1lmnJ5rngAnJmFHFPkapB
   y0hgJ7T8CubMmKJrVQuU4Ay6Hyk5uWJuqDSm1V/j3SuxxInXU1bgNkybf
   g==;
X-CSE-ConnectionGUID: dtSZHOFIS5Waz1DIpFTwvw==
X-CSE-MsgGUID: CWd48NzBTSi6X/wx3ThgZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="82504022"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="82504022"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:09:21 -0700
X-CSE-ConnectionGUID: OyIRqyV5Sf+rAJSs1tVuGg==
X-CSE-MsgGUID: iz3HhURRTBu5xAnjLPt5Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="239435859"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:09:19 -0700
Message-ID: <d47cf3d8-0547-4246-9249-eaf56800f2da@linux.intel.com>
Date: Mon, 18 May 2026 16:09:16 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/27] KVM: x86: Fix emulated CPUID features being
 applied to wrong sub-leaf
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com,
 rick.p.edgecombe@intel.com, chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-2-binbin.wu@linux.intel.com>
 <db11b4df-d5f8-49b5-91dc-daa103f94223@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <db11b4df-d5f8-49b5-91dc-daa103f94223@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/15/2026 5:03 PM, Xiaoyao Li wrote:
> On 4/17/2026 3:35 PM, Binbin Wu wrote:
>> Guard the use of cpuid_func_emulated() with a check that the CPUID
>> sub-leaf index is 0, as cpuid_func_emulated() unconditionally returns
>> emulated features for index 0 and does not account for indexed leaves.
>>
>> Without the guard, when iterating over reverse_cpuid[] entries that
>> share the same CPUID function but have a non-zero index, e.g.
>> CPUID_7_1_ECX (function=7, index=1), the emulated features for index 0
>> are incorrectly OR'd into the wrong capability word.  For example,
>> RDPID (CPUID.7.0:ECX[22]) gets erroneously applied to CPUID_7_1_ECX,
>> which would allow userspace to set bit 22 of CPUID.7.1:ECX in the vCPU's
>> capabilities.
>>
>> This is currently benign as the affected bits in the non-zero index
>> words happen to not correspond to meaningful features, but it could
>> cause problems as new features are defined in those positions.
>>
>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>> ---
>>   arch/x86/kvm/cpuid.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index e69156b54cff..25f582a8d795 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -399,15 +399,16 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>>           if (!entry)
>>               continue;
>>   -        cpuid_func_emulated(&emulated, cpuid.function, true);
>> -
>>           /*
>>            * A vCPU has a feature if it's supported by KVM and is enabled
>>            * in guest CPUID.  Note, this includes features that are
>>            * supported by KVM but aren't advertised to userspace!
>>            */
>> -        vcpu->arch.cpu_caps[i] = kvm_cpu_caps[i] |
>> -                     cpuid_get_reg_unsafe(&emulated, cpuid.reg);
>> +        vcpu->arch.cpu_caps[i] = kvm_cpu_caps[i];
>> +        if (!cpuid.index) {
> 
> Instead of such a temporary fix, I would prefer adding the index parameter to cpuid_func_emulated() and split this patch separately.

I did it in this way because:
- The index parameter was here and it was removed in commit ab8bcf649711
- I thought cpuid_func_emulated() probably would not be extended in the future.

> 
>> +            cpuid_func_emulated(&emulated, cpuid.function, true);
>> +            vcpu->arch.cpu_caps[i] |= cpuid_get_reg_unsafe(&emulated, cpuid.reg);
>> +        }
>>           vcpu->arch.cpu_caps[i] &= cpuid_get_reg_unsafe(entry, cpuid.reg);
>>       }
>>   
> 

