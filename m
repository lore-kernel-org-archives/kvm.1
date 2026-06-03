Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2473FE66C
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472789; cv=pass; b=C/hVq0+hRmkIj0uZY3h3nzIUy0Pu2+/fhbwIZkiYb30MyTvDChN25K15pqFOksf4ebDuiBdotI5SUIKpOpd/a48ksHWr9QmjUZW2vpyHv6uQ/Ub8ow1ixcJxK765820zP61eN8OZ0ySjqSwYK30iJLTdcZfsZLXRDaJSscMVZ+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472789; c=relaxed/simple;
	bh=vUNiv8dGJzLhWKIn3GCL7icdX8+PvKlJdyBEHffTZlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfCyyxt8WhK0G9uGmCbNPNo5WFA9+6iyIaBWI1LKBOUYlakYGR43J53mtlNv53LCK4KAAh33Xb4vpRUSmMEw77SsfMOFdzJlrYYQVWhLNitqU+xFANm+DBCv5GGmi4fw/rivv+ki81q3bjGAM/ze6BpZIDPWpjMBQU2XUnL4om0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=vLZjlhcV; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="vLZjlhcV"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e61da76fd9so8290572a34.0
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 00:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780472787; cv=none;
        d=google.com; s=arc-20240605;
        b=by7hNkIhgeikCI9iv6y4UEEEzIaB6xxE2GSszW1WQH8cjKLhKKqQdHKwfXSqEYYOCC
         ZqElKceFhayG7kcN4mU5UFua3j4IQEOMTJolM1m40hUDFw8WL9E1hvmXMrXp13Lktmi8
         oQcrihUx8aKGGiiB1kDblnQ6YJjI6LONz+eH/QhBEuOTJjZfwLze12DKTUpbcTiaCicQ
         h0e2pP0iWnDmyeL3jRTIzk+T48OSkgPLVvzkW5nzvreajqZ2JuPrmT9+M2hyLWp+D9o7
         BerER3GZ1voD6L8hz/MJyYf3+yGrREzpynWc37x/O81NZrE4nOfYwAJjRGB3bGI6Qxaw
         ygow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FlHY9eiKKORvzxUtme3s/BJqGjxsKo0G5TMvkH2vdGc=;
        fh=lHUcGGAz+sai1D4KDSJfvKdwsVyNO6LpyWzyj401uY0=;
        b=Wz1C9QpK74L/qOVvOx3bZ75pfPhwDJNs15PlVvbtsQfn6gkq59tVqiUBdw4N5qx53v
         FRYC/EzRHuRp9ib4PznJQr6OWSSKZBZfw59I0m6ZgJGxAMs7MeGftjC9O0yFRBA/cBRn
         pmnvIpq9oripiyJUSy/AmpEBS3q186gdJDybI7xsv4Cd45CqPKfQMXR7DcwtrzoBd7eI
         4+MnwRerDnAX6mkVxM6r45jyzrmalzF51SKiZt12/U9ln1XmlWSHTwmzInmlZNlCh9Rs
         YfhZi5Fu38+9w+S/ORIvUMz4T3zJr+Q2YMWn2voHzyvU0j32cghFv0l9EksgpdHKzsFl
         fDjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780472787; x=1781077587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlHY9eiKKORvzxUtme3s/BJqGjxsKo0G5TMvkH2vdGc=;
        b=vLZjlhcV8yjVOVwMgYsyxQ6BwgsRgv71LxgjTYckXEpwfYS1qSVGi02i/smI5QHfEb
         y+V9ICaeqBYKUAHgGdso8/ugMMPQA3zf94cqt6v0ayn4SyTihJpUn3U2BPLjrgrhX/ZO
         jj62f78gwuGqic0Ikdv8onlGc2qaX6L8WdNdggXygYJbl4xzklKSueAA2TdAH7IqzT77
         8Pax0rCZgNR8MzDYsXphO5srZu/9UoE/VkzTlFRl650efldY6zycEnr/GAQhCFIJMoBg
         B+iQTrbcdMbtBbAX7LGwqFonMj+YVM5e0n8Fca3ZnIa7shsFGTVwNTlSO/8fzczs9i9Z
         cfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780472787; x=1781077587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FlHY9eiKKORvzxUtme3s/BJqGjxsKo0G5TMvkH2vdGc=;
        b=PxqHuipebRN1RSNqhT89MYMHkQRXDDXlxcr/IOfZ22PoPaGseWhG/n8JZ2ZXMefB+K
         JrzbcXGygtjQOPi7MSYZd5H+kloCwz8ZR881RNR2wLm2h0/i51ditQfe7gCVTJ5FntI1
         82pMcuT38qwzYFgmiLfH3dA4NNpBMTVe3qeI0wjaZkRE3z6KEbQPgSzM4G/bbmjJM5dR
         D7Vm4p+9zbuK4858sVua0puYK3VzbkyIze/f3V+VuaDWzg1Csa88D7WBaeb4jlQB75WL
         RFSgcijIXnmlmWOvMlhhzOj9j0TRHS6w5UMvRCA8LWFuf1GQ0l5ca40jFxULChblnL3y
         iFkw==
