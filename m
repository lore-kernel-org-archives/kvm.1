Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD3D33D51A
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565306; cv=pass; b=Lc5ZKS1LdO4sWNPhSeSFniKuTxYernSNhg1Yx/F1DenGMVsPhsT/yKVECqqYFHfZM0LjPTavm9HTLWB2atrQ1nA7h9q2WGTybFtMv48Lrm/8/KAgpvkhrcTznJlbUe+yMrFaefWw3BLvjAaXxH/zp3TcKLW0viCnlJwfWJXrqvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565306; c=relaxed/simple;
	bh=wg7lRJNlsW0oBCESMFNCRkAIROxOMlKhfCp9PuczJeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjkS4YmvZCWOXBwb50nlwjriqWERGyZT2tiNoGkmizEk+6/l5Zyd5CL+uPfqro1Mpc8eAHpeRIGqZpzIlTHuHkigNe43m33em9Y7UY63O8pNU+Qd9sxJePktTRmvJMQ5iPtVPsVOj52mBG2y1uqG/bI9NgZ97CthcaIMHTPHIm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gSz+j2jm; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gSz+j2jm"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-59d6e44e5c8so385890e0c.2
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 02:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780565303; cv=none;
        d=google.com; s=arc-20240605;
        b=Sh35qqvOrGAc9wzdoaco7k8VbGbZZC2JFFGnfze8PnTcJoTba5nHOzoIB6v956yelp
         uTKI623WgtZvXnFc3IZ92huDNHF8mRGqChBWHvzOD+ittMr8BqPms84Jcwr6IfYpc8JC
         YC2D+CR7aV0giQ4FSEaSCNPqN5Fe4x4qUjPyD60E7NVyej6TuNH3+AA8SZW3E/5J2sYA
         p9GnoDozDOxMomfr2rlqtrSYaw0+bme1Isp/UBOCTXkqamZPK4k8c5vRCDZow+jmjA9Q
         euxyyo5Ba+vmVemWeW258xYG59pldS888kqenv3s5RZuRlYswyJRByRMSz1TNlK4vnMv
         RBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RCL4lcQvD3orPEEgkWOhjChzr8i+E32h69rRAld3F+M=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=P0oIQ9ehym7X8I2pH+lCXqwI6158r4v+F7noNnY82yAnyEiL7UcnLnOQQiRgLewiT3
         kReP4JNETs0i8iOH8wQqIKnS17hke7rK5WibKrCd/cWyNpeR9zwaO6lTn22C1/+iHbsO
         lbtAVf0myAEqpsyMaL1sRBO6CDXATi0zzcGyqAQuwWCPgnqM4hso/wnm6pgSRBkPcMiE
         BGujEMkOhWYJljSVY2ubaAFOl1bxkmwrk2V+U/W8mTIZ2S5G8/vbVxeCGScXjM9o9xr/
         /KOUT7lTl82rIPgRffWTQB5iXOuNWbPiCNyXdrNztTUaSvycd4zf0X9Ar5HSDK1y1Ny3
         p93w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1780565303; x=1781170103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCL4lcQvD3orPEEgkWOhjChzr8i+E32h69rRAld3F+M=;
        b=gSz+j2jmpWyom6mawh/rOrzMyVdwqC4iPYdrY3YOUA2tVYmShMKyFGcsj8pITvfr+A
         C9bJqVUbwoufd5/xYC91etHAKCXUgW6Gk9iH6rMko8YxAUuHHEFnfm4aIdj00/rYV9Fl
         /L+P7KM75S5jbRI9fNR95WFIcXYbZCFfkVapgfGqPogNjBozwhN+1fCDiKOrcQbSvnEr
         mDSD+hlk1JlaDbHA8rPAl1DBylY+N6EeQxaQA8rymQ52Qt/BQeiQ2jZQ2+Ig55+d5ju7
         G3oF+rcAKw5r8n3oTH143D/EtJnNamyfX06D+EB+zl25VJK5ptfJW9lZgu1ZLTJQzWk5
         16kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780565303; x=1781170103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RCL4lcQvD3orPEEgkWOhjChzr8i+E32h69rRAld3F+M=;
        b=IS5t9g8gQItBrhF7EbqkTvgL6mMCIcSrRoVQX36VcPXg+p0bAYIxYNRfNyP0Bw3Fe3
         0Ik2C0muwcqMv9yFISdAedZJSv5Tfsw+zhGLmKLmoamb2mQZwhejAMdbSOoztYq8dzVT
         ZzdKKn1g9F07MV+gkNuZcT18eu8YTvdKudwOd8hR23rdEe9QD+iqZ6M+YAlecawRU9Ai
         oNAmI0iDvUwDkrmU3Ig/fK+7Gwzz185/H9zg5fPZXFjHrcWo0TneNvUStfVoQ12eOPPg
         ZJCIJ8cgs16guAwIUgsqLvrhnWgApHKvWCILhYod7/MQJE6vJoxrirl3TYKeSXK0Q5He
         jbcw==
