Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF973B42F7
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785218873; cv=pass; b=rytxDiggYAmdyGnoke28jkhuu+Sm7KyZ+ZgIvINAZCp531rBH5KNIkt81v4pg8zRA8T1AmBgKwibklgxOUqL3VmR+35r3i7IX3i7vySaEMrgf/+zPLT9MuBWafnwshkenj0Zgy6kTtOm/njfHrEBsQ5YR5n/sm446jQx3YTxifA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785218873; c=relaxed/simple;
	bh=MgO4M2HsynesaOczMvdKmTjwsq9luQN6S2fU/3HE7OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWUQJ+Rdwdmh9U24aXyIQjTKzkTW7vWmmZQVKAkhse71vt3+my7QVuzwQIV/fASpm+/PSzWqSUlsTju/7CHk2mF/e/kC+xDHZR/UfvvfMe1BvUtBSeA2Je5Ea7R6QnWo5xY9UVmqFvxK5e3NR0Mi0dds6C6rJrV/4T9WKtSlr1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ib0Thu7c; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ib0Thu7c"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-74d55dac06eso1628156137.3
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 23:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785218870; cv=none;
        d=google.com; s=arc-20260327;
        b=nrP5kP/fXQWWXlEUMZfUznlr1UVKodbNdtclsYeFLPp45Q3uOOYsmWI2J7m1M26vTE
         hMvw/uEDQIOk1ua92QqSA97eLliUava4iCxnTJFEoLURKy4j+u6WkHOThaECWGtzCe15
         7aZEJh/PmN02mj4O0BkitkX/1Nsir+hrfeYyZTo9PHQyobY00Cd9PYW9Btl+5MnaA7VT
         OyqAGeIA+pzXBO/yQSem+hPC2twu1cPFOlGGoXdlU5sW6ZLyqg1+6juia0L0BR8GXCOz
         elR9c3G+vBrBmQqk3E7PEi6Z0ZXpmaFEAlKZSfZCVH8Wp9gMzluu+tdTWOPXYFnZVXyZ
         /kfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2a7vMWUWw/2F6ohDaWT0tDr4YJsgL1Cve7Hk+s/k6RM=;
        fh=rcwKmcHZy76DvVQG1we5g3fPfkcPMC3HayFat4mka1M=;
        b=hTIG3EJA2KAplk5mOoorc7U0AAUguTSE+FoysgrL+TmdryxnC2sNMinwSd3xVitYrX
         3C0lLI3EWH5heOA6hOyDPhllSDcfY8jG7hO/kkvm9+i2UBM9otLTzozXyA5+t53ZjriR
         Xte3ynLnqdL38wzBn+LtpUo35i/73/D/DJUNjr/IH8gQrf/Ed8jF4S99Zwtzt6Wib8YR
         OARE3S+KpbLO2hwipbslgr9/frYOT+Do3b8SwAyRjJtmGAv43jgJtDPst82v60L2SEAs
         Ob2EUQzYIzxOx7LBd/ydet4DsM/BgHdkceabtYx1luQboZYP1bBrH9Gs7448alMUddav
         mlBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1785218870; x=1785823670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2a7vMWUWw/2F6ohDaWT0tDr4YJsgL1Cve7Hk+s/k6RM=;
        b=ib0Thu7cbnHiO+2BJoErf1Qbv47/Co0YMgK8OCCr7F82AsLTkZHNJHBCpLHGm56oMK
         /KXCMhItoqYGkh1QK3hfHTjDgRk+3eJUQH85xm7vbSTFSlAOJErarBUqKI49JBGJko5A
         7oM7OPHl65mWbWqlfE9R4MoKD2q4HnlUX0VMBIxUI1PE1dCeUzWioHKCY6a+o0v/rqU1
         t4ZVRjlm1eTc5F01W5EPs2BHkgRUzVs0OUfXvb75aeR5vd199Pn7GPB4e6T3uuuzwnOc
         PmXxmmB0iJmGvU8rVf9IZHCJ5D+z5LKseubmP8L3G4WeAZZragujclfMbteCemBbD5XP
         yZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785218870; x=1785823670;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2a7vMWUWw/2F6ohDaWT0tDr4YJsgL1Cve7Hk+s/k6RM=;
        b=iQ9NNwmtmS99ezEm+r/7WLtvPwKvkJPXCJmAMfeFuNdbJpEMTC9V5yAWivrvVmfed5
         f32GmRTWBWgBgjTEzX3pTyD394geUpMI6HZ/LFa0OXbpO9CPt7hRRc4POJmAaCl5QWoD
         LEJVH87PMWzjbcI5py6sr0Lgo+o/dm/mqqEzbu/yPM41NZv6YTlNTR+THUixqFGetppd
         W3Oo1ycbmvRBT88FQoMy/kgjqCoHsm988/lPm3oQ7mstjozTJbKbrJaLzP86r7asfNBD
         mBuBCahuQ5FoYGCUtPepCw7d/rLSVjFsXrNCFqH3kgqxQFf/EVxbS3GndU4sglOooVfu
         EW/w==
