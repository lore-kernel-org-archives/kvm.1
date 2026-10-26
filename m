Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037858;
	b=pLVcIbp8B68537fahl8aO3tYQ/Yvk5jLBvYIY0lYZvMa63NFN1RVKK71brn/574PBzZD
	 AVG1OyncVTMeC6jzDImexDYMXL3LekgCUg+5hV19J8x9r2M8Z7dKC3Co3FpC6un0945h3
	 u2hqGRkZJD0vUgJypzpjfNEYRcIIf9AcBjYoVvoo71QFXSrsM3Asr181MDs0TiCfrPRu4
	 YTU2WVKB9GDjG1MDx13OnrZkGx6FwBq06Nx7dYI4MOsEe0BSf2EAtguJCowIw4hH5VnIl
	 fWm6oJQ7uQAwPnxz5CKIRMfHkd5DwfB3wwGeFQPj/JqqVEfdNdPmZxJquikjO9mnYew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037858;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9uxlLJEsA1bXTEHp1c6LcwARsGRwFYTcu3KTbRjTHlA=;
	b=kjiW5QyX2Qpobjrb1djiZV3rteKozjxh471wm9J+j0nbZkBo6qA2AKTHf6aGmTD4qHZF
	 Kp6j8zGw4DIPdfNhOa+oLWRR6Zxdb6QBH6Ugw9zTqT2Aupp2uxThkcRdPcLsmOwlIUYiz
	 gbKFXQOSFHhWuLuisz2resql+yb+m3yQtWIItaTEIRJ8Zbr0NACQ4suHN1pYUwLFHepAj
	 jEVVTZlu3Raw56/3DlFaAlu4Cg5IHKBzU9a7+7EpkYkzMuS5lUjUUlCcQXp8TuTGuH90N
	 zyIqlUdS5TVcImOIXEqCBcb8jJCnu3OdCCUPqSaTLk5+DMcFaaP75AASzNeSNG73/mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nbNDw0R/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF67606A31D
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbNDw0R/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C9B1F01825
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 18:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793037857;
	bh=9uxlLJEsA1bXTEHp1c6LcwARsGRwFYTcu3KTbRjTHlA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nbNDw0R/EpYHYoifQ3AZeula7uMg6lFVErZjDVExn+hx8a2bL4/rSPvN0FJYwK7ln
	 DCqyTsBm431pvy/lhvvKteMb9mGXbuUBTT37epr7Ka/AHMMxplEnenbqSdPpey5d0p
	 p/CqYUnu3MRiOQ2M5BN7wRGtKMi0rfFqQPmoPEQ/97KjyXKbrKK7W1KP6T5DNBKmzX
	 jC6iFfanNZbxiUEUuJqS4ql8ITCmHnXvqbgeF/MLzxZ4f9ZK3rHSdcE02bhTgh8QCc
	 NQ6QMG+BB/yl4lY4JPgZVDHrQrRu2GDFEYCM03HSxzsca5raoht9A/2rpxjPyyFXon
	 CryRac76Xjoqw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c45551fa84eso489296566b.3
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 11:04:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzMcc9IPAJnOZ/l3N9t63/VwsIBM+3CbgvZObSctDE1mmIWXVqujHBDqFuuuWOZxBKoEoA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLXmWk2QjJ2czKOu5POpIsnglU7guos6BmfNGplsSItr2od3LPs
	0QZFeqk9eLaV0ia11isYFUH90gAtziJWGOuTQ1vsnTJXjStIkywZmRYkE079iB/dlCXCuUyUrEQ
	h+txqsS/rpMRvb1xteCb2tonXRbDUKrA=
X-Received: by 2002:a17:907:7fa5:b0:c40:dead:7466 with SMTP id
 a640c23a62f3a-c46bdc0ea2bmr844359966b.20.1793037856284; Mon, 26 Oct 2026
 11:04:16 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022215541.631694-1-seanjc@google.com> <CAO9r8zPFEwUVYSTePWN-FurHLzGN6cY8bd-BOj3sjRmjj4xQbA@mail.gmail.com>
 <at-Pfgjt__PJl55M@google.com>
In-Reply-To: <at-Pfgjt__PJl55M@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 26 Oct 2026 11:04:04 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPAvi0vCENtj+7+gVrojB2nOHEoYfyhgdgxpmiUA2kWgQ@mail.gmail.com>
X-Gm-Features: AclHuK-_mV-_o8oyTvjNfVPUxDkJ4-4h_LvJxqYkxEhvrUiyoB5NiBgnQwLbofA
Message-ID: <CAO9r8zPAvi0vCENtj+7+gVrojB2nOHEoYfyhgdgxpmiUA2kWgQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: x86: Convert all runtime WARNs to ONCE
To: Sean Christopherson <seanjc@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 10:36=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Fri, Oct 23, 2026, Yosry Ahmed wrote:
> > On Thu, Oct 22, 2026 at 2:55=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > Convert all bare WARN() and WARN_ON() runtime usage, i.e. WARNs that =
aren't
> > > strictly scoped to module init/exit, or similar, to ONCE() variants f=
or what
> > > should be fairly obvious reasons at this point.
> >
> > Do you wanna CC stable?
>
> Not really?  Maybe?  I worry that this will generate an absurd number of =
conflicts
> and also have "misses" in older kernels, to the point where it oculd do m=
ore harm
> than good.
>
> I could be convinced this should be tagged for stable@, though honestly i=
t might
> be better to omit the automatic backport trigger and just rely on someone=
 to
> "manually" provide equivalent patches.

I can just see this ultimately preventing a DoS and if it lands on any
stable kernel it should be a win, but yeah probably manual backports
are needed :/
