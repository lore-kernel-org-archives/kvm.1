Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1246B466B5E
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633812; cv=none; b=bwAxAIVWbAe2+buR5SzOQDYD/ov0dIvnzGEr1tUNKlvbmoFJD3Fx9iBDUIfKvvaTjrqxYDdLXFdBWQUxXwFcaMZM7JO/P3aeRrU5+f8bDMOT5WPQ4V/GXKkm1evz6Sz2xDHJ93h0YQDzDaUsm1za6oP1l2xzAYY4ZtgZLDF97vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633812; c=relaxed/simple;
	bh=NmpYvmp6cwxFHn3mg6u1fb6FA3N2hxqBeQIzCnLivYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixKBjabHz7kEaMibnoRdj+3KL0wu14uksYbD6TPZoqC06F8VrvrEXz62kWwLJISQ4eUeSa36qanGdyr+29d+/hv48/0kGi09QDDp6G2IvOENxViztrMLf8ZmY1F3DYU5bCB5WfFVN+OsHDa4YIXi7uib2Uox22rpHG4X7JX//wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5mUDVe6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5mUDVe6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4C61F000E9
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781633808;
	bh=uYZjBFBZyt8jiCkJQvne5/0yuISJdA32kXbGUb9705I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=V5mUDVe6Q2N01xUWyMl23IfxNfnRqhsDvVepLuiWpU6kQsixqK1cdY9tUMxLD6r1x
	 ZfYszjzDO00URyZLw52zwtDduoeQFOoi7AOamk2DxuGP8KvvROD0POV6KR9PHUuIms
	 MtEOcR1KncH6dARCpzVnO3voIBtgKzKtGUBUVIhf+mpoMYOuHZLDfBHt/DBIEWzpgh
	 1GrkExwOMLSCJ4O9+l9abeH0SlhKztJasYtIq5kUeib6SQlTULtF51cIQaEEL5uODN
	 xm/+Fzx+7HL8JhQWYWoNq5owLR2C06hCjueFZjxk4kZUtVCAXbQuTuwo1+7GMRhAp7
	 TORNxcFZM116g==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bf1cdcfd6deso595373066b.3
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 11:16:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YxK6sGV2Xggod9Em+TbsW0CwI0J5pVX+o5VOVKAxqEXPJo+8hlj
	PKuhVR+T9dk/SWFiAPVbdiIoAbALZfBC/IAC+RZIj11v/hYlBeum0pX6fsfAMNnMz4TPisT1WxK
	+VVNVn7bQHqHhw1BG1PXD7ieAdg2o3Ew=
X-Received: by 2002:a17:907:934e:b0:bd6:4d8c:bbff with SMTP id
 a640c23a62f3a-c05a5414006mr53106166b.22.1781633807830; Tue, 16 Jun 2026
 11:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-25-yosry@kernel.org> <20260616013031.53DAC1F000E9@smtp.kernel.org>
 <CAO9r8zPA6B72RDWeBMHqv1xz6o9dDHEEjwnMjwAwVwA=5qxaKg@mail.gmail.com>
In-Reply-To: <CAO9r8zPA6B72RDWeBMHqv1xz6o9dDHEEjwnMjwAwVwA=5qxaKg@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 16 Jun 2026 11:16:36 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNzWTbt8j1s7uU8zGGaw1Qy6zuYTrBTbgthHBB6Lvso0A@mail.gmail.com>
X-Gm-Features: AVVi8CdYSl4SsTmo3Sy5DNpk3bRvzkRhKdmW2YBJM4D8KI5kKw2GYH4nijrSDN0
Message-ID: <CAO9r8zNzWTbt8j1s7uU8zGGaw1Qy6zuYTrBTbgthHBB6Lvso0A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 24/25] KVM: nSVM: Use different ASIDs for L1 and L2
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 11:14=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> [Omitting the previously reported issue]
>
> > > @@ -1557,6 +1550,8 @@ void svm_free_nested(struct vcpu_svm *svm)
> > >       if (WARN_ON_ONCE(svm->vmcb !=3D svm->vmcb01.ptr))
> > >               svm_switch_vmcb(svm, &svm->vmcb01);
> > >
> > > +     free_asid(svm->nested.asid02);
> > > +
> >
> > [Severity: Critical]
> > When the hardware ASID is freed here during nested SVM teardown, does
> > svm->nested.last_asid also need to be reset to 0?
> >
> > If L1 disables SVM, svm_free_nested() is called, freeing asid02. This A=
SID tag
> > can then be reallocated. If L1 later re-enables SVM and uses the same L=
1-managed
> > ASID, nested_svm_entry_tlb_flush() will see:
>
> Hmm if L1 reuses the same ASID, it's up to L1 to explicitly flush it if n=
eeded.
>
> That being said, KVM needs to flush ASIDs when first allocated anyway,
> otherwise we risk reusing TLB entries from a completely different vCPU
> or VM. This series correctly does so for L1 (calls
> vmcb_set_flush_asid() when initializing vmcb01's ASID), but not for
> L2.
>
> So yes, we need to make sure asid02 is always initialized (and reset)

last_asid* not asid02.

> to 0, but not for the reason Sashiko mentioned. It's so that the first
> nested VMRUN using an L2 ASID always does a flush (as L1 is not
> allowed to use ASID 0).
