Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5E841A922;
	Tue, 28 Jul 2026 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268271; cv=none; b=Ixm+wkP3ytdhN2zFpTD8hwKeLd75AIQjGwRYNHANAV7F4VMM5EtKFlA8CISuiDmTx8yCfGd5Y8WbY8wDy0GBSD4AZF/8Yw27Id88fyALcxzHdzIWxYi6j9vYEpaN6decefbWG0sPIAe1STPqhOEqzVZQtJwl/byP0bC1eGznkbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268271; c=relaxed/simple;
	bh=R2Y9eK4ltmlz/4BfPD/Z4sGc7/Wr/HX21mAutfHTk2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpEmC3h/yhmZVf+6/+l5SDqxtaqV4DUqJgTRLSrBAOPjGS/DsTuCSz/qywm1nSt0UwbLRTWauODze5K6l4X8B73Mi2enjjqDd5fLWpWIP4PTrzsTU48O5+YaLXasfcNRrdsQrl6nrAxfXQKQm0VjPJBa10vsZwKGbuT028V9BAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/JmXfbe; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/JmXfbe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785268270; x=1816804270;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R2Y9eK4ltmlz/4BfPD/Z4sGc7/Wr/HX21mAutfHTk2c=;
  b=G/JmXfbewsi4WRyT5ywMTqImU360XppOrf+QSZJNDZYYavzrSM55N00r
   AuILUYZCUp2UHY8V8nyTBzohsgoiS3f9856b60/0hVGM74eF/Hz3IiVC+
   Lwd46lIGz44EVdzOG2uXn4KcrP8RlmLkmeNpUXeRkPf2Q0qDbQ7IVTHpY
   ZaLDQF7iTVYya1LN+vvo/URy14DfPxJDqFn3awDOYqpRfgQ8zQlvYs/ke
   Hn8OjLume9L7VVtV4ewI24HpQE/aZjHdwQPMTFMTfHOUNaUJPQJunp7ks
   IDFYH1/A4MnvlgjEECi+zTBjlmiyQak7575IU9eNb0l62ri1ZYo2H6kCG
   A==;
X-CSE-ConnectionGUID: gQS7A2jtS02Nm8VGSgnmYA==
X-CSE-MsgGUID: xJ8Hd1xTQ7SVXYmtojB1Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85948017"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85948017"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 12:51:10 -0700
X-CSE-ConnectionGUID: ICus94gjTcm9k9xOfDOC7g==
X-CSE-MsgGUID: X1I8BxcnSuGWDoypfudVjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="263608132"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 12:51:08 -0700
Message-ID: <f13dc9f0-daf9-4321-820c-1ca688b8c860@intel.com>
Date: Tue, 28 Jul 2026 14:51:07 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] KVM: x86/pmu: Rename all_valid_pmc_idx to
 all_valid_pmc_mask
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
 <20260707183405.15571-3-zide.chen@intel.com> <amj-5YH-LSwZOLow@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <amj-5YH-LSwZOLow@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/2026 2:11 PM, Sean Christopherson wrote:
> On Tue, Jul 07, 2026, Zide Chen wrote:
>> all_valid_pmc_idx is a bitmap of valid PMC indices, not an index
>> itself; rename it to all_valid_pmc_mask to better reflect what it
>> holds.
> 
> How about "pmc_exists"?  All the other bitmaps start with pmc_ and describe when
> the bit is set for the PMC.
> 
> 	DECLARE_BITMAP(pmc_in_use, X86_PMC_IDX_MAX);
> 	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
> 	DECLARE_BITMAP(pmc_counting_branches, X86_PMC_IDX_MAX);
> 	DECLARE_BITMAP(pmc_has_mode_specific_enables, X86_PMC_IDX_MAX);

OK, will do.
