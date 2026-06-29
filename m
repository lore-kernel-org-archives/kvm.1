Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545113438A2
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764457; cv=pass; b=uYF7n6zV+iySruckHTDXbRwrErhdDmI3r0lpaOU7u2DnO49W2WuawfD3ur5hR8+LXbMWC8Hf2cGRtNL9II8hFOiPtrnTM6Ia1UIw/0gafCZ69r3vHFVGXfLa7NtYTzf3ngFP9clqMGyaiOjtRxZIwu2c+xfVY2Cm8gP123ezSno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764457; c=relaxed/simple;
	bh=841cSuiWxfQc2bs8PUx913qlmkW0O3hz7zM/abZtsNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiazN5idfxZsRs8f63JDAJNsFEAzZTbNqFkniXJVhsuRRoLhi7NaUldqbGxZBvUYwMTjxGS9Npx/Bs/8KECbUfhPg+0eP7gL7xuHW6q6En//BDPVfEHrHuiOLUeCzrqF511FDaCj+1dRvuW4dTEEV0yD7YWgzvSnVD4unsm1lYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWOKXuuB; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWOKXuuB"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-461edb387ddso3595342f8f.3
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 13:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782764453; cv=none;
        d=google.com; s=arc-20260327;
        b=V5z8hJbuHxojzsncqMZc/GaqlTC2s+v/P1CnDg1Oh/FYS3sk006BoD98Cczq74FIvN
         jFMUx6ifCzrL+lPvsLiihr8rnpMs1y8YEw9PtQict2gy/PKCVfZ5ezgrnD8psm+fUIvM
         wWaRqwhgKlMx1VE+quTtX53aiXfabG+EaryjMLzbibAqSOSJ6XTaTrXDHjktm+QELOG8
         2s9wZfamqjehPPFEPIo4J7VgBcuPVKLbqtIcD95tCwd+mU8kdru7Oqw/lpKfLGl1Sfdl
         wkhT/IiOcY8tI6eAGZAWunxHHUXbp13yDZANo6jiAbvTD6ilEQ1sFXbm3RSqcCiH6nl9
         5Xbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CFs/yfWuhUwwa8R1BUL99gq564DjmPBXTx3kH108pz0=;
        fh=7AAVu398myGaakie3ZbGSWJPh56wRBTxfQYsq6Fg75s=;
        b=X4mnx29Fr3MuwrFy1n05IhV0xH7EmYA9SJJf4xNz33SpJXPC9DNsf4XGqFVKzUYwR/
         aEKEfd40iJCL6mAimfkqGFySsotjCY0L04QQ+Y71TAqEJ6ofL2TQv1EmKP0v7hBiM8sS
         c0h1W9AhcS1omQ6Ku7U1knhvHXBBnIyNchtPynX32JlG1XNjbWpbnqUGZ++enOQBEptq
         xXL+AeRP5EBF7VaNyegFSm6iEF91gO9Vh2neVAwWXfeqZFxxZKTXprDsjaw/Ym80hYys
         9KPOp1XTSfSnsVbB3+Wh5W6NWJP/0Lcv/Q4QIioZ1kHYSpAJsaV6i+KxgDAyqW6/SlIB
         PYxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782764453; x=1783369253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFs/yfWuhUwwa8R1BUL99gq564DjmPBXTx3kH108pz0=;
        b=fWOKXuuBuIBDM2z7ggXsBPodVyazUR4hY0VcrbBGikSvWH5Bas6st9FEW7mQ/mWbaN
         spRezIohTU1DzW5uhJVq+JlVy9bL00oSfNMreIyUw2KTXpMWTPkQysEYww5faL1p5f/o
         zIFW+mCZkMrnwjvzyBZpGc+s9w7aXZjsO+zPc1UanCmNu6eNF1dXCIjxCFx3lmxdF9Iv
         U6sKAsyiTrBUqd1STUbXF4jKVRhiatTFBM2ugn5acNxS38GdQ/LYNznBo3fDwDmI2FzT
         uR7OzrS5k422663WUa1Kwc4Rahz+/1p45/Cz4I3S6OQ7cYXegDbJaqz2lGz5JD41sOjo
         y4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782764453; x=1783369253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CFs/yfWuhUwwa8R1BUL99gq564DjmPBXTx3kH108pz0=;
        b=KaYufJWHBF6+12gqfSQo66zip8Y/+omM6jsAl6rqMPnDMtMm/1/PLRQi2j4qwejQqz
         GZJSgbB0NWBEpF+uYmvXwQo41+rK5mtpAcDJ29Q59+n0i4vO3/wpyWzNs56U7eXBh8J9
         4sMgops17ZXS3mFuF7Vqi9f9YNlYi+KVAfK2fAiUfDsnwyretpz1CGPu3ze3272w8weS
         GquK419oR0WeU85PYJQfMAAkzClpu9ZoPaCytuVuYYNTBEDIYnYIhJFR3Qmz/6MZsJX4
         7EGnja7eR04xqkXndzHOIicUbOwRQyd6xGuQqVfWWKs7OP+lMWKWPkCy5RBLEbOs7RTv
         Cn7g==
