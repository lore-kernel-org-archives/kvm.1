Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BF8445AE5
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433430; cv=pass; b=BpHdQg+jegMlC+KAkGTSkXyIsF9ZCp7PfbnF4wwbvVPqlXup2b8fJsMgOsLmbDqhoNSLoo+kz2ESAThqriq0pwuMbjq1TywW4tupISzNAEHbd2ra/G4Y0TbVSwfylaL7i1ob4RyLqM+LPQbcRR0HMajc+ThZmeyFE5K6iJzu05A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433430; c=relaxed/simple;
	bh=OlBwlhKOiCMRiIdYne4F/M0ahn6Xw3rouRdmpnSET1s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWskRcU/P6KR0Zp7YDA64HQz59ALuG+WlJjejIUWMpfie6WK1S/0ho6P2bQ/p5YXFdqbQVappOcYq5OH5NO0kWA/d+2CeNDRtzvlWaH60BFWy9Aue/CQ6GviyoD1SFaMOBD+Wujk7gkkVhLTzsK8Qrw7lFcnPY7XkfCOHmK5LVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hoyCLUYD; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hoyCLUYD"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso144388a91.3
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 10:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785433427; cv=none;
        d=google.com; s=arc-20260327;
        b=g/QeWh6FJ9EDyp2Tfyat16OSK1X/GgmAqZfelnrZ8Zu35wvH9sq5GXFa1gY6M9ETQz
         NFQLxsEO999OgZIp20j9B2Dn6aVncHMF5j0als3KyGTcWycQ/KQIQm5O3Z/BChbUr/ue
         nXJb+eaeKcy/VULbUsBUHrHFsGh320minpmvHK1/PBIy1Y3du+Kd6p2nK4SkWFTB2LSW
         zJRgLUwGevl11xn5Q1DGw8ImOFqgm77OcyL0RCIXY7Z4NbxO4CX7I5dEiBZBnaOsndKy
         5d/9g5lOWF835OGOofN9a66W9YWbUtEJAZqSb2BaY/ubUlQ7xgXOs20r+PSwDsll5fFE
         CMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=63PGhmBtUzf4vUZbWnyFr9JI9DJZU2NrWkZa1qKZ4cY=;
        fh=UovrO0TvLiqRHU1kp7Fq/+U56YUYq5jh58TPdqHXeG0=;
        b=QRFCGrpOGc2q805KWYsR7gmeNkXY56qs8RngNIZ99QreNXmSVabw97Ju4VwOqOvEAt
         d5RD4DJjbesn+IF0HkvpvuvcBXhu3knwJMwOwHlTnCJmGx8UjAsaqqnbG0kOLhwXM3oa
         Frr9yOkCvRVBdSr70ozF2O898jC2HO/IYDsxYWi1oBRqPSMw7gRMgN2IcVJQTAZbkG2v
         la6fGy0aQsZ2n3dwBhy5SM2WpT55x4l6xgbtZXWupBwCnjazuFbTBXdNFT/3xdrFvueB
         hpUeBOOpVlPwXrAlUr2EE/L7Boapn7ezcigg4BIkR0C21JlJBzWnS5OSyxkxEJfAcANc
         8l2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785433427; x=1786038227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=63PGhmBtUzf4vUZbWnyFr9JI9DJZU2NrWkZa1qKZ4cY=;
        b=hoyCLUYD4G+jJRJ3ycSoXL6iJZGLfMkcqILSFDkWqU3Uk5eRCNjqGv+wxRy3rmMBjE
         11ByW3b/ItB1Wt2jMVErlLmgNZ3FKlqxk/v+6H0cI4YWAJvFSbT//2R6v06ZO9ohLj3P
         8h3mkTobAfXV5X5ug5DyFpxaHpYuLDUlutdocLSgYttwMPjQlfKr1MSt2E2p6Tyrh/DC
         ZpZUJwzsYJ6YJCZUy8c487DdWp7YXWc3TOYotB3di1bsm++FDW9Z+I7Gw5viiSaksePC
         KSvKlJRj6D+EtnNrijzG7iux+CTzpRPjc8lqN9CmVXNi5dJsPywJEB2uPvDrn8DyvEKT
         lfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433427; x=1786038227;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63PGhmBtUzf4vUZbWnyFr9JI9DJZU2NrWkZa1qKZ4cY=;
        b=sU3ASka/yBC3TcQIIjWyZ5P43y98x9re4cmkIUxA1dxtBQfomts7Q7Ml32EL7EsBd3
         XVoJqEg9yIft4EpvCoxMEc+rVV3TNXFM8MRPxQXFiKMFo6egnpU7VyQztvUtKYXV/WxO
         UG4vzF+H18wmvL0ff1Y8aGkP6V48+urfelj4p4NLSgJIwKJT96kjKKll5HXpbxpb4bLc
         IA5JFJ36wamM222XL94QL7CMau3Rm+OSKbkMvL6vi7Gl+/Gm4YVjeIavOcJPqGQEGcft
         bWD9COzgOSlpec91ijoy+vGG61a1VPfgF/StklGuNJ43gI4+AbloZa2RBYcxyRbKoV0Q
         6PdA==
