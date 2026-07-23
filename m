Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2313E37C925
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827597; cv=none; b=IzGOyC3sWjDqEU3OQuCu5isFF64vm4hiF1cubxSCyswJZmVEke5BNu9b+COJpaS28FPPdNjjaYheytjKDy1SzdwaAXSlfA5pGJRZQRysCy1iEz0oshgLYOTxl5VpgtUXw6qHj6xjRJj3BEPZRWB4zNa2EgNMxW0CleGZnKwuriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827597; c=relaxed/simple;
	bh=cd/ZRwiipOV+bQstkRLvKcE/iZkXqPrrTq6Rfr4R/oU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m7Q4gRwdGowKFUm4Tv91lotpLs4xO4tqyS/t1SUQwZ80DeddVkWxpVWQIjXVtOwdtvkefno3o82VfWiofqabddxj/dgstUTeUVnxvIDzwZ5TV1XS1FKKzSy8/Ok6Uyr5RV2iY6zxz9sPAj5Ji0tJx2pnTZyZTQiMLhclP7gOV2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vowAHAii; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vowAHAii"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so750846a12.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784827594; x=1785432394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yNQpsQ8GyeYtZEElIeEiEJAJInLo2UxIW3TpNd+CGQU=;
        b=vowAHAiie8UNbVP06YJ1ZSXvIP2dFHGgJFX/0BTN9KRfvQi9DMd+PLUcjfGfFeE3wL
         LeZHG7vrA1kA+NjvLSStg5gQm1xRMk4S7oS/D2eU9SKn7Gj6lY7JzhYfjIvoBM0jkY2r
         IzrgASxCM8uhjpuZMuc/oiZGIqPyKuJzyerfhVntXm1C/TLGgi10QUHAr9mZyA6RVqIP
         Q01V1LpD10Cw+7hSVSZs+2xXKvByd8wp5ZIj7SYClDinXuvoioRX39ujHORsjAK9qtD8
         EleoVBvxhRj28HwwVkw7lvsSv8aXbo516GAek5OHh+hdscqEUjKmtKnM3a5u4K2lHv+H
         r6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827594; x=1785432394;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yNQpsQ8GyeYtZEElIeEiEJAJInLo2UxIW3TpNd+CGQU=;
        b=hxnCkcIB1VLKn6fyXA9kOY+ylMVs/bojcEMGJJatv5OjIqJMYgD9T3LQCIpgm7QsyL
         5UYGudsWlLDQCtfkE2vuDAZEKyFDXaqLHSXcJoVXeotdbrSpbrDNnYdLpqXA2o6HVwa4
         BKgLwMObViCbX07K4S/4KrVRXc1uJgOpMKevDWmTfle/GXvFQj9kN3vopWvriG3+5ncl
         SPpEgDyPI+tDrbOKJm9iB6QgA5y7yPxVRO292Z2Xedk9rPlbsEvMlC2mGlGJ8pgWZNTz
         qyOt7lLxcnKT+6FYppgtlE5D6F4G66XSG2MH9wWTKbqDa/Wk4B88vNV+NDZzRiLv7X5S
         B6DA==
X-Forwarded-Encrypted: i=1; AHgh+RoN5M2tW9ByFsUu6qWsxcp4uCQaIeTK9u05KZ+HItMCRb3oGyP8o2AqF1GotvNZWNxiXcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylO9z1HbW/1lO5MGjQTtRtVObb5JwGj3WPWdG7bsT2PNuwAThA
	dqYAAHeHZAQK5Ka5wv2lF88FxF9KD47F8UoozEYzrFdUucZKMaJUUWUJekg01LvI1JnH1fw2aFf
	MkmNcJg==
X-Received: from plbjz14.prod.google.com ([2002:a17:903:430e:b0:2ce:fc5f:e782])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e541:b0:2c9:b48c:fdec
 with SMTP id d9443c01a7336-2cfa6b740c2mr50181305ad.12.1784827593463; Thu, 23
 Jul 2026 10:26:33 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:26:32 -0700
In-Reply-To: <CALMp9eR2XffG3pQL_pjGphSqMGfpJ9vRJi45Hd9RuCSd5EwU6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CALMp9eQL7y5chFEDCrqMR9CbJgiJxXN1hVzxVzojsr92AWnqrA@mail.gmail.com>
 <amFf5MAhc8sUqeYV@google.com> <CALMp9eSssBCuTTWdr1qT2c4Nto2PQO-QOBnobcx2kTnuQaOB1g@mail.gmail.com>
 <CALMp9eQi=604LVn=ZMnzoUy55LVb1qorKzPKm5HVK_ACsPuP_A@mail.gmail.com>
 <amIgLeMCAH2vB4ot@google.com> <CALMp9eSgfL8C7SU+j6+c5s64end-n4uHh=uXtTpDVJ7RcvLQgw@mail.gmail.com>
 <CAO9r8zMukfW2b5tjYarpkpPH0osA_+QEEMRq8k5R8B_WFG_yYQ@mail.gmail.com>
 <CALMp9eRsJeByu4U8NZQhnKM7BaKziyLUix6J3XGCEMZyiar=vA@mail.gmail.com>
 <CAO9r8zOtzSscMx_PFuABkXzZ=xgGOcioegKzgYscXa9WiobySg@mail.gmail.com> <CALMp9eR2XffG3pQL_pjGphSqMGfpJ9vRJi45Hd9RuCSd5EwU6g@mail.gmail.com>
