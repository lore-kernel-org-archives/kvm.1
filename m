Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1253AA4E1
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550526; cv=none; b=gl422LIfK0q+ez0QFo3wJKCocMbG1ZAbpOUgY5Rc+6jK6+w5/fnWGzMAI22UxecNImy84faYsFbnvt7OqeJ0IdjcdimE31jGkpIDuF97nkPS3nJrB0o6uele3reYjq4ul9WK+IfqyxXQAq9dEVCk1DVWNtYyaaxQsOy9OP1Ih/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550526; c=relaxed/simple;
	bh=xCjqAXLZY8rIMGbzZEEGmgRtoHf745poEoIsc8Gidac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iZyhtigIdk/cTA2hcDqhwQND0hBwWnEI1c9hK6Vpfxq6upsOcGwS/Fac93TKGZCA9+1wZvHUEMC4POx6GbMfEbHftt3jX7NRoWS+WXzqcXZLqAR/PTo1xO6uL/2LfRBlgjkVbBkXVL1MrwwbA2Vpe4eH8i1jT3rKxPl99KGdk8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QMCpDGR4; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QMCpDGR4"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423efdbe6fso2391218b3a.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 12:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781550524; x=1782155324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APiDafiaML/mLGCJ3WCjYH//RgPqrmVNUKcSFkPFk/k=;
        b=QMCpDGR4LCYC2q3CSLYf6lzHj3VjUuK7JHq1oG5R4rBCBOmVu6MiqTd2Imn38AoZIt
         E5t+djZxmaycojd3GKo9JGVUva/I1YueJgy08OV42BC3gs6quA/2jbWO9/qE0IYfnSMs
         t3IXjepLFtFwUbg+NMuLgkIU3sp/M+g+eHGJ050Oylmn8ftw7FcvO95f72+da9ZW6YK+
         bYOcfNK83biLf4P44mTp3khYvcQUxNO3zPkfw5fMf57bNIDJTgawSxwZ2p+X2alf0Olx
         dAexeamRdYmYc4zTAVHXtKK182rMKG7hFJ2qOL08HQc1wdzkBMnTyFYs0yTICqTE1tgX
         GG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781550524; x=1782155324;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=APiDafiaML/mLGCJ3WCjYH//RgPqrmVNUKcSFkPFk/k=;
        b=RBS07aVXglI+fO7GuB7Ja4dDdfvryKETI847A/LihC4tVNfGzrUdOWBDKHyQvStlGV
         slNP84uHQ6dIQ5N6de1vckSUnmu1RrEkC4ImTvNmYpXW7nqLgXEbsRAuWm8pv3DIUfZl
         EuMkY8o60eiXYjXgBjQKguAWkWQTb9PxxPy2QSz9FcZYYTxTwbuN5D8Ychce0+cZneKK
         4KQzk3nFcSrhVwuZXCfjLO/t6n1DaU28Zb0q/ZCQkQM06eNUyzq+i7LF1xSPk+jmp7ot
         AVHuSj9ZFp2VCrE/QtszvIrSv3Hi6RQcKvESkvJC/afabe8BazWcE1TI8pE9ux33H/Z2
         ebdg==
X-Forwarded-Encrypted: i=1; AFNElJ/mWw6WzjY2Vvgx+VgBGsCDgbZIEPaCFusYFedB+qlI1rULSwRR+pL0XWDQ1rv+hmW8VWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4Fle+QqbbucWETC3bjVRDP7rqFo0pXa86456iDLgQ9pLrmDj
	q46lQ0Y2FvqZGHKDihuAyGSQmb6Qpe6YeMkVkidrYu8oQIfapDpQvN51i+ckte/KFj6+495kB6p
	k/Jer2A==
X-Received: from pfff14.prod.google.com ([2002:a05:6a00:bd0e:b0:842:3b07:6355])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:418c:b0:835:405a:7e6f
 with SMTP id d2e1a72fcca58-84515357f7emr204148b3a.14.1781550524032; Mon, 15
 Jun 2026 12:08:44 -0700 (PDT)
Date: Mon, 15 Jun 2026 12:08:43 -0700
In-Reply-To: <CALMp9eTDfP908gH7OH8HAJKAsaixNfA5dHnPXBKFquQRFVCxFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com> <20260612230113.684301-8-seanjc@google.com>
 <CALMp9eTDfP908gH7OH8HAJKAsaixNfA5dHnPXBKFquQRFVCxFA@mail.gmail.com>
Message-ID: <ajBNuya3czCahy4K@google.com>
Subject: Re: [PATCH v3 7/8] KVM: x86: WARN if MOV DR emulation hits a "too
 late" #GP
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>, "Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026, Jim Mattson wrote:
> On Fri, Jun 12, 2026 at 4:02=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > WARN if ->set_dr() =3D> kvm_set_dr() fails when emulating a MOV DR writ=
e,
> > as the emulator _must_ pre-check for #GPs in order to get the event
> > priority right when emulating MOV DR for L2 on SVM (all exceptions have
> > higher priority than the instruction intercept).
> >
> > Opportunistically update the comment as the blurb about "#UD" being
> > checked is incomplete and misleading.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/emulate.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> > index b1799ed01939..e030ef9b9744 100644
> > --- a/arch/x86/kvm/emulate.c
> > +++ b/arch/x86/kvm/emulate.c
> > @@ -3298,8 +3298,12 @@ static int em_dr_write(struct x86_emulate_ctxt *=
ctxt)
> >         else
> >                 val =3D ctxt->src.val & ~0U;
> >
> > -       /* #UD condition is already handled. */
> > -       if (ctxt->ops->set_dr(ctxt, ctxt->modrm_reg, val))
> > +       /*
> > +        * A #GP due to an illegal value should be impossible at this p=
oint, as
> > +        * such #GPs have priority over MOV DR intercepts on SVM, i.e. =
KVM must
> > +        * manually check the value *before* emulating the write.
> > +        */
>=20
> This comment seems confusing to me. Isn't an illegal value impossible
> simply because we already called check_dr_write()?

Yeah.  I'm trying to explain why KVM WARNs, and also to guard against dropp=
ing
the value checks in check_dr_write() as future "cleanups".

Is this better?

	/*
	 * Yell if the DR write is rejected, as all inputs have been validated.
	 * KVM must manually check for exceptions *before* emulating the write,
	 * as all exceptions have priority over MOV DR intercepts on SVM.
	 */

> > +       if (WARN_ON_ONCE(ctxt->ops->set_dr(ctxt, ctxt->modrm_reg, val))=
)
> >                 return emulate_gp(ctxt, 0);
> >
> >         /* Disable writeback. */
> > --
> > 2.54.0.1136.gdb2ca164c4-goog
> >
> >
