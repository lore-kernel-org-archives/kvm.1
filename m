Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571DF250BF2;
	Tue, 18 Aug 2026 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083240; cv=none; b=jMo1yudSxN04NcJkR3CsV2Zdr2FbWBOUuMkEy7wBZYGdUwpJoieRLbvg2BdoKy3RvAqPPVUvFFDiIKYunaG7itAaTGI7Vpz8w4ETiB73UD4GgUS9f+ZIBMuLmNM+A+UFoNuFEps6UyYXhMKlArMLDQstbtE7QcgayDF9kBL8QyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083240; c=relaxed/simple;
	bh=7zAeiKb4ZItCbyXLv1015NYGnA0+lBqnTy+Fa7pNleA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdHI8DNUdkpQekxkLnuvj1BHYOhEUjrKLZlIwTCObJBbWrg3EFrWUTWMryCeMq+VBbrNSoLh8g/+G4nPSXVuAW6IQvJDOqtP4YJrpIa3KCYERcs2nrh9zInh/fOcLd1UE/nVDn5EJtx/1+c1jiYrO40+IstXu3gSC4eTd6HcGAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpKApbI6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpKApbI6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787083237; x=1818619237;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7zAeiKb4ZItCbyXLv1015NYGnA0+lBqnTy+Fa7pNleA=;
  b=bpKApbI6Ni9Ai1nvt3t1d9jm1mVKndIRDRXUTwP/dhhe7kAIB1HXe0WP
   uTGOiPU4/aTf2zh/zpo82Ku0TfpWDwUrGP4AZ6KsiN2/s4YWMI3RYy//X
   fZ1/eME4IxFrIwrhV1GS+cg25ereCb+ngg2zxLm7tRCGOf0LYZ0ufx/El
   ZDFNHP8PC+sPG6ItF6zIYfEOKY26cBz5mWvVM/2jweSDQ7CUw7jeTkZ5O
   qNnDaJNZCbNpWYQ6HrtFAK9iAHTck2ElLAKGuoe6b1xDvHsejinj3np/F
   my+4zEwJAOrwEdGmQ4R9dBVv/tbVJZHlAsIGA9CnsN+cVNYmYWCnOxH+5
   Q==;
X-CSE-ConnectionGUID: OCZwwX+DSfePrvjhUlfalw==
X-CSE-MsgGUID: N3yX2wDaS6e9FxINnOs7Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="91459976"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91459976"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 12:59:59 -0700
X-CSE-ConnectionGUID: brBZbxT6Rn6ivUtx+eDkMw==
X-CSE-MsgGUID: ONIhI39URw6d4aNvo0WvNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="270520154"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 12:59:57 -0700
Message-ID: <fe9aa78c-b2b8-4660-a378-f9265afb7543@intel.com>
Date: Tue, 18 Aug 2026 14:59:56 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/8] KVM: x86/pmu: Emulate RDPMC on performance metrics
To: Andi Kleen <ak@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260817183143.226156-1-zide.chen@intel.com>
 <20260817183143.226156-8-zide.chen@intel.com> <aoSZRRDtNxNA0UtK@tassilo>
 <cdd88e7c-abc9-4e49-8947-bb7226f3a385@intel.com> <aoSxVRJqjJzQssMJ@tassilo>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <aoSxVRJqjJzQssMJ@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/18/2026 2:24 PM, Andi Kleen wrote:
> On Tue, Aug 18, 2026 at 01:30:32PM -0500, Chen, Zide wrote:
>>
>>
>> On 8/18/2026 12:41 PM, Andi Kleen wrote:
>>> On Mon, Aug 17, 2026 at 11:31:41AM -0700, Zide Chen wrote:
>>>> If the host has the PERF_METRICS capability but it's not present on
>>>> the guest, RDPMC interception must be enabled and KVM should inject
>>>> an #GP when the guest attempts a PERF_METRICS RDPMC.
>>>>
>>>> If the guest has PERF_METRICS but RDPMC interception is enabled for
>>>> other reasons, KVM needs to emulate RDPMC with type 0x2000.
>>>>
>>>> For simplicity, Metrics Clear Mode is not supported.
>>>
>>> But is the bit cleared in PERF_CAPABILITIES? And would 
>>> the enable bit fault?
>>
>> Currently KVM doesn't advertise
>> IA32_PERF_CAPABILITIES.RDPMC_METRICS_CLEAR[19].
> 
> Thanks.
> 
> How about the fault for the enable bit?

Yes, KVM always injects a #GP if the guest writes
IA32_FIXED_CTR_CTRL.METRICS_CLEAR_EN[bit 14].

> 
>>> It would be better to just support it, metrics clear is actually useful.
>>
>> Sure, I'll add it.
> 
> I guess it could be a follow-on patch, no need to hold up this one.

OK.
