Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B747ECF3
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849089; cv=none; b=MXx1pTWZb1ZNj1W7jq+2Fc1BiBvjJ5YZQx16aNb9tWIiaixaIpDutIlAicduVat0stYNj1vlSj+wvLXgG03ct+CdwKCiReyVOJXldEzongOiTdBTuQvUAdS0ccbpedGQlYAsTK8/7Is0lWr1LWF3Ay9kMcxo5og58R3WRbb7ZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849089; c=relaxed/simple;
	bh=D0qkVSYtfJLlZ8TOrEivIn1n5QyAk3fpgbYhnjCMr6s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BRLBWMGvFE6ElzI4d6nq8tu16nU/7OO2QASryc0PfuLJgZ2G6VHWTdEkBsXEDnD10PICTnm5SzB99f61zKMCZNJIRygHeP+kw4rCONiijmJuW1h6AlhTshupg8Pf9asrgXcmPsEya7nPZJGOkwtvOvsbHrtayhTEziQRojrP3bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tmtFCt/s; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tmtFCt/s"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-366344513a3so17226777a91.3
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778849087; x=1779453887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=47Kj2f2F+IbQfpuhTArKbj0jkRV+0wrodEyOzmIpXTk=;
        b=tmtFCt/s2y0SsLie9k444Aa4RjffaDrYWfdlDhkBZvBCOQn3fuYscZKFTxh1kZ4LRA
         I455vmrY3Z9E1cBSfJWFQvgvOIQT8ilvgpkAZXNAk7LM0p0W6wRJW3K/H7jDIdiNBBbF
         I+BWynzsNNeVVdS8wI4IpP8wSxvsM8/EF8PctWvGnL31jl4mfvju3DHtU/Ucc3Xp7j2b
         SeYZ9sWOBXagcG3u3DBOmRgH/zXu0n7z8sjBVxk1yKRsFFkjUNqu9kw09IGkVfIit00G
         RelN7dB7bljGSbyI4nTVsje61bvg/60c4Hzlky9UXHtUeHGCLphSHSKvQW9wR2ZHrPWq
         N7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849087; x=1779453887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47Kj2f2F+IbQfpuhTArKbj0jkRV+0wrodEyOzmIpXTk=;
        b=q+UxlAstmDG7Zek0WBXtHR2KjWrT8mShNvIauj55s37rs7cD3udKI5AGlL315/hPkv
         Jy8x4TAK52oImEnCVer4KosX3g9Jy1X7lWKCxVuFhGupTwBBcvmGjLuuye6p3dz8Youz
         8aFYHO794oexyLY9hU34m2KokfFQsfBPA7USrUmUJKjh2lTNVu7Aro418taNlG0bHNy/
         sjMxxkrDAWM6FGE2pijd0Bo2M3SmUMS9Xz7GRq3nNNr3wyB0y5Ujaou0XDV5iN343IsJ
         KPzyQtxsCXx6uIfeN5p8ng5w0wdGGQYi/8un4wdGQ2SmXfTxBTCA6+pz0Fw0TVsYMcQs
         BIwQ==
X-Gm-Message-State: AOJu0Yz41/WsOs1JTGu8G14eWde5K3uZAxrLAIIZUw53b86idRWUQXU+
	ptn2pUM5aVw/jYxYSLUNXqQs77ZPGiHrcixGT3Yp1qlQnzZOBusZnGLAXWDao4J3fBjdIeBdmMl
	2WYh9sA==
X-Received: from pjbsh4.prod.google.com ([2002:a17:90b:5244:b0:368:9dc2:8e1c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d8d:b0:35e:3e86:e2d1
 with SMTP id 98e67ed59e1d1-369519df5d5mr3963391a91.7.1778849086696; Fri, 15
 May 2026 05:44:46 -0700 (PDT)
Date: Fri, 15 May 2026 05:44:37 -0700
In-Reply-To: <20260515111957.4188366-1-imammedo@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515111957.4188366-1-imammedo@redhat.com>
Message-ID: <agcVNezX5lf1_3O7@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/svm: work around Virtual VMLOAD/VMSAVE
 bug on Naples and Rome
From: Sean Christopherson <seanjc@google.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, babu.moger@amd.com
Content-Type: text/plain; charset="us-ascii"

On Fri, May 15, 2026, Igor Mammedov wrote:
> AMD Family 17h models 0x00-0x0f (Naples/Zen+) and 0x30-0x3f (Rome/Zen2)
> have a hardware bug where Virtual VMLOAD/VMSAVE causes spurious VMEXITs
> on VMLOAD/VMSAVE even with intercepts disabled, when the VMCB physical
> address as seen by L1 falls in [0x78000000, 0x80000000) range.
> Reserve this range on affected CPUs so the page allocator would never
> alocate the VMCB there.
> 
> Given that it's relative old CPUs + nested env + only performance
> impact, it's not worth fixing on KVM side (which could involve
> messing with allocator or reallocating VMCB, until it's not
> in affected range). And since test acts here as L1 it's not possible to fix
> issue in kernel (L0) anyway. Hence a quirk here, to prevent tests
> failures where we can't do anything about them.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CCed: AMD folks for awaraness and in case they would be willing
> to look into fixing issue on CPU side.

LOL.  Don't hold your breath.  According to AMD, Zen4 erratum 1454 is a firmware
issue.

https://lore.kernel.org/all/20241105160234.1300702-1-superm1@kernel.org

> there is not official EOL dates on both, but using a newer
> generation(s) release dates it appears that both are effectively
> discontinued for ~3-5 yeas
> ---
>  x86/svm.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/x86/svm.c b/x86/svm.c
> index a85da905..706ff2ef 100644
> --- a/x86/svm.c
> +++ b/x86/svm.c
> @@ -334,6 +334,21 @@ static void setup_npt(void)
>  	__setup_mmu_range(pml4e, 0, size, X86_MMU_MAP_USER);
>  }
>  
> +#define VLS_BUG_START	0x78000000ULL
> +#define VLS_BUG_END	0x80000000ULL
> +
> +static bool has_vls_bug(void)

Probably need to be more specific, because there appear to be multiple flavors
of vls bugs.  :-/

> +{
> +	u32 sig = cpuid(1).a;
> +	u32 fam = x86_family(sig);
> +	u32 model = x86_model(sig);
> +
> +	if (fam != 0x17)
> +		return false;
> +
> +	return model <= 0x0f || (model >= 0x30 && model <= 0x3f);
> +}
> +
>  static void setup_svm(void)
>  {
>  	void *hsave = alloc_page();
> @@ -413,6 +428,13 @@ int run_svm_tests(int ac, char **av, struct svm_test *svm_tests)
>  		return report_summary();
>  	}
>  
> +	if (has_vls_bug()) {
> +		phys_addr_t addr;
> +
> +		for (addr = VLS_BUG_START; addr < VLS_BUG_END; addr += PAGE_SIZE)
> +			reserve_pages(addr, 1);
> +	}
> +
>  	setup_svm();
>  
>  	vmcb = alloc_page();
> -- 
> 2.43.0
> 
