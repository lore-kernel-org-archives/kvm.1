Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF8634F255
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815670; cv=none; b=jFnGLhK+ZFEz8rXwYX2qPEF4lkW+eX/fAQLYAgixb0DJjXEyHATdEBNeb1xuWIWiWPNUp8jLXv1CZ3LiAhHI7zpGN32J80+8wCQrehgOZuUvBqT/E9ugnTF/mmCJoh+8hgRZiMk6geWP4H3MBeikNkeYMFgWcWlzCSq3esKjGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815670; c=relaxed/simple;
	bh=lvLxv0a7ddSghcgNjikKGFBHIJQ96CiM+qyO1VfahSs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H4P72+bFnTFLG92n9T0g6WuMtj5ggHr590QxMLjjJdE9xmuvBXMczLWK1gGBIla49KVG8ZRqnFXhZnymPvs6R4x568IixrNudxTlqUGu7zXcDzpe1aEhlIgZ/ef6fZNM+aARVzDMR5gexlx6fhWJPmHIbTFHVoSjSrlXcESs54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LdePGXyJ; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LdePGXyJ"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c7f385887bso14283345ad.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784815662; x=1785420462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KkkLxjRuacH+YWuwhfrHPZbQVzyfdxh66YMxAceC5IQ=;
        b=LdePGXyJI8nufGEpxQt6v9VgB2HtFznbux6NZeBSSBipvOK2cH6ArMdNvGYtuKweX0
         WME+5EhtshXmURsoL0Ek+INTFDDvQHI0Z6nMcnOIEpYI46UQxXRmxKQPEMi9X2lX3pyY
         xmGzJY0eTqadqZeP53wF2cFae1Svfh6cYG2bQOqwIyAQgAlHUjQfNfoYxA1D0vgoxVET
         6M1kJiVWLx0sESaK+PNYipJftkkWfIJ1tF7vnNXZaDf1eVF0Gsx7bSrUs8UA63h5kzK0
         Xsczm1QQWtkc6V2SPUzvuihrpfgHa5yTsHc1CYJUpJleuyuPDgPGL967fLlSr0MQtaOl
         6tLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815662; x=1785420462;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KkkLxjRuacH+YWuwhfrHPZbQVzyfdxh66YMxAceC5IQ=;
        b=oYu+LAEq/1y9jUYKUHINhqA9kbxtsp5Y66J76TRRWl1DGy7PzJ5ila56mf4vXcaYTO
         vFQzqo4d1apdJfMfT7oMSH5lf34dyBqwJKWgsTl1uqtWuIauPfo11P1VyGIWiEAiEvcw
         9ipW6oA/RWLNkC7tQQASw3/Wb41BiczxF1tZ2gQrhkjIYD2ctibrZX9bQ5yC+urZMXBr
         nABhAREcFehS4s5x7F+GbgTb8hPeLoHfZxBAsbQFYvJiW5oo52hKIccG22kEgDAD2p2z
         KB8V4peDMfYaUl5YPh1+UTxCkDrAa29EJU31JT5noBX+fvVmq6n5XdhGuBasYoEveoOR
         C5cg==
X-Forwarded-Encrypted: i=1; AHgh+Rrf4mDXigD1wwKReBs+RUjwGjJqAN2VkTzeUMf25q99vGNfPxHuystqE/EcFBjf6jJs678=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCFY/q6PeQFjknb7KH0dSU+q7pmxzRnyBN1ayNvBs1K0LxNA/d
	mq4iTn9WwUpyFnHn+8z89hV/alkny5WseNuAG6mEETUm1X4HP/tkeEZDiFRbo/mJpeEQtKF9END
	oQBMxWA==
