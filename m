Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014403254B3
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995490; cv=none; b=UlrrWGFOFsA4r1hp/uwMtPVZgPk7jiRfw4PU1hsO0Py5PfzU5rfmYw7HkIR0hFcuoe6Ct7++LmN0zjqB8NziV172fD6L+ybNd0wBvpLrCiMd2lJ061xivR0sI6BJQUoTuUYVUYDjqmg21eSzta9J2/1BESSbE+GfDnlosqfa0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995490; c=relaxed/simple;
	bh=zyTEglQ01PQgkU28oBwSUJUPV5CdJLwxaLrIFr6Je8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBXUtvb2nYI1QfiYeKopWmIACbsymz2k6hzWFZ1U63IDJAarYtXOS4VXh53CVd5BIyGjiDQGH/ExbAKHzBekdV7XSe0waMSbvb6Dn4KUathlGz2Dx0mskkDYD7fBTGHVvpGy+mRAikOMkClKCFXXKp4LTB6HtURnXJVeXJcDNU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP+5sH6O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP+5sH6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38F51F00A3C
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 19:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779995488;
	bh=5Bjo954enTZ9usn/gTFi3fPweRVfq1xcFY2XXgrcQxI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DP+5sH6O8SFAaTS6uCiPJpQ+gly2hm3ie07+7gAiTbuEdDZqdhQv/o2//NLJUMF3V
	 7fyKQ20qyDBliehzajVDHyMgXRnV3xFitGl1t72eyMGSyIlPVBkKMWb18OWP/0O3Vq
	 mlPvL0N/syl3/A9bUA0XI+oFip8iUYPEMgIjxPyalzcbfh+98MlC33fKpRAtt3/HrG
	 tO7jGEzzCUKsckAOkeWjKXdRXEGsP+toKJc9bd7A9GK7s5Z2wCdu4+ullIlnEU6QK6
	 XAliWxIZ9+xA5gCeSrulgACdIcZCRPp7g3poE7b8lXDrP/0/QNQWWneIY+r/sxKyNs
	 OAJa0VCIqnshw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so21393365a12.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 12:11:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+9xrPs2AB8MLt7ayvP2XZcFqNgW/PiSAZuPcMLYHgqyjMGA8jMI703XNFcpFHpz7fPxK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrcU+Sstdxfd3UOlqj24vw9n3h0Mt+12B6/NzFJbgYQxAD5enw
	dMlAsIpX7r8UOrS2yjZXTlsM4Lq5jsjmNusi7QyLA/Kg1VlP9HPwp/zVtfLwVXMQ6k0Ra99F7tQ
	POc+RIFF1olei/KldQkgN6ucLv0Z6If8=
X-Received: by 2002:a17:907:d12:b0:baf:19a8:b44b with SMTP id
 a640c23a62f3a-be9738440b5mr34882466b.25.1779995487565; Thu, 28 May 2026
 12:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527180417.4119289-1-seanjc@google.com> <CAO9r8zNrz3U18hGOj9MAd46X-OHYzs9-QebH=D1TRp=wcHmk=A@mail.gmail.com>
 <CAO9r8zOLxAmtkGD0_pQdbikDR+jL2jaAgOY_nooyY+S_mOoo+Q@mail.gmail.com> <ahiSeDZibiaD7pOC@google.com>
In-Reply-To: <ahiSeDZibiaD7pOC@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 28 May 2026 12:11:16 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMXFmx3q-u0KbuQDXOW7=0QmKmQV0cp_vzU5GPPVG3sSg@mail.gmail.com>
X-Gm-Features: AVHnY4LtguZxEYI7jltiMd4gsiOaSGeoijdX6UofX-y_X6udEJnCPD0x_J7yLW0
Message-ID: <CAO9r8zMXFmx3q-u0KbuQDXOW7=0QmKmQV0cp_vzU5GPPVG3sSg@mail.gmail.com>
Subject: Re: [kvm-unit-tests GIT PULL] x86: random smattering of changes
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 12:07=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Wed, May 27, 2026, Yosry Ahmed wrote:
> > > > ----------------------------------------------------------------
> > > > Isaku Yamahata (2):
> > > >       x86: Replace NOP with CPUID after WRMSR(TSCDEADLINE) to seria=
lize deadline timer
> > > >       x86: tscdeadline_latency: Remove unnecessary nop
> > > >
> > > > Jim Mattson (1):
> > > >       x86: nVMX: Add retry loop to advanced RTM debugging subtest
> > > >
> > > > Kevin Cheng (2):
> > > >       x86/svm: Add missing svm intercepts
> > > >       x86/svm: Add unsupported instruction intercept test
> > >
> > > Any reason not to include this series:
> > > https://lore.kernel.org/kvm/20260312200308.3089379-1-chengkev@google.=
com/?
>
> I ran out of steam (and time), and I don't want to merge like this withou=
t a high
> level of confidence that it's the least awful option.

