Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E4C40F750;
	Thu,  8 Oct 2026 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446653; cv=none; b=SkN8V6Jql19R+oQWYWonIuijKoQyNxMO2QaDpCO96nm8wyGJM3WLDBmAGidWfi0xKxtSOGTaptEbF7tWD/YylfF0G3pglAcNV7Xzj/rPRLpphkClJBwCLZrg3XMq02USRCJqNU5p+7F+VlE9DDOnXUuvbeilwAGkbkrBid7NPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446653; c=relaxed/simple;
	bh=iPRuigRTgI7UNa3JZXmJoZRbz2L9mD3CYobEwbxw4JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWNyzcfX5GCDqGek62v4SMo+GOnLq5ZWQLFeinAaXK1rHBvrvQhJb1YXAGKviCg9hZJfhIX5ohD315akjUxg2jZBgP7f5A9NPFPlh8fWzU/h44cFGRvVfPzqxl87fYOw0V/aDxcbMiG1J+tJUywZibWhfM9ib2q4u8IIeO6Qz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TboxvBHr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TboxvBHr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791446652; x=1822982652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iPRuigRTgI7UNa3JZXmJoZRbz2L9mD3CYobEwbxw4JA=;
  b=TboxvBHrmnfXx4RRWMf4RkiGJloUxWwMrq8H26GN0rYK0Tu/YZvPHfb9
   5JGzmpIWAAgEdr4Tjbz3HjR0K4v6HvvcTV0sKvQtb5euiipJBJSLwQKyL
   9S/6eq3/8+LZlmqE3PXTJ4dm4BRrPgZBryv6XjwPmFveyFZ8WRtSWbZui
   8d4AaRa+OHgF/Url0vFdL/6uE8BAa8uemdYSOmKY29A3JTKoAeILeJPzW
   acY+17F4s0Qg5JsjJ+MB72OIm6b0xr0Kl8rz4lUtJt2RbBSoTvLs6GB6n
   l1A60WG7ZMWxLcw9VFMP6anHdW41BcZJ31RBaOFiYp2ieOr4t+Zlvinbi
   w==;
X-CSE-ConnectionGUID: JMgb1kt+SbePiCpGDOjVTQ==
X-CSE-MsgGUID: yWC+gteQQa28VPz5mNJjCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="110473"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="110473"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 01:04:12 -0700
X-CSE-ConnectionGUID: s14q95EyThmD4zFM9Pa1wQ==
X-CSE-MsgGUID: QJhsjLNATxi+jXB4XZGVKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="323577"
Received: from unknown (HELO [10.238.2.98]) ([10.238.2.98])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 01:04:08 -0700
Message-ID: <2036b58e-d2cb-4992-97d4-cb136bb0a387@linux.intel.com>
Date: Thu, 8 Oct 2026 16:04:06 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] KVM: TDX: Ratelimit the "EPT Violation on pending
 acceptance page" warning
To: Yan Zhao <yan.y.zhao@intel.com>, Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 James Houghton <jthoughton@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Ackerley Tng <ackerleytng@google.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Sashiko Bot <sashiko-bot@kernel.org>
References: <20260930001127.3170009-1-seanjc@google.com>
 <20260930001127.3170009-4-seanjc@google.com>
 <ascJReVNL2N4lJau@yzhao56-desk.sh.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <ascJReVNL2N4lJau@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/2026 11:08 AM, Yan Zhao wrote:
> On Tue, Sep 29, 2026 at 05:11:27PM -0700, Sean Christopherson wrote:
>> Ratelimit TDX's kernel logging when a guest accesses an unaccepted page and
>> has opted to disable EPT Violation #VEs for unaccepted accesses, as the
>> pr_warn() is trivial for a misbehaving userspace to trigger.
> Since the pr_warn() is previously accompanied by a kvm_vm_dead(), which kicks
> off all vCPUs and disallows re-entry, a misbehaving guest should not be able to
> trigger pr_warn() more than once.
> Or are you concerned about the pr_warn() being triggered by multiple misbehaving
> guests? But would it be better to print for each guest?

Sashiko reported the issue due to the change introduced in the patch 2.

  Will this change allow a malicious or buggy userspace VMM to flood the host
  kernel log?

  By replacing kvm_vm_dead() with KVM_REQ_TRIPLE_FAULT and returning 1, KVM
  will clear the request during vcpu_enter_guest() and exit to userspace with
  KVM_EXIT_SHUTDOWN. If the VMM ignores this exit and repeatedly calls KVM_RUN
  without resetting the vCPU, KVM will immediately re-enter the guest.

In this case, is the Fixes tag pointing to e6a85781f783 needed?

> 
>> Fixes: e6a85781f783 ("KVM: TDX: Detect unexpected SEPT violations due to pending SPTEs")
>> Cc: stable@vger.kernel.org
>> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
>> Closes: https://lore.kernel.org/all/20260923164348.2DB2D1F000FF@smtp.kernel.org
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> ---
>>  arch/x86/kvm/vmx/tdx.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index e3723f1222fc..4cac43299851 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
>> @@ -1937,8 +1937,8 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
>>  
>>  	if (vt_is_tdx_private_gpa(vcpu->kvm, gpa)) {
>>  		if (tdx_is_sept_violation_unexpected_pending(vcpu)) {
>> -			pr_warn("Guest access before accepting 0x%llx on vCPU %d\n",
>> -				gpa, vcpu->vcpu_id);
>> +			pr_warn_ratelimited("Guest access before accepting 0x%llx on vCPU %d\n",
>> +					    gpa, vcpu->vcpu_id);
>>  			kvm_prepare_shutdown_exit(vcpu);
>>  			return 0;
>>  		}
>> -- 
>> 2.56.0.rc1.315.gc6ed9934b7-goog
>>
> 

