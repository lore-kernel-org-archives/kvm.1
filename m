Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED51E515
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393394; cv=pass; b=rB0hpuKAju/0Kgk4wg9xx+O5//SeHxS787XvRhxeUM7aNxCYhFSRO/pT2TIuQ4CnPufrIOcuolz34T+Yc91jIq3DHBlwWjyA+Xkmg+fwuOeNd0+eq8196uBzQREM8zq+Qcv3YNG4VmI32LYH4x4Zov7ut5LdIElgy97GOC3VbHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393394; c=relaxed/simple;
	bh=HqCNvr3RehKJCJOmUpyaLBl/xGdtbyrZSMkWYjHgkpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBgBczDXkuybbzS1BrOgTTiZQ/59MBYJSGfK4F3fL1BcJwN6cTKNwnKLNyWZskILzcc36TZnlHtp2iYxCdHEO0UwNJRzmqRwW10Ks51YyyYrs8ZSnwsd/5PuMTgXAp4vRa/YH6u17iuH3ASXk0hPaKdm61mALUyi/jl2afyAxCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=cD0Udpsm; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="cD0Udpsm"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47de008b020so235465f8f.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785393392; cv=none;
        d=google.com; s=arc-20260327;
        b=IfeR9GGQ6MgOrS1mb8CgdvfG8g1/snboYS8FUKgx1XS7/k99vnaNwaJB2s8r7o28ci
         pJPg1qZH4c1N7s/wOd8XpVQA8yOaxh3cbA4yoGLn+tuFMs+TK7JIGd/fqEj3tHj0ZSXl
         Yv0py8F4OvLO52icNpNJNaj/n1OA0OSUUk6QW+apcj9T1BdvTfbbccVmLmMmSQOWP52a
         RPt7XwO6657i3N3owPq531w42D/+ifem8Be/NleFSQpGL+w0eVom4uJHvAdlfa8VyaKP
         XGRy1WDEWqgiCkvtK7V3dA+rz8faTOCXgkDsMkW38j86infwiBkwjuA17caL50wIbO8a
         JBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qTmettx8cBsuN1BktqpKr41TwEVmMBQwm8x7EG1kBB4=;
        fh=OoT1glIjq3EZYJDFwz52ZNeYCB0F/o8cP+zijikrTxE=;
        b=GfS/cF69gXPbfsV8NIJNqFMT8BmouqEaD0bmFzBmtBbWujQxzae7LylNqL0CRVk4Fe
         MZoqnE1T3xgCt9JGXK0KfxScjy3Hqj4tPSDDY+W/7Js9Uc68webMW3Oq/aEYKiqnGGFN
         usuAAFuX0VBDAx2MZwsXpjgVyVDEy43CARHTv+isRTZNtbvhu6qRQukiwqHkDiRhfnTW
         Mi2l6dc21s1lISgRzLJEV2Q3u8ROEfzowy1dkHACsMfszCcCDv062yF+bzU/LvlYJIqd
         8A9WVlufarh2sQycHn6Frhqy1G0E2DheEPNjUVtjjsxDpe2kztaE5H3w9e6zKUFCtdi4
         1QiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785393392; x=1785998192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qTmettx8cBsuN1BktqpKr41TwEVmMBQwm8x7EG1kBB4=;
        b=cD0UdpsmFVhrQ9Ha2hBH8cyC+qZ6iWJreizLoCKI7Yp3zgV/sTf7dXrY2wWJLw8qGc
         xobY7ZoqCs+nkteyq2Ncx8dHzRC0jIDdMufG1ileZoknz6BP6ctdtDwfTujRXaQyQ6Wt
         iYyWD+z5uxqd/IXaov32VMsgUZ4OV2sPE9//SnDBPHcu3NojpvK2neGNe567wPWQlWbT
         t5KPEs3goQWJ/2Zbniv27gWV5+YOCQZ32R+rsS7znEtBvYmYdUh8Kgkx4hQO61rKZCD3
         H37nR2jUFduLNfyZAiokgC8T0d24fHBBTwtJUfSeOJX4LOuwRNvyOk4VgXjJoS/xRQyf
         dyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785393392; x=1785998192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qTmettx8cBsuN1BktqpKr41TwEVmMBQwm8x7EG1kBB4=;
        b=LBD9VHiA0cQ/LC3XO+HNFU7pdevJXz4HBYK938QQwStvNTNuDumItdw8XwjEkhYhMI
         Fiy5cwus12BgqVrjTy6+Sd5mChLmR+Giv2D49dtNxFWQRzyEmB5gHX0wN4sFZJkSz6K0
         43jmslFNzL8KQzl3UXJhOv9zB1Jl5As3sNvqt0eyXj7F4ZOhP5QnGgYcj47nTMMA8gFK
         ArX5Yj1mdmOHjI6FdGLIChm1YmNHEpu8FO7z055ILS/UJNq4V5UA5JRTtUUwQHOgv8c0
         zWdTjTZIuZK1vXH0IE6PkGunQHTLza9d0DbPOKty2YxEPexmMzkJVrvo/vHUpBI0qs9P
         Zd/Q==
