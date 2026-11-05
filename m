Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793922190;
	b=LF+kWhleP5OAuWO8QdFVRwFk2MubA6L+4p3SIPOSwSiYsO/HwILOlYtLre2OVTEgBs99
	 C9MEmB489pU4YHRUk3dvTa1KeHfLfnExRhxOZUFptoLjDVOqgEbp1jGsAixRpz6FkeHYa
	 IV+p2D4HKi1ifz38yZipSMuSivglTwOqTxG9RcUFJGXVsfKcYa8UA91LiSscRtWr/ePF5
	 oMD6oiBYnE5rc8jtpGfv/iGncePO5wSXTqElpiHYtQ5PXU/t2VvbfU36lqekafsBtSJgE
	 H4u+6oE82zHedfmx/BD2yvskIeUBnMj/nS92urIpH1ufL82ZVN3BATl9PaE8pLC/3nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dc90RyiGFoLb3JGpztvQfjTlSJkJ9NTlT+pR5m6yETA=;
	b=4AZ8PyztPjcqqxloPTO9+kPkGl65UpPWlMSTAzhZPIDIgk5hwqMfsK1CDK5TAPIAbLbP
	 z0aaPsgrtZtgHksDOjYPhatOXyysXSZNk2P0nHmQdv4w8Fg/+KkplEVycERrCHX1auM9p
	 8mXGRtFvkraEharbZlgYjhaan2m0YZBOaU8T/Vj98yHDXqd4KSAD+3BLY3Vv2HRWiynna
	 JL//8xUGe5hJQYrl3/pyPhRFMq0YaucoMOsaJWyKigEYfyvMxZy7uJ34R7KZHDWkSIU9r
	 fL1OOTKMcYHdo2SC6zcW3dg2po/mcG8SJte+4Jj8a5EvjAZ64+7j27GI+INd68gdXmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Fr4F7V4N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A03F606A31B
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A03F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Fr4F7V4N
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b579ed8da6so2013a12.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:43:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793922188; cv=none;
        d=google.com; s=arc-20260327;
        b=iudvgcCoKr8ic5hAdQP9SIbEcX/e3bRPxs9CMsZh4Mrd0W6bB9Egj05aQJDjD8vS6l
         5L4sy0cWo7wD87maAQw3N0jYJtdoIyYm8QcNyekk/JiqmK6N6Q4de8TDJsiOlVRLepB3
         3I8N9PBANKsTEjgRpucIaAHBABeuNV2zrJTxvQKcDU0GkzZ4exDKVI7LltDkUkDmFr/y
         7Aqka9fD7HxKdy9rVat6L04B/6MSikfOUB7Off+x29joR+nsFKJBsIAe65sR1gr1sAXD
         OAvyYK9xOZcwI6HY1acEXeeD1StI4AyupCGO+ts6fnWlCxejj7X2p2ryrzNB+VyAjk/L
         CwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dc90RyiGFoLb3JGpztvQfjTlSJkJ9NTlT+pR5m6yETA=;
        fh=0R5CCWl4rcy0FkMOcwnCFkvSRmNOrQfGIWU0S3TDHns=;
        b=iUGS6CxJeIqzb/MK9sE+THa/2JcgsyWqLofYsKSMjR52vxPsk4Qf4Gvtf+RJgn62pU
         wbMOVGzA8ce+yNCX7tGm+1E+FjcT4qvbQanOS5K+OK4WuFGZObOwSxRSVMShA5dY/6om
         D8bbyMLCMCiqLJ8ylZ+3uxRU7RQC3khyJHKzPE0XblqTxb8g4tkKLcAUpBVsjZDXRsxS
         7M674eE+adbqFl/35lX0KyyLFToZO0Rbv9P5xfkUDuiLE6OGdgr+sEf6uVnfSRTHcXBZ
         NoCAEmn9ivMgPjxElDVt3rXO/+KMbyUlylfhGRy2q95vM+utvIe5gDjvcVaRqni6YZuR
         SJww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922188; x=1794526988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dc90RyiGFoLb3JGpztvQfjTlSJkJ9NTlT+pR5m6yETA=;
        b=Fr4F7V4Nzu0gtdS5tvD30yZSxz0N0QpCe6iAKFnAj5sFX3tvTkTGDthDTe0rGrx+z7
         7PdXeJp3Upq1Oy0f1jJQLwsW9UrW6l7ktO/28+uBkb/ABb7afdVfe1T8+x1It61y75pB
         EfGliBmUxA+srFpcSr9hwMgitM6KpFigNvIrSMFqmFXf3ZmURX0ucVgJtq9QBZp8yqgE
         1OCSD3zyMkVPMZH9urKgMaBoUYG1P+gcGo4SxHcasLVQzz0wpSqW5e99aEqxgxNo+/63
         3qI/oKVxfRQvP/pBhZ77QJ7oVsVxwy9NRIFaaTWAUO19tWCqWEdTYvBDtQIAwmu8yjjf
         StGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922188; x=1794526988;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dc90RyiGFoLb3JGpztvQfjTlSJkJ9NTlT+pR5m6yETA=;
        b=GhcLJT+A4itzc1HI3VhPWeLNoeWbofZ/dtr3LCWXKayjhdxfn8o7CDErwj5ERhgj7Z
         xFCh1kl6GA/I5dxFyQp0Tmu9L4IG8t2JH27j6ZjA39gYN9vI/nGLXe79VOBPzTvL/aJI
         2IPN7oz5wgxIRqfRUd0hHfVMbNqm9kYESAledCq9uVqYvBscBTqRpG3589ApY4chl0qq
         aEpW8N1Yg7cLmr0d/7/gpW6Oad8DAY9Sb3U3yK7oVHWqJdGjMGfHz+s8d7MMeOu0RvY1
         KXCtHNkuE1sUXOKbxXv0SPm+NTcTDlc/2e74bUMJ3tWtOscrRFQj561emkNoSEftXvES
         PWXw==
