Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C99357CE0
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790984644; cv=pass; b=HdUl2FeHEI3yZ4k2kSkQSmS36VpkrX3wpZS79pIykEMLqux9S+NW4ojsUx8H/PQ9Aj9z5HISq1iicuGTsurWiKdPCEb6KJTAV1/DggJM06JjSjaMjCU9VzwrzNS81o6RfP5b3rCvxAVOUJA/J+pFiNcbib/C91PMcoyrRjV1prI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790984644; c=relaxed/simple;
	bh=DZr/vCbFgIBJPmKcQOyr74fLm5UgcCgTHWfWGuIHrcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDzi8DOs6NONjRLPw7oU+a13ji8o1WduuUdUFrR5YGpPfBvzlTru/7s4JUaeoQLf2xob2P3EK3/kob/9EIVy3griZTBvdDc2yk5x3ZfLf1yRhEd40k0VQVOzxhe7CQVoO0EhtXRBSu1hji1G6Ople+W9qQl46zr/qGAcZ5xaD/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U6YKuQyM; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6YKuQyM"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso1780a12.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 16:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790984641; cv=none;
        d=google.com; s=arc-20260327;
        b=kdOYMfOLS+fea4SH3mwz0KJ8aaK3xhWWTcYSkhtW3TMv6lRP58f1DHKw4SSOFflBAL
         KXspxeRt+f0vG2Lk+C3bwU0scX7dC0umRXnrW6vOLvcDJynmr+j2xhz08okhJ1rbtGdP
         AkUuAf+r/U1W+DoCNj/FINeb8BjHrZDIpYILWKYxTxg5JxLBpv5VRKDMDCNijbS7PhnV
         dUuijmGpYBLJQN7ttmncEez/W5aqCzvloDrF/X5mKUIS9X8cxqBtaePcoOdICUQoZAZS
         FECwK3wx7D+G7QjBRvTPjFyz26HbI3wIoW+G1Ep+NYjfagks0T1sSmbgnis7RqZUq7m+
         lB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aIlGyARb9eRqNb63DpSQXFW7TwIGyoCVVTaa9X6iF28=;
        fh=LzRiDC7yq5xCqU8Utb14k6bRiaSzMZ+7sPpuiqbYZfc=;
        b=Of15s+5IK12txWzgje1wJnqHa+lnj/Y1X22lAZNXx9yq/YSjLP+6jVMpJMQgaUvL2+
         GR4LnlttC8l9kGncQks7xmtUZkNgCtYr9Agdmemib1yvFq2+aR62tpPJmfRVHYO1Hy7B
         tmANj549rVZ1lDAuT6SlJ3PGYfqMAN5bB5/t4EL04Z4xq/DHRXN3LiaVUROjWv7Dklfp
         UeaKCK12tYPrVMnNrwp2uP5qRvdNVmuqWoAKpOCMX8SPZdgIGD9YgVqk/6XtAKxMvZwT
         Sr6w/gcxxo4N8luUkeUkFE1Y6lkWpkesFQP7+1ZDtnE2FH5daOWN29HI05zY6pR1m4HE
         donw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790984641; x=1791589441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aIlGyARb9eRqNb63DpSQXFW7TwIGyoCVVTaa9X6iF28=;
        b=U6YKuQyMD+EAfvHAC3PlMUdmYlM6khVjQupEccLbhTcTJnSxczvAPDjPTzkicVk716
         DypxW/X93qtWFXyVuwIikY4KZA+9bF7/H2dEZuuJbCbUiyb0oUIJ9iN9ZWkfd8UAscDF
         t3Q60wUWRJl6EBTbuIbA/L4X5WBx18rxvgLiu0aN8vcM94+qeeO1kEBACSdvcCxKVcuw
         2kMa3fuuRhpctLWsrISnDQvqRSoGe1xNgrg5fFMCEdC1gEV42wwJw9tXPNvA2Odwvs6+
         7wecBQzD54EPjQp7HIAaVPJbDTpRZHYtirCcVjvdW4aPlC13r2H642rHWp6k1iuMOAJ8
         n5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790984641; x=1791589441;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aIlGyARb9eRqNb63DpSQXFW7TwIGyoCVVTaa9X6iF28=;
        b=X6HNXKSNRx5FK3pFHi+p9Mve+sssZtGLFAEYvupuLnXSdFH2P0m03R+IiDm0G0MP37
         4YziMuFEYy2reMDPR5CK7Rc1QdNumlcxQFU/yMH9TfP8wPTP/Ud/urRbA8LjGayxahK8
         JdtcUjbysAiKYHQQRInpWPxt+IVS08lmN43fRmtWdo1CiZhDP7LOdIN+ePJkH3btvLnA
         njHLWf0V4tUf3z/DIshRs6P/hOSvUxFmtkqoDMF1IP5O5n4K89RsdX1sp3LD7rWfeo6b
         E4M7L6+Fp01wb2ri5xa0Xpovf/3CvMjoco/E1qPTZTKT/8MJvXtEZ93srckJjOV5EZJs
         ssEQ==
