Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E743264CE
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791540462; cv=pass; b=EOU/KBAA+KQy0I1urd5nqVQs5OqWNIg3ycOL5Wr4JnWu00uNPvrJCzgnKTEVzCKwCQF/PcaCSNh0z26CSPi/AdCtKgK3wJYaXXHVCRE6mC8WTXmFwsXJl39auKvfIRWV1FMwJFXKdnky8Npv0EW1CvHyq8TiX9hgsBoeYmzKQqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791540462; c=relaxed/simple;
	bh=GkWN5edVJbSqZ/Lu7tScH+pETGbwVkwJGGt+4owIDBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ga+q5cc7Lg1TvDPAVbMUgFY4lZjBQ9PtbuLYlN3DMlyL3QvuhC+Ti394WdlXPjk9b5ByZs0kOZzs7hCMyGv/fMRM+2Yvia/l77sAcFErtmUoTZUKzv5+eeevJkINiOt11b3KU3eSTQFDLq0SBZXz44dQe7brAeJNsCU8ZOjydtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=dQvI6mN2; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="dQvI6mN2"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48bbb06e746so3352323f8f.3
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 03:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791540460; cv=none;
        d=google.com; s=arc-20260327;
        b=UEZlbNeRzUvfFZ0Im79cTdcVUNt5/NpN8rAvxw+cOXMfO5sglpNZzJ0ZJ0gQhx3x8F
         axwbwmVc51oKKfdta7uBLZJ5MikBGmIh/Lb4Knq8loUWYmYgCukmbVBJ6LSY6N9crBLg
         15TCgN/e4PovuX65vUCpU+VZAkRZwadgvf1kwrs6vWB8fVTA04rpWP0tyeN+Mg3IeKGO
         uuUuGyU6pVh0T2P9ugZPvS7SZSlj1xbEu6t4NLYpuZvXZ7i99oVCoxzH5H4b4ItEZsBG
         8txQ49e/TMLkt9wdMpaC22ej0X1a3YQGWXfogFctvR/UjI575qBxqqUmDTu1JDZzGKri
         ESlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YhlTmiSSnyAhAbjv/VolTrl3XZ08TdurV9y8UvnnMXY=;
        fh=nq997oMDRdkJA61j1i+V7R0ndD+EjdKRbjEysAyh1mE=;
        b=IUTwR3wbJF0mR8ANKz/+B5v0hAA9FKPfl2+Y/19vIEraLWTMvy9XTpT9PeAN+iSam3
         IgjG67VtFO4oR/1OoLXCTAPfRuzsUS5hMKsxaS8BL1/03zW4TU2sowJbOfnvF7aoh4/Y
         sX97UULQH1OOQXMI0zfCic/XgAy0aVUITJV6dC0riEyTqAB/Kd32W01hsci4G9GR5iyX
         lxP/1pnw3m5QqxpbmhoJpFnydY5IF1WgTg1zHA8Dl4Pcu3xp1IpoYRGUZ/UJzzRaCmvH
         Y+DKhpa7aWydBI9vVyY+PAtlaUaEDS8K/bRA64e5oDFMBtKOrU4wDGcXc6PLlZqKSe0f
         wRMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1791540460; x=1792145260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YhlTmiSSnyAhAbjv/VolTrl3XZ08TdurV9y8UvnnMXY=;
        b=dQvI6mN2hvS+s96iN4LChaWavr5QQ7qHRCpdgSVcsg5fttaoOh0V9CtjINEc55nNK3
         8PgJXjyIJF109KDPR2WX+exkr3xqnTt+cHOK2Qd38XLXCqwH+z516IQVaxuqg95dP7ol
         QAn3Ok2jb5ok1p/LutiWpL2WHkPmvzBTbSMO/paeCCuipcOHriVmy5Esjsan4o3Gxcbv
         JTpCFF+6gn/D+ZvIodigGuPCc+VJBXMjSzPgvkirq8P7J99CGpbKE6JX8p4JdWqnlJMA
         XEWAhparpCNh7U1tx2uQF/BPmJxisBudGDWza/mxluiUUig/FBiDnho/hHp5QWZrhZ21
         c45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791540460; x=1792145260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YhlTmiSSnyAhAbjv/VolTrl3XZ08TdurV9y8UvnnMXY=;
        b=2uOOeVk+420CoOKwA/Wnc8Wn//yOgjvI0+bBluJltcMmDBqal5bP1GXlO4JuRdcZaz
         4uiZiFKjaS8eFiPrV75IxjU+d5590SSrDtefhMPA2llB9qL1RNwT2CxvOPF4FHZ3lLBx
         SFzCIPpdN78sNWx5N9/RqGRv2rfBDtdMg/Un4XyS3fjPAj5LiSvar3AlmI3TyLir8Acq
         BF+2S5M7WgoH6Zl3l1ohOTFCbFmL09h66dvn+eeNviiJFdgaVj8pFtU4MNIZjVNdv3ON
         4mi5+CMXo3OnlEyouNGBLRsc33bhi5tagbzrT0OtTnoNbQJ/zpzPK+TEKNpdn3XtUaXk
         pSbA==
