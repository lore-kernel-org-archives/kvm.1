Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4126230F7F2
	for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416854; cv=pass; b=AhgzdBCXOFfUsQRl9mXGzRT0+nOENYTdelQAHLPidTUvJpBeV9qK4sAZN4usR9mgz7TIYXX4DpG/ky1gu2IYkzJNvi3Svw+qcfTfV8B9lYCCFja3J0LLBEfmCiRUOqswuR3gbl9bJyO2BC6LxLMY6insAeJpl8szAmNJi+PmkT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416854; c=relaxed/simple;
	bh=GFmFHxmI99Jtkcntpamr9EvKSkRGfpLna86l6xN0TCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7q0w7717NX4oNVN0owLgTo5A5MnzsWFQv7LNTPpoEPuSpcM+Iyudt0GlUhv10sX31sjUzY3lFIK6Ta9eV0PmnpyqZtmdW7dE6C0P79v7RDEcMb//MNlE08bmjwU+uqgc7dJbbkTOga1x3LmO/m2QRBcwHR2lVg+YQH9pZKYm2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=x4eYuXOv; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="x4eYuXOv"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-48650c78e09so778842b6e.2
        for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 23:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781416850; cv=none;
        d=google.com; s=arc-20240605;
        b=SAKmRBqPbtCTlGb3gEEWr4HkHfNCKk2Cc/CTrzSN3dt1OmlbAt9UEClzV5J4UezWqu
         XXzxL9nWTXyCXvsdA/KJPlt+F7k7dqxBYEDfTafJnKaPBP8OLZ5LngDULlCwHZ3nNHkf
         dgPqiWbc4WKQ5a94IIthlFZeg5et1nqZADJcUTE1BLUxfLaZtHty9SrDjfXnoHQw6lW7
         eKXnliZAYd8vUeVL6aCGCkc1ooU0LStNUKNPKXX2xzLCOhpskA72b+nwl9CvVN6CJREF
         dny3WUJi+NpcdzharTM9pl4aATyEWr6rGzjU67I2EfClLIRyMYziN7eDqvYbmb49DKVI
         FiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6aVhsTHtrBdLggpkvdt3o21vUFooCWmvJl8eOgwGC1c=;
        fh=xa7xa9cJ+KVmrOnfM6wo698EgSqKmOZ+/fuNriPqi/M=;
        b=Bl+AFLZWRSGjWa97V6BiZvAVVvle+BjS11rDIjz6uaFE/Z7MUTgMv5rYzum0v5ahg4
         fRUKAdKEm4kJP3Q10W99CwePZ9PSc/S/GC8XzbEdJI/jZguq1FVvwk/TJLs7r3rrM2gF
         6NHleuP5Aw+utw260VShslkG1VUzPgdzl1+DxnqXANUGrtbEiYiF1171UGQHvie+KPrw
         fChcw7oF2qQsbmZYKiW0CdFxMMA+aw1SKkXkRXxciq4ghymmdgnDBBEEWCO4dlr8tZnh
         vsyfTU9iXfspXPsZnUR1wC5AcESArMb0ngvBD18tsOgB3bvdpYRllAN9jTpcqdUavRlG
         WAWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1781416850; x=1782021650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aVhsTHtrBdLggpkvdt3o21vUFooCWmvJl8eOgwGC1c=;
        b=x4eYuXOvIiet0alM3xnQzbfE+uB5E4v0VQ5ChjvkW8Oz3sqnQxW31QS/3aLGac9XS1
         06XlFe8OMtlowgOEpbJK5WbFgEjI+AT5Rvf7dTY3S96OXN1M+lHRU9D0VutzNgPUOk8r
         EOEiproElThsntMGH0cMcxN+XF7ErznFdBJBBuhzoo9AL4vVwIQBUsz7+XK1f5gXJI1B
         isxtUdky8HgTvx0baE2D/kFceSJE1i9IGkz2X3WZ+HROqsJKIsCDpTi02FnrCrQ7Z/Lm
         Uh2fMG8NJJ0mglW7YyWkmkcl8zctmHKUIVLro/pFMi+WQgbE296vGRpti80yLGgDrkxc
         ueaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781416850; x=1782021650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6aVhsTHtrBdLggpkvdt3o21vUFooCWmvJl8eOgwGC1c=;
        b=TtBDP1jzx/rHqTIimR/AhD2y+l1CzaWikbrNdJ8clk5vbLdcN51WotCYZO3ethf4jY
         dHxV1NLpukid9wug0mbSdA+SvN2GNxk47S8Psov8p9bWASWG+CqeDM5aucGcRC62h8/v
         Q4LBoU1E89qWxOIbgZHcA7SD+YVvWTW3pSdsSCDAfA+bRJoOs8kIO3AEyl2Q4DiCMUEp
         4Dm9IgxSoD+xmDtjQ+Pval7QK+qVdfHwoco29WghpL0ia0vnWS4M9wYiSvyyiTLcunLr
         6TwM9ooCHqy76ICXiUEnRv6kOer6gpK4iA7hC5rwKiIwW8ixREffttH5zE0cA9/95DFk
         eoOA==
