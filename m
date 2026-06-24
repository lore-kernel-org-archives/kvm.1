Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3D6306775
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782317684; cv=pass; b=T7Sbw3YI470mDYI8f3LsMQPp5aUN53jJFsyuj4ZMe8eMarfR1iPSMgZ9F9FV3avLD92ucAItlV7YSe+ovKOxb/dqkk7Xz9svdPnRUhFrGbN4QlXWuvVbrmEJaeCNKPZl3oLNb4go8TADocs5pMcdQCxVVDVRH+TsEC0szT2UFyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782317684; c=relaxed/simple;
	bh=Sdzgqtv1Tmlni/DBclt3F/1Zy3gjhyQWqH2lmWCayf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbwpUNdeyLTv9Cwe6uHigoZisNa1YH7NAOJP0VzszSnaPHjYj0/gLuhTsxtar8gZgYdkzOETglmfihnV3IGbUmNQ0zZOE7J5pOm8Yz6yzYyL6oiZWIeolbj4zxznLgD0cUh1Xlrb45HpRqDqMO0bo3svro8nVF+JZYoS+7NO8l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ajk/R8Bo; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ajk/R8Bo"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-519ed52bcc6so334171cf.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 09:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782317682; cv=none;
        d=google.com; s=arc-20260327;
        b=rUOVEDqjzwxZN8z0raddD8s0w7VzzFNcDHMkFZmryE5SP0XBDzkHW4bJF4jf83+J3T
         DQjLe1t7gm1z5TbN10u9Lh2y/KQifUL0LldfOCehxPi7DIu8KmLfxNkPQaErpyGhasHg
         udlqvpw/3bJhhtRqPRZZ9Z/m+E0+PrVPJsd1vOoyAks9qWpPcPbL8eAsMZ5Y1pJlEPbY
         Kf2nIfHtdcGdw4JkAiQ/ItYxxdVx+odfwzUrUSgGFuLaZBiEGnNYFFCNirGbDkxOkZUI
         YDhpokrtvNAGKBMKk1tRenR6c0pfxZejFRyCIRvyKZInR/SCm9WeCVnzNq/pkcLAHbTZ
         xpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L4jqqFTyVaEfw5oQOEDvCjggk+pjLmWqgC46xkeFBNE=;
        fh=vQ0urNc3k6xQe3yD0ZGzZcJ3g06W/veYbWtWoguyCWc=;
        b=J/A4a9mcYGiA0qGrAsPzzOZR9Q0Uzkx/Rr7yFEVmfckWDJwB6ZJvIG6hTvr+RhzjuT
         qm4rNH8ZYulmZuYjpIkn/XWCYIM8S6+9S7r3/MscAUYVOh7nsKpAl43Ymm4uSfTITSCw
         xY+Z+gpmYj1uwCo1z8oScAqY4oi0L6GlbK/q6x7trOXWP/LCTYzMkgKTSFOJ/UR++tU5
         tke+2FGfKtK7ToXQDF9JSnjFubaPEM8EFbXB8aGBlfBmg26uneyAYKZF249X69IJkxMa
         +8ANVAUhEsPUCY6b8QsFE60F5vX9kLBmuTdkpG4K1lTVw7FaKYnhQKxtboZItPgbTA9r
         ZZNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782317682; x=1782922482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L4jqqFTyVaEfw5oQOEDvCjggk+pjLmWqgC46xkeFBNE=;
        b=Ajk/R8Bo3wDQ2TaZg29+fjL5hpW54G5g0VyCDv458zHyYJzVP+04+UjxHKoUoF4TOn
         NoBhFvmoSLAeWlpSmFJzaavSJJn7vEZyUDPqWyxJuOkdUTTlDSd3eZg/kpodTVEPgmJh
         bLzKc0rCa0PKDpAF2GXIZDes/FM9SVZV+0lZgLA9AR8YpExc6davbBxRJSxJd3jtw9/e
         MjlAEWO4JErd4T2U22E1Nq1PTlHC2DrxoU6LaEJ07Nfn18jS/eb0FV1Knyk8YxF6n1f2
         G7NQjKCHtYqvSwqStpp/8TXGuiSX5opHA03S8aXGiM4QmixyFjNkxJE33G3+joCHwV5Q
         iz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782317682; x=1782922482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L4jqqFTyVaEfw5oQOEDvCjggk+pjLmWqgC46xkeFBNE=;
        b=cfv5SWA/KxtY9ICViZe+GeSL6ncGYCBXhUS4CVX5g72Pr92Rpvkjh3FbFktCToaJcU
         hN+bhyEBRtbJCK2h7l/y0miTuW9yO4ao5R4LcZaNfWR8ADCYaFB5od3XO1s070QRTTAC
         T6ML9FUQwV0kTce2F4rvsLH69QviItr6YnhJo1vMO321fV+TjRhPmwTWa/aEFjBkIZyx
         YuWBPjZcqn2cTArKR1MOkte9qa+bwQMOeYNJWozLf6yhD/3dg8s8eZd5hSLISJnQFAli
         2tomVWUfG0w3ot+1y/5FvTdgxgn2+sK2cJBCmI77TzhzFrkAyMAvDdUKXeNK/Rua/LLw
         GxUg==
