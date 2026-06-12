Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD3035DA43
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308289; cv=none; b=m3ftIyBvit3Uv3+4u0XE0kNw9As+uoTZ+GKdA3cLVwo9/m5yaTaJ5bhqJofOKtTN/RJoY/VSliq3SbuqqK/WOvTgXPDlJa7evhWuGPQ9t+1Bc+L5nWt9h1/sA8RHcqK3sIAeTFbVo9tvKCak9BG26RGjz59+lv8veJ3N2mnJLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308289; c=relaxed/simple;
	bh=KrrixN7adNVjBTUOLfV1MrmXfGbP++mQnNm45UA20N4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j+Ku0xmT1rskaGNLqmutHDAJJV32uyxyG8Y+KEmO9h4NBmYwZ4UAVEVOxjCLupOMrUuGQ3vn1JvcBYBmmxh/c9akEzUk675qQmnyqJpocoUxCFdut3wedbp32ubJUFXt+JFAAct1eTb8S6w1yWJMw9L79/875LK3E32O8tDAWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fR3pubv3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fR3pubv3"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d98b5a68fso2538249a91.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781308287; x=1781913087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ksOXGkmUmxHYgHNgZg6HQ8a2PuzuJbH+miksav8bu0=;
        b=fR3pubv3Cq6v0yQw6Gvjn8HdjG5aRYorzTPPtG6bb7Cy8Kq/IGwpu2uTuiMqwjUo0v
         iL0lidQc5rczi43AMeT67Sl7Z7p9KbDh9Q7Qv1R1Ol+vJuPr8NBgpiOwpuxfT+p8tdx8
         1rInDd2OyhWBU1JQqQV52Dmksbau+HOCNwQBZ5kRkBH/XL5QfRc8QCWrNhQHvF5w0o42
         OEx25OuTG3ySBI13bkwHrAv5b5Lmtn9q1KO14ZpyrrK9qOsCSVfjPGCpei1EHwY7vtWa
         b/6MI4GVQ3DJleqoiuveFdtXt2y8zigLHVgkcNO8PC2XJlQPVJBNxLC0t1boZxwHAS+m
         UK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781308287; x=1781913087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ksOXGkmUmxHYgHNgZg6HQ8a2PuzuJbH+miksav8bu0=;
        b=bdod7KL4yIR/yuf5mUEDLgRg/aEFLmJzw1oF3vUIbfL1ylxwSRg+92J7sVMOd5SYMW
         wKSnP1G4zeznNEDeGsqr4O5m7vvVmTMagYhzeQDlNr2IFxKxb5pPQOK7tuudtG4o9Pcz
         phjv40LNhc84GE++/ltNsEqAc+wRa8JZ9xDTfiXq1X3hg4xm9zNWBs2tWTBnDbqpteaY
         dnUZU/6nlezzXTOjSGRnQNxR/yI+9xboO1XEUk7+5Wq5ZBfwThwUfKXQqswM71pnQ/r2
         aATS/zaoV5Fq3iGhLSnR6WKV7yd31eZXYpEqCnF+MpRfwipyWQdPHSz2PROTPhNMNwGz
         FVcQ==
X-Gm-Message-State: AOJu0YzusRA6r2Q00/kpWe5OCR3vbdzeuRyAZys0PN6kCBylx2rydUNG
	Uc3JM3fuk5mxxuhRxWQmlR33quMxQYghNguVq4aIpTPVedqsnNpBIQofevgprtAGenrzjIxvCuM
	qIcdVtg==
X-Received: from pgwa8.prod.google.com ([2002:a65:6548:0:b0:c86:2164:9671])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53cc:b0:36b:7f69:c152
 with SMTP id 98e67ed59e1d1-37c2bd494e7mr1429812a91.18.1781308287198; Fri, 12
 Jun 2026 16:51:27 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:51:26 -0700
In-Reply-To: <20260612232829.482311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230113.684301-4-seanjc@google.com> <20260612232829.482311F000E9@smtp.kernel.org>
Message-ID: <aiybfjQbD4qMRMGi@google.com>
Subject: Re: [PATCH v3 3/8] KVM: x86: Manually check DR4/5 write values to fix
 SVM intercept priority
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 12, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> > index 4484c5fa19e33..a1bccab0eefee 100644
> > --- a/arch/x86/kvm/emulate.c
> > +++ b/arch/x86/kvm/emulate.c
> > @@ -3853,15 +3853,23 @@ static int check_dr_read(struct x86_emulate_ctxt *ctxt)
> >  static int check_dr_write(struct x86_emulate_ctxt *ctxt)
> >  {
> >  	u64 new_val = ctxt->src.val64;
> > -	int dr = ctxt->modrm_reg;
> >  	int rc;
> >  
> >  	rc = check_dr_read(ctxt);
> >  	if (rc != X86EMUL_CONTINUE)
> >  		return rc;
> >  
> > -	if ((dr == 6 || dr == 7) && (new_val & 0xffffffff00000000ULL))
> > -		return emulate_gp(ctxt, 0);
> > +	switch (ctxt->modrm_reg) {
> > +	case 4:
> > +	case 5:
> > +	case 6:
> > +	case 7:
> > +		if (new_val & 0xffffffff00000000ULL)
> > +			return emulate_gp(ctxt, 0);
> > +		break;
> > +	default:
> > +		break;
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this code need to check for canonical
> addresses on DR0-DR3?

No, MOV DR doesn't do canonical checks on the debug reg value.  I double checked
the SDM, and on both AMD and Intel hardware.
