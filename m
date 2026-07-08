Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989EF31F99D
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783550457; cv=pass; b=mEktCTlgWBov96S3arCILGDHZ9lFNSOiA1fcyO43Vj0nj0GXKb+HBiRltbMusDueiaSpAmyphoPOKPOHvY0HW3A+IJl771lmhGBM1DvKEX5ELXJ+tirl6g2i/fVqzG7Nzpnruub1Xx0nsbzCpLar7b7sL8Du+I7vAoGhfQgJ23s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783550457; c=relaxed/simple;
	bh=rPldlDDv33O/lSfMUjwv2Bi9kjt+AmcV3PaA++c0lv0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDROmD206sfjxuo3hP3i+6RSHAoLAhgQ+7SkKsqETrqoKoHHSE7MFw+WAWi/j3+zuQ1wR4EqLoXXdeldN/1IehFi5/ST6bJtYKOvQQuS1xdEtAUdl03yUm5Aa0bF2blL4On0FW8jfVmIsej5JxQ0EvkewCBkVO7ofDMdjHilANo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iyrqjywP; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iyrqjywP"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc6dd436c6so12744015ad.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 15:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783550456; cv=none;
        d=google.com; s=arc-20260327;
        b=bzzo4ues17xt18Sf0HBHMnw03OtaPbyySV+3bcDUFRtofiYqFrlApnbTDxpJZgGFHx
         URmWi4sMHvW4B2Lkns21VR73jC2xpi1QKulpgOG3acThl5GEMblkIcawvlck9w4qCmFl
         ljm2syiFi3/HAY5HN/K9k5Z1xIfznAdW+48E4sNZSC4ONUrJTcz9p9IyeqMl5YsEjiM3
         CB5nkEigIP4UNAnaMgLAygCnsyWUidDL1nEmQtTQKvxm0tjSTToWAA1VbGzzctTYcoN7
         PT30z2Iod1Mk/AEizkHag7jFlYd6XU3Rrdj79ekJ/IeGnhA0ojxBPNZKBQgOwyYjyBuK
         CcVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=rPldlDDv33O/lSfMUjwv2Bi9kjt+AmcV3PaA++c0lv0=;
        fh=SH9t9TFPeQ8bPdsk3rquMb8Ls+3hlsbagh6aBc008A0=;
        b=sZ+khRHs531FCHc6CI4WaLOv0coQIM/hyaCJO0ZzM8m98kvJaCM5twvc8X+Ln10Naj
         D4zpFk41xEtx3Lk/4eufsHit0AoBX8HOGKUIJtByis88CZt2rNtDmsbIyGDrzFWfEsUw
         0Iy7guXSjyrZgKuBgZmaZ3L84FfxWesFJ9fHxFryL+EMfz/CfLvkgCcznHw2vtAb+GBJ
         Cmc/anPOjgMdgqqYVgONs/4fIT1GbIIT8e7IvyKXQe9MDnbGYpzuL3bJhaEjo+Dszh2Y
         MBg2ie/Pa8u6aXaJFTfohJYjp6Cl11L/kssq4acFeOPGIUxxdsKxUpCwftbFEe/nO6XQ
         dOBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783550456; x=1784155256; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rPldlDDv33O/lSfMUjwv2Bi9kjt+AmcV3PaA++c0lv0=;
        b=iyrqjywPI1nMVJHFRmdxDbaZomT4ToBsL93yGpnFnc1eOHgbrg2RCaggfG3S6OqOXo
         olIEAJdVpsxzeOrbocEQPoBNiM6DHhRzSTpu2soiGrS40hPuAhdAmrTkwQwACI1ey96q
         JjyYAfA2W5n/Z5rUQtOuZjgCRMBmLydMDUDkb0H9o40aiCA3BGJ1SfzVvTsby2/qvUQo
         ELrtwxcUmCPZ/ZoAKumTaWoFpUQLvQbO1jQTVLCv8GuI+T0gyiUFIX4Bfm+IF5ICVJ0q
         mAiyjKaMNiYCC0ohWcexVgs4cgs4KY2QKMgtz/jv4++1cah2VH6hPR/H1mh2xrusegOp
         p+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783550456; x=1784155256;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rPldlDDv33O/lSfMUjwv2Bi9kjt+AmcV3PaA++c0lv0=;
        b=pI0J2cAbwSl+oImn0WZcAdAoyXh6xaCi7ygJ6Ji5rDXrpX7G6nswA/jf4WJU8NU+sI
         wcIw4unlIs78++4h1UaGQfAAdbukpa0I25TkjtrKKH2pkBuN6/pLl1iu3gSdcW/9wFfd
         SPtipuqQo6SeqTHxlfpYMJk9fV1H+LdfTmm4xUf7D0FrFmX0Sc6UEiDaOPshRa40ZgEK
         59ed5dwooh0JJvp8lF18XFc8QEJ9011g268SYfGocCsgseJZ/jS6DIsOWvqGt+B9EeAH
         cN3xk7k4s6iV99z2uXjeH5PIF6ntPlExdgbT3jTTpFsOVi6xpoo6Sc2yl1LVWWMthhDn
         A1iA==
