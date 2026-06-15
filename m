Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87DA30B50A;
	Mon, 15 Jun 2026 05:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781501144; cv=none; b=cxwPwkxo7gyMi1Gvdcr4IU0qOZ/KwICAGuClqsVjNWbk7EZ8xeMjBrhQwscJ54l9LgDmpc5USsBzt6ywV7F1SZxfiKFX4pZaSpwYTFXMD/Z0IUlP4MmIj6htefg3RXnSi0WnozmKhoQkd8TOjAq8QLs+rsy/jlrwFvO/+bnTM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781501144; c=relaxed/simple;
	bh=jxNRfHRED4vlaTzfm3C5fufGdYDoNurNhDLJiZp8aQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxKeVi/hyGeDIOz41psExqEVrYTg4QvoyrzIxY9qROLfO/jaxUo15gjJu93d0XZ9DPP/wuPGSphLa0akhXG8RM8Kpo4j5zmwcFELH4H8pqKT8ljoPaRERbjYWULaqBqndN0VVPwfHGcb5dBvxzNJIt/QgvjacLRQYM6VmAHYTJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8JM9l90; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8JM9l90"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781501143; x=1813037143;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jxNRfHRED4vlaTzfm3C5fufGdYDoNurNhDLJiZp8aQ0=;
  b=N8JM9l90JnXQEsk3hwAcF+hLDNhYoyp2I1Xw11qlxGvZhWn23nn8WTqz
   fyHqVXkXsUb6nS4Yf1Nt570RA4u+WdYkNNEmYUgLlGKdDroBYozL89nhB
   ssKOPDpd+KZu8y65MiGulSIVUqQxwIpi4JMzbwEBwy/eGgoY1r62cYMjK
   VjJoN2nKg0WSc5YGa7M9tLWUyTJH4407N7n00Fg+VfUwq3PKrGXiO78iQ
   ecu/1dhIlOm1ArsW33SFVT9W5LxaX+uWpIknexYA1AJV0mfot3cCjrjIO
   61ONoof9UWx+uxVER1mmvhzMG91LSgJoQgRmU+chL2Tww3Lnp6SWsx3Gq
   g==;
X-CSE-ConnectionGUID: M2gHZLwDSFupfAlF+BgPpA==
X-CSE-MsgGUID: xPqlMm4cRkemGrHorhkT1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="81370080"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="81370080"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 22:25:42 -0700
X-CSE-ConnectionGUID: bx4uasUhTLirkHV9zI97CQ==
X-CSE-MsgGUID: 0Mb/pfkCSsOb+9/4pbS78A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="251301139"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 22:25:40 -0700
Message-ID: <8275c274-79a1-4adf-b3f4-6675e7ef00e7@linux.intel.com>
Date: Mon, 15 Jun 2026 13:25:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/30] KVM: x86: Move the bulk of register specific
 code from x86.c to regs.c
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-5-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-5-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Introduce regs.c, and move the vast majority of register specific code out
> of x86.c and into regs.c.  Deliberately leave behind MSR code, as KVM's MSR
> support is complex enough to warrant its own compilation unit, and doesn't
> have much in common with the other register code.
> 
> Note, "struct kvm_sregs" has fields for EFER and MSR_IA32_APICBASE, and so
> the {G,S}ET_REGS flows technically contain a tiny amount of MSR code.
           ^
Should be {G,S}ET_SREGS

> MSR_IA32_APICBASE is already managed by lapic.c, and so doesn't require a
> "placement decision".  As for EFER, leave all other EFER handling in x86.c
> (later to be moved to msrs.c).  The primary interface to EFER, set_efer(),
> is very much MSR specific, even though EFER is arguably more of a Control
> Register than an MSR.
> 
> No functional change intended.
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

