Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A160830BBB8;
	Tue, 14 Apr 2026 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157349; cv=none; b=rjtVhwZjPJE4RmhFc+o8JBrTtH8rp+f17YkxajX7jSyXZafVuvbcE6YBARnjju9sPXQnlLa3SgjIlOHaHp66zM+x7j6XfKtkTfexIEpdHF6hIYjMFlCASyYTXYN+vi2PaAogmLCfKQ8GJ4Qy755BcG1uyyq4BRtR+wysStaD7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157349; c=relaxed/simple;
	bh=0N5RTLSrxY95aejxvPQ8vZxB+b26mehKBbv597pm+10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNA5hD8FR7mOmwAXTNX3w1Bga2tFxmyo7/rKaPNhT1vtvXHveLb+WYE/YSPs3y9IU3epSK31XILBzCuq8J81GSnmwCZbUYU4K0CTw6cZVHp1FVkpY+cuLYnU3rH0AKe/FGRBfkSutlvatKaIbN0GVdMnmofg/ifzEi2hREq/bYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8+oSGjx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8+oSGjx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776157347; x=1807693347;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0N5RTLSrxY95aejxvPQ8vZxB+b26mehKBbv597pm+10=;
  b=c8+oSGjxOWcPp0euSXdgA/ZkF/+AZlTX5j56xVGM5tJ7OGBXhPIOPCXn
   2cj1QT/GQ0muBYKQqmheoSgyDAhoGnbeD93wLEddvHCEpQtf6rTUhowes
   FzEKL2cHe+hAiQOkq7DLJ0TnI1YgK3ujaN1S9a5h8uSPf7EkKBAVm5RO5
   VK7A51Cs2xkIdyeycvqt4oV8W1uxBuJCXi/zLv1ibwziieR+pzAC0BJWJ
   zDOFVBpBPpw7Ckd0f3DHIHTNbMZUfZzKCsuldLQG/H3LpAL/tFraR2bCQ
   y9AqUYEcQMuljNcHJf+4q5kyzyr3J4OmPRXrOq4MzEelgWNk6hURFh8qG
   w==;
X-CSE-ConnectionGUID: uHvzNPfERWioOS9b19iDkQ==
X-CSE-MsgGUID: B8hpQJDgSIWFZEP3PZmptA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="87731247"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="87731247"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:02:27 -0700
X-CSE-ConnectionGUID: LtvhdQdnTYGnxRe39pvQWw==
X-CSE-MsgGUID: 6pMz3faGRE+E9s8foisOzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227378950"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:02:25 -0700
Message-ID: <7c1afcda-5a7d-40b6-a992-5f38caa80462@linux.intel.com>
Date: Tue, 14 Apr 2026 17:02:22 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
References: <20260409235622.2052730-1-seanjc@google.com>
 <20260409235622.2052730-8-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260409235622.2052730-8-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/10/2026 7:56 AM, Sean Christopherson wrote:

[...]

> @@ -2542,18 +2542,18 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  
>  #ifdef CONFIG_X86_64
>  	if (is_64_bit_hypercall(vcpu)) {
> -		hc.param = kvm_rcx_read(vcpu);
> -		hc.ingpa = kvm_rdx_read(vcpu);
> -		hc.outgpa = kvm_r8_read(vcpu);
> +		hc.param = kvm_rcx_read_raw(vcpu);
> +		hc.ingpa = kvm_rdx_read_raw(vcpu);
> +		hc.outgpa = kvm_r8_read_raw(vcpu);
>  	} else
>  #endif
>  	{
> -		hc.param = ((u64)kvm_rdx_read(vcpu) << 32) |
> -			    (kvm_rax_read(vcpu) & 0xffffffff);
> -		hc.ingpa = ((u64)kvm_rbx_read(vcpu) << 32) |
> -			    (kvm_rcx_read(vcpu) & 0xffffffff);
> -		hc.outgpa = ((u64)kvm_rdi_read(vcpu) << 32) |
> -			     (kvm_rsi_read(vcpu) & 0xffffffff);
> +		hc.param = ((u64)kvm_rdx_read_raw(vcpu) << 32) |
> +			    (kvm_rdx_read_raw(vcpu) & 0xffffffff);
> +		hc.ingpa = ((u64)kvm_rdx_read_raw(vcpu) << 32) |
> +			    (kvm_rdx_read_raw(vcpu) & 0xffffffff);
> +		hc.outgpa = ((u64)kvm_rdx_read_raw(vcpu) << 32) |
> +			     (kvm_rdx_read_raw(vcpu) & 0xffffffff);

All registers become RDX, which seems not right.
Also, should "e" versions used here?  

>  	}
>  
>  	hc.code = hc.param & 0xffff;

[...]
