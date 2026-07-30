Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A8C3A425B
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399003; cv=pass; b=nA8KX9u95emGch2bhF7q7GYmaVYzz88n73hOZ0v/dMkV7s33A8XsuxxDR1COSE7X97NzRhyuHCNBmIw48FaJBwF/UGVs1fHyppte9PlWeBTzIm+rAC7/vxsSnnM/rm30J7ne/v3lwXT4HEPfjmLoKw6FHVI2Kh+trYgjeFItehw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399003; c=relaxed/simple;
	bh=bgUxttEOc8bbIrI++YGvuJ2XDUOAzzYGK0IaAtH2dHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIhJG0GmElsZ6Bg+2EG5uGkOHBn2QOh1T6VgcLfmm6UMBKok8cXEiMZlVQ6QwqoODUfH+fIEOp7Dj5XBLnv64HpoaKDa66rFySxhUg1dNwSSCD+yjS5nA9CbltxHSnRdjcQMXDTiS2FSojgXjGqZz+oOyswcplphUOKuFA53eHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=lZwA9+I7; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="lZwA9+I7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4956242332dso15694585e9.2
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 01:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785398998; cv=none;
        d=google.com; s=arc-20260327;
        b=BRMv8ai5afsqmZDbhETUMVZDLHdVy501Wr2OMo/138DOlEpDzKkNMdG4/ajydbbpdL
         /Yy4XGyAFvzKWLMOJWo80KxprE5FX6jqxyZs4i7/kbv2RdqgXZ0aoUXCDKz1r65y9JVF
         ErHaYjkl+QTf5xg3R+2zacQIo/9+8/B9mXGNgvZxQzv6gpvB79jzF81yvbkESgVwEvUR
         g5LypQV2sCs1wehKxnQBq/eyy3uLYdC6/k24uiC64AqUkAqeDxR8y3jXmZuZ3YKbCpZB
         7D+GMubEPhOGg8HjhVRH7eRgvbtnM7VzFiuHdYhKHtgjtiGzjkGtqtukB4bnX+aB+uIP
         e71Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I28fJ6EFOJn8CYutxyUmwtvmtpycDXSI/8E+Uz2TqT4=;
        fh=LmeuBNSXPp3ayeGX8omY3GcddkN+3NDqONe0+Lk8IlA=;
        b=JE4xFwrifmOGcQtbgauOuwnWl89QfS4V1dX0jHvhOEdHuIia2Uq7zBKIy6G+gnhcz3
         ecqMf/FVBnevsrQyqIQZG4AVITc8bdKbHUBmMWBNRKkRX2FGi4vhjHNuV+wtXCc01qL1
         mMkqtbifQG1CkeBa6560D4GY/aTX24KGPNqQSWJ/WR0k/DEbHO/kKmxknO+IuaLlNrqy
         FnJ2qoFotPNPXeERWEdbJ4ONvp3rQQAq1GDSWOTBr82dt6D5s/gBRb/NeDYMdbyida1Z
         HBHBkzcGSywJk9OyMmKVxoofy18imzz20gluDcW6/SvEGMD28QgXRJuQ43cvw43smCsO
         Cdkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785398998; x=1786003798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I28fJ6EFOJn8CYutxyUmwtvmtpycDXSI/8E+Uz2TqT4=;
        b=lZwA9+I7yyCCOSA23ynYkpGev2jLMQoUApLbUd1YG2oTi65GQsb8l9/FPfaDrq9Z3Q
         WoB5MkxFmiQgWDM076ekGP6DnjLg0EbqkZ7QseUsF43IrH6W0GHzZtpEH6+bnSuQ0DUo
         l0aYBT4yPnYaMR0WioZuiazBTsNG4CYTfNls2FFkuXU2SFnyU7enC7itx69DbRHu768I
         DEGCoAh1zQMZgLQMvVE443frSzOW1B71sdhahBVKrnkBC7IkbtcYEcEdPdgVuFUfiOlj
         7qywFAZ2WI3/vh0QufsYkmfOYoU3KjSbgXUJPwA9xe9bXfDnlqPZiDnhZJVK80V7IiPl
         S3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785398998; x=1786003798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I28fJ6EFOJn8CYutxyUmwtvmtpycDXSI/8E+Uz2TqT4=;
        b=PlcOP2Xr86qL10p84KhK9sGAPSTT1LvZfPez52/+QpxFhxd5/hAf7mYS2vr2OOHIB8
         QB2jrsA68uhgrNdilLZZxl18mKTri06/rS8DIe0TJE23Ceb1TKJLN9PHRR0VRWVdy+BP
         Sl7+bkTQLQBQZmcTBOcikgkD1F3mFtW/TVt1Py2OVyLnxCRrFBt+g1MhUsjcOAiFNfeD
         z35KOtL3XFDP5MmS4cH1djqSYWU2JVuAfz1GHbY9/pdNm3ol12GrY4Pqqb3uyxMwi7YL
         V1uxGGDiaIaxgOakmpqcFu1xp/7x/7+qrRj7oBuye3MhMZPHkJcBxO7kPvkicztUxsIt
         lkIA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9kIgTVFapgKltvz2vYBD3WZkp9OOdpLIgMwGB/juFxnBrnNp8z0ZIzn85FShcIDq0iSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4YSYp/96lyx8Hgk4zeGnO5QN3QO78hUpMKvOCHPpkXL16yatm
	nexVx++Vo1XsLZDZ5jFD76AloHHlnAD7V6qM/wD5ogud0Dv8c1l4Y+YbyCq7TKPKILUQk8iu8R4
	UYrtk6Dpzmd4A739jNHm5OSyVxVx6ipKBc0u/xxhrDg==
