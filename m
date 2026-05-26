Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA74C25B0BE
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779826694; cv=none; b=E9j3OF50R/c57I2rvBWlvLoYidiRQDgYXYsmKVt7Vvy3DbOO37gRpvTR3QGCUabLbagCUIjidlFNrpmBi7sPgi67BwYi+UxL859FqRC3pkwY345F+gwbFsnM1W+/7J9upUgjHj9Cy97OGsgBgFrTt9fRx6Z5z2grR9LGglURApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779826694; c=relaxed/simple;
	bh=uPX2Vv6sl1N8tZq8k77saq1gFrGNkXTerT2rhszNpIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzO3vmcKeFYN3xSLKoeN8xslYNNEbMPNRisOt8oBWAF2y3+lIzq3eMfpodZALiIVMmYVzDbGlBvy5qaNKQah2cOC4JPsMhm2voTbF7eMe99gomC7fUALu8+qB1xeHBgA45pBo8EvkGWM0jaJzQsZspdxNktiehZxb7XkxdZSIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEpQBorz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEpQBorz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8046F1F00A3C
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 20:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779826693;
	bh=VFAHaqeDXhdvrZhDDwx4GnmWtjl5CllgZ/HuBUKxWVg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PEpQBorzvM73wLSwqYZygzXM3CeDiu2ARViOihdKP17vcjtRX2Payt2d3UauNVm3N
	 A94dC/0hCWIEuIgGBmalb01YtMQEMg8X/9Mh9HedYgb5krCNUqsuSITEzhnPZl2egQ
	 F513bextw2Nfl4z1dczby2zjIW5L6z+nOuwod3INfPMRLLOPJDB/+E+c2wi1iDjvc8
	 Fj2kCrzQSU9GJ6HXQgSkjlyeSn42NPfygbJO+ZBIgtCTblHvOH6k4kRLWrB+3IBiwM
	 JITg3z/oeniBb0FHRYwMtfKa3Emz0Dn5oMFypRRirwCZgL1atbkZgmFX0AItZqxuvz
	 ZjZqge7GwfmnA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd4d7f4fa02so1852888766b.3
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 13:18:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ZWccJG+ZeLnikpEjxhlYlBQ/laPCmLaX+C5RUfLLEjRvfpzJPHu1k7e+E5LwHLeYP0Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj5lMpha1oRHMlgi9zCX9sCDCKCVppxB0Runeru3g5uaGcdizr
	tyHLQYqngBdX61XiF33/OzRfmSmT/XQNwAIHAIVDRu4U9JRtSWdiQq6EHc35tXvhhE2crml3tRi
	QndWGa3AL7pAl/tO6NdntkJBiZfw0Df8=
X-Received: by 2002:a17:907:a789:b0:bd2:bd3:1ef8 with SMTP id
 a640c23a62f3a-bdd272cfb68mr1236896266b.35.1779826692504; Tue, 26 May 2026
 13:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506015733.1671124-1-yosry@kernel.org> <20260506015733.1671124-2-yosry@kernel.org>
 <ahDidRRVYHD6x50P@google.com> <CAO9r8zNOEYf7RzoDUjueTVaiFTFQ7sizBfpeCoCbCCTFavRDqw@mail.gmail.com>
 <CAO9r8zMuhJpeBwY-tod4mr522hXhHRrkK8UhnxgpMi0SQ0vyMg@mail.gmail.com> <ahXwaC7U8mGJKr-P@google.com>
In-Reply-To: <ahXwaC7U8mGJKr-P@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 26 May 2026 13:18:01 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNiNJ4xwYmAEv1YzcYKKQnzM6kdcJBAis+Hm3WxG3VMJg@mail.gmail.com>
X-Gm-Features: AVHnY4JC8tanyrCzmFH9ud9SVPtlSBLG2VYBnqfZXbTlWitS9gsdcSpSApg3lQc
Message-ID: <CAO9r8zNiNJ4xwYmAEv1YzcYKKQnzM6kdcJBAis+Hm3WxG3VMJg@mail.gmail.com>
Subject: Re: [PATCH v6 01/16] KVM: nSVM: Stop leaking single-stepping on VMRUN
 into L2
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 12:11=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Fri, May 22, 2026, Yosry Ahmed wrote:
> > On Fri, May 22, 2026 at 4:45=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > On Fri, May 22, 2026 at 4:10=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > On Wed, May 06, 2026, Yosry Ahmed wrote:
> > > > > According to the APM, TF on VMRUN causes a #DB after VMRUN comple=
tes on
> > > > > the _host_ side. However, KVM injects a #DB in L2 context instead=
 (or
> > > > > exits to userspace if KVM_GUESTDBG_SINGLESTEP is set) in
> > > > > kvm_skip_emulated_instruction().
> > > > >
> > > > > Introduce __kvm_skip_emulated_instruction(),
> > > >
> > > > Eh, just make svm_skip_emulated_instruction() visible via svm.h and=
 call that
> > > > directly.  No need to bring SVM's mess into common KVM.
> > >
> > > Yeah I thought about doing that. The only reason I was hesitant is
> > > that if [__]kvm_skip_emulated_instruction(),
> >
> > if [__]kvm_skip_emulated_instruction() gains new logic*
>
> Well, __kvm_skip_emulated_instruction() can't gain new logic if it doesn'=
t exist,
> which is why I want to avoid it.  IMO, it's _more_ likely that we'd add c=
ode to
> __kvm_skip_emulated_instruction() that breaks the obscure VMRUN behavior.
>
> And if we add logic to kvm_skip_emulated_instruction(), it's seems like a=
 forgone
> conclusion that we'll have to analyzing VMRUN to see what the "right" beh=
avior is.

Right, sorry I wasn't clear. What I meant is, if someone is modifying
kvm_skip_emulated_instruction(), they are likely to check
__kvm_skip_emulated_instruction() as well to check which variant
should carry the logic based on the callers. They are less likely to
check direct callers of {svm/vmx}_skip_emulated_instruction().

>
> > > handling it here might be missed. Also, there's only one direct calle=
r of
> > > svm/vmx_skip_emulated_instruction() (and it's TASK_SWITCH interceptio=
n, who
> > > cares).
>
> handle_exception_nmi() also calls it for INT1, though that code is broken=
 (the
> INT1 should count as an instruction).
>
> > > So I think it's more consistent and future proof to refactor
> > > kvm_skip_emulated_instruction() instead.
>
> I actually think the task switch case is the perfect argument for using
> svm_skip_emulated_instruction() directly.  The only flows crazy enough to=
 warrant
> bypassing normal instruction skipping behavior are legacy task switches a=
nd VMRUN.
> Sounds about right to me :-)

No objections here :)

Mainly the point above, that it's more likely someone will check the
callers of __kvm_skip_emulated_instruction() when updating
kvm_skip_emulated_instruction().
