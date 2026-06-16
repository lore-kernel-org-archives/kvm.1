Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6D39D6E7
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781646566; cv=none; b=CnhC6wYkOtfw+ho2MSjVXBkLl+ceQTs9NRc6JwXmeqxJ6i7BrdNJOiYdHzxQ5AzuVmetMPg3Hlm+woWlC4eUC3PmWLF8JfjP+q7wykyEsB4770P5wb4z/I/Ob0M4cpaCKq+843U2Im8aIxe98zLDdY1xpEy1ixzrwVpaSf8oC3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781646566; c=relaxed/simple;
	bh=D49o0GGOZ6ABp0SoVuFYM02Euiv4ld3iCUfaUgxIv0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Am2enJ+lulczduue9TWWEWxYMCB/+s6yLUT351z6YpyjRST/VFI9JBrFqLQsn31M8Op/4cqnMaSliP0I4+Q6d6WZdRouSHqYQ9Tf1r/N2ibFR6aY6KwIxHRQiY03d1KM8fOs2aN9afwDJGo6LJX5T64k9RFTPVlLk5Sm2uAXHrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEJd7B64; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEJd7B64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A2C1F00A3D
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 21:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781646565;
	bh=5mhjG6CO3XMv9T4m+wpz6MkRZthJ0LsGs+Tm06Z2gnE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SEJd7B64GPuOstPEkQ18Pckwk8PnlIivXBb8COu+U03IBbQyEhLZwdQpJNYiIslJF
	 b30Z+sPi9bHiUxCbXBPJAi7njg35jtQvfgYR3Kgyf3n/wkOHgSFBsVgOgw1rncQGH1
	 NuOvrKNn8DgN+Gd66G7IE3bNLGHe4Hz1HB1yNKjvITJ0ew0Sn0PaK0m9DiP1YjW3wj
	 TGKro/6yp2w7R4mdSF6eBEqGjkpNRW7MRSCOqrRBPUK5odpOI/eZ6PcBd1MQKPamff
	 QtPU6JIxdnYB9jPbUpJHbFEITdFVSI1vj+X5ml/52ETIZkfd6Gi/GnAHn3CzcY8TMC
	 aOg2ZJxh/1I3Q==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bec3ffb95dbso744914466b.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 14:49:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/XjAuVQJxytxEqI1IrXfay3VtHeEHU4ipJWVIKQLMYEO1XwkhMcgkvLvXjn2JHLhDZt84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdwWKIXLdxnn66HGfnXs9R/fxLtSrQMBTLo2E3K+0qM4Ogjetr
	VMflR33KdeZ0tcNRKemKqfpwm/XwdULlx/iUZZwc//uIUtFKyetQypK892I0VbZqUi335zPyHfs
	Zqg6TtrgDUeC+DS2JtFoHJiHihjMMv+k=
X-Received: by 2002:a17:907:842:b0:bee:e2a2:bdbf with SMTP id
 a640c23a62f3a-c05a85a5c91mr88402066b.29.1781646564445; Tue, 16 Jun 2026
 14:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-25-yosry@kernel.org> <20260616013031.53DAC1F000E9@smtp.kernel.org>
 <CAO9r8zPA6B72RDWeBMHqv1xz6o9dDHEEjwnMjwAwVwA=5qxaKg@mail.gmail.com>
 <CAO9r8zM1aKR6VzOhVq1_xTH5ZhSUBzYh-tr+ZzO_L4o28iy9OA@mail.gmail.com>
 <CALMp9eRS0EyqPqWZNkS0U=iH4mSt0snD44ufgXw7wvs9+o=a4A@mail.gmail.com> <CAO9r8zOMJdzFvjtpyCYZnZWG-ddVtBqLUvbHr0ggA-58KSC7yQ@mail.gmail.com>
