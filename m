Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140A03B42CE
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781557071; cv=none; b=DG6Q19Ot75uMqKpm3xNjVUXKdm85Vsc0tv2Xv5+VADk+ZCBv5WYoJe1j5CdgUVT+TLw+rCL+uPLPZzdE+y4K28ZuFm1oaVLTspb2qBdRRs/QZBa42dq+8M/cP+1le0MNIASJGGpHIuE+5AzIfs3yV/1wXdfY2f21jQtPcHhLv6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781557071; c=relaxed/simple;
	bh=x1iYYQMNxSGYgYQaNpmlpk6BAvsm9R4qO4txSv4otjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmqgmPq8UZc/WpsLQ+e2ZQB59lLCIuhs5gWEvb4GZK7JOX7cdn53qVN7FW4WUnj5s59b8FUZGJXqfIX97byDOlwu9YieFrEbF0PgjUMWQ/t0ZdkSTiSAgAGyqnN+j7ljF2XZxQGpgjJXyaHWZacrbu6+DLYFmLb0MnNCMyxyHM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRkwZXNh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRkwZXNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4CF1F00A3E
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 20:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781557069;
	bh=vJSuxSG97Q+i/Jgi7qhX9Ne0PadNZmEIG3SjS9YTHjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gRkwZXNhw62anknk/QAcivJlI1Ef4W0550RbwSZJc3a6paHvIn3j2U1u3hJgGTfJf
	 +lRSE+4rVOYD0h0Kj7FYIDcCVyIhqk4zcN1vokKPlPZc5kRhl7yB5A9PYapYCUzYtQ
	 ybxWA3ABJot0C39vZo6/6gCsnp1ETq8NYQIZZ2CIeDx3M2PEXKL1FLnUTejXAa7W4l
	 Xd7CO04aj6NQoYAtzfgdBiLiQUBE+xdbn56+2ST4n/2U/S5ERw5jYbU3gOUDr1RWqo
	 Z0b6nHN1XEmtRvKaqjo5Ro9eaa88WiPpSoD+9j++NVAEy0rXcxbXajmN6LDw9aZHoE
	 FxSm5Kqc/f1Aw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6912f4acca4so6697291a12.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 13:57:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8E5vNxo4wkjqT7M8/+qjBIOWk2LOGF4GIM9iX8gexgr1+9w6jVItXX9LvawthxA4phXik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNcpJAWhXoNB/4VrqvrcRYL02EsDWZJBg1F0gm+PupOxjd4iTO
	gJjGf4TOh+KkdMdRwzuI8wf7oZGlB1Sjhd1VAYvRkPLBP9j2KMdTvx2wX6MXPxaM4392UAKAOAN
	21fx7TPHnj/1c4sqgOvYh36f0RjHKzZw=
X-Received: by 2002:a17:907:1987:b0:bea:3ebb:19d2 with SMTP id
 a640c23a62f3a-bff4c6f9410mr569294866b.25.1781557068751; Mon, 15 Jun 2026
 13:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612133727.411902-1-seanjc@google.com>
In-Reply-To: <20260612133727.411902-1-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 15 Jun 2026 13:57:37 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNa+ueRh0hf-CJ8sdyOFrcF+nEc7S06ZkMmV=GAvum6hA@mail.gmail.com>
X-Gm-Features: AVVi8CdAATKMCeNnrYcCFAhmeVTfaVN_77tHPAEMMDRQc6cMBoFa93k54REgY2w
Message-ID: <CAO9r8zNa+ueRh0hf-CJ8sdyOFrcF+nEc7S06ZkMmV=GAvum6hA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Expose number of shadow MMU shadow pages
 as a stat
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 6:37=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Turn arch.n_used_mmu_pages into a stat, mmu_shadow_pages, as the number o=
f
> live shadow pages is arguably _the_ most critical datapoint when it comes
> to analyzing the shadow MMU.  Before the TDP MMU came along, i.e. when th=
e
> shadow MMU was the only MMU, explicitly tracking the number of shadow pag=
es
> wasn't as interesting, because the same information could more or less be
> gleaned from the pages_{1g,2m,4k} stats.  But with the TDP MMU, where the
> shadow MMU is only used for nested TDP, it becomes extremely difficult, i=
f
> not impossible, to determine which SPTEs are coming from the TDP MMU, and
> which are coming from the shadow MMU.
>
> E.g. when triaging/debugging shadow MMU performance issues due to "too ma=
ny
> shadow pages", being able to observe that 99%+ of all shadow pages are
> unsync is critical to being able to deduce that KVM is effectively leakin=
g
> shadow pages.

Why not expose indirect_shadow_pages? IIRC that was also one of the
stats we (mostly you) used while debugging?

I guess for most cases, mmu_shadow_pages will represent either the MMU
pages used to shadow the VM's x86 page tables (with TDP off) or nested
TDP MMU pages (with TDP on and nested used) -- but I do remember some
interesting case about direct mappings in the shadow MMU or sth?

I could be hallucinating this (I was bit by an AI agent).

>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
