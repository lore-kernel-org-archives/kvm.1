Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945731;
	b=HPMkSud5zWlM4mSs3qh1dMhq6xIKPYTRQhHcbTkojzuQ6cvoHeXsFLYtRHX2sLJqEXeZ
	 ezXOeVL+1qUpTJWZYC9ve3Fr8hdz/SaMaZ5lxt7RDwqalJAV77FXu5yswhy0YuN6tPC/m
	 JbiArEmvwi/uU1CNaK/1SOa4t+Y7u0s7EAGzVIowg9g0nXU0X3aRScxcuwg/vjwyRhvuO
	 9YQsXepgP45eohNR6d2rfh52Tk0qt2CG+erK5uvbxmA9ZqyfSuCj9kRwjNYb1YtPoTES1
	 cODe0AYrUVHzdwNSKKt3UtlNfxNzR7zssyXHVWmAJjNP6BQPXrw6Xl7lkB1nUWN651w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945731;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=q3KwXHnOAx+548KVSxT58roZKN6FpLAa4LwmuqkVZG0=;
	b=JLCJjNWUrFtVE12vS5XSb/CeMgStg9XfYj/GxCwawdPByQy7rA0RfaD9JGeU4Xu+LWyn
	 Z5IXiDRdXtjpAAEBetnw4JVZObyQraLNAN/27duxhFRqKx//VnKMhX1XDGmqezolU7FGA
	 m+ygzsqjksUCKxqiYP2avQLnhE4BreL5DwKzXKgn4FdLPTOx5MmPOSK0z3/+ggWGWKNDL
	 85l9hs/3MUb1SPEKdNyPaYQOdCSQbngVfyfulv325JyjALRIjdVtkMp9EaXnrirQcQ40c
	 ojwE95y7NMJjEnrEFSpUxfA3hZnEOpRu8Rfgp2OVg8Kp910R7wLvlDOsZaJ6Qxh/tNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lq6n3zYn;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46678606A31C;
	Tue, 17 Nov 2026 20:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46678606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lq6n3zYn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794945732; x=1826481732;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+y1voXPlsXi2cu9LgUWuXI01TNll5OgBBpq7fP71YPw=;
  b=lq6n3zYnKdskTGKVNVwoBh2JPr9i/ONKJfjIUcpqlYYTMe8ZMcB5ggoD
   68RfS+Fprbx63tCnWP4spLP5x6JP7Nd0M2W4xdIFsOV/IWdZqAykfAEUf
   WhDf3yQ4lvqnVKnqnl2ETL7XB+HTPF+TkHKjQdVTbCnfdC5l/FlEq2oXx
   BOJbX7nZu1F6D3he/2QWrPVyYTqqH888SMuOfoN2Ud4NCXwkC1ewqoK/6
   D7JClMaJGEKV6s8g9chh+Gpe3lzwG2095lyblRi6j0LQKn9XYlD7ocpXm
   /3CiYFqDzOhyM3AFMH10ibovOnTKoujW1ckVdH7pT9idzfM6651CrA56A
   w==;
X-CSE-ConnectionGUID: zR3ZZV1gRwGDEku8sy6ZAA==
X-CSE-MsgGUID: SeV76WN/R5GD9lIlqW1Yzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3724183"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3724183"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 12:02:11 -0800
X-CSE-ConnectionGUID: f84nI4lzTF64SGXeoJtDCA==
X-CSE-MsgGUID: LtOpH+P9TYmaqMcjnmAVeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10001864"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 12:02:10 -0800
Message-ID: <e090723f-cc02-40c2-af57-ab5dfda91dcc@intel.com>
Date: Tue, 17 Nov 2026 14:02:08 -0600
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
Subject: Re: [PATCH v4 06/21] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters
 from kvm_pmu
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-7-zide.chen@intel.com>
 <CAO9r8zPD_i2aWc3jaKRr-=1Pz0td=6nqBpgBfVVaV3jfzVTAjw@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CAO9r8zPD_i2aWc3jaKRr-=1Pz0td=6nqBpgBfVVaV3jfzVTAjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/17/2026 11:23 AM, Yosry Ahmed wrote:
>>  static void amd_pmu_init(struct kvm_vcpu *vcpu)
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 136069dfcd44..e21abcedea70 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -761,24 +761,21 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>>  {
>>         bool intercept = !kvm_vcpu_has_mediated_pmu(vcpu);
>>         struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +       unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
>>         int i;
>>
>>         if (!enable_mediated_pmu)
>>                 return;
>>
>>         /* Legacy counters are always available for AMD CPUs with a PMU. */
>> -       for (i = 0; i < min(pmu->nr_arch_gp_counters, AMD64_NUM_COUNTERS); i++)
>> +       for (i = 0; i < AMD64_NUM_COUNTERS; i++)
>>                 svm_set_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
>> -                                         MSR_TYPE_RW, intercept);
>> +                                         MSR_TYPE_RW, intercept || !test_bit(i, &gp_mask));
> 
> This fixes a pre-existing bug that was reported internally, that can
> happen if a malicious VMM reduces the number of counters after
> initiating KVM_RUN but before VM-entry. The current code would fail to
> re-enable the intercept on the counters that become unsupported.
> 
> Might be worth splitting this out into a standalone fix.

My hesitation on a separate patch was to avoid throwaway code churn.
A standalone patch would add:

        for ( ; i < AMD64_NUM_COUNTERS; i++)
                svm_enable_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
                                             MSR_TYPE_RW);

and then it will be immediately overwritten and collapsed into a single
loop in this patch.

So basically cleaner logic vs. avoiding immediate churn. I'm happy to
split it out if you prefer.
