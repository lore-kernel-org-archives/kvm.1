Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218899;
	b=4C1MPR/YNoSvGfn16X5Ope5PmvIH+uS44oj2oWKBlxm+t8ulkYsZ8ejF5KmTW+1D9t5b
	 jCOPjyNjqjCPcgMiRZVJnzwOlgNahY4j3W+b4TUbSDxKBr1ILpeOCof4RYiHHOSokYLnu
	 FvaOCm6kgLuJsas2nd1IXH5rgiacc4ROGKkTpVTMPDwtF2VMeSpa2NSyfRnQjhfOHifRb
	 U2CGHf6q+IVw/5oraiivMqSnTi9/2phLmTXj9VlzrrKCIX04aU1N6IHaCTGxo8mPp5O3a
	 kG8WWf/kWkj68IhWCGRJsmq0CtBf2s2eWHxaElL6oIycdMLQyPYqHZb9BRcSMGUHwkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=/TmMXWLfEGbWDaHSm2PxvH23AwXzX4t8rkjf35AV8mo=;
	b=XtCvaftHDbET7kgtvz+Onvui80CSpi+4EZP0ujB4VrfoHdWHed46FdM7si3K9S38YxzN
	 5r0+xCNSaafJAqhqTgKp3CUdOb2RCgSrUsHGLFR20iZ75NlOSeiTETf/mZ4UaQqdm/iCq
	 PymRQHaCA7mxwtW0yM6Uk7xdD7LZnsUNA+PqOq+cPDGq2187i/TnHZVNJuEjaShL9H2Mn
	 JVakH32BvFFtQOJGoVPQ8g+Q9WTMEcxBTaz92CZ70eW34sQil3PoDJyOqSqqKlnpdeCt9
	 d7glBMwMMyryzoO98ugLFFJUEt3m5Vr77MzvpQS+TzgRYGZiJ+WaITZvvplYyUVvizw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lEpCKL9s;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B947E606A31D
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 20:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B947E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lEpCKL9s
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ada8bc8575so2336475a91.3
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793218898; x=1793823698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/TmMXWLfEGbWDaHSm2PxvH23AwXzX4t8rkjf35AV8mo=;
        b=lEpCKL9s5/4FtMSSS1UQQFjk0MwEzw8uiJHyYZ/K/RMegbfUhRMi86ZijioQHA3vbs
         ZFsYlz95XYOwQEyGgYaCuI5ctl42SMf3PW3yjGF4OC+eEgNiChCFNJ2YqMf3Fe/ZdMzu
         ChDQbX+thd1+K/gTiZ11aU0IpBkNwAfTgaxuJ0MxG2KYi5gNBHXOzvH97ThkvnwmSIpT
         QXm7BD/UgWUBX5uMCWq+oXeidVZbhYLT6vopFztrZx5f4E8LsabeTkg2xD8WNAvvj9Ys
         itVFtfiQ8OjnZ2awmF2BSAVpaR4VszuFgxjPtJK0I9r9V5NRShvHNWMIvyBGNgEFLRXM
         7SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793218898; x=1793823698;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/TmMXWLfEGbWDaHSm2PxvH23AwXzX4t8rkjf35AV8mo=;
        b=eFYwKhyL/VCTpEbBO+xgCFINVge/nytT/wb+09pUTnC/OMSBo0kLfxnlOplS5DpLt1
         dIPi6jokmwUJnQ5YOb2DYxfMPaAT3TaW2NyFHun4TPmxkG+Zn/mbYBYxA8mPwYBliPms
         B13HaLOa7T0UNxW5y1WcooorvRKUuKRPNGkxcdZQUr+Bl87WrCIBWYKmd447PnEKdcYe
         CZsBz6XxNuvjWHnUlMKHn6t+ssRIfSvagJY24DPoHcNJduUFoRjkomZ1ibb05FO9I6pq
         R/Uz9yDxbcqxuHr/S96DHkPDG3zAmO1PnnQMzphhwvXo44xJfQlYNSXwpWQHUVuAIodf
         fDnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwdB5UtIktg/Z6mvRfydh/6LBUGar+FYgWrmio6sXsn2XMNZLkpYn5K0rmtMg9IH802HTE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKw3QpMXVXzzMWsiogHtA8mO9TFwjvs1PQG/moy2BvvHHrL24x0
	Mhr8DX/nvDfYAGH4XJoxHRd0bo4rFGCTPF7/kQ/4m6DHRfvZnfnAaW67R+IhdMyAuhhqdZFhHWL
	eQj4GJQ==