X-Forwarded-Encrypted: i=1; AKwUvBwppN6xQdL7IOJpwluJuO4e1Ar9cW7gEJR9FhGfvYlWjFgdUUbre8O6DC7yqXoaAQq8q2k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LgPQnfHU8AQSQy8a8Ir2xJgJeI5TkEGuPHmifcO9s6whWDky/
	g3ISgKXn26sfwJB9DWJiHl5fuCppCUYx3Er58cKdvAt396k5LqIW0qwBqy+LE8jhP7Td73ez4MC
	bC4oQ5B66g3JoD2+9uZ5KoyudPkI+EE4KFmkvew0W
X-Gm-Gg: AYBFou0fZiYMW1mTGjjaQIy3Qyv8yVg3Jku9gOA1hEGkC6pykxdpUWAqoIwycX/aTYo
	t3DuuAKUwatel95MrXUlwqISrynJlg8CiwJdoIbgCJCklNdNZIRE1c/Ch9+SKbu0BAyVbyvXi7x
	HlYgdcRWq3zetZc8OBrVzmGuTsprxNdtM+w5CVM3kICynQ9v9m98HeSo1eVjtfKcJLYxI/1Y5fR
	E5TmGSoWmBM9tx3/SUUxjUoJN3/BzwwP294eVCuh1qacMbmmIexuB3Q9cByKdqkGI7MLfYJbZul
	PPMPUzN9MyWEihhrO2MHi7+RJtsGcRMu39MAhMGSSwlWrKt4DF0h3hC+vr9aRD/TrleP6g6XLvg
	fJb5RWveb2zm41C7UgI4A6nOdJFE0u1D6U0NuJoOcPObGZ8Jt17RAs9Tvb9W/2JI7Y/TXoinaL6
	DMrzlgqKWy8/mnOG9fuhBIq5Wx3g==
X-Received: by 2002:aa7:d29a:0:b0:6b3:b648:314d with SMTP id
 4fb4d7f45d1cf-6b597a39693mr33716a12.6.1793922187317; Thu, 05 Nov 2026
 15:43:07 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-2-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-2-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 15:42:53 -0800
X-Gm-Features: AclHuK-q1n7ef8QSRUSWuBCekJOMlqyDXP_oWN6zqFV0sPGgMvXhDoC5_Nz1imA
Message-ID: <CALMp9eTMteQ7WpPv++Ds_LZY_1MydqtwHy=7zsUEgrfRempbeA@mail.gmail.com>
Subject: Re: [PATCH v8 01/20] KVM: x86: Extend VCPU registers for EGPRs
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:35=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Extend the storage to include extended general-purpose registers (EGPRs:
> R16-R31) when CONFIG_KVM_APX=3Dy. This option is for VMX only.
>
> Although EGPR state is XSAVE-managed, and thus could be stored in the
> guest fpstate, VCPU storage provides a more convenient and efficient
> access path for KVM.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Link: https://lore.kernel.org/abL8SW5JS1aV5goa@google.com
> ---
>  arch/x86/include/asm/kvm_host.h | 18 ++++++++++++++++++
>  arch/x86/kvm/Kconfig            |  4 ++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 3af7395c2430..690de9606d6d 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -163,6 +163,24 @@ enum kvm_reg {
>         VCPU_REGS_R13,
>         VCPU_REGS_R14,
>         VCPU_REGS_R15,
> +#endif
> +#ifdef CONFIG_KVM_APX
> +       VCPU_REGS_R16,
> +       VCPU_REGS_R17,
> +       VCPU_REGS_R18,
> +       VCPU_REGS_R19,
> +       VCPU_REGS_R20,
> +       VCPU_REGS_R21,
> +       VCPU_REGS_R22,
> +       VCPU_REGS_R23,
> +       VCPU_REGS_R24,
> +       VCPU_REGS_R25,
> +       VCPU_REGS_R26,
> +       VCPU_REGS_R27,
> +       VCPU_REGS_R28,
> +       VCPU_REGS_R29,
> +       VCPU_REGS_R30,
> +       VCPU_REGS_R31,
>  #endif
>         NR_VCPU_GENERAL_PURPOSE_REGS,

In kvm_vcpu_reset(), KVM unconditionally zeroes the entire vcpu->arch.regs
array on both RESET and INIT:

    /* All GPRs except RDX (handled below) are zeroed on RESET/INIT. */
    memset(vcpu->arch.regs, 0, sizeof(vcpu->arch.regs));

However, according to the Intel APX Architecture Specification (rev. 9.0),
section 3.1.4.1.1 and Table 3.7, R16-R31 are unchanged on INIT:

  The main difference between EGPRs and legacy GPRs, is that EGPRs are not
  enabled by default (specifically XCR0-enabled) in 64-bit mode, and their
  INIT behavior is XMM-like; in that EGPRs and many other XSAVE-enabled
  register states are un-changed on INIT events as shown in Table 3.7.

By extending NR_VCPU_GENERAL_PURPOSE_REGS to include VCPU_REGS_R16 through
VCPU_REGS_R31 without updating kvm_vcpu_reset(), KVM will erroneously zero
R16-R31 when init_event is true.