X-Gm-Gg: AR+sD13BjXcu9Xf8+/dJtdGCKQjGUX63o4sx21Knci3u76s+FTOi0c4rheh1ntK2oO+
	stNCeboKLm0z+TWFRQjOFEm3ChUwzAkVVFYmSZkEqXzyTOYYIUxtt2aWdDBF6w9WhyDrXL4fyji
	Poja/5I0X3p/Xl3u5wFDbY8FxKQa1Oml2w6O9aJ1GQYyi4Zo1kyRM/iOjUmTcBK3XsAoUUqWtcD
	UJGY8JhloMOIHXAXuC1NfEzIUahOJUFDd1kVh/dq7lLfWKRKzFaPBWcjVLPYRrAOuKYv9Hca9gp
	If4WzJZwYX/rjZ9L/Dc9QfHtjxrLRp5Drs/R6kmfeNwtSyKpaYUPQZLQPMPxC5NRAE923zCgIqK
	nQUX875LOAqShrVOrQV0Tsp/+z5GDCnwKc2U1SCy+OeZWmUsP1Is8VF3iC8r7RmdJIWwS3cQuVs
	JLdyhs9TpGcg==
X-Received: by 2002:a05:600c:46cb:b0:497:fee2:f54f with SMTP id
 5b1f17b1804b1-49800eb74famr18543495e9.28.1785398998244; Thu, 30 Jul 2026
 01:09:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626103619.174179-1-yhchen312@gmail.com> <20260730065711.3721489-1-yhchen312@gmail.com>
