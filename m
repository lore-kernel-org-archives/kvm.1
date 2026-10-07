Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5EC3016FB
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791393954; cv=pass; b=SN1wcOAJhOdWjIYrc/94BqGWuI+Gpr2ai5dhxezrK4IbQ4DikVqhoVOU03No2ncI/zf6eWb9OBFaezd/eF5UikubjTt+mKw7AEzVKNUJoIPckk6ez+R4uPO9mniLCqYOm6t0wTrUAobOMhLa+05c6OXbLCWeQKygmbyu0IdT9T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791393954; c=relaxed/simple;
	bh=bFp9FVgXRrSNtyXuTeJPHtEaTr54uyHDuywyPyXVyxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtJcD4wBk4vJvAer9nIhmACq7sCv9CbFRvufP6+4tMQN0naGCfEtxc4lxmlQVqI4pVPcjwJRLMUK2zr+oIQ1mlbzM269Q6XwcJ/ymvUEIfp/uXoYeQ0tLyxlcm4xrQI9F6SlN8Nhj0EnaqxYWYwQVt4LerrScRDIgjO5x6KHr1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q1VeGU1m; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1VeGU1m"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso535a12.1
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 10:25:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791393950; cv=none;
        d=google.com; s=arc-20260327;
        b=FniOH+d2nN4/qsEERJrhV+HSV8mh/K48Zs0Xk4QC4HC+3W0M2O8L4kCMDbbuOZnoEw
         OMQjlGBjMPfWJ2Xfn5u8Z2l+f86TXHUWcGSexZSmk9p0Co+JTzr6A8DVP/f3pWaY1iHV
         a8RMWgTJoGtTJ36xHlXg0Uwk4whPXpSPqYlGA1rOVyG5fbrBIc7AJBbW3UopbIAGY28R
         cIK8QNgEb2gFUHepaXeNEknnc3fTTt7xV7zOqpp6kZlwoGwOvj5La5RhwwF9xMEhK4h5
         UMTVKovq2xPey0lv1Fy5Tla1SWxdGSNexp/0DCUoKJaG1E/5wuFmXM8nm5lztJ5jWfPt
         IiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S6P0cpKO7LTMMHYnGA44fwrKbiotpZEp6qx4bE4GHhk=;
        fh=bMhcdQXan9I+hc9fIWPkBqx3IRQ5DtyW3oAIbsbhpiU=;
        b=HfENFmTm5Ite4rGrX+u8kfhgVz02jAKHUB/giqnbJiaUrPqcaj+g8j13m8S5yRZTnq
         4p2fxCOI2uFF5ZHoeCHsUZbd6A5Zj/MSaOLLMgX25+Tg984CyNZIm7eU7ZcPj8B4aVdu
         1S5F7somZ65krpcjMy7djW3h3QQlLz1JdD3qPqEt+YKToTjDoB7n/xlPVDSZL2/mlpFg
         4f6xq/a+LHsNfzpswQaVfDUQsWl2Hc30sV8aMBfwYPpj5oBIOkbjZDtrYU7wrP9jhbfJ
         XeaJPuvo6+wsD1Rp48oUO1HYfED+huDTckSyRkqaOwY3HkeR695MCCMEHX3nBycVCAmC
         xS0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791393950; x=1791998750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S6P0cpKO7LTMMHYnGA44fwrKbiotpZEp6qx4bE4GHhk=;
        b=q1VeGU1m52RkcepBIokglRDWdJ+xNQv/2QGgQvXj8ah3/fvnKWPaMZRZNf5usWqz8L
         7O786uaIN072g3ny6yIsddKSTwYkDOHkifLzGEVqdowonCYncusHMtWtFwx6S2tFISua
         sSzuJj8pvJBdXcJUOzaRTf7uEoUUkCt4ipT/bXKax7+2tj+ksD9+oPE0pP/2rwZUON7A
         k6Ybd0Jv3t5cx8KakzPfAnwGYzL0qsdqjBiQFLehYabayEOo3bFp5BZEaYrQ3NR4rJmL
         52li/dh4f0NqS8DbSkEW/6b7z0o7YNGNXlg6Yzh3NcWfeOZEQEBXNCWrHxz3siUsrxem
         9oqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791393950; x=1791998750;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6P0cpKO7LTMMHYnGA44fwrKbiotpZEp6qx4bE4GHhk=;
        b=bgZhA1i8F8zPnD/QQJ0gv5KwgOmiB2eZuwvZfLBzXqjRZVU0/7bSV8rCKaxZqgUgLy
         6M3+9taJIYFcYBSce/leDqgbmNUrbrIBjvshV/yJFqFOMgLloz7ugH7UCrapDZuXjbJ/
         reI/85Ot5w7Hd6lgzQGV/R/AvGI/dKmYoZLiSyCSBrIMHtHbWmeXH9OIxoIqf5hNawx6
         PvegQeCpezCLZjDfj5MaO4V+uGdHLtE4771KBuqXd7rxTIKLtcJhyQ8fjuo7VqbZvSK/
         ZWhTn9EgPHYYBDLYHi9MsVw3MFxE6jMyd1uhvEj2lbbO0sWY7AQUwuhlBws2OdKh/+0s
         rvOg==
