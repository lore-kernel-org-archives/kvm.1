Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793662659;
	b=j4tuuuqoKvPYBQvDXnEGmJLFqXDH6KqNKKdtFOzqCWIRZomrSGMPHALUxwavMABOUKoN
	 y7pv1yaNZURXp/fAvK+Azhf0gfRDKCDPudEz9P+0uDub9UjmS3OiU+28vgUVdk0eXCHwk
	 Mzqa3UxqbgrXH+zlPCKf/ggH0vidgsWR4x2Q97xXBG+8HlIu8ZGZszQSMyN+HDk/4TnEJ
	 MZ8M4oqjj2CR4heT0couLMUgSsCeGJ0tqgFMMZMV97We4OW/zcm7/HQ6eMt7Rt56dkvuH
	 fimXzklC73MJOpGz7gOVbQb0VPYCSJWZTNsh0Dpgf3V+B3SJYf+RqmEsMjNN0Z3bySQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662659;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=oBbOwdv7HQAsh6m0z82QEjFn2nZEMVYTw6CIehV5US8=;
	b=KJR3t2NbC+I2kYzEilVhw/unOaaHHDcl0pM4G+hjxFsxdJYmAMpULIYTQmj90wUGaB9h
	 8L4oky5O9Z8CEEQH12KiHKm/I6si5lf8YCMqUl3S652qCMFAZPALQF7ayg0GtsxTchl/O
	 o6bG7dC7qicnXh1dgUYclJGrLzEwfljV9GckCxD595tElK8FELfDmONIdlh1pBMfyrB0c
	 hFOW2QWGWgDD5ndrAWtS+6fKv39snnjOt3QMaU41fXWoxWv51ytMMoVlqb9UXgE+jiQeV
	 scHix6oVgD7vXtm9ri5fV+NBIAY+mfqAcM7sVEas1B6khbh9RGSah1yMvqB5REwSuKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mk1Cjqsd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78510606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mk1Cjqsd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7F01F00A16
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 23:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793662659;
	bh=oBbOwdv7HQAsh6m0z82QEjFn2nZEMVYTw6CIehV5US8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Mk1CjqsdB5MHIBfkvJAnrnLbWPw1mcXNGh18LyKHVNCWARR2ZuM9QifSTS2FL2M1K
	 3gOx+MDAblO6LMyrMmCD5SMsyZ9184ru/m56WKcOC0U+3D4UeMIWSYR/2fPiUCKb2C
	 Y1wbc3nQ84HFQwA1cAHAzKu+cqnr9NoTo1eHzEMMIQVIRdDwq7UoiX9L1uGqDLeErG
	 oP71RYNGLLTe9Xb1uqsf0ZaacqIH3kROq0mfyieMBkylFpQe7qkxVq7FHr4U3l/GxM
	 7PxiRRJwQU4IZXc7QtjhRCdDIDiYv5IEv4PN/ABemcOgVz12UEaxL6U2Mpx1TCo+TM
	 Jw8+NqsxKTayA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4550d8ab15so430808266b.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 15:37:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzRwgTlsjIaqmOLI0tKbrGCEH7h76irq5KE88DtYP+QSG7Ikter0n7cg/cyBdfzVd8svB8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/R4UeRQZMXyzFgk4690wWdQMkuhZzRLQz/hngMx/8NMfvfgo+F
	geZ1PuUdEdMGkBa/eYEsdokuUT0IS37Szusw1XHoV4PGO8e1i6CPwOblvfIfulwitOecH83gz9+
	Afju4aN/AsI1fkrtGIbYOCqVQx+Q9rMI=
X-Received: by 2002:a17:906:ef0b:b0:c25:91bc:ff55 with SMTP id
 a640c23a62f3a-c4ca7a878bamr1000724766b.23.1793662658028; Mon, 02 Nov 2026
 15:37:38 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-12-zide.chen@intel.com>
 <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com>
 <auUQgRVFASkWtkoK@google.com> <3276824d-f6a0-455a-bf0c-703fc6d52cf1@intel.com>
 <CAO9r8zMxQnRLKGrW69rX7703AatWMp6KOXMObL9baHRPs4dW8A@mail.gmail.com>
 <6c9a13c9-e6c1-4540-a8ca-1f0e800f3571@intel.com> <CAO9r8zOWzr61pkkF01AvEp+YSOo6bA1N=L91RYiM=ETtK5+D9w@mail.gmail.com>
 <69c428d7-239a-485e-9494-32b8aa82da05@intel.com> <CALMp9eRsR8xaUmQyVu5QmYx1cZ2qFGGk+31bMymhmN9_iaPuMg@mail.gmail.com>
 <f7213eba-5b61-4514-a315-bce64823fad5@intel.com> <CAO9r8zM4eWD538L3osqSVoB0VHnjgRREtv2k419a1Vvuq+Q9rw@mail.gmail.com>
 <6d84ab57-a702-4ac0-9e29-579449b3d826@intel.com>
In-Reply-To: <6d84ab57-a702-4ac0-9e29-579449b3d826@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 2 Nov 2026 15:37:26 -0800
X-Gmail-Original-Message-ID: <CAO9r8zMvkGzxUR7jBPVFWK+Fry4wk49J3WdwFqa22bSgGaS4YQ@mail.gmail.com>
X-Gm-Features: AclHuK_Ks2MMA5FQP6XHgCe9LxJ4b9bkprLfwSiy6MqT83PaLeo4sR9HyA3cRUY
Message-ID: <CAO9r8zMvkGzxUR7jBPVFWK+Fry4wk49J3WdwFqa22bSgGaS4YQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"

> >> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> >> index 38c7a4fa1007..3849b3f5234a 100644
> >> --- a/arch/x86/kvm/pmu.c
> >> +++ b/arch/x86/kvm/pmu.c
> >> @@ -862,6 +862,8 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct
> >> msr_data *msr_info)
> >>         switch (msr) {
> >>         case MSR_CORE_PERF_GLOBAL_STATUS:
> >>         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
> >> +               if (msr_info->host_initiated)
> >> +                       pmu->global_status &= ~pmu->global_status_rsvd;
> >>
> >> The underlying issue still requires proper mutual exclusion between
> >> Intel PT and mediated vPMU, which I think can be addressed separately.
> >
> > Or maybe handle the host PT while the guest is running? Not sure if
> > that would be correct.
>
> Since KVM switches APIC LVTPC in guest context, it seems difficult to
> correctly handle host PT PMIs while the guest is running.

One hacky way to do it is to make perf_guest_handle_mediated_pmi()
handle host PT before calling into KVM. This doesn't completely stop
the guest from seeing the bit tho. Also, I think we may have no way of
finding out if we still need to inject a PMI into the guest for a
different reason or not :/

>
> I guess Intel PT virtualization could be re-enabled sooner or later, and
> addressing the exclusion issue would be a must at that point anyway.