X-Forwarded-Encrypted: i=1; AHgh+RoYyx8kR2dykst61n+e9zoLtwvs8YyCEpfzcfmx45/sjn443lOlv71oFVULjy32Y5BNFYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNn+/KN8/9q/cCWtarMpdKz+kubyUOojimBR02rORSEMvPT7Zu
	6aNrrrc102jGtpJsV7BzaFuA7PYBsiHx035VJK+fSKaUO2GrVqN/oVFVavlA3VB354p+fgEtNMT
	8dUfuumsCtgfgqo9g4B+xA/9t+mJfhavT6hEP0ynBZA==
X-Gm-Gg: AR+sD10pT9K5qh7YuedxG5EFEOwgKQDqH+99egpIGbhhTLPiiDVuTAwXE+7sehwvokT
	caWIOhK4nMVoDvQ0PFZuJvMb19K77MzltYzdlhrU+djMpVV3YLUUkhZd4Q/SoQCAfQJ3jsCDOg+
	ndwhM5EaFKAnKujmlXcGfon34MenOHJsXC9i0wPBiSSTNAiUg5JdR+Q4uaMMn1ToaHK3Vmfftf0
	lFMLxgyS5xPqsIlbM72r8mb9FvaXLNMaGzytkrS3sI2bmIF3dLwp5FSSGFZF87vAcfp6LEmxLSS
	9CuAWRMWFvrZerIriy/8QxURqkC4ZatMCx1aCqBUBJP7fyhgB6RVeGWqQnBrt/mmta+hYSxZQx9
	vWcrr6okG++ur3NQAJqxW5myu8zsd6A1ZymwZeXaVO+q8SRjgkPKGDCBD2HCSgvE=
X-Received: by 2002:a5d:588f:0:b0:475:da0e:744d with SMTP id
 ffacd0b85a97d-47fc8bd9a17mr1123969f8f.8.1785393391373; Wed, 29 Jul 2026
 23:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729232527.139183-1-inochiama@gmail.com> <20260729232527.139183-5-inochiama@gmail.com>
In-Reply-To: <20260729232527.139183-5-inochiama@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 30 Jul 2026 12:06:18 +0530
X-Gm-Features: AUfX_myMCEfrPFgw6hpa1bzA5HZDULLUkMJkPLOpIjbzM3NJsjXgJbt-fDAUHQY
Message-ID: <CAAhSdy3mzKDCy1zEpB7K7qJHG_mUThUu_bXwD+n+RjONPvtS3w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] RISC-V: KVM: Mark the reset callback of FWFT
 extension always dirties CSR
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 4:55=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> As the CSR is only flushed when the csr_dirty is set, always set the
> csr_dirty field in kvm_sbi_ext_fwft_reset() so the CSR change can take
> effect immediately. This unconditional set should be safe as all
> supported FWFT features change the CSR state currently.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_fwft.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 56fb59afe02a..2e35e7e12327 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -601,6 +601,8 @@ static void kvm_sbi_ext_fwft_reset(struct kvm_vcpu *v=
cpu)
>                 if (feature->reset)
>                         feature->reset(vcpu);
>         }
> +
> +       vcpu->arch.csr_dirty =3D true;
>  }
>
>  static void kvm_sbi_ext_fwft_validate(struct kvm_vcpu *vcpu)
> --
> 2.55.0
>
