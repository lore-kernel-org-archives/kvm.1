Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217312;
	b=jsztX/ya8oSCUuHswCN2XaOcX1606jElqX2XfYFtfqWXyCHShmncHhP+TDVddMJTcJQM
	 ODt4ZhoMMtFCNm02XVdTzfvFHy8/U9tsG8A4tnbtVxi4hXy64Ga036ABafhh4WvCM3NiU
	 BOuq3QeK7YLZkNsMpuyORw5dsF9uNgesz6S5PYFbyo2wAvO5nsxMfbm/v6MqRoHp45PZq
	 UJ/YipAHVS0sOSFMKiKjNDjQis1h4ketW0hIwD0nRExSsfpxAZPkeJXQkVQuUk+5nmZUP
	 vxT+7KnbdV6PBievw8jNjowuD/nC6atPWeYPOwXcfHIM7wXlZXqqe8KO4INGxTL7KZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Gq20EnHxEvHMZEl/XIYvnT71R2LiAwiexNOWAraqNV4=;
	b=yiwKrjdLLKhYcBaiDMXogIcaeDJ19vBdscu79aLRUaUW6rX7nXmWn6QS2vqQ1lT0qiKo
	 q1PYpgZzRj/PGhosxSeblrOMa4iJjZi+elXIbrJE0lHvcL6EuEvzFmZZg+YhpXnGG/S0j
	 qWVM9cB0/CkZeErBbcWCsSgAagU/PnU2MonLv9lIow7VAe8DhhtPPxzUuh/FQl7HYwgRQ
	 +rNJx3x/Y9ke5Tbu6QW5zvD7dAW0DqAIgAYcYqujlvEjACIjmvNEZQ6vhabsHQupzeaEY
	 b2ug9Gk1mhzql5SmU6WOt5F8VQ6LnqKhMa3LCo5Jh0eMXR8DrwLQdv4M6bKo94G6r7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="opCJ/tiO";
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB69606A31A
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 19:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADB69606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=opCJ/tiO
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a079256596so1341903b3a.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 12:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793217311; x=1793822111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gq20EnHxEvHMZEl/XIYvnT71R2LiAwiexNOWAraqNV4=;
        b=opCJ/tiOS5FOLrKOzmwW8NtQr1WT8YytCtf9kjCSUvD6QaEEe4BFnN1oRD37lZl5WZ
         DfBcZL/Z2JM54WQtfyE17/23wratFGWUl7JLbTt/93aWJ4GHVtLhHVcmSE96gbOSa+9d
         vggW2vhElRqhl50HTlChoxu4dj3qL4HO+TAr3sRS2Rsyo4oXzvWdguqB2Nlu2PJyCPoA
         KIK70X+R7/Al744096yUZk/9QmUuoBm4aCRqkN+4UuPGeehRsfWyrZhSQBTKnQk+ShUp
         pYos0bJPFEsMryFOEWgBotEDYKHAFn/SBvYBb9ZEKXdr2n4Otqx9BYPx353JxiTMAOoF
         K/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793217311; x=1793822111;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gq20EnHxEvHMZEl/XIYvnT71R2LiAwiexNOWAraqNV4=;
        b=kT6I8GtC1zr4w1MiIvUuqrANUiBjTOTDSninPKcj/5QoF02HsVgKsxmsOgQ8A1Vz/8
         Hy6ZS1bkiSYQHgQDo/zbHmmQ4QzFCILV1LDJmlJkJx70RnGi6K2BMWaNsYxpHdM5P78+
         uPBa9v0RF3d274YW6RJp+U6In2Q0ZQaPPSNE4hOFB0YGNnI2v2Hbc0nJWCs6jshUUiab
         tZjmCOT0bVL5iL8PYY8kXo/0STmjtkkY2Nid4j5G+uQ9RuHN8d10DDjYwyLWnF57BfRc
         Z2nSI7UvwpdblE0y8uTg7/v2FGt/yW6+7QNdFkizgrhKBqea7hQv8tERljwXJuFoOqq+
         oFcQ==
X-Forwarded-Encrypted: i=1; AKwUvBy6z38z/lpaRKdFTObZf6RiP5nDUOR1v15Pzo5MmSoVp4eCEELXzXZTOfaGJvtjONhhbpU=@vger.kernel.org
X-Gm-Message-State: AFq9FYImcq2g31gCV0jLyStzI4D4M61ORz6fZ92CMtgliD4DEqa5A3VJ
	6io/IB626YlNlGLOZryC6WG2XJ4kdmOoKbW61vXh0jDZqKZnNNxfEcmIBrzCaSKOvPRmDBZNsWw
	2DVMRDQ==
X-Received: from pfh1.prod.google.com ([2002:a05:6a00:12c1:b0:885:756d:3709])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:808:b0:8a0:3307:c46c
 with SMTP id d2e1a72fcca58-8a6e8888934mr2834062b3a.36.1793217310714; Wed, 28
 Oct 2026 12:55:10 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:55:09 -0700
