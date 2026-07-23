Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA7C39CD07
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828058; cv=none; b=YDAhYWRdPiQFiY5CvObVuFq4eNmWmEz7z9kZA7cNHUH/4jiJU3h/uynubtBVv/pE4BFXa4zIhxnzdChuP9lAQ2UDrEpm7kT1GVt0uMI8ao0GCf8TvGCh6cfqZxeSqF4ia9ltmoYBgOVn8yq6FE6it8Idlwis76L3MFUS6QPKltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828058; c=relaxed/simple;
	bh=sZ75fyPUpsG4cDZaf3qg0RDGMoCrr+NvIVGfWAPKEqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnxM9n3sY/HpU/pN5oEfNEMISWeq+XeaFC8SLM7F+/C7GBQefC1b74CJ0C3qaSwq30QX0dv6v23//76aE6dM2hAM+mSNAJ70SnUyYmLN9Sh4srjGhDScUhs89k4aUPuDEAI7UY6wB9G7mCAIpOhJ4bIqVUFmqqpZErjBZF2n2Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmrAV09S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmrAV09S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F661F000E9
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784828054;
	bh=Xn3IGnx6Ieb7ewYOeq32UjxUiAozzX1qNNxJmdlr7yc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CmrAV09S7lHvqtv3CpuDrRmVoLNXrlMlMyefKusnyAYWGp9PC58d7Mr3HT1AlJA/h
	 m2Kdi77/Nhvs57C4K6kn+bbCmDFeIYl/2p+6M60UeBV1GyhMp+REhda5i5DLN9C+D/
	 OXonh2/RrUL7yYJ9PRS5YWoZFF3F4aNCjRJEAEnzLJG7DPprLR9JDMtq13W53I2aaK
	 PtXi4u0lRFp53gehAqH4d4ATOWuOvOQArJ+OH5Xov8pcipAjbDZ+2K9UeW20YHLGUr
	 +KxNiC0TliaZCInkkbmeGCZ0J/9N/JiQHpOsfkj+iWWnQFC/IRyB9NUra+UQEQb8Ww
	 57L/+5cRhYXQw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15cd3fd760so113134866b.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 10:34:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrhxbe1dsX02D3XVF6NJ/grCx98V1guK4h7GsSnma3Mbd7K5UW9VbsDbZYy8ylEP1ke1MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvJFTGJclCV5MGqDIDDmQnlFwv7oegbXshw5/wyVft8Ydejqhx
	bzsWpF9FUaPOOy5yoUSrrmSC49OT4WsIPELdS9rxQbiRHkzc66twoM5mD3c8waMKrpIPqJ6WoZd
	APDHB4423tulrb9QMYR1TIrMexZi3QFg=
X-Received: by 2002:a17:907:9806:b0:c12:2b09:6c83 with SMTP id
 a640c23a62f3a-c1c50b91a28mr190563166b.33.1784828053898; Thu, 23 Jul 2026
 10:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALMp9eQL7y5chFEDCrqMR9CbJgiJxXN1hVzxVzojsr92AWnqrA@mail.gmail.com>
 <amFf5MAhc8sUqeYV@google.com> <CALMp9eSssBCuTTWdr1qT2c4Nto2PQO-QOBnobcx2kTnuQaOB1g@mail.gmail.com>
 <CALMp9eQi=604LVn=ZMnzoUy55LVb1qorKzPKm5HVK_ACsPuP_A@mail.gmail.com>
 <amIgLeMCAH2vB4ot@google.com> <CALMp9eSgfL8C7SU+j6+c5s64end-n4uHh=uXtTpDVJ7RcvLQgw@mail.gmail.com>
 <CAO9r8zMukfW2b5tjYarpkpPH0osA_+QEEMRq8k5R8B_WFG_yYQ@mail.gmail.com>
 <CALMp9eRsJeByu4U8NZQhnKM7BaKziyLUix6J3XGCEMZyiar=vA@mail.gmail.com>
 <CAO9r8zOtzSscMx_PFuABkXzZ=xgGOcioegKzgYscXa9WiobySg@mail.gmail.com>
 <CALMp9eR2XffG3pQL_pjGphSqMGfpJ9vRJi45Hd9RuCSd5EwU6g@mail.gmail.com> <amJOyIOzsJx8dWa-@google.com>
