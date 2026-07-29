Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531AB2DEA8C
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 04:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785300818; cv=pass; b=o2ftnyn1A3OPM2NYY/wYvXXC3/c90SEeCVJYSW1A9pKZhkTM+YW+xMtRrEb5gbL0dGGb/dlpOkniLgLAmQHaI1OGNh+qHZKZyo5zPG1CezWRF/nITGc79E+F7n+FhOY6xsTav6xUpvS1cv55xmuyDEQXZwja2RnMksKsREmvJZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785300818; c=relaxed/simple;
	bh=sMFAAzwuME8O9Q4FkhBViLFDiCHSSEC3uT79oN/b0c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dv3NP2dtuNnSWReYqQkcX5dnRZZ085Nivk1jqYTsIbJmBHmb9k4F5ikQRv6AwnxZRx4WMB41w2J9VFNLiKs64UCqbpcUcMN8tKybZ1YpriH9m3eI8lHyvhH9ikCpePdzYDsbOUMIYO5NQ0pD/yc4Xmak+v/LqIViUxKxGAfTRR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZ1ukyLY; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZ1ukyLY"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69fec8b4638so7727a12.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 21:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785300815; cv=none;
        d=google.com; s=arc-20260327;
        b=lAsXafZip+Zbyte1NGWpA7MN07zHmRVRFbXMNZlDNn3C1Phz85xpwX3ijjEMeJK+A8
         xRewpMCaEIZP+aABK+3J2gqL+dw40iAbl5357KxJ6whK9fY0L+w8jY913M8cpJU/PWA8
         aMXClwP5H74xo4deSs8kc5zpnfQuLt5pNnlDuPcoz03rJ1+t+gq/lWxADIakiGGGMG3C
         YWCmZ/znZVheIAGe/L0wE59sLpXLvOjtDq6/rWDuA9GbJbl4uZwMjFRKJyMoV34Lx5d2
         3jH0AvHWgUQSoWC6sswcHBwVpxyKq/+Hq6HkPajQYptragff0ylPVHjIfH8E4BOXUdDU
         vkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sMFAAzwuME8O9Q4FkhBViLFDiCHSSEC3uT79oN/b0c0=;
        fh=/ma5m0e3tZ+ZXx3/OK28JhURwNiUoHE4d85cU1Skh10=;
        b=YuFl/MjBbbDi8J9xgrh4YxyILRlFk6GXSVTej+5rEfa4zVUjEPYEbYRU8MIW66CSrM
         NAZQhI/d8VaT4CzTQym2armNjx3YOxD125xzl37xnVAsRIu//tW0orFHehqCAyDjLIrY
         w6ccCStlUfNf2laA7kGAwlrI2Ung9KeChQuXx6KHNiXB506xj8agYWzFDPgo71PBGV7o
         R5p6acuigxkecu2qAmK9+dBmeYKgXO59oSfzB0jqDca20d3sNhLqtZ2f16uFyqN73Rn2
         6Wrsz2FlCmEJYKqElKxwdtcNgycgkGZlUaiwcO4qcSiYRQLSSIqCwhb5+5TeDFPsWHmh
         HOjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785300815; x=1785905615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sMFAAzwuME8O9Q4FkhBViLFDiCHSSEC3uT79oN/b0c0=;
        b=wZ1ukyLYghLDCmYoTBv608CPQuSL12R7rR6np7Zq1eA5Gp4X6S8d+HwwRvgzGBuMTy
         syJbQYPJ0yJfTlihtpHN2U2NG30BpogbM5vZKE0VIun7ufKvXoOANQ16nMyzJgTbOHyr
         SMd56SYz2t2spiZka8Py9HL7lpR8/wrPvpXzswpoVZEmc9amRIZqq0n2vKnl9A7JFknQ
         o8qINA+TwD7MjX/EiVwoF15fC6upnPRS3VALFoBnSSM+itidseTWtS4kX8Mmo6+w2fcZ
         xocJz7uK8p/GECSgvZF070pa/kv3Xp/39jfVCctt6HTM8xY0evvyaav0aK54+2RQjCYo
         cVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785300815; x=1785905615;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sMFAAzwuME8O9Q4FkhBViLFDiCHSSEC3uT79oN/b0c0=;
        b=tJDc/I3Yk79+95ETQx0fdO/VNR5AKg389TDdYZjRXoxPob+5k8e1BP7S03DpMrRp1d
         cugNzz9IXjAddCrUJxqoJ8D/dka7yhS8JNph9ndqEdz5nK/MoH/r8PIaS5DHJe+cDSTZ
         qKIks6EuR2ubEIQCiUeSyEdqQc4WztwxwfnR/SPWTTvyuKNeMmH5Mzv/mYeXeMoNkIOy
         I4JZ2tTJ2gKa7Ja41WAlb4iaxTkyTrrdDo1YzdIYCZbfGNolL0PzrJ6GyzOZCg+t12Vy
         zB4fkVpC9incZTtQfh8Fg6X+QmPlAYbq89huQh91vXUaZtJF+pF1UqLWCcThLxJq+3Cs
         rWJw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9zMqUglANr1RwogRgr/3J+l9SRXlRB55zw5lQJOmWVx5o/+mpLUScpt0ufF99xGQIpdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3hqXOPr7uApD8xeYoVvkCBou4FmkzX9AaqP6TFk2ZQE9QKo25
	nKo+JabPtn5osfBo5UDN/5rDGaMoYz/K7KcaQo3zNZp2kVerMvtJVdr+7reXFtgpOCGAIL4oa0A
	+yvm70IgiNFOITEnJYjn8xYwPoX6VbzIsJNF0bM4mult7xVB/M2bJsa/m