X-Received: from plic6.prod.google.com ([2002:a17:903:3706:b0:2ea:8030:9125])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f49:b0:39e:6d82:dca
 with SMTP id 98e67ed59e1d1-3ae580a0249mr2538063a91.30.1793218897891; Wed, 28
 Oct 2026 13:21:37 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:21:36 -0700
In-Reply-To: <CAO9r8zOKuY5wGXYr9_L0p+-w3qBaNd36XgjyQn462zxU5aCY3w@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261012233638.2546339-27-yosry@kernel.org> <CALMp9eS8KDozNGT9J_uN69W32QEvTbg2JrtRqN0ESi00b_uq=A@mail.gmail.com>
 <atqRyeqSXViiNIk6@google.com> <CAO9r8zMqiW=3t7zRo_WAhKJfpYsDwuG3e=nK14GXhrq+foYnOw@mail.gmail.com>
 <at-O8-tzgezj2du-@google.com> <CAO9r8zO8ViSqCBer4rV5qBQGcDKA_60Aj_KEVQx2obd9zU7-Hg@mail.gmail.com>
 <auDkX94UTjrLNmqp@google.com> <CAO9r8zP5rom7VpA3-BsuB-H_+G5r-OC-Bfz=iTMbhQrWB4RYbA@mail.gmail.com>
 <auJTHfdEPjbhGdyw@google.com> <CAO9r8zOKuY5wGXYr9_L0p+-w3qBaNd36XgjyQn462zxU5aCY3w@mail.gmail.com>
Message-ID: <auJZUF3dmCHYQRxD@google.com>
Subject: Re: [PATCH v3 26/27] KVM: nSVM: Use different ASIDs for L1 and L2
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026, Yosry Ahmed wrote:
> On Wed, Oct 28, 2026 at 12:55=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Tue, Oct 27, 2026, Yosry Ahmed wrote:
> > > On Tue, Oct 27, 2026 at 10:50=E2=80=AFAM Sean Christopherson <seanjc@=
google.com> wrote:
> > > >
> > > > On Mon, Oct 26, 2026, Yosry Ahmed wrote:
> > > > > On Mon, Oct 26, 2026 at 10:33=E2=80=AFAM Sean Christopherson <sea=
njc@google.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 22, 2026, Yosry Ahmed wrote:
> > > > > > > On Thu, Oct 22, 2026 at 3:44=E2=80=AFPM Sean Christopherson <=
seanjc@google.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Oct 16, 2026, Jim Mattson wrote:
> > > > > > > > > On Mon, Oct 12, 2026 at 4:37=E2=80=AFPM Yosry Ahmed <yosr=
y@kernel.org> wrote:
> > > > > > > > > Moreover, does this change the semantics of PV TLB flush?=
 In
> > > > > > > > > record_steal_time(), we have:
> > > > > > > > >
> > > > > > > > > if (st_preempted & KVM_VCPU_FLUSH_TLB)
> > > > > > > > >         kvm_vcpu_flush_tlb_guest(vcpu);
> > > > > > > > >
> > > > > > > > > IIUC, an idle vCPU that wakes into L2 will flush only L2'=
s ASID. In
> > > > > > > > > the past, with a shared ASID, L1's ASID was always flushe=
d on emulated
> > > > > > > > > VM-exit anyway. Now, L1's ASID will be unaffected. Though=
 I can't find
