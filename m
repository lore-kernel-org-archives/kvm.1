Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E84F054D
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563850; cv=pass; b=cYCKCICVU6d5yAhAFu/oieoo0lYizFN8QX/dnKCUiQfKejTsCkeKSlwbVC5rO4R5WbDoXSthLrfbaVOWzxUSYbesMwUebOzEbeWJSqB9iR7uusk2kTEtM5iaIy+rNdjFAPfDmkHl+or4nlc8J2gU3FLvgASeko9ScPwtsI/nXvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563850; c=relaxed/simple;
	bh=ZcD3lWBEn/k5gS7QyncQIx9YliZr40hzwE5JijjRb3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAakEa6fClMvINUQxKYJWWeMO/1TgSbFDKi5jVCH2wHEyj5ddLqrxWe8i57kSJWvnT1k7fB6o7OtLz2aAP9DAoi0UaqyDNEBZg/x2vJupWKpQgizmT+63T5RYPWhJDycBhIEjT6BhCHUL9IWIASslY0P4SuYmsR1v9KV5TwW25A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=F3VIz5qE; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="F3VIz5qE"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dc202a60eso75186f8f.3
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 09:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791563845; cv=none;
        d=google.com; s=arc-20260327;
        b=rC9TK703q68NQNBvVilsVw1INr461ZVt1nI336k2a9WviFuvqQvhhhXPVAMeJV62Kq
         dhoiWE+ALMx84ickQ1ygkNbcOtFeQ+9eda2vt+oFMeB7MiMh92cZaxijg2Eg7il0ytMy
         XzlaIVrmBOkgdmod6Afz4eIdzfCAQF+Sc0Fiof9DM+FTgagmfPX/k5Hac2it8ygte7wU
         4USMpTnTHnjPncptCeQM+pC0VRsnaCPw0zgGEKBadnPl82ost2aTrShISyqDJDVGnPfB
         9Uo1t8FMEC/WWj0GlMv8JAdL3sSNLCcKh59QE2/nsC/y+RWwqISYsY9OxpgOLBVK4GB1
         t/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZcD3lWBEn/k5gS7QyncQIx9YliZr40hzwE5JijjRb3o=;
        fh=r5FvWTLZbj2uFvdt+GsHqk7MzszOyUc6ITwaBWpUQr8=;
        b=rm1TyXoTaWBt1IixHbYX4oEOkCnScNlrfZHD7q7ptUhq5q0jQOrinVxhl8yS8BXZU1
         yInh8Gvv/ysQTsHeIlvdcUqTRzt8dmlIDcdW1KXjmieGuw8LFEjJL96XNbhkf+QhT3WJ
         dqH2IYM6BJUscrbp8DZnDx5nsLv5Suhm76D6T0vOeCerdg9VP1od4ZnAnt/pj/w9PaNc
         e/xRfOlUJh1AkU8SwYdwRcdiqesRAyj/MiEW3O5vihrvh+dfmJxJ1giSgrgYv3cNf867
         L9wsLM7R0ODZzZbhHKmKgFwpNcPRYuPR/KZKgZz0h1CNm2dXeFv24BbRpQXk0Oa6ly4T
         tjAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1791563845; x=1792168645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZcD3lWBEn/k5gS7QyncQIx9YliZr40hzwE5JijjRb3o=;
        b=F3VIz5qE3aWHrSSf/Dd33psysfSfCUO2kYtVI6N9FN6L6jBjHyIclYT97aROmKujAE
         c63KczfxmI1hmN2Jin5nrs9kejp0WV76pRfwJm+atDJ7YtluS6sOqJYd7POa9m0vyZTx
         PdlfC0BGOrvsexXdcHjNsomEtgYsml4IMhJB7nyynVwW68yu58Xqu26ufvQ4qv1mAgAX
         Y9MiWUFiuuPcZZF2sLfa/RuTevPMq6iPHHiglmiqBWVuvI360FiJ/bUOUDcxQVGvMbgk
         4esbvjhM8n9F+1WFa8kJ3JeLCgkis83pRAGcQh0L7EqV5VHNo4vEHnK+ZBQvAn+4I3Hf
         FoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791563845; x=1792168645;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZcD3lWBEn/k5gS7QyncQIx9YliZr40hzwE5JijjRb3o=;
        b=KoyrIfxf5qQbia8UhFOflLrAjWFwIuAzqAtS0RMRYl15B4GXxjjEMwk49/+NkY7Rt5
         iAmw20WpkNk/Z7EwRKMDzN2yl4k1RcqQ8R4RFHHRF/iO7VkqPmUOMbrO2LF+3HXf4IJZ
         GwSktjDXIJJ+VaN2WJBnBHIJzbAy4gyrRgke6wCFX8lIXS1ic47zGAv2GQEfRXk9PkLL
         90f2NFf/1spTzt3es7m9e55/FR29mU8DtPKlgvvMJ7xqJg9j/WWnX8SvS1A2P2jn1hOu
         8gkXkBWINdqGzaWBlmfU5N7eNqHsAviuW97RUdtxrH47xsvdWCRssVpz53tGfjk9DCP0
         bYFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxR7Qwu6T8JLzo/6/RFNDACvdBYnoRhHsmnTmbn63k0M8Lam1EEAIQrfhgNYYRVIFaLJHI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJw1JYIB/ZGLgC38wtE8Em3oB60oyd6Y/c8yJhTZDYKFMmSjsHo
	EpQu60ovFWvuCIlZHeB/463B1pymgGCUGHnYK9o4iVk78Qe9g3NfWG5Dnt0HwnqtyDJv9tg5yP3
	0AlAuqaILnVolh+Y+7O9bR+C9ZNFst4eXndWpoLhskQ==
