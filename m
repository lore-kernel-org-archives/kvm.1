Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6033AD9B
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 23:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863700; cv=none; b=suaqPgIsc0MDhDV1cz5JfM3B4ynZsQFbATK/lItMYcMRa8D8cJ5pK7+EG+WQ7yQ6P9kEm6YXNEO84AgUCzOzisUKeV2acoF8K9OAT4YMN/DdYQA04lzNq+DUXoFMhzBKb3w29xv/b6H4K99r/iawVvnLqqGpxXdUBo9ia8N1PSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863700; c=relaxed/simple;
	bh=INUaSPGUw+qOCoVDyWM1gYtP3pSnnmG9DGgN5vlnF4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suXxfZ9jmZfjpfil16WfNlHetpUFkBItXccCqY9pP7r4loUbEHXD315b7/nIpHV6sJCvylxUDCC7Oiuqoo8Qn84opn4oyY1NPOfU6U6XjwylAvYqUS001gRbMMLFLfaKFtdpU4hSIJq4oqF5u5BGVd00Uw9rDqPWXgZ+YExmUtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbFzKxSH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbFzKxSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C2B1F000E9
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 23:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863698;
	bh=ZGnUQC91ekw9WU1VjD+6q7/VQm2twK3AfYxisJxTqaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UbFzKxSHfrHJ/Z6Q4v3LbCjwKs5swtaINXgwD/sXPYq4zbO6Nl8tji7BdDZUZiuDM
	 1isu6yF24I2FsP6ZOL0mAnUFzC2iEWcqlcXOerdxXdxsbEIzWv5+1fm4YLYvFdP2Yu
	 Pt2q3wpLEmV6j18SXXKRxDgC29Y+zdQfgPs5B065tfhcfa2iGCF1A4yg3mEWJeY7gC
	 e11v1Yhll4Se9WwAXxbo/1Yxr8SNlilFJ+LIYNNESIUk9tCuMPoXA1hLss9wCkx6ZR
	 ivBOsNvQgBf+xTi7WIw+U0T/e2IRxGoQBHY/k8sjBzGSbeHcjq0+VueckyFBZqmkUG
	 lDTmOV6/epftA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c12614b81c9so15776866b.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 16:54:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YzfHERl4TpoXh2wjpG03cy82x7Ycs+2kQH/oVQBWLVqOvFNkgsy
	/ZnHvt9o8ZEHaS7ZW2t1hh1s9f/QGClETSTVWXcIXFo9twa/aJnDsZbeDMBIwZ/SkyXvA6b+5Zr
	HOIJqm2k9VDwRzNvnVAu6z4G90Awlna4=
X-Received: by 2002:a17:906:3190:b0:c12:660f:e359 with SMTP id
 a640c23a62f3a-c1298247202mr90770166b.62.1782863697921; Tue, 30 Jun 2026
 16:54:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630234716.3039031-1-yosry@kernel.org> <20260630234716.3039031-6-yosry@kernel.org>
 <20260630235208.0FEBD1F000E9@smtp.kernel.org>
In-Reply-To: <20260630235208.0FEBD1F000E9@smtp.kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 30 Jun 2026 16:54:46 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOBQxSNO==og6b1kX6WLYVimHrTs9owy8UrttpSs2pyaA@mail.gmail.com>
X-Gm-Features: AVVi8CcmFBHLD5bdVYKW4sPv5z6NqNUNm7AR9GALFQ3ryZEKGgpIBVjTs35Xn4o
Message-ID: <CAO9r8zOBQxSNO==og6b1kX6WLYVimHrTs9owy8UrttpSs2pyaA@mail.gmail.com>
Subject: Re: [PATCH 5/7] KVM: x86: Reverse the polarity of efer_reserved_bits
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 4:52=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Incorrect bitwise logic in EFER validation rejects valid zero va=
lues (breaking guest boot) and allows guests to set reserved bits (triggeri=
ng VMENTRY failures).
> --
>
> commit 4bd740e43933efd5aaca18b2bd83e1696dbbd7dd
> Author: Yosry Ahmed <yosry@kernel.org>
>
> KVM: x86: Reverse the polarity of efer_reserved_bits
>
> This commit reverses the polarity of the EFER validation variable, renami=
ng
> efer_reserved_bits to efer_supported_bits to align with other fields in
> kvm_caps. The stated intent is that no functional change is introduced.
>
> > diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> > index 17d4c813a9e8a..b9a16a27f6c23 100644
> > --- a/arch/x86/kvm/msrs.c
> > +++ b/arch/x86/kvm/msrs.c
>
> [ ... ]
>
> > @@ -606,7 +606,7 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu,=
 u64 efer)
> >  }
> >  bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
> >  {
> > -     if (efer & efer_reserved_bits)
> > +     if (!(efer & efer_supported_bits))
>
> [Severity: High]
> Does this bitwise logic inadvertently reject valid zero values and allow
> guests to set reserved bits?
>
> If a guest writes 0 to the EFER MSR, (efer & efer_supported_bits) evaluat=
es
> to 0, and the negation makes this condition true, improperly rejecting it=
.
>
> Additionally, if a guest writes an EFER value containing both a supported
> bit and a reserved bit, the condition evaluates to false, allowing the
> reserved bit to be set.
>
> Should this check instead be (efer & ~efer_supported_bits)?

Yes, I completely screwed this up :)

The tests don't fail because we only have tests for SREGS setting EFER
(added in this series), and __kvm_valid_efer() still properly catches
invalid bits for this path (because KVM caps =3D=3D guest caps).