X-Gm-Message-State: AOJu0YygTDUxqXbVtPudjFJEUf0NL5mwph2nAwjL1Fe2JbIzLIgSKWPu
	tYCnH3WTNfEjwbukDF1Id6cWFujG3qk/N3G1cUornnLbgcWwpwoIUeQMl8F+GKM1sD/uEzpcyo+
	QCZehXnsTZ/fYdQK9XuQc7F8bUVJ5a+9XtS8Gjtohnu52qFTgEgCOAbFoRA==
X-Gm-Gg: Acq92OEveFPjKZIUHvPwtK+PHcY7llpzh1M54qY8VVBRghIxJPL+Pivl68TC12todr1
	JT5EiJ6M6zTeY7uvfDR8IMX0r/BiF30iDpJJIDn/y6hXQ0D5UTNpMAUaKtp9Ud1INt0Dd9BlfsT
	ZUyZ0nzNPzjlfM1RCZ5mM+jvj7stvDG5hleSympNUCb4TFz4sOFd+B3kiSMbgz935pRSQXz4Gp8
	TNtHawo213rnZ3cL4t6Vfj8jcM2tu7Nq2YGIQPI9iK65Y/B8ZzrL+VXhdebc8rj3+Yc8M338rx1
	B8/ylXjFQNt3teZ0kkIg
X-Received: by 2002:a05:6122:8b01:b0:59b:396b:cea7 with SMTP id
 71dfb90a1353d-5a6e852f461mr4558017e0c.9.1780565302845; Thu, 04 Jun 2026
 02:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-kvm-get_reg_list-v2-v5-5-415d08a2813b@sifive.com> <20260601115444.8FA2E1F0089A@smtp.kernel.org>
In-Reply-To: <20260601115444.8FA2E1F0089A@smtp.kernel.org>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Thu, 4 Jun 2026 17:28:11 +0800
X-Gm-Features: AVVi8CeZRd_Q-LBEz-R52ZmAsGdJ0GpJ5AL3CndkzKAkQ3KhAAdQ_zLy8QAqlUs
Message-ID: <CAMWQL2jD_QKcEBRERJHnObgWYO8gApyM+LEG8NU5dwSurYX9yw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] KVM: riscv: selftests: Split SBI FWFT into
 separate feature-specific sublists
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 7:54=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The `pointer_masking` FWFT registers are omitted from `filter_reg=
()`, causing spurious "new registers" output when testing other FWFT config=
urations.
> --
>
> commit aac064e5a6f0dbfa5efc45c4b208f71e477aa98e
> Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>
>
> KVM: riscv: selftests: Split SBI FWFT into separate feature-specific subl=
ists
>
> Divide the monolithic SBI FWFT register list into separate sublists, each
> testing a specific FWFT feature independently. This allows tests to run
> correctly on platforms where not all FWFT features are available.
>
> > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/t=
esting/selftests/kvm/riscv/get-reg-list.c
> > index 5033c09201ef1..cb86cb6b36355 100644
> > --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> [ ... ]
> > @@ -149,6 +150,14 @@ bool filter_reg(__u64 reg)
> >       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(iprio1h):
> >       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(iprio2h):
> >               return isa_ext_cant_disable[KVM_RISCV_ISA_EXT_SSAIA];
> > +     /*
> > +      * FWFT misaligned delegation registers are always visible when t=
he SBI FWFT
> > +      * extension is enable and the host supports the misaligned deleg=
ation.
> > +      */
> > +     case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_R=
ISCV_SBI_FWFT_REG(misaligned_deleg.enable):
> > +     case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_R=
ISCV_SBI_FWFT_REG(misaligned_deleg.flags):
> > +     case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_R=
ISCV_SBI_FWFT_REG(misaligned_deleg.value):
> > +             return sbi_ext_enabled[KVM_RISCV_SBI_EXT_FWFT];
>
> [Severity: Low]
> Should the pointer_masking FWFT registers be included here as well?
>
> If config_sbi_fwft_misaligned_deleg is tested on a host where the SMNPM
> extension is available and cannot be disabled, KVM will expose the
> pointer_masking registers. Because they are omitted from filter_reg(), wo=
n't
> the test framework spuriously report them as new registers?

The SMNPM extension can be disabled so the KVM won't expose the pointer_mas=
king
registers when testing config_sbi_fwft_misaligned_deleg.

>
> >       default:
> >               break;
> >       }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601-kvm-get_=
reg_list-v2-v5-0-415d08a2813b@sifive.com?part=3D5