Message-ID: <amJOyIOzsJx8dWa-@google.com>
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
> On Thu, Jul 23, 2026 at 9:57=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Thu, Jul 23, 2026 at 9:54=E2=80=AFAM Jim Mattson <jmattson@google.co=
m> wrote:
> > >
> > > On Thu, Jul 23, 2026 at 9:32=E2=80=AFAM Yosry Ahmed <yosry@kernel.org=
> wrote:
> > > >
> > > > On Thu, Jul 23, 2026 at 8:57=E2=80=AFAM Jim Mattson <jmattson@googl=
e.com> wrote:
> > > > >
> > > > > On Thu, Jul 23, 2026 at 7:07=E2=80=AFAM Sean Christopherson <sean=
jc@google.com> wrote:
> > > > > >
> > > > > > On Thu, Jul 23, 2026, Jim Mattson wrote:
> > > > > > > However, since KVM completely ignores NASID, it would be sad =
if
> > > > > > > migration were blocked because the target has a lower NASID v=
alue than
> > > > > > > the source.
> > > > > > >
> > > > > > > That's an argument against changing it without some kind of u=
serspace
> > > > > > > opt-in. Increasing it seems safe, but if userspace just refle=
cts the
> > > > > > > value into KVM_SET_CPUID2, then an increase would block kerne=
l
> > > > > > > rollback.
> > > > > > >
> > > > > > > In any case, I think the new value should be a constant so it=
 doesn't
> > > > > > > imply a migration constraint. Perhaps we should adopt the hig=
hest
> > > > > > > value reported on a physical CPU to date? I think that would =
be
> > > > > > > Bulldozer's 0x10000.
> > > > > >
> > > > > > Or keep KVM's enumeration at 8, then find somewhere in KVM's do=
cumentation to
> > > > > > describe KVM's behavior and provide guidance for userspace, but=
 otherwise make
> > > > > > it userspace's problem to solve?  I'd be a-ok with that.
> > > > >
> > > > > That sounds best to me. Document that KVM ignores the guest NASID=
 and
> > > > > commits to always supporting 2^32 ASIDs. Advise userspace to popu=
late
> > > > > NASID with a power of 2, and perhaps mention that hardware has on=
ly
> > > > > reported three different values over the last 20 years: 0x40, 0x1=
0000,
> > > > > and 0x8000.
> > > >
> > > > I agree that documenting that KVM supports any NASID value from
> > > > userspace is needed here, so that VMMs can set reasonable values an=
d
> > > > migration pools are sane.
> > > >
> > > > That being said, I still think KVM's enumeration should be increase=
d
> > > > from 8. If KVM's enumeration is just a hint, then it should be a go=
od
> > > > one imo. Current L1 KVM will flush everything (L1 + L2) every time =
it
> > > > runs out of ASIDs and pumps the generation, so advertising a small
> > > > number of ASIDs leads to L1 unnecessarily hurting its performance.
> > > > Newer KVM (with this series) won't suffer as much.
> > > >
> > > > I think we probably want to pump KVM enumeration (e.g. to 0x8000 or
> > > > even 0x40) *and* document that it's just a hint and KVM effectively
> > > > allows any value.
> > >
> > > How do you do that without breaking rollback?
> >
> > KVM's enumeration is just a hint :)
>=20
> Yes, but existing userspace VMMs do not know that.
>=20
> > Also, in practice, even if you rollback the CPUID presented to an
> > existing VM by userspace should never change, right?
>=20
> Today's KVM claims support for only 8 ASIDs. If tomorrow's KVM
> supports 0x8000 ASIDS, and we start a VM on tomorrow's KVM with a
> userspace that copies NASID from KVM_GET_SUPPORTED_CPUID, that VM will
> look like it can't be supported on the old KVM if we have to roll
> back.
>=20
> Hence, until you get an ACK from *all* userspace VMMs that they
> understand that KVM's reported NASID is just a hint,=20

Way off topic, I keep reading NASID as NSAID and can't help but wonder if y=
ou've
found another way to imply that KVM is diseased and needs drugs ;-)

> you can't change the reported ASID=E2=80=94unless, of course, you make th=
at change an
> opt-in.  But any VMM that opts in already knows that the value is just a
> hint, that it can set any NASID value it wants in the guest CPUID, and th=
at
> all values are actually supported by all versions of KVM that report any
> non-zero value. So, then, what's the point of the opt-in? What's the poin=
t of
> changing the hint at all? Documentation solves the problem completely.

+1000
