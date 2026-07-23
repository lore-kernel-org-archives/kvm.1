Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F24334B2
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784809463; cv=pass; b=irdA0VkeDNb+lE0Pk8PGgLSQhwZg785Kgcqs400KVeH6Tx8DI7g8mATFkezch5sxXR/bNob850WDSI+/Vdw29onhIgYUTorHeiGWI2unmsEKL6y0yttJs/2Vgpahvq2vB7jAtdYVdAYsrmmRnIAkZbp0m+KWrLMudy1MkXs0u2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784809463; c=relaxed/simple;
	bh=yXTWWLAH4Op+e7kZKlLTCzeVAK1GHyoPijnvlrQm5aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seG1kSU9x2CpUl4XZxRWSc3G7U99mbPdnP4wkzL9P1Jba4XDgtJgz9nhm+3Yty2tSIJnbWZX8O0MKNsOXuk0eW/DkC/QN3+tcARbcd9nLHRrzESqExtDZ6EVujaRVwgkrJmEwTTGs15jBbkcWFG4szVpLxHha+kmlHuGfy2Xz1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXQ0jTFW; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXQ0jTFW"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso8003a12.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 05:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784809460; cv=none;
        d=google.com; s=arc-20260327;
        b=rVWWFXoPwIEQLn+0PIdd/tFTxbsMhO/ugwsl8Fa20ZdyMvAWDlKNQjVdHCFE+fnjwx
         49Iru9XBoekehVJDVU1xc2hyl33yR7Ak/IMtjlyqWaNt6uQOIKmBTJCMd0N68SE7EQI8
         GExKjMXA8knOEWtar3L2fRnMYFNdRvPw9e5Gd7qkDGXuR43wd/paDqrVcyDnvEh3wISX
         nY5Z/11pIBzWj3wiyCAZDppcXZwMi/i5D7mBQI5+UYtnrPwPjBTD8PXY8IiSicTNMXVV
         XQIkEv9x0MqHWbvdhwVuBcDIi8S4cD+wyS7yOUYRpku+D3Q2Gk10Dg3GjZq1dvMAHBLl
         E9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h2kryxHT6lkEhPRGZ5tRmqg1tGUSZx9gA8qua8zQHJc=;
        fh=8D55DnShMz/wVJVQMN+wb8noPGiYJAInz7RuNd65ZcI=;
        b=b5T6Ma8Il8OXcslftq7dJSj3H86v+zGCnJ588r9RC2G1FSL/fDjtX8T8T0ZpRxa4su
         Phg8T8KUUQt+N+cl4MOzUCoctbBKwEHYZn1MSGQgam30jA7k2VffWRy6xkbhp4Df6tpI
         x9/9Uk4yRHZhevUUo5b8hKXabxk7OXircomUFkEZ8P2wD6gQ8xmwsSsJG15Eg0G33nea
         R50UIQboe7+1fMd3O0FI9g3wbAmV71pDjGi9WZRPbSt9ihVSb5Cmn6SJzHP/Mm8XsNOk
         C87MhFz+l3gFFB27gNm8gvPOCzobl6+dZkjeddT4LI1qSiXR+0Gt3M1QlZB7zZKR0waP
         ZOnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784809460; x=1785414260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h2kryxHT6lkEhPRGZ5tRmqg1tGUSZx9gA8qua8zQHJc=;
        b=DXQ0jTFWkpNgYLxRrHUlPoiLoL0/PzluU+79P9e0X9+GO43Ppk7/c4wX+gJe0g8GwW
         QLfT7oL1fI/SGBx+zALk3dHU/HKzy/g1Rdp40x/A1IxTPph8WzDJavaikSQn8lss/F68
         KSgtVeMcOm8BbX1olDxRlvzByM4gXJLnhIMwZvIF+b36qwjri/psbBtFgIYB0q3lW9hm
         73gxh+LeoP1Qfj6BPt5Y5kl82qqmeU940kBMZDpcFfwFwrCpESagDiSoxfJgk/n1QAwO
         6T7p21AkjzcD5yAxXrNkwWbxWRld6fyArhDBulaxLy5WqKj36XuiopF3VdYMTwllFVHx
         bf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784809460; x=1785414260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2kryxHT6lkEhPRGZ5tRmqg1tGUSZx9gA8qua8zQHJc=;
        b=WOt6c5jsXbuknHp1rcipZjGKhK2tYkLBw3Mfkj0+lTMSfJtUXw02L3wf703QFX0xaW
         9GV6wjqtcsYPAS/H+fviex1m2Ou/nMSJVaxWtjEiibri/RPrFQLjrL3chUxhKlEblsMS
         WEFdJxuZvVpoGN6KBwh5V/boHlouIxS6Lk30AshbmelLJ7myry5/pbbZ4O6e8SQuXcIu
         MIvzlhvvuC6jxWdHIxcfaQtA0d4HzRscNOJ0JInzuqBtgZPzMEDou6AwhRcIAWUMRAgu
         xuTHbQjuShfxKioDRq7WTZKbOha9sU7IT/6FPyn5M8WsuKXxZWq9aNhK8chUcbILC04X
         7S2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq4cOJSXW1WN1PuxO3E2F+PZikZeE5nes0xmZZLVVVVJjj5Pk5RDRrCEs4Gm0KFryB5s08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqSxplnDMqGtV45h+K0olJ4pWruC0LPgury1Vv6XXwfYyOZe3p
	igd9Tv24V0/MhsnY2LKH+ClFITLNJFFI6juVzlwQuha03aqIEPMPBtqzv53le9I/ZZUZQ/dpFLC
	PLwMxPAuPE4xScVKvufCLbESl0lm8/IQtW/XIPN6b
