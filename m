Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D441EB5FD
	for <kvm@vger.kernel.org>; Sat, 12 Sep 2026 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789197603; cv=pass; b=FA0gRRQObqZBd0kxQKI1CU/DL6FaYdC9p9lVstRDSOMwg9fTHR8QkF1zRuy5E3TOx+ecTMK2VMYYKtG72hN7M9dQ1rbV8xyISe0qan0oXE12GSbBPFHTOQEjX4L3SAKkGxsRMwEMspzMVPHJDkJUvXm/JlenUJ+veG+oRJkSk44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789197603; c=relaxed/simple;
	bh=96QqdAH+ut3FoNAu5P8fNecmY73HgWuZtIEXkBWpqh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enEzVzUzUpY7BlIcZFO2lIzWeJZ/nupKGuYlCqaPSPsqTqIYyI1VLHMBT5putAOjKHX37UUXTjgmCKa9n5HB2eNb121Jju7w/u+SIX3TWOosrn+Rh7LLPCZjNAFd4pikdurs6ia+SUdAEskArxjHULnIf4Jpm3NrCfdU7/OCs0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=ppJTEwSG; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="ppJTEwSG"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47de0093c42so1623010f8f.3
        for <kvm@vger.kernel.org>; Sat, 12 Sep 2026 00:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789197600; cv=none;
        d=google.com; s=arc-20260327;
        b=SCH5qtICWkmmzz5uaNXrlfQt6DtaMMtT6KbLxAzKRB/4ix5rMSvsynmsPGL0/KnS27
         BSL5UhBOQsriglc3hCQvtWN9XNNT7Fw6CIT/FxYP+AeUqCiPLDigh2Alx7J5HDQyF4XS
         haFcEjGeLKm3uIjdHFz50/J8MlWrNmHkoJYlWXhzdmKqM8QfCg6FVDtU6hMvvZpuvLNl
         oC4dTGyj+02lO40kMDqDnD8Ea2RjA8uG8Kl8yOOM9H4KEp/q5YbA2Qh0N+RzOV7fDl+b
         UfKP3vjH8GrcBsNEebELvy4b0KOnV286bjS3O3WX7/0qI53rr0sG4lazN5v8Z4Geq7RR
         0gNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+HCXtMkwPRPt0+8i1UnJyzIlexbsOaqziQRyoO3VN8k=;
        fh=sZZ900F05VmguEqUCX/OZNCGgZj7jXXENf6p6ESz+44=;
        b=Ci/kZ9qfx10PEMu1SxEZ5FrKaQOBDDzWMmSy9LjxDtnmLblpkO4PHIP2sECuYfz3rj
         8IaZt7+bipEzUgKxv+VmfFVBxduQaSfSflJHGvyANtVo8tZujqhWaYZKUR7Kw/mEzo6k
         PGOlK+Lk+iWB0aO0PTjG30LOWG/C27O+kmgEep6BfoiULd0qjckmhypffKzDuinJrdgp
         sC6aBfaDGuQiMbhGB/Ok5ZUeiXeI9NNhJiCNaC/3cbFnTXJyB+6nIr8tNbFG6Qyeu9K9
         t6XuLpihoyVQ+xUVpe0BAz3TWPxUZ0WERzNlifB2+YKTQOon28xfgpeqt+A7WjA/c7Zl
         phHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789197600; x=1789802400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+HCXtMkwPRPt0+8i1UnJyzIlexbsOaqziQRyoO3VN8k=;
        b=ppJTEwSGUgr/ATI3/8AmaI/wzOXHMeTZiqeuiisUik103k4Iuk36bllz65KzLAtR4A
         Ns5xKxVsMblItnNY2rNwGE8nQ/EkjiUpkfOSN76BGWUx5zwFmS/Bp6ll1TCde2EpXViv
         4AItdjmAwN7Zd/bWaRfGUjIIPimTei3mrR0Cg0ybvfSi2Wj7B1LAhDFhk77Rj1OJXP0X
         sWIx+OSL01oXjZs4HI8Hhogi7/vrVqR+mFECnvX9C+1OVyRvu+e7FxX0mJS5ErIKhxiG
         dOimFqpJiMrYrSQ2BA/nTx79Mbbft0YGPBux24Zp1acD6XyeyBt3Y1TVW9sLc2a5b7je
         gjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789197600; x=1789802400;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+HCXtMkwPRPt0+8i1UnJyzIlexbsOaqziQRyoO3VN8k=;
        b=Ib6eFwZ9nStyHg/tmki4bxIxUCnXFAZLf5J8rbck7QZpG3HRh1P79o5c0cUSH7NzV3
         52iqcS9vJSlD/7u30R0c8psvxyCvWDzAqeiHsaF+ssYOBBl4r1vkGwCkIHGoRvo7JNd3
         pfDUBO9jMe35DBZLGEBCcYDAwzrl0TbnvlX+ihuejKQxnRQ9+do1/Ekcb81tdG8bN8Z3
         26Z0lS3TArFE30tlEUXo0jJBmyZb/x9qOnjgSdKyeE24bhKZ9t6dVqP5dmsZ2JEUPePv
         YWeiL/krvO0jmqlwVLACaEMyBGjZzVdX0nMiN5FwYZ0w2t/iqbrCiocp1P2FIaEkZvUc
         utGg==