X-Forwarded-Encrypted: i=1; AHgh+Rp5oEnuQ04OrdXAcieptaebik6g6A3girqTKQedCbJnf+iDUYWy9iNsuAg/Ls1lCM6WTAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLfm/ktK6wSxAKBYdic0B7ezxT6pIiBusKWrcNzJ2CeiT9JnS
	XiWT6RqQ2yNVeJ6Z3dkB/+0Cg5Bfl9Vc50JU0NZ/HY4W5whEuHKOzHFvpjLkdmxRS5q3NwjpY2o
	GUbkCkvqnREHmPb+i/swoiVDuZcpUGNY=
X-Gm-Gg: AfdE7cls8UwnCdSu75Ka8UHxLFrX1EmqZ2fpRiTJ2w3Cbufa7+PvCDrZd23ZtWVADZD
	jwFIyMfT9d3SJUjG41kcXN0bnbqt7C0mS55ZegNRyejTXxEx0tIkoyjAmWjCs8CdGSzADnE08GC
	9Suuja2sSQWwzDud626DbNLHcBZ855Z8QH5Xm+qSoyNv4vZHke+URU8z6IqyhSaWOX4DH1lkU1m
	0h1GgDkCdpkkOuL0fZKRS/HfyHW5kDurWGTdw3z2zfvdlUoQgkWaXXrNoPh6yW8IF7DWUWztATB
	kLjnySGuhCsl/neH1AAi+zCBML5tkA==
X-Received: by 2002:a05:6000:27c9:20b0:470:eb60:bed5 with SMTP id
 ffacd0b85a97d-4755117849amr648521f8f.20.1782764452460; Mon, 29 Jun 2026
 13:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com> <20260621-riscv_insn_table-v2-7-7f0810ee2274@gmail.com>
In-Reply-To: <20260621-riscv_insn_table-v2-7-7f0810ee2274@gmail.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Mon, 29 Jun 2026 16:20:15 -0400
X-Gm-Features: AVVi8CfDVfYDga5-lVxUUxsvbnGGVBUwFyz5QNZw1Fs5Hnp0CP3OBY-vABw_urA
Message-ID: <CAJFTR8Tb54YPUQXiPCRq4XsX-P_vSyS2W=HThvEzb=BLn2Cy8Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] riscv: Use generated instruction headers for
 misaligned loads/stores
To: thecharlesjenkins@gmail.com
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Nam Cao <namcao@linutronix.de>, 
	Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 12:08=E2=80=AFAM Charlie Jenkins via B4 Relay
