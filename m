Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2CE3DB33D
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580689; cv=none; b=Yfskx11OaZBAmKH2g2Dq0RktCnL12kd5O5SIqPcrITKy1e12/xQ2vCF+3qHeiOFMdPz7zpS5p1p66pBqrTIFBhWPrsI84dE9codOn1wKPdCR74OAMar//lZx3Ehp3jKbqgS/ESXTWVDAQWFTK5wGthNjYkVe/LnQpsjJdLCyZhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580689; c=relaxed/simple;
	bh=VzjWA9vNgOcPmEN2qFVtcG/1dm70z7M0Ms2JTek35eE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=pBgFBnpc0KlQu9+nIIoEAymqdeqk62O8ujXqqxicsN520Bh7yEY6bxM5zgBPlHruhvNLW9eEQbZRRgbfOJiqFf0zQLKsJdUCEez1wkH9+wNuzVjvWof42Qo8ecyg2fLq85R9aFUpooBc0H8fmXwyyC4weT6HejhH6sjBkgQeNU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPLCuU6b; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPLCuU6b"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so19958035ad.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 00:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783580687; x=1784185487; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RojLPltz8DwvvSu0nWycaSfVOIfQRK6RQOm7qxh34pM=;
        b=kPLCuU6bHiGV2/UDPW786unMNL2b7BU7gQRao3hlzyNdXkHM6nvOxl31tsTRh3NFxl
         vvi1HA3BrAk4g2ywMeKFC9Soz5zoRbJw46IRaGwC2qpMNJOf3cDrOllnrTYgFpgr3Wa+
         lYKpuhFrxlTdghdfOey4b87GIaZPF85QemiXe8UrV+3xM6/sUmw2+Q2WXlmYP2cLJNop
         5RO9M6umpDzbf93cUKltUCD40BmcZXnL0zhlRa/qQZpQojT49mDBBezGwPMNIJlDEhlo
         PMPczpWaYSUJkil+LivEwEX+cTuOLas1ETSt/L0loeu6S9pUPc9An2SWQ1J2jcjDtpDd
         pnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783580687; x=1784185487;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RojLPltz8DwvvSu0nWycaSfVOIfQRK6RQOm7qxh34pM=;
        b=lMOAnc4lqJjvZtzoRX2DEjgMgPGL4EmagQoeZ/ocmyjycXZnR+0oyGoqHUjDQ3lOXY
         BTbTl2EMk/bpXe/1Y5VpFDL/WmA4fYoYrP5Y9GoAUtZ8lvkZ2g71mpLtRWvz0mOpqeGC
         bwPa1CDod/TjzYEtHGKX335a/F4c9dQeEsY1xhb0r0eBoxuu0gNK4u2DcCsmMPnMDdaM
         UUyN1wMqXBPcZebcOXDKqO9SibKBxC3ZMyHDcnWQKMCkddGLPsrYmmuYpQWToKsfbQnK
         btf41wVEUSDuhOkp/6J1anbSUzjnsAcHvylBg8PXRU6Qt1OOk/3QtZB/8Se+EzlkvpoV
         0iqA==
X-Forwarded-Encrypted: i=1; AHgh+RpZt5K0R38MXm799LoPGw/DigO3k97brKXTMT5qgn5snQmM9WPVJVhK5hhjLstzQFMd2N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQVgHFy5EvqgpgEbCOrrF7JA4fQrMHaKwI9d89/27lPijreQA
	3rZTV4rP4oG7SfuZrtb+gWTZHEdcnp+oUESxP0wV3z01XYbcTqyl+qfp
X-Gm-Gg: AfdE7cnZbdZ4BzKCahLwhvCOf0Cf+XAA+73blopyTmRn4f5KdPRbyVBGDMPFJJU5AK8
	wN1uiEhIWuUhpS2ZAfW8t6lIoa2yyTw92JE8c2EztRYmNHcZNsD84TGRBsVUr+QOnWM8SbT7XNL
	ada64OtstkiLZa2G1R2xavv/wxInc9ogNLoCGEI69iJk//XOOsWAQCqS/BTLV8p0H90NFtgbif3
	sMbA80sDv8xPTPqcOk1UJ2wLVA+n5IpZQFmBAoIGhCSN7DEVZWN9sfCu6WcdvgDlWiypwxNTFLg
	XzWKJ5AFf46J/WDp+dNhNg3nZ5cEQpnua+zapwm7nLM/fvNVK2PX4wFZKZulnh8ixoOWim72jEF
	P58DKhtFG1lUCQ8lVgVWSqh/oymmqTPqDwLkPxZNpZsjJpEpdRZ0Rz1pLqYpLZ3VlXrje2CqdIi
	TwEsMnPLfNSX4=
X-Received: by 2002:a05:6a20:d529:b0:3b4:85db:1bed with SMTP id adf61e73a8af0-3c0bcbc5c42mr6970115637.45.1783580687320;
        Thu, 09 Jul 2026 00:04:47 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6596681fsm31951861c88.8.2026.07.09.00.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:04:46 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Salman Farooq <salman.farooq3310@gmail.com>, maddy@linux.ibm.com
Cc: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Salman Farooq <salman.farooq3310@gmail.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix comment typos
In-Reply-To: <20260702030344.2211462-1-salman.farooq3310@gmail.com>
Date: Thu, 09 Jul 2026 12:31:04 +0530
Message-ID: <8q7kwssv.ritesh.list@gmail.com>
References: <20260702030344.2211462-1-salman.farooq3310@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Salman Farooq <salman.farooq3310@gmail.com> writes:

> Fix two instances of a misspelled word in comments.
>

Not sure what this will really get us and what is our maintainer take on
such spelling mistake fixes. I definitely hope we won't churn out a lot
of patches just to fix simple spell mistakes.
But FWIW, the change looks good to me, so:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Signed-off-by: Salman Farooq <salman.farooq3310@gmail.com>
> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
> index 5fbb95d90e99..6ac8364a7639 100644
> --- a/arch/powerpc/kvm/book3s_hv_uvmem.c
> +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
> @@ -163,7 +163,7 @@ static DEFINE_SPINLOCK(kvmppc_uvmem_bitmap_lock);
>   *  All its GFNs are moved to Normal-GFNs.
>   *
>   *  UV_TERMINATE transitions the secure-VM back to normal-VM. All
> - *  the secure-GFN and shared-GFNs are tranistioned to normal-GFN
> + *  the secure-GFN and shared-GFNs are transitioned to normal-GFN
>   *  Note: The contents of the normal-GFN is undefined at this point.
>   *
>   * GFN state implementation:
> @@ -1010,7 +1010,7 @@ static vm_fault_t kvmppc_uvmem_migrate_to_ram(struct vm_fault *vmf)
>  /*
>   * Release the device PFN back to the pool
>   *
> - * Gets called when secure GFN tranistions from a secure-PFN
> + * Gets called when secure GFN transitions from a secure-PFN
>   * to a normal PFN during H_SVM_PAGE_OUT.
>   * Gets called with kvm->arch.uvmem_lock held.
>   */
> -- 
> 2.55.0