In-Reply-To: <20260730065711.3721489-1-yhchen312@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 30 Jul 2026 13:39:45 +0530
X-Gm-Features: AUfX_mwaS-0L_QunPthFIR0wUkd9jd-G1TNThdyyB0C0UI4rKdyrC64gP7qrcWY
Message-ID: <CAAhSdy3x-Dtv+QR0UkR9xtHPqV1R+fxYyE1OAbon3yXJS1nq8Q@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Add arch-specific tracepoints
To: "Yuhang.Chen" <yhchen312@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Quan Zhou <zhouquan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 12:27=E2=80=AFPM Yuhang.Chen <yhchen312@gmail.com> =
wrote:
>
> Add RISC-V KVM tracepoints for events that are useful when debugging
> guest exits and in-kernel emulation paths. The existing kvm_entry and
> kvm_exit tracepoints are kept, with the kvm_entry PC format fixed to use
> zero-padded hexadecimal output.
>
> The newly added tracepoints cover:
>
> - kvm_vcpu_exit for synchronous guest traps
> - kvm_vcpu_irq for VS-mode interrupt set/clear
> - kvm_mmio_emulate for MMIO load/store emulation
>
> kvm_vcpu_exit reports the full trap context (sepc/scause/stval/htval/
> htinst) so userspace can filter by scause, and is placed after the
> interrupt early-return so it fires only for synchronous traps.
> kvm_vcpu_irq covers every set/unset_interrupt() caller from a single
> place.
>
> Example trace output:
>
> kvm_vcpu_exit:
> VCPU: 0, SEPC: 0x80200000, SCAUSE: 0x17,
> STVAL: 0x10000000, HTVAL: 0x4000000, HTINST: 0x2023
>
> kvm_mmio_emulate:
> VCPU: 0, Store MMIO at 0x10000000, len 4, insn 0x2023, sepc 0x80200000
>
> kvm_vcpu_irq:
> VCPU: 0, IRQ: 10, level: 1
>
> Testing:
>
> A QEMU-based test program was used to exercise:
>
> - Guest page faults
> - MMIO emulation
> - IRQ injection
>
> Verified trace output generation for:
>
> - kvm_vcpu_exit
> - kvm_vcpu_irq
> - kvm_mmio_emulate
>
> Assisted-by: YuanSheng:deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Yuhang.Chen <yhchen312@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3

Thanks,
Anup

