Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE043358DA
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800055; cv=none; b=OGDWD3HLHZsu7LgRqfmZxRa+Lqy24tC1jG51bHCy/rmU349gt3jDJQYzQW2G3AxY251kHdHMMgigJqq7qe1vj4RuHy954Ho7bQbcfCm94GrbrmhSHK2tHiUAk6jhzwYFbqdFLTFQ0XcIdcacAJOYu17U2OZbSbL2HTL7FuDodFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800055; c=relaxed/simple;
	bh=BCX2akkhmmnaIZWDdudQQH9BULKqJHzDvO2oUnBo4gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryOsW+KyEWXiF4rjZmrRG1VbIB+9r4jqKwFQ49HPGA3g5A+3v2xeBkiVa/jFyRjC9BXxj2X6n2f8RsipK0/HPmB2H6fy+N89/JO6D1DnWrPmq9PrafD5HTaZHTGVFETmwSBFzOSMW7dNWDsuz6nCB/DII5lcAKEXebM6RSlzbOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/VvzIea; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/VvzIea"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-139f71a5201so305536c88.0
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 23:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782800053; x=1783404853; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kQ4pwxtyxCm1G5M66xxdmEUDpbEAdNwzhoPavDK6tNs=;
        b=W/VvzIeaDL5z/x4oWJH9DmLoCBvoKVdXFEo54vs7MKd7DG4eVXfaYAviGkbLa1Uf1k
         LJ/XaPkIw/5Zke3cW2L9EqRWOMsIbbMMEt3GHXA04jp4s4Gt2CmguXuMIybMyrC1GXkL
         /R88k2NYAPsdPMKmBNZOBZjuGCaqIiFtJbLFKJsXeNMF4g34w7eO2zvI4z5itZNY1kCJ
         SvxprX9Uq2jIvIUQk7bmJ4sb2TIAZH237u0cCzy2BkpomGKc0p0MLwUQuYDtLk5YMw6m
         Tc5Svu27E6abYzzAzlW0c2mKxnlwhgiDDOwcyuhd3gOR1rZ2xCV1paDVihKer6BCOTag
         eZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782800053; x=1783404853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ4pwxtyxCm1G5M66xxdmEUDpbEAdNwzhoPavDK6tNs=;
        b=kApq+53e5hkJPDtktcDMo56+jUEtG4osXrHBq5lQuo3BGFnEgdN9SUg3tAoRvCvx9a
         CGtSX3cnPtn0bNtDq6R1JRefrX5u5cpPUkk+X59cGq4OpQL9ACo6ZCTkJLZ4cjMyohzn
         +KCEf3exbzVlnRy7Z/9lT5odjgSahaHHt0Yf0z/xnFCyp5IA3nOTz0HzPyJpYzRmvibi
         nqVCWgti76VzixSUjtFeh2/VuSQiGAWlSfkbgdS0PlYE64MkaTUQBQKVwxGtgYJvAIFp
         IJILITcSeQ5elcg1o1ipuhflwgU4yB+rEAGk7LMz2DS5BRuxwyokRpZuDACWZ/2m5Ien
         jx6g==
X-Forwarded-Encrypted: i=1; AHgh+RpBldHsrHvtK7ZEFuGkYhkXm7FOjewdUmvIwEtzgHE0Xjy/pyG/CH8nk/ZONn0YUwNPKYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbzyyX5tHG6pIKGaWmbH6dYh5YckxCgw1TAM9G6/mZnS8t+C9d
	8fs3au8Vw0aD9f8giacJBdnYhCYyFBd5fZjjxfPLlg8o1kK0k+cIkrSm
X-Gm-Gg: AfdE7clNFIjD1EpjkhBmUXxtM5FTOy2ZiIgccXcMOvQJE5mMBhH4acpQqBl6DRSf7Fp
	fMB/jn6ovxAmxS/oZqWXFgBOw5Sh7Ic+oujKiN6EcX1Gb4HYc+tWB/T/n6rOMzyZXYyb2xv6YqV
	K1EkRHzGuQoSXx3VlFOeCPzNzXat9eTeN2bYTotq3IRBHYvFe7dmEZMqQDy7Vawn9DbrmXySGJU
	UbVtNRZZ9GPG78b79t7dx9uOg8PIeXNZthRk7zr+qoiYvHFx/tsIxi4WN7K6wwvfXh+NyY8N2qI
	HfE2pr5Z0iLGfojq7LVZzQZlMPv1cT9AJ4tdtEcthVAQXeMUZXhRBaG/IcTAsZj6+RlxT29+K9B
	b6pr2h5A72+iMuIqhqrBIX1vy0BZBU2K33pTrcr0G3aCL9Oa0KQVGqOcOYQkmWxe7hcL2kMrdvK
	a0lKBvMPDg6yA2/q4kHCL8ur1QvTJ4oyn8