X-Gm-Gg: AYBFou2TNfwdipJPij3c8XCFGyeQggT9dJRA1YmYX1+sQzAdJf0L3XNDURtItxvdSrl
	LS5dK0qqkPR8WvaFOsrrwBbnwfX9FrCfRNWs1VEGFSqHpihcmhFmLZ9jCQ4Z67/rlWgL7ZLeM7j
	dlJPqhCcPK2pp1V5wR7lFEvPdduytAgjWrbYiu/SN9UljfcOfkTG6bISvbWDb/KHlcgDzyzaYKg
	RPCT5wNYTrjazbeNQO4cEjcNyBaLgGNJE+ofjprdSK7mZxxtXyZTWMObU28eO+R/SHK78wt2tSO
	98+Zv4FCX0pDDSIS11AOgLGu72yrRMcEIzp8zdDgI1cBxetXTQJDxzUvH13/ZmN+mJDAL4dMSyj
	iHjyMethVFWQqHSpYfi+xT7vRNZletbSP8mEbzzse4QtOaFViiROkYwwY50hBeY8crdFH/27kcw
	==
X-Received: by 2002:a05:6000:46db:b0:48c:652b:9694 with SMTP id
 ffacd0b85a97d-48dbaadd069mr3527485f8f.14.1791563844566; Fri, 09 Oct 2026
 09:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925155116.465203-1-andrew.jones@oss.qualcomm.com>
 <CAAhSdy0Y8kQ=gsiX0QX6Ntq=fL89METhA0s7G3niBBJrHpue7A@mail.gmail.com> <7zy352odf4hekcibmio3atunubffzxfcsqnn55q6sfkksnynfj@5bx263nnizdm>
In-Reply-To: <7zy352odf4hekcibmio3atunubffzxfcsqnn55q6sfkksnynfj@5bx263nnizdm>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 9 Oct 2026 18:37:13 +0200
X-Gm-Features: AclHuK8vtPQ4aaw6JsQ85iwGdZHaeULxx6XNPczP994xQTrZFbfymhhY5wrwX9c
Message-ID: <CAAhSdy2mAs6UgTk-hbGd3DX_1242Jpy9WLnOp6kmPvVVtABWHw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Use a raw lock for IMSIC wakeup state
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: kvm-riscv@lists.infradead.org, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:44=E2=80=AFPM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> Hi Anup,
>
> On Fri, Oct 09, 2026 at 01:45:20PM +0200, Anup Patel wrote:
> > On Fri, Sep 25, 2026 at 5:51=E2=80=AFPM Andrew Jones
> > <andrew.jones@oss.qualcomm.com> wrote:
> > >
> > > kvm_riscv_vcpu_aia_imsic_put() can run from the scheduler preemption
> > > notifier while the raw runqueue lock is held. Taking vsfile_lock, an
> > > rwlock_t, there violates the lockdep wait-context rules.
> > >
> > > Protect the CPU/HGEI pair with a separate raw spinlock. All updates t=
o
> > > that pair retain vsfile_lock and take the new lock, while scheduler-o=
ut
> > > uses only the new lock around the HGEIE update. This keeps the wakeup
> > > setup serialized with VS-file publication and release without bringin=
g
> > > wider IMSIC operations into a raw critical section.
> >
> > Instead of introducing another lock, why not replace
> > read_lock_irqsave(&imsic->vsfile_lock, flags) with
> > write_lock_irqsave(&imsic->vsfile_lock, flags) in
> > kvm_riscv_vcpu_aia_imsic_put() ??
>
> Unfortunately, write_lock_irqsave() has the same PREEMPT_RT issue, since
> rwlock_t is sleepable on RT in both modes.
>

I am not fond of nested locking, why not convert vsfile_lock into raw
spinlock ??

Regards,
Anup