X-Forwarded-Encrypted: i=1; AFNElJ+6cbco0bhbXuFwCek9Sv/cltMYhdaH1ht9xxrh815tviFYifgFtTnhPlFEO73yiiQ52pA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+NLeqg5LwTOFmE5lhWMWyllp+8GatEZGAMZ858VTivN6Sz+7R
	OHxl2pOMz9f9uclL0wk81wjvXM5qgc9/9h1928peR0uXfzX6AHn/p34vbYNldIV7pyYn8tjSAbS
	2UH4hjIthlnC2VprTdOkgsxYjAx0a2kMCJNrRSh6+fA==
X-Gm-Gg: Acq92OFyujfSASpAPAvaxVcbMmvMs6SIJeX9AALbm1twngICsGan0ZylS+cmXlIXi4c
	2nL77PTCK6Rhdolh/qvdtTvQyrHLNi4xcHpnyM4MeZrEfRn9/jAZxN8HgX4XB9BNVPEV5Bk6yj2
	i6atqC7GNXjN0pq2qxnG3DmES+hynnVESe2eJUxfhoyclPkSKhqHQiXNE7qXF9M3QOWH8NaTd4x
	zFUbDpaMK0HrJ/spCdi23rJ5jxmdaHsyrmMVVYc6S1H3adGNVL4dnl/yy3y0B0V7/j3eA577SWd
	ybo+YyDs2hVuuqJxkWLLAtPS1DjPKZJ/NnwI1Qwx92g3DU8hX2ebYuMd4NN03L8Gsnpuy1AOfva
	vQz2N23RPjDO5PbASXxvwESqBz4Y=
X-Received: by 2002:a05:6808:1913:b0:479:d25e:9065 with SMTP id
 5614622812f47-4874193626fmr4089846b6e.2.1781416849782; Sat, 13 Jun 2026
 23:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608155252.4292-1-seanwascoding@gmail.com>
In-Reply-To: <20260608155252.4292-1-seanwascoding@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 14 Jun 2026 11:30:38 +0530
X-Gm-Features: AVVi8Ceq3OyQQIUIVdWs5NFiagGdQ8JYTaKyAaPM91EWXGBydU7G-cFUukPtTZU
Message-ID: <CAAhSdy3KxyhejM5J46pXMyQwVzaZ6USY_-ZHVeuBSEyCxwZJdw@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: kvm: Use endian-specific __lelong for NACL
 shared memory
To: Sean Chang <seanwascoding@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 9:22=E2=80=AFPM Sean Chang <seanwascoding@gmail.com>=
 wrote:
>
> When compiling with sparse enabled (C=3D2), bitwise type warnings are
> triggered in the RISC-V KVM implementation. This occurs because the
> user-space data unboxing macro '__get_user_asm' performs implicit
> casting on restricted types without forcing the compiler's compliance.
>
> Additionally, raw 'unsigned long *' pointers are used to access the
> SBI NACL shared memory, whereas the RISC-V SBI specification mandates
> that these structures must follow little-endian byte ordering.
>
> Fix these by:
> 1. Adding a '__force' cast to '__get_user_asm()' to safely suppress
>    implicit cast warnings during user-space data fetching.
> 2. Introducing the '__lelong' type macro, which dynamically resolves to
>    '__le32' or '__le64' depending on XLEN, and replacing 'unsigned long *=
'
>    with '__lelong *' to enforce proper compile-time endianness checks.
>
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.2

Thanks,
Anup

