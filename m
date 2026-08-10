Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F3A3DB96B
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368086; cv=none; b=isw2San44jtFLoobxFVZgkq/DRaR31NuK6EeLVoiQ7yBXsU8jbmA/SmQhtO2/3tnxgCQ7HmctitAWk7VoZUPxOzLGkAXSlfWvzYXfHHiyrBJBJkjqWooJ8s2vT5BWMvJev9PvVpKtxS4xT5z2cTU+ols3wqQx5b7f5c+hfTXNZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368086; c=relaxed/simple;
	bh=Jritruhw88V157bsaVjUyVKBcWQHYkBHQchXkcJBv5s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YX7AWlc7L5e6UG/hFiwm3oIrLADPlvWQuD2h2Z/Qk40T1LMIGdcFH5XvAYgMWTr6f1LtNskpgyzXOmdkuBJzIm8FB56Tm2Tcj7Bvy9nOv440dNn7o4h0ccMMmAr8e26frV7IWRQGlWekWuLOiT9xUmKaLLCJfaDV5PqtetKkRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsVFpnly; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsVFpnly"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-496b6f97676so18841035e9.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786368083; x=1786972883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NUXsdBwMwxI/nd8pDWWxjP+P4ja3jy+HCgssAFJhmgg=;
        b=KsVFpnly6kRpcGVBKOuXSahCz+9YlTaqQAPZ1s3hCO46zs2gz0wHCHTI82CfDjYCwk
         9xebSdtbw4Y3DMJWj6bFYWZk2FKRp3mxn6gtcC9YR0APA0Y0BXUy3B3um9YQKam9lYIW
         wsAEgJpcStNeMWM1NXAQt3nxLqUq5IHZA9yzUmHjDRwI/G+A7ThTM/UXsyg14o82jV+c
         tb1WTCBqLccwI8Xh+oKebSvw4XKdZDWBaJ+NZ0RlEBxckEhWv5c0BYfHt9uYXvX27RRK
         ouiPs2xaChHJwUY6ON9RlGHaHtAInp1mbH+qjHfFX+l7pmPiIFDPABj1CF+lanQ2ioQs
         EU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786368083; x=1786972883;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NUXsdBwMwxI/nd8pDWWxjP+P4ja3jy+HCgssAFJhmgg=;
        b=gjId+1CSNRtX1tAa79Xqc8kpVgQHZEAw44sVeRh7U359VUEgryq8U/LTV9EyXdg1gH
         MlszM6PxwJ4usYjAkUp9064tQuthuVIvoN64ZGhH0wp8HhqxEpBfmZKNeKCVSoJ5CyI0
         QjAUEQ146s3rxHFP+z3HkRc951G49IYBfWIwSojoG8K7kr4PWj9BU2RF++aG5XsFMlLj
         kZG5OmgwA+nWFZl/5FrLCWt5WJ0huqmpPAOH1dVtG7DZ0rtqcpF3Lvpf4ikTRlLAoqrt
         qbKk/5lDjmMqZBBSCq69UcWzv9IlXOxDyz9BYwaaNUF/zKcNYLtvSC6e5VHhXqIjsza3
         aCLA==
X-Forwarded-Encrypted: i=1; AHgh+RoYWPb7trF2OIGKHQS16cbGw59scOPdQGpo0fCYPPsdzn0mLxhJh+bspm0I/jUIoMz0hi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlkbktGftyAYrCcvQgR+OD4m/zfgYWa/EfNgn3xmaphFhpTROE
	FMLc1zfIGYz/Y/wRDc5DaWFZ7uggCLPBY397UYeCeVkUtvmsyVce13l4bkn310I6sfa0N8HxzGW
	HL+QgUuH5qdM8ky1S5Q==
X-Received: from wrwl10.prod.google.com ([2002:a5d:674a:0:b0:47d:fb5d:6130])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4715:b0:493:cefc:d113 with SMTP id 5b1f17b1804b1-4996195884bmr227828785e9.5.1786368083378;
 Mon, 10 Aug 2026 06:21:23 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:21:22 +0000
In-Reply-To: <20260728122128.D0E831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-10-tarunsahu@google.com> <20260728122128.D0E831F000E9@smtp.kernel.org>
Message-ID: <9huzy0ee6rhp.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 09/11] docs: liveupdate: Add documentation for VM and
 guest_memfd preservation
From: tarunsahu@google.com
To: sashiko-reviews@lists.linux.dev
Cc: kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Mismatched kernel-doc section titles cause Sphinx build warnings =
and missing documentation.
> --
>
> --- Patch [9]: [PATCH v4 09/11] docs: liveupdate: Add documentation for V=
M and guest_memfd preservation ---
> commit a930d2f58a9edc06bdcfd10fb383e97d7fe3996c
> Author: Tarun Sahu <tarunsahu@google.com>
>
> docs: liveupdate: Add documentation for VM and guest_memfd preservation
>    =20
> Add Documentation/liveupdate/vmm.rst detailing VMM requirements, scope,
> ordering constraints, and kernel-doc inclusions for KVM VM and
> guest_memfd preservation via Live Update Orchestrator (LUO).
>
>> diff --git a/Documentation/liveupdate/vmm.rst b/Documentation/liveupdate=
/vmm.rst
>> new file mode 100644
>> index 0000000000000..b8e8fb2b63c21
>> --- /dev/null
>> +++ b/Documentation/liveupdate/vmm.rst
>> @@ -0,0 +1,107 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>> +VM & Guest_Memfd Preservation
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>> +
>> +.. kernel-doc:: virt/kvm/kvm_luo.c
>> +   :doc: KVM VM Preservation via LUO
>> +
>> +.. kernel-doc:: virt/kvm/guest_memfd_luo.c
>> +   :doc: Guest_Memfd Preservation via LUO
>
> [Severity: Low]
> Does this section title exactly match the DOC: title in
> virt/kvm/guest_memfd_luo.c?
>
> If the source file uses "Guestmemfd Preservation via LUO" without the
> underscore, this directive will fail to find the documentation and genera=
te a
> Sphinx build warning.


I will correct it. Good find!
>
> [ ... ]
>
>> +VM & Guest_Memfd Preservation ABI
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +.. kernel-doc:: include/linux/kho/abi/kvm.h
>> +   :doc: DOC: guest_memfd Live Update ABI
>
> [Severity: Low]
> Does this section title match the actual title in include/linux/kho/abi/k=
vm.h?
>
> If the source file uses "KVM and guest_memfd Live Update ABI", this misma=
tch
> will cause empty sections in the generated documentation.
>
> Also, should the literal "DOC: " prefix be omitted here? The directive
> typically only expects the text that follows the prefix.
>
>> +
>> +.. kernel-doc:: include/linux/kho/abi/kvm.h
>> +   :internal:
>> +
>> +See Also
>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728121138.11=
03610-1-tarunsahu@google.com?part=3D9
