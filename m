Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8421930D3FE
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792101357; cv=pass; b=fa2wWuClaokokApFkBsGAlCBxRxQF/S4Tarsmz2F+6ydeKkmGCC5jtpKuVCbD435UHhQVxZqNR0qbvzLCbcHpzpnecnheR+jLzUHplJM/3nmBUIxTfpVHjeCq7McBy1xkVpPW2w1yWT5oN69eH9AkUe4GN9QncNLDvEzVCPb17U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792101357; c=relaxed/simple;
	bh=79g5ogA0I1GdHv/JPvhhzq91Q8Tf1OOh8jZbsYg+F80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATxbRsPVlPw+DVvqHmHk1VH6HahkexdkuD1wYimZFzqtw79mRZoNP138OBdha44EHo+MQSrXq45ZEb7AOWgt7lQR6ibVuGIDEt1tz6TNe37s77O9+F14+hUS6O/59jDE5WzwmCuDWA7oGEKbQc+TfrDFT4b92hgEjduzHm6KfgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=retiS23H; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="retiS23H"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1617a12.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 14:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792101355; cv=none;
        d=google.com; s=arc-20260327;
        b=oE19QAgqC/n2nzYVpcyozlh6EGpZJJ6nyDga/ckTUTLrcFrgWDDYC/tgBGk5MSaeKS
         PV74G0sfLPKCo287jtctM1JTCtmwY+z9KWJUl+sTds4mRW8fJmug/tcwwkpYvvVx3xvY
         t9TRn5jg3yPF4eSMYPsTVA3+qmxsororWCwBk5SLLJEoKxoeID7UIQdt33obmfJmA/W+
         gA6B9b+vVXPIe85sir5dnkUPCw2nk3cAm+sDAiTM3YzLND67LzbRhLpEdeHM2aS2ZJvj
         uCXVhoGNkk6ESCxzydOBy0bkCrmP3t0HIUDM7AxCaKVYAGhVM4V0yNSaVGrkiZ7QHCPt
         cIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AncdyNWulj2gORzp3e0kx2tc7Zdn14X5aLncnwklBvo=;
        fh=6OrF/z5RzDHKn24X9+QswaoFygYWXd1AUTTBNltivwg=;
        b=CzMw/D7VumUnZ0RwXyU6TLd0FoAmGxOd3YI72myHJ/LgztA/RdCwVTwj9h8hxg0vsD
         ZoG47376XIk+xBeUhKn3uh/t5FxosS4TrqbQyOyI4TyW/iL2FWWnuW1uXE4GJFgZmvLG
         d5R5x2xqwCsKqhA0jtqHeA5jooqQCKYuX6l3SK87Y3Z7KHFLUGuMbsfX7zet0KsyyS8R
         N/TSgN9+RFYsO93eyMscBxVPv77p9AyYwsQt6wCasrtmDm/Yap7NyTJ7KFk70C4CDGKV
         JfVGlAM+eO4QKUzsF1Ko2Ob6eGXE2QmP1s/ZfselwSP9g3oU7oC1jdyUb0FOIsZJWgGt
         DhiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792101355; x=1792706155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AncdyNWulj2gORzp3e0kx2tc7Zdn14X5aLncnwklBvo=;
        b=retiS23HlkYiY+UIuSk5FX4gatelO7J9TLQi2mX3Mq3bRAv2SY07SMY5Ax0Lj5++Ow
         33rLaFtjZtfh/MVRShyrFMXT0uLIRyhhXqV2hzwFujUOmA2+GRM/ekY9aS6emLeoypx9
         XwrX3To3uBCa3fNugA0r+YZng+kmlxg1gUlPkkp27sMk12n9rbwBaj+/gmtTVg5ZV+6q
         aWSXtMYxzTkl752Pg3AB4HdM+PodqNMOUmUh7ytPwVrllYgyWEyclHOUdEaEnfjhrtAA
         U96j0Gc1nnYHrirrnARNJMjJF0Crilva9e8cy0vNeqaN3ZHXYyyOcxoCWGrKWxhS+59c
         E+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792101355; x=1792706155;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AncdyNWulj2gORzp3e0kx2tc7Zdn14X5aLncnwklBvo=;
        b=I5yk+cD+KlBOcjqKXBgk/CU5wLUji+KOj7MRMWOEbyN7rM8YRhVQlHpysWme74QE+7
         17AZVcAUYgL5r6hc2mz8PM1GWyGDUsIVy8dIl+zfLOleGlisWH7ztafnA+JeAwfvpvwy
         DrLtY3fb5KrwC/So2GvADDg0l3ZM9JYNYD4+pMF/ycPQLt1wq3V85l/VdJsmEcYNcc0t
         kQhg9ubXcFsVyZutRu2hHPXLHZO4ZIHFqRAJOmAOmJf7kF+rXQpS2eej7uGOsv/B0XF5
         pem04zvbn2YLfgPNcfih6i8F4UX/zsoYPb6F0adcLxD1lDip8CdPXoHT94rvzue6WinM
         2wZA==
