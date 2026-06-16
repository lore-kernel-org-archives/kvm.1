Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3737CD31
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639809; cv=none; b=AEBEC7YKqB/QMe3hQfu1Ix2yrvPEG36eWxj/u8TY3EfgO/xPi/etz1SXRxPmZTjXAYMbNGYJzfkSbWr6UykIrwaq6gshfqKJSo+LNSJ96F1HUxbcNws/EN1Vdj4tHRQs2/ZMdEBCTxrtxYjj7sYO2csvpTQnHACr/7Zw2+QlTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639809; c=relaxed/simple;
	bh=fdECusmbQimqAO7FUbvxT4C+3cdeJ33l5jxcefbwdhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T97Ls7XpNBiV8/eoomLBSXtL3RC3RjidML2gMAi9qDM5NzH88QBKfsLQg5MsDnZhDJOqIh38B6aVYz9/nZhwI2ShAnZkG/2gPHyFonJFB5HvyrDO/CR1jk6llOqOOKVxYqL1AcK0WxEcQmY5FzBzUIFuz0dB5genYak5HrCSSp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYaBkXx4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYaBkXx4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA7A1F000E9
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 19:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781639807;
	bh=oGUW0Qza0yi05eQYzGeFSOktaWzJbU8RtLbmdGU9AHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CYaBkXx4ka1Hv0Aw0MUsBLD9ZUxucLwIVXWfIdZwm3Zm8TiaSVetTmkXKuX9Jq6Xo
	 sJ4/YL/rBKMPzVinLHuEmPlt/1kBmohJT8Q4EIAth+1kAn335UXPANrJqz+iNDlVMk
	 sGh841SqemqbQTK75UKHDwLY2z6vyEgzRxqf7jPA5E0uh8CVrdF3k/F0iTE9LGzgg1
	 G7+5IUWAyiGBuQibLj6vYzKFDfiD1IpKCAkUF/XNQ5xY/D3+Ov6i67+MlfR1045DL8
	 jCobD6z05cf9TxqWRywpwasU+SxOsUn+Y7PMJHo360KaQMVCbPvoGrbV4BBa0Mn1d/
	 jmucnFsSrLPnA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-beb2a97cc9aso940038166b.2
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 12:56:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9LEIvlXYcx8oJ2a/dzmcmxCj+BOmsdWl/sBcJq+6ScZmOdQJIOU0c1J+9UJ3at1os+eF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBI04hQuP561RIL2f39LatV16txm8tQ9Po1Mm+TWjJx/eVFM5m
	ZC6RW3yICejTQ7r/hYexlyFitcO0SDqbCzp4yk7vkh8IxNAMAKHyzacthIKFQPEFK3gZg2+QEmO
	pEjIrCvAvoT+CzaLA7LziXet37XfYP04=
X-Received: by 2002:a17:907:9617:b0:bec:52f4:28f3 with SMTP id
 a640c23a62f3a-c05a7ea5fcemr67816066b.44.1781639806780; Tue, 16 Jun 2026
 12:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-25-yosry@kernel.org> <20260616013031.53DAC1F000E9@smtp.kernel.org>
 <CAO9r8zPA6B72RDWeBMHqv1xz6o9dDHEEjwnMjwAwVwA=5qxaKg@mail.gmail.com>
 <CAO9r8zM1aKR6VzOhVq1_xTH5ZhSUBzYh-tr+ZzO_L4o28iy9OA@mail.gmail.com> <CALMp9eRS0EyqPqWZNkS0U=iH4mSt0snD44ufgXw7wvs9+o=a4A@mail.gmail.com>
In-Reply-To: <CALMp9eRS0EyqPqWZNkS0U=iH4mSt0snD44ufgXw7wvs9+o=a4A@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 16 Jun 2026 12:56:34 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOMJdzFvjtpyCYZnZWG-ddVtBqLUvbHr0ggA-58KSC7yQ@mail.gmail.com>
X-Gm-Features: AVVi8CfPC6Q5TfKId2ngb6QRnXcbE4Cx8JTEluFXYcPcyFsb3H6C-JSveRcPCT8
Message-ID: <CAO9r8zOMJdzFvjtpyCYZnZWG-ddVtBqLUvbHr0ggA-58KSC7yQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 24/25] KVM: nSVM: Use different ASIDs for L1 and L2
To: Jim Mattson <jmattson@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 12:54=E2=80=AFPM Jim Mattson <jmattson@google.com> =
wrote:
>
> On Tue, Jun 16, 2026 at 11:28=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> w=
rote:
> >
> > On Tue, Jun 16, 2026 at 11:14=E2=80=AFAM Yosry Ahmed <yosry@kernel.org>=
 wrote:
> > >
> > > [Omitting the previously reported issue]
> > >
> > > > > @@ -1557,6 +1550,8 @@ void svm_free_nested(struct vcpu_svm *svm)
> > > > >       if (WARN_ON_ONCE(svm->vmcb !=3D svm->vmcb01.ptr))
> > > > >               svm_switch_vmcb(svm, &svm->vmcb01);
> > > > >
> > > > > +     free_asid(svm->nested.asid02);
> > > > > +
> > > >
> > > > [Severity: Critical]
> > > > When the hardware ASID is freed here during nested SVM teardown, do=
es
> > > > svm->nested.last_asid also need to be reset to 0?
> > > >
> > > > If L1 disables SVM, svm_free_nested() is called, freeing asid02. Th=
is ASID tag
> > > > can then be reallocated. If L1 later re-enables SVM and uses the sa=
me L1-managed
> > > > ASID, nested_svm_entry_tlb_flush() will see:
> > >
> > > Hmm if L1 reuses the same ASID, it's up to L1 to explicitly flush it =
if needed.
> > >
> > > That being said, KVM needs to flush ASIDs when first allocated anyway=
,
> > > otherwise we risk reusing TLB entries from a completely different vCP=
U
> > > or VM. This series correctly does so for L1 (calls
> > > vmcb_set_flush_asid() when initializing vmcb01's ASID), but not for
> > > L2.
> > >
> > > So yes, we need to make sure asid02 is always initialized (and reset)
> > > to 0, but not for the reason Sashiko mentioned. It's so that the firs=
t
> > > nested VMRUN using an L2 ASID always does a flush (as L1 is not
> > > allowed to use ASID 0).
> >
> > I think VMX might have the same problem.
>
> This code *should* take care of it, since vmcs12->virtual_processor_id
> can't be 0 if it's being used, and vmx->nested_last_vpid is
> initialized to 0:
>
> > if (is_vmenter && vmcs12->virtual_processor_id !=3D vmx->nested.last_vp=
id) {
> >         vmx->nested.last_vpid =3D vmcs12->virtual_processor_id;
> >         kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
> >         return;
> > }
>
> However, Gemini points out that last_vpid is not cleared when L1 does
> a VMXOFF, even though vmx->nested.vpid02 is freed.
>
> Per the exhortation in security-bugs.rst, I am treating this issue as pub=
lic.

Yeah both last_vpid (and last_asid) should be reset to 0 when nested
is turned off (VMXOFF or clearing EFER.SVME), we should probably also
document that this is required to ensure a TLB flush on the first
usage of the ASID/VPID.
