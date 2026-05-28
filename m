Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3D2E736D
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991108; cv=none; b=Br9J9OIyr/ks0EhEAgqsJTJnfHCtpqQdmZs0Q8/VyDrcrrzuu6gJfIs/w48IlYMtdBUUhurEbV0lKj7dxRao3TumMxPhBCTGjRPgZC9wztcn3u8vKNpNZYyZZdO6THe5vvkDcoRp0zcWMh83OFAAM+odQwhZXJgLtyar3tNTK2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991108; c=relaxed/simple;
	bh=hc3UesN29CF20wOgu+tmb1Ds3CR52EMvl6N9AokI1k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aED+10ybv7CLCIuPm1P3vXxllnQWHr4PdC0DPMJFQlXALq090CM0JoI8enVPwnmu2RixHybdxLe+nF1iOyMwU9KEqYr64uY5SaKwRwiNpZmqgBhjSu6HPEr2FXP8dxgSzVJG1nxu6Uo1i7Im2U5oh9vuSAF/po/c7mIYvCP31m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRJHFf8s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRJHFf8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604DB1F00A3F
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 17:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779991106;
	bh=xYAZdlSqfi/qnVtJtnbCQKrCx7zqQzVZyc4IuwDcx4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lRJHFf8sYlxn4CSexVSLcrhDyV/8rQxbjOfXLtf9fXmJ5Qb1SK9BEMBZTW/5fLOce
	 rErhMMM1r8OMVMmq22dUo13KO48epUQLUbNGZcxVH4llxywx5JbrK2f9LmGOTnBati
	 zjXggBhSPd7LWXn5E09cXLsrY/2z6hnRBUSssDH4ycu6/laiupGv1nqlDOtXUGEeyp
	 mWWKiy04sTVb61ewNuCG2LXKrSZhJlaho0414ABQvTzcK2JEbYd++cZKDQLITsVM99
	 GMcHUSFhHpqBQK4y5FqvoEhNAS7bmdq3ELr8BQW6XjW8x8gQhEcZGzJKHenulVIv54
	 GR8wVk7TAGLMw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bdd1986cc86so1047868566b.2
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 10:58:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+LN9QqyPJcypm4oxY0B7CNoK6z32jDZpiDDDfYp+CfIkKPS4O5s0kAw9ntJekA1OXEWBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyneU78ylnsjTorZJkkN/uNPAbQUshW1Oca2yp5DSdWCa47KQhc
	/W0oubrs7Pw55G7ne8X8HUI9rd1Jcm8bE81IW9NIT2Q9SZ2Tov6R9Gc45Bnfx8IvxXiFTngNd7+
	kih45EsCZPfiLTfIa3I/LqGbClvw+cbA=
X-Received: by 2002:a17:907:7b9d:b0:bd9:2b46:99b0 with SMTP id
 a640c23a62f3a-be974a19664mr13349366b.49.1779991105313; Thu, 28 May 2026
 10:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527234711.4175166-1-yosry@kernel.org> <20260527234711.4175166-16-yosry@kernel.org>
 <aheu-KReRnd7qK1l@google.com>
In-Reply-To: <aheu-KReRnd7qK1l@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 28 May 2026 10:58:14 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNw+iFdZn3uE6p7cCZYVPNeBxAwKhGtKgTErWQ3WL9tWw@mail.gmail.com>
X-Gm-Features: AVHnY4IDiBF15PvC9-eK1Fh-QJuj5eqiCCtuQ109Pcm56_Bs812qCp1e6fN2pQI
Message-ID: <CAO9r8zNw+iFdZn3uE6p7cCZYVPNeBxAwKhGtKgTErWQ3WL9tWw@mail.gmail.com>
Subject: Re: [PATCH v7 15/17] KVM: selftests: Allocate a dedicated guest page
 for x86 L2 guest stack
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

On Wed, May 27, 2026 at 7:56=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, May 27, 2026, Yosry Ahmed wrote:
> > Instead of relying on the L1-provided stack for L2, which is usually an
> > array on L1's own stack, allocate a dedicated page of VM memory for the
> > L2 stack in vcpu_alloc_{vmx/svm}() and use that as L2's RSP in the
> > VMCS/VMCB instead of the L1-provided value.
> >
> > Most L1 guest code does not do anything with the L2 stack other than
> > stuff it in RSP, so this change is transparent and the L1-provided stac=
k
> > is silently ignored. The only exception is memstress nested L1 code
> > which puts the vCPU index on L2's stack, so update this code to use the
> > newly allocated stack.
> >
> > L1-provided stacks will be dropped and cleaned up separately.
> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
>
> Blech.  This exposed a nasty edge in selftests.  For tests that enable TD=
P, the
> slots need to be identity mapped *after* allocating SVM/VMX.  Found out t=
he hard
> way: the gPAT test starting failing.
>
> Not worth worrying about right now, just one more wart in selftests that =
needs
> to be cleaned up.

I would squash that diff below to the gPAT test rather than this
patch, but up to you.

Generally speaking, the tdp_identity_map_default_memslots() API sucks.
It has to be called after all mappings/allocations are done, which is
soooo user unfriendly and when it breaks it takes time to figure out
what's going on.

I think it should go away. Ideally either:
(a) When TDP is enabled in the VM, tdp_identity_map_default_memslots()
is called, and then every time we create a new mapping in the VM we
mirror it in TDP page tables.

(b) Every time we update guest mappings, we mark the TDP page tables
as "out of sync", and we "resync" on vCPU run as needed.

Either way, it is not as straightforward as just calling
tdp_identity_map_default_memslots(), because the current code reuses
the same logic as stage-1 mappings, and it fails if there's already a
PTE. So consecutive calls will fail if they try to map the whole thing
-- unless we free all TDP page tables first.

I don't think I have time to spend on this right now, mainly
documenting my thoughts, and putting this out here in case you (or
anyone else) has enough hatred for the API to go do this before I get
the time to.
