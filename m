Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED1E3C3C0F
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222658; cv=none; b=ioyA6FhlBuOchX4MvU93K4b3Tid0KaSrw2CsLW2r6RfnBuP/KV7MCUAhKQLpn01HDkjCa5IW6BCZtZjkuwd8nmZuIjC84W9G/ePmK7iwIZO2JJRbpZ3NnuP0aiga3SpKveYfsbSchhdWeoz5Bxm9Bm9rr8cDGTnevfGoePALtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222658; c=relaxed/simple;
	bh=sITUUNKWqzTY5nA5d1dtCOT0qEP5ePE+d3ykIrAA9xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASGO0DDh7+sina65iwMBtZwUM+2b2iHvRI0n3CL/kqIVOoESdSJjaFkb4uKP+Y76SC1UqgRFW/q/7/1FG/wnPbK5GaKWl+Aa9LbvI6Ylle0WqCu6eGlRB9rMXceTJBrvO3p4KtrJ2AMubYcQaoPKyZqi0t2PtHfywVes2DBGfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BTGjis/L; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BTGjis/L"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso4693590f8f.3
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784222654; x=1784827454; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lKtR9Jxp2MImzZP0T9BC3u+TcUq704oO/4jwxoBn6sY=;
        b=BTGjis/Lhsrk4uYoxRLc3b8j1QsDavbFWvORIs1PFqkw5ZJoDCyi/u57vu8o4KNbd7
         hQiZqGuYycDzXgfIrlVyvfUAZ94X/n/XrQiuOcJFQhGenZ9DdSH5tmw7iaOVHbMWZaf9
         YTMG6fQT4cDnH75zFfCTNwZmla3pmHOKqKvOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784222654; x=1784827454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lKtR9Jxp2MImzZP0T9BC3u+TcUq704oO/4jwxoBn6sY=;
        b=pJ4X7Zmf3eCVLv1SLF2yDz0/T1gC7GVaFKfwlJC4a47jQAAu6wZ7bn63hYJk3JDJc4
         wBb5s0jB813hQ+7CxOvGC5a0qQrpijCMfWgRjAY+wmak6iHo+viFHLFCPG7T3xhxBWMs
         3KDWspywbc8FnPRd9AvHSXO8N4odUug3gTQYlFCRmodzWIpqwPQnwP1ItKAdEy74Yxqo
         DOSuSytmGXed1Tt1bOKnOtKiH7Tq7PqawN3/ciKEA/43Av5Xa7hp7GvGLs57ZYePpSEq
         NQby+KG3uWyqO1QhlYv1pvKKMo028UACoyXrVQ4CPgDk/1X/fBwhh4bfuHlEm96wf7Ai
         bl+A==
X-Gm-Message-State: AOJu0YwGwF971gODwDgwh0W11XC0Aj/SiSp59l8lQgKGEzPiZuLpGlW4
	ECC8DQTmXFr4DpTAn+El5f8Yl9XmilI03XzeaoZHBavo4BGVkP5XSugb5cbhGfHZhyNffELI4VK
	YMDv35Q==
X-Gm-Gg: AfdE7ckjGCEWv1/GTrgMh9UBZk2cZxHdmJrJThJGfQKC7tRZoKwQPDTWJrmD1vGVXSC
	pFj3EvCQPmUS4D4rcUdK89YiXHyZIlL2EMpR1zHRbsGRAEpDGgbqjTkWIigSt66IbUzAseGLjTI
	3Mgfw2mJecJ7VJYitDoawF59LXfM6RAY3GfmQv3yOlOGfudehc2dvER23KbZezG9UY+hrSi3Lu5
	xchcs2IRetaoUvAB5VbyvxUUKSQ8+Ve7m/B4h/Gl3PuZw4Nu5rYAwdQKxpTbVwmBvJw2hKHeVNl
	xxtDENuWQEbUeoHXZoHqS6yfj/qda4OkHMfOhQVscREWTnvEkdaGSP3s3wZ9cP2CCpGKOnB9DfO
	7KYB9QLzP/oxlqp+fVYAPXK8pqjlKnXQX4CdeUzq8Iynnvp3y4Ba0XOWzoyxCEV9Alfd2XK8Tsx
	14yDAwoIkTWXW91oN0hyNMFHKMlu4ueaAA1fSh
X-Received: by 2002:a05:600c:638f:b0:493:dcad:84da with SMTP id 5b1f17b1804b1-495158c6a66mr146906325e9.1.1784222654526;
        Thu, 16 Jul 2026 10:24:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:285b:8:ac40:81d7:8c61:d942])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e8c41asm73221925e9.9.2026.07.16.10.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:24:13 -0700 (PDT)
Date: Thu, 16 Jul 2026 19:24:10 +0200
From: Dmytro Maluka <dmaluka@chromium.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU
 creation
Message-ID: <alkTuicE2ELcakS9@google.com>
References: <20260716160801.3155582-1-dmaluka@chromium.org>
 <20260716162900.9D8131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716162900.9D8131F000E9@smtp.kernel.org>

On Thu, Jul 16, 2026 at 04:29:00PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Critical]
> This isn't a bug introduced by this patch, but does this exact same
> vulnerability exist in the AMD SVM AVIC code?
> 
> It looks like the SVM code suffers from the same use-after-free pattern
> when userspace creates a duplicate vCPU ID.

Seems plausible. Can someone with AMD expertise look into this?

> In arch/x86/kvm/svm/avic.c:avic_init_backing_page(), the newly allocated
> APIC backing page address is written into the VM-wide hardware IPI table
> before the vCPU ID duplicate check:
> 
>     WRITE_ONCE(kvm_svm->avic_physical_id_table[id], new_entry);
> 
> If the vCPU ID check later fails in kvm_vm_ioctl_create_vcpu(), the
> new vCPU is destroyed and kvm_free_lapic() frees the backing page:
> 
>     free_page((unsigned long)apic->regs);
> 
> However, the AVIC table is never updated to revert the overwrite.
> This leaves the physical address of the freed page in the hardware table,
> which could cause a hardware use-after-free if a guest subsequently sends
> an IPI to that ID.
> 
> Could we also implement vcpu_postcreate for SVM to postpone the AVIC
> table update, or do we need a separate fix for AMD?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260716160801.3155582-1-dmaluka@chromium.org?part=1