X-Gm-Gg: AR+sD11WagVbB/nDgWwxbb4A7uVNkfIhJbx6xsBZXzTLlMpwI9jDbR5j/msjUL9OAMg
	219bpq8h0n3dCbQsQXpIET+iY7aSYlTb9p0Y4SXWxEo9v55LEtJnaHFo/dcNKNeCdhm/9Bftyfd
	W1nInm8gNdyOZalJScP0mpna1tUkHauRIE4bG7upJZ3R5y1WKKK/lo2aVS+a+En0yqHenRwZzrL
	/rI4MDqJfr77B8EGXao7WZ1E0FQDIUrqg+yJ5PXhLeiMgiolbedtVhlf4edQQ==
X-Received: by 2002:aa7:d393:0:b0:69c:83f3:4831 with SMTP id
 4fb4d7f45d1cf-69f6ccf07a7mr49534a12.7.1784809459359; Thu, 23 Jul 2026
 05:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-3-yosry@kernel.org>
 <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
 <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
 <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
 <albJNb-akQJ97Yor@google.com> <CALMp9eRGx=K+UBp76A=dZ=bD_Txonq7j8pSn9HVczdtyyuAs3Q@mail.gmail.com>
 <amE_nPDem-imSfqF@google.com> <CALMp9eQL7y5chFEDCrqMR9CbJgiJxXN1hVzxVzojsr92AWnqrA@mail.gmail.com>
 <amFf5MAhc8sUqeYV@google.com> <CALMp9eSssBCuTTWdr1qT2c4Nto2PQO-QOBnobcx2kTnuQaOB1g@mail.gmail.com>
