Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9AC1A704B;
	Tue, 25 Aug 2026 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787623238; cv=none; b=IbDrfcYFrj53n+wgvj5eNSSkGqQG725h0rlsVv00m2BnT8bSjzG5V8/zms04G8V02vEo5cyFsg8Xi7u0bdrDd9kDK/GCeVm92wLWUh2GfGql3EcFP8NELZqsA085WGMOIKZoQ1BhlKeTzp2wPTX7Ua3vi0vrgPgN3CEB36tFEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787623238; c=relaxed/simple;
	bh=rRShZ7FQmQ3rkbo+nSq4+MU8i3yWkEdooIVKqWt3XFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGEeymmkO5dfBQzoaqN+ZB0l8WGzolxiAaK+Fm8CRPVBL4dQZ+cobw3l6S+WzacO/42Mpy5s3GcOr9RPmwRotCkbDxU90DEZB4MxhQtRPbebwGZeEKgddK6AobGsEDWM5+U0xYEY0iQwHuHw2UupI3SmvapeRtH13U++5hQWQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzjFRMnd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzjFRMnd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787623236; x=1819159236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rRShZ7FQmQ3rkbo+nSq4+MU8i3yWkEdooIVKqWt3XFs=;
  b=SzjFRMndzl/RimVWU8pS+Qy69jTPQ4bNUUaNoTNxpa9zLLRPydXlWEQ6
   jyGCHb37tWrnluyHEawxRRjZvOEJTCCnEqoSryReRRNBugdKSBgh7mr0W
   YK/xV+HMVVGvJc5AuW4owixfb07zYKb3+bjp3+P40ulGWBsdbz9uKftut
   TyvZ8Zz/FkRQfkhbvflMaE+bW+oYqI2ac2tmibFpyrKjd3Va3haxlt3RV
   zwigrucAzlmeKSnrd4zQy186GrjshoDybBRWnJVaLpJA7K+Hb1JrQs9hv
   Bs25dyzRphJXMcETv6oxFKafRX7am7UYFUdhw8dunQ31T1JBqGZAvHBFv
   A==;
X-CSE-ConnectionGUID: ZQpyaZ3FTze++Yv/4PiU7w==
X-CSE-MsgGUID: fHLxQdIyTd+mvso7uDl+Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87210963"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="87210963"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:00:35 -0700
X-CSE-ConnectionGUID: /j0BNouQRcCMRsnNIl8/Pw==
X-CSE-MsgGUID: yUEn0qUbTjSMwthmrtozoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="263876937"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:00:33 -0700
Message-ID: <48da6c88-aab5-423c-83ab-8e0514e2a344@linux.intel.com>
Date: Tue, 25 Aug 2026 10:00:30 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: TDX: Charge misc cgroup before allocating HKID
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
 <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
 "Hansen, Dave" <dave.hansen@intel.com>
References: <20260821093957.1722167-1-binbin.wu@linux.intel.com>
 <35248f8b1859582cd78a31177043c3d61489c19f.camel@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <35248f8b1859582cd78a31177043c3d61489c19f.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/2026 5:10 AM, Edgecombe, Rick P wrote:
> On Fri, 2026-08-21 at 17:39 +0800, Binbin Wu wrote:
>> Add a tdx_hkid_alloc() helper that charges the misc cgroup before
>> allocating an HKID, and unwind the charge if HKID allocation fails.
>>
>> __tdx_td_init() currently allocates an HKID before charging the misc
>> cgroup. If the charge fails, the error path calls tdx_hkid_free(), which
>> uncharges a resource that was never successfully charged. This can make
>> the misc-cgroup usage negative.
>>
>> Charge the cgroup before allocating the HKID.  Wrapping both steps in
>> tdx_hkid_alloc() makes it the exact counterpart of tdx_hkid_free(), i.e.
>> keeps resource allocation and release symmetric, and lets __tdx_td_init()
>> simply bail on failure instead of open coding the unwind.
>>
>> Reported-by: sashiko-bot@kernel.org
>> Closes: https://lore.kernel.org/all/20260710040153.D8EA71F000E9@smtp.kernel.org
>> Closes: https://lore.kernel.org/all/20260718020348.3B4221F000E9@smtp.kernel.org
>> Fixes: 7c035bea9407 ("KVM: TDX: Register TDX host key IDs to cgroup misc controller")
>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> 
> As a straightforward bug fix:
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> But it seems a bit awkward how the keyid allocator is carefully hidden away in
> arch/x86 but the KVM caller does the cgroup maintenance. Hmm, I'd wonder if we
> could move the struct misc_cg pointer to struct tdx_td or otherwise pass it in,
> and make this stuff managed by arch/x86.
> 
> I think the only reason it is KVM managed is that an old cgroup patch got
> applied on top of the base series. The old design from the era of that patch had
> the keyid range exported, and KVM used it to manage the keyid allocation. Then
> when the keyid range got hidden, it resulted in the alloc/free functions getting
> exported. So I wonder if the new tdx_hkid_alloc() should live in arch/x86.
> Otherwise we are doing the thing where KVM just wraps arch/x86 exports to do
> what it needed to do in the first place.

Yes, make sense.

> 
> But not needed for this patch in any case.

It could be a separate cleanup patch.


