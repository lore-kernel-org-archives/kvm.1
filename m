Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ECC30C63A
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610401; cv=pass; b=J1gAR3EaDvaHtWnXzTzj30GAj2DyyYUDvljgBlJDSQbEYsgNdamq+kbe+gTVyKg2CDqr0nqZRxcxrDZyfcDuCviWdoIZ9+rkbjxCWTGOuzrPNoB/N4dUf/yGm2mklEGXEbG+bCGdp/+KLRtLYqxHmVyFNWZc/NZdJjyp3OsR1Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610401; c=relaxed/simple;
	bh=vVxGSK+l8E9v6SCAFbvJugN+7803gj8KTueKTvWfyis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwVEnNZFYQxF3xH3bkMpjWpjUtDeyLu4/2j3ZoB1/CwsbGHjeF3ijZvL5FgvXe0C9j+txgzr64ap8OPf/Tq9xh9sa0Ppc22rc0BJR5fZZfOWUsjFrx5VaO4KcTTmq2/JUB44rFZNLT2DMpTylmnjaLPzIdpjIpqrfTYv7uvlGDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qv1PNbAB; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qv1PNbAB"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68d22476e88so4136a12.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 14:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780610398; cv=none;
        d=google.com; s=arc-20240605;
        b=gdAaiu/8YVoOuWIrLvTVmOnz8KPKH9EFJsk934BamClksmbBODW/aEmLeNS33xAPQF
         D3fCJkXbhRVxmJyaIid0WHyEfwif3S6CnCP34GF6Tr3DNudGPKNJ8xt2E57NDLln0S1A
         R8tPMC6zw3zETsNC/bLtJ8k72PMR1GQ18mEX6v4KEG8VpJh8DEzP9ltEVscgBKt6Vu3E
         MuQ+qTQukOAcJxQO2h07kTW2Rrj0XcfnUEFq1D741/DbvGOPx2Pz4FPGvT/Ermc7wbcx
         hXV1qRG+P7cWznHHi6cLonEUt94DskwY+9rFc3p+d0/xRWowahb+94NQwiX7AzNN9Puj
         Cvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a9QnkuBjtyP43zhkb9vrNIxEjJO6EEj6fPZLvwgeJTU=;
        fh=1F5o4aBQ9wmxHcEfhyY+ra11UFj6yRthZgPAA4/I6M8=;
        b=VcV0eOxQ+9H55xZX6IH5o19CRcXEmo4sIkixXAzccAhjwVY5alAx1tpqUpis+FCWbY
         MC/PvI2us4HlrOuPJ4fID9+iM//p34KiUzLfCw9y086ySKyhjHOY7zyDvc9+tnSCWWcp
         P1gicZb16WDOq7qYgfRxDBpMGGYVeVdBDlDucmZXaCqGfAz3kSsZl+EjUdD6v9gK8p7i
         rdKYZBI3vA2xqTzGiiWGTg7IdqvCa8pGiXX5GuHUy0faPS32Kz0fGCyKn0CB2UQr5R/l
         tKeVumGx9dxgbnK6YfFump/GFe/3Jej4ZKZKbJK37mS2umffzofTLkjYof3o88E2QZAF
         dSew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780610398; x=1781215198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9QnkuBjtyP43zhkb9vrNIxEjJO6EEj6fPZLvwgeJTU=;
        b=Qv1PNbABp/o5pXKxCws0rozn7ExMPe4dcEslsOBAZDY7yY5AwsXOX+fXk9oGUo38Tw
         Okf9NUVFKRVrBcSnlr6zsp4qNsqElmSdjHlz1/qwADroOwohPhFfn38o01qMWQhNQpjh
         wq3qA8ZvXHWhG+oZP7GVGBbAT5dEQU42oOSuveSY5VdgLYg0SIpa2HEEjRu4DlngmHo0
         l0TwEjfjOxwiR//UcY7I/osSbyVqORN17IxMJcDddv+6MpQY8TTy2aucrGxezrDFuXSF
         kL7f253ZAqFsY+kN9CiYfUqi6T8R3q0wpvbNtLpZ1bo39kOIyCT8yvZaaWJUNqdpifDK
         6KcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780610398; x=1781215198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a9QnkuBjtyP43zhkb9vrNIxEjJO6EEj6fPZLvwgeJTU=;
        b=RuFOW7EsAQb/9x+4GU4VDn8fKhiLgI+GWDX1jrQhg/Cmj4LQVx2c4HUWT/fnlT155+
         rgqa4spKB9trruud0Pt+0Km8Y4OrEqbgBEi4TIpfLCJ7iphz1L7O6heh3M/1rsNqCJmn
         PhGkBpowvTZrjoPHrY45rouJ9eWRFewDEfS8X5CPkgIQqd27xc988yQNFKRB8QRGT3gu
         u2eSWStgnndmJKqaaVyxXvEQc8PstIu5K52neb0jTX7OzJy0edRh1+2DIP5Xw4v+3gbo
         kLCvPAUpWHVbiE1wgH5dobKsVvrzVxM+YPJwqeeBeLj+I+yj0IJ9GOoWCm+wTCDmQNX6
         eWxg==
