Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.221.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792646446;
	b=kiNC3LbWeuqdkzQmRM93NenNyRbKGJCZg1MFmPQoLcZcTQgk1a5DcIFArimUxYBtd3YT
	 Aa/2ju7B+WC49zVb9OoR6i+e7E4GsRFV6XfpATuUvvgVKHe3yXc6pSlMrfwysjDLy5+xk
	 zwQzyNSSk+mHTH3U9UfaRem5Sh2HRSvckYyZZ94u1yUnL9us6fAVK5WV3d298NXFgZ80I
	 ZlvPJcFWjafQYg+ALpRw/nmeZW0PTPEpOUnwEmUwE6e+HTXr2qqTr1ZVO8n2zQdwqDcTe
	 3Jq5gamJfLoRLV2ivWef4wgF5WlyhP7shpPs2NQ501EoYOmfwu58paUr9gyXZfNGIhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5dV8J2o+756ExcNaGq9topEd2CgNZBpheBIgCfX69Gs=;
	b=Q5DVU1It2DTIO2ThL/hpIUo+x/yfnMgjO4DJuGipTSfOzVDOSclyPm39RgsHFLdeU7F6
	 qnxorehQdIgWOt1BnW6PYwsUVPSskonWbERjYnCbuzD5g9ujUZuggxnEKGawFJXbTubKM
	 F3XY4DexJ9BtpiuIvYT0+ta9ru7MgIXVdBr6iKR56Yh40uLCovvc9aS7jBQBy114UyLOW
	 tSU7GSXxEbFr5fur/70lGAj+89ylCwsjRT0q45y0qda7im9I49LG6HS6a4EfiRTN9qfFw
	 Sp2dfxHOLkkH1WkM4MygOLpxIk1Tykgp4Qt8RwvDAgXIMFAm6aBANn7Mp8Lj98XWo0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=aMLRwuAa;
	arc=fail smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79C2606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 05:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E79C2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=aMLRwuAa
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso1056518f8f.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 22:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792646444; cv=none;
        d=google.com; s=arc-20260327;
        b=lr0lJk+RkEfLX3jMSComiX47Lu9Depd+sAH/nPL5uocEIidqpeJLHaQ2YVYnFIJ/LS
         7KEK4JH27+e74loNqik/hDBGVVpYCCODMyXTI4I0FSJyXS7dJ4MxzN8bw83e0cfcA3rZ
         o1/+iJW6+YfuQeyqpFR5effh5xK9kjcNlTX8l29l9IG6yymViYX0OdmuBwcN99Avbahp
         unToAHMf476It94A8OBSxzy5NHXKN1UnL/MiD0BRrpWcfOkoUr7AUMh+V9UiLm8YU1S0
         les/oE2ichBSwHMpQTOZ8QxqDWDiy+x4NNsNJ/WOtZa7VnvNHT4360RAWXkMKGBw3Sw9
         4yXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5dV8J2o+756ExcNaGq9topEd2CgNZBpheBIgCfX69Gs=;
        fh=GPDKjzTiQjYvFmw1eBihzQyUBUoztraLxFnJ216PUrc=;
        b=k5yzaYuf76JGGPY0sAAyOgyBc54+pKONMM3846PTke3fFg+FCug7qdb8XiPLpC2lDl
         izs4N31cnzlIo4rVG4puxNf8q0cbuXIJJpMtMNqGI3uBMo5z4RwvtelXybu42b7vnwvo
         MCFIz51c3IKIpBKNfEz6SDnaoU4W0oLhcAY/C+qC+i+Aasl0m1pRoBRdc1/RDae1bH4e
         26RohkmuLr9IHx8R15w4UA/JHzOsyNKZQi4wfJshkxCXf2gNl81mSaGGp0W7LneizVAS
         5bvJJfRE00Vb0yJIlBqq4VrhjTK8LDcpTUPsf+ADWMHE1q7FSQuLB3MQGVMwqZC9mqD2
         tBHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1792646444; x=1793251244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5dV8J2o+756ExcNaGq9topEd2CgNZBpheBIgCfX69Gs=;
        b=aMLRwuAa3ERHVGJY70WDS+qGWqIhOrxtO8b8v9SoygeljlCPgsS9qiX1mL8rvP1xCx
         FpFHdwvboaJmbBGr42Q56PIl7PA7RvBcbqtwAEVi2tN7JoP0GFhzw6TJ/jsx/obytj8s
         x1yRMv9UObcXmBCnRgJhjYyreJWvs8m5mDy+84AR8tReeWe6fUhEZxtf22vfWX76lYhG
         SScV+wRoxe5BHsDMacZOCPSaBy2WtXc1rBxDM1OM8T1szLChNzv0BtbhLnsjUO7xsx/B
         jDQ98oAqxDtsehGTKaEZWTDbitUDthYS2qhR00W6DFto33fME86vzd3XSXRoSAHYw+AW
         eqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646444; x=1793251244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5dV8J2o+756ExcNaGq9topEd2CgNZBpheBIgCfX69Gs=;
        b=2ruzhOJAoJ87ybfLVGfDvvYkTR1mPaORXXzZYNvSSYre18ENV1xKNd1br+lqR1avdY
         wAj2+Yaz4rSv0K2sU2u7wa555IR1L3Hg8/ICw4ObxY2/Co9nfeRW1aug/Cb4WAneYrCC
         sThA2rHX7wj2sBHVkzel+DLLOKXLeOrgvyPFHwc214llgew5FzESB7SJfD4d5LWPcS8c
         f/R0OoBNysLdw755BmQyEyRI8IUYmw2XY65+Iaj8kWV5rSQjMvm8tCMVaxNHnWCxsvOT
         4Ded82Dm1FBxAgqb/vUqK7XQV+7vHTwPNhU5lr0ZZOSQAW/EdiBtplGfTqnmxxX1SHYV
         D+Hg==
