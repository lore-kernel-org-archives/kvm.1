Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFA13B0595;
	Thu, 24 Sep 2026 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260858; cv=none; b=XpwoaOK9GzmHN6BscP8xI+vmrSv/LcIuZxuPKNbMdeA7kek1nBkiO0H2HV7DU3tVwpmKb+mu2BteBxrXwc8Fl49fzGstysNbGzsTv7dRDuqyUhBnETSPgIVLTwPggrcY/QorLcIsClT8YGiwrzqlcI4yoLFRGLJ9P7q2+VFcQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260858; c=relaxed/simple;
	bh=9nkdWvz9hhC1cz7bsXYe8wD1jlHlZ9/tNVri0cwsTMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvenGQPuk+QPZNZX2JNiIsuEb8XwoqiM/EyQjlfx9oYqOv5zwi5E9xmLo9A4T0O7uaySeRo0a4c56n5POhwRpsQXh6LVc5di3gPIf8cdHd6lQsG3WnapX4K4ySKVPt1mjHhGDypVYlXZeVsXKNIh4zZO1eofYTQu7haU6x9vndw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQjyXOVs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQjyXOVs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790260857; x=1821796857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9nkdWvz9hhC1cz7bsXYe8wD1jlHlZ9/tNVri0cwsTMs=;
  b=dQjyXOVs7WcEAzdQ1wHL+QY2iByVOV3s+D73yhZP7vC5EuP6O4L0YQ3V
   nj6SUap2PewzkADE3+t5a2xoPRkWZpA+h6KcBlZWKO1NjpDyNTp2Nb6tH
   g45QWw0SNjDC3dxDb7X5ceBG4za1q2ZuVGRspERv1RLf+0R17tR+Cd5g9
   7VSlDcsbPEJ1gLgkKwnr9/B0Le0FjOc990wFesCxJQv8m3fkqiB3CZPeB
   Sg+xmgKx9LbHvNAdYeyQbn7//d5tbZ3HoSMG74M5yV3SZJDrSFnS+c2wc
   9adR2GfD759g8v6c9dVpALjT+4lddE1OU0ZcHrLBNS2NYV6AYD4o8SysL
   Q==;
X-CSE-ConnectionGUID: jPHB+BOnQT+pSKhitxPWSw==
X-CSE-MsgGUID: 0zBdZf2wTmS6N+Vo0YERTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101206788"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="101206788"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 07:40:56 -0700
X-CSE-ConnectionGUID: fDqRe0w6RyeZ6OoGEPAW2A==
X-CSE-MsgGUID: jB/V1XkhQdK1qmUcwPt4GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="273616688"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 07:40:53 -0700
Message-ID: <5949c545-2104-4824-b007-5345fe0e5d7f@intel.com>
Date: Thu, 24 Sep 2026 22:40:50 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: TDX: Synthesize SHUTDOWN instead of returning -EIO
 on unhandled EPT violation
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 James Houghton <jthoughton@google.com>, Yan Zhao <yan.y.zhao@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ackerley Tng
 <ackerleytng@google.com>, Vishal Annapurve <vannapurve@google.com>
References: <20260923163315.1580860-1-seanjc@google.com>
 <50ccc54c-6cbb-4ae2-a84a-4dcbc958f91c@intel.com>
 <arUv_KydBD2kWkIo@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <arUv_KydBD2kWkIo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/2026 10:13 PM, Sean Christopherson wrote:
> On Thu, Sep 24, 2026, Xiaoyao Li wrote:
>> On 9/24/2026 12:33 AM, Sean Christopherson wrote:
>>> Synthesize a triple fault, i.e. exit to userspace with KVM_EXIT_SHUTDOWN,
>>> instead of returning -EIO from KVM_RUN if KVM encounters an EPT Violation
>>> due to a guest access to a pending page.  Returning -EIO implies KVM is
>>> buggy, and most VMMs will respond by completely terminating the VM, versus
>>> rebooting the VM in response to KVM_EXIT_SHUTDOWN.  I.e. give the VMM the
>>> option of trying to keep the VM (from the end user's perspective) alive.
>>
>> But reboot isn't good, neither.
>>
>> I still think a new specific exit reason[1] would be better, as I suggested before.
>>
>> [1] https://lore.kernel.org/kvm/1b0ea352-c645-461b-9e19-5202791f8e2d@intel.com
> 
> Doh, I completely forgot about that patch.  *sigh*
> 
> I actually thought KVM_EXIT_MEMORY_FAULT this time around, but I was worried that
> it would confuse a VMM.  And practically speaking, the VMM can't do anything other
> than print some diagnostic details and try to reboot the VM, because the guest has
> very deliberately opted out of #VEs.
> 
> An alternative to KVM_EXIT_SHUTDOWN would be
> 
>   vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
>   vcpu->run->system_event.type = KVM_SYSTEM_EVENT_TDX_FATAL;
>   vcpu->run->system_event.ndata = 1;
>   vcpu->run->system_event.data[0] = gpa;
> 
> So that the VMM could log the guilty GPA.  Though I'm not sure I like overloading
> an explicit guest event.
> 
> As for KVM_EXIT_GUEST_ERROR, I don't see the point.  As above, the VMM can't do
> anything other than reboot the VM.  I doubt Linux-as-a-guest will ever support an
> interface that allows recovering from this situation, because again, the entire
> point is treat unaccepted accesses as fatal conditions.
> 
> All in all, I think my vote is still for SHUTDOWN.

My concern is that userspace cannot differentiate between triple fault and
accessing a pending page if we return KVM_EXIT_SHUTDOWN. It's not friendly for
debugging.
