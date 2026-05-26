Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE703C0A0F
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822699; cv=none; b=rG/toy8aWH4uTlCRUbb5UzNVRg9q+HLbSzPv9Zi2cVCIn6aG+8sU/tqkgrs0y9rIylZ5zoDFci5E9xla5r+BsJht/j1mvz5C3uq13IL3RV4tpH7vD5nbzDFr+DPqSltrbB4lxda3mbKGPSk9m2QyXK3izAMdfgn8yYEnQtnc5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822699; c=relaxed/simple;
	bh=r0B3/LXiCCefp1GjqQcNi43nrCqy4jhnGJo1iHggQ70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u+JDjVYsQ+Tw3wuMND+BcNloFpoTceQMBV+3JSY4p0WMlWykX7rWPMQ5MV/sW2MDnKTt5u4I1MRnXBM1RYxaVnrIH0gbdaPNCkye0dDWt3Ym4dfZ3sAV0dhnoY6jUfDZ5LU+ug6DE3cesQiy7HSa81xy3LsW6ze4mnLEo5rWDOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RzQfXRiw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzQfXRiw"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82c935e048so6804808a12.0
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779822697; x=1780427497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7aWUpmpx5OZU/6ppMEyWSa6e+OFoaoQGmjbVgY2GCQ=;
        b=RzQfXRiw9/M0ENpI3W3eNIW5p6C12Bb3gox5ZvDXiVBLtCXsJmzGWC6WFBJfpFBo2A
         y0xZNfC8Ht+FWMp0oFIqF6lew3qc+8EpY3YWP4PH2fdY4lH0cOwf3OmS6IbRj90n3SDV
         5TvlesAUGfeAnk65T9DpzH3sGA6sSQE6dJYq1V4veh4Hd1nXDKgTOCBxaLRgLU/0YuqK
         QpJeRcMznCwCEc+YoMnyVxa74LVeRpsgv7TEtP1OJcg47Q9qDSn9LQ24JgKS4mWpkL4j
         9JFKyygnpTKI/caGUrX2L1W7pFlRo4sTa0RgX/tVkCxuzwKIxMWXpPti3l+0zcGpV0/c
         KnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779822697; x=1780427497;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H7aWUpmpx5OZU/6ppMEyWSa6e+OFoaoQGmjbVgY2GCQ=;
        b=IiBoKILH4s0abkhBzO+yj2q+JBW93NA3bm8xgpHzSLpVeJTV/P652A13vyWIdW58Be
         vgR+LddcoK3MCq/vLHORi9lIXfBh239uNFQSOiriQHX9bzx0/e1J52vBc5MbPuvfeV0L
         EhvdBQSQyxHBPBMAKifxfx27JEl2/IzBsFFxSgPCtQYDYK7/tZN+UIF2BF92v7UNzjVl
         xZfAstHaWirox20hGf/fKWjdbB6RMqYPI/uLdyYch+STOmQ+4UMBHZ1K9uR+8pm6zlOS
         QEALpomfB3NGTsYV6qpkZy/rJ4v8/JfGLvsyoUzhFzVEfR7Kx8FczGTDVDPnifm/R96m
         pBJA==
X-Forwarded-Encrypted: i=1; AFNElJ+YTtlntaNwRZjKYMUWyQMFOm2Srd+vwzQr/xsKRcBFN1XPRmB5qyUhhcQEC+6sXY/Vgdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGOj3iO5392EsdeYbK4qzJBa13i8N1oxayxSfHYr8Xb9B3aaJ
	DUpCEgQ/O+4Pe5DVMXFVfkLChVis8/QjMU4yw+qrt2SHyACR3G/BZirqx6yv9T7MN7bytwMbzVo
	FbwmoeA==
X-Received: from pgbbw24.prod.google.com ([2002:a05:6a02:498:b0:c79:3224:837d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7283:b0:3a2:f05a:795e
 with SMTP id adf61e73a8af0-3b307bc9d78mr19907560637.3.1779822697331; Tue, 26
 May 2026 12:11:37 -0700 (PDT)
Date: Tue, 26 May 2026 12:11:36 -0700
In-Reply-To: <CAO9r8zMuhJpeBwY-tod4mr522hXhHRrkK8UhnxgpMi0SQ0vyMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506015733.1671124-1-yosry@kernel.org> <20260506015733.1671124-2-yosry@kernel.org>
 <ahDidRRVYHD6x50P@google.com> <CAO9r8zNOEYf7RzoDUjueTVaiFTFQ7sizBfpeCoCbCCTFavRDqw@mail.gmail.com>
 <CAO9r8zMuhJpeBwY-tod4mr522hXhHRrkK8UhnxgpMi0SQ0vyMg@mail.gmail.com>
Message-ID: <ahXwaC7U8mGJKr-P@google.com>
Subject: Re: [PATCH v6 01/16] KVM: nSVM: Stop leaking single-stepping on VMRUN
 into L2
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026, Yosry Ahmed wrote:
> On Fri, May 22, 2026 at 4:45=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Fri, May 22, 2026 at 4:10=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Wed, May 06, 2026, Yosry Ahmed wrote:
> > > > According to the APM, TF on VMRUN causes a #DB after VMRUN complete=
s on
> > > > the _host_ side. However, KVM injects a #DB in L2 context instead (=
or
> > > > exits to userspace if KVM_GUESTDBG_SINGLESTEP is set) in
> > > > kvm_skip_emulated_instruction().
> > > >
> > > > Introduce __kvm_skip_emulated_instruction(),
> > >
> > > Eh, just make svm_skip_emulated_instruction() visible via svm.h and c=
all that
> > > directly.  No need to bring SVM's mess into common KVM.
> >
> > Yeah I thought about doing that. The only reason I was hesitant is
> > that if [__]kvm_skip_emulated_instruction(),
>=20
> if [__]kvm_skip_emulated_instruction() gains new logic*

Well, __kvm_skip_emulated_instruction() can't gain new logic if it doesn't =
exist,
which is why I want to avoid it.  IMO, it's _more_ likely that we'd add cod=
e to
__kvm_skip_emulated_instruction() that breaks the obscure VMRUN behavior.

And if we add logic to kvm_skip_emulated_instruction(), it's seems like a f=
orgone
conclusion that we'll have to analyzing VMRUN to see what the "right" behav=
ior is.

> > handling it here might be missed. Also, there's only one direct caller =
of
> > svm/vmx_skip_emulated_instruction() (and it's TASK_SWITCH interception,=
 who
> > cares).

handle_exception_nmi() also calls it for INT1, though that code is broken (=
the
INT1 should count as an instruction).

> > So I think it's more consistent and future proof to refactor
> > kvm_skip_emulated_instruction() instead.

I actually think the task switch case is the perfect argument for using
svm_skip_emulated_instruction() directly.  The only flows crazy enough to w=
arrant
bypassing normal instruction skipping behavior are legacy task switches and=
 VMRUN.
Sounds about right to me :-)
