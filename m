Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E281B4138
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783968655; cv=none; b=qRvfJ/0tk0b8NpRlRk5V4cV1FrY/CrnL3oO8AwTTTUwW3SjnK/96S18FyZbYkzh17+nBsA3exA9c27ddZVHu88o1jxAK5yvKu+B33yzjaZ8KK4LhyxaAJil7X3NYT+elQhO0zfM1uyPDpDXT2KOguX1EpaCGuEOa2fv3bw7FBv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783968655; c=relaxed/simple;
	bh=lCiBYyieZZ8S9qHdh2XkEQSXncYR3z+XsnzKSadTwLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVNIT1LUXauCDnM9G6DQxbHnX8WoX+p7+BtFHqdu8uQvoMv4BIidyEPBlCGmgAeX6lXIjTeHqAjjb2p+xrB6y1Boofll7oHG6/foC91sewOdv03kgMn+biqKlabsne8985wfoe1osMiaWxyMUH2zK1lamixWqDQscK7i6JMnm+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7Xfg6VP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7Xfg6VP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A951F000E9
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783968654;
	bh=+bZ31BFKiT5ZnHZNGrubQMqqnbYhvjVA9oboBrjq8rg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=N7Xfg6VP1xx0pFx+n3ZoYPTZu1CnvsBpbZaAFbe0DfyLf0xew+qjrQ1rDVgNuuhEc
	 k2rzSKskUOhNWFhFm6i0orAchmMGJiowU4gVrma+ysrMJ3RqfaGIzQKQ/DA3LnXB6H
	 eVbJMz42Kd/8hrKThvuP8uZe1GbVIE7qgNgzL9+xfCZ8S8kqXjIVB0Y7lp+F+gP/ZA
	 /t+uaeGocGTz2jcYYT039rBEX8rgc7pCnqzCjCiksOc4+HlbwpzPuo4aiJOxgEC4lc
	 S4knUoK2uDgqLFQtRo5VUuC0o+ZCYQO5iOWCwgENlwlQS89hM7NUAAMDF/XNufzO92
	 6S6qw2wfuXMnw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15ba5b151dso30743166b.3
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:50:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YxoOiuqnCaG7ek2pVuYkMUAmAdvaL0ybzFXc+el/K0bK047B2QA
	VJGIjFmbUyT+gCl+LfSAGr83vouHPI29b9HYU0ouqIJEG+IDxN6aUOKMiT6+0CXSYQFaWgUFp0c
	yg9woKXM79qv2BAIMe6G1xgpUoMDFWuo=
X-Received: by 2002:a17:906:7951:b0:c16:2e4f:a367 with SMTP id
 a640c23a62f3a-c162e4fb853mr371930366b.18.1783968653341; Mon, 13 Jul 2026
 11:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713181020.2735367-1-yosry@kernel.org> <20260713181020.2735367-3-yosry@kernel.org>
 <20260713184256.82C181F000E9@smtp.kernel.org>
In-Reply-To: <20260713184256.82C181F000E9@smtp.kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 13 Jul 2026 11:50:42 -0700
X-Gmail-Original-Message-ID: <CAO9r8zON0dSUNQ6dUwo3zj+WtMdyfHjFzQRkVMr-NADS0k4nPw@mail.gmail.com>
X-Gm-Features: AVVi8CemN3bXpYx2U8GaPsDeaBGI1kjYizO0rs8J9jXQRLYpJm7an72smgAILvM
Message-ID: <CAO9r8zON0dSUNQ6dUwo3zj+WtMdyfHjFzQRkVMr-NADS0k4nPw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] KVM: x86: Disallow EFER.LME and EFER.LMA if long
 mode is not supported
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 11:42=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] KVM_SET_SREGS bypasses EFER validation, permitting userspace to =
set unsupported EFER bits and potentially triggering a host kernel BUG_ON.
> --
>
> --- Patch [2]: [PATCH v3 2/5] KVM: x86: Disallow EFER.LME and EFER.LMA if=
 long mode is not supported ---
> commit 804513f9cd9e8710ae3f651192ce52e48ee9e59a
> Author: Yosry Ahmed <yosry@kernel.org>
>
> KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported
>
> Remove EFER.LME and EFER.LMA from EFER reserved bits only if long mode
> is actually supported.
>
> > KVM does check long-mode support before allowing
> > the bits for guest writes and userspace writes through KVM_SET_SREGS*
> > (in __kvm_valid_efer()), but userspace writes through KVM_SET_MSRS only
> > check reserved bits.
>
> [Severity: High]
> This isn't a bug introduced by this patch, but is the claim about
> KVM_SET_SREGS* checking __kvm_valid_efer() accurate?
>
> It looks like KVM_SET_SREGS can actually bypass __kvm_valid_efer(). If
> userspace invokes the KVM_SET_SREGS ioctl with a crafted sregs structure
> where EFER_LME=3D1, EFER_LMA=3D1, CR0.PG=3D1, and CR4.PAE=3D1, this state=
 appears
> to bypass the consistency checks in kvm_is_valid_sregs().

This is fixed by
https://lore.kernel.org/kvm/20260713181413.94A481F00A3D@smtp.kernel.org/.
I forgot to update the changelog here after I split the series.

>
> Then, __set_sregs_common() applies the EFER bits directly via the
> architecture-specific callback:
>
> arch/x86/kvm/regs.c:__set_sregs_common() {
>     ...
>     kvm_x86_call(set_efer)(vcpu, sregs->efer);
>     ...
> }
>
> On a 32-bit KVM host (!CONFIG_X86_64), this call reaches vmx_set_efer(),
> which unconditionally triggers a KVM_BUG_ON since long mode is not
> supported:
>
> arch/x86/kvm/vmx/vmx.c:vmx_set_efer() {
>     ...
>     if (KVM_BUG_ON(efer & EFER_LMA, vcpu->kvm))
>         return 1;
>     ...
> }
>
> Additionally, on SVM, bypassing __kvm_valid_efer() allows userspace to se=
t
> EFER_SVME and force nested state allocation even when the guest lacks the
> X86_FEATURE_SVM capability.
>
> Could this allow a malicious unprivileged userspace process to trigger a
> host kernel panic (if panic_on_warn=3D1) by forcing this KVM_BUG_ON?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713181020.27=
35367-1-yosry@kernel.org?part=3D2
