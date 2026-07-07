Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241802F39B8
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440334; cv=pass; b=UU0DmRy31BC3hGUJ5+vqblOeWVTq8plPC2AxX/0QPEk/ltHT+J1my2YiGf4alMtXd0AiqFCBat9WF8hJg6C4DlqgYAiQwt3KAU8IVxHv/Xu+AYRzJUIcnhHjDS4+KLet66mHWXwDg6iuHjZREBpPTI8V1nKbtqSpj7cy1KYdZ1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440334; c=relaxed/simple;
	bh=MU5J38kNi5nHMKheIjGe/Xm+qFWaP07mV2SMmt1DBU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKxaW2yRioEdepba8umVHVP/KJ5Ckg4R4D0N+dfFpT+1yXgrvRq8tbnCbLWxT1yJ95ETVkRgUD5uYSXE+zp4jmwEYZAaWwUYxdOMjOTj3fZ7/N/HJBRQG39lUbtMeMjLQ2UVJIsZVXt/jbHpUZrNIKCXD00lS1EEBfdrMQzYEi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=j6fbqiIR; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="j6fbqiIR"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47362928f65so4150068f8f.2
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 09:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783440330; cv=none;
        d=google.com; s=arc-20260327;
        b=N6DT7KZEGp0Pa+ELprNdnujCOpk8wjOgwf4xz1gLR92FUIBnUjyyUIwi6Se939uQ8X
         dfEm5AF4pRCbD1CBuTS+t9deuKVMS/OOxltkLn4TqTQDX44nChkfoanDo7yENp61brTc
         PyrK8UGscVWXjJdQhM38SffzpYAm5kXdouC+Dk72cd1BgF0N6hvvX/yE5fy+WtZwTGg8
         BpDPpDLTB3t5Zjwc61Gv5+XBN28fs9ViJ5x2dOnXWTW4KqzEH/VHEQTGzcET82VhjPgm
         Zmbnmaq3hUOCzyTggPYo5Sz9A4O0y87czqfhO2wYZXEeOVoXJTMahgUy7dcHALwhRsuv
         EFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V/DlJkDGqxbF36EBGePC3r0EE77kaV1bH979h2i3FPo=;
        fh=sEtVVThqybTySKOYIwnpiM3uPgxS0URoiRnu1yw/vcM=;
        b=O7grzgqGCWdxYHigNmdSWSAPujVQB4jzOrfrWqkYqkV/z3ofakgDYB6PqLDz9PYwQX
         n6vsXePDNalR570Vwp3dI+/tQO8fttNHC73kPcoM4dFKnP+oQ0bTLdgxHCDtbJjg5Nfr
         P/eDO31SuSSFyOs7cnLOi4kesDrdS9Cfgl1juEc58pSNT0a3JXBa8LeBmAP8IXN514MY
         /RjPMcnX0uznxIWxGz/urT+8oo3QaazG4WB6NaFzDCS/nOyeu6tqDY4rqCiNAxRstkvX
         JT9oLno17ZhJNRScBPvbbhb9sAySWy7Akmzb/DBXjl9807qTUW2Ms/REB3bxXxP5XvAj
         T0Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1783440330; x=1784045130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/DlJkDGqxbF36EBGePC3r0EE77kaV1bH979h2i3FPo=;
        b=j6fbqiIRymJ+kxDFZcrFI1ZUPn045w8hOPCCRe0GNUvDJDCnlFkfk0jpSRk2DBmJ+a
         1Q7xM/YToHBWOLXbtCPS5XFT1oJ15Xnc4HDHMRSzyO70XhAfDRTFFraUK1JasvIsX4dD
         PnCmmBHaow44d1Yh1gINwtAKjoUdYa9oFKaldO9DZhl21HFYa/20ySUpospjC+nCIFwQ
         DeroWA02z8lrpIR/TzeW6S9zxaxlkGuAbTvfBylkPmrf9CX7QVUM5wmexD/hKdf9Xi74
         9adBpBAljyBtTs1C934CvLdW3g3p9m3SUjs3c7jlmhu1flo6BMArSh7P7L1TjkMUKNmX
         v/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783440330; x=1784045130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V/DlJkDGqxbF36EBGePC3r0EE77kaV1bH979h2i3FPo=;
        b=rQQXCPLzxNkd0VsZqZAOQ+QJf8lg773SA1/c4TCd6oqDip1GoeDB7KppfPZOZJzm7d
         uxgzDJ8IQAcIiUntPzEFq4l3wNYCCvJvpr0MU+J6mjDIOfByL5apJ7lBmDltrD8rURWM
         XCGHwIW4nSHLH9vEdo1ANTvlp9QSmTu2y2jUePGs+w6wa95Kiwwaq1tkhFzJoeGJAQtj
         txI462WK3HF9fVJKyxHzE6Md824dXaB6/ZtZX1/6kK+FsDQXjAJNkeNN01mZwaPJikK3
         KvXiFWWuCrFmHEuhscwPIBuVeXWWTGfdHXOd0FSqseZjn9K7ovDlqINdgz0Biq2MSjOM
         YJ9Q==