X-Gm-Message-State: AOJu0Yx7iG6xWGNaywQAY34a1NK2oqQ5hx81DuF5j5kAR+Pe2DcRPnSh
	nSqPpCCv+fDjtabvhnSLbnsGtLr3fBNEnKui4nS5vbBaVIBloFHdouIUBqmw4/i0e0zhmYu+CfT
	+RgQHcMMYvcuUfuvbZfkE1aC+EQi7QVPGaiGd6pGV
X-Gm-Gg: AR+sD11kLdztIYr8r6thKBXvKzTWEYwe2t3c8dqPDxo/qLyoo7wWHNjKBUjOH6iF2bW
	H5K9uPgBp9Wu1ENQyhibvihQcbBZNT04636IFn0C5g3S5X7OK1733iA3fiidTMBIQHRGJmbUUui
	7OHYlusbkRpCBt6b4pIwcv4EX5oJC7WvhTUlL33tde6aj8qqSC2XWhpuD32U3Qvd7Pmcm/+vcaA
	fxqaCKvIMczkKw2tow+bvHUWiCJg3okrVhgPK2Gu/aC+tYKc4y8pZkHBjNkFPbCNhek86+Kij6v
	HWxrYc+0LDsMgbtRa33xKwNvvxEuTHMllEHaFLM0wnLr3x0AMNewd2LA92fc3x8lE+1DAFzvo2z
	nE2Q7ruCgO64dNUW33EFqm+N03GUKTIDntqPXEwJgMfpmJg==
X-Received: by 2002:a17:90b:1dc7:b0:38f:240d:b857 with SMTP id
 98e67ed59e1d1-38f9bda5d44mr2890773a91.2.1785433426437; Thu, 30 Jul 2026
 10:43:46 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 10:43:45 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 10:43:45 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728122655.17C791F00A3A@smtp.kernel.org>
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-4-tarunsahu@google.com> <20260728122655.17C791F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 10:43:45 -0700
X-Gm-Features: AUfX_myKuoszqFvWeEwTloNt1W9Hm9CCDiUlXfsqzDGDzLiGRc2fM4YKO_l1eUo
Message-ID: <CAEvNRgGDhcu2LUqhwVtGJSUo4uXQHrGOYRDaM2qzPTO4LX=jKQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] KVM: Export kvm_uevent_notify_vm_create()
To: sashiko-reviews@lists.linux.dev, Tarun Sahu <tarunsahu@google.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The patch claims to export `kvm_uevent_notify_vm_create()` but fa=
ils to include the `EXPORT_SYMBOL_GPL()` or `EXPORT_SYMBOL_FOR_KVM_INTERNAL=
()` macro.
> --
>
> --- Patch [3]: [PATCH v4 03/11] KVM: Export kvm_uevent_notify_vm_create()=
 ---
> commit 5e642ea16f0d267e622a352de60bfe397ecf79df
> Author: Tarun Sahu <tarunsahu@google.com>
>
> KVM: Export kvm_uevent_notify_vm_create()
>
> This commit exposes the kvm_uevent_notify_vm_create function to allow
> triggering KVM event notifications during VM creation.
>
> [ ... ]
>
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -6348,6 +6348,11 @@ static void kvm_uevent_notify_change(unsigned int=
 type, struct kvm *kvm)
>>  	kfree(env);
>>  }
>>
>> +void kvm_uevent_notify_vm_create(struct kvm *kvm)
>> +{
>> +	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
>> +}
>
> [Severity: Low]
> The commit message mentions exporting this function, but is it missing an
> EXPORT_SYMBOL_GPL or EXPORT_SYMBOL_FOR_KVM_INTERNAL declaration?
>
> Without the macro, won't dynamically loaded architecture-specific modules
> like kvm-intel.ko hit undefined symbol linking errors when they try to
> call it?
>

I'm not 100% sure about the use of EXPORT_SYMBOL... here but usually I
compile kvm as a module to try and catch these types of linking
issues. Maybe Sean will have a better method/explanation for this.

This brings about another question I have though. How does luo work if
the new kernel's deserialization of the persisted data structures
depends on a module? Like in this case, KVM is a module, if KVM isn't
loaded in the new kernel, do the data structures stick around until KVM
is loaded? Or is KVM required to be loaded as a module in the new
kernel?

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728121138.11=
03610-1-tarunsahu@google.com?part=3D3
