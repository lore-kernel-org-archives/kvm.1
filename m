Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE213D301F
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780552151; cv=pass; b=qSBnD0URWFuM2YRjh9hwNLMjKm3ISXXLHGi99qSYzP4Y7d5zUXqPyApKgFL3z0BXlV8NGgoUQGVPOV8BflxFy4YStb78F1Z1uUl1YR6I6OjU9odiFqHolL4twIBHoluOZhakKmaBbv3oBV6I2Y0sJFuh3JN2Ottt7kbpAFpTNZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780552151; c=relaxed/simple;
	bh=ZOgnx+X7WI8kQhjeVpIpcvYh7MMBs5sOqtCLGS58iWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTckVgFc1tcWmLEFRvZdKW78R9EBhkc79uiKPFXPEh46GikSUasPVJbx+LNc55No364qR7SRHwADxNtgTg5oxQQsmMx3cR6K06b2n+6bbPqoXtFb+p7EvezgxubEU0QaYZNGNFlC/eKKBgaZM+ZamxsetnIuhvMA4PdQfEn/djU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=TDwKYPMF; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="TDwKYPMF"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5177b1a7441so5216731cf.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 22:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780552147; cv=none;
        d=google.com; s=arc-20240605;
        b=c1vfhJhc78vPOBPnOCzNGYnKCXnwc5mO9CEXAs8n+l9szmUqTrFjW5mo5fbM6SHkb+
         xEsVW6+n8sBRZNfZ7N0fmrk6+pXqIY42HacQK8dO2TLErbs3Y9xvBmhT+62YlpWx87D8
         /fEL5NqE8GwBYaPkHUpIBWR+eg8fdml0ucIpLS18SxhSQIjqint38HxmJM6ml0SqxTAo
         xdFCInXnP/Z8sXwm7i0XbJ2TA0OGg6pXKVOmEOR/p6EJCpddBSb/Bjwk+2AW9nG6fuvH
         nOUezM6sr7nLYLaHg59qNi2xIUSy+mgveduX8Eje7IvkQQI/guadC4W75gOMuMiqbsOQ
         554A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PIUh8wR1+0AAFR8fB6HVLdYG12z8klZ1AKaxwRhBZSw=;
        fh=sxXW/tPlvmOmxE0Dp5aDPFWeD9ewlIgK5idCf5oafL0=;
        b=bdpoHZ3LCpNzoG1VXHrbftSo5NKjvYVaLF4/qb3dCgs/HAX9kYUzLX/rU4a1HRStCi
         ndNGoKBdU7mfJt/gSJvqTAkyvjgWU6QmTTQf0MEn8Pz70q214xwv+oqJJtB5YPTECK5x
         NPwPKnEnASm4Nu7aXh/tj25Ef2sRvjwPH8nSR8JvbyYYUMHqwLUebVXTKjQoD7b13I5V
         ACYN/BTZmPoFTMDJQboeKPTGA9reagsJTfE+cb5FryaJWlH5TbZjYSdE3Eg6mcGNmH0B
         RivRbHr3JOBMmAqXP9pZ9PUmHmHEWAe/DNtMByeBFeaypu+h68tXFgd3GUQA/Fz6uZOB
         l9oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780552147; x=1781156947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIUh8wR1+0AAFR8fB6HVLdYG12z8klZ1AKaxwRhBZSw=;
        b=TDwKYPMFVtPw9aenFcjQ6s0kpUlfjpU53TGzsaPUZaic4e/zb6uLlP6KlVHzr+a1BV
         VPSQcK5s2yzQ2SgQ1U9fvp1Xk00cT8guoy4P6Ne83DPpDt4+Suk0c6O8YQ01kCLgffhM
         RANMT5rsuRV4TAMKc4bCvkjXrvGk2v5uJRUEtOhDpzz05aId2IqYjKIVes2IDYFREvgP
         wjfdLvkXW6oXBDm9TkE3LdNa7Nw5PXAgLwcrQdCSrH2hQEMIOD1nM0No5RgFvJJPFyPi
         fzsEX0MenmcfjMBbnOcKzhHgaaGDY2/Ayc7iOKVV29hp7IMBchEm1Ox9HXzUR2TXswmw
         wzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780552147; x=1781156947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PIUh8wR1+0AAFR8fB6HVLdYG12z8klZ1AKaxwRhBZSw=;
        b=LbKUQaepC8LO2bJIE3J/61QcecDWiqPt/8EQoeyq9zABhnB6fJDikj3im7WxGIHp+F
         +eoA//J1Cfzf9Jdrob34oDCWXxFoArIMn1QOO5BLPRgNzUCtvNrFgfHI3SZtDDl6oA9+
         RCOauyTKZQ+56X/tWTZhowa3d0d+dVG1mvkja56Q5BrXNoARVzUc/N79/pY+90nIaa82
         e08Yh2+9+R9e4LcbVIubqkcQxipQTRYFsMsgrKnX0Ma7GuG+0PnkH+IchyU4OWEfUDu9
         YKtibT7zEP9006L+UmjVnxmTRZlfM5ryFxH9Owd5hULywtyWbGHNTrszPgOpVlppk7py
         FBJw==
