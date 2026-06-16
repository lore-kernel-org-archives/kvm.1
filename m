Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD20D3CC324
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633700; cv=none; b=YKs1HVxEo875sHb47kiuefFh8UzaIwGcJoSROlsfU2el3PbvQ0f1OYQ38XSiqjWN4PetcF7Ixph2JntKa24BQjhQI5VBduYIyn00I1jpBUE5l+dhRZtEPzG5exGEk2JGxRwMpfsY7nfrSk4aQ8ImrDZE5KxSCbbrO03g68bvlKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633700; c=relaxed/simple;
	bh=n/Gt2XuOXaJx81x5N32Kh30SJJCzAFygkCGE2nCgIS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEB/ldU+IhDX0ugqJKbyf2rlNKTuEB12KgRRkMaeyxO/PHu8jXW4kOlKugGgBCrRmSaz92nMKofcTK7+e2rdDvf3dOT+X48sTKwI4ctR4HjUKhZqBW/qsZ0Zl1ils9Oxx9sqXKRXSbLrcRN2BGbfXbMNgaQZHPl3dMdBCAT9jks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIQrOclH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIQrOclH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC501F00A3A
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781633699;
	bh=8jPR+F2Ip/6UCCswQiyT4Uen1VcliE/f+lFy7tJr3Xc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RIQrOclHuSJv9XtLARn/b+WHceDefj//EweyFMTQqzmdRCVhlj8grUOb3Dy59fUp/
	 kJ/TpXKD5EonUOWyislKZe6C/7PFEv5t7xMM6CXHAwL4b9j+fdtsZPuz8Rylqqeand
	 aiW10e2JyW7M5OiH0UO6sYvHGCiYnnX7l6i8hD4fpAIyKaa5Ya/qzLFxtOXMu5fZN4
	 mhoJTBs/w/w3uR0Hw80+/JwCrmQsMoE2aaiBzq6zoDg5tGvk2H7uUnYrrEAYD+snDI
	 n1Gh7Pn9RqId6yfEhVq3OIPDTCbJnKESEtedtwo58ZqYJPehUMbq+mYiNahl4t5R9t
	 C1JEFkxIX86LA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-beb2a97cc9aso924322466b.2
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 11:14:59 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz9f8VzfqvOFknX0wcNTm3k/AXCXPu19DcXv/6LqLsHWwabBzdd
	3ofJ9JZmTf4EGTYB8/kS1OCBLUuBZNLsNDDXNwfKLeQD1Vmzwzlw7zI6Xyj5DEl4oHhlMYM13Fa
	mVI2b8pKROLhqu3uI/7+4MbX2fP2T4sI=
X-Received: by 2002:a17:907:75e8:b0:bed:fc51:cbbd with SMTP id
 a640c23a62f3a-c05a75aa3fcmr39100366b.30.1781633698459; Tue, 16 Jun 2026
 11:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-25-yosry@kernel.org> <20260616013031.53DAC1F000E9@smtp.kernel.org>
In-Reply-To: <20260616013031.53DAC1F000E9@smtp.kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 16 Jun 2026 11:14:46 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPA6B72RDWeBMHqv1xz6o9dDHEEjwnMjwAwVwA=5qxaKg@mail.gmail.com>
X-Gm-Features: AVVi8CdG6D_XBhyqL1hBVvuUH2LsKhy_eesT-Lo_K2hwaNXKiQRhyVMrzrqStBM
Message-ID: <CAO9r8zPA6B72RDWeBMHqv1xz6o9dDHEEjwnMjwAwVwA=5qxaKg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 24/25] KVM: nSVM: Use different ASIDs for L1 and L2
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Omitting the previously reported issue]

> > @@ -1557,6 +1550,8 @@ void svm_free_nested(struct vcpu_svm *svm)
> >       if (WARN_ON_ONCE(svm->vmcb !=3D svm->vmcb01.ptr))
> >               svm_switch_vmcb(svm, &svm->vmcb01);
> >
> > +     free_asid(svm->nested.asid02);
> > +
>
> [Severity: Critical]
> When the hardware ASID is freed here during nested SVM teardown, does
> svm->nested.last_asid also need to be reset to 0?
>
> If L1 disables SVM, svm_free_nested() is called, freeing asid02. This ASI=
D tag
> can then be reallocated. If L1 later re-enables SVM and uses the same L1-=
managed
> ASID, nested_svm_entry_tlb_flush() will see:

Hmm if L1 reuses the same ASID, it's up to L1 to explicitly flush it if nee=
ded.

That being said, KVM needs to flush ASIDs when first allocated anyway,
otherwise we risk reusing TLB entries from a completely different vCPU
or VM. This series correctly does so for L1 (calls
vmcb_set_flush_asid() when initializing vmcb01's ASID), but not for
L2.

So yes, we need to make sure asid02 is always initialized (and reset)
to 0, but not for the reason Sashiko mentioned. It's so that the first
nested VMRUN using an L2 ASID always does a flush (as L1 is not
allowed to use ASID 0).

>
> nested_svm_entry_tlb_flush() {
>     ...
>     if (svm->nested.ctl.asid !=3D svm->nested.last_asid) {
>         svm->nested.last_asid =3D svm->nested.ctl.asid;
>         new_asid =3D true;
>     }
>     ...
> }
>
> This check would fail to set new_asid =3D true. Since this patch removes =
the
> unconditional TLB flush on nested entry, would this regression allow the =
L2
> guest to run with stale TLB entries from the previous owner of the reallo=
cated
> hardware ASID?
>
> >       svm_vcpu_free_msrpm(svm->nested.msrpm);
> >       svm->nested.msrpm =3D NULL;
> >
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616004155.14=
35766-1-yosry@kernel.org?part=3D24
