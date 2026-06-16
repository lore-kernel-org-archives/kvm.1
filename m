Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6911747AF5D
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634522; cv=none; b=bVI2mZVXOhJvZDtXbaGOnsHzFcoyaePNKeyT5JT0uaAaVP5LezpapjpzcOXi3FZtv0mbAm86MAQtjGckBKum4aazEKpwOqYthoS4b7vo92BWpgDxboqIkp0vaXGAVx8lZeVs7g4/iHIq806ZwskviSMYhtap/aOFHFL5Iw3NaPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634522; c=relaxed/simple;
	bh=/IPWvzWE3mBCQO6eVjzmENBoluGWTRJrVfjEUnbHEGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/3gDElieAVrPbz8DfI0XDBn1weFdMWm8zezTG18xz1zGSFk/3kqAN9kdnvcZioOJ2BozFD/dUuKBo6NQLYXHFVFmwLBxAW5PO/K/O3KfqYPZ86+Y3sbZv4UCIqMGta5QsWI53+hg5FKxel33jMUA/e3PfU5zfWiTnCC0Ncmk/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdTfv/sG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdTfv/sG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289501F00A3D
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781634520;
	bh=AMEMq1m5LZROrTM6KasbbQmcYxkBva6ZQOd5Fe0JbjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FdTfv/sGLQVkQ/grL7uNBEYTSaloaksPs6kmJknRJU3wgEFibLQ895plYvzK3oQ+u
	 veJWOnzY5j/pJrsBW/V+K3zXuPSf0bZD+P7Y91qMj3gtyNO7smnr3VmCMeW1MKCeH2
	 ZVBNSwsa4CaDOLF42h5BTaopkcEHrUY/8oyXUi1ZN/Z7zJOl5tHPM91vZbzpHmOMfX
	 MIqFSm5tiBCm1BnAT9Ncg1eCDW9fzoDVt7ZZH8kL7lb2eJ2IEjXFqawoQAr8OErHJG
	 Sah5zk+DQmv9say628xYin/wdptBisUiBtQ5SANpyPa4esWCisSTx8bl2eq5qQhEtc
	 bDsWAVN1woSEw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so8022483a12.3
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 11:28:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YzqFVVFT/Tn+7zt+YOF1lS2XAtd6UHbDIS1QDCa24JpC6jtqWYM
	M54aG/tGnoME6aIg7lAy2UUq3GzxozbOKXzyeFljblNlhNPkO+jqo6Rd8Sz6ctkFPtD9Va8VF96
	0mtoPWnLxasJq6FNz7+L6gWmCrteQj1w=
X-Received: by 2002:a17:907:9805:b0:bfe:ed06:5a16 with SMTP id
 a640c23a62f3a-c05a7bb59c7mr51253466b.52.1781634519151; Tue, 16 Jun 2026
 11:28:39 -0700 (PDT)
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
Date: Tue, 16 Jun 2026 11:28:27 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM1aKR6VzOhVq1_xTH5ZhSUBzYh-tr+ZzO_L4o28iy9OA@mail.gmail.com>
X-Gm-Features: AVVi8CdLfKDfFBG-2pNNqpgYhvG4dfI1iIxMmXI9SuNwPIRKQo6WeFsIst67xuc
Message-ID: <CAO9r8zM1aKR6VzOhVq1_xTH5ZhSUBzYh-tr+ZzO_L4o28iy9OA@mail.gmail.com>
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
> to 0, but not for the reason Sashiko mentioned. It's so that the first
> nested VMRUN using an L2 ASID always does a flush (as L1 is not
> allowed to use ASID 0).

I think VMX might have the same problem.