X-Forwarded-Encrypted: i=1; AKwUvByiy6/pQPRdKTWt+vhw1fFtBpr6L3CZny/UefNMa71CIpAhmt/x37QFTzNlTJfWtoHmORQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQOoTng+Iw2r2kEZngSeI+tPKAgDPkKejiIpGao9D3RC6WcBGX
	IipIiigkhu2KPOFxttJkkVqLIM/2JNVsL9RvsJAwSsjcp19fiEr/utj9KOYtfPURg/hI3cMFu1h
	Hxuo//qfc10e06Jh6Wp7LZHrW13gEWo+c7Tjt/kmK
X-Gm-Gg: AYBFou1mpiWZvx4AoKjb+Q+U5RdukL1D3ez5tf3l645EGlguw0QaX4eK/lSNAw9CZml
	Bi6FqMiLWiPQwvi78WETtja+cnUSzSqtEsZomu609K7QWUQzJdJ0z4HJY5DlaMEC2blgxSplWS2
	mDEx3b/2ycb8DhAvW2AFSqgycp6SS+P8FcZYRYT3cRNjH3niaCoGG9J4YUF4SPYVJ7dvse/W4/n
	SbqNbt6xKXmAsBanB99FTT+oxQW3NuWZof12eB8gNBPUhCUHHy29MEuvaL5VhvurLuxjS1xrSoz
	xoz+6muPUiRWEKO2SAysEWEhk8hLs46s1w7UxgoAB1c+kZzmIv40+qU=
X-Received: by 2002:a05:6402:a2cb:10b0:6af:7a5a:97e4 with SMTP id
 4fb4d7f45d1cf-6afaf6bf03amr12928a12.12.1790984640920; Fri, 02 Oct 2026
 16:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com> <20260930173635.3362655-14-seanjc@google.com>
 <20260930175237.A8FD21F00898@smtp.kernel.org> <ar1QBSKMGJUFBExK@google.com>
In-Reply-To: <ar1QBSKMGJUFBExK@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 2 Oct 2026 16:43:48 -0700
X-Gm-Features: AclHuK_u3oOlu9nwYVbzwucGA7__Is1oGfxZD76ma2kyYIXaC_NIXJdsyLaNogQ
Message-ID: <CALMp9eRkgiFYeQcTU_aweJQTfrq7ijN5hw+6otKE_RvgGQm=Uw@mail.gmail.com>
Subject: Re: [PATCH v3 13/21] KVM: selftests: Use KVM's reported TSC KHz as
 L0's frequency (sanity checked)
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 11:23=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Wed, Sep 30, 2026, sashiko-bot@kernel.org wrote:

> > > @@ -212,18 +209,30 @@ static void test_tsc_scaling(u64 l0_tsc_freq, u=
64 l1_scale_factor, u64 l2_scale_
> > >  int main(int argc, char *argv[])
> > >  {
> > >     u64 l0_tsc_freq, tsc_start, tsc_end, l1_scale, l2_scale;
> > > +   struct kvm_vm *vm;
> > >
> > >     TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX) ||
> > >                  kvm_cpu_has(X86_FEATURE_SVM));
> > >     TEST_REQUIRE(kvm_has_cap(KVM_CAP_TSC_CONTROL));
> > >     TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
> > >
> > > +   /*
> > > +    * Create a dummy VM to get KVM's default TSC frequency.  All CPU=
s that
> > > +    * support TSC scaling should have a constant TSC, i.e. there's n=
o need
> > > +    * to calibrate the "real" TSC.  But do sanity check that the obs=
erved
> > > +    * TSC is within range of KVM's reported TSC frequency.
> > > +    */
> > > +   vm =3D vm_create_barebones();
> > > +   l0_tsc_freq =3D (u64)__vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL) * 1000=
;
> > > +   TEST_ASSERT(l0_tsc_freq, "vcpu ioctl KVM_GET_TSC_KHZ failed");
> >
> > [Severity: Low]
> > Does this properly catch an ioctl failure? If __vm_ioctl() fails and re=
turns
> > -1, casting it to a u64 and multiplying by 1000 results in a very large
> > non-zero value (0xfffffffffffffc18).
> >
> > Since TEST_ASSERT only checks if l0_tsc_freq is non-zero, won't this pa=
ss
> > using garbage data instead of failing the test?
>
> Eh, yes and no.  KVM_GET_TSC_KHZ existed long before TSC scaling, and whi=
le KVM
> doesn't sanity check tsc_khz, i.e. KVM_GET_TSC_KHZ could return a "legiti=
mate"
> negative frequency (when those ~2.17PHz CPUs come along), in practice che=
cking
> for a non-zero value is sufficient because any bogus value will quickly f=
ail the
> functional checks.
>
> Heh, actually, kvm_arch_vm_post_create() *already* validates KVM_GET_TSC_=
KHZ:
>
>         r =3D __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
>         TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ did not provide a valid TSC f=
requency.");
>         guest_tsc_khz =3D r;
>
> so this is a non-issue.  I agree it's not the prettiest, I just don't car=
e enough
> to clean it up.

In my best Sashiko passive-aggressive tone:

Is it possible that vm_create_barebones() bypasses that check?
