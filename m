Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07B33121E
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607309; cv=none; b=ajRiPw0n72YX91mKQKl+9lWg1owZKYPncfs5zFOkMUBFtLiANKYliwH4idIlHurqqvyg/64KsvouLh5SSksyemtpeBG+7AlAYJxPSUXDyUpNMdj3ezNE9axX2b60NfmFKdrHgpdYAUwaCGILVnPrWuUW6+0S2Q6Y+dpGZbAdhaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607309; c=relaxed/simple;
	bh=4UGvmcJWO+vF4ijE0i9D6ZUUiRa1XDumSYloGfIKakI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D6nDSmg3QPV1/PvYqR/6u+vU+CAeSht1Yhn69up+PNRGgIGr2If+ph1SvNIiiYZ3MhAqz/UeJ6rEzIZQJvU9aYd2MhkZqOh7io8XGoRCJEwM15++UC1bV3WQT7bkHJPWm+FL13D4nMbrXZaK3V/h68062jvWTaa4VoVmHHtfH4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wm6gsbTu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wm6gsbTu"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-38827cee19eso1413240a91.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783607308; x=1784212108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g8eThvaBRatBKc4k9DT72V3nfTJdvxG/RsPvyVMBgw4=;
        b=wm6gsbTux7p3qJCv0awUjauTBi2lvqeTkI5W3yo8nDpK7nnqnJ9xbPOUIivY+MZdgJ
         L1P6HhJyqjGfBRoTY1cs19+9JQhhWbXGp7QmzTDXXwLBRMR1E2S9b+4ypts4XM1Tbbiv
         buHj6m+z2lXLthZX5yZGLP06+sDFATFEP5FBTNo33i376mqOpefRBS0lmF01txBbMh5B
         ysR9bmZdOcmWArFT3Kexz3RhmEAalcrjcDEd7iQ1kEKUhARDrWgbl7rz9gubFrWeU4tq
         BWpkjYQkLFTOdW6QXqi+QbNI7B3b/gf9kKPk95E9oVYhnGhGhialqvjmUp2srnRbP4x8
         5bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607308; x=1784212108;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8eThvaBRatBKc4k9DT72V3nfTJdvxG/RsPvyVMBgw4=;
        b=I8XCQXg9BuaLgL2i1eymuVfz8OkI6ciJD++9IUzJv+T8l2fiyS3YKk0Ohm/+MqGav0
         FwdmJZZIKmVci2OuBT6+FwqEzMdz738hL6FWYcapHPomZsGTnRFfOCwAZK0CETRi9HCB
         lvoZpTjliaWon+KPH41CK3Nelwo+OnCe0u2Ecni73zJ88aVevbgbPSZrORnULpXVohl4
         RhbKq313yK+UANb9oRnwDO3RGQVNcAgBecwUWh1YOKuhVSKSW6FNenfTREFcnO/MImZK
         V3WnmLi5HlxlYgfCVnWl/wvL90+d5vdzaE4ieLQNd76Nbh9LPDvTtK0O8w5/BpaUVefQ
         fNRA==
X-Forwarded-Encrypted: i=1; AHgh+RqekHAVLDEAJFgPm5kqnZ4q/eSQqvBpTxYSFYxhz2iHB9O38RouOJ1veswG4hG93ReJkGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6eWNzMtib2eCPzL2GkA4VppUcFfjYYY1vHmWRObSDSLngzUtV
	MuhhIaotowaQxyUpKe3p9PTGMCXEPVK1A40Qj6ZAMEW1BD2GMzsAoyhvKRvGTV7lKtRK3D3ivz8
	CgWNGEQ==
X-Received: from pjbbt4.prod.google.com ([2002:a17:90a:f004:b0:381:9321:9051])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e184:b0:37f:e8d6:72c0
 with SMTP id 98e67ed59e1d1-3893f694ae8mr6844986a91.1.1783607307420; Thu, 09
 Jul 2026 07:28:27 -0700 (PDT)
Date: Thu, 9 Jul 2026 07:28:26 -0700
In-Reply-To: <20260709072247.3305784-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709072247.3305784-2-clopez@suse.de>
Message-ID: <ak-wCrZ0J-s0d27A@google.com>
Subject: Re: [PATCH RESEND 6.18.y 0/3] KVM: x86: Backports for VM entry
 failure due to stale CR8 intercept
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026, Carlos L=C3=B3pez wrote:
> Backport for bb365a506b1e ("KVM: x86: Unconditionally recompute CR8
> intercept on PPR update") with two prerequisite patches.
>=20
> Resend: fix destination emails (did not properly send first version to
> stable@)
>=20
> Carlos L=C3=B3pez (1):
>   KVM: x86: Unconditionally recompute CR8 intercept on PPR update
>=20
> Sean Christopherson (2):
>   KVM: x86: Move update_cr8_intercept() to lapic.c
>   KVM: VMX: Grab vmcs12 on CR8 interception update iff vCPU is in guest
>     mode

Acked-by: Sean Christopherson <seanjc@google.com>