In-Reply-To: <CALMp9eSssBCuTTWdr1qT2c4Nto2PQO-QOBnobcx2kTnuQaOB1g@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Jul 2026 05:24:05 -0700
X-Gm-Features: AUfX_mzmKly_yHgJj4rm4HxpN9m3lpF_7_vkg6JqJOBRlYGQns80KWgeHxwi3tM
Message-ID: <CALMp9eQi=604LVn=ZMnzoUy55LVb1qorKzPKm5HVK_ACsPuP_A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 7:46=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Wed, Jul 22, 2026 at 5:27=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Wed, Jul 22, 2026, Jim Mattson wrote:
> > > On Wed, Jul 22, 2026 at 3:09=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > On Tue, Jul 14, 2026, Jim Mattson wrote:
> > > > > On Tue, Jul 14, 2026 at 4:41=E2=80=AFPM Sean Christopherson <sean=
jc@google.com> wrote:
> > > > >
> > > > > > What complications?  Advertise the lowest common feature set fo=
r the pool, just
> > > > > > like userspace has to do for literally every other feature.
> > > > >
> > > > > The problem with passing through the number of host ASIDs to the =
guest
> > > > > is what to do when the combined host plus guest usage exceeds the
> > > > > number of available ASIDs, particularly when FlushByASID is not
> > > > > available.
> > > >
> > > > But that doesn't have anything to do with the number of ASIDs that =
KVM enumerates
> > > > to L1.  As of this series, the number ASIDs KVM will consume in har=
dware is a
> > > > property of the total number of vCPUs in the system (one ASID per v=
CPU, plus one
> > > > more for nested usage).  E.g. if KVM advertises 10000 ASIDs to L1, =
all 10000
> > > > (10001, if ASID=3D0 counts?) of the those ASIDs will map to svm->ne=
sted.asid02.
> > >
> > > That's not the only conceivable implementation.
> >
> > But it is what is proposed in this series.
> >
> > > KVM could advertise 64 ASIDs to L1 and reserve the corresponding non-=
zero
> > > ASIDs for L2 VMs (i.e. the first L1 ASID is 64). Then, vmcb02.asid =
=3D
> > > vmcb12.asid & 0x3f.
> > >
> > > > Of course, that completely undermines my statement about suboptimal=
 performance:
> > > >
> > > >   And potentially suboptimal for performance.  There might be a leg=
itimate reason
> > > >   why a CPU generation advertises X instead of Y.
> > > >
> > > > My bogus assertion about performance notwithstanding, I still think=
 advertising
> > > > what hardware supports is the simple, sane approach.  Because at th=
e end of the
> > > > day it's just that: advertising.  Userspace can do whatever it want=
s, including
> > > > peeking at raw CPUID.  E.g. if we want to pull a stupid and emulate=
 the behavior
> > > > of ignoring "unsupported" ASIDs, then we'd need to do that based on=
 userspace's
> > > > defined CPUID model, not KVM's advertised support.
> > >
> > > But you could refuse a userspace CPUID model that claims more ASIDs
> > > than KVM supports.
> >
> > Nah, that's not the KVM way.  For this one in particular, there's zero =
reason to
> > enforce anything.  Practically speaking, *if* we want KVM to act like h=
ardware
> > and ignore unsupported ASIDs, then KVM *must* allow userspace to define=
 a max ASID
> > other than exactly what's reported by KVM_GET_SUPPORTED_CPUID, otherwis=
e migration
> > pools become impossible.  And at that point, disallowing a larger max A=
SID adds
> > zero value.
> >
> > If KVM claiming support for an explicit number of ASIDs is a sticking p=
oint, then
> > I vote to zero the output in KVM_GET_SUPPORTED_CPUID, but I'd prefer no=
t to do
> > that because it will break reflecting KVM_GET_SUPPORTED_CPUID directly =
back into
> > KVM_SET_CPUID2.
>
> If KVM supports any userspace-provided value for NASIDS, then
> shouldn't KVM_GET_SUPPORTED_CPUID return 0xffffffff?

Having given it some more thought, 0xffffffff might induce buggy guest beha=
vior.

However, since KVM completely ignores NASID, it would be sad if
migration were blocked because the target has a lower NASID value than
the source.

That's an argument against changing it without some kind of userspace
opt-in. Increasing it seems safe, but if userspace just reflects the
value into KVM_SET_CPUID2, then an increase would block kernel
rollback.

In any case, I think the new value should be a constant so it doesn't
imply a migration constraint. Perhaps we should adopt the highest
value reported on a physical CPU to date? I think that would be
Bulldozer's 0x10000.

> > > And __nested_copy_vmcb_control_to_cache() already ignores a bunch of
> > > unsupported bits. I don't see how this is any different. That's how
> > > the hardware is implemented. Intel likes to fail VM-entry. AMD prefer=
s
> > > to just ignore hypervisor stupidity and move on.
> >
> > The issue is that KVM has played nice with unsupported ASIDs for years.=
  If we
> > want to change that, it needs to be quirked.  And I just don't see the =
point,
> > because KVM's behavior isn't outright wrong: the APM doesn't say what w=
ill happen
> > if the hypervisor is being stupid.
>
> The APM doesn't say that an out-of-bounds ASID causes VM-entry
> failure. What other possibilities remain?