X-Forwarded-Encrypted: i=1; AKwUvByoGTeA9jGHz2YYUJROL2RowWsU9dQvrYQOBovdZb7APFb2bZF3PEApG1CI2yia7I08i2Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSWX0QVPjxbpgtN6n7Ej3+idRVf8j7z793PMp1hrDVaUnrzKxw
	zU4SI3vHB8KxUtBy4OORzKyPj82zxsc6CHRHVmlXNDTdnJmwrDWZwSfsZ06ZNFBI2q65qbQWc8o
	m0HudKPL1CHMQdq7UeI2SyETBIqrN326i9Ovh7X0qyQR5oJAJssJhtuhb
X-Gm-Gg: AYBFou2iB1Tz/5LbA00yKvLw6FnYX+qYZKKh3GfA0kG+9FGtQDeoyYr8zRpCEJ/ZWds
	P08JBD9R7pJcusldQc/QjiBB+gnUv3pnH1tbhjBuebIVyOnqEz4k6/OufX9MC1bPI1zqdc3v3xb
	gFqS28/NP7v364cOI4mWPbavolDCneCrQOITPGNje0HyLgnYkKtNiRHCxGGrExiO2VjF3QFEVQG
	5NiVscfNT33rXXwkpuUoEYOl7dHQu5mZuGIJXWleE0q1oXHnUoYKy+mseLr3v1gfuEfjED/YX1G
	/Gi3iqVn/M9xEIhWOHHAW2XvAJrhwUCMKGzI7m7Q1sUYajrfSQ/Ixtc=
X-Received: by 2002:aa7:ccd1:0:b0:6ae:188e:e119 with SMTP id
 4fb4d7f45d1cf-6afdc8fe78dmr118123a12.9.1791393949297; Wed, 07 Oct 2026
 10:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com> <20260930173635.3362655-14-seanjc@google.com>
 <CALMp9eS0=HgM02Ff4mv6RLHVoM3EgavhKu_P6J-oTWTMbk9zng@mail.gmail.com> <asXg3cJvaeqMOfAr@google.com>
In-Reply-To: <asXg3cJvaeqMOfAr@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 7 Oct 2026 10:25:37 -0700
X-Gm-Features: AclHuK9eyrVIWkB2ErSGSXKSMWgWxHaYbX_W9hVeHs0rrHK0BMCJBAg7Fw6FRG0
Message-ID: <CALMp9eR8yMTFTJXVFHpkpv6ptt33Q3m16n=CWuBF6mQu=AaY5A@mail.gmail.com>
Subject: Re: [PATCH v3 13/21] KVM: selftests: Use KVM's reported TSC KHz as
 L0's frequency (sanity checked)
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 11:04=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Oct 06, 2026, Jim Mattson wrote:
> > On Wed, Sep 30, 2026 at 12:04=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > >
> > > Use KVM's reported default TSC frequency as L0's frequency instead of
> > > calibrating L0's frequency using RDTSC.  Trying to calibrate the freq=
uency
> > > in userspace is all but guaranteed to be wildly inaccurate, e.g. due =
to
> > > interrupts, preemption, etc, and no known CPU supports TSC scaling wi=
thout
> > > also having a constant TSC.  I.e. there's no need to calibrate the cu=
rrent
> > > frequency, as it should also be the same as KVM's default frequency.
> > >
> > > Opportunistically sanity check KVM's reported frequency against what =
is
> > > observed via RDTSC, e.g. so that KVM_GET_TSC_KHZ or platform issues s=
how up
> > > much earlier in the test, before VMs get involved.
> > >
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  .../kvm/x86/nested_tsc_scaling_test.c         | 25 +++++++++++++----=
--
> > >  1 file changed, 17 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.=
c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> > > index d790ab36a198..a78585af0ffd 100644
> > > --- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> > > +++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> > > @@ -137,7 +137,7 @@ static void l1_guest_code(void *data)
> > >
> > >  static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1_scale_factor, u=
64 l2_scale_factor)
> > >  {
> > > -       u64 tsc_khz, l1_tsc_freq, l2_tsc_freq;
> > > +       u64 l1_tsc_freq, l2_tsc_freq;
> > >         struct kvm_vcpu *vcpu;
> > >         struct kvm_vm *vm;
> > >         gva_t guest_gva;
> > > @@ -159,11 +159,8 @@ static void test_tsc_scaling(u64 l0_tsc_freq, u6=
4 l1_scale_factor, u64 l2_scale_
> > >
> > >         vcpu_args_set(vcpu, 1, guest_gva);
> > >
> > > -       tsc_khz =3D __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
> > > -       TEST_ASSERT(tsc_khz !=3D -1, "vcpu ioctl KVM_GET_TSC_KHZ fail=
ed");
> > > -
> > >         /* scale down L1's TSC frequency */
> > > -       vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *) (tsc_khz / l1_scal=
e_factor));
> > > +       vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *) (l0_tsc_freq / l1_=
scale_factor));
> >
> > Our internal Sashiko complains:
> >
> > [Severity: Medium]
> > Is l0_tsc_freq passed to KVM_SET_TSC_KHZ in Hz rather than KHz?
> >
> > In main(), l0_tsc_freq is calculated in Hz by multiplying the KVM_GET_T=
SC_KHZ
> > result by 1000. Passing this value divided by l1_scale_factor into
> > KVM_SET_TSC_KHZ configures the guest TSC frequency 1000x larger than
> > intended, since the ioctl expects a value in KHz.
> >
> > I concur.
>
> Drat, I thought I had fixed all of those goofs.

Well, the issue is rendered moot by the next patch in the series.