X-Forwarded-Encrypted: i=1; AHgh+Rr6GQCJ4uhSw0vLZ/M9PrSvHnPdMr+rpMIia6ViNLJIpz0NyqmkZwPF8GXv64OTY33+6GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNaqyRppboyYOuFtwv4txQoUI3df89pg4IpfHCH67jhDv8UIjT
	vwqAdMlTUiY3mgNs8ZPkDSdJfV90Buoo858CTKNaMMdD9dIdZ92ka0oEzyDh67nBwj9P258MjoL
	ET2ii34jMng9qeMSUUdjnZ6l9JFtUtwD0UHi426svtw==
X-Gm-Gg: AR+sD13UP+g42SDabNAuKmkhTf4jmS7/Fs4hvMUHNdMMtF4oOLQIDaBXxe5DE7XsgdI
	wTfWZfchftmI/SxJt1uI/JCa5/X4/reiyfsvgRmU6WNInOFmG4uqCpLlLEiKiWTnSrNzOR7GqVM
	VFGwFW2naA5XdvDC4dfZW5yDGo1KwcznAoBMq/lxwnYeGpjiDTQz1w2Lx8ACNprjS+0ewcfqfkl
	2zksJ5EJf1ybPPObLMzDd1+rXj/aPUIG93aECgPjArQsxpytq6WoWjCO4owKTXJzL35oA2BS9w=
X-Received: by 2002:a05:6102:4427:b0:744:dd70:a364 with SMTP id
 ada2fe7eead31-7549fd6e3d3mr465958137.9.1785218869833; Mon, 27 Jul 2026
 23:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725001749.2579274-1-tchiu@tenstorrent.com> <20260725001749.2579274-4-tchiu@tenstorrent.com>
In-Reply-To: <20260725001749.2579274-4-tchiu@tenstorrent.com>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Tue, 28 Jul 2026 14:07:37 +0800
X-Gm-Features: AUfX_mw_62-4lK2BZBvaae4kegf7-p9VbNGQFGBZwtylrrbgR8x34n4t0vYS8hc
Message-ID: <CAMWQL2jkVDVBw=_pecSR42RjooLoPevPP5ZEzwyz_m9YBc_PTQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] RISC-V: KVM: fix vcpu vector context handling for
 kernel-mode vector
To: Andy Chiu <tchiu@tenstorrent.com>
Cc: anup@brainfault.org, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Vincent Chen <vincent.chen@sifive.com>, 
	Eric Biggers <ebiggers@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Andy Chiu <andybnac@gmail.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, dfustini@oss.tenstorrent.com, 
	Sean Chang <seanwascoding@gmail.com>, Zong Li <zong.li@sifive.com>, 
	Deepak Gupta <debug@rivosinc.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 8:18=E2=80=AFAM Andy Chiu <tchiu@tenstorrent.com> w=