We're already doing this for vmx:
https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/blob/master/x86/vmx_test=
s.c?ref_type=3Dheads#L806.

If this is the only thing holding that series, I think cleaning it up
should be done separately for both VMX and SVM.

>
> +asm(
> +       "insn_sidt: sidt idt_descr;ret\n\t"
> +       "insn_sgdt: sgdt gdt_descr;ret\n\t"
> +       "insn_sldt: sldt %ax;ret\n\t"
> +       "insn_str: str %ax;ret\n\t"
> +       "insn_ltr: ltr %ax;ret\n\t"
> +       "insn_pushf: pushf;ret\n\t"
> +       "insn_popf: popf;ret\n\t"
> +       "insn_intn: int $0x22; vmmcall; ret\n\t"
> +       "insn_int_handler: iretq\n\t"
> +       "insn_stgi: stgi;ret\n\t"
> +       "insn_clgi: clgi;ret\n\t"
> +       "insn_rdtscp: rdtscp;ret\n\t"
> +       "insn_wbinvd: wbinvd;ret\n\t"
> +       "insn_lidt: lidt idt_descr;ret\n\t"
> +       "insn_lgdt: lgdt gdt_descr;ret\n\t"
> +       "insn_lldt: xor %eax, %eax; lldt %ax;ret\n\t"
> +       "insn_rdpmc: xor %ecx, %ecx; rdpmc;ret\n\t"
> +       "insn_cpuid: mov $10, %eax; cpuid;ret\n\t"
> +       "insn_invd: invd;ret\n\t"
> +       "insn_pause: pause;ret\n\t"
> +       "insn_hlt: hlt;ret\n\t"
> +       "insn_invlpg: invlpg 0x12345678;ret\n\t"
> +       "insn_rdtsc: rdtsc;ret\n\t"
> +       "insn_monitor: xor %eax, %eax; xor %ecx, %ecx; xor %edx, %edx; mo=
nitor;ret\n\t"
> +       "insn_mwait: xor %eax, %eax; xor %ecx, %ecx; mwait;ret\n\t"
> +       "insn_skinit: skinit;ret\n\t"
> +       "insn_icebp: .byte 0xf1; ret\n\t"
> +       "insn_xsetbv: mov $0, %ecx; xor %edx, %edx; xor %eax, %eax; xgetb=
v; xsetbv;ret\n\t"
> +       "insn_rdpru: xor %ecx, %ecx; .byte 0x0f,0x01,0xfd;ret\n\t"
> +);
> +
> +extern void insn_sidt(struct svm_test *test);
> +extern void insn_sgdt(struct svm_test *test);
> +extern void insn_sldt(struct svm_test *test);
> +extern void insn_str(struct svm_test *test);
> +extern void insn_ltr(struct svm_test *test);
> +extern void insn_pushf(struct svm_test *test);
> +extern void insn_popf(struct svm_test *test);
> +extern void insn_intn(struct svm_test *test);
> +extern void insn_int_handler(struct svm_test *test);
> +extern void insn_stgi(struct svm_test *test);
> +extern void insn_clgi(struct svm_test *test);
> +extern void insn_rdtscp(struct svm_test *test);
> +extern void insn_wbinvd(struct svm_test *test);
> +extern void insn_lidt(struct svm_test *test);
> +extern void insn_lgdt(struct svm_test *test);
> +extern void insn_lldt(struct svm_test *test);
> +extern void insn_rdpmc(struct svm_test *test);
> +extern void insn_cpuid(struct svm_test *test);
> +extern void insn_invd(struct svm_test *test);
> +extern void insn_pause(struct svm_test *test);
> +extern void insn_hlt(struct svm_test *test);
> +extern void insn_invlpg(struct svm_test *test);
> +extern void insn_rdtsc(struct svm_test *test);
> +extern void insn_monitor(struct svm_test *test);
> +extern void insn_mwait(struct svm_test *test);
> +extern void insn_skinit(struct svm_test *test);
> +extern void insn_icebp(struct svm_test *test);
> +extern void insn_xsetbv(struct svm_test *test);
> +extern void insn_rdpru(struct svm_test *test);
>
> > Also this (but less importantly):
> > https://lore.kernel.org/kvm/20260317225327.4068448-1-yosry@kernel.org/.
>
> Because I hate bumping the timeouts.  It's a losing game of whack-a-mole.=
  For
> now, it's easier to bury my head in the sand.

LOL