X-Forwarded-Encrypted: i=1; AFNElJ8C+AVK66ce5etd4V3vOuvDMHdFhxIKzmDNHTyQp6Trs2n6kM5G5aj1PSTAaoj/0RooU6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl0FPseyxEKe6QFA/ogxb4TSwMCLAjEf6iyVsVozMb66ypUqxf
	3LEfH5vJOdDQPi5oFDdN8Wooa3PB9SchCPTq+vAqdCDkUQ/XQHk2ArNte83f5Yu7SaI4d/Kj2C0
	5gOzQTtWTCZlaGfIgLzc3hv0zQwYPCfv1JL3UFeAJKQ==
X-Gm-Gg: Acq92OHAuVc0wdfvv9ZbmjFQNhqXLnPgQJta4DzdfCG4uB1+IzuHbp67KdvTXy4Z8aP
	p90XpSK50Ps/rn5NAsJSEUHy2CkJcjyFnoYlnn9wRhhkJ2UNUEeZNmO8jEZn0OVFWajwfn2VoNE
	vjzaujMysw3WXZCqjr8uDJui8gN/oSYZ3tlezEPlWpVVkdHSaXDLYMXHQPtI4LODZKkcrEIXcXu
	1R55gVNct8GjE3Ep4mOEuk0fwWs02tWcfKSYPi7yySaCgsvGSe8VgxlNReJ8tMs2OhfI1T4VCbh
	4DLA0JDeaKJNE1An1E+tUbSW6DwH0eeykW4OVw+qwY+cs0/ogdyk3MqaRKEeN26i38vpjXJOnDD
	vG4wOrJ3ZYyKO6xq6wLmOvQjfRzK9uiW+NI0Z
X-Received: by 2002:a05:622a:6113:b0:516:df5b:4338 with SMTP id
 d75a77b69052e-517786fe3aamr94112741cf.28.1780552146620; Wed, 03 Jun 2026
 22:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526031517.1166025-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260526031517.1166025-1-xujiakai2025@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 4 Jun 2026 11:18:53 +0530