rote:
>
> Running vector workloads like perf + mcf on KVM can result in an
> unexpected termination due to a vtype corruption. This happens because
> the kernel-mode vector (KMV) misattributes the guest's vcpu context as
> the user's context and source from a wrong status.VS.
>
> The simplified call chain that results in this problem is shown as
> follow:
>
> __riscv_sys_ioctl()
>     kvm_arch_vcpu_ioctl_run()
>       kvm_riscv_vcpu_exit()
>         kvm_riscv_vcpu_sbi_ecall()
>           kvm_riscv_vcpu_pmu_ctr_stop()
>             kvm_vcpu_write_guest()
>               __copy_to_user()
>                 enter_vector_usercopy()
>                   kernel_vector_begin()
>
> kernel_vector_begin() should use the sstatus.VS from guest's vcpu
> context instead of task_pt_reg(current). Also, it should not save
> guest's v-reg into the user's context memory.
>
> To resolve this, the vcpu context must be correctly saved when KMV is
> serving a guest. However, invoking KVM functions directly from generic
> RISC-V architecture code introduces a reverse dependency, breaking
> builds when KVM is configured as N or M.
>
> Address this by registering an RCU-protected callback for context
> flushing. KVM registers this callback at module initialization and
> unregisters it on exit. When KMV starts a kernel context, it can now
> safely flush the vector context via the callback.
>
> Fixes: ecd2ada8a5e0 ("riscv: Add support for kernel mode vector")
> Signed-off-by: Andy Chiu <tchiu@tenstorrent.com>
Reviewed-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

Thank you!
Yong-Xuan


