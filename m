Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136A19D8BC
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198608; cv=none; b=KYV0pPY71hK+8EBobysqgDweelbYyZ/g04L0FQp7gh39o2MgLTJZzqSWj+bQ1ohG5QFIlaxdTUdXzZWZ3S1IVuJPWdvhktEDrt9k58om4TCqT3ZARhQvjhJIfj2gHi0LPisUkfHmsw1cRCX39izW0vAdiFYfQG0VGzc0qR1Mia0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198608; c=relaxed/simple;
	bh=wA1BoqjYaaixH548+AR+9SISsUtb4p6xmrtcnIlDEuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOaTwTMSpppspVo18fmtQkAH4HCxeOijfzd0kFZeJoQvv+6N7kzSlNFeItszkGmRkvH04c6L1yWbTu/PVYCAf/f6oBI2kITf6e+Bsl6qMh0Y4bPa1rNcbBoq4cdDqsr57K0JtbK43LehhchkJeOkDXeQQpy/26FVeglBswW3xVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RP+iISKU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RP+iISKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DA71F000E9
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198607;
	bh=x0q1Ph/Yp4ZJIoFFIv+J0F7VP+1tona2KKai49zosks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RP+iISKUP6KYAVZ53B4vHtVLYt3HRFpwX3j2mYjwcL0v5eDZOP+tiKcoVKcz3OWxU
	 w4HHSdeDHHtqYVki+KCN3mJ+efXNWe6BrUxu96pantcQyOHUQ1ngLIxajw7S9pHMgD
	 cUoHxcVUP6rDL849zw7C0oDjq+ab4cEMMYI/5jzY/SqdnfXV3dOFaqD51Dl6R5magr
	 CuY2gnHIrEhDAZNlaMrJJbe2JGVeDXiDIHkitUAgNa3ajWiqfDDttrcT5LcWIoNYe/
	 hIWiCcH7MU9e+3QWdMZOHR/0sHSJeKvHt0roUOygxSEfp+WvApmckFLR/ran6bHPbb
	 mrVTTN6Q/kDtQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15cd3fd760so346108866b.2
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:30:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YzlfDycKHzFLuQDEpuEj0VVkp4j4MNImyh2wq+T8zRN9AKjk79V
	BWhOQcbjXV1meH0QeZnYZ9v/7aRP0NjaGdyvNogQ36N+F6T7PAf2uwwDncYHoleF9q8v7uqvwFt
	hVCPaFUs/Av82/g1STXlYpAcMFIjtPro=
X-Received: by 2002:a17:907:980f:b0:c15:df42:952c with SMTP id
 a640c23a62f3a-c1f721720ebmr4546566b.28.1785198606390; Mon, 27 Jul 2026
 17:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727235228.1007324-1-yosry@kernel.org> <20260727235228.1007324-3-yosry@kernel.org>
 <20260728000733.987911F000E9@smtp.kernel.org>
In-Reply-To: <20260728000733.987911F000E9@smtp.kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Jul 2026 17:29:54 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNYSxvQDQmvvCiu373yMn5W-tsX6Y6Jqeyb3m041xo8Dg@mail.gmail.com>
X-Gm-Features: AUfX_my2CdgM9Wrr6tQLY64RgnIY9mPtSW_i98X72n9k1SSCN6bV1mYT8FoGzfQ
Message-ID: <CAO9r8zNYSxvQDQmvvCiu373yMn5W-tsX6Y6Jqeyb3m041xo8Dg@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] KVM: selftests: Fix RAX and RFLAGS VMCB offsets
 when running L2
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:07=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The hardcoded offsets in `LOAD_GPR_C` and `SAVE_GPR_C` are misal=
igned with `struct gpr64_regs` by 8 bytes, causing out-of-bounds memory cor=
ruption and shifting L1/L2 registers to incorrect offsets.
> --
>
> --- Patch [2]: [PATCH v4 02/12] KVM: selftests: Fix RAX and RFLAGS VMCB o=
ffsets when running L2 ---
> commit 828b231275dca6c618d4ec1f5e43abd20a4b5e54
> Author: Yosry Ahmed <yosry@kernel.org>
>
> KVM: selftests: Fix RAX and RFLAGS VMCB offsets when running L2
>
> This commit fixes incorrect vmcb_save_area offsets by using vmcb->save.ra=
x
> and vmcb->save.rflags as parameters to the assembly block. This avoids
> hardcoding offsets completely and also directly uses guest_regs.rax inste=
ad
> of assuming it is at offset 0.
>
> Link: https://lore.kernel.org/all/20260521092311.86030-1-pbonzini@redhat.=
com/
> Closes: https://sashiko.dev/#/patchset/20260518202514.2037078-1-yosry%40k=
ernel.org?part=3D1
>
> > diff --git a/tools/testing/selftests/kvm/lib/x86/svm.c b/tools/testing/=
selftests/kvm/lib/x86/svm.c
> > index 1445b890986fd..766d15f1d534a 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/svm.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/svm.c
> > @@ -164,19 +164,22 @@ void run_guest(struct vmcb *vmcb, u64 vmcb_gpa)
> >  {
> >       asm volatile (
> >               "vmload %[vmcb_gpa]\n\t"
> > -             "mov rflags, %%r15\n\t" // rflags
> > -             "mov %%r15, 0x170(%[vmcb])\n\t"
> > -             "mov guest_regs, %%r15\n\t"     // rax
> > -             "mov %%r15, 0x1f8(%[vmcb])\n\t"
> > +             "mov rflags, %%r15\n\t"
> > +             "mov %%r15, %[vmcb_rflags]\n\t"
> > +             "mov %[guest_regs_rax], %%r15\n\t"
> > +             "mov %%r15, %[vmcb_rax]\n\t"
> >               LOAD_GPR_C
> >               "vmrun %[vmcb_gpa]\n\t"
> >               SAVE_GPR_C
>
> [Severity: High]
> This isn't a bug introduced by this patch, but do the hardcoded memory
> offsets in LOAD_GPR_C and SAVE_GPR_C cause an out-of-bounds memory access=
?

Yes, this is fixed in following patches.