> > > > > > > > > any real documentation on PV TLB flush, it *seems* like t=
he remote
> > > > > > > > > vCPU would want L1's ASID to be flushed. OTOH, this chang=
e makes nSVM
> > > > > > > > > behave just like nVMX.
> > > > > > > >
> > > > > > > > That's a bug that absolutely needs to be fixed, probably re=
latively urgently.  We
> > > > > > > > should also document that passing through the steal_time sh=
ared information to L2
> > > > > > > > to utilize PV TLB flushes for L2 is explicitly not supporte=
d.
> > > > > > > >
> > > > > > > > I hate to re-introduce deferred actions for L2 =3D> L1 thin=
gs, but that seems like
> > > > > > > > the only sane way to handle this, because handling the !tdp=
_enabled case, where
> > > > > > > > KVM needs to sync the current root, requires knowing what M=
MU is going to be in
> > > > > > > > use when L1 regains control.  Yuck.
> > > > > > >
> > > > > > > Are you implying that *you* will be re-introducing deferred a=
ctions? :P
> > > > > >
> > > > > > Heh, probably not this calendar year.
> > > > >
> > > > > Are you opposed to this series landing before that is fixed, keep=
ing
> > > > > in mind that it will expose nSVM to the pre-existing bug?
> > > >
> > > > Nah, though I should just fix the damn bug.  It's not hard, I just =
don't want to
> > > > do it because I don't want to reintroduce a deferred request.  Unte=
sted, but I
> > > > think this is all that's needed.
> > >
> > > Makes sense to the untrained eye, although I do wonder sometimes if
> > > requests more generally need a way to key off guest mode. I am sure
> > > you don't want to open this can of worms :)
> >
> > It's not so much a can of worms as it is infeasible to come up with a g=
eneric
> > scheme that would add value.  The hardest part in all of this is identi=
fying when
> > an action/request *always* needs to be serviced in the context of L1, e=
.g. this
> > code has been around for ages and it wasn't until Jimshiko came along t=
hat anyone
> > noticed there's a bug.
> >
> > The actual servicing of the request in L1 is straightforward and vendor=
 specific
> > for the vast majority of cases.  E.g. guard(vmx_vmcs01) is essentially =
what you're
> > asking for, but it's obviously VMX specific beause SVM can simply grab =
the pointer
> > to vmcb01.  In other words, there isn't a general need to defer request=
s or have a
> > framework for servicing requests while L2 is active.
> >
> > This one is special because of legacy shadow paging, and specifically t=
he need to
> > synchronizing the MMU.  In theory, we could temporarily switch to L1's =
MMU, a la
> > vmcs01, but it's entirely possible L1's MMU doesn't even "exist", e.g. =
because
> > the host state that will be loaded from the VMCS on nested VM-Exit is d=
ifferent
> > than the pre-VM-Enter state (which is possible on Intel).  Even if the =
MMU context
> > was known, switching MMUs at this point in the KVM_RUN flow is terrifyi=
ng.
> >
> > So, while I detest the deferred approach, I also think it's absolutely =
the right
> > thing to do for a fix that needs to go to stable@, and probably the lea=
st awful
> > fix long term as well.  But it's very much a one-off snowflake, not som=
ething we
> > should generally encourage.
>=20
> The other example I thought about is
> kvm_service_local_tlb_flush_requests(), AFAICT this only exists
> because we don't have a way to specify a request for L1/L2. But yeah,
> I agree if these are the exceptions rather than the rule.

Yes and no.  Doing the "obvious" thing by tracking L1 vs. L2 requests would=
 be
subtly wrong.  E.g. if L2 triggers a flush with virtual ASID=3D1, then KVM =
must
service the flush in exactly that context.  If KVM shoved the request into =
e.g.
l2_requests and serviced those at the next entry to L2, then KVM could proc=
ess
the TLB flush using the wrong virtual ASID.

So while I get where you're coming from, I think the current approach of us=
ing
a unified requests queue and then servicing the requests that are "local" t=
o L2
on nested VM-Exit is the "right" approach.

> In my head, there was also a request we clear for exceptions on nested
> VM-Exit, but looking at the code again, it's not a request, we clear
> the exception and interrupt queues. I think this is the right thing to
> do architecturally anyway though?

Yep.  If an event is supposed to be preserved, then it needs to be saved in=
to
the exit fields of the VMC{B,S}.  KVM's software model should always be res=
et.
