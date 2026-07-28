Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF09C175A85;
	Tue, 28 Jul 2026 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200466; cv=none; b=YAvcDhrCBGqsy0raDn1FgcCs/HCtK/YLGFjxPkLHtMRmij8vTfXtLb9Wdvo8onuYt9WyZWH1MhRHqliEO9OGgp57QszF6+QneI5yRKqJimLFm6/+Y6xoyALVYxLP46pZzM9Cg2okkzrZN8NMTlHVMGgGE3Dt3B5o8ib6153e2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200466; c=relaxed/simple;
	bh=3u0BAomQAf3tllPl+HTendrWBkSHtUMKeiWKjnd8IbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ao+1Zrd4MYUBBmjEDC3thKsC67wOWiewPTugOJdH2Tor9XO3nPdCiMcpK1ssWQDdvCrizLMGKG7VYegMlRDlraSmZymeiZIjZ8kUyFDZDfLPO3dvt6dINh0Mb6jKSRI7I3is+Y6rHEEsdDpYN2MzTd7Hzb4DkzDqAMbbacHXJwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVdgVjYc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVdgVjYc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785200464; x=1816736464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3u0BAomQAf3tllPl+HTendrWBkSHtUMKeiWKjnd8IbY=;
  b=gVdgVjYc+jt7WgoDt+tZororGzKCWckJAJcLxAdq9AhwFycgh9CHo+Qs
   X3oT/1FAyxxa2frSmumn55j32mPr5eFLW4x7DMlCM5kHV2LX7IC1E2+RN
   jk9LC74XKWGy36VwI6omyRCKwPcWjoc5OEso3VEgPuW/osc8mdXHPO3lM
   uU3B7CyYl4ofNmPlmfl8RajJFyQQ2e/Jqzeb9D4joNRVUAcNY+i2AkVT6
   84UvKawnRn76882eERpn+tYWnGoRxQ4llHnS1U8SMcCFM4VX5Ur9bBE2G
   mqW3J0cU9vjphJhiEK1UdUVz5zw7OoaJcs5GHntdAKr3QQRRSJdufXtJh
   Q==;
X-CSE-ConnectionGUID: ZStE8gC1T9yWSv00PUr6Cg==
X-CSE-MsgGUID: CPLRiKFDQbyESFL87mvHBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="96930900"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="96930900"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 18:01:03 -0700
X-CSE-ConnectionGUID: cKLvqKpJTmyHPVf+buB24w==
X-CSE-MsgGUID: WKEYqhc6Th6v5I8l/1rrSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="263867656"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.132]) ([10.238.208.132])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 18:01:01 -0700
Message-ID: <f9cff94c-950c-45a9-a274-970ba421baea@intel.com>
Date: Tue, 28 Jul 2026 09:00:56 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] KVM: guest_memfd: Rename prepare() hook and
 Kconfig to make_private() / CONVERT
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fuad Tabba <fuad.tabba@linux.dev>,
 Ackerley Tng <ackerleytng@google.com>, Michael Roth <michael.roth@amd.com>,
 Fuad Tabba <tabba@google.com>
References: <20260723210811.72720-1-seanjc@google.com>
 <20260723210811.72720-8-seanjc@google.com>
 <627eda4b-c084-4cd8-ad3a-3b3793feae0d@intel.com>
 <amdqJtKey_zX4-Mf@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <amdqJtKey_zX4-Mf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/27/2026 10:41 PM, Sean Christopherson wrote:
> On Mon, Jul 27, 2026, Xiaoyao Li wrote:
>> On 7/24/2026 5:08 AM, Sean Christopherson wrote:
>>> Rework guest_memfd's prepare() hook into a more accurate make_private(),
>>> and rework its Kconfig from PREPARE to a more generic CONVERT.
>>
>>> This will
>>> allow x86 to share (pun intended) a kvm_x86_ops.gmem_make_shared() hook
>>> between the "convert to shared" and "reclaim" flows, which are one and the
>>> same for SNP.
>>
>> Does it mean in the future we will introduce something like below?
>>
>> #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>> int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>> int max_order)
>> {
>> 	return kvm_x86_call(gmem_make_private)(kvm, pfn, gfn, max_order);
>> }
>>
>> +int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
>> +{
>> +	return kvm_x86_call(gmem_make_private)(pfn, nr_pages);
> 
> s/gmem_make_private/gmem_make_shared, but yeah, that's the plan for the in-place
> conversion series.

/faceplam my copy-paste mistake.

The patch looks good to me,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
