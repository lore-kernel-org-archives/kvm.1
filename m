Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597CA3AE6F5;
	Sat, 13 Jun 2026 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781341305; cv=none; b=bmoy55Kybk3gNj+9oBuGJomoZNfNl8RF7+4UCGDHSPNIpkxfDtFkEY7+RANzDyxscu08rbrVF48V34xEXNQcSKwwRrib4onVRvNl/Pg48X2a8R1zgaCEjTe5K8eRHUdgcy9EvxjsCt/IEC6bFQ07tb4P/zYfRMYAmL6iMKxBUrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781341305; c=relaxed/simple;
	bh=+hwRwDGNZxIM8yDsnEpkK1qNjRmGtaJabsWZqCZKTwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ha2aK6jGFqrT95APpT9/DDZB//oo7G7c23iaoU0+0FXGT/l/PqrS93/2YQJOROKChB1CYE7OJeOEoolll4kYzqpiW0hFZX+qtEbZjdXIUIIOat9qflmzBAGtDDiHD/efZSkga/vlY3HZlf2726W3fUrnXpo1YgBkEj+2ZqB/2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvlL5h7k; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvlL5h7k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781341300; x=1812877300;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+hwRwDGNZxIM8yDsnEpkK1qNjRmGtaJabsWZqCZKTwo=;
  b=HvlL5h7kixtFnl55/PxOP2ilxog7ZUpInE1dudz8i1I2RjiSR6V6xkdt
   Q8yEZy5Cr2/ksdWbVj0724DkYnrsdR6fcRMqmYr0GvS2ceA/qEGT5/URp
   SFqD4Br9Kq4gpVZboEDnzhl0ZiORjwUl9i7oeHvLkJSv5ULjGNzXcOFiF
   htmhwASK3VQrHAuu1O+2f06GkYAkZUGiMvL3F89zLaiUtIYqiQccrhgXa
   fxM3uaV5/6q+0FhIG/16DrVnu2bkXm1Cxri9H7qw+FzQv/HzAHaj7DARX
   KZhdQoMZuniuILnMG3eTtupFe06I9VBtHqelMwjlYZuEOokCEEdqN7nG0
   A==;
X-CSE-ConnectionGUID: 3JyDFJVKTnGMoZ6ygbA6ew==
X-CSE-MsgGUID: 2dSmpvCLQJqKUpPNRuIxEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="82167070"
X-IronPort-AV: E=Sophos;i="6.24,202,1774335600"; 
   d="scan'208";a="82167070"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 02:01:39 -0700
X-CSE-ConnectionGUID: RL9Aa6JURSqe1uPcygEfkA==
X-CSE-MsgGUID: 72wEBZl9Qu2Hmqrbi4XCpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,202,1774335600"; 
   d="scan'208";a="252124397"
Received: from unknown (HELO [10.238.0.202]) ([10.238.0.202])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 02:01:36 -0700
Message-ID: <ea5bb362-f6ff-48e1-94f0-0b413969a186@intel.com>
Date: Sat, 13 Jun 2026 17:01:34 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/30] KVM: x86: Move kvm_caps and kvm_host_values to
 asm/kvm_host.h
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-7-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260613000329.732085-7-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Relocate the kvm_caps and kvm_host_values struct definitions and their
> associated global variable declarations to asm/kvm_host.h to allow for a
> variety of cleanups in x86.h and mmu.h, and to establish a (hopefully)
> maintainable rule that asm/kvm_host.h's role is to define common
> structures (and declare any associated globals), and anything needed by
> arch-neutral KVM.
> 
> While it would be lovely to trim kvm_host.h down to the point where it
> *only* holds things needed by arch-neutral and/or non-KVM code, multiple
> attempts to do just that have failed miserably.  Trying to "hide" code
> from arch-neutral KVM is too restrictive (and ultimately pointless), and
> KVM x86 itself also needs a place to define common structures and their
> globals, e.g. to avoid inconsistent header include chains and/or misplaced
> helpers.
> 
> E.g. as pointed out by Kai, it's weird that x86.h, which is a kitchen sink
> of sorts, includes regs.h, but not mmu.h.  Literally the only reason that
> x86.h doesn't include mmu.h is that mmu.h references kvm_host, which is
> currently defined in x86.h.  As a result of odd include ordering, the
> very clearly MMU-specific helper mmu_is_nested() lives in x86.h, not mmu.h
> 
> "Fix" the kvm_host dependency so that x86.h can be the "central" include
> everyone expects it to be, and set KVM x86 on the path to having somewhat
> sensible "rules" for what goes where:
> 
>    - asm/kvm_host.h holds "common" structure definitions and associated key
>      global variables, and things that are referenced by arch-neutral KVM.

I'm confused by the term "arch-neutral" all over the changelog. I 
suppose include/linux/kvm_host.h is arch-neutral while asm/kvm_host.h is 
arch-specific but not KVM internal only.

>    - <thing>.{c,h} holds relevant declarations and definitions.
>    - x86.{c,h} is the kitchen sink for everything else.