X-Gm-Features: AVHnY4LyQ7maifTN_o50bMgh-xrYsnwlJAwt9wlqVzVOlVBs2GIDYLsvccHKq1w
Message-ID: <CAAhSdy0RxUMYP-fs5=drG+6iwVEmwiVvHRL2MRieEXP7YiERjg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix NULL pointer dereference in AIA IMSIC functions
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Nutty Liu <liujingqi@lanxincomputing.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 8:45=E2=80=AFAM Jiakai Xu <xujiakai2025@iscas.ac.cn=
> wrote:
>
> Fuzzer reported a NULL pointer dereference in
> kvm_riscv_vcpu_aia_imsic_put() when a VCPU's imsic_state was NULL while
> kvm_riscv_aia_initialized() returned true.
>
> The global initialized flag is set per-VM in aia_init(), but imsic_state
> is allocated per-VCPU in kvm_riscv_vcpu_aia_imsic_init(). If a VCPU is
> created after aia_init() has already run, its imsic_state remains NULL
> while the global flag is true. When this VCPU is preempted, kvm_sched_out=
()
> calls kvm_arch_vcpu_put() -> kvm_riscv_vcpu_aia_put() ->
> kvm_riscv_vcpu_aia_imsic_put() which dereferences NULL.
>
> Add NULL pointer guards to kvm_riscv_vcpu_aia_imsic_put(), consistent wit=
h
> the NULL checks already present in all other functions in the same file.
>
> Also add a NULL guard to kvm_riscv_vcpu_aia_imsic_release() and
> kvm_riscv_vcpu_aia_imsic_has_interrupt() for the same reason.
>
> Fixes: 4cec89db80ba ("RISC-V: KVM: Move HGEI[E|P] CSR access to IMSIC vir=
tualization")
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> Assisted-by: YuanSheng:DeepSeek-V3.2

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.2

Thanks,
Anup

> ---
>  arch/riscv/kvm/aia_imsic.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index 8786f52cf65a2..d38f5de0834c5 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -683,6 +683,9 @@ bool kvm_riscv_vcpu_aia_imsic_has_interrupt(struct kv=
m_vcpu *vcpu)
>         unsigned long flags;
>         bool ret =3D false;
>
> +       if (!imsic)
> +               return false;
> +
>         /*
>          * The IMSIC SW-file directly injects interrupt via hvip so
>          * only check for interrupt when IMSIC VS-file is being used.
> @@ -722,6 +725,9 @@ void kvm_riscv_vcpu_aia_imsic_put(struct kvm_vcpu *vc=
pu)
>         struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
>         unsigned long flags;
>
> +       if (!imsic)
> +               return;
> +
>         if (!kvm_vcpu_is_blocking(vcpu))
>                 return;
>
> @@ -738,6 +744,9 @@ void kvm_riscv_vcpu_aia_imsic_release(struct kvm_vcpu=
 *vcpu)
>         int old_vsfile_hgei, old_vsfile_cpu;
>         struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
>
> +       if (!imsic)
> +               return;
> +
>         /* Read and clear IMSIC VS-file details */
>         write_lock_irqsave(&imsic->vsfile_lock, flags);
>         old_vsfile_hgei =3D imsic->vsfile_hgei;
> --
> 2.34.1
>
> Found by fuzzing. Here is the report:
>
> Unable to handle kernel paging request at virtual address dfffffff0000000=
6
> Modules linked in:
> CPU: 1 UID: 0 PID: 26225 Comm: syz.9.1131 Tainted: G        W           7=
.1.0-rc1-gb69bcb13ed70 #2 PREEMPT
> Tainted: [W]=3DWARN
> Hardware name: riscv-virtio,qemu (DT)
> epc : kasan_byte_accessible+0x12/0x20 mm/kasan/generic.c:210
>  ra : __kasan_check_byte+0x16/0x46 mm/kasan/common.c:573
> epc : ffffffff80beb626 ra : ffffffff80be9622 sp : ff200000016276a0
>  gp : ffffffff8a395320 tp : ff6000008f6f5040 t0 : ffffffff86a7e880
>  t1 : ffffffff8a4a4a00 t2 : 0000000000000000 s0 : ff200000016276b0
>  s1 : 0000000000000030 a0 : dfffffff00000006 a1 : ffffffff867223e4
>  a2 : 0000000000000000 a3 : 0000000000000007 a4 : 0000000000000003
>  a5 : dfffffff00000000 a6 : ffffffff8010e72c a7 : 0000000000000004
>  s2 : 0000000000000030 s3 : ffffffff867223e4 s4 : 0000000000000000
>  s5 : 0000000000000000 s6 : 0000000000000000 s7 : ffffffff8010e72c
>  s8 : ffffffff867223e4 s9 : ffffffff8a3da080 s10: 0000085c7b3d0060
>  s11: ff6000008f6f5040 t3 : ffffffff8a4a4a00 t4 : ffffffff8a4a5a80
>  t5 : 1ffffffff22ed7d1 t6 : ff600000ffa4d710 ssp : 0000000000000000
> status: 0000000200000100 badaddr: dfffffff00000006 cause: 000000000000000=
d
> [<ffffffff80beb626>] kasan_mem_to_shadow include/linux/kasan.h:66 [inline=
]
> [<ffffffff80beb626>] kasan_byte_accessible+0x12/0x20 mm/kasan/generic.c:2=
10
> [<ffffffff80be9622>] __kasan_check_byte+0x16/0x46 mm/kasan/common.c:573
> [<ffffffff802fe7ba>] kasan_check_byte include/linux/kasan.h:402 [inline]
> [<ffffffff802fe7ba>] lock_acquire kernel/locking/lockdep.c:5842 [inline]
> [<ffffffff802fe7ba>] lock_acquire+0x198/0x50e kernel/locking/lockdep.c:58=
25
> [<ffffffff867223e4>] __raw_read_lock_irqsave include/linux/rwlock_api_smp=
.h:174 [inline]
> [<ffffffff867223e4>] _raw_read_lock_irqsave+0x76/0x82 kernel/locking/spin=
lock.c:240
> [<ffffffff8010e72c>] kvm_riscv_vcpu_aia_imsic_put+0x72/0x17c arch/riscv/k=
vm/aia_imsic.c:728
> [<ffffffff80101bda>] kvm_riscv_vcpu_aia_put+0x288/0x324 arch/riscv/kvm/ai=
a.c:155
> [<ffffffff8011f210>] kvm_arch_vcpu_put+0x44/0x612 arch/riscv/kvm/vcpu.c:6=
21
> [<ffffffff800d50aa>] kvm_sched_out+0xdc/0x296 virt/kvm/kvm_main.c:6405
> [<ffffffff86705faa>] __fire_sched_out_preempt_notifiers kernel/sched/core=
.c:4923 [inline]
> [<ffffffff86705faa>] fire_sched_out_preempt_notifiers kernel/sched/core.c=
:4931 [inline]
> [<ffffffff86705faa>] prepare_task_switch kernel/sched/core.c:5176 [inline=
]
> [<ffffffff86705faa>] context_switch kernel/sched/core.c:5332 [inline]
> [<ffffffff86705faa>] __schedule+0x10c8/0x513c kernel/sched/core.c:7188
> [<ffffffff8670a0e2>] __schedule_loop kernel/sched/core.c:7267 [inline]
> [<ffffffff8670a0e2>] schedule+0xc4/0x35e kernel/sched/core.c:7282
> [<ffffffff80121cc2>] kvm_riscv_check_vcpu_requests arch/riscv/kvm/vcpu.c:=
670 [inline]
> [<ffffffff80121cc2>] kvm_arch_vcpu_ioctl_run+0x1d16/0x3214 arch/riscv/kvm=
/vcpu.c:885
> [<ffffffff800da8ee>] kvm_vcpu_ioctl+0x532/0x13ce virt/kvm/kvm_main.c:4469
> [<ffffffff80d45c90>] vfs_ioctl fs/ioctl.c:51 [inline]
> [<ffffffff80d45c90>] __do_sys_ioctl fs/ioctl.c:597 [inline]
> [<ffffffff80d45c90>] __se_sys_ioctl fs/ioctl.c:583 [inline]
> [<ffffffff80d45c90>] __riscv_sys_ioctl+0x180/0x1e4 fs/ioctl.c:583
> [<ffffffff80078fb2>] syscall_handler+0x94/0x118 arch/riscv/include/asm/sy=
scall.h:112
> [<ffffffff866fa94a>] do_trap_ecall_u+0x43e/0x5de arch/riscv/kernel/traps.=
c:342
> [<ffffffff86726756>] handle_exception+0x15e/0x16a arch/riscv/kernel/entry=
.S:232
> Code: 8082 07b7 e000 1141 17fd e422 810d 0800 1782 953e (4503) 0005
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:   8082                    ret
>    2:   e00007b7                lui     a5,0xe0000
>    6:   1141                    addi    sp,sp,-16
>    8:   17fd                    addi    a5,a5,-1 # 0xffffffffdfffffff
>    a:   e422                    fsw     fs0,8(sp)
>    c:   810d                    srli    a0,a0,0x3
>    e:   0800                    addi    s0,sp,16
>   10:   1782                    slli    a5,a5,0x20
>   12:   953e                    add     a0,a0,a5
> * 14:   00054503                lbu     a0,0(a0) <-- trapping instruction
>
> <<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>
>