> ---
>  arch/riscv/include/asm/kvm_nacl.h | 14 ++++++++------
>  arch/riscv/include/asm/uaccess.h  |  2 +-
>  arch/riscv/kvm/nacl.c             |  2 +-
>  3 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_nacl.h b/arch/riscv/include/asm/k=
vm_nacl.h
> index 4124d5e06a0f..f45407bcaa26 100644
> --- a/arch/riscv/include/asm/kvm_nacl.h
> +++ b/arch/riscv/include/asm/kvm_nacl.h
> @@ -60,9 +60,11 @@ int kvm_riscv_nacl_init(void);
>  #ifdef CONFIG_32BIT
>  #define lelong_to_cpu(__x)     le32_to_cpu(__x)
>  #define cpu_to_lelong(__x)     cpu_to_le32(__x)
> +#define __lelong                __le32
>  #else
>  #define lelong_to_cpu(__x)     le64_to_cpu(__x)
>  #define cpu_to_lelong(__x)     cpu_to_le64(__x)
> +#define __lelong                __le64
>  #endif
>
>  #define nacl_shmem()                                                   \
> @@ -70,7 +72,7 @@ int kvm_riscv_nacl_init(void);
>
>  #define nacl_scratch_read_long(__shmem, __offset)                      \
>  ({                                                                     \
> -       unsigned long *__p =3D (__shmem) +                               =
 \
> +       __lelong *__p =3D (__shmem) +                                    =
 \
>                              SBI_NACL_SHMEM_SCRATCH_OFFSET +            \
>                              (__offset);                                \
>         lelong_to_cpu(*__p);                                            \
> @@ -78,7 +80,7 @@ int kvm_riscv_nacl_init(void);
>
>  #define nacl_scratch_write_long(__shmem, __offset, __val)              \
>  do {                                                                   \
> -       unsigned long *__p =3D (__shmem) +                               =
 \
> +       __lelong *__p =3D (__shmem) +                                    =
 \
>                              SBI_NACL_SHMEM_SCRATCH_OFFSET +            \
>                              (__offset);                                \
>         *__p =3D cpu_to_lelong(__val);                                   =
 \
> @@ -87,7 +89,7 @@ do {                                                   =
               \
>  #define nacl_scratch_write_longs(__shmem, __offset, __array, __count)  \
>  do {                                                                   \
>         unsigned int __i;                                               \
> -       unsigned long *__p =3D (__shmem) +                               =
 \
> +       __lelong *__p =3D (__shmem) +                                    =
 \
>                              SBI_NACL_SHMEM_SCRATCH_OFFSET +            \
>                              (__offset);                                \
>         for (__i =3D 0; __i < (__count); __i++)                          =
 \
> @@ -168,7 +170,7 @@ __kvm_riscv_nacl_hfence(__shmem,                     =
               \
>
>  #define nacl_csr_read(__shmem, __csr)                                  \
>  ({                                                                     \
> -       unsigned long *__a =3D (__shmem) + SBI_NACL_SHMEM_CSR_OFFSET;    =
 \
> +       __lelong *__a =3D (__shmem) + SBI_NACL_SHMEM_CSR_OFFSET;         =
 \
>         lelong_to_cpu(__a[SBI_NACL_SHMEM_CSR_INDEX(__csr)]);            \
>  })
>
> @@ -176,7 +178,7 @@ __kvm_riscv_nacl_hfence(__shmem,                     =
               \
>  do {                                                                   \
>         void *__s =3D (__shmem);                                         =
 \
>         unsigned int __i =3D SBI_NACL_SHMEM_CSR_INDEX(__csr);            =
 \
> -       unsigned long *__a =3D (__s) + SBI_NACL_SHMEM_CSR_OFFSET;        =
 \
> +       __lelong *__a =3D (__s) + SBI_NACL_SHMEM_CSR_OFFSET;             =
 \
>         u8 *__b =3D (__s) + SBI_NACL_SHMEM_DBITMAP_OFFSET;               =
 \
>         __a[__i] =3D cpu_to_lelong(__val);                               =
 \
>         __b[__i >> 3] |=3D 1U << (__i & 0x7);                            =
 \
> @@ -186,7 +188,7 @@ do {                                                 =
                       \
>  ({                                                                     \
>         void *__s =3D (__shmem);                                         =
 \
>         unsigned int __i =3D SBI_NACL_SHMEM_CSR_INDEX(__csr);            =
 \
> -       unsigned long *__a =3D (__s) + SBI_NACL_SHMEM_CSR_OFFSET;        =
 \
> +       __lelong *__a =3D (__s) + SBI_NACL_SHMEM_CSR_OFFSET;             =
 \
>         u8 *__b =3D (__s) + SBI_NACL_SHMEM_DBITMAP_OFFSET;               =
 \
>         unsigned long __r =3D lelong_to_cpu(__a[__i]);                   =
 \
>         __a[__i] =3D cpu_to_lelong(__val);                               =
 \
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/ua=
ccess.h
> index 11c9886c3b70..5d4ec15584cf 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -112,7 +112,7 @@ do {                                                 =
               \
>                 _ASM_EXTABLE_UACCESS_ERR(1b, %l2, %0)           \
>                 : "=3D&r" (__tmp)                                 \
>                 : "m" (*(ptr)) : : label);                      \
> -       (x) =3D (__typeof__(x))(unsigned long)__tmp;              \
> +       (x) =3D (__force __typeof__(x))(unsigned long)__tmp;      \
>  } while (0)
>  #else /* !CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
>  #define __get_user_asm(insn, x, ptr, label)                    \
> diff --git a/arch/riscv/kvm/nacl.c b/arch/riscv/kvm/nacl.c
> index 08a95ad9ada2..6f9f8963e9dd 100644
> --- a/arch/riscv/kvm/nacl.c
> +++ b/arch/riscv/kvm/nacl.c
> @@ -20,7 +20,7 @@ void __kvm_riscv_nacl_hfence(void *shmem,
>                              unsigned long page_count)
>  {
>         int i, ent =3D -1, try_count =3D 5;
> -       unsigned long *entp;
> +       __lelong *entp;
>
>  again:
>         for (i =3D 0; i < SBI_NACL_SHMEM_HFENCE_ENTRY_MAX; i++) {
> --
> 2.43.0
>
