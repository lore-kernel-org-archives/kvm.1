Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A785A3EF679;
	Fri, 15 May 2026 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830348; cv=none; b=f9OjvdCBs75Zf01D0U/8hliHSWampPIBp2q5fkGl2Owx5iWwMhrXl37BcQOLvAi+O7IvvxyM/zP9yukGdj1Ns1/hb3nsr/ovZTXr0ddItVpsgqE6XdRC70oyxaRv4J+dd9q/krPqXgdQxlQcdzodaoWTULfw6deCy6Za+Vcset4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830348; c=relaxed/simple;
	bh=C9RnqPp9TD7IsZxzUgq4iv/setTbDnuN+8X2WTmIHs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4OqfDFX+KvhrxJavdyM015CF2Tqy5iopZHvNskh/BmD2IaVoZfr04dcR5HjzIyUP3SVYRT4f3WAZ99FAMpxg8lG37Zs2+HNi9oq+lweROdmMygdj4Vtg79f3Em6MPpMMoHa5Wjqu6eD24gGiN6ODZ0fT03h/NZjypwBrgFAbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJJxTykr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJJxTykr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778830347; x=1810366347;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C9RnqPp9TD7IsZxzUgq4iv/setTbDnuN+8X2WTmIHs8=;
  b=PJJxTykrYD5dt5h21//SFGmegXJWzneMg4nRcE/e9nZQBGKZKTmi5A4T
   joxmDNu0hQxJhlKhP8lbcoui9H/VxipaAHcvQjBWb9ViDtjkN+mNAshQ8
   WQq205O3CAn9y6R8iyY0tDdV4kBr3Mlug0LHRvYLBkyZ6ijHxeKzqdQ8N
   dzkcZvAg3e9vhtDYzU7kOjjZNLrJJiNqFNk++i/kFnzeDY2WBejWm1/8i
   +P097OIsvoa3bIeUhebrWK9Un1ALPdoLNy1T/N79Kg/35bjPlcg2lVTr+
   dvXW0qYRd/P9tqDoawPekbXVx/rEN0tDj0LT27W37cusxSgJY9oI2md44
   Q==;
X-CSE-ConnectionGUID: L+CLlUN1QN689NTCK1Z4jQ==
X-CSE-MsgGUID: CsEHyko/R26mm9HPvdqzmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="97212295"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="97212295"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 00:32:26 -0700
X-CSE-ConnectionGUID: My+epgdRRnyvz3GhICJlsg==
X-CSE-MsgGUID: kcT0T8cDTOqH2tT69QiZgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238503586"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 00:32:22 -0700
Message-ID: <6dbb40eb-8052-49d8-9ee4-26645f4a2615@linux.intel.com>
Date: Fri, 15 May 2026 15:32:20 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] KVM: x86: Trace hypercall register *after*
 truncating values for 32-bit
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
 <20260514215355.1648463-6-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260514215355.1648463-6-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/2026 5:53 AM, Sean Christopherson wrote:
> When tracing hypercalls, invoke the tracepoint *after* truncating the
> register values for 32-bit guests so as not to record unused garbage (in
> the extremely unlikely scenario that the guest left garbage in a register
> after transitioning from 64-bit mode to 32-bit mode).
> 
> Fixes: 229456fc34b1 ("KVM: convert custom marker based tracing to event traces")
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/kvm/x86.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 209eae67ab18..23b3957b9ae0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10430,8 +10430,6 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
>  
>  	++vcpu->stat.hypercalls;
>  
> -	trace_kvm_hypercall(nr, a0, a1, a2, a3);
> -
>  	if (!op_64_bit) {
>  		nr &= 0xFFFFFFFF;
>  		a0 &= 0xFFFFFFFF;
> @@ -10440,6 +10438,8 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
>  		a3 &= 0xFFFFFFFF;
>  	}
>  
> +	trace_kvm_hypercall(nr, a0, a1, a2, a3);
> +
>  	if (cpl) {
>  		ret = -KVM_EPERM;
>  		goto out;