>
> ---
> Changelog v3:
>  - clears RISCV_V_VCPU_NEED_RESTORE flag in host restore to prevent
>    leaking (Sashiko)
>  - consolidates guest vector restore at returning to guest to prevent
>    unnecessary save/restore between the preemptible window from
>    vcpu_load to vcpu_enter_exit
>  - Document the added riscv_v_flags
> Changelog v2: address concerns pointed out by sashiko
>  - encloses vcpu_flush_v_callback() with rcu_read_{lock,unlock}
>  - put riscv_v_start before put_cpu_vector_context() to prevent
>    redundant context save
>  - protect v context operations against softirqs
>  - apply bitmask when reading SR_VS out of guest's sstatus
> ---
>  arch/riscv/include/asm/kvm_vcpu_vector.h | 24 +++++++++++
>  arch/riscv/include/asm/processor.h       |  8 ++++
>  arch/riscv/include/asm/vector.h          |  5 +++
>  arch/riscv/kernel/kernel_mode_vector.c   | 51 ++++++++++++++++++------
>  arch/riscv/kvm/main.c                    |  4 ++
>  arch/riscv/kvm/vcpu.c                    | 12 ++++++
>  arch/riscv/kvm/vcpu_vector.c             | 22 +++++++++-
>  7 files changed, 112 insertions(+), 14 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/includ=
e/asm/kvm_vcpu_vector.h
> index 57a798a4cb0d..6371d5ea5392 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_vector.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
> @@ -35,6 +35,22 @@ void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_co=
ntext *cntx);
>  void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx);
>  int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu);
>  void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *vcpu);
> +void kvm_riscv_register_vctx_callback(void (*func)(void));
> +void kvm_riscv_unregister_vctx_callback(void);
> +void kvm_riscv_vcpu_flush_vector(void);
> +
> +static inline void kvm_riscv_v_init(void)
> +{
> +       if (has_vector())
> +               kvm_riscv_register_vctx_callback(&kvm_riscv_vcpu_flush_ve=
ctor);
> +}
> +
> +static inline void kvm_riscv_v_exit(void)
> +{
> +       if (has_vector())
> +               kvm_riscv_unregister_vctx_callback();
> +}
> +
>  #else
>
>  struct kvm_cpu_context;
> @@ -69,6 +85,14 @@ static inline int kvm_riscv_vcpu_alloc_vector_context(=
struct kvm_vcpu *vcpu)
>  static inline void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *v=
cpu)
>  {
>  }
> +
> +static inline void kvm_riscv_v_init(void)
> +{
> +}
> +
> +static inline void kvm_riscv_v_exit(void)
> +{
> +}
>  #endif
>
>  int kvm_riscv_vcpu_get_reg_vector(struct kvm_vcpu *vcpu,
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index 812517b2cec1..a6a0c3d5a913 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -67,6 +67,12 @@ struct pt_regs;
>   *  - bit 0: indicates whether the in-kernel Vector context is active. T=
he
>   *    activation of this state disables the preemption. On a non-RT kern=
el, it
>   *    also disable bh.
> + *  - bit 1: tells kvm that the vcpu process has guest context saved in =
vcpu's
> + *    context memory and need to be restore upon returing back to the gu=
est.
> + *  - bit 2: represents that the vector context has now loaded and belon=
gs to
> + *    the guest kernel. Any non-scheduler context saving routing needs t=
o save
> + *    the register file to vcpu's context memory. The bit is set upon re=
turing
> + *    back to the guest and cleared after loading the host's vector cont=
ext.
>   *  - bits 8: is used for tracking preemptible kernel-mode Vector, when
>   *    RISCV_ISA_V_PREEMPTIVE is enabled. Calling kernel_vector_begin() d=
oes not
>   *    disable the preemption if the thread's kernel_vstate.datap is allo=
cated.
> @@ -97,6 +103,8 @@ struct pt_regs;
>
>  #define RISCV_V_CTX_UNIT_DEPTH         0x00010000
>  #define RISCV_KERNEL_MODE_V            0x00000001
> +#define RISCV_V_VCPU_NEED_RESTORE      0x00000002
> +#define RISCV_V_VCPU_CTX               0x00000004
>  #define RISCV_PREEMPT_V                        0x00000100
>  #define RISCV_PREEMPT_V_DIRTY          0x80000000
>  #define RISCV_PREEMPT_V_NEED_RESTORE   0x40000000
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vec=
tor.h
> index 00cb9c0982b1..fffe72a77208 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -58,6 +58,11 @@ static inline u32 riscv_v_flags(void)
>         return READ_ONCE(current->thread.riscv_v_flags);
>  }
>
> +static inline void riscv_v_flags_set(u32 flags)
> +{
> +       WRITE_ONCE(current->thread.riscv_v_flags, flags);
> +}
> +
>  static __always_inline bool has_vector(void)
>  {
>         return riscv_has_extension_unlikely(RISCV_ISA_EXT_ZVE32X);
> diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/k=
ernel_mode_vector.c
> index 965c8edbe984..da6ebc4dffdb 100644
> --- a/arch/riscv/kernel/kernel_mode_vector.c
> +++ b/arch/riscv/kernel/kernel_mode_vector.c
> @@ -13,16 +13,31 @@
>  #include <linux/kvm_types.h>
>
>  #include <asm/vector.h>
> +#include <asm/kvm_vcpu_vector.h>
>  #include <asm/switch_to.h>
>  #include <asm/simd.h>
>  #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
>  #include <asm/asm-prototypes.h>
>  #endif
>
> -static inline void riscv_v_flags_set(u32 flags)
> +static void (* __rcu kvm_flush_vector_ctx_callback)(void);
> +
> +void kvm_riscv_register_vctx_callback(void (*func)(void))
>  {
> -       WRITE_ONCE(current->thread.riscv_v_flags, flags);
> +       if (WARN_ON_ONCE(rcu_access_pointer(kvm_flush_vector_ctx_callback=
)))
> +               return;
> +
> +       rcu_assign_pointer(kvm_flush_vector_ctx_callback, func);
>  }
> +EXPORT_SYMBOL_GPL(kvm_riscv_register_vctx_callback);
> +
> +void kvm_riscv_unregister_vctx_callback(void)
> +{
> +       rcu_assign_pointer(kvm_flush_vector_ctx_callback, NULL);
> +       synchronize_rcu();
> +}
> +EXPORT_SYMBOL_GPL(kvm_riscv_unregister_vctx_callback);
> +
>
>  static inline void riscv_v_start(u32 flags)
>  {
> @@ -87,6 +102,22 @@ void put_cpu_vector_context(void)
>  }
>  EXPORT_SYMBOL_FOR_KVM(put_cpu_vector_context);
>
> +static void __riscv_flush_vector_context(void)
> +{
> +       void (*vcpu_flush_v_callback)(void);
> +
> +       if (riscv_v_flags() & RISCV_V_VCPU_CTX) {
> +               rcu_read_lock();
> +               vcpu_flush_v_callback =3D rcu_dereference(kvm_flush_vecto=
r_ctx_callback);
> +               vcpu_flush_v_callback();
> +               rcu_read_unlock();
> +               return;
> +       }
> +
> +       riscv_v_vstate_save(&current->thread.vstate, task_pt_regs(current=
));
> +       riscv_v_vstate_set_restore(current, task_pt_regs(current));
> +}
> +
>  #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
>  static __always_inline u32 *riscv_v_flags_ptr(void)
>  {
> @@ -130,7 +161,7 @@ static int riscv_v_stop_kernel_context(void)
>
>  static int riscv_v_start_kernel_context(void)
>  {
> -       struct __riscv_v_ext_state *kvstate, *uvstate;
> +       struct __riscv_v_ext_state *kvstate;
>
>         kvstate =3D &current->thread.kernel_vstate;
>         if (!kvstate->datap)
> @@ -148,13 +179,10 @@ static int riscv_v_start_kernel_context(void)
>         }
>
>         /* Transfer the ownership of V from user to kernel, then save */
> -       riscv_v_start(RISCV_PREEMPT_V | RISCV_PREEMPT_V_DIRTY);
> -       if (__riscv_v_vstate_check(task_pt_regs(current)->status, DIRTY))=
 {
> -               uvstate =3D &current->thread.vstate;
> -               __riscv_v_vstate_save(uvstate, uvstate->datap);
> -       }
> -       riscv_preempt_v_clear_dirty(current);
> -       riscv_v_vstate_set_restore(current, task_pt_regs(current));
> +       get_cpu_vector_context();
> +       __riscv_flush_vector_context();
> +       riscv_v_start(RISCV_PREEMPT_V);
> +       put_cpu_vector_context();
>         return 0;
>  }
>
> @@ -220,8 +248,7 @@ void kernel_vector_begin(void)
>
>         if (riscv_v_start_kernel_context()) {
>                 get_cpu_vector_context();
> -               riscv_v_vstate_save(&current->thread.vstate, task_pt_regs=
(current));
> -               riscv_v_vstate_set_restore(current, task_pt_regs(current)=
);
> +               __riscv_flush_vector_context();
>         }
>
>         riscv_v_enable();
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 0924c75100a2..da8a5f6d4b4d 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -14,6 +14,7 @@
>  #include <asm/kvm_mmu.h>
>  #include <asm/kvm_nacl.h>
>  #include <asm/sbi.h>
> +#include <asm/kvm_vcpu_vector.h>
>
>  DEFINE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
>
> @@ -76,6 +77,7 @@ static void kvm_riscv_teardown(void)
>  {
>         kvm_riscv_aia_exit();
>         kvm_riscv_nacl_exit();
> +       kvm_riscv_v_exit();
>         kvm_unregister_perf_callbacks();
>  }
>
> @@ -170,6 +172,8 @@ static int __init riscv_kvm_init(void)
>
>         kvm_riscv_setup_vendor_features();
>
> +       kvm_riscv_v_init();
> +
>         kvm_register_perf_callbacks();
>
>         rc =3D kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index cf6e231e76e2..e2651808e1d3 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -603,9 +603,11 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int c=
pu)
>         kvm_riscv_vcpu_host_fp_save(&vcpu->arch.host_context);
>         kvm_riscv_vcpu_guest_fp_restore(&vcpu->arch.guest_context,
>                                         vcpu->arch.isa);
> +       get_cpu_vector_context();
>         kvm_riscv_vcpu_host_vector_save(&vcpu->arch.host_context);
>         kvm_riscv_vcpu_guest_vector_restore(&vcpu->arch.guest_context,
>                                             vcpu->arch.isa);
> +       put_cpu_vector_context();
>
>         kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
>
> @@ -626,9 +628,11 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>         kvm_riscv_vcpu_host_fp_restore(&vcpu->arch.host_context);
>
>         kvm_riscv_vcpu_timer_save(vcpu);
> +       get_cpu_vector_context();
>         kvm_riscv_vcpu_guest_vector_save(&vcpu->arch.guest_context,
>                                          vcpu->arch.isa);
>         kvm_riscv_vcpu_host_vector_restore(&vcpu->arch.host_context);
> +       put_cpu_vector_context();
>
>         if (kvm_riscv_nacl_available()) {
>                 nsh =3D nacl_shmem();
> @@ -765,6 +769,14 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct=
 kvm_vcpu *vcpu,
>         kvm_riscv_vcpu_swap_in_guest_state(vcpu);
>         guest_state_enter_irqoff();
>
> +       /* sstatus.VS !=3D SR_VS_OFF is guaranteed when NEED_RESTORE is s=
et */
> +       if (current->thread.riscv_v_flags & RISCV_V_VCPU_NEED_RESTORE) {
> +               current->thread.riscv_v_flags &=3D ~RISCV_V_VCPU_NEED_RES=
TORE;
> +               current->thread.riscv_v_flags |=3D RISCV_V_VCPU_CTX;
> +               __kvm_riscv_vector_restore(gcntx);
> +               gcntx->sstatus =3D (gcntx->sstatus & ~SR_VS) | SR_VS_CLEA=
N;
> +       }
> +
>         if (kvm_riscv_nacl_sync_sret_available()) {
>                 nsh =3D nacl_shmem();
>
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 62d2fb77bb9b..ef2eee6ec308 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -56,8 +56,7 @@ void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cpu=
_context *cntx,
>  {
>         if ((cntx->sstatus & SR_VS) !=3D SR_VS_OFF) {
>                 if (riscv_isa_extension_available(isa, v))
> -                       __kvm_riscv_vector_restore(cntx);
> -               kvm_riscv_vcpu_vector_clean(cntx);
> +                       riscv_v_flags_set(riscv_v_flags() | RISCV_V_VCPU_=
NEED_RESTORE);
>         }
>  }
>
> @@ -72,6 +71,7 @@ void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_=
context *cntx)
>  {
>         if (!kvm_riscv_isa_check_host(V))
>                 __kvm_riscv_vector_restore(cntx);
> +       riscv_v_flags_set(riscv_v_flags() & ~(RISCV_V_VCPU_CTX | RISCV_V_=
VCPU_NEED_RESTORE));
>  }
>
>  int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
> @@ -95,6 +95,24 @@ void kvm_riscv_vcpu_free_vector_context(struct kvm_vcp=
u *vcpu)
>         kfree(vcpu->arch.guest_context.vector.datap);
>         kfree(vcpu->arch.host_context.vector.datap);
>  }
> +
> +void kvm_riscv_vcpu_flush_vector(void)
> +{
> +       struct kvm_vcpu *vcpu =3D *this_cpu_ptr(kvm_get_running_vcpus());
> +
> +       /*
> +        * Only reached from __riscv_flush_vector_context() when RISCV_V_=
VCPU_CTX is set, which
> +        * always have kvm_get_running_vcpus non-NULL.
> +        */
> +       if (WARN_ON_ONCE(!vcpu))
> +               return;
> +
> +       kvm_riscv_vcpu_guest_vector_save(&vcpu->arch.guest_context, vcpu-=
>arch.isa);
> +
> +       if ((vcpu->arch.guest_context.sstatus & SR_VS) !=3D SR_VS_OFF)
> +               riscv_v_flags_set(riscv_v_flags() | RISCV_V_VCPU_NEED_RES=
TORE);
> +}
> +
>  #endif
>
>  static int kvm_riscv_vcpu_vreg_addr(struct kvm_vcpu *vcpu,
> --
> 2.43.0
>
