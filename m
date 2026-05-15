Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9465E438FEE;
	Fri, 15 May 2026 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836287; cv=none; b=fNnVkDTY0hCAlfNa+79iDOGElhj1VMsG4TLqKsX95ez9hb1/Wzjf7rdTa7WDM7JnIAzpkpvD5qbF9QKVAPZcq9r/0V320ir5whcZfnlMfp0Zf7VW19Xcuyuz1as0FnoZ9tEoFwcNXpe3jS3ZR0HeU7nE5S+7OM7NZWPs1IDWgho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836287; c=relaxed/simple;
	bh=zGKaKQ6dtA7Hhr9fOKQeqiBMAzV9iwchLhWskzXRt9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJQUiZagfeEbIufhxfMREVEnkSyVwuAlYGn4nkRYyOkJEGcnoQ418vlySwP9ADF1C7f5R+hd98iyV5pLpXe7f52jrPO9xshGRInia4BuwI4CKbfB0ivWjCQt0SLFOonnrpBCpfBqdZ++7hXMQh4N+nVU10Dmk2V01+fIkJv/RRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvobcRCC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvobcRCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778836284; x=1810372284;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zGKaKQ6dtA7Hhr9fOKQeqiBMAzV9iwchLhWskzXRt9s=;
  b=EvobcRCCSvaUXyXd6Nioupdcqa+pdNRoXgzSyVNinJ2omgKPPafNrCKC
   GsVk4GxVAVMLZjjoPQxrZw4ZTSl4YOUzfkkSEQsOLm48LZtAr7Y1yHHYj
   qdPVAK8k4dZ97zJm0jEMOKVQyjUOup1hvFTOOu8XSEy4tUZaJVlXoXAYc
   D6qdLftcB/GFGkIl5RV1IJ+ydfE3cwU1ADqMGXA3kkq34gVtNohi7GLFq
   faa4H3ZSvlurZmzNp51DdCVBITUcpdQoRKTgkIaSazIdJLeP4nKOM+hT2
   wt8Qk62KT8W1C5rmQtZkIYgDLu7Ecb7Qlol8QrrGC//SmCAKVPQfCDQgR
   g==;
X-CSE-ConnectionGUID: 4X0IbyiURhetwrIAXwOwYw==
X-CSE-MsgGUID: gvGHnLqvSW+tqBYoHmIIsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79910578"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79910578"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:11:21 -0700
X-CSE-ConnectionGUID: RPS6GyU/RveP8/xcWkHClA==
X-CSE-MsgGUID: Xb5nik7jSP+wqEbR6HBnZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="237782088"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:11:18 -0700
Message-ID: <2050c851-37d0-4b26-b34b-f8c8a7c2b200@linux.intel.com>
Date: Fri, 15 May 2026 17:11:15 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] KVM: x86: Drop non-raw kvm_<reg>_write() helpers
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
 <20260514215355.1648463-10-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260514215355.1648463-10-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/2026 5:53 AM, Sean Christopherson wrote:
> Drop the non-raw, mode-aware kvm_<reg>_write() helpers as there is no
> usage in KVM, and in all likelihood there will never be usage in KVM as
> use of hardcoded registers in instructions is uncommon, and *modifying*
> hardcoded registers is practically unheard of.  While there are a few
> instructions that modify registers in mode-aware ways, e.g. REP string
> and some ENCLS varieties, the odds of KVM needing to emulate such
> instructions (outside of the fully emulator) are vanishingly small.
> 
> Drop kvm_<reg>_write() to prevent incorrect usage; _if_ a new instruction
> comes along that needs to modify a hardcoded register, this can be
> reverted.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/kvm/regs.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
> index b28e71caed25..52bed14f43e3 100644
> --- a/arch/x86/kvm/regs.h
> +++ b/arch/x86/kvm/regs.h
> @@ -61,11 +61,6 @@ static __always_inline unsigned long kvm_##lname##_read(struct kvm_vcpu *vcpu)
>  {											\
>  	return vcpu->arch.regs[VCPU_REGS_##uname] & kvm_reg_mode_mask(vcpu);		\
>  }											\
> -static __always_inline void kvm_##lname##_write(struct kvm_vcpu *vcpu,			\
> -						unsigned long val)			\
> -{											\
> -	vcpu->arch.regs[VCPU_REGS_##uname] = val & kvm_reg_mode_mask(vcpu);		\
> -}											\
>  static __always_inline unsigned long kvm_##lname##_read_raw(struct kvm_vcpu *vcpu)	\
>  {											\
>  	return vcpu->arch.regs[VCPU_REGS_##uname];					\

