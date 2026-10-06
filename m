Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA633F8AD
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791265027; cv=none; b=NAHLoH4zZ61EcsMKIBGJZLkQK/oeeit2wfpRe5Hi2vUVCSrwGhwH0d/KX2Ql7r/o4HnmwywWHtys0ravV+BT1rD8HXu6O7Cj22f/bX2qFTXYgco2QWSHLoIIDU0BWv9bLRJVR48TDjxsdT7Wdvv4Z9qGAb1o1/V4Ktgzj2t/opY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791265027; c=relaxed/simple;
	bh=8GHqHHW4P3wMvCdDuwdvXLkRiUFHsX1QeAsDhLHpns4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=neJPVVQs5APKNueQISbMXODJZ165qNXQ0joxFRJwACfD82lMDGLKgGhQTJEXSBXPSkDZ22YAvMLTQKwjAJ7MeKC1OseKhSbFAJPYTWclecg0qa8dh1NzCD88SN+8uOgMdZve1wSSkt503oQGiJH30mtUPklmAGB9FreldmYlVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wBGxP4q/; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBGxP4q/"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc7e92f36f9so2137231a12.3
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 22:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791265026; x=1791869826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JrZ+9fylt/opwUtHI9ou9/fKWBeNkcZDirBcL4MFEik=;
        b=wBGxP4q/hhSwaXNeJ83XxHT4QqqqhE6vUfLWwtJPRbYw+ThhgR9RpBVP4zwh2QIIvN
         4XPLvhFVNzw2tMWg56uwEzf4zo6oacqBAmaKURr0sgAB/a+Y2A0lGkZmGVD+J0Rp4UVc
         TcYx06nKpIKTb+e8BBN/1B3M2KwL218SjTv99qoLz6ArXZbf1ZrZVsBOoOw1g0jOGyaG
         +XvBcJLZFFJRO006FwT6218cu7vTxcqp1R7BddYqMK4H2Oqcakxg8iXWfXxKGmGcMRFk
         dWrBc1TvlBOAyiREBEJDAsYwec7VELHu0MFyCLftY2ZquuD33FHei58jw/Oy1yqEhy5a
         RXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791265026; x=1791869826;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JrZ+9fylt/opwUtHI9ou9/fKWBeNkcZDirBcL4MFEik=;
        b=k6S4NzDeij+btpw0Oq3NWwSeWYIkOlwEwvmecxO/I2IQ+H9JpZNVeXGCCgGp5mgdNN
         FP9ax6zQ7I4TRegssiDNRAQ9wE42GbgnuHnHA794NJWqQ93GrkET+pHVrgJhjxZLezWr
         xrMWKqaEykEqa2b6WgY/S3MsJWey6XtcMEC5cA7kvRQ/e/jnHKxrWFL6sd2WtEsZF/pv
         xdT3JH1jjcydVyWBNMHvL9w3srIkLdlyuyMGa+t94911RLBBAawPNA/wzAMKgNyjMpgF
         YjbNU/9TmS0q8qaxdwN7MZuOtVDTwU7AZ7Z8chFdLT6fXMuSpWKxoJDmYlrltzq2z7KM
         WYAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwDecTqKXy9dCRGBztZW+2UXom7FJPsQWLTlTBU4WA9m8qg0efEhZZsejWl4U0fWd7vEEY=@vger.kernel.org
X-Gm-Message-State: AFuF++kg1nSIFljdRGhxRIZy3xZ7baxSOnRfDUDzDRTD/5HDms03g+cx
	nUogCXuEPlYWV/wTgwzZC9yRjds3E8F9EoG0/OLUx/jX7JXzh9Fh+u7FtIrvTZjXm0U1WLloE5x
	1+l9oAg==
