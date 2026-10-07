Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA9822157B
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 06:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791353057; cv=none; b=C4tWFhiem1chO/qvpj6mla5p6kca469sU4kEak8Dg8om+ENI+zziUI3k9O12q0TBdIFTxe+TEylBm8HSUx5T/GMD8ZVGAqEwtyYJ9f1DzsaJd7HcfejEe9dG00i6So6ZfNKuRpSY4l4xtRutJNAPiDzAqmgRJZSi9dg6sVBmmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791353057; c=relaxed/simple;
	bh=SlxywiYNTN/vMh+tKJ4hiU9xxky0J2NSIW3uscQ7HSI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qpfIGijIJexA3KLzmdEKyCwRSf8pMYaKZM0s9R2nQL/bzG9IlaFc3BQTxDZO6cpyZG9nGgSoNOk/R0rMLYermxALaBmvdreKm+JL0GKULQeWE67IFHkMVgRYXqCb8eW4VxltuWStAD2ZvL4xuTbODHIGu4ZP+j1gHrSPDbjNmeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KYJUkqEm; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYJUkqEm"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2df8d1e91c9so66918505ad.0
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 23:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791353054; x=1791957854; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7Dzf0BvAXFZBe0f6pp2D4e8a/RDTV83MOaX+nbQF2dU=;
        b=KYJUkqEm7p7IrmirtjpieozljBw/CiMrrYqj+cql+lbGyUMDjzKe3k0EdS2KQrD01Y
         1bp1guWzLKhxhcLOt3jhfMscf7aAx/pg/eb5omXOFAmud6LviE3ueKq2F5N9I96Ly9NQ
         gpVEnBqZ4UXVOW2rUjUslu1MQFqquZb0J0t1o3OBuyUycAmcNgMU95CKJ6Jv/X3SklDC
         5yToVw8wwzsE4h76vjX3dY9l3bpTBuKudtVuaL9UYVdNS5BLVFO8refpFlvAP374BXes
         KgWrHWdwTYbT57L8CaT0TdbSHbQgsR0EiN8gknN8hC7iQxrG7KwLblH4d2vYug393utV
         lNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791353054; x=1791957854;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Dzf0BvAXFZBe0f6pp2D4e8a/RDTV83MOaX+nbQF2dU=;
        b=M6I8Bl2vlhl/rS7tXLXOwI9ggwbJp0dPlOGtqJS1Dped4cLWTdqPsIwT+7tC/YbLw4
         ISQjIka9hQbehVLES2AN6VkzWhPJpXF0nYtnUxgYtDbAwRXcyhtL9UrL6OgKPDrx/IVh
         enSuhQF85MPlXoV3KvjfsP6NGU70tw6WWir+U8c2WlNYg8XllRfcUttN1BMnkyIyxo/A
         mba1JmYvhGcYeDFMe1+G2YkfOwegcoxR0qHI94B2i6Lzc2dMj1SRUKZNMts/dNUnIGBQ
         ZZ1JTY3gCWeMqzyUG6DONNKNSioUgFgZOJNKYjeMJJC6S4/O6Phlhv/FTd6cfLaU7yn+
         rsGg==
X-Forwarded-Encrypted: i=1; AKwUvByIY2dtP1WCRj8YYZ1ChggBEPFBt/cJ4MuY5qbOIPliILokO/7JrLIePLQh5R3/3iYI6k4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIq2xolT6DbK+spl1bTgFg6Kg2QwlEW41gBQvNUMOYhMove8cSF
	D7E8gxRcePDnJBDI02wNssSnZ4wzsvJZ/RVo/AjC1Xi1CYnpkq607eJ3cQXeJkvFIE9yjUPIdss
	0INrY7w==
X-Received: from plkb5.prod.google.com ([2002:a17:903:fa5:b0:2e6:13a2:7648])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f706:b0:2e6:1715:e468
 with SMTP id d9443c01a7336-2e61715e6cdmr2886455ad.61.1791353053953; Tue, 06
 Oct 2026 23:04:13 -0700 (PDT)
Date: Tue, 6 Oct 2026 23:04:13 -0700
In-Reply-To: <CALMp9eS0=HgM02Ff4mv6RLHVoM3EgavhKu_P6J-oTWTMbk9zng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com> <20260930173635.3362655-14-seanjc@google.com>
 <CALMp9eS0=HgM02Ff4mv6RLHVoM3EgavhKu_P6J-oTWTMbk9zng@mail.gmail.com>
Message-ID: <asXg3cJvaeqMOfAr@google.com>
Subject: Re: [PATCH v3 13/21] KVM: selftests: Use KVM's reported TSC KHz as
 L0's frequency (sanity checked)
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 06, 2026, Jim Mattson wrote:
> On Wed, Sep 30, 2026 at 12:04=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > Use KVM's reported default TSC frequency as L0's frequency instead of
> > calibrating L0's frequency using RDTSC.  Trying to calibrate the freque=
ncy
> > in userspace is all but guaranteed to be wildly inaccurate, e.g. due to
> > interrupts, preemption, etc, and no known CPU supports TSC scaling with=
out
> > also having a constant TSC.  I.e. there's no need to calibrate the curr=
ent
> > frequency, as it should also be the same as KVM's default frequency.
> >
> > Opportunistically sanity check KVM's reported frequency against what is
> > observed via RDTSC, e.g. so that KVM_GET_TSC_KHZ or platform issues sho=
w up
> > much earlier in the test, before VMs get involved.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  .../kvm/x86/nested_tsc_scaling_test.c         | 25 +++++++++++++------
> >  1 file changed, 17 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c =
b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> > index d790ab36a198..a78585af0ffd 100644
> > --- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> > +++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> > @@ -137,7 +137,7 @@ static void l1_guest_code(void *data)
> >
> >  static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1_scale_factor, u64=
 l2_scale_factor)
> >  {
> > -       u64 tsc_khz, l1_tsc_freq, l2_tsc_freq;
> > +       u64 l1_tsc_freq, l2_tsc_freq;
> >         struct kvm_vcpu *vcpu;
> >         struct kvm_vm *vm;
> >         gva_t guest_gva;
> > @@ -159,11 +159,8 @@ static void test_tsc_scaling(u64 l0_tsc_freq, u64 =
l1_scale_factor, u64 l2_scale_
> >
> >         vcpu_args_set(vcpu, 1, guest_gva);
> >
> > -       tsc_khz =3D __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
> > -       TEST_ASSERT(tsc_khz !=3D -1, "vcpu ioctl KVM_GET_TSC_KHZ failed=
");
> > -
> >         /* scale down L1's TSC frequency */
> > -       vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *) (tsc_khz / l1_scale_=
factor));
> > +       vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *) (l0_tsc_freq / l1_sc=
ale_factor));
>=20
> Our internal Sashiko complains:
>=20
> [Severity: Medium]
> Is l0_tsc_freq passed to KVM_SET_TSC_KHZ in Hz rather than KHz?
>=20
> In main(), l0_tsc_freq is calculated in Hz by multiplying the KVM_GET_TSC=
_KHZ
> result by 1000. Passing this value divided by l1_scale_factor into
> KVM_SET_TSC_KHZ configures the guest TSC frequency 1000x larger than
> intended, since the ioctl expects a value in KHz.
>=20
> I concur.

Drat, I thought I had fixed all of those goofs.
