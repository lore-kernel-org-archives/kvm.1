Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3316C311979;
	Fri, 15 May 2026 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837500; cv=none; b=Y9/S3q1tul90GbwfZb8SItx5w173+3Z7ons7IcsDe7FtQHXE4vngunJ+VBCznN4H0WheLPe2c3QNTD93ArOM7S2+tWEDbG3zzM2tteW2EWQzA4aBI/hZQcWk1eanKMmfBu96KX+C3183ta1Zw09m1yo4Idsg75v0VAv9hSRSsgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837500; c=relaxed/simple;
	bh=uCrBN2i8MRNXIZzYEXBbFXHwxmGM2py31n2aAD0Qz/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2sRYsEN10vSIe967kY4orY+BRwsY+WHEL4A2BZM/UhK3FA5R168XWLs8OKMbuoXIegnnZmyAxFvdFZ0g+Dvtrg78MKelEU8xErV17fGpFGsOtu3BaKaXCSy+Uy3xKMrGa2xrBhw9a+auOcja73bQydWj0YoaZIsEcI8adtMKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehMozInE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehMozInE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778837499; x=1810373499;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uCrBN2i8MRNXIZzYEXBbFXHwxmGM2py31n2aAD0Qz/A=;
  b=ehMozInECR5/13lBoQsDZc4EyxR9SFK7mj7nhHj7/8JCrGXILeF2ICJQ
   6j0DG3gVs+RJiSb9IyH2C0WjRmXZQ9dvEhw0FGTzlJ+ttoPUGJHQ8/5m6
   F5FWuBl1W7L+6AMtFZlHBKQl/MwP/QUOQG5Zp+iLmreTX6JKjUrLVedNt
   qLGiLpMMKYOToEFSNAurrsd+sNa+mANvk+trMOITDtywhDNNuC/4GdpTP
   pXw9BhWM+qNhH7esbQBdluOI7RilJzJqgBswwAS5TeCySGb6lys+Az2In
   JyGlLM6DNQrDrPbhljqhEE95NC+Vny/UQmGqXMvrfxjlGNSXJZkW4bel+
   g==;
X-CSE-ConnectionGUID: VpGfTs8bQYqaE86OLZXgGg==
X-CSE-MsgGUID: Xv8zlgzQRISK+PruiWnu6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="97365247"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="97365247"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:31:39 -0700
X-CSE-ConnectionGUID: PiRg6vWSRm+o+6fbqS2aOg==
X-CSE-MsgGUID: +TKPNNNMRSeNtMfLmGwIsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="268994395"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:31:35 -0700
Message-ID: <a4392de4-16ab-4a4d-a79f-966ab9e5061e@linux.intel.com>
Date: Fri, 15 May 2026 17:31:32 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] KVM: x86: Harden is_64_bit_hypercall() against
 bugs on 32-bit kernels
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
 <20260514215355.1648463-13-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260514215355.1648463-13-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2026 5:53 AM, Sean Christopherson wrote:
> Unconditionally return %false for is_64_bit_hypercall() on 32-bit kernels
> to guard against incorrectly setting guest_state_protected, and because
> in a (very) hypothetical world where 32-bit KVM supports protected guests,
> assuming a hypercall was made in 64-bit mode is flat out wrong.
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/kvm/regs.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
> index 52bed14f43e3..d4d2a47a4968 100644
> --- a/arch/x86/kvm/regs.h
> +++ b/arch/x86/kvm/regs.h
> @@ -39,12 +39,16 @@ static inline bool is_64_bit_mode(struct kvm_vcpu *vcpu)
>  
>  static inline bool is_64_bit_hypercall(struct kvm_vcpu *vcpu)
>  {
> +#ifdef CONFIG_X86_64
>  	/*
>  	 * If running with protected guest state, the CS register is not
>  	 * accessible. The hypercall register values will have had to been
>  	 * provided in 64-bit mode, so assume the guest is in 64-bit.
>  	 */
>  	return vcpu->arch.guest_state_protected || is_64_bit_mode(vcpu);
> +#else
> +	return false;
> +#endif
>  }
>  
>  static __always_inline unsigned long kvm_reg_mode_mask(struct kvm_vcpu *vcpu)