In-Reply-To: <CAO9r8zP5rom7VpA3-BsuB-H_+G5r-OC-Bfz=iTMbhQrWB4RYbA@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-27-yosry@kernel.org>
 <CALMp9eS8KDozNGT9J_uN69W32QEvTbg2JrtRqN0ESi00b_uq=A@mail.gmail.com>
 <atqRyeqSXViiNIk6@google.com> <CAO9r8zMqiW=3t7zRo_WAhKJfpYsDwuG3e=nK14GXhrq+foYnOw@mail.gmail.com>
 <at-O8-tzgezj2du-@google.com> <CAO9r8zO8ViSqCBer4rV5qBQGcDKA_60Aj_KEVQx2obd9zU7-Hg@mail.gmail.com>
 <auDkX94UTjrLNmqp@google.com> <CAO9r8zP5rom7VpA3-BsuB-H_+G5r-OC-Bfz=iTMbhQrWB4RYbA@mail.gmail.com>
Message-ID: <auJTHfdEPjbhGdyw@google.com>
Subject: Re: [PATCH v3 26/27] KVM: nSVM: Use different ASIDs for L1 and L2
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026, Yosry Ahmed wrote:
> On Tue, Oct 27, 2026 at 10:50=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Mon, Oct 26, 2026, Yosry Ahmed wrote:
> > > On Mon, Oct 26, 2026 at 10:33=E2=80=AFAM Sean Christopherson <seanjc@=
google.com> wrote:
> > > >
> > > > On Thu, Oct 22, 2026, Yosry Ahmed wrote:
> > > > > On Thu, Oct 22, 2026 at 3:44=E2=80=AFPM Sean Christopherson <sean=
jc@google.com> wrote:
> > > > > >
> > > > > > On Fri, Oct 16, 2026, Jim Mattson wrote:
> > > > > > > On Mon, Oct 12, 2026 at 4:37=E2=80=AFPM Yosry Ahmed <yosry@ke=
rnel.org> wrote:
> > > > > > > Moreover, does this change the semantics of PV TLB flush? In
> > > > > > > record_steal_time(), we have:
> > > > > > >
> > > > > > > if (st_preempted & KVM_VCPU_FLUSH_TLB)
> > > > > > >         kvm_vcpu_flush_tlb_guest(vcpu);
> > > > > > >
> > > > > > > IIUC, an idle vCPU that wakes into L2 will flush only L2's AS=
ID. In
> > > > > > > the past, with a shared ASID, L1's ASID was always flushed on=
 emulated
> > > > > > > VM-exit anyway. Now, L1's ASID will be unaffected. Though I c=
an't find
> > > > > > > any real documentation on PV TLB flush, it *seems* like the r=
emote
> > > > > > > vCPU would want L1's ASID to be flushed. OTOH, this change ma=
kes nSVM
> > > > > > > behave just like nVMX.
> > > > > >
> > > > > > That's a bug that absolutely needs to be fixed, probably relati=
vely urgently.  We
> > > > > > should also document that passing through the steal_time shared=
 information to L2
> > > > > > to utilize PV TLB flushes for L2 is explicitly not supported.
> > > > > >
> > > > > > I hate to re-introduce deferred actions for L2 =3D> L1 things, =
but that seems like
> > > > > > the only sane way to handle this, because handling the !tdp_ena=
bled case, where
> > > > > > KVM needs to sync the current root, requires knowing what MMU i=
s going to be in
> > > > > > use when L1 regains control.  Yuck.
> > > > >
> > > > > Are you implying that *you* will be re-introducing deferred actio=
ns? :P
> > > >
> > > > Heh, probably not this calendar year.
> > >
> > > Are you opposed to this series landing before that is fixed, keeping
> > > in mind that it will expose nSVM to the pre-existing bug?
> >
> > Nah, though I should just fix the damn bug.  It's not hard, I just don'=
t want to
> > do it because I don't want to reintroduce a deferred request.  Untested=
, but I
> > think this is all that's needed.
>=20
> Makes sense to the untrained eye, although I do wonder sometimes if
> requests more generally need a way to key off guest mode. I am sure
> you don't want to open this can of worms :)

It's not so much a can of worms as it is infeasible to come up with a gener=
ic
scheme that would add value.  The hardest part in all of this is identifyin=
g when
an action/request *always* needs to be serviced in the context of L1, e.g. =
this
code has been around for ages and it wasn't until Jimshiko came along that =
anyone
noticed there's a bug.

The actual servicing of the request in L1 is straightforward and vendor spe=
cific
for the vast majority of cases.  E.g. guard(vmx_vmcs01) is essentially what=
 you're
asking for, but it's obviously VMX specific beause SVM can simply grab the =
pointer
to vmcb01.  In other words, there isn't a general need to defer requests or=
 have a
framework for servicing requests while L2 is active.

This one is special because of legacy shadow paging, and specifically the n=
eed to
synchronizing the MMU.  In theory, we could temporarily switch to L1's MMU,=
 a la
vmcs01, but it's entirely possible L1's MMU doesn't even "exist", e.g. beca=
use
the host state that will be loaded from the VMCS on nested VM-Exit is diffe=
rent
than the pre-VM-Enter state (which is possible on Intel).  Even if the MMU =
context
was known, switching MMUs at this point in the KVM_RUN flow is terrifying.

So, while I detest the deferred approach, I also think it's absolutely the =
right
thing to do for a fix that needs to go to stable@, and probably the least a=
wful
fix long term as well.  But it's very much a one-off snowflake, not somethi=
ng we
should generally encourage.
