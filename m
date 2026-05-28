Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964323FB042
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991369; cv=none; b=c22zWSTX8pQawTQED79G5ybdPTAcNrrkAYlf89hWIWsbujziGjh/Dyd0bD9Qw7GroaISkpkHNJwluMAAO5nJfPfRILLmhzNxYPQNcWJ6TYoWnZS25E/kaXoK50pxNUNCFkjlegaj+NCW5GO5ZbmdAT47YnfMuHDZyzAS0djuPb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991369; c=relaxed/simple;
	bh=MXADqez2nf34lyfSTg6f/cc5l2FLAza4ohZxdpYi0Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MT6Bd/0OyHoSMYadbNmHvfeXhWbyIC1TcRfJ3X1kGiWTbEnGMjfxtYGIUysKZM4+6te/6k1ob7NRZOgBnPrHjBhqEA703Dr0TSrtaKA6duCobpJ0Fh38XbTdNhgPJeBdabomKUU3BfbHf3DYCpYQtjjv3Qv2dgdbsWHk9ZaUNCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA1vcEuO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA1vcEuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B681F00A3C
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779991368;
	bh=WPAo7qq4N+QSV3QEfbPPpZzKrWWB42Jkmwv3/YJH2qw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kA1vcEuOxBKMbgyzXPqMF1q3aHul1ckwGopNhJC/LhOXNX9nYYn0uPuvgy1z/ki2p
	 N2JoI1ifNy6BCodwfaxx3ptF8UBK8thPQ7uhdYuhFnwW34LrTjlCI2vtW4VYhMWTAp
	 mUvaQBT6q6lyPmPmEoDEI8hEbuiJUmH5Rab6lsmxxlcyX0nR4rAqhVdH5L0TqoBBX2
	 WHewP9LVdqqmg8/GqTUYBghxU7LoOh2z60RjGzxjL8t0vepA/tm9Saih8+p14b8gz9
	 4+rsAxmlFWxBBZkTu6lO1iQPhotxKRuHG6irDZjie8X69BQO7P6f/gQylgv+pniSfF
	 y2GBpX5Y7+Pkg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bdbcc6c4500so1217038966b.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:02:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+bFETLE2lFOYfLAzAzWDlTEzbFeVhI9oLqvi8G3u+rxBJiAL4p3b1i/4wXKKcyyTF4fas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKiu6TY7sPWjQ5X2E1nUGkERlLCxwKQf8AC4/1Dnwq/hNbKHc
	lK4W1MKwLEVeqZ19htcjlL27i+vxP5OBVBd2ehkbuhCP52jXVK+tLoB1wWC3C1sL/P5JWH0WXat
	4mQYgEDchBwfq1vdXN5INuucuzgKgP5k=
X-Received: by 2002:a17:906:4fca:b0:bdc:bb72:7bc7 with SMTP id
 a640c23a62f3a-be973d29a42mr15463466b.31.1779991367192; Thu, 28 May 2026
 11:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527234711.4175166-1-yosry@kernel.org> <aheoLra4MFZj7ID7@google.com>
In-Reply-To: <aheoLra4MFZj7ID7@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 28 May 2026 11:02:35 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNgjATxV6KL4gv-_JwCQyUt-ygG9t4dKAe00sUVVLg=8w@mail.gmail.com>
X-Gm-Features: AVHnY4JJnioazfwT8t0pNID5b3M-MIdf10cV-JVC0c-PzRBPemI7iJF-mRne8Nk
Message-ID: <CAO9r8zNgjATxV6KL4gv-_JwCQyUt-ygG9t4dKAe00sUVVLg=8w@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] KVM: x86/pmu: Add support for AMD
 Host-Only/Guest-Only bits
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

On Wed, May 27, 2026 at 7:28=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, May 27, 2026, Yosry Ahmed wrote:
> > Jim Mattson (2):
> >   KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediated
> >     PMU
> >   KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Only
> >     bits
> >
> > Yosry Ahmed (15):
> >   KVM: nSVM: Stop leaking single-stepping on VMRUN into L2
> >   KVM: nSVM: Bail early out of VMRUN emulation if advancing RIP fails
> >   KVM: nSVM: Unify RIP and PMU handling calls when emulating VMRUN
> >   KVM: nSVM: Move VMRUN instruction retirement after entering guest mod=
e
> >   KVM: x86: Move enable_pmu/enable_mediated_pmu to pmu.h and pmu.c
> >   KVM: x86/pmu: Rename reprogram_counters() to clarify usage
> >   KVM: x86/pmu: Do a single atomic OR when reprogramming counters
> >   KVM: x86/pmu: Check mediated PMU counter enablement before event
> >     filters
> >   KVM: x86/pmu: Add support for KVM_X86_PMU_OP_OPTIONAL_RET0
> >   KVM: x86/pmu: Disable counters based on Host-Only/Guest-Only bits in
> >     SVM
> >   KVM: x86/pmu: Track mediated PMU counters with mode-specific enables
> >   KVM: x86/pmu: Reprogram Host/Guest-Only counters on nested transition=
s
> >   KVM: selftests: Refactor allocating guest stack into a helper
> >   KVM: selftests: Allocate a dedicated guest page for x86 L2 guest stac=
k
> >   KVM: selftests: Drop L1-provided stacks for L2 guests on x86
>
> This all looks good.  I'll get the KVM changes applied and pushed (assumi=
ng they
> pass testing).
>
> For the selftests, I'm going to hold off on applying them until after the=
 initial
> pull requests for 7.2 are merged into Paolo's tree.  The (AWESOME!!!) L2 =
stack
> changes are going to cause conflict hell, and it's easy enough for me to =
carry
> them out of tree for a few weeks.
>
> I'll send a refreshed version of the selftest once kvm-x86 has settled do=
wn for
> 7.2, e.g. to account for the gpat test as well.

So do you plan on getting it merged later in the 7.2 merge window or
for 7.3? I think the former but I am not quite sure.
