Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E02350D7D
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783969104; cv=none; b=ekdWQX2WCFPfUye5VBJNWScelrJsbCzgzJkny+4wtQSvsesSC39fuTvPCvbwWR+ZzAFezjtmrcE/Pc9vVjkW3GE2jYy4N1VXMz4lfaStDkg62FZyZoJxMT2IKnJeFxWrsw7+5f1vG7Rvs3I1pWPsVuGy1klL5MnLFeQFvdN8Fj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783969104; c=relaxed/simple;
	bh=saMKXQuQhui8m4G3DHxJnlVfPcGFaHNM5ahzTToGot4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZJ0RbiAkkvScXuWUHrnUi71pNHOAkEAaKKIxHm0+ybxDP1HCYbd8Ja5EbREy2I+Kb445h7Xkyz8YnVcMmiBrGhF6nE3gxzOnolvAiYj52tvnBjy0uSznBGy6BAo7/FfGU3joCtUnrVRjRVJ0j+re+6nONQQtnOeiGE0RSXnV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BSKMnwJ5; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BSKMnwJ5"
X-Forwarded-Encrypted: i=1; AHgh+RojBaUFflDq9h6yStXSKeVSE3F8L5sVJblJPTXz3zsyoYVPL2IsU2ESxglGiZIyOJ9GRPo=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783969099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=saMKXQuQhui8m4G3DHxJnlVfPcGFaHNM5ahzTToGot4=;
	b=BSKMnwJ5tdluNGK9yukFLn6NCREFDAyFyE7k8g9T3YAqE030GB4vH5E8KjEfAxywInjeoA
	VmtD3uD/jvCcB9VlEkhg4OP1STfX2rSUycZCB9g5rrwnr5lXJ5JnlyH88Sh4LATLpCA/gn
	WUC3zRdLVA7mHDcup4vr6ngtrlS/7TQ=
X-Gm-Message-State: AOJu0YzDmTm1CFcc2SqG9FuwgunQCm24TKTTBFWiKAKgbkYw7zrR5qoU
	d8vx5tLOCaRx8qCuZacbCxuhJ8fpNGUZ09heaRugJymslAZEkdiYAvxkKJsph7V6sqhIwTGTR7S
	goiwtugaRwZ/Wnt8P9Fc9JlbFlfu4prMO92vgFsNO
X-Received: by 2002:a05:622a:a591:b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-51d71543adamr5975311cf.3.1783969089452; Mon, 13 Jul 2026
 11:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-19-seanjc@google.com>
 <CA+EHjTxJMfiGoJGetvsOWXeHjFQexFh=sdQ_kvSQT86uztAaLQ@mail.gmail.com> <CAEvNRgFgaDx9OivkKteksk36OvchMNmAk=i8CZj31huxqXB-Pg@mail.gmail.com>
In-Reply-To: <CAEvNRgFgaDx9OivkKteksk36OvchMNmAk=i8CZj31huxqXB-Pg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 13 Jul 2026 19:57:32 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxLKvj-qOQFgZ66Pq+ULQ0D98QU65gGe_2wWnR5_fTa0A@mail.gmail.com>
X-Gm-Features: AUfX_mz1ocQhaS1og1nw9rB4tAZldez9YqprwIodEpLz1KSQvk7XoHMlyFvWmz4
Message-ID: <CA+EHjTxLKvj-qOQFgZ66Pq+ULQ0D98QU65gGe_2wWnR5_fTa0A@mail.gmail.com>
Subject: Re: [PATCH v4 18/18] KVM: guest_memfd: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
To: Ackerley Tng <ackerleytng@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Roth <michael.roth@amd.com>, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	=?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Mon, 13 Jul 2026 at 16:41, Ackerley Tng <ackerleytng@google.com> wrote:
>
> Fuad Tabba <fuad.tabba@linux.dev> writes:
>
> >
> > [...snip...]
> >
>
> Thanks for bringing [1] up, I didn't make the link when this change was
> being discussed.
>
> pKVM definitely needs a callback when the folio is released from
> guest_memfd's ownership.
>
> >
> > free_folio is the only to_private=false caller today, but the cover
> > letter sketches the other one, a private->shared conversion through
> > kvm_gmem_make_shared(inode, start, end). Once that lands both reach
> > the hook with to_private=false, and as far as I can tell, the only
> > thing separating them is kvm == NULL / INVALID_GPA. That isn't
>
> On the folio teardown path kvm has to be non-NULL so that SNP can find
> out which VM to unassign from, so you're right that INVALID_GPA won't be
> sufficient to separate conversion to private and teardown, for pKVM,
> from the arch perspective.
>
> > documented as a contract, and nothing in-tree reads it on that branch
> > (the kvm/gpa check is under if (to_private), and
> > sev_gmem_make_shared() doesn't take a kvm at all), so nothing would
> > catch it regressing. The sketch is also inode-scoped, so I'm not sure
> > the conversion path passes a non-NULL kvm at all; if it doesn't, the
> > two aren't distinguishable.
> >
> >>
> >> [...snip...]
> >>
> >
> > The Kconfig now couples them too: an arch can't take teardown without also
> > taking conversion. pKVM wants teardown and not conversion, so that's a problem
> > for us today, not only once the second caller lands.
> >
> > This is the same ground as v8 15/46, which ended with the two split under
> > separate Kconfigs. Suzuki confirmed CCA disables both; pKVM wants teardown only,
> > since our conversions are guest-initiated and EL2 has already done the
> > transition by the time the host runs the generic path [1].
> >
> > I'd rather keep the free path on its own callback. If you want a single hook,
> > passing the caller explicitly instead of leaving it implied by kvm would work
> > too. Merging the two conversion directions is a genuine cleanup, it's the free
> > path I'd like to keep separate.
> >
>
> Is it okay if later, we add a .gmem_teardown callback with a new CONFIG
> flag that pKVM can use?

That works for me, and I agree it's nicer to introduce the callback along
with its first user.

Sean, is that the plan you have in mind as well? Two things that matter for
pKVM when it lands: the new CONFIG needs to be independent of the conversion
one, so that free_folio fires for an arch that selects only teardown (pKVM
wants teardown and not conversion), and the teardown callback stays distinct
from a private->shared conversion. Good point on teardown needing a non-NULL
kvm for SNP, incidentally, that's another reason keying off the sentinel
wouldn't have worked.

If that's where this is heading, I'm happy.

Cheers,
/fuad

>
> If that's okay, this merge (of function names and of the patch series)
> can proceed. It's also nicer that the new callback and CONFIG are
> explicitly (re?)-introduced with pKVM support so the introduction is
> chronologically linked with pKVM support too :)
>
> > Thanks,
> > /fuad
> >
> > [1] https://lore.kernel.org/all/CA+EHjTwLRzrq0vY0-OosENJ2Gkknerux53aVBj0zGRQUkRQP=A@mail.gmail.com/
> >
> >>
> >> [...snip...]
> >>