X-Forwarded-Encrypted: i=1; AKwUvBzflblR4EJPeZw8yJUQGOTe4kofFJqDI0tg27eMAJDkIVfBqH2MM6aQK2R80TWBris0hdw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0M8GfPJDiLXVAlr9cw2WDlWLJRhJPK3livR6kC9YYqmubN1u4
	BhPWvT5HO79wZFsX5Reiuj0pA8robSW0W/TadNztO9480Sv2wAqycOd1LItSMwyic/o3o559Kji
	XmTcgrLeTtGS4EihrFUy7kmzGB0fx5letuQTbfGqm
X-Gm-Gg: AYBFou1y+gHnmNLnvANT77fIamDcCbbQ9O+xpl3pUAaxfz9fn1niIiAqFYSt3fFGdwu
	7GRpQuTnOxle9QNVh+p2gaJ8+yXNbtSB9GZO3HuzYrXC3FpIyTGI3PdQ+wjSmD+fXVdaR3UZ+YZ
	uKbV5hpI7qnwMqVJCYcFdpesVr7qcCF3Py81WOBgUnZXClipKJ/UlKuFzj/tbGrew4heE7I8IBT
	t2+GN/k48xLIEtA4XmzNe9ZXYIF4d/v38ZPtIJN7X2Dq2LjbhzHQlK6juvPBQBVLB8VdJ0CmE3r
	mpD5k9XT/GOe6Ft2K90Nj+ebiiApzCuOG9xxOR+aouPYirNcfaaKevXUeuMm/5mHzg==
X-Received: by 2002:a05:6402:461b:10b0:6b1:b607:a5db with SMTP id
 4fb4d7f45d1cf-6b38bee8277mr7482a12.3.1792101354190; Thu, 15 Oct 2026 14:55:54
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-14-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-14-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 14:55:42 -0700
X-Gm-Features: AclHuK9gcJUHdFVjiS-NT8eUvgfHYnlNZI3clKtFMVjRkrs5A4QiIfSLdfLqFP0
Message-ID: <CALMp9eSV0ikZ8CDoah_vCKYFXEm5syYh_sCMQ8wXhGB0+E=vcg@mail.gmail.com>
Subject: Re: [PATCH v3 13/27] KVM: nSVM: Add a placeholder ASID for L2
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> In preparation for introducing a separate ASID for L2, introduce a
> 'placeholder' ASID that is still the same as L1's ASID. This will
> facilitate future changes that need to distinguish L1 and L2's ASIDs,
> before actually using a different ASID for L1 and L2.
>
> On SEV VM migration, copy the new SEV ASID into asid02 and vmcb02, in
> case nested was already initialized on the destination vCPU before
> migration.
>
> No functional change intended.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/svm/nested.c | 5 +++--
>  arch/x86/kvm/svm/sev.c    | 9 +++++++++
>  arch/x86/kvm/svm/svm.h    | 2 ++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index bfb297b7d71ab..780132725bb79 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -701,7 +701,6 @@ static void nested_svm_transition_tlb_flush(struct kv=
m_vcpu *vcpu)
>          *  - Honor L1's request to flush an ASID on nested VMRUN
>          *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
>          *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
> -        *  - Flush L1's ASID on KVM_REQ_TLB_FLUSH_GUEST

Um...How does this patch either do this TODO or render it moot?

>          *
>          * [*] Unlike nested EPT, SVM's ASID management can invalidate ne=
sted
>          *     NPT guest-physical mappings on VMRUN.

[ ... ]

> +       /*
> +        * If nested is already initialized on the destination vCPU, also=
 update
> +        * the nested ASID to match the new SEV ASID.
> +        */
> +       if (dst_svm->nested.vmcb02.ptr) {
> +               dst_svm->nested.asid02 =3D asid;
> +               dst_svm->nested.vmcb02.ptr->control.asid =3D asid;

+1 to Sashiko.
