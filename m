Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F913C908;
	Mon, 10 Aug 2026 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786353843; cv=none; b=iQqg5gj/jcJ5SkwvoBE4yz82kFwUgegysC0cuudr+mGwqMGJmDsrxVBRb2oLcHeIcDOpCvqAGoJF+REOGofpMxhkaSbWXRK3M7sAitZPj2Qfl3ULaOfLHm3IJnYQI3XnjYxSuK1OU5YLrnO9LzK0Z7rZuGUTRnMnBEg7AXuy8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786353843; c=relaxed/simple;
	bh=LW2jP2NizVcdvwsMvxzQk6MgcoCMM4C0w6R2tDmhQHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDABd41YeZ1gFQmgNNIFP3qIAH6ybdETdNTzkDGwMKcY4JpJQEj5gIhiVBULcYhxexTOEzyuhaKn5K3EayDTH4m8DmWajGBBgtlv1D47XA/WMT/BrUvvMxRcvBvxTZ+5S7jy+KjYDRgfg6YktAIkOKaG1LrZ1yhW2e0dyuPeCio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljywc8QR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljywc8QR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786353842; x=1817889842;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LW2jP2NizVcdvwsMvxzQk6MgcoCMM4C0w6R2tDmhQHg=;
  b=ljywc8QRcegnmxKGrF9Xc6+QzLcO6w4OIlIx3+arIkmbKxFlPTVdljee
   CzDepEQmQLhuZmHeyojBp3XCRb/OPtaUPz9SCtrYCqZJcEvLBg6M2HOkY
   puur4GmSA3Y6yloSM0ejHTAgp5xuALJhBzPxZ7/N+1JqEqCVU1eUUKed2
   gaQY+zWIN2sFj7mBHbcXIvtqsyc3557MCDHiFRdCQ6T5fkdN6Ygw1ZRhg
   M2wDy6oz6Xo/8bsgnhEjK9tPrrjykD220XuvhxK6Q5JZCZ7FVvj4IfvTo
   +7bp2yOvm1RThYaQYwaJxSwJq3oHrmVYrLfdF3fMDLtNZuURVW8aYYGHK
   Q==;
X-CSE-ConnectionGUID: /MOgIU2OQvW3Ejs8TVblow==
X-CSE-MsgGUID: TdWOf1FBTMauAn5tvwhqfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="89385761"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="89385761"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 02:24:02 -0700
X-CSE-ConnectionGUID: wgELzn4wSnu6OjH2+R03sQ==
X-CSE-MsgGUID: za3+GbRRQjSyiJab1tnzEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="263603030"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.242.118]) ([10.124.242.118])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 02:24:00 -0700
Message-ID: <14193ad6-8046-44cb-99f5-d357e1b03d2d@linux.intel.com>
Date: Mon, 10 Aug 2026 17:23:56 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] KVM: TDX: Fix a benign off-by-one bug on the end
 GPA for INIT_MEM_REGION
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko Bot <sashiko-bot@kernel.org>,
 Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>,
 Haotian Jiang <jianghaotian.sunday@gmail.com>
References: <20260806170602.4112602-1-seanjc@google.com>
 <20260806170602.4112602-3-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260806170602.4112602-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/2026 1:06 AM, Sean Christopherson wrote:
> When verifying that the incoming GPA rage for INIT_MEM_REGION doesn't wrap,
> check the inclusive last GPA, not the exclusive last GPA.  Super duper
> technically, it's ok if the very last GPA is -1ull.  In practice, the flaw
> is benign as KVM x86 disallows memslots with GPAs that exceed MAXPHYADDR,
> i.e. INIT_MEM_REGION would fail with -EINVAL anyways due to the memslot
> check in kvm_gmem_populate().
> 
> Opportunistically use check_add_overflow() instead of manually checking for
> wrap, mostly so that the inclusive math doesn't need to be copy+pasted in
> the "is private" check.
> 
> Fixes: c846b451d3c5 ("KVM: TDX: Add an ioctl to create initial guest memory")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