X-Forwarded-Encrypted: i=1; AFNElJ9EuvYU2RvJgC1nvGExIsGi5PytEn1zorlWENEXgr/JckrvqOz60VZc9J8zhpW3E8J0nRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD7lgMfPvrQFL09h/kfsedIdKB63vklYWo97rftOfhTyduQhA6
	GFLVyFlVfaqxqU/pTrfFYriQLCnioCMBmF4nqoLsFDvL4MS10xvD48cVRdxiNKoxPmxla5GlajX
	EqMIXsC+t89/aSe3Z5RKPPUy/GFcq8/y2sw5WYlQkvgkttBsoKdsx10s=
X-Gm-Gg: Acq92OGA1/7EJMpHDPBpL02orLsPic16HZ4o8cv5KF9+fiNvyAB5/rKi6Xf5esJUdGD
	O35GwjULMsABPfoQscIud0WgcMY830AvptHllE2yTBuPZL/MHd2q0sQNctE7wi+d6PeLyYsZmtZ
	qcU6Dg82+MezppNCqyWCrDzbYKi7VHg9/ng6R+xA3z7T4LUbP7JgqrWbRohcdBthoFCa0LjPKtP
	xUJHwXutKEtmIDy0Pxy/wogjV4l84LNGUaHHEKlakjxogHKB4vozKmHclDAN82MVLFn8loPbrtX
	IPcuhlpfJdxJzhdan1ycYwzd7qOrk933BLURqMvhfe6P08/eFjWyISQqGy+Mt19SaiXaUaYMgtI
	pBphifDMTGyU9jVTKfc9Pj6EzJuYTmpCi5jPuJg==
X-Received: by 2002:a05:6820:a113:b0:67e:eb4:238f with SMTP id
 006d021491bc7-69e47ebb7c2mr1148163eaf.18.1780472787482; Wed, 03 Jun 2026
 00:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601084336.2601675-1-inochiama@gmail.com> <20260601084336.2601675-5-inochiama@gmail.com>
 <ah1pgb4S-UoSWhC_@inochi.infowork>
In-Reply-To: <ah1pgb4S-UoSWhC_@inochi.infowork>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 3 Jun 2026 13:16:14 +0530
X-Gm-Features: AVHnY4IXk6Xj-7gKzaesDTTCYZDI9ERPTRAVFn1Ta5l01WccpSIZ_xwI2pHLbD0
Message-ID: <CAAhSdy0ZycwjYrKowzaydKhh=fcEDD9-C6TKmb838s0hq8a2hA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Deepak Gupta <debug@rivosinc.com>, Thomas Huth <thuth@redhat.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Sergey Matyukevich <geomatsi@gmail.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 4:46=E2=80=AFPM Inochi Amaoto <inochiama@gmail.com> =
wrote:
>
> On Mon, Jun 01, 2026 at 04:43:32PM +0800, Inochi Amaoto wrote:
> > Extend the KVM ISA extension array to allow KVM userspace to
> > detect and enable Zicfiss/Zicfilp extensions for Guest/VM.
> >
> > Assisted-by: YuanSheng:claude-4.7-opus
> > Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> > Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  arch/riscv/include/uapi/asm/kvm.h | 2 ++
> >  arch/riscv/kvm/isa.c              | 2 ++
> >  2 files changed, 4 insertions(+)
> >
>
> I have forgot to add CSR_SSP to the context, will add in the next
> version. But I have a small question for it: could I reuse the
> generic subtype or use a new CSR subtype?
>

Add another CSR subtype for Zicfiss.

Regards,
Anup
