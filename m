Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D869B1EB1AA
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179269; cv=pass; b=e0cxmVfx0Q9dF0xna3tG1/oAnYUofu0wSLphLw5CDWcoDS2h3qdwGXWKR/lDKtchLBIb+PFNHd7jMsuxIc2n8PTyCK8H7Z0dK6lWhfnoeW4Zd7FzXM1HlHswBUj1O+D+4TgYwxofqzGPSi4GGOnb9IvOVhcdFW+Zmh9D/c/lmYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179269; c=relaxed/simple;
	bh=uJFGFLzirY/vHBGqV0yRgabUC6JrYut6ZFglfLhuyZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6wsDasvVDHgTMY2BKArT+QHwZG3K0r4S/l63hboh0S4i9UOMsJ+cnf2w7PThHIQyxQjG/E7P+buq3pZilcD08mv7IYAGCZLlNUtJJQQ+qsf3LFNoEzlstuELRS/JtSYHYOTHU5yXo1jao226X6y9qSEtImzGAhpYZm9FPO1RdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLe0fX1R; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLe0fX1R"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso46a12.1
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 12:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792179265; cv=none;
        d=google.com; s=arc-20260327;
        b=WnwlWhn97siHRBM/PeY1PTtXh0o49P6sn5x9R2THjTuHAJwmgYOfQIrCfyuSxn/oTe
         IQ4o9Iybcq7IwzdYWl7x0iIyIO9O145dqAZaSCsI7/UP4CMa+EBu+bgZP2d60eJmSoCx
         kH36edyI9pb0TPP1yMdwRhAEzWLqw3UiPrnH+lLdePFnSkByXwJ2H0is4zwh+iU1sALL
         WBhNukqnesZDkuvwzFDq3gNgC5Cdq+i/SBF9vw5dxhFp2cc6MMwCZ7yhSfEOTO3oOPsb
         ZdJoj/xQMOfM1tVoGB0u1yebgShdKZnM+CEbkOW6QHb3S+W9ZmKM7f9dYi3wwHS4ern8
         r55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XyqDYqvsBK9DCe2WChAIDKhJNBGuOpHFCMCEbXTik+E=;
        fh=BReBdJ5BLjFXd6qkHaNFpv1Tt6bHDxpuVzki3EQM4cw=;
        b=TuwOBr+oSXJH7MoubzaaV+biuXGARkLqexwJrkQtpUcU/Qgxo2hkybl7Vj5KQSssOY
         FOhm7SUKmDJB33DG+hcaB6o32dwb5ToV3Y3izL+ldQXFTtVQtm8DQZ+noQdaIlurJPEB
         0+QREmJ+BbfCGNS4fik5bvQVxlHqiA6POLxRqxYCTcdKOPKPIODLUO7xfBHPUKbJB08H
         2vq/STFM5lsCVfzs820QSdPJSXTSt7SrjNQoV82F3GaG1P7vtpZA5D4wssd01qNcouxF
         lPSDyB+P7amaSw72RMl5p4YcZ9afLMdoYqqPUeEIXfVTjEEbZEQDuimRYadeaowAUHsk
         es6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792179265; x=1792784065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XyqDYqvsBK9DCe2WChAIDKhJNBGuOpHFCMCEbXTik+E=;
        b=sLe0fX1RT/tcPZmVprvWumTfrdWQvITCTBhFAsRB7d79PMqf7v4MQ/tU/Le+fVx6Px
         K0kj42Rqf8G3mtgaWGgycV11KkjkUieG/CUtnd2gvF1uXHySKrxxQqMH9FCeEleBKmYA
         mB2KVmRtLY7GJAa7sWyR+rAzBuQQI0EBe+sZtAaW+TkQ/cs+ow7eH2u2zPqFYuJS4cMN
         t9tlFgEiLeLN7qHM6XAUvXgDomgBjEzeFiUbkgjJLkafUQJwkCVpQrPhpV9EP5Mlcd4m
         vwUpB5zRL/xdfZFC0uC3TrS5OrzKztMuGrGb+Fhf4qay3XgpAEu5YVgWYYG0ixi1DNH0
         egoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179265; x=1792784065;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XyqDYqvsBK9DCe2WChAIDKhJNBGuOpHFCMCEbXTik+E=;
        b=or9KhyJ6blqJxKR+Jev5OylW7ZntEhWDunCBAX/sGj2+b/btn/ny/Jls4w4KA1J9fh
         lR4WkeNfA6fXPW3DWw+EErEwIwciI/EBDo8oH6tnvjYfTCXdd0B3PRhDLXxVAEteus21
         Y9Qfsiz8/Gn7gyCUfFrMEKHMv445SPrAu0PuPxhcgxge+kIghZ0+VGt4sl1KhyjU/fXJ
         iwoaFCbw5pGa/1FU2Ba5a0b+e3d66fw7ciUrldupm7pfsYvblyka178R3MsVG7JG0RPL
         O8xVpgb3Hkk4yHhGgYkPanY8yTJoDJ+VH0EVnzADH8Ev/NREmjy0IIQmr3S5nYfzsjln
         aMjg==
