Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF94407CFA
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991547; cv=none; b=LUfwzeu2xWkueR52T4SH1Vm7RsaGloUdfPRiTim/4P+X4kNuNLn1tmbO3yzEKqBXS99LYAb9OfQ1Ft4l/L8Vd0igF5KCL/OJ2eO4lJ60AvqUsSPqSdVqRdU6piGGTFBIUseDpw5/PVMZ6vpkr82GvDUf61lk56ExnH0IJSw6/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991547; c=relaxed/simple;
	bh=ezWkMf1/nBuwKvq1Ie6nTfMcUtAMsxfURYeysfpXWtg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oOcD0PRnO+Ne3pI1XCF3uqAGHb81EOKUx9auFe409Jwv8vh49UIzqC1keu8t1E5el3HbOTcocMVo0cn8+wGQdTBDmhNmr+RdRl7HYOCXI510j53lvTDvcC5QJKvnuebofmCKSLQkHlvQgOGjGz0kiMn8ERkCQibbjANE7frE2tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muFhEEvl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muFhEEvl"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd6cc53fd6so135693915ad.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779991545; x=1780596345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAX4aGyOlp58kUC6uPoUPFDHIumnxZdWSgRHitD9Mr4=;
        b=muFhEEvlrm7+GSocv/9jaos8tn4Q0MtvzGVvQjYomUkuFPutXZy0y8V4CXWsyuiTwa
         ghmHnRH6YVmCM4hFv60x1RtXU5XAalgYnPBM/3cZjOsA/eiEm1PDgyyFWNR1yeSf2NwD
         vqnDa5JGfxODQGDgQO11O5aoef8/uNSzHBl/7JGBSkrTJX0HrGOQLIV8aW8lgUtvxsEZ
         FD6U40iUwAqzlyYc2Ndg4uyE1QkR/PbJOZGU3v0PQLUgE97yp+oNoeM9U0inlJlfvFyg
         feomkO0kcx1sEeVMQNLneFXLqq4P4/vkbkaYPSHNDgAVWo0kxCEIs0C0fFai09orc7LF
         htBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779991545; x=1780596345;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EAX4aGyOlp58kUC6uPoUPFDHIumnxZdWSgRHitD9Mr4=;
        b=A5Fmsxwfm8WhadMDqTGiaDZQhPEl20Qu21TZ6IHvIrpCkPbhddkaF5M/SkHcKl82ov
         LKY2Aym3ToMmZrx28wj6pYLVGprwX56wvfZXhfyqm/LHmKeIBLtcXqNvLdS3ibWY51l2
         ouTgyJNLM01VZMr6lS1TGKWRBvvDJPD1CWT97AqLJsxaXTMcXOV52+F0fhNq+oHBmNDp
         zUNaimzhKSDwHs2gjcscVE1O9XdXBIHapxmeFtKF9zCH8IIzsZtiKB6vqoiUnE6vVbKe
         J8FD8ed18QB7sRajKZ7SAnu02QfuPV14D8E8A0IifdDJeCl/ugx+xoDfBHcqPxvB/3e8
         5Uig==
X-Forwarded-Encrypted: i=1; AFNElJ/R2eyHOhnStUeOrazV41GSEZPaT+eeuqMtqO8k3ZOZGMVXpn1lWr2NaogECBq0mAzi8uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdSmtIuPXe1mzbjV9V1j+2Nmmk1fjd+yt1tpJFhVJkawMtfrUU
	BVdc47hxUd7Paxx2HzmSwOa5klB4EsQcWTzQ+SURMeSR4agNmZbmDTXbfAoJwd72MCv1Gh7ReDx
	N38O4wQ==
X-Received: from plbkg11.prod.google.com ([2002:a17:903:60b:b0:2ae:41d1:278d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2388:b0:2b4:5cb8:99eb
 with SMTP id d9443c01a7336-2beb07e9e15mr313634085ad.27.1779991544602; Thu, 28
 May 2026 11:05:44 -0700 (PDT)
Date: Thu, 28 May 2026 11:05:43 -0700
In-Reply-To: <CAO9r8zNgjATxV6KL4gv-_JwCQyUt-ygG9t4dKAe00sUVVLg=8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527234711.4175166-1-yosry@kernel.org> <aheoLra4MFZj7ID7@google.com>
 <CAO9r8zNgjATxV6KL4gv-_JwCQyUt-ygG9t4dKAe00sUVVLg=8w@mail.gmail.com>
Message-ID: <ahiD99VKTEseNlCL@google.com>
Subject: Re: [PATCH v7 00/17] KVM: x86/pmu: Add support for AMD
 Host-Only/Guest-Only bits
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

On Thu, May 28, 2026, Yosry Ahmed wrote:
> On Wed, May 27, 2026 at 7:28=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Wed, May 27, 2026, Yosry Ahmed wrote:
> > > Jim Mattson (2):
> > >   KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediate=
d
> > >     PMU
> > >   KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Onl=
y
> > >     bits
> > >
> > > Yosry Ahmed (15):
> > >   KVM: nSVM: Stop leaking single-stepping on VMRUN into L2
> > >   KVM: nSVM: Bail early out of VMRUN emulation if advancing RIP fails
> > >   KVM: nSVM: Unify RIP and PMU handling calls when emulating VMRUN
> > >   KVM: nSVM: Move VMRUN instruction retirement after entering guest m=
ode
> > >   KVM: x86: Move enable_pmu/enable_mediated_pmu to pmu.h and pmu.c
> > >   KVM: x86/pmu: Rename reprogram_counters() to clarify usage
> > >   KVM: x86/pmu: Do a single atomic OR when reprogramming counters
> > >   KVM: x86/pmu: Check mediated PMU counter enablement before event
> > >     filters
> > >   KVM: x86/pmu: Add support for KVM_X86_PMU_OP_OPTIONAL_RET0
> > >   KVM: x86/pmu: Disable counters based on Host-Only/Guest-Only bits i=
n
> > >     SVM
> > >   KVM: x86/pmu: Track mediated PMU counters with mode-specific enable=
s
> > >   KVM: x86/pmu: Reprogram Host/Guest-Only counters on nested transiti=
ons
> > >   KVM: selftests: Refactor allocating guest stack into a helper
> > >   KVM: selftests: Allocate a dedicated guest page for x86 L2 guest st=
ack
> > >   KVM: selftests: Drop L1-provided stacks for L2 guests on x86
> >
> > This all looks good.  I'll get the KVM changes applied and pushed (assu=
ming they
> > pass testing).
> >
> > For the selftests, I'm going to hold off on applying them until after t=
he initial
> > pull requests for 7.2 are merged into Paolo's tree.  The (AWESOME!!!) L=
2 stack
> > changes are going to cause conflict hell, and it's easy enough for me t=
o carry
> > them out of tree for a few weeks.
> >
> > I'll send a refreshed version of the selftest once kvm-x86 has settled =
down for
> > 7.2, e.g. to account for the gpat test as well.
>=20
> So do you plan on getting it merged later in the 7.2 merge window or
> for 7.3? I think the former but I am not quite sure.

Ideally, later in the 7.2 merge window.  Worst case scenario, super duper e=
arly
in kvm/next for 7.3, so that developers (and me) can build on the functiona=
lity.
