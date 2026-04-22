Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C552C21C7
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776891808; cv=none; b=ptoCoG8RMDW758SSQa1O71QZBpF9+Za4NNGgpJ0bcjhiKwKHQCa1817NmUYILxBJkiPAFKn6XcB++wx8M9m0Dgl2mfmzNmccnMJETwSZ8QfsAcT82fNQfKQkYDu/dNOh3u3ayIOYuejgrhZ0DCjWeSIV18RID011JRQWjcygaZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776891808; c=relaxed/simple;
	bh=CjXMm9O9HgEbazVGNENiF7rUYZhQt66j+C1SKcZ9yJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLL5NWU4zLJ/DpHf7naz7Ze9yfPomwsaweApeZa75MXZHxJh0s+q8anhsiI21ZANjl9v7pXZxKOkqpmCf07c8hqn5dLt+HMGd+OUrahVqN0vvBZLGobPwuDW3rZfCI/OvzTxXYh7bdbM3xiIS1ZLp5rBsPyOJLeyLxQ+ssFrRl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNSXkOVh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNSXkOVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776891807; x=1808427807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CjXMm9O9HgEbazVGNENiF7rUYZhQt66j+C1SKcZ9yJc=;
  b=nNSXkOVh+VT/ui4OI93Zi5MKvN8YVac8TPY2NGgcv+J8hJU80SDD/1Di
   Sbm9QatJGeJ9jnGtZXYLzuKc6b7VygP+BYT/5i7Irflo63XVmMWi3LZ/+
   KBUAdUED8tI470cS1AqnSdsJInp8umGCgDAvAVDtc8Nj3pgTDGWEzcoic
   Ldq7SwzOxdIHtvjQK8L93Z5RHEoENCzeBWwvq/7neaKKQ4TVU+lF5/A6K
   mAp0En7oLUfMbwaIQ0DjnSMADcxFQlGfyNJwM+VAfiUQa3jwdC9ldXjBI
   KGgeWX1KIj3yNlWf3A0bnyuAcvsyI3jsAaKYnxHtudVhuc9YLSAT6Wg3O
   w==;
X-CSE-ConnectionGUID: lwW8DToSTQ+naTNhLylCBw==
X-CSE-MsgGUID: hXoVo1WdSHKTwCsvU+KlMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77917718"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="77917718"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 14:03:27 -0700
X-CSE-ConnectionGUID: JFHHzxPrScKv5+EVEyoQHg==
X-CSE-MsgGUID: Yl6Xr6X/SAOmXBMsJdwUmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="228120888"
Received: from unknown (HELO [10.241.241.111]) ([10.241.241.111])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 14:03:26 -0700
Message-ID: <be9cf7a9-4793-4bd4-b91e-cc9e0b6696a4@intel.com>
Date: Wed, 22 Apr 2026 14:03:25 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/13] target/i386: Add pebs-fmt CPU option
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-12-zide.chen@intel.com> <aeiE9ZZ5AE+uMgmN@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <aeiE9ZZ5AE+uMgmN@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/2026 1:21 AM, Zhao Liu wrote:
> Hi Zide,
> 
> On Wed, Mar 04, 2026 at 10:07:10AM -0800, Zide Chen wrote:
>> Date: Wed, 4 Mar 2026 10:07:10 -0800
>> From: Zide Chen <zide.chen@intel.com>
>> Subject: [PATCH V3 11/13] target/i386: Add pebs-fmt CPU option
>> X-Mailer: git-send-email 2.53.0
>>
>> Similar to lbr-fmt, target/i386 does not support multi-bit CPU
>> properties, so the PEBS record format cannot be exposed as a
>> user-visible CPU feature.
>>
>> Add a pebs-fmt option to allow users to specify the PEBS format via the
>> command line.  Since the PEBS state is part of the vmstate, this option
>> is considered migratable.
>>
>> We do not support PEBS record format 0.  Although it is a valid format
>> on some very old CPUs, it is unlikely to be used in practice.  This
>> allows pebs-fmt=0 to be used to explicitly disable PEBS in the case of
>> migratable=off.
>>
>> If PEBS is not enabled, mark it as unavailable in IA32_MISC_ENABLE and
>> clear the PEBS-related bits in IA32_PERF_CAPABILITIES.
>>
>> If migratable=on on PEBS capable host and pmu is enabled:
>> - PEBS is disabled if pebs-fmt is not specified or pebs-fmt=0.
>> - PEBS is enabled if pebs-fmt is set to the same value as the host.
>>
>> When migratable=off, the behavior is similar, except that omitting
>> the pebs-fmt option does not disable PEBS.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
> 
> ...
> 
>>      if (user_req != -1) {
>> +        if (!is_lbr_fmt && !(env->features[FEAT_1_EDX] & CPUID_DTS)) {
>> +            error_setg(errp, "vPMU: %s is unsupported without Debug Store", name);
>> +            return false;
>> +        }
>> +
> 
> This is a general code path to check user_req != -1... but
> 
>> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
>> index 1d0047d037c7..60bf3899852a 100644
>> --- a/target/i386/kvm/kvm-cpu.c
>> +++ b/target/i386/kvm/kvm-cpu.c
>> @@ -231,6 +231,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
>>      }
>>  
>>      cpu->lbr_fmt = -1;
>> +    cpu->pebs_fmt = -1;
> 
> -1 is only set for KVM, so other accelerators have lbr_fmt=0 by default.
> 
> This will cause make check fail:
> 
> stderr:
> qemu-system-x86_64: vPMU: pebs is unsupported without Debug Store
> Broken pipe
> ../tests/qtest/libqtest.c:201: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
> 
> (test program exited with status code -6)
> 
> So I think the initialization should be placed in the general code path
> as well (x86_cpu_initfn()) - and move lbr_fmt initialization back to
> general x86 codes.

Yes, the related changes in patch 9/13 should be reverted.

> 
> Thanks,
> Zhao
> 

