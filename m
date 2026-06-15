Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB35522D7A9;
	Mon, 15 Jun 2026 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509774; cv=none; b=DyuVDR+Fio7oOUwup7ErVJQFzMl2M6GNAOB70DgyP6Dsxo0zMKeW3n0t28LZi2OndsZNq9LpQLFZswDMyj2aUZkfZyXUeRsysBJySLBWCBw4c4k5lnFH8MpiSJF80kZum+MdBra3SnoOiZXqt5mSuwHIEQl0Zj6QJmAXUOBNlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509774; c=relaxed/simple;
	bh=3lZBBr06fygo7ST7Xxrd+BVohacIS92ZVZG/4Wiqlhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLu+Jmc93KFWNmqQSLM3rP3M8TMfzqC4kSHqzPMXDMu/5a6P+ym704BO/TCCRwYWKI4Y/CGZdBy5yt2J6js5ZB3hGSCe+1X/aZwBAHqPK9Ij0EMWYdf7ZfLBaqTZvFeKw04tW63npC2c6/gJuW6aWVGGUY5NPWjT+nwFr9/o0hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/fsjvJl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/fsjvJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781509773; x=1813045773;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3lZBBr06fygo7ST7Xxrd+BVohacIS92ZVZG/4Wiqlhw=;
  b=R/fsjvJlBoiFMMIQQnI7szc09KaJU6UBXgfKypfYKJrWm0jU8sWObK2n
   M56X74Pj0H7pgHLlue3ldNpGwKy9bVhUM3+aG+txButu5bUrbdHs3hDe3
   mX+BR0OzVskon6zp2UghSKJEWOTGtjQu1lvRF9z0ZogQ1hXMKAluIwcNR
   OyIs30cEQWiO6XVAGxVNc1AEHzOklqK0a/ZiwXEFJC2Iqx77GUhMtk1CL
   5K+q1pjNgbUeeEnnDKCA8A7I9t1cfLugb6t8Xnh61yjeSDvWdMri5Oif8
   KCYKzw1qZn2UkihXVq8kGMY/MfTNyo8YWHc60LMslh6NQ4ZEBBMfCoqZ5
   A==;
X-CSE-ConnectionGUID: cs3sSShwRomhe2YwsbKHXw==
X-CSE-MsgGUID: KLhM6DE8Sk+hHy5VuypFZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="99663318"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="99663318"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 00:49:32 -0700
X-CSE-ConnectionGUID: zWsUn1SJSv+tcVEkdaUHdg==
X-CSE-MsgGUID: sW+WQZlfRFG+EpHs5ykahw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="243039749"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 00:49:29 -0700
Message-ID: <115aeae4-9d07-4872-a4ad-a776f4ef34d2@linux.intel.com>
Date: Mon, 15 Jun 2026 15:49:26 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/30] KVM: x86: Move eager_page_split to mmu.{c,h}
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-10-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-10-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Move KVM's eager_page_split module param to the MMU, as it is very much an
> MMU knob.
> 
> No functional change intended.
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/kvm/mmu.h     | 1 +
>  arch/x86/kvm/mmu/mmu.c | 3 +++
>  arch/x86/kvm/x86.c     | 3 ---
>  arch/x86/kvm/x86.h     | 2 --
>  4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 0eaea2d4fac9..d30676935fff 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -13,6 +13,7 @@ extern bool tdp_mmu_enabled;
>  #define tdp_mmu_enabled false
>  #endif
>  extern bool __read_mostly enable_mmio_caching;
> +extern bool eager_page_split;

Side topic, the attributes don't take effect for declarations, but in general,
does KVM/kernel coding style have a preference to keep it for
consistency/annotation or just drop it? 

