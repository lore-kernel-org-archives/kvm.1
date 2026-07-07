Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB214480946
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461367; cv=none; b=NVfoDsZ0Z+VBAaNfOO4DCWVlUx+4DiaKAorzhgt3rW/O8e35deKFGwsilV9biBfRaHD/JI8t7dfROzrglGBTUXLh2ofpOAJNp7Tn0H4CfOMZ9sSg45KLIYQu/s4rEBf4Y6PqNdffan9AWHmLg6IWhAmoh4yiT0giMkCj6Y+t1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461367; c=relaxed/simple;
	bh=lcSX7wCiKhMfn9Aj2tF8/IHgpw9MSCDR5lmvSzHU4ng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=seyrzkANQRsLYCTCCHT8neltUk5ud08l8JXforz7mRZ+NfGnuClFa9YNGI4+gcCBSPMw9jGCTbr3IM1mK9STAE4UGZG0PlhPGBnFxgtAMHbt5/V3RFudehc+ZSY7oDcWdgoFzPJyNflsrSM2TpXlMt/4QCB0G4sx7QrzEf0nidQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NwkQML4X; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NwkQML4X"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so906765ad.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 14:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783461365; x=1784066165; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0hWbsqrGNSQLEq0KyayeGwYCXe9bS5W8pXklldJ77o=;
        b=NwkQML4XFFQcFoUNtS1sar97inP9HbbArSCwb/xJ7qsjln4Gch8hHLOOIgypXwJ2pK
         pa6R7ZArwGEtUBEQ8o4qgMVnt/MeUzGoEQYZ7/on5hTv4p4vb8JSp+lenmUIDjSbXZPX
         zL05eRJK23xNULdqq61mRdiaohPanzQfNpyuX2QA2Bb328X5OWsGDDDTME/X7Ec8aqFT
         xizOw5ciG+FOk7Ft+wMTVUXNFYRLoOq0zP9EI++uJ10YqKfDvvwmHwxRHDe32SBIcpyX
         7ynMWplJb1KpsHtE03ygniBdb2KdjRB6BlCpwnmMoQvmjRgjcU6TCIpaKHkrOr8GFzFU
         ICjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783461365; x=1784066165;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p0hWbsqrGNSQLEq0KyayeGwYCXe9bS5W8pXklldJ77o=;
        b=hHDEhQD7DhukRoeydRGS4qwJW0Mg5iqjww7HBwdWJiZPqen6Mz/uPrBTqd474+C7Yn
         RCOLXQOybXN8fHr+SsZWYnAVnvQ+r2I6YggBOk5CIr1w37lsSFsMghKx4i1rmgby6T4B
         4x6SZSVjHC6GH64noG56vCmfubp7ChkRyY+uiZZUc3kfV0CREkc3G5PhQLwLvu4NRiCT
         76gmHIlM0gF4FJAg2c6cOEx07EHKhn/eE12Lx189VMtvPc1yGBWcgVDOtCjMxAXHu9yL
         H2moe91NutESz/u+/uV2H4qD7npMw/NRgKw54MN66AbG9sDMYem/aBTGpBivrNv3v5ct
         ILVg==
X-Forwarded-Encrypted: i=1; AHgh+RpOc02nfuLWitpifgstj51cm+z1ArAovsOeg5iSV3bTyqSAxnQx2qHMpMI4zdz3zHb+Qe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5tnNwzhlaLFe913ZjGwfuTTjeK8XRwXaL9y9F8UPzi/rhg4RB
	qgqAJcBn522b7Wg9nCwvP8SFM27z3iqHxXoBmehVQnbI81v5lZTvxTFSD6+/0GyNfD6qI2KwC1V
	S5+8m6A==
X-Received: from plck21.prod.google.com ([2002:a17:902:f295:b0:2cc:79e2:e717])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84f:b0:2ca:64d3:f0da
 with SMTP id d9443c01a7336-2ccbf06b525mr64867165ad.32.1783461364987; Tue, 07
 Jul 2026 14:56:04 -0700 (PDT)
Date: Tue, 7 Jul 2026 14:56:04 -0700
In-Reply-To: <20260706195413.1966458-5-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706195413.1966458-1-yosry@kernel.org> <20260706195413.1966458-5-yosry@kernel.org>
Message-ID: <ak119GtNZOmBpGmW@google.com>
Subject: Re: [PATCH v2 4/7] KVM: x86: Add a per-vendor callback to setup EFER caps
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 06, 2026, Yosry Ahmed wrote:
> Move handling EFER.SVME and EFER.LMSLE from hardware setup to a new
> optional per-vendor callback invoked from kvm_setup_efer_caps(). This
> centralizes allowed EFER bits handling to kvm_setup_efer_caps(),
> facilitating following changes to move efer_reserved_bits into kvm_caps.
> 
> Move the call to kvm_setup_efer_caps() after per-vendor ops are
> initialized.

Why?

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a0b2c40d93c21..a297a77469b38 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6903,6 +6903,8 @@ static void kvm_setup_efer_caps(void)
>  
>  	if (kvm_cpu_cap_has(X86_FEATURE_AUTOIBRS))
>  		kvm_enable_efer_bits(EFER_AUTOIBRS);
> +
> +	kvm_x86_call(setup_efer_caps)();

I would rather move the togging to kvm_setup_efer_caps(), e.g.

  static void kvm_setup_efer_caps(void)
  {
	/* Enable syscall by default because its emulated by KVM */
	kvm_caps.supported_efer_bits = (u64)EFER_SCE;

	if (kvm_cpu_cap_has(X86_FEATURE_LM))
		kvm_caps.supported_efer_bits |= (EFER_LME | EFER_LMA);

	if (kvm_cpu_cap_has(X86_FEATURE_NX))
		kvm_caps.supported_efer_bits |= EFER_NX;

	if (kvm_cpu_cap_has(X86_FEATURE_FXSR_OPT))
		kvm_caps.supported_efer_bits |= EFER_FFXSR;

	if (kvm_cpu_cap_has(X86_FEATURE_AUTOIBRS))
		kvm_caps.supported_efer_bits |= EFER_AUTOIBRS;

	if (kvm_cpu_cap_has(X86_FEATURE_SVM)) {
		kvm_caps.supported_efer_bits |= EFER_SVME;
		if (!boot_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ))
			kvm_caps.supported_efer_bits |= EFER_LMSLE;
	}
  }