X-Forwarded-Encrypted: i=1; AFNElJ+lDEtFAKiEYhDHd0Ou2/HefKwB53KeDa4GhjKqg17sNf14dZyPErlE+fc/EjU21VhFzS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgAvWx1oHRDbnK6aprZ/hq9Yh3me75EFgwBOOkTzjTCIoZUhKh
	2pBa8RkIOAwnOgzmm7En1rMw/1tEynD/lEP2MnnOiRBzOzs4rpJmmc869Ktfx4pBFAwq1G4nuJ1
	dVScpkD3FvCoAFLGUEU8PWydUEBzu/F6lAXQK/xC/
X-Gm-Gg: AfdE7cmG2WdSdHPDEFqmKuagkkvOtU+XC+buPeejvbdhWxo+zRq5rFkyZK+3OBY6wO+
	JM8Ym423GLINmMRq0lr6hetuZptIgA1XRyrRocdC5dsPgKh+fsMHGvKijSIu8qhBLY2OkYAO9wj
	LqeYwPPqAxgQv9rmSB+KVtxihYx3RFC0VDT2BnloDsjFJEDARUs9lgCaMAqCWBeRhi73tBh+rXU
	zPiQ4l8bNV6J/RiGXDp9IMia6xfAmJ+AU1Qi9aTJ8xfrqqLK4WxcaloWGBFqOdD+McVdfNedqm/
	ZLyrsyJmclInF3qxcTX2UKSkrms=
X-Received: by 2002:a05:622a:14:b0:519:df4f:6c93 with SMTP id
 d75a77b69052e-51a617dba42mr10324841cf.20.1782317681383; Wed, 24 Jun 2026
 09:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-6-31f31367d420@google.com> <20260622101056.4120C1F000E9@smtp.kernel.org>
 <DJFI4P57YE9X.20DPMTK9LL7LW@linux.dev> <ajm_dEqauYLBi-7T@google.com> <ajnTJ03IxVnBXWdp@google.com>
In-Reply-To: <ajnTJ03IxVnBXWdp@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Jun 2026 09:14:30 -0700
X-Gm-Features: AVVi8CfUZG4ru4sHeWtIPbsYQyBEOrJbLz3f3SZdi_mmHQdVijFR8buxYw7ygJ4
Message-ID: <CAJuCfpEUZ-xL7ebW21Q=5wXDFuJSeh52Ei-8YLsRUdXiB5NiYg@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] KVM: VMX: Use higher-level allocator
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	sashiko-reviews@lists.linux.dev, Brendan Jackman <jackmanb@google.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 5:29=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Mon, Jun 22, 2026 at 04:04:20PM -0700, Sean Christopherson wrote:
> > On Mon, Jun 22, 2026, Brendan Jackman wrote:
> > > On Mon Jun 22, 2026 at 10:10 AM UTC, sashiko-bot wrote:
> > > > Thank you for your contribution! Sashiko AI review found 1 potentia=
l issue(s) to consider:
> > > > - [Medium] The commit message incorrectly states that `__alloc_page=
s_node()` allows passing `NUMA_NO_NODE`, while the opposite is true.
> > > > --
> > > >
> > > > commit 7bd439c242125db27305b61b14c9972fb028282a
> > > > Author: Brendan Jackman <jackmanb@google.com>
> > > >
> > > > KVM: VMX: Use higher-level allocator
> >
> > While you're dealing with nits, can you massage the shortlog to somethi=
ng like:
> >
> >   KVM: VMX: Use no-underscores API when allocating pages for a specific=
 NUMA node
> >
> > "Use higher-level allocator" is extremely vague, and arguably misleadin=
g because
> > the "allocator" being used isn't changing.  Which is kinda the point: *=
nothing*
> > is changing in practice.
>
> Maybe "higher-level allocator API"?
>
> no-underscores is just.. meh :P

It's overall a good idea to add "No functional change intended" at the
end of the changelog in all these cleanup patches.

>