X-Forwarded-Encrypted: i=1; AKwUvBxTY8Pdki8d2RsmeWVSZI/Mv0vk0SHUXx5tBqp2UcmCRT1+PpcG6YpiAJiIEkQyYh3I5JE=@vger.kernel.org
X-Gm-Message-State: AFuF++monc4IfFJgS/blhRZUh6zbzInW0sDgOVbRI+ddVoiRf2x/9bku
	Mq8zZnAV8LF5GBN7a3y5y71Pv1oAOjiZJE2klbkDHz+SplzHBxA8QRm8Hl/mafvRbtdsUlzBa5l
	6YfbwuLI7eKkZNgNgW75tdWpVXjMmvxiN37hOt+WBqQ==
X-Gm-Gg: AYBFou1c1dFYGHUpyqdTBKQfdFdIuSW39IhVSCUx1h1Z2tqDextkm5qXBvzX77R97zt
	kewaK1hYQZQnBF4jWx9eJ6vm8zzuRcuMh3E1GGVGK04aUbcLaedeZmARqCFN9QF/lLLKQBnm80P
	wjTNoRRwzhiAfRgpco10FpLsAb7Mnj4XdrDbBRY/rgdx0RqqExttWOgDnwtEapOIscJcN2rJGn/
	flcJ03bEFp7NHmriFxDATfZYw4PlPwoknCaSpxLdKxMOcSfYi7ZlDmO59OqkLzfT1m+rbkitJWG
	7T7mIOXJZcju4+SBmW5W+rmSdtm+su9ssHQjCjsOR6rdKJCo4pf2meI5Rmi8eZq55U14jvvM4cY
	vzMUPobTDwuZpdShk71ruPxIXQXsHjzTXvOCUd5RIlYg5aM8QPjdfISQu7OyhALG8VCHQrDwPDw
	==
X-Received: by 2002:a5d:5f44:0:b0:486:ed36:bb8 with SMTP id
 ffacd0b85a97d-486ed360ceemr8264961f8f.29.1789197599622; Sat, 12 Sep 2026
 00:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <caplitmus-rv.c91c005b844342d9a9f60949b04c520d.d65@163.com>
In-Reply-To: <caplitmus-rv.c91c005b844342d9a9f60949b04c520d.d65@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 12 Sep 2026 12:49:47 +0530
X-Gm-Features: AcwNN1VonCRcgUOPNOO0ybAk3-QpJzTjEpr8-CCE2ai98LUN-VM9a568vF76B6w
Message-ID: <CAAhSdy0cnHwfs5hRfZdq6WAzrEobqcjYMuv1oAmvRk2pi2zkPA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Publish NACL HFENCE configuration last
To: Pengpeng Hou <hppiscas@163.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 1:37=E2=80=AFPM Pengpeng Hou <hppiscas@163.com> wrot=
e:
>
> The SBI NACL interface requires software to write Page_Number and
> Page_Count before publishing an HFENCE entry with Config.Pending set.
> __kvm_riscv_nacl_hfence() currently stores the pending configuration firs=
t.
>
> Write the payload first and order those stores before publishing the
> configuration word with WRITE_ONCE(). Use a write barrier that also
> applies to UP kernels, since the consumer is outside the Linux SMP
> domain.
>
> Keep nacl_hfence_mkconfig() unchanged: setting Pending in a local value
> does not publish the entry. The shared-memory store is the publication
> point.
>
> The issue was found by our static-analysis tool and manually reviewed.
>
> Fixes: d466c19cead5 ("RISC-V: KVM: Add common nested acceleration support=
")
> Assisted-by: GPT-5
> Signed-off-by: Pengpeng Hou <hppiscas@163.com>

There was another patch from Zongmin Zhou which is relatively
more complete hence I have merged that one.

Regards,
Anup


> ---
>
> diff --git a/arch/riscv/kvm/nacl.c b/arch/riscv/kvm/nacl.c
> index 9aff03c4..c5c4907a 100644
> --- a/arch/riscv/kvm/nacl.c
> +++ b/arch/riscv/kvm/nacl.c
> @@ -5,6 +5,7 @@
>
>  #include <linux/kvm_host.h>
>  #include <linux/vmalloc.h>
> +#include <asm/barrier.h>
>  #include <asm/kvm_nacl.h>
>
>  DEFINE_STATIC_KEY_FALSE(kvm_riscv_nacl_available);
> @@ -42,12 +43,15 @@ again:
>                 }
>         }
>
> -       entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
> -       *entp =3D cpu_to_lelong(control);
>         entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PNUM(i);
>         *entp =3D cpu_to_lelong(page_num);
>         entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PCOUNT(i);
>         *entp =3D cpu_to_lelong(page_count);
> +
> +       /* Publish the payload before setting Config.Pending. */
> +       wmb();
> +       entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
> +       WRITE_ONCE(*entp, cpu_to_lelong(control));
>  }
>
>  int kvm_riscv_nacl_enable(void)
>
> base-commit: 4d7d9486c04d917265f64c55bd23b2cc4fe7749c
>
