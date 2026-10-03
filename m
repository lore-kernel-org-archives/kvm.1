Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79E35E95C
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021723; cv=pass; b=UZpJu70kLfl1K0J63WXmhQEz4T7k4uYsw6zjVp4Bf9O+gMoks6VEJmqyaDxUHRMY2337vpq/hBwsKIkHjHfbErHoAtukomIjlEEd8AT7NOdDS9GTlMPWauQ6LfVvXZi1IT1aoV21oslSpP/0GbtczUrz3LYFU7z7yEKq3Zwg8fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021723; c=relaxed/simple;
	bh=9i9dctui2j8y6dJnAzDejHHRA0xGrLuN2S3+baGa4zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pfbcww5G3xetwTyGfO5T6gXW/caBhLQtkf0JmzcODQwnqbVs/ErE5JUfzpy1SY+/T4GugZk9A8FOJipifOJHw842zDsYVTX1BAcFVsnaPAujfPB+VE7LmLTEQ811vwYABWdKXxLuSWIB2tJgFD+RUiuxC5EopG4uc1h5oFskH60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=l+NAwLGx; arc=pass smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="l+NAwLGx"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af5ae31d8so188351f8f.2
        for <kvm@vger.kernel.org>; Sat, 03 Oct 2026 03:02:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791021719; cv=none;
        d=google.com; s=arc-20260327;
        b=KHtCXIv6kXjNR5NIfvMvO/kGcc1SdR+YBXp7kfLVqw6J4yGQlA55QHSB+tTAgceoWv
         4uR0o0cSSDgUGjaDUpAMzDg7DK8attNAs/hRrc6GMHK8ngzMzdvsUlnr4zwzxw2URTmZ
         80UOdKMNWFASJolEJN2jYmSdO/whcRf0jWmGB+d4fNOQqwXulJBqs2of2blKpBctCGz0
         VZCm37h4+1yEuLHzyC8Lnwu0C0mjgnPhbYHhHi04nX9lnebBCMpeg2FAX+p3NioWA+UZ
         x/ISKoLhko3Uslhs1uqsFtD9acmXfxqg3wAwfxToO38ACIkvRgCpFUDT40me4hbr9Gnt
         /NmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=toFwkFZa1NLpcYuyov6v0MW1/I0mrWgEqkrs2TGLYcE=;
        fh=lJzdj10uYBnv7TfxiDjFy9LXjO11CJXyjMn5LbTR1KI=;
        b=E5gVdBRUOG5BGFxdPM0ivL6BuiWq4RjKg2uGn8hvJgo+QduaRqJ0N13V8gJu1W8DyI
         0oTZZ/cACa/GhNX1miEiyYuQsJ/TcfB0FUxYzuIG8ng1o2Hp6fJqQR2bwxw5SqtvqQpV
         aJYGgi2qJpdCmtBqCbb3y+M6PyFU5A6NkMEVQjwd1K0EsnMobymQcGSz9pPSweVcB82h
         bSz5V9rhk4mYdKcZG6c6Jg7xaOGEQyEQ9ZJZs7q61h0nyOODCBCu8B7rat+/lFiiWSYd
         kja20QuigWgLe4hqNcypt7Ao9r7OP3DFWF7XlcbpKUnATS9Tj+poRDS7+2JwXXz3azOc
         aOYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1791021719; x=1791626519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=toFwkFZa1NLpcYuyov6v0MW1/I0mrWgEqkrs2TGLYcE=;
        b=l+NAwLGxdMy+Mo11c5SuNYUk2++WL7MD1Rdxi+J3iKTe8Z4ep/pDw3/22Q34H5avWv
         kilKLN46bSt0zOfv7hYf5tX2farNlIQ6F+5cj0/RR/mJj0d9IMCTOr+kHNm75+ibt0Vp
         9RbK6W64x9BBzvLYcU6IIkjvREjMbKXwmaRzQUsE7LVlgAKWROzsVaYxp8uv3Gf4U+rW
         t9rCmXsV3j/K2YbDs3PZQIaAIytS1GebDYV7eAwgPGF99NK6ng5K0mn/XqaV2Zcp1XjN
         W52rKq3yXAN7/ZyFB488xjpIzpY0LGgGWp7C51orolalYTJjnVBb+s0GtBN7uzHaUz3y
         FE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021719; x=1791626519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=toFwkFZa1NLpcYuyov6v0MW1/I0mrWgEqkrs2TGLYcE=;
        b=mNGevhJZTK8uGSTTKNLiQkFlrVrMy5IpqQ6b7XvbEMBPOH+ipHj4zJTe3E7A2DlAld
         eRRHDbFRMfRwFSGcmqkV1U/mtJO11E8HK8oF3BgysW01JK2nIP2HueeTIb5yenygkPXi
         E8GAh6bksPaEBkXxUwiHpPxGbMHogBLQyviUdUlAfNNEIzS2FbwQaYmcB3OmeK76z7vT
         mwZazz1VDd1NaP97TPWGazok4Bh9P9votiwXDY3d41fKl59h6zUBfGeWx6z+JouAyP1h
         AUHfE/WFKj+IbMk2EP9rKx8lwh3r4EszqHSN8A498j3uU7vemM782lZTAU7GRv5JBJmP
         o2XA==