X-Forwarded-Encrypted: i=1; AHgh+RrGXzN+cZ10yBAGJIMhkOx3/xtGEjdneqvZ3+OJ1KgTvXYcV8KtwQacvNAnJUnsXw0KmsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznJywOBwWOkijL1OkCbRRXySRWNeJe+x11GIrHnKUS7tD58jw1
	FtrNe9JI1Wow+Ipx5Ft/xLOqtXVzICVUtwt/zHu0jwrasby432CtyQaFwq2Bvxz/3Ime6bLytwK
	8+kHwF0d1QYB84q0uoU2hwbAr9jeZNEQ0JtK63+sesssdjL+NVkrG
X-Gm-Gg: AfdE7ckyKFoSsEb35gE4oa8GwbULS9ft63ayzylcG1oHDkNxPRhXtYWiUL551EvPAfT
	5onTfRXbUujASLhePTcZ3LvYpWPfvwuQEU4U5NFdg3jicHp3thVvlKgOhgfekeAFGqKzik/V/vX
	SsEwRNSaH9ZIRXAa07o7zPp3ZT/wXNmoRi5EY40euDcwja1gVtx0CI3VKjWq7TQH9G92DoaPcTI
	YhJeXd/p6Z8sfl2vIz9MEMktkSjSN4o6M35xLEFM1MroSvqSJRaIc2VVV4pkYR1k8WIKcviGCB0
	nSbIxmjCwd8mGds3q9yJka1m/JwJOdM5VPVJ3rFVxHmmPVMwXyb1hMYjlRXu26jhdqAd+X8mGR7
	UqZTyUQERYMVO7po=
X-Received: by 2002:a05:600c:5297:b0:493:b2c1:b2f9 with SMTP id
 5b1f17b1804b1-493df06214bmr68876505e9.8.1783440330210; Tue, 07 Jul 2026
 09:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ag_N8H3e3YzjRb8j@chonkvm.lixom.net> <20260528190927.886558-1-tchiu@tenstorrent.com>
 <20260528190927.886558-2-tchiu@tenstorrent.com>
In-Reply-To: <20260528190927.886558-2-tchiu@tenstorrent.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 7 Jul 2026 21:35:18 +0530
X-Gm-Features: AVVi8CcWdFCu1n2raU_TmAMBKLSfTrwte2kK_76gBl0xIpAUvJ1Tsw2-3WZveWM
Message-ID: <CAAhSdy0UTST5W7wvTcpF0y-+1AE0Mz6cPChBxrtsr7PWCAqh2w@mail.gmail.com>
Subject: Re: [[PATCH] v4 1/4] riscv: vector: refactor vector context operations
To: Andy Chiu <tchiu@tenstorrent.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, dfustini@oss.tenstorrent.com, 
	greentime.hu@sifive.com, daichengrong <daichengrong@iscas.ac.cn>, 
	Han Gao <rabenda.cn@gmail.com>, Yong-Xuan Wang <yongxuan.wang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 12:41=E2=80=AFAM Andy Chiu <tchiu@tenstorrent.com> =
wrote:
>
> Lift riscv_v_{enable,disable} out of __*vstate_{save,restore,discard} so
> that we can reuse some functions without repeatedly turning on/off
> vector.
>
> Also, refactor and document about the user context save in preempt_v to
> make code more readable.
>
> Signed-off-by: Andy Chiu <tchiu@tenstorrent.com>

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
> Changelog v4:
>  - fix an unused variable warning (Olof)
> Changelog v3:
>  - new patch since v3
> ---
>  arch/riscv/include/asm/kvm_vcpu_vector.h |  8 +++++--
>  arch/riscv/include/asm/vector.h          | 15 ++++++------
>  arch/riscv/kernel/kernel_mode_vector.c   | 29 +++++++++++++++++++-----
>  arch/riscv/kvm/vcpu_vector.c             |  8 +++----
>  4 files changed, 41 insertions(+), 19 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/includ=
e/asm/kvm_vcpu_vector.h
> index 57a798a4cb0d..e679869e2ba3 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_vector.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
> @@ -16,14 +16,18 @@
>  #include <asm/vector.h>
>  #include <asm/kvm_host.h>
>
> -static __always_inline void __kvm_riscv_vector_save(struct kvm_cpu_conte=
xt *context)
> +static __always_inline void kvm_riscv_vector_save(struct kvm_cpu_context=
 *context)