X-Forwarded-Encrypted: i=1; AKwUvByJX+tiQP7UDpHENv5nnMDvA0G4EffslWTlh4tqGQQcDSU7AJ1nQhPGaysJIJXVIoy5qjQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYO4JfNzApTz9dRO1jgY2dK8DxLSrlG6bki6u1Gb8DDSDhShaF
	lfoIym1dVnsDqL2ZQ9fY+q5l/2uksytHl5oqTUXxPKbwEmMnUaYUdxhtuG0YWXy1i1/O2jYm585
	QWrUxTK92CMFYVEdv+rwe8jlInkVEwQfh3wFD1JSCoRq3raoXi8tx
X-Gm-Gg: AYBFou2tiGMtmRGH4WykK+EHZlWADEaDw2Ckcyp2b5oQRG35WgF+u2qWrpLjKFhkNi9
	x1t3e+chW/02ZBo6duSFSy1m3aTFdwpM3Rd78K55OFP2YSyLYo4O56/ryD/fQ9hK4VgEfya6NhB
	GsB28T9u/XVCNXFld3KPmESVe2liTrJ31fchqO0slP/2JOkV8nIgvfp7RsGRItjU1PNxQw6BBIj
	qLYkLvVGgplvlcBK3ug1Eb9VZQ3GzAXpbJgpUZ/dswM/k1xI9Xo12s9BHaksVThX3RxsdW9fHjy
	YqFIxKU62+KlRlurkk38EiI+/xD5MwAUlir6sh6dWmtR+1q3jPiPCDcypxJI46GeNW3Hszt1On2
	OcL2DM7sA0NlKtrmIxHKKL7SI2mEuWlmx9646WMDir6pkdtEzX7xKhrkOXk5DyqVuHjKZ4xTMaz
	AHV7mB2M0MCqhwOjitAyIOOvqW9aJRVbGIhMJ/QAUL0FAQCCVtRiQZoaVwWb+iFA/f77S2fKfln
	mORpg==
X-Received: by 2002:a05:6000:4025:b0:48d:c29e:40c3 with SMTP id
 ffacd0b85a97d-48e264bdcd8mr8669565f8f.33.1792646444331; Wed, 21 Oct 2026
 22:20:44 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019134709.2610129-1-andrew.jones@linux.dev> <atZPqGKEip_sW3fr@orel>
In-Reply-To: <atZPqGKEip_sW3fr@orel>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 22 Oct 2026 10:50:32 +0530
X-Gm-Features: AclHuK8Srkuid1EQZ7HZGvxQuXz3bcbCHVgrlN5FrFRdxoTbUp0B6JefKaok7ws
Message-ID: <CAAhSdy0KvbHT6iShPfMkhePP0V2cVohv6WcHWieWLwZYqkFnjg@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Convert IMSIC vsfile_lock to a raw spinlock
To: Andrew Jones <andrew.jones@linux.dev>
Cc: kvm-riscv@lists.infradead.org, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 10:46=E2=80=AFPM Andrew Jones <andrew.jones@linux.d=
ev> wrote:
>
> On Mon, Oct 19, 2026 at 03:47:09PM +0200, Andrew Jones wrote:
> > kvm_riscv_vcpu_aia_imsic_put() runs from the scheduler preemption
> > notifier with the raw runqueue lock held, so it must not take
> > vsfile_lock, an rwlock_t, which sleeps on PREEMPT_RT. All vsfile_lock
> > critical sections are short, so a raw spinlock is fine.
> >
> > Fixes: 4cec89db80ba ("RISC-V: KVM: Move HGEI[E|P] CSR access to IMSIC v=
irtualization")
> > Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
> > ---
> > v2:
> >  - Convert vsfile_lock to raw_spinlock_t instead of adding a separate
> >    hgei_lock [Anup]
>
> Hi Anup,
>
> Sashiko found an ABBA deadlock with this v2[1]. Making vsfile_lock
> exclusive serializes kvm_riscv_vcpu_aia_imsic_put(), which runs under
> rq->__lock, against the SW-file inject paths, which kick the vCPU
> (pi_lock/rq->__lock) while holding vsfile_lock. Lockdep confirms it with
> an EMUL mode guest, and the host then hangs (I should have tested with
> EMUL before...). v1 doesn't have the problem, since its hgei_lock never
> has anything that wakes tasks nested under it. I tested v1 in both EMUL
> mode and hwaccel mode [again] with lockdep and it's good.
>
> Should we take v1 instead?
>
> [1] https://sashiko.dev/#/patchset/20261019134709.2610129-1-andrew.jones@=
linux.dev?part=3D1
>

Okay, we will go ahead with your v1.

Regards,
Anup