> ---
> Changes in v2, per Anup Patel's review [1]:
>
> - Replace the per-cause tracepoints kvm_guest_fault, kvm_sbi_ecall,
>   kvm_wait_riscv and kvm_csr_access with a single generic kvm_vcpu_exit
>   tracepoint that reports the full trap context (sepc/scause/stval/
>   htval/htinst).
> - Replace kvm_irq_line and kvm_timer_update_irq with a single generic
>   kvm_vcpu_irq tracepoint covering all set/unset_interrupt() callers.
> - Keep kvm_mmio_emulate.
> - Drop the now-unused trace.h includes from vcpu_sbi.c, vcpu_timer.c
>   and vm.c.
>
> [1] https://lore.kernel.org/all/CAAhSdy2Qa2DGFzb27MgmoH5Pf1BOrgwaZBqP__U9=
eejs5-5Bsw@mail.gmail.com/
> ---
>  arch/riscv/kvm/trace.h     | 81 +++++++++++++++++++++++++++++++++++++-
>  arch/riscv/kvm/vcpu.c      |  4 ++
>  arch/riscv/kvm/vcpu_exit.c |  4 ++
>  arch/riscv/kvm/vcpu_insn.c | 13 +++++-
>  4 files changed, 98 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kvm/trace.h b/arch/riscv/kvm/trace.h
> index 3d54175d805c..23a5fd1b686e 100644
> --- a/arch/riscv/kvm/trace.h
> +++ b/arch/riscv/kvm/trace.h
> @@ -25,7 +25,7 @@ TRACE_EVENT(kvm_entry,
>                 __entry->pc     =3D vcpu->arch.guest_context.sepc;
>         ),
>
> -       TP_printk("PC: 0x016%lx", __entry->pc)
> +       TP_printk("PC: 0x%016lx", __entry->pc)
>  );
>
>  TRACE_EVENT(kvm_exit,
> @@ -56,7 +56,84 @@ TRACE_EVENT(kvm_exit,
>                 __entry->htinst)
>  );
>
> -#endif /* _TRACE_RSICV_KVM_H */
> +TRACE_EVENT(kvm_mmio_emulate,
> +       TP_PROTO(unsigned long vcpu_id, unsigned long sepc, unsigned long=
 insn,
> +                unsigned long fault_addr, bool write, int len),
> +       TP_ARGS(vcpu_id, sepc, insn, fault_addr, write, len),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned long, vcpu_id)
> +               __field(unsigned long, sepc)
> +               __field(unsigned long, insn)
> +               __field(unsigned long, fault_addr)
> +               __field(bool, write)
> +               __field(int, len)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->vcpu_id        =3D vcpu_id;
> +               __entry->sepc           =3D sepc;
> +               __entry->insn           =3D insn;
> +               __entry->fault_addr     =3D fault_addr;
> +               __entry->write          =3D write;
> +               __entry->len            =3D len;
> +       ),
> +
> +       TP_printk("VCPU: %lu, %s MMIO at 0x%lx, len %d, insn 0x%lx, sepc =
0x%lx",
> +                 __entry->vcpu_id, __entry->write ? "Store" : "Load",
> +                 __entry->fault_addr, __entry->len, __entry->insn,
> +                 __entry->sepc)
> +);
> +
> +TRACE_EVENT(kvm_vcpu_exit,
> +       TP_PROTO(unsigned long vcpu_id, unsigned long sepc, unsigned long=
 scause,
> +                unsigned long stval, unsigned long htval, unsigned long =
htinst),
> +       TP_ARGS(vcpu_id, sepc, scause, stval, htval, htinst),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned long, vcpu_id)
> +               __field(unsigned long, sepc)
> +               __field(unsigned long, scause)
> +               __field(unsigned long, stval)
> +               __field(unsigned long, htval)
> +               __field(unsigned long, htinst)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->vcpu_id        =3D vcpu_id;
> +               __entry->sepc           =3D sepc;
> +               __entry->scause         =3D scause;
> +               __entry->stval          =3D stval;
> +               __entry->htval          =3D htval;
> +               __entry->htinst         =3D htinst;
> +       ),
> +
> +       TP_printk("VCPU: %lu, SEPC: 0x%lx, SCAUSE: 0x%lx, STVAL: 0x%lx, H=
TVAL: 0x%lx, HTINST: 0x%lx",
> +                 __entry->vcpu_id, __entry->sepc, __entry->scause,
> +                 __entry->stval, __entry->htval, __entry->htinst)
> +);
> +
> +TRACE_EVENT(kvm_vcpu_irq,
> +       TP_PROTO(unsigned long vcpu_id, unsigned int irq, int level),
> +       TP_ARGS(vcpu_id, irq, level),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned long, vcpu_id)
> +               __field(unsigned int, irq)
> +               __field(int, level)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->vcpu_id        =3D vcpu_id;
> +               __entry->irq            =3D irq;
> +               __entry->level          =3D level;
> +       ),
> +
> +       TP_printk("VCPU: %lu, IRQ: %u, level: %d",
> +                 __entry->vcpu_id, __entry->irq, __entry->level)
> +);
> +
> +#endif /* _TRACE_KVM_H */
>
>  #undef TRACE_INCLUDE_PATH
>  #define TRACE_INCLUDE_PATH .
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 977e36ab83d3..c0556cb4caa5 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -439,6 +439,8 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcp=
u, unsigned int irq)
>         __set_bit(irq, vcpu->arch.irqs_pending_mask);
>         raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
> +       trace_kvm_vcpu_irq(vcpu->vcpu_id, irq, 1);
> +
>         kvm_vcpu_kick(vcpu);
>
>         return 0;
> @@ -465,6 +467,8 @@ int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *v=
cpu, unsigned int irq)
>         __set_bit(irq, vcpu->arch.irqs_pending_mask);
>         raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
> +       trace_kvm_vcpu_irq(vcpu->vcpu_id, irq, 0);
> +
>         return 0;
>  }
>
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 6c8530b9f29e..d03c6e82b1bc 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -11,6 +11,7 @@
>  #include <asm/insn-def.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/kvm_nacl.h>
> +#include "trace.h"
>
>  static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
>                              struct kvm_cpu_trap *trap)
> @@ -212,6 +213,9 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct=
 kvm_run *run,
