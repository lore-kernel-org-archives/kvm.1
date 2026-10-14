Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2A421FF2A
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016750; cv=none; b=IySpZeuGh4TSDzpyI+HZC05Ixkwq0ssLjffULCiPS2kcoint157sXUfqIuG0Oq0dnLC4uY0xOji16cWQME9vamFGKuOmYDjI+4Ai6lh0xZiYYAO8kZq9aLlQ4rP54VPhbu7fAGI53goPbEgE8FXJE2aiQeu18BRDe4RElA2h4AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016750; c=relaxed/simple;
	bh=TcjZw94PKcWZj5E2V8Ve/zaBIXnoYpu+tzsew7JkeMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgA/aVKcyEewCiShkoYFcY/F5OSPEqSK4oBPvSVEbJmHwx/u+XWSz/DWX5Y6LPh3QNOdJiG73lTwzVWt6kgpwLcJDecCi/r7hcuvlP1ICmtB/yH5vM0XuacTjSUeAG8tYb/rO6agwdGXDugcx5QxVmDbH2Cjcrnl2knVsMEA4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB3gngrB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB3gngrB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4921E1F000C7
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792016749;
	bh=1Ht1WZ3tHnehlbechAROaSWrsWVBjwNhjaGlSlzbygw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kB3gngrBe9+yDJa9/7UtlMgKsaI5uSTagMOJYwFKfaQ0OMcKJfmDEpaXV9+V9z2WO
	 ATqPfgsbeI1UtXqUTnywGKz1nWCDo6BxRSegwyxkxLijR7VG+viRQE+aoepcUC9mk7
	 tJvTeAJiYZfdnAIV5rSyYeUIYTGRxRYr/nOwc0W9/MQwjBga1LEKJqexLoHW2dp4S4
	 rAdPtgLr9l39k2cQWxDo7dLgb2z5fS8I/tWJeh315N+mpUbf1XMJrhZk1DHNBTNtA0
	 vWe7x4rbrR2UVwqZxvc1qSEBsDHZI4KgsIScnQdmYOEk4a4BXe14ofkxYBRkXzQEeX
	 EAXBh7aRbpnjw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c315729ad50so763470266b.0
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 15:25:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByoSCQBwHt/GgWXXRGt8sMA8AeKXhe0rNkDq/AXBry5OiptYNIzphHV0J+uvxh6I5E8iko=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwfzIEMzJ70GKgAb40JtQFnfNEEp5TjAe4JEqT99GSci4aXEwT
	AQuSS6IVqkCLDVs/L/IVHCoQGQqhcE9Dcaqo3bxgVV9vnb+GmB3FIQrPjDUa6+jHqd0FbFgsuM+
	WixJcqPILEy8pIes1Br1ekg/lMNpIelo=
X-Received: by 2002:a17:907:9686:b0:c1f:983f:d8a with SMTP id
 a640c23a62f3a-c31aa017261mr1750877966b.24.1792016748234; Wed, 14 Oct 2026
 15:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-6-yosry@kernel.org>
 <CALMp9eSWazT=0tXKvGb9UNWBv62di33QgugQHOa+Bo2sq0qUCQ@mail.gmail.com>
 <CAO9r8zPPR9LMtcwhH=D8gJLjmC6800mJdyV+nKT83TnMti7wJw@mail.gmail.com> <CALMp9eTyzxwjKnWXem=dAGiwJsUsArssQTcQhg56HVd+js5pSQ@mail.gmail.com>
In-Reply-To: <CALMp9eTyzxwjKnWXem=dAGiwJsUsArssQTcQhg56HVd+js5pSQ@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 14 Oct 2026 15:25:36 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNx-CUVeN8gfhnFxAUP9RBLnLV=eAFHhtW8FqTvhNEXFQ@mail.gmail.com>
X-Gm-Features: AclHuK--o7h_Stui5Fi9tI83gJakdf715k8lQZciJzbWTb26-VroCnbYjkfDf6c
Message-ID: <CAO9r8zNx-CUVeN8gfhnFxAUP9RBLnLV=eAFHhtW8FqTvhNEXFQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/27] KVM: SVM: Add helpers to set/clear ASID flush in VMCB
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > > +static inline void vmcb_set_flush_asid(struct vmcb *vmcb)
> > > > +{
> > > > +       vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
> > > > +}
> > > > +
> > > > +static inline void vmcb_clr_flush_asid(struct vmcb *vmcb)
> > >
> > > The name of this function makes it sound like the inverse of
> > > vmcb_set_flush_asid(), which it isn't. Maybe vmcb_clr_tlb_ctl()?
> >
> > Why not? vmcb_set_flush_asid() sets FLUSH_ASID and
> > vmcb_clr_flush_asid() clears it, right?
>
> Not exactly. The tlb_ctl field is not a boolean.

Right, but the current implementation treats it as such (with the
exception of falling back to FLUSH_ALL_ASID, but that becomes
transparent to the callers).

>
> vmcb_set_flush_asid() sets tlb_ctl to 3 (flush current ASID).
> vmcb_clr_flush_asid() sets tlb_ctl to 0 (do not flush).
>
> Other legal values are 1 (flush entire TLB) and 7 (flush non-global
> entries of current ASID).
>
> And, in fact, these values were chosen so that older hardware would
> see both 3 and 7 as "flush entire TLB."
>
> So, it's a little more nuanced than set and clear "flush by ASID."

I agree, I chose to abstract it as a boolean, but I understand it can
be confusing.

>
> Maybe vmcb_set_flush_asid() and vmcb_set_flush_nothing()?

I would prefer vmcb_set_flush_asid() and vmcb_set_no_flush().
