Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634D2DD5E2;
	Tue, 16 Jun 2026 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592393; cv=none; b=RFvVk90lsrzS9N3RO3PjbVcGTyJMtt3v4XKmZLP1loBgn05+XQi841Me4cOVmMGv5hFWT2JPA5cCYD7HrgmhHuMZvr61aAax5tx+keVJpebtOUY/FhFJT/u2NZTq8wfgDWQoMoW+N4O3JpSFf6cIj+O9maReCVCqBji0SYYuiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592393; c=relaxed/simple;
	bh=TZquXhF00f7rLY18AYS2fYjiHTfnNNEIUMNsH8choP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=no4MRr4ZfKjDqPn64RhVQkZB3WYhsBc4O2JQ4E7pIrXekMr5lA3HYWFYJrNXjftqSDFxqW7+Y6QLfv4K9bLr2FcWs1fjkMIPVmBv0jQ3wzJOFnRmh7xHuRlbgsORZpStvu3c6QhcEaVXg9o5t1VqQOpjtywleC5Axac9Nnfi5s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aviJ/hEq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aviJ/hEq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781592392; x=1813128392;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TZquXhF00f7rLY18AYS2fYjiHTfnNNEIUMNsH8choP8=;
  b=aviJ/hEqAr4MCFK4RnF5w9T8uGaw36r+QKELk+S0ToUga0VRqalt3gAq
   BTs5zWJ2V681w7+AP5ihEmWLC7ibuSi4Kfk6yrDthZ5eXtvIcdaQ/62t3
   CjjFY4vDxRrjZyRlAbYZuH8lLMXY6id2BMWmiPv5BjfchxWm8eH3t0Jdu
   ZhiTKtrN8KDEihBg3NwkW6JUNl8+w7GCcAVAvC5BLiLvRzgKoAxcsWLXz
   1Okz6lDjRwaUAaZixUSAD41AS52L4nE6Odm5n3P5j7FgHMOprsg3v5uPd
   8D+eVqt0MQkgANb+pD5xQEc0hOIr9X9gfthp38Z4XGlB8qg3USisYM3p1
   w==;
X-CSE-ConnectionGUID: Vkp8ph+RQzuFbNwqeT1Q/A==
X-CSE-MsgGUID: uDrpzP+CThOveMGR35mB/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82090549"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82090549"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 23:46:32 -0700
X-CSE-ConnectionGUID: vcFYQTFuSq2yRwpWFYe5Hg==
X-CSE-MsgGUID: FteTN44HQcSay2JN62tFyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="251984018"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 23:46:30 -0700
Message-ID: <4e5567a9-f3cb-43a4-ba7b-432ad5cff1dd@linux.intel.com>
Date: Tue, 16 Jun 2026 14:46:27 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/30] KVM: x86: Move misc "VALID MASK" defines from
 kvm_host.h => x86.c
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-23-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-23-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Move a variety of "VALID MASK" defines, e.g. that capture which flags in
> a given ioctl are supported by KVM, from kvm_host.h to x86.c.  The set of
> valid flags/bits is very much a KVM-internal detail, as the values from the
> hardcoded #defines are often captured and massaged by KVM's setup code, i.e.
> *directly* using the macros outside of KVM x86 would be actively dangerous.
> 
> No functional change intended.
> 
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