<devnull+thecharlesjenkins.gmail.com@kernel.org> wrote:
>
> From: Charlie Jenkins <thecharlesjenkins@gmail.com>
>
> Migrate the misaligned loads/store code to use the generated instruction
> headers instead of the hand-written instruction composition functions.
>
> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
>
> ---
>
> Similar to the other patches of this series, I extracted out the logic
> of this function and brute forced all possible inputs to validate that
> the outputs are the same. To verify this change in the kernel, I booted
> on Spike and used the misaligned access checker which does some
> misaligned accesses.
> ---
>  arch/riscv/kernel/traps_misaligned.c | 183 ++++++++++++++++-------------=
------
>  1 file changed, 83 insertions(+), 100 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index 81b7682e6c6d..4d2a2432e0c4 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -22,15 +22,11 @@
>
>  #ifdef CONFIG_FPU
>
> -#define FP_GET_RD(insn)                (insn >> 7 & 0x1F)
> -
>  extern void put_f32_reg(unsigned long fp_reg, unsigned long value);
>
> -static int set_f32_rd(unsigned long insn, struct pt_regs *regs,
> +static int set_f32_rd(unsigned long fp_reg, struct pt_regs *regs,
>                       unsigned long val)
>  {
> -       unsigned long fp_reg =3D FP_GET_RD(insn);
> -
>         put_f32_reg(fp_reg, val);
>         regs->status |=3D SR_FS_DIRTY;
>
> @@ -39,9 +35,8 @@ static int set_f32_rd(unsigned long insn, struct pt_reg=
s *regs,
>
>  extern void put_f64_reg(unsigned long fp_reg, unsigned long value);
>
> -static int set_f64_rd(unsigned long insn, struct pt_regs *regs, u64 val)
> +static int set_f64_rd(unsigned long fp_reg, struct pt_regs *regs, u64 va=
l)
>  {
> -       unsigned long fp_reg =3D FP_GET_RD(insn);
>         unsigned long value;
>
>  #if __riscv_xlen =3D=3D 32
> @@ -58,10 +53,8 @@ static int set_f64_rd(unsigned long insn, struct pt_re=
gs *regs, u64 val)
>  #if __riscv_xlen =3D=3D 32
>  extern void get_f64_reg(unsigned long fp_reg, u64 *value);
>
> -static u64 get_f64_rs(unsigned long insn, u8 fp_reg_offset,
> -                     struct pt_regs *regs)
> +static u64 get_f64_rs(unsigned long fp_reg, struct pt_regs *regs)
>  {
> -       unsigned long fp_reg =3D (insn >> fp_reg_offset) & 0x1F;
>         u64 val;
>
>         get_f64_reg(fp_reg, &val);
> @@ -73,10 +66,8 @@ static u64 get_f64_rs(unsigned long insn, u8 fp_reg_of=
fset,
>
>  extern unsigned long get_f64_reg(unsigned long fp_reg);
>
> -static unsigned long get_f64_rs(unsigned long insn, u8 fp_reg_offset,
> -                               struct pt_regs *regs)
> +static unsigned long get_f64_rs(unsigned long fp_reg, struct pt_regs *re=
gs)
>  {
> -       unsigned long fp_reg =3D (insn >> fp_reg_offset) & 0x1F;
>         unsigned long val;
>
>         val =3D get_f64_reg(fp_reg);
> @@ -89,10 +80,8 @@ static unsigned long get_f64_rs(unsigned long insn, u8=
 fp_reg_offset,
>
>  extern unsigned long get_f32_reg(unsigned long fp_reg);
>
> -static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
> -                               struct pt_regs *regs)
> +static unsigned long get_f32_rs(unsigned long fp_reg, struct pt_regs *re=
gs)
>  {
> -       unsigned long fp_reg =3D (insn >> fp_reg_offset) & 0x1F;
>         unsigned long val;
>
>         val =3D get_f32_reg(fp_reg);
> @@ -107,28 +96,18 @@ static void set_f32_rd(unsigned long insn, struct pt=
_regs *regs,
>
>  static void set_f64_rd(unsigned long insn, struct pt_regs *regs, u64 val=
) {}
>
> -static unsigned long get_f64_rs(unsigned long insn, u8 fp_reg_offset,
> -                               struct pt_regs *regs)
> +static unsigned long get_f64_rs(unsigned long fp_reg, struct pt_regs *re=
gs)
>  {
>         return 0;
>  }
>
> -static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
> -                               struct pt_regs *regs)
> +static unsigned long get_f32_rs(unsigned long fp_reg, struct pt_regs *re=
gs)
>  {
>         return 0;
>  }
>
>  #endif
>
> -#define GET_F64_RS2(insn, regs) (get_f64_rs(insn, 20, regs))
> -#define GET_F64_RS2C(insn, regs) (get_f64_rs(insn, 2, regs))
> -#define GET_F64_RS2S(insn, regs) (get_f64_rs(RVC_RS2S(insn), 0, regs))
> -
> -#define GET_F32_RS2(insn, regs) (get_f32_rs(insn, 20, regs))
> -#define GET_F32_RS2C(insn, regs) (get_f32_rs(insn, 2, regs))
> -#define GET_F32_RS2S(insn, regs) (get_f32_rs(RVC_RS2S(insn), 0, regs))
> -
>  #define __read_insn(regs, insn, insn_addr, type)       \
>  ({                                                     \
>         int __ret;                                      \
> @@ -217,13 +196,13 @@ static int handle_vector_misaligned_load(struct pt_=
regs *regs)
>  }
>  #endif
>
> -static int handle_scalar_misaligned_load(struct pt_regs *regs)
> +static noinline int handle_scalar_misaligned_load(struct pt_regs *regs)
>  {
>         union reg_data val;
>         unsigned long epc =3D regs->epc;
>         unsigned long insn;
>         unsigned long addr =3D regs->badaddr;
> -       int fp =3D 0, shift =3D 0, len =3D 0;
> +       int fp =3D 0, shift =3D 0, len =3D 0, rd =3D 0;
>
>         perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>
> @@ -240,68 +219,71 @@ static int handle_scalar_misaligned_load(struct pt_=
regs *regs)
>
>         regs->epc =3D 0;
>
> -       if ((insn & INSN_MASK_LW) =3D=3D INSN_MATCH_LW) {
> +       if (riscv_insn_is_lw(insn)) {
>                 len =3D 4;
>                 shift =3D 8 * (sizeof(unsigned long) - len);
> -#if defined(CONFIG_64BIT)
> -       } else if ((insn & INSN_MASK_LD) =3D=3D INSN_MATCH_LD) {
> +               rd =3D riscv_insn_lw_extract_xd(insn);
> +       } else if (riscv_insn_is_ld(insn)) {
>                 len =3D 8;
>                 shift =3D 8 * (sizeof(unsigned long) - len);
> -       } else if ((insn & INSN_MASK_LWU) =3D=3D INSN_MATCH_LWU) {
> +               rd =3D riscv_insn_ld_extract_xd(insn);
> +       } else if (riscv_insn_is_lwu(insn)) {
>                 len =3D 4;
> -#endif
> -       } else if ((insn & INSN_MASK_FLD) =3D=3D INSN_MATCH_FLD) {
> +               rd =3D riscv_insn_lwu_extract_xd(insn);
> +       } else if (riscv_insn_is_fld(insn)) {
>                 fp =3D 1;
>                 len =3D 8;
> -       } else if ((insn & INSN_MASK_FLW) =3D=3D INSN_MATCH_FLW) {
> +               rd =3D riscv_insn_fld_extract_fd(insn);
> +       } else if (riscv_insn_is_flw(insn)) {
>                 fp =3D 1;
>                 len =3D 4;
> -       } else if ((insn & INSN_MASK_LH) =3D=3D INSN_MATCH_LH) {
> +               rd =3D riscv_insn_flw_extract_fd(insn);
> +       } else if (riscv_insn_is_lh(insn)) {
>                 len =3D 2;
>                 shift =3D 8 * (sizeof(unsigned long) - len);
> -       } else if ((insn & INSN_MASK_LHU) =3D=3D INSN_MATCH_LHU) {
> +               rd =3D riscv_insn_lh_extract_xd(insn);
> +       } else if (riscv_insn_is_lhu(insn)) {
>                 len =3D 2;
> -#if defined(CONFIG_64BIT)
> -       } else if ((insn & INSN_MASK_C_LD) =3D=3D INSN_MATCH_C_LD) {
> +               rd =3D riscv_insn_lhu_extract_xd(insn);
> +       } else if (riscv_insn_is_c_ld(insn)) {
>                 len =3D 8;
>                 shift =3D 8 * (sizeof(unsigned long) - len);
> -               insn =3D RVC_RS2S(insn) << SH_RD;
> -       } else if ((insn & INSN_MASK_C_LDSP) =3D=3D INSN_MATCH_C_LDSP &&
> -                  ((insn >> SH_RD) & 0x1f)) {
> +               rd =3D (8 + riscv_insn_c_ld_extract_xd(insn));
> +       } else if (riscv_insn_is_c_ldsp(insn)) {
>                 len =3D 8;
>                 shift =3D 8 * (sizeof(unsigned long) - len);
> -#endif
> -       } else if ((insn & INSN_MASK_C_LW) =3D=3D INSN_MATCH_C_LW) {
> +               rd =3D riscv_insn_c_ldsp_extract_xd(insn);
> +       } else if (riscv_insn_is_c_lw(insn)) {
>                 len =3D 4;
>                 shift =3D 8 * (sizeof(unsigned long) - len);
> -               insn =3D RVC_RS2S(insn) << SH_RD;
> -       } else if ((insn & INSN_MASK_C_LWSP) =3D=3D INSN_MATCH_C_LWSP &&
> -                  ((insn >> SH_RD) & 0x1f)) {
> +               rd =3D (8 + riscv_insn_c_lw_extract_xd(insn));
> +       } else if (riscv_insn_is_c_lwsp(insn)) {
>                 len =3D 4;
>                 shift =3D 8 * (sizeof(unsigned long) - len);
> -       } else if ((insn & INSN_MASK_C_FLD) =3D=3D INSN_MATCH_C_FLD) {
> +               rd =3D riscv_insn_c_lwsp_extract_xd(insn);
> +       } else if (riscv_insn_is_c_fld(insn)) {
>                 fp =3D 1;
>                 len =3D 8;
> -               insn =3D RVC_RS2S(insn) << SH_RD;
> -       } else if ((insn & INSN_MASK_C_FLDSP) =3D=3D INSN_MATCH_C_FLDSP) =
{
> +               rd =3D (8 + riscv_insn_c_fld_extract_fd(insn));
> +       } else if (riscv_insn_is_c_fldsp(insn)) {
>                 fp =3D 1;
>                 len =3D 8;
> -#if defined(CONFIG_32BIT)
> -       } else if ((insn & INSN_MASK_C_FLW) =3D=3D INSN_MATCH_C_FLW) {
> +               rd =3D riscv_insn_c_fldsp_extract_fd(insn);
> +       } else if (riscv_insn_is_c_flw(insn)) {
>                 fp =3D 1;
>                 len =3D 4;
> -               insn =3D RVC_RS2S(insn) << SH_RD;
> -       } else if ((insn & INSN_MASK_C_FLWSP) =3D=3D INSN_MATCH_C_FLWSP) =
{
> +               rd =3D (8 + riscv_insn_c_flw_extract_fd(insn));
> +       } else if (riscv_insn_is_c_flwsp(insn)) {
>                 fp =3D 1;
>                 len =3D 4;
> -#endif
> -       } else if ((insn & INSN_MASK_C_LHU) =3D=3D INSN_MATCH_C_LHU) {
> +               rd =3D riscv_insn_c_flwsp_extract_fd(insn);
> +       } else if (riscv_insn_is_c_lhu(insn)) {
>                 len =3D 2;
> -               insn =3D RVC_RS2S(insn) << SH_RD;
> -       } else if ((insn & INSN_MASK_C_LH) =3D=3D INSN_MATCH_C_LH) {
> +               rd =3D (8 + riscv_insn_c_lhu_extract_xd(insn));
> +       } else if (riscv_insn_is_c_lh(insn)) {
>                 len =3D 2;
> -               shift =3D 8 * (sizeof(ulong) - len);
> -               insn =3D RVC_RS2S(insn) << SH_RD;
> +               shift =3D 8 * (sizeof(unsigned long) - len);
> +               rd =3D (8 + riscv_insn_c_lh_extract_xd(insn));
>         } else {
>                 regs->epc =3D epc;
>                 return -1;
> @@ -319,11 +301,11 @@ static int handle_scalar_misaligned_load(struct pt_=
regs *regs)
>         }
>
>         if (!fp)
> -               SET_RD(insn, regs, (long)(val.data_ulong << shift) >> shi=
ft);
> +               *(unsigned long *)((unsigned long *)regs + rd) =3D val.da=
ta_ulong << shift;
>         else if (len =3D=3D 8)
> -               set_f64_rd(insn, regs, val.data_u64);
> +               set_f64_rd(rd, regs, val.data_u64);
>         else
> -               set_f32_rd(insn, regs, val.data_ulong);
> +               set_f32_rd(rd, regs, val.data_ulong);
>
>         regs->epc =3D epc + INSN_LEN(insn);
>
> @@ -336,7 +318,7 @@ static int handle_scalar_misaligned_store(struct pt_r=
egs *regs)
>         unsigned long epc =3D regs->epc;
>         unsigned long insn;
>         unsigned long addr =3D regs->badaddr;
> -       int len =3D 0, fp =3D 0;
> +       int fp =3D 0, len =3D 0, rd =3D 0;
>
>         perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>
> @@ -351,67 +333,68 @@ static int handle_scalar_misaligned_store(struct pt=
_regs *regs)
>
>         regs->epc =3D 0;
>
> -       val.data_ulong =3D GET_RS2(insn, regs);
> -
> -       if ((insn & INSN_MASK_SW) =3D=3D INSN_MATCH_SW) {
> +       if (riscv_insn_is_sw(insn)) {
>                 len =3D 4;
> -#if defined(CONFIG_64BIT)
> -       } else if ((insn & INSN_MASK_SD) =3D=3D INSN_MATCH_SD) {
> +               rd =3D riscv_insn_sw_extract_xs2(insn);
> +       } else if (riscv_insn_is_sd(insn)) {
>                 len =3D 8;
> -#endif
> -       } else if ((insn & INSN_MASK_FSD) =3D=3D INSN_MATCH_FSD) {
> +               rd =3D riscv_insn_sd_extract_xs2(insn);
> +       } else if (riscv_insn_is_fsd(insn)) {
>                 fp =3D 1;
>                 len =3D 8;
> -               val.data_u64 =3D GET_F64_RS2(insn, regs);
> -       } else if ((insn & INSN_MASK_FSW) =3D=3D INSN_MATCH_FSW) {
> +               rd =3D riscv_insn_fsd_extract_fs2(insn);
> +       } else if (riscv_insn_is_fsw(insn)) {
>                 fp =3D 1;
>                 len =3D 4;
> -               val.data_ulong =3D GET_F32_RS2(insn, regs);
> -       } else if ((insn & INSN_MASK_SH) =3D=3D INSN_MATCH_SH) {
> +               rd =3D riscv_insn_fsw_extract_fs2(insn);
> +       } else if (riscv_insn_is_sh(insn)) {
>                 len =3D 2;
> -#if defined(CONFIG_64BIT)
> -       } else if ((insn & INSN_MASK_C_SD) =3D=3D INSN_MATCH_C_SD) {
> +               rd =3D riscv_insn_sh_extract_xs2(insn);
> +       } else if (riscv_insn_is_c_sd(insn)) {
>                 len =3D 8;
> -               val.data_ulong =3D GET_RS2S(insn, regs);
> -       } else if ((insn & INSN_MASK_C_SDSP) =3D=3D INSN_MATCH_C_SDSP) {
> +               rd =3D riscv_insn_c_sd_extract_xs2(insn);
> +       } else if (riscv_insn_is_c_sdsp(insn)) {
>                 len =3D 8;
> -               val.data_ulong =3D GET_RS2C(insn, regs);
> -#endif
> -       } else if ((insn & INSN_MASK_C_SW) =3D=3D INSN_MATCH_C_SW) {
> +               rd =3D riscv_insn_c_sdsp_extract_xs2(insn);
> +       } else if (riscv_insn_is_c_sw(insn)) {
>                 len =3D 4;
> -               val.data_ulong =3D GET_RS2S(insn, regs);
> -       } else if ((insn & INSN_MASK_C_SWSP) =3D=3D INSN_MATCH_C_SWSP) {
> +               rd =3D riscv_insn_c_sw_extract_xs2(insn);
> +       } else if (riscv_insn_is_c_swsp(insn)) {
>                 len =3D 4;
> -               val.data_ulong =3D GET_RS2C(insn, regs);
> -       } else if ((insn & INSN_MASK_C_FSD) =3D=3D INSN_MATCH_C_FSD) {
> +               rd =3D riscv_insn_c_swsp_extract_xs2(insn);
> +       } else if (riscv_insn_is_c_fsd(insn)) {
>                 fp =3D 1;
>                 len =3D 8;
> -               val.data_u64 =3D GET_F64_RS2S(insn, regs);
> -       } else if ((insn & INSN_MASK_C_FSDSP) =3D=3D INSN_MATCH_C_FSDSP) =
{
> +               rd =3D riscv_insn_c_fsd_extract_fs2(insn);
> +       } else if (riscv_insn_is_c_fsdsp(insn)) {
>                 fp =3D 1;
>                 len =3D 8;
> -               val.data_u64 =3D GET_F64_RS2C(insn, regs);
> -#if !defined(CONFIG_64BIT)

Shouldn't we keep this?

> -       } else if ((insn & INSN_MASK_C_FSW) =3D=3D INSN_MATCH_C_FSW) {
> +               rd =3D riscv_insn_c_fsdsp_extract_fs2(insn);
> +       } else if (riscv_insn_is_c_fsw(insn)) {
>                 fp =3D 1;
>                 len =3D 4;
> -               val.data_ulong =3D GET_F32_RS2S(insn, regs);
> -       } else if ((insn & INSN_MASK_C_FSWSP) =3D=3D INSN_MATCH_C_FSWSP) =
{
> +               rd =3D riscv_insn_c_fsw_extract_fs2(insn);
> +       } else if (riscv_insn_is_c_fswsp(insn)) {
>                 fp =3D 1;
>                 len =3D 4;
> -               val.data_ulong =3D GET_F32_RS2C(insn, regs);
> -#endif
> -       } else if ((insn & INSN_MASK_C_SH) =3D=3D INSN_MATCH_C_SH) {
> +               rd =3D riscv_insn_c_fswsp_extract_fs2(insn);
> +       } else if (riscv_insn_is_c_sh(insn)) {
>                 len =3D 2;
> -               val.data_ulong =3D GET_RS2S(insn, regs);
> +               rd =3D riscv_insn_c_sh_extract_xs2(insn);
>         } else {
> -               regs->epc =3D epc;

This line should be kept.

Thanks,
Jesse Taube

>                 return -1;
>         }
>
>         if (!IS_ENABLED(CONFIG_FPU) && fp)
>                 return -EOPNOTSUPP;
>
> +       if (!fp)
> +               val.data_ulong =3D *(unsigned long *)((unsigned long *)re=
gs + rd);
> +       else if (len =3D=3D 8)
> +               val.data_u64 =3D get_f64_rs(rd, regs);
> +       else
> +               val.data_ulong =3D get_f32_rs(rd, regs);
> +
>         if (user_mode(regs)) {
>                 if (copy_to_user((u8 __user *)addr, &val, len))
>                         return -1;
>
> --
> 2.54.0
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