>         if (trap->scause & CAUSE_IRQ_FLAG)
>                 return 1;
>
> +       trace_kvm_vcpu_exit(vcpu->vcpu_id, trap->sepc, trap->scause,
> +                           trap->stval, trap->htval, trap->htinst);
> +
>         /* Handle guest traps */
>         ret =3D -EFAULT;
>         run->exit_reason =3D KVM_EXIT_UNKNOWN;
> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index f09f9251d1f0..ef2a827811f3 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
> @@ -9,6 +9,7 @@
>
>  #include <asm/cpufeature.h>
>  #include <asm/insn.h>
> +#include "trace.h"
>
>  struct insn_func {
>         unsigned long mask;
> @@ -375,7 +376,7 @@ int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, s=
truct kvm_run *run,
>                              unsigned long htinst)
>  {
>         u8 data_buf[8];
> -       unsigned long insn;
> +       unsigned long insn, raw_insn;
>         int shift =3D 0, len =3D 0, insn_len =3D 0;
>         struct kvm_cpu_trap utrap =3D { 0 };
>         struct kvm_cpu_context *ct =3D &vcpu->arch.guest_context;
> @@ -405,6 +406,7 @@ int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, s=
truct kvm_run *run,
>                 }
>                 insn_len =3D INSN_LEN(insn);
>         }
> +       raw_insn =3D insn;
>
>         /* Decode length of MMIO and shift */
>         if ((insn & INSN_MASK_LW) =3D=3D INSN_MATCH_LW) {
> @@ -453,6 +455,9 @@ int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, s=
truct kvm_run *run,
>         if (fault_addr & (len - 1))
>                 return -EIO;
>
> +       trace_kvm_mmio_emulate(vcpu->vcpu_id, ct->sepc, raw_insn, fault_a=
ddr,
> +                              false, len);
> +
>         /* Save instruction decode info */
>         vcpu->arch.mmio_decode.insn =3D insn;
>         vcpu->arch.mmio_decode.insn_len =3D insn_len;
> @@ -502,7 +507,7 @@ int kvm_riscv_vcpu_mmio_store(struct kvm_vcpu *vcpu, =
struct kvm_run *run,
>         u32 data32;
>         u64 data64;
>         ulong data;
> -       unsigned long insn;
> +       unsigned long insn, raw_insn;
>         int len =3D 0, insn_len =3D 0;
>         struct kvm_cpu_trap utrap =3D { 0 };
>         struct kvm_cpu_context *ct =3D &vcpu->arch.guest_context;
> @@ -532,6 +537,7 @@ int kvm_riscv_vcpu_mmio_store(struct kvm_vcpu *vcpu, =
struct kvm_run *run,
>                 }
>                 insn_len =3D INSN_LEN(insn);
>         }
> +       raw_insn =3D insn;
>
>         data =3D GET_RS2(insn, &vcpu->arch.guest_context);
>         data8 =3D data16 =3D data32 =3D data64 =3D data;
> @@ -570,6 +576,9 @@ int kvm_riscv_vcpu_mmio_store(struct kvm_vcpu *vcpu, =
struct kvm_run *run,
>         if (fault_addr & (len - 1))
>                 return -EIO;
>
> +       trace_kvm_mmio_emulate(vcpu->vcpu_id, ct->sepc, raw_insn, fault_a=
ddr,
> +                              true, len);
> +
>         /* Save instruction decode info */
>         vcpu->arch.mmio_decode.insn =3D insn;
>         vcpu->arch.mmio_decode.insn_len =3D insn_len;
> --
> 2.34.1
>
