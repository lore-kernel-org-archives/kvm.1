Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038002;
	b=14+yihzTv3wSWdgX55dVXV0b1/vgxhsrK3mQbfWmOFbDyGdxAh2pZjhYKvjp0Vq/SPtB
	 AJu6Mc8gkErbRR9ON3jH/Jy9D+hjTKsPDoX/sM10Q1JpP80GCeFQWTKepBaatsKB4/BxO
	 Qa/XLTn27+NBHFR1Fzp1uDq2vGkPyotysdXyiwWE8lFxZo5nwu8YjUaFW8hF7C8D5TJ/G
	 XG56SA2n0BZ1b+lRXcAGRhE/8o2pkkxXXec2VdKKXmSSR9gkR53Zu8JM+eG86WFCAjXbz
	 CHtqUlFZa6yDRemxqgUZ+qu8+DFhRv9/0nuFTg4/Tj25kgKp5khPzChHA44KDOVfgAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038002;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+WO5y2AngqrfTxKT/T6m0OE0wBrX03D/nrxV02HU4vc=;
	b=X70Gb9nKGnwc2v6l2NREeAmmzv0U4QzFtUjxRNlx243RKlykwa56IjRuvqPK8GaHPNB/
	 K9AJ6c5sWjSR7PhDo2n4wkgPQGNST/cDPSyIf3/DSjEJsAWmWBrQ2VW7XXGJUWChc8+Dg
	 Lv/eY+DH1P5gT0YEU4eavMGaf+q18ZjmirZ65HHJvvhkqRnI3BtoP53SMUGSpgezD/8a1
	 4iaPBJ8qML2uglgT3dThj5XWHq/tFRCwIOGMZAR3PHxMisQ9h848y5AvAadhaL4lGTEGx
	 49YYU108LzaBSOMqzjogY7P9C9ltXzIRo+hNdiAhNNpm+8wB425dGb0UucrKrZif88g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuZXGavS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C6606A31D
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuZXGavS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722171F01828
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793038002;
	bh=+WO5y2AngqrfTxKT/T6m0OE0wBrX03D/nrxV02HU4vc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nuZXGavS7nwFeAtYZG7Ii6CGpwv1djXJ4FILZrlSUIc/7SDyHIO6iDDZZxvwrm5fB
	 jcFWKx3mcvvX1zH9ZMh+bDWAO2Auj0SS4Vs1jScV19plYqqgc0djX650H0AGyeRHS7
	 sHBXCymBNa2Eug59E93QeFQx9Jcgl+n3fSjHNEAmQDN2wKkissZqp0MrUW79u+nTFt
	 gtSnUzGfqk+10Hxe71diHoMxPx6bhOPEYKOT1W4AqvT3grHwCdqVrQuEjGnhMclcDa
	 Ct77NL6BxqTRehOjetYmscGLySn1ssD0IqEjrFiB+T1s/VMtg2goFQnaeTUYr5U5VV
	 g71TmvtcZx6xw==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f30660e69so221175785a.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 11:06:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwcvIBPqlJ862gghMFlSJxn7fzDeie3G5R+6w5grbFh80ec5SWjH/JzQpa1nOBrom9xVP0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXCuxSgOYs/Ii9nXnJete3et/9Xj7+OKN16MDBy7s/qXhqvBZy
	J4GxCxEvUV15ceH1k61rz7E3JoJzUygLrAfOUWs++XmNeddW8Pg6kh33vl5Xum34We7+jlPq6wr
	K9XQE1ZQ7+ryGycPK6nTI7YoeI2Lk2P0=
X-Received: by 2002:a05:620a:2984:b0:93a:82a:71e5 with SMTP id
 af79cd13be357-940ef901e83mr1117271685a.19.1793038001851; Mon, 26 Oct 2026
 11:06:41 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-27-yosry@kernel.org>
 <CALMp9eS8KDozNGT9J_uN69W32QEvTbg2JrtRqN0ESi00b_uq=A@mail.gmail.com>
 <atqRyeqSXViiNIk6@google.com> <CAO9r8zMqiW=3t7zRo_WAhKJfpYsDwuG3e=nK14GXhrq+foYnOw@mail.gmail.com>
 <at-O8-tzgezj2du-@google.com>
In-Reply-To: <at-O8-tzgezj2du-@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 26 Oct 2026 11:06:27 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO8ViSqCBer4rV5qBQGcDKA_60Aj_KEVQx2obd9zU7-Hg@mail.gmail.com>
X-Gm-Features: AclHuK_nwQrxES2GqNZh5mrxNi_TR0Sm-muFcxiIyZPzWxpBNhYA6gRX4WEkbgA
Message-ID: <CAO9r8zO8ViSqCBer4rV5qBQGcDKA_60Aj_KEVQx2obd9zU7-Hg@mail.gmail.com>
Subject: Re: [PATCH v3 26/27] KVM: nSVM: Use different ASIDs for L1 and L2
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 10:33=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Oct 22, 2026, Yosry Ahmed wrote:
> > On Thu, Oct 22, 2026 at 3:44=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Fri, Oct 16, 2026, Jim Mattson wrote:
> > > > On Mon, Oct 12, 2026 at 4:37=E2=80=AFPM Yosry Ahmed <yosry@kernel.o=
rg> wrote:
> > > > Moreover, does this change the semantics of PV TLB flush? In
> > > > record_steal_time(), we have:
> > > >
> > > > if (st_preempted & KVM_VCPU_FLUSH_TLB)
> > > >         kvm_vcpu_flush_tlb_guest(vcpu);
> > > >
> > > > IIUC, an idle vCPU that wakes into L2 will flush only L2's ASID. In
> > > > the past, with a shared ASID, L1's ASID was always flushed on emula=
ted
> > > > VM-exit anyway. Now, L1's ASID will be unaffected. Though I can't f=
ind
> > > > any real documentation on PV TLB flush, it *seems* like the remote
> > > > vCPU would want L1's ASID to be flushed. OTOH, this change makes nS=
VM
> > > > behave just like nVMX.
> > >
> > > That's a bug that absolutely needs to be fixed, probably relatively u=
rgently.  We
> > > should also document that passing through the steal_time shared infor=
mation to L2
> > > to utilize PV TLB flushes for L2 is explicitly not supported.
> > >
> > > I hate to re-introduce deferred actions for L2 =3D> L1 things, but th=
at seems like
> > > the only sane way to handle this, because handling the !tdp_enabled c=
ase, where
> > > KVM needs to sync the current root, requires knowing what MMU is goin=
g to be in
> > > use when L1 regains control.  Yuck.
> >
> > Are you implying that *you* will be re-introducing deferred actions? :P
>
> Heh, probably not this calendar year.

Are you opposed to this series landing before that is fixed, keeping
in mind that it will expose nSVM to the pre-existing bug?
