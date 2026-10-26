Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793041187;
	b=di1DdTwwW2x9v9313oHURNfn897RDzuhplSWEY8NvaF8wa0e+7cUpjA4bDT/LzIAbQgw
	 pj8dmEjfTyJlyPNf/cj83kiUIWBREnAFCGff0w/futE1sh4bssvO8e5BAd3A8sTEla852
	 6sWosFchCEQb9LdQQpZChfBwyA+5wqBZTSgza6WL+p9GNd5pD2EtBSduLE9R0kPdShJHs
	 V3sK6aMsFHb/NFNcOvuIfLy1jpHFAdrMU8VRYwba01uFJ9IupR70zNeAn6818d2Xt1lLl
	 DTISRVKoWNOT92WsqdUW2i/AuUKpVuGibtQuWNxBcdbdnBz+lGLXrmZv8xmRkJo2orw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=vFQSzrzMPbR886MkQnFhhUgLb0bB/SvZ7Bv3piD6vcA=;
	b=YnIoqrjHlQPAxdP5dJNr37KntYQZfWUlTiL06vzuKcHG3Kovgt1Tl/K98CntE4j6PCsy
	 aMR2tx+ksQde29w0eaZTfFQxRZQ0fbzJhGtrb+8lAjphNv8PoyAk9rRTY9oGJbl9J7PUy
	 wSQDmd7msypo5asWGrIQTAvA/Kg3Vq9sFZnFRmqdU6f1Tl/eoH5vG/O1r55alNpYo+fEt
	 noighJsgxzhK7xWz5j3fzUgepCOPNvW5HDktFSZJdAqAB7BHA571w3HczlQMhYDQjQo1X
	 YI3CZIRowUXkUgSJ/WNy6u6r55qGifUIhp7mGVcfzy0X3PkX72c/5181hvUFhFZ7rJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NUlN30vn;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973F606A31A
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 18:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D973F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NUlN30vn
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e9821ca96fso38594385ad.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 11:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793041186; x=1793645986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vFQSzrzMPbR886MkQnFhhUgLb0bB/SvZ7Bv3piD6vcA=;
        b=NUlN30vnYiu/NIUtOUp+Tn4OxP3vIq7NpWCK/SBMEp0pzsRPLp3PSYWwv08HqWKq8c
         DMP+nLjVSEnuniHsAymIsTM7kpVYCHa534FAc0ZvmNh2LQP7iDWqKwIMJi38LGZTGDai
         UeOiaWkYNaKU5kKenhqjQOe59hKsMNOukDtG7z9etMGVjBwVzOIm2DDtSAHyuyna1r9N
         EKQ1ZW4a6Riu45WU8/INkcUq3hRDjnw6Gx3WDw/Nh/Zpx823xFlqRzTueV/kpLJei9sQ
         SJHpd3BuAkucBYeUwPkuvYyabt7yBtr8wYdd4gZisVFmGSmVfgbzBj7zOlsMc38qTUyo
         Ts0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793041186; x=1793645986;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vFQSzrzMPbR886MkQnFhhUgLb0bB/SvZ7Bv3piD6vcA=;
        b=GQoO/2ZKFIYh/QxGxDcyDzck0+krHcDZV5WmihEZuSXrOH0RQPSvDKD6PMoVmetq1X
         MvA0/hft9BtIl95Rn+6rW6Vso/0adxJQ65Z11UVyrf1T+m+ZIuI/M+1+K6UQ6mmYGmAw
         GBN37ufSmyd8pAbY7e9bFHs7ZiSW35f3c+SW+rwfeukODsG/0JGI6Wm3l3Dw76PgiIS9
         FBYHXA/cGxlfIFOzIEO3+ehoYrgnD7Xjr+FW2fqRr4xmyKAZmd0JzzuQxnSNekGpauMp
         BdsJPUkd0Upj5lvWEDEOtgioulrl/9g4Sch3q1z1M4VZ0r8GtHHLvERgFoWDp2wCB/lo
         AvUg==