X-Received: from plpw15.prod.google.com ([2002:a17:902:9a8f:b0:2b6:417:db8d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d490:b0:2cc:a977:4260
 with SMTP id d9443c01a7336-2cfa6bc41bemr42950935ad.21.1784815661627; Thu, 23
 Jul 2026 07:07:41 -0700 (PDT)
Date: Thu, 23 Jul 2026 07:07:41 -0700
In-Reply-To: <CALMp9eQi=604LVn=ZMnzoUy55LVb1qorKzPKm5HVK_ACsPuP_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
 <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
 <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
 <albJNb-akQJ97Yor@google.com> <CALMp9eRGx=K+UBp76A=dZ=bD_Txonq7j8pSn9HVczdtyyuAs3Q@mail.gmail.com>
 <amE_nPDem-imSfqF@google.com> <CALMp9eQL7y5chFEDCrqMR9CbJgiJxXN1hVzxVzojsr92AWnqrA@mail.gmail.com>
 <amFf5MAhc8sUqeYV@google.com> <CALMp9eSssBCuTTWdr1qT2c4Nto2PQO-QOBnobcx2kTnuQaOB1g@mail.gmail.com>
 <CALMp9eQi=604LVn=ZMnzoUy55LVb1qorKzPKm5HVK_ACsPuP_A@mail.gmail.com>
Message-ID: <amIgLeMCAH2vB4ot@google.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026, Jim Mattson wrote:
> On Wed, Jul 22, 2026 at 7:46=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Wed, Jul 22, 2026 at 5:27=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Wed, Jul 22, 2026, Jim Mattson wrote:
> > > > On Wed, Jul 22, 2026 at 3:09=E2=80=AFPM Sean Christopherson <seanjc=
@google.com> wrote:
> > > > >
> > > > > On Tue, Jul 14, 2026, Jim Mattson wrote:
> > > > > > On Tue, Jul 14, 2026 at 4:41=E2=80=AFPM Sean Christopherson <se=
anjc@google.com> wrote:
> > > > > >
> > > > > > > What complications?  Advertise the lowest common feature set =
for the pool, just
> > > > > > > like userspace has to do for literally every other feature.
> > > > > >
> > > > > > The problem with passing through the number of host ASIDs to th=
e guest
> > > > > > is what to do when the combined host plus guest usage exceeds t=
he
> > > > > > number of available ASIDs, particularly when FlushByASID is not
> > > > > > available.
> > > > >
> > > > > But that doesn't have anything to do with the number of ASIDs tha=
t KVM enumerates
> > > > > to L1.  As of this series, the number ASIDs KVM will consume in h=
ardware is a
> > > > > property of the total number of vCPUs in the system (one ASID per=
 vCPU, plus one
> > > > > more for nested usage).  E.g. if KVM advertises 10000 ASIDs to L1=
, all 10000
> > > > > (10001, if ASID=3D0 counts?) of the those ASIDs will map to svm->=
nested.asid02.
> > > >
> > > > That's not the only conceivable implementation.
> > >
> > > But it is what is proposed in this series.
> > >
> > > > KVM could advertise 64 ASIDs to L1 and reserve the corresponding no=
n-zero
> > > > ASIDs for L2 VMs (i.e. the first L1 ASID is 64). Then, vmcb02.asid =
=3D
> > > > vmcb12.asid & 0x3f.
> > > >
> > > > > Of course, that completely undermines my statement about suboptim=
al performance:
> > > > >
> > > > >   And potentially suboptimal for performance.  There might be a l=
egitimate reason
> > > > >   why a CPU generation advertises X instead of Y.
> > > > >
> > > > > My bogus assertion about performance notwithstanding, I still thi=
nk advertising
> > > > > what hardware supports is the simple, sane approach.  Because at =
the end of the
> > > > > day it's just that: advertising.  Userspace can do whatever it wa=
nts, including
> > > > > peeking at raw CPUID.  E.g. if we want to pull a stupid and emula=
te the behavior
> > > > > of ignoring "unsupported" ASIDs, then we'd need to do that based =
on userspace's
> > > > > defined CPUID model, not KVM's advertised support.
> > > >
> > > > But you could refuse a userspace CPUID model that claims more ASIDs
> > > > than KVM supports.
> > >
> > > Nah, that's not the KVM way.  For this one in particular, there's zer=
o reason to
> > > enforce anything.  Practically speaking, *if* we want KVM to act like=
 hardware
> > > and ignore unsupported ASIDs, then KVM *must* allow userspace to defi=
ne a max ASID
> > > other than exactly what's reported by KVM_GET_SUPPORTED_CPUID, otherw=
ise migration
> > > pools become impossible.  And at that point, disallowing a larger max=
 ASID adds
> > > zero value.
> > >
> > > If KVM claiming support for an explicit number of ASIDs is a sticking=
 point, then
> > > I vote to zero the output in KVM_GET_SUPPORTED_CPUID, but I'd prefer =
not to do
> > > that because it will break reflecting KVM_GET_SUPPORTED_CPUID directl=
y back into
> > > KVM_SET_CPUID2.
> >
> > If KVM supports any userspace-provided value for NASIDS, then
> > shouldn't KVM_GET_SUPPORTED_CPUID return 0xffffffff?
>=20
> Having given it some more thought, 0xffffffff might induce buggy guest be=
havior.

Ya.

> However, since KVM completely ignores NASID, it would be sad if
> migration were blocked because the target has a lower NASID value than
> the source.
>=20
> That's an argument against changing it without some kind of userspace
> opt-in. Increasing it seems safe, but if userspace just reflects the
> value into KVM_SET_CPUID2, then an increase would block kernel
> rollback.
>=20
> In any case, I think the new value should be a constant so it doesn't
> imply a migration constraint. Perhaps we should adopt the highest
> value reported on a physical CPU to date? I think that would be
> Bulldozer's 0x10000.

Or keep KVM's enumeration at 8, then find somewhere in KVM's documentation =
to
describe KVM's behavior and provide guidance for userspace, but otherwise m=
ake
it userspace's problem to solve?  I'd be a-ok with that.

In practice, I highly doubt any production setups that support nSVM regurgi=
tate
0x8000000A.EBX from KVM_GET_SUPPORTED_CPUID back into the guest.  And if th=
ey do,
very arguably keeping KVM's existing behavior is the safest option for them=
.

E.g. somewhat amusingly, QEMU hardcodes the number of ASIDs to 16:

            *ebx =3D 0x00000010; /* nr of ASIDs */

I think we'd want to update KVM selftests to validate a broader range of AS=
IDs,
but I'd want that coverage no matter what.

> > > > And __nested_copy_vmcb_control_to_cache() already ignores a bunch o=
f
> > > > unsupported bits. I don't see how this is any different. That's how
> > > > the hardware is implemented. Intel likes to fail VM-entry. AMD pref=
ers
> > > > to just ignore hypervisor stupidity and move on.
> > >
> > > The issue is that KVM has played nice with unsupported ASIDs for year=
s.  If we
> > > want to change that, it needs to be quirked.  And I just don't see th=
e point,
> > > because KVM's behavior isn't outright wrong: the APM doesn't say what=
 will happen
> > > if the hypervisor is being stupid.
> >
> > The APM doesn't say that an out-of-bounds ASID causes VM-entry
> > failure. What other possibilities remain?

As real CPUs apparently do, the unsupported/unused bits can be ignored.  Bu=
t that's
only a viable option if the number of ASIDs is a power-of-2, which KVM can'=
t
guarantee (without yet more semi-arbitrary restrictions on what virtual CPU=
 model
can be enumerated to the guest).

ASIDs above the max could be capped to the max ASID.

Hardware could detect the impossible-to-track ASID and effectively treat it=
 like
VMX handles VPID-disabled, i.e. flush on every VMRUN and #VMEXIT.

And obviously "hardware" could pretend the max is just a hint, and make it =
all
work, as KVM does.