>  {
> +       riscv_v_enable();
>         __riscv_v_vstate_save(&context->vector, context->vector.datap);
> +       riscv_v_disable();
>  }
>
> -static __always_inline void __kvm_riscv_vector_restore(struct kvm_cpu_co=
ntext *context)
> +static __always_inline void kvm_riscv_vector_restore(struct kvm_cpu_cont=
ext *context)
>  {
> +       riscv_v_enable();
>         __riscv_v_vstate_restore(&context->vector, context->vector.datap)=
;
> +       riscv_v_disable();
>  }
>
>  void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu);
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vec=
tor.h
> index 00cb9c0982b1..45820cd900d6 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -198,7 +198,6 @@ static inline void __riscv_v_vstate_save(struct __ris=
cv_v_ext_state *save_to,
>  {
>         unsigned long vl;
>
> -       riscv_v_enable();
>         __vstate_csr_save(save_to);
>         if (has_xtheadvector()) {
>                 asm volatile (
> @@ -227,7 +226,6 @@ static inline void __riscv_v_vstate_save(struct __ris=
cv_v_ext_state *save_to,
>                         ".option pop\n\t"
>                         : "=3D&r" (vl) : "r" (datap) : "memory");
>         }
> -       riscv_v_disable();
>  }
>
>  static inline void __riscv_v_vstate_restore(struct __riscv_v_ext_state *=
restore_from,
> @@ -235,7 +233,6 @@ static inline void __riscv_v_vstate_restore(struct __=
riscv_v_ext_state *restore_
>  {
>         unsigned long vl;
>
> -       riscv_v_enable();
>         if (has_xtheadvector()) {
>                 asm volatile (
>                         "mv t0, %0\n\t"
> @@ -264,14 +261,12 @@ static inline void __riscv_v_vstate_restore(struct =
__riscv_v_ext_state *restore_
>                         : "=3D&r" (vl) : "r" (datap) : "memory");
>         }
>         __vstate_csr_restore(restore_from);
> -       riscv_v_disable();
>  }
>
>  static inline void __riscv_v_vstate_discard(void)
>  {
>         unsigned long vl, vtype_inval =3D 1UL << (BITS_PER_LONG - 1);
>
> -       riscv_v_enable();
>         if (has_xtheadvector())
>                 asm volatile (THEAD_VSETVLI_T4X0E8M8D1 : : : "t4");
>         else
> @@ -291,14 +286,14 @@ static inline void __riscv_v_vstate_discard(void)
>                 "vsetvl         %0, x0, %1\n\t"
>                 ".option pop\n\t"
>                 : "=3D&r" (vl) : "r" (vtype_inval));
> -
> -       riscv_v_disable();
>  }
>
>  static inline void riscv_v_vstate_discard(struct pt_regs *regs)
>  {
>         if (riscv_v_vstate_query(regs)) {
> +               riscv_v_enable();
>                 __riscv_v_vstate_discard();
> +               riscv_v_disable();
>                 __riscv_v_vstate_dirty(regs);
>         }
>  }
> @@ -307,7 +302,9 @@ static inline void riscv_v_vstate_save(struct __riscv=
_v_ext_state *vstate,
>                                        struct pt_regs *regs)
>  {
>         if (__riscv_v_vstate_check(regs->status, DIRTY)) {
> +               riscv_v_enable();
>                 __riscv_v_vstate_save(vstate, vstate->datap);
> +               riscv_v_disable();
>                 __riscv_v_vstate_clean(regs);
>         }
>  }
> @@ -316,7 +313,9 @@ static inline void riscv_v_vstate_restore(struct __ri=
scv_v_ext_state *vstate,
>                                           struct pt_regs *regs)
>  {
>         if (riscv_v_vstate_query(regs)) {
> +               riscv_v_enable();
>                 __riscv_v_vstate_restore(vstate, vstate->datap);
> +               riscv_v_disable();
>                 __riscv_v_vstate_clean(regs);
>         }
>  }
> @@ -378,8 +377,10 @@ static inline void __switch_to_vector(struct task_st=
ruct *prev,
>                         prev->thread.riscv_v_flags |=3D RISCV_PREEMPT_V_I=
N_SCHEDULE;
>                 }
>                 if (riscv_preempt_v_dirty(prev)) {
> +                       riscv_v_enable();
>                         __riscv_v_vstate_save(&prev->thread.kernel_vstate=
,
>                                               prev->thread.kernel_vstate.=
datap);
> +                       riscv_v_disable();
>                         riscv_preempt_v_clear_dirty(prev);
>                 }
>         } else {
> diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/k=
ernel_mode_vector.c
> index 99972a48e86b..21127b33fea8 100644
> --- a/arch/riscv/kernel/kernel_mode_vector.c
> +++ b/arch/riscv/kernel/kernel_mode_vector.c
> @@ -123,7 +123,7 @@ static int riscv_v_stop_kernel_context(void)
>
>  static int riscv_v_start_kernel_context(bool *is_nested)
>  {
> -       struct __riscv_v_ext_state *kvstate, *uvstate;
> +       struct __riscv_v_ext_state *kvstate;
>
>         kvstate =3D &current->thread.kernel_vstate;
>         if (!kvstate->datap)
> @@ -134,20 +134,35 @@ static int riscv_v_start_kernel_context(bool *is_ne=
sted)
>                 *is_nested =3D true;
>                 get_cpu_vector_context();
>                 if (riscv_preempt_v_dirty(current)) {
> +                       riscv_v_enable();
>                         __riscv_v_vstate_save(kvstate, kvstate->datap);
> +                       riscv_v_disable();
>                         riscv_preempt_v_clear_dirty(current);
>                 }
>                 riscv_preempt_v_set_restore(current);
>                 return 0;
>         }
>
> -       /* Transfer the ownership of V from user to kernel, then save */
> -       riscv_v_start(RISCV_PREEMPT_V | RISCV_PREEMPT_V_DIRTY);
> +       /*
> +        * Skip saving user's context if it is not DIRTY. We would have t=
o start KMV in "dirty" if
> +        * this check is performed after KMV starts, to protect user's ct=
x. Then, we could waste
> +        * time saving already "clean" context once KMV is started in "di=
rty".
> +        */
>         if (__riscv_v_vstate_check(task_pt_regs(current)->status, DIRTY))=
 {
> -               uvstate =3D &current->thread.vstate;
> -               __riscv_v_vstate_save(uvstate, uvstate->datap);
> +               /* Transfer the ownership of V from user to kernel, then =
save */
> +               riscv_v_start(RISCV_PREEMPT_V | RISCV_PREEMPT_V_DIRTY);
> +               /*
> +                * Calling the guarded version of vstate_save to make the=
 code cleaner. Also, the
> +                * vstate check within the call is necessary as context s=
witch may happen between
> +                * __riscv_v_vstate_check and riscv_v_start. In such case=
 we are not supposed to
> +                * save the context again.
> +                */
> +               riscv_v_vstate_save(&current->thread.vstate, task_pt_regs=
(current));
> +               riscv_preempt_v_clear_dirty(current);
> +               return 0;
>         }
> -       riscv_preempt_v_clear_dirty(current);
> +
> +       riscv_v_start(RISCV_PREEMPT_V);
>         return 0;
>  }
>
> @@ -180,7 +195,9 @@ asmlinkage void riscv_v_context_nesting_end(struct pt=
_regs *regs)
>         depth =3D riscv_v_ctx_get_depth();
>         if (depth =3D=3D 0) {
>                 if (riscv_preempt_v_restore(current)) {
> +                       riscv_v_enable();
>                         __riscv_v_vstate_restore(vstate, vstate->datap);
> +                       riscv_v_disable();
>                         __riscv_v_vstate_clean(regs);
>                         riscv_preempt_v_reset_flags();
>                 }
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 62d2fb77bb9b..da6c6db846c1 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -46,7 +46,7 @@ void kvm_riscv_vcpu_guest_vector_save(struct kvm_cpu_co=
ntext *cntx,
>  {
>         if ((cntx->sstatus & SR_VS) =3D=3D SR_VS_DIRTY) {
>                 if (riscv_isa_extension_available(isa, v))
> -                       __kvm_riscv_vector_save(cntx);
> +                       kvm_riscv_vector_save(cntx);
>                 kvm_riscv_vcpu_vector_clean(cntx);
>         }
>  }
> @@ -56,7 +56,7 @@ void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cpu=
_context *cntx,
>  {
>         if ((cntx->sstatus & SR_VS) !=3D SR_VS_OFF) {
>                 if (riscv_isa_extension_available(isa, v))
> -                       __kvm_riscv_vector_restore(cntx);
> +                       kvm_riscv_vector_restore(cntx);
>                 kvm_riscv_vcpu_vector_clean(cntx);
>         }
>  }
> @@ -65,13 +65,13 @@ void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_c=
ontext *cntx)
>  {
>         /* No need to check host sstatus as it can be modified outside */
>         if (!kvm_riscv_isa_check_host(V))
> -               __kvm_riscv_vector_save(cntx);
> +               kvm_riscv_vector_save(cntx);
>  }
>
>  void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx)
>  {
>         if (!kvm_riscv_isa_check_host(V))
> -               __kvm_riscv_vector_restore(cntx);
> +               kvm_riscv_vector_restore(cntx);
>  }
>
>  int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
> --
> 2.43.0
>