X-Received: from pgap125.prod.google.com ([2002:a63:4283:0:b0:cc7:ac0b:f49d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1405:b0:3dd:85a8:cb81
 with SMTP id adf61e73a8af0-3e12472425dmr273047637.36.1791265025528; Mon, 05
 Oct 2026 22:37:05 -0700 (PDT)
Date: Mon, 5 Oct 2026 22:37:04 -0700
In-Reply-To: <CALMp9eRkgiFYeQcTU_aweJQTfrq7ijN5hw+6otKE_RvgGQm=Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com> <20260930173635.3362655-14-seanjc@google.com>
 <20260930175237.A8FD21F00898@smtp.kernel.org> <ar1QBSKMGJUFBExK@google.com> <CALMp9eRkgiFYeQcTU_aweJQTfrq7ijN5hw+6otKE_RvgGQm=Uw@mail.gmail.com>
Message-ID: <asSJAJUuvCAXkCwi@google.com>
Subject: Re: [PATCH v3 13/21] KVM: selftests: Use KVM's reported TSC KHz as
 L0's frequency (sanity checked)
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026, Jim Mattson wrote:
> On Wed, Sep 30, 2026 at 11:23=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Wed, Sep 30, 2026, sashiko-bot@kernel.org wrote:
>=20
> > > > @@ -212,18 +209,30 @@ static void test_tsc_scaling(u64 l0_tsc_freq,=
 u64 l1_scale_factor, u64 l2_scale_
> > > >  int main(int argc, char *argv[])
> > > >  {
> > > >     u64 l0_tsc_freq, tsc_start, tsc_end, l1_scale, l2_scale;
> > > > +   struct kvm_vm *vm;
> > > >
> > > >     TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX) ||
> > > >                  kvm_cpu_has(X86_FEATURE_SVM));
> > > >     TEST_REQUIRE(kvm_has_cap(KVM_CAP_TSC_CONTROL));
> > > >     TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
> > > >
> > > > +   /*
> > > > +    * Create a dummy VM to get KVM's default TSC frequency.  All C=
PUs that
> > > > +    * support TSC scaling should have a constant TSC, i.e. there's=
 no need
> > > > +    * to calibrate the "real" TSC.  But do sanity check that the o=
bserved
> > > > +    * TSC is within range of KVM's reported TSC frequency.
> > > > +    */
> > > > +   vm =3D vm_create_barebones();
> > > > +   l0_tsc_freq =3D (u64)__vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL) * 10=
00;
> > > > +   TEST_ASSERT(l0_tsc_freq, "vcpu ioctl KVM_GET_TSC_KHZ failed");
> > >
> > > [Severity: Low]
> > > Does this properly catch an ioctl failure? If __vm_ioctl() fails and =
returns
> > > -1, casting it to a u64 and multiplying by 1000 results in a very lar=
ge
> > > non-zero value (0xfffffffffffffc18).
> > >
> > > Since TEST_ASSERT only checks if l0_tsc_freq is non-zero, won't this =
pass
> > > using garbage data instead of failing the test?
> >
> > Eh, yes and no.  KVM_GET_TSC_KHZ existed long before TSC scaling, and w=
hile KVM
> > doesn't sanity check tsc_khz, i.e. KVM_GET_TSC_KHZ could return a "legi=
timate"
> > negative frequency (when those ~2.17PHz CPUs come along), in practice c=
hecking
> > for a non-zero value is sufficient because any bogus value will quickly=
 fail the
> > functional checks.
> >
> > Heh, actually, kvm_arch_vm_post_create() *already* validates KVM_GET_TS=
C_KHZ:
> >
> >         r =3D __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
> >         TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ did not provide a valid TSC=
 frequency.");
> >         guest_tsc_khz =3D r;
> >
> > so this is a non-issue.  I agree it's not the prettiest, I just don't c=
are enough
> > to clean it up.
>=20
> In my best Sashiko passive-aggressive tone:
>=20
> Is it possible that vm_create_barebones() bypasses that check?

LOL, *sigh*.  I'll send a patch to add a wrapper, having to manually do the
assert is annoying.
