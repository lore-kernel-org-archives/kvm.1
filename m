Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBF92857EE
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412113; cv=none; b=BtTN2FaCYlsqyj5vxtDaauy13JK5snqWthweDXtJrqRIuCTAxpdqEyBmjPOsU61r3zN3l3/8NiYrP20L4GdQc3iizmhCc6u97R9CrK+IcvvnWFMIpA2TtO1kKcLa+MvW7s5haOJjPfV0goPsid1XtyhJgvWEW4vJ6JqqVhgMVQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412113; c=relaxed/simple;
	bh=8y8AtoffgThN0z87ShPqpxaGYDEItR/KXxFv0jwcHSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tjo00zQab3SnbqVTfBxwJ5odnsnUK+an2Vl3wNDotN+1OTqJRmys+3/2xb027yYUsa9n2bGY4QfXC1KC9kb1/phtY7UiCub9YVtLfwYHlROTfLet05jkvkkGnlr9JfhMHENIf4/LtyIY3sye2ALzP7hZfPH4qHtU1NMnhwMPo+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kKpYXFv1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKpYXFv1"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d97415004so5556319a91.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780412111; x=1781016911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzFEGMqD74OctjtVvpex5EvDiYSxFnm/wYYcilIDAmU=;
        b=kKpYXFv1Cv8ZMvIFP/DTCNVdEGBSK1rsrHIULEZDTqwRQLIBJfx5FgDKdkvyNJthRG
         dWUMq/3ITRg6PUA6GfqCyKvYfzN2Xt8UWO7CHl2bijvXKgczyHkgH3yAgE7pcrlB86t5
         JxKJSf9Gejx9qGeGxsAu3ynBU3BSvwECyXOtPjLIPqOXfq49jUupsXOuOfZMIoR0KF3S
         Y7F4FAw/2Pb/eZqBeVHGlYuYZWU2oHIn8lp+PTrOPy0/AJic8vGeQ4F1/d4s1s50zooc
         29TdEdI0TikQ00joZjh8EPn0/OMsiOHo2nUwfO0ImDGePWe2KwebZz8I2IqIgJ/8o+s8
         SfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780412111; x=1781016911;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nzFEGMqD74OctjtVvpex5EvDiYSxFnm/wYYcilIDAmU=;
        b=Wc3oUzQF93JUZxdE8NC3LVKwCkqk+2NaZJ7d88Z/9BSv7wENOY25cor6rikwPAUFVC
         jaF7/cM1QM04ahkdzObvUck4W+PZzG4wgS2koHCCpAtFLD9aQq+Oztin4XYAxj61dKRN
         FHwM6+g2NQ3Ws9z44Xiu1CinQmzwJsqyyYuVtRqaGOB2GbipXxO5TdwCNy/1bNe9qPEg
         5g7tiHKexX2gQSJe+1axqFjhokrpHwMqTocaGjJq791x4oEZI0WoW5wLrJ8kcveFbWR8
         d8EApDqvLnZ554zg9Wt39mdl5o2gW2pdx/Y2XZC7V4JruVO/eqyH5nAxE+iBU/8tth1e
         ICoA==
X-Gm-Message-State: AOJu0YxQiYlV9uvTFrNTAaGS6eGYoSE0fIuhWtXJ/KIXrLwEHtPA+ggs
	dHs9Mnr0/OmGQ1IQ4O7XufaDkKxfOKP9H6sE53MhYcXwyvYuQ+voMmrDGYmyyw8VAY3YQeeqZan
	bFwIp7A==
X-Received: from pgv31.prod.google.com ([2002:a63:155f:0:b0:c82:72ae:396b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f46:b0:36b:bb66:fbc3
 with SMTP id 98e67ed59e1d1-36c4ff25303mr14722349a91.4.1780412111170; Tue, 02
 Jun 2026 07:55:11 -0700 (PDT)
Date: Tue, 2 Jun 2026 07:55:10 -0700
In-Reply-To: <20260601133320.91479-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601133320.91479-2-clopez@suse.de>
Message-ID: <ah7uzuAHyQh2GI7T@google.com>
Subject: Re: [PATCH] KVM: x86: fix #GP check in em_dr_write()
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2026, Carlos L=C3=B3pez wrote:
> The practical impact is limited, as check_dr_write() already checks DR6
> and DR7 manually. However, it misses DR4/DR5, which alias DR6/DR7 when
> CR4.DE=3D0.

*sigh* (not at your patch, at the existing code)

Which, after digging into *why* check_dr_write() checks DR6/DR7, highlights=
 that
this fix is incomplete.  em_dr_write() can't rely on ->set_dr() for #GP che=
cks,
because unfortunately for us, the #GP check has priority over DR intercepts=
 on
SVM, and over DR7.GD (General Detect) #DBs.

Of course, KVM only gets the intercepts right for DR6/7, and doesn't get th=
e
DR7.GD priority right for anything.  Not to mention that emulating a MOV DR=
 for
L2 (the only time the intercept priority matters) is all kinds of unlikely.

FWIW, VMX is more sane and prioritizes the intercept over everything except=
 a
completely bogus DR (i.e. DR > 7), i.e. it's purely because of SVM that KVM=
 needs
to split the checks in weird ways :-/

I'll send a v2 (series of 6, double-*sigh*), as there are some additional c=
leanups
that can be made.

> Fix this by treating any non-zero return from set_dr() as a reason to
> inject #GP.
>=20
> Fixes: 996ff5429e98 ("KVM: x86: move kvm_inject_gp up from kvm_set_dr to =
callers")
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
> ---
>  arch/x86/kvm/emulate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 585a8ceab220..de138ef92dc6 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -3299,7 +3299,7 @@ static int em_dr_write(struct x86_emulate_ctxt *ctx=
t)
>  		val =3D ctxt->src.val & ~0U;
> =20
>  	/* #UD condition is already handled. */
> -	if (ctxt->ops->set_dr(ctxt, ctxt->modrm_reg, val) < 0)
> +	if (ctxt->ops->set_dr(ctxt, ctxt->modrm_reg, val) !=3D 0)
>  		return emulate_gp(ctxt, 0);
> =20
>  	/* Disable writeback. */
>=20
> base-commit: d1568b1332b6b3b36b222c2868fc102727c12a34
> --=20
> 2.51.0
>=20
