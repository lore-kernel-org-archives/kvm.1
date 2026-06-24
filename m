Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04495346AF1
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782344870; cv=pass; b=mpU2BpTMc+rSLzphuEkqV7r4/C77I/Cdk72ePiN7ZDALpnX0JvAEwllknLQ5qPPyvaWVoCZxMGuFkaTC8TMB+Zth7D86qLc+dcNenAtnoLqh/aHGxdlMviwHOYwc96tnTJIKEPOU+JMAlX3GIlPAKQO1S9bVuNeT1GRJCMWPpEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782344870; c=relaxed/simple;
	bh=BOTs7ndZFpsyfsR7Xd704fb0PFSbUEVOoFzPWcbnkd8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8OH30hAohsQbT/utTKkb0jeXWgji6NJAHD+Zz6GISU33JipA26aFYAFeG8eJ5KU0mPKju2w8cpieWOgL7/FA9B1YvICr1oi2XwZVNrP/hAwtuKHxmpMY3/NPzz++CqcByPZSl80YiEFSrdtIN7TNkzHG0EsdMGzeI+FxF0IRvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2VaH551; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2VaH551"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13986d61b4eso999695c88.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 16:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782344868; cv=none;
        d=google.com; s=arc-20260327;
        b=dMCKBG8GzzHQVligRwHX4lW7xdZoA5CPIs9ZYAAGcT+P35XPKClMHOVPiyP78L/u6H
         uAWiZGbRYX8/hmfjyPxPnbPpe8rj7UPGphGRNyWyWk1SHyZzHH5OHiy6IYWodhCnBDgb
         XSD6H23yIlVMpB/cxQ4kF6Hw+tkDj08WAchimtfW12W8G8oQFbWYJgi+R4rEP5zc3GJP
         Bv/wPencmETtkFa23IP2o27L1rCIRZ4oqxvJuwyvVNPqSUAyqNQXUJQSg9kw6erW84xV
         S+mE/mPR5VLznxP+u5sUNR8eLrYx0JLtzho+P7/U6JdLk68uFmf87j+hSVkDQsE7plDd
         9e3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=18U+I3MBHpVGWp0B9SjNPE91pyZLnJEIxilKZScMveI=;
        fh=KVy4+j+TE0qJlGnL1oxDtQvAs+ZlkPteDJwxhHS2piY=;
        b=Q5NnfHiburPG/3twOU0AqQRcWqiA0pKDO2KGi2NNqOiCrgY34hia3MPxoqrF2+RX2p
         1P2+PSrYPjzIyjpF893Cfpv2eht+JPRQZOsR8tvjFYDCJScNVmn74sIk5eUUhpvUy78f
         hjDIB2OTEmc75Q9V4NFcFyTFJddM54vmrV2VXcuP004OKbtMG+we2JNqiWKEdxTfdt0S
         UlMSK1T4tkbH2uXp0nGuIISXJ9MbF6rjoLSXW3gAIBjGsBqBrHfvH8L6fUQdF6tVkxgC
         Jl/5kQCf1IfYr6wBCVKXnam1wK1jPw/KIZFvsQm0QXSgNA+KEWFSPEAPCusSYQifXEhd
         pvJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782344868; x=1782949668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18U+I3MBHpVGWp0B9SjNPE91pyZLnJEIxilKZScMveI=;
        b=j2VaH551cx+jK85joo9stweuJyYc9JJn7hLgMPBCaPYRCLrHkTyHZXOhqVPwh76Mte
         FXhACii6Hn6oF1c1O4bYOE6m8nTZCio1BAQtbwyYaLdwAxSlbe15n06CDjsDRP6XhJN1
         UEDtJS0gl8R3nKI0CffyTcZC4QDT1fy+uH+or0obwSyWGJi1Kk9p327mNN8hJ4Dekb1H
         sQTZJRLWOio0aJVjoPvF7qJ9j/8NRvG67VtVv8G0ExvoeziuoHr63TGfSCfJIKqwmskq
         3zAQfCSjK9ZxEQJ+T+2lD6i6xrZfz4cZNNf4WKdludgUEsS3jvTJvHaTLy/URciCaLRd
         pa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782344868; x=1782949668;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18U+I3MBHpVGWp0B9SjNPE91pyZLnJEIxilKZScMveI=;
        b=XuwwhQiMLFfWibU0n30G+WegH1J4jP3A6Gi4bwN0KxVEFL6Gn7LFc3yRxo9Ay1I2Id
         u/NOqhoJIsR3nOPQPa8kFabqmHbsuKZQu2wwHYALthM+wWjmb1Keh9EzhK5ZLqiQVUxs
         snpif8zNJot0YN+O2bBJHUBVA0mXSAbCJeZxSt73EisfHhxJqzNvUp1hyIUcOAc9FaOk
         0d9yV0P/YrRPaXFREc6UMbWXzdih1NQn+AExgRWUllFxCP7Zg3/ac68EqbQcd96kI4Px
         J4183eZ8QvDwrWNF0UHBEqfa+UQtfUwx2VLTthCTSTHjXXzltF+h88S6gltZIAhXnPEq
         q6cw==