X-Forwarded-Encrypted: i=1; AKwUvBxfq5QOiVIB6N0CSyMvNdCHkNJCLcGgSZXrkzxzaEuDM66yMfAgIGWs6UdRM5ykBKXNi7Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiZ/lv9lNQKYEDNgDOToxPkDJcOebRnJdbbfvXhST4gSOlNBUG
	X+32LITN2E8jxSgFX1RzayjxXNweQ0KmGXL7SKXeGNJpKcaRnQo2b2lvBle8CteTe4uriOkMxEv
	iMCsY9TAUYZdVyGyXEhGnk1bsjYOzJef/J6upbbKn
X-Gm-Gg: AYBFou0EQvBqir4hyVeoVLxAH4E0To1ZokTx4EtXqevsE781i5d2a9Ji6YT0f4+M5ey
	NWzq6t0zCeeRZTMSV89Bio97xp6ve/Z+AMPxvN46MJB/btQk9HlSNqKkSx4b+aWmODVvtAd7gto
	o9iSBq81rNo95+KSIB541z4Zf142qCHmVvHIfBLAVR/aW+DFqWwlxdHKcS8QoMYJ0/3KQqJ0oyF
	4EVWHyRHFW8KCa1T5L8uZf48TDD2AXTqtbmuLA/2eHRvHBVSt0Rs94s2o2ib72sBntvlaPKeHo1
	lT+Z4J7jNarlq1T6Ad7DEBaPBv4WFD5mak+PscO/tPa5XPdsc7qoTW4=
X-Received: by 2002:a05:6402:5177:b0:6b1:bce6:1220 with SMTP id
 4fb4d7f45d1cf-6b3a8c0a97dmr7268a12.12.1792179264501; Fri, 16 Oct 2026
 12:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-4-yosry@kernel.org>
 <CALMp9eT9xOFKSFnOg5OeXgmXV0pr-4-yJdBFFMORPx22BgHnHw@mail.gmail.com> <CAO9r8zMtrxJYN83_ht1wLfNrRvc_suLm7LyDhxZABQTBt-fN-w@mail.gmail.com>
In-Reply-To: <CAO9r8zMtrxJYN83_ht1wLfNrRvc_suLm7LyDhxZABQTBt-fN-w@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 16 Oct 2026 12:34:12 -0700
X-Gm-Features: AclHuK8DdKpSponPWc_KxEn5sY4A6TFNT8lBSzHedmtJI_CHuTEi-RSJOFcs3_k
Message-ID: <CALMp9eTm1oR=uwoZfgHUF1d7rhH9PVJMZnmqxnNVA4t_bmpUyQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/27] KVM: VMX: Generalize VPID allocation to be vendor-neutral
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 1:38=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Wed, Oct 14, 2026 at 11:23=E2=80=AFAM Jim Mattson <jmattson@google.com=
> wrote:
> >
> > On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > > +static struct {
> > > +       spinlock_t      lock;
> > > +       unsigned long   *bitmap;
> > > +       unsigned int    nr;
> > > +} tlb_tags;
> >
> > Can we statically initialize this to avoid the call to spin_lock_init()=
?
> >
> > ... tlb_tags =3D {
> >         .lock =3D __SPIN_LOCK_UNLOCKED(tlb_tags.lock),
> > };
>
> The call to spin_lock_init() is less code, but I can make the change.
> I don't have a preference.

Your call.