In-Reply-To: <amJOyIOzsJx8dWa-@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 23 Jul 2026 10:34:02 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNBLNabmG2ar4o6fEgSVBj9_77MXBKVMGM-gBp2UsrYGQ@mail.gmail.com>
X-Gm-Features: AUfX_mxQY6mm8EPbT2gJ1v2J5JdKZZdssbanCZ6v94BsgPm4CcMrJXtu1l6HtCA
Message-ID: <CAO9r8zNBLNabmG2ar4o6fEgSVBj9_77MXBKVMGM-gBp2UsrYGQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 10:26=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Jul 23, 2026, Jim Mattson wrote:
> > On Thu, Jul 23, 2026 at 9:57=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > On Thu, Jul 23, 2026 at 9:54=E2=80=AFAM Jim Mattson <jmattson@google.=
com> wrote:
> > > >
> > > > On Thu, Jul 23, 2026 at 9:32=E2=80=AFAM Yosry Ahmed <yosry@kernel.o=
rg> wrote:
> > > > >
> > > > > On Thu, Jul 23, 2026 at 8:57=E2=80=AFAM Jim Mattson <jmattson@goo=
gle.com> wrote:
> > > > > >
> > > > > > On Thu, Jul 23, 2026 at 7:07=E2=80=AFAM Sean Christopherson <se=
anjc@google.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jul 23, 2026, Jim Mattson wrote:
> > > > > > > > However, since KVM completely ignores NASID, it would be sa=
d if
> > > > > > > > migration were blocked because the target has a lower NASID=
 value than
> > > > > > > > the source.
> > > > > > > >
> > > > > > > > That's an argument against changing it without some kind of=
 userspace
> > > > > > > > opt-in. Increasing it seems safe, but if userspace just ref=
lects the
> > > > > > > > value into KVM_SET_CPUID2, then an increase would block ker=
nel
> > > > > > > > rollback.
> > > > > > > >
> > > > > > > > In any case, I think the new value should be a constant so =
it doesn't
> > > > > > > > imply a migration constraint. Perhaps we should adopt the h=
ighest
> > > > > > > > value reported on a physical CPU to date? I think that woul=
d be
> > > > > > > > Bulldozer's 0x10000.
> > > > > > >
> > > > > > > Or keep KVM's enumeration at 8, then find somewhere in KVM's =
documentation to
> > > > > > > describe KVM's behavior and provide guidance for userspace, b=
ut otherwise make
> > > > > > > it userspace's problem to solve?  I'd be a-ok with that.
> > > > > >
> > > > > > That sounds best to me. Document that KVM ignores the guest NAS=
ID and
> > > > > > commits to always supporting 2^32 ASIDs. Advise userspace to po=
pulate
> > > > > > NASID with a power of 2, and perhaps mention that hardware has =
only
> > > > > > reported three different values over the last 20 years: 0x40, 0=
x10000,
> > > > > > and 0x8000.
> > > > >
> > > > > I agree that documenting that KVM supports any NASID value from
> > > > > userspace is needed here, so that VMMs can set reasonable values =
and
> > > > > migration pools are sane.
> > > > >
> > > > > That being said, I still think KVM's enumeration should be increa=
sed
> > > > > from 8. If KVM's enumeration is just a hint, then it should be a =
good
> > > > > one imo. Current L1 KVM will flush everything (L1 + L2) every tim=
e it
> > > > > runs out of ASIDs and pumps the generation, so advertising a smal=
l
> > > > > number of ASIDs leads to L1 unnecessarily hurting its performance=
.
> > > > > Newer KVM (with this series) won't suffer as much.
> > > > >
> > > > > I think we probably want to pump KVM enumeration (e.g. to 0x8000 =
or
> > > > > even 0x40) *and* document that it's just a hint and KVM effective=
ly
> > > > > allows any value.
> > > >
> > > > How do you do that without breaking rollback?
> > >
> > > KVM's enumeration is just a hint :)
> >
> > Yes, but existing userspace VMMs do not know that.
> >
> > > Also, in practice, even if you rollback the CPUID presented to an
> > > existing VM by userspace should never change, right?
> >
> > Today's KVM claims support for only 8 ASIDs. If tomorrow's KVM
> > supports 0x8000 ASIDS, and we start a VM on tomorrow's KVM with a
> > userspace that copies NASID from KVM_GET_SUPPORTED_CPUID, that VM will
> > look like it can't be supported on the old KVM if we have to roll
> > back.
> >
> > Hence, until you get an ACK from *all* userspace VMMs that they
> > understand that KVM's reported NASID is just a hint,
>
> Way off topic, I keep reading NASID as NSAID and can't help but wonder if=
 you've
> found another way to imply that KVM is diseased and needs drugs ;-)
>
> > you can't change the reported ASID=E2=80=94unless, of course, you make =
that change an
> > opt-in.  But any VMM that opts in already knows that the value is just =
a
> > hint, that it can set any NASID value it wants in the guest CPUID, and =
that
> > all values are actually supported by all versions of KVM that report an=
y
> > non-zero value. So, then, what's the point of the opt-in? What's the po=
int of
> > changing the hint at all? Documentation solves the problem completely.
>
> +1000

Pointed taken. I will drop this patch in the next version and add a
patch documenting this instead.