X-Forwarded-Encrypted: i=1; AKwUvBwzyloQVo4CtQeNET05xdZd+7DYgqJsCBWgY/u6nd0QZ5Cfn9WxtP+D19AW8VRuw/7ZfB4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiQvH2DzsNSAOHXdmTbDUjzQ6ZnenWC6rwdFIxCgLnn+sqJlYr
	9g6S5iD4bHD/XT7QF7NVOSx4uFbM42TaBzq/pzWB3yyW80kEhDSN3PyqrkwkDSZQuIy8zi5iinu
	y59CVUVC01TwKEEDd6c2KQJ4NTaLx06mFBWdyL2TTCA==
X-Gm-Gg: AYBFou3370ibk3SG1ZfJ5yqwBdQfzbWqhqyR8rbctLQUrBluJCl3++oNaZ+gy1REnra
	4UDX7sZom5ezHB8vVjIq4FH1a9FGQZRKCq8T9sPiaME04z8IylLO+4M80ZLDAT5Tfd9CKWNBMkc
	FxPf4i4dc06ClPLGNJksOaudeVS82sVo3bD9E33+4qZ5eu6x6+NIwt84Ef5o3CohKHCLru3+Dyx
	RvE5U1pWjGpp71ZPYZVVL5n5etgmZmJ83BtvYg1MN40zWYP8+KATa+/SpaBhK4EoTd9kfaMap8k
	AQmJN8FB6/vw26QIbiIMOrkHIfIZXFwIx3U+kIr9D+eSiRxcbxT6H0jd8Af6DdlLI5Y2/BNatnw
	UII8u4yXf90pIvbgFL55dZWfWiGIiQomzYXkQj4/oX6xV2UBUkrR5QBWG+tFGmlcj4T2prmsfIA
	==
X-Received: by 2002:a5d:5d83:0:b0:48a:efed:ac97 with SMTP id
 ffacd0b85a97d-48dba9d326amr2435668f8f.33.1791540458537; Fri, 09 Oct 2026
 03:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-kvm_kselftest_dump-v1-1-55b022c6ef8e@sifive.com>
In-Reply-To: <20260831-kvm_kselftest_dump-v1-1-55b022c6ef8e@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 9 Oct 2026 12:07:26 +0200
X-Gm-Features: AclHuK8s2qRUsbqTNG8YPqEmgy3yDujBoTHugKHr0lrqk5zZyltW7DxQdyuRR9k
Message-ID: <CAAhSdy3TOK6B5SUpFs+dQBzfLDy3-otMxTPEPwzOsoNsqY3cKg@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: selftests: Dump sepc/scause/stval on vcpu_arch_dump()
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, greentime.hu@sifive.com, 
	vincent.chen@sifive.com, zong.li@sifive.com, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 5:57=E2=80=AFAM Yong-Xuan Wang <yongxuan.wang@sifive=
.com> wrote:
>
> vcpu_arch_dump() omits trap-related CSRs, making it hard to diagnose
> unexpected guest exceptions from the dump output alone.
>
> Print sepc, scause, and stval alongside the existing register dump.
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.4

Thanks,
Anup


> ---
>  tools/testing/selftests/kvm/lib/riscv/processor.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index ded5429f3448..bf355afa8486 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -235,6 +235,7 @@ void riscv_vcpu_mmu_setup(struct kvm_vcpu *vcpu)
>  void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, u8 indent)
>  {
>         struct kvm_riscv_core core;
> +       struct kvm_riscv_csr general_csr;
>
>         core.mode =3D vcpu_get_reg(vcpu, RISCV_CORE_REG(mode));
>         core.regs.pc =3D vcpu_get_reg(vcpu, RISCV_CORE_REG(regs.pc));
> @@ -270,6 +271,10 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *v=
cpu, u8 indent)
>         core.regs.t5 =3D vcpu_get_reg(vcpu, RISCV_CORE_REG(regs.t5));
>         core.regs.t6 =3D vcpu_get_reg(vcpu, RISCV_CORE_REG(regs.t6));
>
> +       general_csr.sepc =3D vcpu_get_reg(vcpu, RISCV_GENERAL_CSR_REG(sep=
c));
> +       general_csr.scause =3D vcpu_get_reg(vcpu, RISCV_GENERAL_CSR_REG(s=
cause));
> +       general_csr.stval =3D vcpu_get_reg(vcpu, RISCV_GENERAL_CSR_REG(st=
val));
> +
>         fprintf(stream,
>                 " MODE:  0x%lx\n", core.mode);
>         fprintf(stream,
> @@ -296,6 +301,9 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vc=
pu, u8 indent)
>         fprintf(stream,
>                 " T3: 0x%016lx   T4: 0x%016lx T5: 0x%016lx T6: 0x%016lx\n=
",
>                 core.regs.t3, core.regs.t4, core.regs.t5, core.regs.t6);
> +       fprintf(stream,
> +               "SEPC: 0x%016lx SCAUSE: 0x%016lx STVAL: 0x%016lx\n",
> +               general_csr.sepc, general_csr.scause, general_csr.stval);
>  }
>
>  static void __aligned(16) guest_unexp_trap(void)
>
> ---
> base-commit: b5060a4aa33d7d78a8c1837ab08ef0c81ea96650
> change-id: 20260831-kvm_kselftest_dump-3f8d4daf5c60
>
