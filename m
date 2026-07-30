Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22E532C302
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785371096; cv=none; b=D+QvYRK4HYwzAW+SZXZrD/C31mg5r9+F3wj1dI1oDz8f5wTGgYQet0Bu8e02qoL6og1wA4hSBVp1CNOrlc+1YBx+xzP0Y999PdmVOj7C33LuIB0uVqGqIt3ejZGPKWuKniSSyMwv2GXMe/rVKqZ4+3LUSpTKND3Ey3L0WvYhfpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785371096; c=relaxed/simple;
	bh=xm6ESbBynSLmhNt4M7M1U1vd4p6GXt12PIYK9cFwelw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDuCk7WUqpGl3y90bX5S4avqec13sfg9f2RdVNWYzbh3fgYaHYbELD8lmagB3BXN32d23QrbbgTOdBi93TvALKgVe5h7xOdWAz0oPiOqGZygvaL4tQ0H6hMNsK308krIDP+o8gt27o7wUklCqdJc/IPVRArbhiY1puu09sSuM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grr4s9yO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grr4s9yO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB451F000E9
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 00:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785371093;
	bh=dAaJcyJIlsN9+VcsL47cSswYldIJvu79S7xvKTMOhYc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=grr4s9yO1PxJpdXwOelv4mPqcykI3TjHUredS7qBHg94cNIR8qV+Ww+Y6/N8HMa06
	 sk58IHEB/aROEHgZ5ZbbVtIAJB5wSp6iMMFZ8rE0o+U/NA4Hc8kx0cfYHYvJOoSfHS
	 /fMGjp1vjgCK68G6FOjhilHSAt5BRvs7by31fxL6UwATM4Jpxq6ayv5wgHe2LNO/Cm
	 a6csyhlnzJNIpMDuYae41f5pDeP+Gxo4L3qtiSBenkXLIWepdjsNOwtcW2sTbBTxnn
	 eJfHXRIgq1JgElz/aiF5KoZ0U/fvgTqstO43qX7EL8g0kNj/Wa5z/FcV5/nBKAaZbw
	 +s+OvM+D26WLA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so2482259a12.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 17:24:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqlWZpm7z3t1LNBnwVoD/o9QxXrySDKEcwSQZYlCF4lP3g2TApjsC9nHIj53hdJaP97Mv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTEiinnSwyj+WrKDVqfZkSkSw2aiR13ccrxu1xn00d83YZNDx/
	K0D8SnadKLhidVjdepxmRp34em+Wu3VOAaMT+0PQ6HIxvpaBmomiOe04lJyZTF0Gn9aFGASRWXy
	AT86rsmQCYFSI8XSyaSiR9oqdHKXfDno=
X-Received: by 2002:a17:906:eec6:b0:c1c:28e5:652e with SMTP id
 a640c23a62f3a-c1fa5663060mr27362866b.25.1785371092905; Wed, 29 Jul 2026
 17:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723094419.630204-1-pbonzini@redhat.com> <ameuTMWJUZfleIbk@tycho.pizza>
 <CAO9r8zMopB=YKXs5pkQmPf9uHKE0P0XORcNbc60AWXTusuY3tg@mail.gmail.com> <bb63796e-37ad-4c88-a4cb-198bd6da65e3@redhat.com>
In-Reply-To: <bb63796e-37ad-4c88-a4cb-198bd6da65e3@redhat.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 29 Jul 2026 17:24:41 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNWQxDoTh9Pa2g_YDi4+fpEUBFSr-Z5DBY_P8nYiTgExw@mail.gmail.com>
X-Gm-Features: AUfX_mye56RZ4SFCUoDO-9Du1bmLfP_Mytpxnh5gLeUQ4CAyR2QhlECeGMEU1CM
Message-ID: <CAO9r8zNWQxDoTh9Pa2g_YDi4+fpEUBFSr-Z5DBY_P8nYiTgExw@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if
 NPT enabled
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Tycho Andersen <tycho@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Sean Christopherson <seanjc@google.com>, 
	Alexander Lougovski <alougovs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 4:41=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 7/27/26 21:58, Yosry Ahmed wrote:
> > On Mon, Jul 27, 2026 at 12:23=E2=80=AFPM Tycho Andersen <tycho@kernel.o=
rg> wrote:
> >>
> >> Hi all,
> >>
> >> On Thu, Jul 23, 2026 at 11:44:19AM +0200, Paolo Bonzini wrote:
> >>> As to the workload, Alexander threw more or less everything at the sa=
me
> >>> time at the VM:
> >>>
> >>> - a full Windows Defender scan every 30 minutes
> >>>
> >>> - a disk I/O job
> >>>
> >>> - a loop doing repeated mmap of system files (mostly to hope that
> >>>    it triggers some consistency check in the Windows memory manager)
> >>>
> >>> - SQL Express 2022 + StressDB (1.6M rows), with the host doing querie=
s
> >>>    (75% write/25% read) via sqlcmd
> >>
> >> Can you share the code for the mmap + disk io + DB content generator?
> >>
> >> We're looking at this and would like to reproduce.
> >
> > Not sure if this is relevant, but I see that hyperv_tlb_flush is flaky
> > with npt=3D0 on Turin at the tip of kvm-x86/next (commit 567329869b9c7)=
.
>
> Same on Milan, but ept=3D0 works.
>
> > It's not likely because the problem fixed by this patch happens
> > specifically with npt=3D1 and not npt=3D0 AFAICT, but it is a weird
> > coincidence :)
>
> And also because this patch uses, in the end, the same flush mechanism
> that npt=3D0 and ept=3D0 already use.  So that bug is probably in npt=3D0=
.
>
> That said, I'll do a quick experiment of running hyperv_tlb_flush in a
> loop with this patch.

I don't think this patch changes the behavior with npt=3D0 tho, right? I
would be surprised if the flakiness went away.

I mainly mentioned this in case the (preexisting) cause of the
flakiness is somehow related to the problem this patch is trying to
fix.