X-Received: by 2002:a05:7300:6115:b0:30c:9ca4:5cd0 with SMTP id 5a478bee46e88-30ee9f63cdamr444602eec.4.1782800052515;
        Mon, 29 Jun 2026 23:14:12 -0700 (PDT)
Received: from blinky ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee326c7a7sm4344373eec.29.2026.06.29.23.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:14:11 -0700 (PDT)
Date: Mon, 29 Jun 2026 23:14:09 -0700
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Jesse T <mr.bossman075@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Nam Cao <namcao@linutronix.de>, Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Conor Dooley <conor@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 07/16] riscv: Use generated instruction headers for
 misaligned loads/stores
Message-ID: <akNesSDbmi89Y1Cw@blinky>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-7-7f0810ee2274@gmail.com>
 <CAJFTR8Tb54YPUQXiPCRq4XsX-P_vSyS2W=HThvEzb=BLn2Cy8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFTR8Tb54YPUQXiPCRq4XsX-P_vSyS2W=HThvEzb=BLn2Cy8Q@mail.gmail.com>

On Mon, Jun 29, 2026 at 04:20:15PM -0400, Jesse T wrote:
> On Mon, Jun 22, 2026 at 12:08 AM Charlie Jenkins via B4 Relay
> <devnull+thecharlesjenkins.gmail.com@kernel.org> wrote:
> >
> > From: Charlie Jenkins <thecharlesjenkins@gmail.com>
> >
> > Migrate the misaligned loads/store code to use the generated instruction
> > headers instead of the hand-written instruction composition functions.
> >
> > Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> >
> > ---
> >
> > Similar to the other patches of this series, I extracted out the logic
> > of this function and brute forced all possible inputs to validate that
> > the outputs are the same. To verify this change in the kernel, I booted
> > on Spike and used the misaligned access checker which does some
> > misaligned accesses.
> > ---
> >  arch/riscv/kernel/traps_misaligned.c | 183 ++++++++++++++++-------------------
> >  1 file changed, 83 insertions(+), 100 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> > index 81b7682e6c6d..4d2a2432e0c4 100644
> > --- a/arch/riscv/kernel/traps_misaligned.c
> > +++ b/arch/riscv/kernel/traps_misaligned.c
> > @@ -22,15 +22,11 @@
> >
> >  #ifdef CONFIG_FPU
> >
> > -#define FP_GET_RD(insn)                (insn >> 7 & 0x1F)
> > -
> >  extern void put_f32_reg(unsigned long fp_reg, unsigned long value);
> >
> > -static int set_f32_rd(unsigned long insn, struct pt_regs *regs,
> > +static int set_f32_rd(unsigned long fp_reg, struct pt_regs *regs,
> >                       unsigned long val)
> >  {
> > -       unsigned long fp_reg = FP_GET_RD(insn);
> > -
> >         put_f32_reg(fp_reg, val);
> >         regs->status |= SR_FS_DIRTY;
> >
> > @@ -39,9 +35,8 @@ static int set_f32_rd(unsigned long insn, struct pt_regs *regs,
> >
> >  extern void put_f64_reg(unsigned long fp_reg, unsigned long value);
> >
> > -static int set_f64_rd(unsigned long insn, struct pt_regs *regs, u64 val)
> > +static int set_f64_rd(unsigned long fp_reg, struct pt_regs *regs, u64 val)
> >  {
> > -       unsigned long fp_reg = FP_GET_RD(insn);
> >         unsigned long value;
> >
> >  #if __riscv_xlen == 32
> > @@ -58,10 +53,8 @@ static int set_f64_rd(unsigned long insn, struct pt_regs *regs, u64 val)
> >  #if __riscv_xlen == 32
> >  extern void get_f64_reg(unsigned long fp_reg, u64 *value);
> >
> > -static u64 get_f64_rs(unsigned long insn, u8 fp_reg_offset,
> > -                     struct pt_regs *regs)
> > +static u64 get_f64_rs(unsigned long fp_reg, struct pt_regs *regs)
> >  {
> > -       unsigned long fp_reg = (insn >> fp_reg_offset) & 0x1F;
> >         u64 val;
> >
> >         get_f64_reg(fp_reg, &val);
> > @@ -73,10 +66,8 @@ static u64 get_f64_rs(unsigned long insn, u8 fp_reg_offset,
> >
> >  extern unsigned long get_f64_reg(unsigned long fp_reg);
> >
> > -static unsigned long get_f64_rs(unsigned long insn, u8 fp_reg_offset,
> > -                               struct pt_regs *regs)
> > +static unsigned long get_f64_rs(unsigned long fp_reg, struct pt_regs *regs)
> >  {
> > -       unsigned long fp_reg = (insn >> fp_reg_offset) & 0x1F;
> >         unsigned long val;
> >
> >         val = get_f64_reg(fp_reg);
> > @@ -89,10 +80,8 @@ static unsigned long get_f64_rs(unsigned long insn, u8 fp_reg_offset,
> >
> >  extern unsigned long get_f32_reg(unsigned long fp_reg);
> >
> > -static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
> > -                               struct pt_regs *regs)
> > +static unsigned long get_f32_rs(unsigned long fp_reg, struct pt_regs *regs)
> >  {
> > -       unsigned long fp_reg = (insn >> fp_reg_offset) & 0x1F;
> >         unsigned long val;
> >
> >         val = get_f32_reg(fp_reg);
> > @@ -107,28 +96,18 @@ static void set_f32_rd(unsigned long insn, struct pt_regs *regs,
> >
> >  static void set_f64_rd(unsigned long insn, struct pt_regs *regs, u64 val) {}
> >
> > -static unsigned long get_f64_rs(unsigned long insn, u8 fp_reg_offset,
> > -                               struct pt_regs *regs)
> > +static unsigned long get_f64_rs(unsigned long fp_reg, struct pt_regs *regs)
> >  {
> >         return 0;
> >  }
> >
> > -static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
> > -                               struct pt_regs *regs)
> > +static unsigned long get_f32_rs(unsigned long fp_reg, struct pt_regs *regs)
> >  {
> >         return 0;
> >  }
> >
> >  #endif
> >
> > -#define GET_F64_RS2(insn, regs) (get_f64_rs(insn, 20, regs))
> > -#define GET_F64_RS2C(insn, regs) (get_f64_rs(insn, 2, regs))
> > -#define GET_F64_RS2S(insn, regs) (get_f64_rs(RVC_RS2S(insn), 0, regs))
> > -
> > -#define GET_F32_RS2(insn, regs) (get_f32_rs(insn, 20, regs))
> > -#define GET_F32_RS2C(insn, regs) (get_f32_rs(insn, 2, regs))
> > -#define GET_F32_RS2S(insn, regs) (get_f32_rs(RVC_RS2S(insn), 0, regs))
> > -
> >  #define __read_insn(regs, insn, insn_addr, type)       \
> >  ({                                                     \
> >         int __ret;                                      \
> > @@ -217,13 +196,13 @@ static int handle_vector_misaligned_load(struct pt_regs *regs)
> >  }
> >  #endif
> >
> > -static int handle_scalar_misaligned_load(struct pt_regs *regs)
> > +static noinline int handle_scalar_misaligned_load(struct pt_regs *regs)
> >  {
> >         union reg_data val;
> >         unsigned long epc = regs->epc;
> >         unsigned long insn;
> >         unsigned long addr = regs->badaddr;
> > -       int fp = 0, shift = 0, len = 0;
> > +       int fp = 0, shift = 0, len = 0, rd = 0;
> >
> >         perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
> >
> > @@ -240,68 +219,71 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
> >
> >         regs->epc = 0;
> >
> > -       if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
> > +       if (riscv_insn_is_lw(insn)) {
> >                 len = 4;
> >                 shift = 8 * (sizeof(unsigned long) - len);
> > -#if defined(CONFIG_64BIT)
> > -       } else if ((insn & INSN_MASK_LD) == INSN_MATCH_LD) {
> > +               rd = riscv_insn_lw_extract_xd(insn);
> > +       } else if (riscv_insn_is_ld(insn)) {
> >                 len = 8;
> >                 shift = 8 * (sizeof(unsigned long) - len);
> > -       } else if ((insn & INSN_MASK_LWU) == INSN_MATCH_LWU) {
> > +               rd = riscv_insn_ld_extract_xd(insn);
> > +       } else if (riscv_insn_is_lwu(insn)) {
> >                 len = 4;
> > -#endif
> > -       } else if ((insn & INSN_MASK_FLD) == INSN_MATCH_FLD) {
> > +               rd = riscv_insn_lwu_extract_xd(insn);
> > +       } else if (riscv_insn_is_fld(insn)) {
> >                 fp = 1;
> >                 len = 8;
> > -       } else if ((insn & INSN_MASK_FLW) == INSN_MATCH_FLW) {
> > +               rd = riscv_insn_fld_extract_fd(insn);
> > +       } else if (riscv_insn_is_flw(insn)) {
> >                 fp = 1;
> >                 len = 4;
> > -       } else if ((insn & INSN_MASK_LH) == INSN_MATCH_LH) {
> > +               rd = riscv_insn_flw_extract_fd(insn);
> > +       } else if (riscv_insn_is_lh(insn)) {
> >                 len = 2;
> >                 shift = 8 * (sizeof(unsigned long) - len);
> > -       } else if ((insn & INSN_MASK_LHU) == INSN_MATCH_LHU) {
> > +               rd = riscv_insn_lh_extract_xd(insn);
> > +       } else if (riscv_insn_is_lhu(insn)) {
> >                 len = 2;
> > -#if defined(CONFIG_64BIT)
> > -       } else if ((insn & INSN_MASK_C_LD) == INSN_MATCH_C_LD) {
> > +               rd = riscv_insn_lhu_extract_xd(insn);
> > +       } else if (riscv_insn_is_c_ld(insn)) {
> >                 len = 8;
> >                 shift = 8 * (sizeof(unsigned long) - len);
> > -               insn = RVC_RS2S(insn) << SH_RD;
> > -       } else if ((insn & INSN_MASK_C_LDSP) == INSN_MATCH_C_LDSP &&
> > -                  ((insn >> SH_RD) & 0x1f)) {
> > +               rd = (8 + riscv_insn_c_ld_extract_xd(insn));
> > +       } else if (riscv_insn_is_c_ldsp(insn)) {
> >                 len = 8;
> >                 shift = 8 * (sizeof(unsigned long) - len);
> > -#endif
> > -       } else if ((insn & INSN_MASK_C_LW) == INSN_MATCH_C_LW) {
> > +               rd = riscv_insn_c_ldsp_extract_xd(insn);
> > +       } else if (riscv_insn_is_c_lw(insn)) {
> >                 len = 4;
> >                 shift = 8 * (sizeof(unsigned long) - len);
> > -               insn = RVC_RS2S(insn) << SH_RD;
> > -       } else if ((insn & INSN_MASK_C_LWSP) == INSN_MATCH_C_LWSP &&
> > -                  ((insn >> SH_RD) & 0x1f)) {
> > +               rd = (8 + riscv_insn_c_lw_extract_xd(insn));
> > +       } else if (riscv_insn_is_c_lwsp(insn)) {
> >                 len = 4;
> >                 shift = 8 * (sizeof(unsigned long) - len);
> > -       } else if ((insn & INSN_MASK_C_FLD) == INSN_MATCH_C_FLD) {
> > +               rd = riscv_insn_c_lwsp_extract_xd(insn);
> > +       } else if (riscv_insn_is_c_fld(insn)) {
> >                 fp = 1;
> >                 len = 8;
> > -               insn = RVC_RS2S(insn) << SH_RD;
> > -       } else if ((insn & INSN_MASK_C_FLDSP) == INSN_MATCH_C_FLDSP) {
> > +               rd = (8 + riscv_insn_c_fld_extract_fd(insn));
> > +       } else if (riscv_insn_is_c_fldsp(insn)) {
> >                 fp = 1;
> >                 len = 8;
> > -#if defined(CONFIG_32BIT)
> > -       } else if ((insn & INSN_MASK_C_FLW) == INSN_MATCH_C_FLW) {
> > +               rd = riscv_insn_c_fldsp_extract_fd(insn);
> > +       } else if (riscv_insn_is_c_flw(insn)) {
> >                 fp = 1;
> >                 len = 4;
> > -               insn = RVC_RS2S(insn) << SH_RD;
> > -       } else if ((insn & INSN_MASK_C_FLWSP) == INSN_MATCH_C_FLWSP) {
> > +               rd = (8 + riscv_insn_c_flw_extract_fd(insn));
> > +       } else if (riscv_insn_is_c_flwsp(insn)) {
> >                 fp = 1;
> >                 len = 4;
> > -#endif
> > -       } else if ((insn & INSN_MASK_C_LHU) == INSN_MATCH_C_LHU) {
> > +               rd = riscv_insn_c_flwsp_extract_fd(insn);
> > +       } else if (riscv_insn_is_c_lhu(insn)) {
> >                 len = 2;
> > -               insn = RVC_RS2S(insn) << SH_RD;
> > -       } else if ((insn & INSN_MASK_C_LH) == INSN_MATCH_C_LH) {
> > +               rd = (8 + riscv_insn_c_lhu_extract_xd(insn));
> > +       } else if (riscv_insn_is_c_lh(insn)) {
> >                 len = 2;
> > -               shift = 8 * (sizeof(ulong) - len);
> > -               insn = RVC_RS2S(insn) << SH_RD;
> > +               shift = 8 * (sizeof(unsigned long) - len);
> > +               rd = (8 + riscv_insn_c_lh_extract_xd(insn));
> >         } else {
> >                 regs->epc = epc;
> >                 return -1;
> > @@ -319,11 +301,11 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
> >         }
> >
> >         if (!fp)
> > -               SET_RD(insn, regs, (long)(val.data_ulong << shift) >> shift);
> > +               *(unsigned long *)((unsigned long *)regs + rd) = val.data_ulong << shift;
> >         else if (len == 8)
> > -               set_f64_rd(insn, regs, val.data_u64);
> > +               set_f64_rd(rd, regs, val.data_u64);
> >         else
> > -               set_f32_rd(insn, regs, val.data_ulong);
> > +               set_f32_rd(rd, regs, val.data_ulong);
> >
> >         regs->epc = epc + INSN_LEN(insn);
> >
> > @@ -336,7 +318,7 @@ static int handle_scalar_misaligned_store(struct pt_regs *regs)
> >         unsigned long epc = regs->epc;
> >         unsigned long insn;
> >         unsigned long addr = regs->badaddr;
> > -       int len = 0, fp = 0;
> > +       int fp = 0, len = 0, rd = 0;
> >
> >         perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
> >
> > @@ -351,67 +333,68 @@ static int handle_scalar_misaligned_store(struct pt_regs *regs)
> >
> >         regs->epc = 0;
> >
> > -       val.data_ulong = GET_RS2(insn, regs);
> > -
> > -       if ((insn & INSN_MASK_SW) == INSN_MATCH_SW) {
> > +       if (riscv_insn_is_sw(insn)) {
> >                 len = 4;
> > -#if defined(CONFIG_64BIT)
> > -       } else if ((insn & INSN_MASK_SD) == INSN_MATCH_SD) {
> > +               rd = riscv_insn_sw_extract_xs2(insn);
> > +       } else if (riscv_insn_is_sd(insn)) {
> >                 len = 8;
> > -#endif
> > -       } else if ((insn & INSN_MASK_FSD) == INSN_MATCH_FSD) {
> > +               rd = riscv_insn_sd_extract_xs2(insn);
> > +       } else if (riscv_insn_is_fsd(insn)) {
> >                 fp = 1;
> >                 len = 8;
> > -               val.data_u64 = GET_F64_RS2(insn, regs);
> > -       } else if ((insn & INSN_MASK_FSW) == INSN_MATCH_FSW) {
> > +               rd = riscv_insn_fsd_extract_fs2(insn);
> > +       } else if (riscv_insn_is_fsw(insn)) {
> >                 fp = 1;
> >                 len = 4;
> > -               val.data_ulong = GET_F32_RS2(insn, regs);
> > -       } else if ((insn & INSN_MASK_SH) == INSN_MATCH_SH) {
> > +               rd = riscv_insn_fsw_extract_fs2(insn);
> > +       } else if (riscv_insn_is_sh(insn)) {
> >                 len = 2;
> > -#if defined(CONFIG_64BIT)
> > -       } else if ((insn & INSN_MASK_C_SD) == INSN_MATCH_C_SD) {
> > +               rd = riscv_insn_sh_extract_xs2(insn);
> > +       } else if (riscv_insn_is_c_sd(insn)) {
> >                 len = 8;
> > -               val.data_ulong = GET_RS2S(insn, regs);
> > -       } else if ((insn & INSN_MASK_C_SDSP) == INSN_MATCH_C_SDSP) {
> > +               rd = riscv_insn_c_sd_extract_xs2(insn);
> > +       } else if (riscv_insn_is_c_sdsp(insn)) {
> >                 len = 8;
> > -               val.data_ulong = GET_RS2C(insn, regs);
> > -#endif
> > -       } else if ((insn & INSN_MASK_C_SW) == INSN_MATCH_C_SW) {
> > +               rd = riscv_insn_c_sdsp_extract_xs2(insn);
> > +       } else if (riscv_insn_is_c_sw(insn)) {
> >                 len = 4;
> > -               val.data_ulong = GET_RS2S(insn, regs);
> > -       } else if ((insn & INSN_MASK_C_SWSP) == INSN_MATCH_C_SWSP) {
> > +               rd = riscv_insn_c_sw_extract_xs2(insn);
> > +       } else if (riscv_insn_is_c_swsp(insn)) {
> >                 len = 4;
> > -               val.data_ulong = GET_RS2C(insn, regs);
> > -       } else if ((insn & INSN_MASK_C_FSD) == INSN_MATCH_C_FSD) {
> > +               rd = riscv_insn_c_swsp_extract_xs2(insn);
> > +       } else if (riscv_insn_is_c_fsd(insn)) {
> >                 fp = 1;
> >                 len = 8;
> > -               val.data_u64 = GET_F64_RS2S(insn, regs);
> > -       } else if ((insn & INSN_MASK_C_FSDSP) == INSN_MATCH_C_FSDSP) {
> > +               rd = riscv_insn_c_fsd_extract_fs2(insn);
> > +       } else if (riscv_insn_is_c_fsdsp(insn)) {
> >                 fp = 1;
> >                 len = 8;
> > -               val.data_u64 = GET_F64_RS2C(insn, regs);
> > -#if !defined(CONFIG_64BIT)
> 
> Shouldn't we keep this?

The ifdef doesn't matter anymore because the new riscv_insn_is_*() have
are all ifdef'd out so unconditionally return false if they are not
supported on CONFIG_64BIT/CONFIG_32BIT.

> 
> > -       } else if ((insn & INSN_MASK_C_FSW) == INSN_MATCH_C_FSW) {
> > +               rd = riscv_insn_c_fsdsp_extract_fs2(insn);
> > +       } else if (riscv_insn_is_c_fsw(insn)) {
> >                 fp = 1;
> >                 len = 4;
> > -               val.data_ulong = GET_F32_RS2S(insn, regs);
> > -       } else if ((insn & INSN_MASK_C_FSWSP) == INSN_MATCH_C_FSWSP) {
> > +               rd = riscv_insn_c_fsw_extract_fs2(insn);
> > +       } else if (riscv_insn_is_c_fswsp(insn)) {
> >                 fp = 1;
> >                 len = 4;
> > -               val.data_ulong = GET_F32_RS2C(insn, regs);
> > -#endif
> > -       } else if ((insn & INSN_MASK_C_SH) == INSN_MATCH_C_SH) {
> > +               rd = riscv_insn_c_fswsp_extract_fs2(insn);
> > +       } else if (riscv_insn_is_c_sh(insn)) {
> >                 len = 2;
> > -               val.data_ulong = GET_RS2S(insn, regs);
> > +               rd = riscv_insn_c_sh_extract_xs2(insn);
> >         } else {
> > -               regs->epc = epc;
> 
> This line should be kept.

Oh huh I wonder why I got rid of this. Good catch, thank you!

- Charlie

> 
> Thanks,
> Jesse Taube
> 
> >                 return -1;
> >         }
> >
> >         if (!IS_ENABLED(CONFIG_FPU) && fp)
> >                 return -EOPNOTSUPP;
> >
> > +       if (!fp)
> > +               val.data_ulong = *(unsigned long *)((unsigned long *)regs + rd);
> > +       else if (len == 8)
> > +               val.data_u64 = get_f64_rs(rd, regs);
> > +       else
> > +               val.data_ulong = get_f32_rs(rd, regs);
> > +
> >         if (user_mode(regs)) {
> >                 if (copy_to_user((u8 __user *)addr, &val, len))
> >                         return -1;
> >
> > --
> > 2.54.0
> >
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
