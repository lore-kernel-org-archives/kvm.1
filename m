Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD7027FD51
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567887; cv=none; b=VgJG8Ndh/eRxvmFGqxD5f+EyJC/guozD6FZXApILY0idfZALhpcSb8xKMxd3JItsdilQ86z/T2mS1yKBptV6mdKXfTxTe67vWQstLyFvRnYJz1//O7JBgtEmhIj7ErrwmumDX3sfZyJcltzLuhN2htTfnyiKNlkymf8sqTKLpP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567887; c=relaxed/simple;
	bh=v4PgUdE43nHTbA5soLd3rBltuVMlhnojXtVTHFkCfGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrBbjpvhakE/Mqet9UZ4DKk1Dqz5sFULTTbDHIB+cRVDCrF582pL4hz/deaaw+HwgbuOVURP7GyeavlrXdfh9J6EopKSTw7oU27788KX4NeHKnQ+th8dlooipBTaTBOkUyPymJjJn2BbuzO9ndwQvM7vEXds1qgMFwYJpt983AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omz+Oele; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omz+Oele"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48031F000E9
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 23:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781567885;
	bh=1UmaMFQ/4eIV+ti/x/VXJ+YBRSH8ZH3TYC2gJLIhwWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=omz+OeleB1+6snp7MUFfUmqmZeat8qL7Xkogu15BWy9OgaBgPFFxm+gUCqj48R85m
	 5cedjducNR5MBGFbymqfchEQVmYqGhuUAv7Bm1xKrMLClDtRFWXF1N0UX02bVnNMgK
	 caWFL4KbuUjL9xZArvzlYvR3wEzx9CNRzMpMfP+W2gyMy5/MOkwjtOrLxZHaWTnMC4
	 DlHWbKk0lJjJeDoXwakI9Wwif1es4UvHrHR+g5cQ/rvyCcrxbQPfLt9kijZMDkvM1c
	 olK1rnuY+OLqdPE4rh6lPR9zS82T4YYRtItvfjyu4QKSHo0LfO6/ZZwQh07Hdqnppi
	 XPs3RukWqjG2g==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bf84a2b2077so448547466b.2
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 16:58:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9vNHmkkGMePyhQnx3+5osrxTG04yKADfzIZQaPR6Yya0hv0g/fKn2/zb8HF2Lso20bOuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaqiIalFspS1M49CnqyRM81rO0hd/1GEzb9lIy1MwiTrJ0y8le
	iahdRTf8GF6Xdlfshliv9If6M1VfBeXwVuvrKoHZvLHh01PHfpmB2ZR09nKap0i8ACRFGKlGzxa
	5axxQ3Gre6Z9LfloVDTAIy9l+f9uNb6A=
X-Received: by 2002:a17:907:75d0:b0:bf0:3f52:72e9 with SMTP id
 a640c23a62f3a-c043d6bf966mr32542666b.44.1781567884799; Mon, 15 Jun 2026
 16:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612133727.411902-1-seanjc@google.com> <CAO9r8zNa+ueRh0hf-CJ8sdyOFrcF+nEc7S06ZkMmV=GAvum6hA@mail.gmail.com>
 <ajCOzEV6zIVegeWV@google.com>
In-Reply-To: <ajCOzEV6zIVegeWV@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 15 Jun 2026 16:57:52 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNqhUHCs=Q-jWUhQr8VJF7SgL-Kh4Ztji0E5vWpSB2UOg@mail.gmail.com>
X-Gm-Features: AVVi8CeZ9yJnMk_kwSGNbEJ9LWbYdOQSNEVsqaqt2tvKdIbJsSa-KCb7J7Cz09U
Message-ID: <CAO9r8zNqhUHCs=Q-jWUhQr8VJF7SgL-Kh4Ztji0E5vWpSB2UOg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Expose number of shadow MMU shadow pages
 as a stat
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 4:46=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Jun 15, 2026, Yosry Ahmed wrote:
> > On Fri, Jun 12, 2026 at 6:37=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > Turn arch.n_used_mmu_pages into a stat, mmu_shadow_pages, as the numb=
er of
> > > live shadow pages is arguably _the_ most critical datapoint when it c=
omes
> > > to analyzing the shadow MMU.  Before the TDP MMU came along, i.e. whe=
n the
> > > shadow MMU was the only MMU, explicitly tracking the number of shadow=
 pages
> > > wasn't as interesting, because the same information could more or les=
s be
> > > gleaned from the pages_{1g,2m,4k} stats.  But with the TDP MMU, where=
 the
> > > shadow MMU is only used for nested TDP, it becomes extremely difficul=
t, if
> > > not impossible, to determine which SPTEs are coming from the TDP MMU,=
 and
> > > which are coming from the shadow MMU.
> > >
> > > E.g. when triaging/debugging shadow MMU performance issues due to "to=
o many
> > > shadow pages", being able to observe that 99%+ of all shadow pages ar=
e
> > > unsync is critical to being able to deduce that KVM is effectively le=
aking
> > > shadow pages.
> >
> > Why not expose indirect_shadow_pages? IIRC that was also one of the
> > stats we (mostly you) used while debugging?
>
> Because it's a subset of mmu_shadow_pages, and I suspect mmu_shadow_pages=
 will
> be more helpful if we're only providing one of the two?  E.g. if the prob=
lem is
> that KVM is leaking indirect shadow pages, then either number will suffic=
e.  But
> if KVM is zapping old SPTEs due to the KVM_SET_NR_MMU_PAGES limit, then w=
e really
> want to see mmu_shadow_pages, otherwise there will be a blind spot with r=
espect
> to direct shadow pages.  And if there's bug that's specific to direct sha=
dow pages,
> then we're probably hosed either way, because it will be difficult to obs=
erve just
> the direct shadow pages (unless they happen to be the _only_ pages, which=
 is very
> unlikely, but then we'd still want mmu_shadow_pages,).
>
> In practice, thanks to the TDP MMU deliberately _not_ accounting its page=
s as
> shadow pages, the delta between the two values will be tiny on setups wit=
h TDP
> enabled, i.e. on practically every modern deployment.  Because hypervisor=
 page
> tables are typically tree-like, and hugepages are, well, huge, the number=
 of
> direct shadow pages in indirect MMUs will be counted in tens or hundreds,=
 out
> thousands or tens of thousands of total shadow pages.

Yeah if we're choosing one, I think mmu_shadow_pages is more valuable.
What do we lose if we make both of them stats tho?

>
> > I guess for most cases, mmu_shadow_pages will represent either the MMU
> > pages used to shadow the VM's x86 page tables (with TDP off) or nested
> > TDP MMU pages (with TDP on and nested used) -- but I do remember some
> > interesting case about direct mappings in the shadow MMU or sth?
>
> Yes, there can direct shadow pages in an indirect mmu (guest is using a p=
age size
> that is larger than the host, in which case there are no gPTEs to shadow =
and thus
> the gva=3D>gpa / l2_gpa=3D>l1_gpa translations in KVM's shadow pages are =
"direct").

I never understood why these are "direct" tho. Sure, they do not
directly correspond gPTEs, but they still are shadowing guest
mappings. IOW, if the guest has a PMD mapping and KVM has some PTE
mappings, aren't those PTE mappings still shadowing the PMD mapping,
and still need to be sync'd in the same way they would if they were
shadowing PTEs? The main difference I can think of is the 1:n
relationship?