X-Forwarded-Encrypted: i=1; AFNElJ/hpty3FsA3/i4sirKk93Za34uAcjpcvo35dXmTBPr0heAW8ETgx95veNyEP6+8rK0DhKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgK97qkeeXWc3szi5SpI2RkH0sRtvQJYza93V9HO1U0xvWlZqa
	WQlzAre+B/ZrbSk5kEHMftuyBjKD5Om0GycC1YUfwU3zHxl/5B/CGu7qaSiJEodaaiZh41vscp9
	LUykJg13aH7ovF7wN/uOdD/bJd0hhXMiyINjDfSPK
X-Gm-Gg: Acq92OF5UMv26v0s9GQnu/qr70HoAG38g6vlYW8oKdOBcVvUtWn8A7Azg6JQHqowMoV
	U5/GXdK1L5scNu3VKh1T7/ZpqzRZnj2WcON+F53fkg5j5LudMVCdStJv6U4X6olVWQh5zNNg65M
	pY6+2GRLKl1M9ze9VfqHkt5ELUAEuyyYcpZEv1mScnfRMd/uhD5tuAmORI/tpQW0dfvvy8/662I
	HyrbXpHFwRD9qFXb4h7pbaNGRCqvQwP/1enKaK0DC+SQhSTxFxelLtmBqHK5ZmIA12XANSVloZ+
	J7Tl+r7QR6uZRQyxTQ==
X-Received: by 2002:a05:6402:371a:b0:671:4bfd:e074 with SMTP id
 4fb4d7f45d1cf-68fccc701c2mr1820a12.9.1780610397965; Thu, 04 Jun 2026 14:59:57
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718214999.git.reinette.chatre@intel.com>
 <2fccf35715b5ba8aec5e5708d86ad7015b8d74e6.1718214999.git.reinette.chatre@intel.com>
 <Zn9X0yFxZi_Mrlnt@google.com> <agPUfzbMzTU1ebii@intel.com>
 <agY6JuEJRhwpwlRL@google.com> <aga+jCVUW0d4GufQ@intel.com>
 <CALMp9eSqqsEzd5MSeO46EdC8aOwhyhU7e2bOW2LSdnDQGXEVpw@mail.gmail.com> <aiHY8cWZYZNb-DED@google.com>
In-Reply-To: <aiHY8cWZYZNb-DED@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 4 Jun 2026 14:59:45 -0700
X-Gm-Features: AVVi8CeucmPpZN457bCq14zRZbqQ-x0Hda7enSMbNTtAXoKcZUthRE1m8xj7b3c
Message-ID: <CALMp9eQ17UaAje1DQ7v24U7iKujvnOknY4itQjSqOaKSn_FqBw@mail.gmail.com>
Subject: Re: VMX Preemption Timer appears to be buggy on SKX, CLX, and ICX
To: Sean Christopherson <seanjc@google.com>
Cc: Chao Gao <chao.gao@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	isaku.yamahata@intel.com, pbonzini@redhat.com, erdemaktas@google.com, 
	vkuznets@redhat.com, vannapurve@google.com, mlevitsk@redhat.com, 
	xiaoyao.li@intel.com, rick.p.edgecombe@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chenyi.qiang@intel.com, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

?

On Thu, Jun 4, 2026 at 12:58=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Jun 03, 2026, Jim Mattson wrote:
> > On Thu, May 14, 2026 at 11:35=E2=80=AFPM Chao Gao <chao.gao@intel.com> =
wrote:
> > >
> > > >> EMR158. VMX-Preemption Timer May Expire Earlier With Certain Large=
 Timer Values
> > > >
> > > >I assume the same erratum applies to previous generations as well?
> > >
> > > Yes.
> >
> > This test still fails on our SKX, CLX, and ICX systems.
> >
> > Sean,
> >
> > Were you thinking of enforcing a cap on delta_tsc in vmx_set_hv_timer()=
?
>
> Heh, to be honest, I wasn't thinking of a whole lot of nothing.  Falling =
back to
> hrtimers does seem like the easiest solution.

I think vmx_set_hv_timer() should return -EINVAL for values impacted
by this erratum. However, the only documented issue is for EMR, and we
have not observed the problem on EMR. That's unsettling.

Chao:

1) Should we just assume that all Intel CPUs are affected?

2) Is there any compelling reason not to simplify the limit to 2^25?

3) Is it just coincidence that 25 + IA32_VMX_MISC[4:0] (on EMR) =3D=3D 32,
or should the limit be calculated as 32 - IA32_VMX_MISC[4:0]?