X-Gm-Message-State: AOJu0YxG9IQVzTYfubxHL29jFSP2jmcgVrcsZy0rwF62x/jzqylkox/N
	9ZpaoWXiHRbJ4liVujTaQ2XFC+vQOcLmHSpwn6LO/4yEqoi7FxLAm6OhtcKJ+t0MxcFGgNZhw9B
	mUyELeuA2cHVaNr/8hbBl/9BKQFGkAsyx4zJEQNIAudl14yQ8pYLGQeTC
X-Gm-Gg: AfdE7cmW7n+2O6nAwwj0sUfbUmVMCv8dTPBPCQzHNqNg6NXXhUYdPuNRG8RyIjC4mG+
	qmCdIp5bS7gdW2NeYe84JLhOH/5AAljF4UiWobJ0NzPJa6DMb6w4kZfBRPAvRaR3j1VIqi5cGAs
	PAy0GxX0Jsf9Y+d1q8psmD2AxtdUAXqc3iGJJhPTZJuhRtPuXM6N7g4usyPYoTZXBpg+E6/1YKi
	gQOtLk/isimWioixZn2rSivOv4J5pzbxuDe+ceIg+vztEj3EmhrBEJMCbLyc57gDN1QeITlG9ds
	6CE76whXSSLVMyvJLfOLotNKUjlMYd8943B0hIGrTPeRV2MrrKEBS+Ai1JE=
X-Received: by 2002:a05:7022:98d:b0:136:c565:e83a with SMTP id
 a92af1059eb24-139dbb3ec98mr135615c88.24.1782344867276; Wed, 24 Jun 2026
 16:47:47 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 16:47:45 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 16:47:45 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260619005856.09DD81F000E9@smtp.kernel.org>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-24-9d2959357853@google.com> <20260619005856.09DD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 16:47:45 -0700
X-Gm-Features: AVVi8CcyRflzPmfvQme9jCFwguwaCgRojeI5Y2eDu1yNbRvAkdDgWUV4du7WdVU
Message-ID: <CAEvNRgE6iKBhMYM64rgvuVEOvAFyNoryzpjTtSQRf5TcrLTepA@mail.gmail.com>
Subject: Re: [PATCH v8 24/46] KVM: guest_memfd: Make in-place conversion the default
To: sashiko-reviews@lists.linux.dev, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Unprivileged userspace can trigger a WARN_ON_ONCE if the host =
administrator misconfigures a module parameter.
> --
>
> commit bf8cb04a544d7b8235d73034e0febf195ab335c3
> Author: Ackerley Tng <ackerleytng@google.com>
>
> KVM: guest_memfd: Make in-place conversion the default
>
> This commit makes in-place conversion the default when the architecture
> supports private memory. It introduces a module parameter to override the
> default and adds a warning in the CoCo VM memory population path if in-pl=
ace
> conversion is disabled without enabling per-VM memory attributes.
>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 86c9f5b0863cb..5cb73543c03c8 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -1193,10 +1193,15 @@ static bool kvm_gmem_range_is_private(struct fil=
e *file, pgoff_t index,
>>  {
>>  	struct maple_tree *mt =3D &GMEM_I(file_inode(file))->attributes;
>>
>> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>>  	if (!gmem_in_place_conversion)
>>  		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
>>  							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
>>  							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
>> +#else
>> +	if (WARN_ON_ONCE(!gmem_in_place_conversion))
>> +		return false;
>> +#endif
>
> [Severity: Medium]
> Could this WARN_ON_ONCE() be triggered by unprivileged userspace if the
> administrator misconfigures the module parameter?
>
> If the system administrator sets kvm.gmem_in_place_conversion=3D0 on a ke=
rnel
> compiled without CONFIG_KVM_VM_MEMORY_ATTRIBUTES, it appears this warning=
 can
> be reached from an unprivileged ioctl path calling kvm_gmem_populate().
>
> Since an unprivileged user creating a CoCo VM can intentionally trigger t=
his
> warning, could this act as a host-side denial of service on systems confi=
gured
> with panic_on_warn=3D1?
>
> Would it be better to convert this to a pr_warn_once()

Sean, what do you think of using pr_warn_once()?

> or perhaps validate the
> module parameter at initialization time?

I thought about this too, but didn't want to move it to initialization
time because this (populate) is probably the first time the kernel
knows for sure something is used weirdly.

Like, perhaps the admin did compile without
CONFIG_KVM_VM_MEMORY_ATTRIBUTES and also set gmem_in_place_conversion=3D0
but wants to use the host only for non-CoCo VMs and hence doesn't need a
warning, idk.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-inp=
lace-conversion-v8-0-9d2959357853@google.com?part=3D24