In-Reply-To: <CAO9r8zOMJdzFvjtpyCYZnZWG-ddVtBqLUvbHr0ggA-58KSC7yQ@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 16 Jun 2026 14:49:13 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOAESL=K1GooASNvZw-Ty+02X3LivQx46ESC9++c6EhEA@mail.gmail.com>
X-Gm-Features: AVVi8CfK7_xi350BthhiyWW7okttCK3V7MWNRz_I1x-uTKT92HEmp2sBShXDzR4
Message-ID: <CAO9r8zOAESL=K1GooASNvZw-Ty+02X3LivQx46ESC9++c6EhEA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 24/25] KVM: nSVM: Use different ASIDs for L1 and L2
To: Jim Mattson <jmattson@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 12:56=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Tue, Jun 16, 2026 at 12:54=E2=80=AFPM Jim Mattson <jmattson@google.com=
> wrote:
> >
> > On Tue, Jun 16, 2026 at 11:28=E2=80=AFAM Yosry Ahmed <yosry@kernel.org>=
 wrote:
> > >
> > > On Tue, Jun 16, 2026 at 11:14=E2=80=AFAM Yosry Ahmed <yosry@kernel.or=
g> wrote:
> > > >
> > > > [Omitting the previously reported issue]
> > > >
> > > > > > @@ -1557,6 +1550,8 @@ void svm_free_nested(struct vcpu_svm *svm=
)
> > > > > >       if (WARN_ON_ONCE(svm->vmcb !=3D svm->vmcb01.ptr))
> > > > > >               svm_switch_vmcb(svm, &svm->vmcb01);
> > > > > >
> > > > > > +     free_asid(svm->nested.asid02);
> > > > > > +
> > > > >
> > > > > [Severity: Critical]
> > > > > When the hardware ASID is freed here during nested SVM teardown, =
does
> > > > > svm->nested.last_asid also need to be reset to 0?
> > > > >
> > > > > If L1 disables SVM, svm_free_nested() is called, freeing asid02. =
This ASID tag
> > > > > can then be reallocated. If L1 later re-enables SVM and uses the =
same L1-managed
> > > > > ASID, nested_svm_entry_tlb_flush() will see:
> > > >
> > > > Hmm if L1 reuses the same ASID, it's up to L1 to explicitly flush i=
t if needed.
> > > >
> > > > That being said, KVM needs to flush ASIDs when first allocated anyw=
ay,
> > > > otherwise we risk reusing TLB entries from a completely different v=
CPU
> > > > or VM. This series correctly does so for L1 (calls
> > > > vmcb_set_flush_asid() when initializing vmcb01's ASID), but not for
> > > > L2.
> > > >
> > > > So yes, we need to make sure asid02 is always initialized (and rese=
t)
> > > > to 0, but not for the reason Sashiko mentioned. It's so that the fi=
rst
> > > > nested VMRUN using an L2 ASID always does a flush (as L1 is not
> > > > allowed to use ASID 0).
> > >
> > > I think VMX might have the same problem.
> >
> > This code *should* take care of it, since vmcs12->virtual_processor_id
> > can't be 0 if it's being used, and vmx->nested_last_vpid is
> > initialized to 0:
> >
> > > if (is_vmenter && vmcs12->virtual_processor_id !=3D vmx->nested.last_=
vpid) {
> > >         vmx->nested.last_vpid =3D vmcs12->virtual_processor_id;
> > >         kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
> > >         return;
> > > }
> >
> > However, Gemini points out that last_vpid is not cleared when L1 does
> > a VMXOFF, even though vmx->nested.vpid02 is freed.
> >
> > Per the exhortation in security-bugs.rst, I am treating this issue as p=
ublic.
>
> Yeah both last_vpid (and last_asid) should be reset to 0 when nested
> is turned off (VMXOFF or clearing EFER.SVME), we should probably also
> document that this is required to ensure a TLB flush on the first
> usage of the ASID/VPID.

I tried reproducing the problem by running an L2, killing it, removing
and re-adding KVM in L1, then running an L2 with another kernel (i.e.
different kernel addresses). That didn't cause any problems.
Nonetheless, I think the fix is correct (famous last words). I sent it
out (with another TLB flush bug in nVMX):
https://lore.kernel.org/kvm/20260616214652.2157032-1-yosry@kernel.org/.