X-Forwarded-Encrypted: i=1; AKwUvBzd+qTNV6J16TNb93vJVjISXkS+lWABfUpMN0QDeNyWkHAU+VL3CMFW5tjjMmvzxw5NN+s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjbAbqXjD14ypLaovSKHqMX0qT6ceEQc2Ch7xl211ixFtNkCuR
	JRbR+D4GnBDCVcp+MkZRB3hAjTleN31P5qPsKuSA+h3wqsGZWBUixdTTBDVaebk0FqCOnp1lAoL
	mSJ6+OCDsPhruVirbmSQ3o2Lw14mGEKVWVoOMEC6+Vg==
X-Gm-Gg: AYBFou1ifpFOUJEHiIdd4gdm5us6M5Tc1lsH6K8kNbVUptRKZ0IAcI4tP792kfqkhIK
	ZfZft9DnCpfG+E6dCJe4pj7HEjfL3mIlbESLqoFGsMLOatgjKuuXlqzaC15DpDHuGAOPJg9BH1B
	ZIfla7hIYoGhDirg8zlkNB7ANdKGbIx6/ur0og4prxiIGMf5h81tAv5LDYI9ZcCxGFHX1MMPTOc
	81vkIehvOfET/Y4K1gs9Tonu0vO0Qtimeezv6CzMt78APqFnua3q8+1lV/YSKdajk9ENhFEk2Ez
	EpDf6Wy4EdGZmmEXq5uOlx0NAFmxn2IdpcpsIx9g3ATW6E9ruHlbtXqjVxkLzmm8kYcPuh0Qh0V
	kEMVCImcFr9uTsEVNIjhB48r33ummAR/kJ54qsXYg/9zOsqP/V+elrcnqq2Dx6L6DIgkJQ1ii7+
	8=
X-Received: by 2002:adf:e199:0:b0:48a:efee:db70 with SMTP id
 ffacd0b85a97d-48b126c255fmr8787711f8f.7.1791021719467; Sat, 03 Oct 2026
 03:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814114507.583424-1-jinyu.tang@linux.dev> <20260814114507.583424-3-jinyu.tang@linux.dev>
In-Reply-To: <20260814114507.583424-3-jinyu.tang@linux.dev>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 3 Oct 2026 15:31:48 +0530
X-Gm-Features: AclHuK_dkAiQSJCFKF0TsjCXthGT7oWYDuuxVVTi1OVsI6Ecqotq3FhGa4Yyvnw
Message-ID: <CAAhSdy2rj7fV0_Apk79NQqdsTW4-tK1JLo9S7ty3JorfukSVLQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] KVM: selftests: Add RISC-V Sv57 page table indexing
To: Jinyu Tang <jinyu.tang@linux.dev>
Cc: Anup Patel <apatel@ventanamicro.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>, 
	Jinyu Tang <tjytimi@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 5:16=E2=80=AFPM Jinyu Tang <jinyu.tang@linux.dev> w=
rote:
>
> RISC-V selftests can create guests with five page-table levels, for
> example when the selected guest mode is Sv57. The RISC-V page-table
> walker only had index arrays for levels 0 through 3, so
> virt_arch_pg_map() indexed past the end of the arrays when level 4 was
> used.
>
> Add the missing L4 index mask and shift so selftests can build guest
> page tables for Sv57 VMs.
>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Signed-off-by: Jinyu Tang <jinyu.tang@linux.dev>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.4

Thanks,
Anup


> ---
>  tools/testing/selftests/kvm/include/riscv/processor.h | 3 +++
>  tools/testing/selftests/kvm/lib/riscv/processor.c     | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tool=
s/testing/selftests/kvm/include/riscv/processor.h
> index e3acf2ae9881..abde3c71c891 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -127,6 +127,9 @@ void vm_install_exception_handler(struct kvm_vm *vm, =
int vector, exception_handl
>
>  void vm_install_interrupt_handler(struct kvm_vm *vm, exception_handler_f=
n handler);
>
> +/* L4 index Bit[56:48] */
> +#define PGTBL_L4_INDEX_MASK                    0x01FF000000000000ULL
> +#define PGTBL_L4_INDEX_SHIFT                   48
>  /* L3 index Bit[47:39] */
>  #define PGTBL_L3_INDEX_MASK                    0x0000FF8000000000ULL
>  #define PGTBL_L3_INDEX_SHIFT                   39
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index ded5429f3448..b4d41a407553 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -43,6 +43,7 @@ static u64 pte_index_mask[] =3D {
>         PGTBL_L1_INDEX_MASK,
>         PGTBL_L2_INDEX_MASK,
>         PGTBL_L3_INDEX_MASK,
> +       PGTBL_L4_INDEX_MASK,
>  };
>
>  static u32 pte_index_shift[] =3D {
> @@ -50,6 +51,7 @@ static u32 pte_index_shift[] =3D {
>         PGTBL_L1_INDEX_SHIFT,
>         PGTBL_L2_INDEX_SHIFT,
>         PGTBL_L3_INDEX_SHIFT,
> +       PGTBL_L4_INDEX_SHIFT,
>  };
>
>  static u64 pte_index(struct kvm_vm *vm, gva_t gva, int level)
> --
> 2.43.0