X-Gm-Message-State: AOJu0Yxv1dVPNO5Ts4j0gQQuqs0Upm9xQNq2Y88QW0L7Nc0zysREJuZh
	cp+nsrQfFCo6jYyZNMqiYzRKF2EWLAlLim5hDJF7qfvuqztcdfx+RwChe2UdMPmMfxsYKqk2f0T
	uDHM9/E9pJ24BFoB1b0FwVEN72tRO2WDshRHMcIpI
X-Gm-Gg: AfdE7cmnEkixVOgiOnaO532GbwszhxMtHnq2VRdYRqM81HNqznhK8IyjoV8CMobMKxJ
	QwZXXVPqwhO42jkLozSBKMwK5uo/8F0x8jPWwEuuewBWbS09hotsbZWBvcygRGRnaYkyYtpfdSl
	YUtmJZlT5EhrhJZox4lz59d2yAYv4L0Rz1xn7QJe0k8k3eA5mj2l3rRUv41y/W3Kci8cAJjjfSq
	zXUI0gG0d3ooMFX629LO99fm3/2hynHzPywF7gZQukwgLX/LDN7PHAcElUQ/t0KoaMMigrGPHzX
	fFxQpHBJhy9qEnHskULY68TEFrGqF9zc9V/ncVKM3LffcJ0BOd6T2Qjrbx8=
X-Received: by 2002:a05:6a20:1581:b0:3b4:71c1:ab29 with SMTP id
 adf61e73a8af0-3c0bcf5d7e7mr5058514637.16.1783550455409; Wed, 08 Jul 2026
 15:40:55 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 15:40:54 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 15:40:54 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260630222607.497895-5-seanjc@google.com>
References: <20260630222607.497895-1-seanjc@google.com> <20260630222607.497895-5-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 8 Jul 2026 15:40:54 -0700
X-Gm-Features: AVVi8CdM7hMxBo7Sfpocmu0dZ7I0zxs1RszJRY-7TomLOnZ6z46E6Uj88Dzzjh0
Message-ID: <CAEvNRgG-Q_aci8rU7bBXoYyo73RsNDEAYT5vnr2oFF-nWizQGA@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] KVM: Rename .gmem_invalidate() to .gmem_reclaim_memory()
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Rename .gmem_invalidate() to .gmem_reclaim_memory() as the hook is called
> when a folio is freed, which is far too late and lacks sufficient
> information for KVM to actually invalidate its usage of the memory.
>
> Keep guest_memfd's trampoline, even though it would be trivial to wire up
> .free_folio() directly to an arch callback, to avoid bleeding guest_memfd
> internals into arch code (specifically, avoid referencing folios in arch
> code).
>
> Opportunistically guard kvm_x86_ops.gmem_reclaim_memory() with an ifdef to
> ensure the callback will actually be called, e.g. so that non-SEV code
> doesn't try to wire up a callback without enabling
> CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE.

Shall we also rename this CONFIG to CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM_MEMORY?

>
> [...snip...]
>