X-Gm-Gg: AR+sD10jC5ab+e53dl4zpehfTFIlByA1tl0LvSOkvoeDwjCzZoOgaKvARdIGs/7+8yR
	2DgvUOYcOxVE/va59R4ti7QQwA9hTGqaqEOlKUQ31x7eBgG65igCYeSMv8vMo4XsGqu6gubAEsC
	aWw4XtztJrxUvJbpewK5HOFxu6Ci3NnEBGlXqPBpUZSC6gjiJ9i/42w5deT1hdyRVZFzpSVVzlZ
	U/mm/olcVajZexW7Sn7X1rYmgxAPc/XY9Qlinc/EhdliVv9WrCiTFcDJUV0PEVktE0K2Ql0tPFO
	hS2T8r5u2BTSklRT3iWN2fRTr2mk56mZ01Z7wce3396m
X-Received: by 2002:a05:6402:b2c:b0:696:b77c:ba9a with SMTP id
 4fb4d7f45d1cf-6a063d6224bmr2083a12.1.1785300815153; Tue, 28 Jul 2026 21:53:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713180153.2728382-1-yosry@kernel.org> <20260713180153.2728382-2-yosry@kernel.org>
In-Reply-To: <20260713180153.2728382-2-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 28 Jul 2026 21:53:22 -0700
X-Gm-Features: AUfX_mw5m8sb8VCglMRYjv50guo-4bXpkr1fp75evnF2-aR6x9YqPMGk2ozuZAs
Message-ID: <CALMp9eRhWq+MXj8zax8hS48eZVE031kctfa=SC1ngT31iBtC5w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] KVM: x86: Check EFER validity on KVM_SET_SREGS*
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 11:04=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> When handling userspace SREGS writes, check the validity of EFER (i.e.
> allowed bits) before writing the new value of EFER through the
> per-vendor set_efer callbacks. This prevents userspace from writing
> bogus values (e.g. EFER.SVME=3D1 with nested=3D0).
>
> Note: on KVM_SET_MSRS, KVM only checks EFER validity in terms of KVM
> caps, not guest caps, so it is possible to set EFER bits that are
> supported by KVM but not by the guest CPUID. Potentially allowing
> userspace to set msrs before CPUID.
>
> However, for KVM_SET_SREGS*, check the validity of the set bits against
> both KVM and guest caps. This is consistent with other validity checks
> (e.g. for CR4) that check validity against guest caps, which already
> imposes the need to set CPUID before SREGS.

Where is the requirement to set CPUID before SREGS documented, aside
from this commit message?