X-Forwarded-Encrypted: i=1; AKwUvBxVQsgylWScpqrUoBrOtendZM0u2iUVAiRi8CxO7saJvkWSo2F2qnDcljRgW3e81xBlQQs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIs0g6OwdUFWzgrU8XN24GuKBIfO/sJGVZQI0kK0KRdd8DKDIr2
	cKEMnl/Qj0uKq5qamuIJqp5yUVANuaBwQYULT/8cZ4bbDtz6NfCz83Ce2O6RkoxBMZAtdBb/ix+
	3pYmXPg==
X-Received: from ploe5.prod.google.com ([2002:a17:903:2405:b0:2df:a429:6698])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3805:b0:2e9:460e:ca57
 with SMTP id d9443c01a7336-2ea9c66910dmr71815065ad.15.1793041186062; Mon, 26
 Oct 2026 11:59:46 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:59:45 -0700
In-Reply-To: <kupecdcwbmc.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022215541.631694-1-seanjc@google.com> <CAO9r8zPFEwUVYSTePWN-FurHLzGN6cY8bd-BOj3sjRmjj4xQbA@mail.gmail.com>
 <at-Pfgjt__PJl55M@google.com> <CAO9r8zPAvi0vCENtj+7+gVrojB2nOHEoYfyhgdgxpmiUA2kWgQ@mail.gmail.com>
 <kupecdcwbmc.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
Message-ID: <at-jIZ4uK9_IgzZh@google.com>
Subject: Re: [PATCH 0/2] KVM: x86: Convert all runtime WARNs to ONCE
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026, Vitaly Kuznetsov wrote:
> Yosry Ahmed <yosry@kernel.org> writes:
>=20
> > On Mon, Oct 26, 2026 at 10:36=E2=80=AFAM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> >>
> >> On Fri, Oct 23, 2026, Yosry Ahmed wrote:
> >> > On Thu, Oct 22, 2026 at 2:55=E2=80=AFPM Sean Christopherson <seanjc@=
google.com> wrote:
> >> > >
> >> > > Convert all bare WARN() and WARN_ON() runtime usage, i.e. WARNs th=
at aren't
> >> > > strictly scoped to module init/exit, or similar, to ONCE() variant=
s for what
> >> > > should be fairly obvious reasons at this point.
> >> >
> >> > Do you wanna CC stable?
> >>
> >> Not really?  Maybe?  I worry that this will generate an absurd number =
of conflicts
> >> and also have "misses" in older kernels, to the point where it oculd d=
o more harm
> >> than good.
> >>
> >> I could be convinced this should be tagged for stable@, though honestl=
y it might
> >> be better to omit the automatic backport trigger and just rely on some=
one to
> >> "manually" provide equivalent patches.
> >
> > I can just see this ultimately preventing a DoS and if it lands on any
> > stable kernel it should be a win, but yeah probably manual backports
> > are needed :/
>=20
> With my backporter's hat on, it would help significantly if we split the
> patch per-area (hyperv, [l]apic, posted_intr, vmx, svm,...). It would
> also help those who want to analyze whether the particular WARN_ON() is
> actually guest triggerable and open the corresponding CVEs.

Honestly, I don't think that's actually going to help.  Exactly which WARNs=
 are
problematic will vary by kernel, a lot.  I.e. the set of WARNs that are spa=
mmable
*now* is not the same set that was spammable in 6.18, 6.12, 6.6, 6.1, etc. =
 Then
factor in different configurations and threat models, and the set of proble=
matic
WARNs gets quite large.

So from an upstream perspective, I think we should assume everything the wo=
rst
and "fix" everything, and then do the same for LTS kernels.  I.e. backport =
the
concept of "never do multi-WARNs at runtime", not necessarily the literal p=
atch.
