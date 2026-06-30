Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C343B71D7
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 04:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793656; cv=none; b=LFWM/ybqZsfonijIBOqYMhLoYRyHVUS4BOsg8mMJuBjoGpNvNptA76BlSLqDlUvEviNM7ialOuVoVXeeqVqmWGuCVpR4ZK9YZhiT67ntqHRHhlwNKHu+CuJT06Zy6dGW/Mg8OF29wTi/JY+gTgga4+KH2qz4tcqxilW2SqirsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793656; c=relaxed/simple;
	bh=UYzJbObuxMCTJLvc6ROVC19Ddwad4MHiUWNs/FLSck4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSHN8rLIbVcSvq8ZIOhL5AwYgkBYCmgovX43oF/9/qMCzE2hH0JHQxMzDKt2nUq9BMv8qqOVXIKIoVCiA4E0psziMItXaPeopaCVaWry/GkkfSalTxRmFUAG51h5yPpwBO3CRz4/gs7bGhoY38/oNO6ujXA2mDB7heq7DHmSYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=islY7ez5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="islY7ez5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B395D1F000E9
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 04:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782793652;
	bh=GyJZZiADxFDgtejPe6CZLylJN/kIfStCGXrgblz45RY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=islY7ez5TznRi0C1iLek4N2X7TvVISCI4ouIUkurnDuH+ALx9gBG3/qSqcVS92eMH
	 mLyLLulAiiUQVFFjNhSrhFzd5bhlt/7fNN7xQEfgHuQ8CxS/2+rLreI6CHZwo4ECTx
	 4nMh99WMcz57GTlcMeRMRm2jTS0/faCimTHbRbgvezZWtT8V4tDMkYKVUQ5c6Q5Ncz
	 K2Pl1RyCDtdbi72++Z5QpWLEbgpE0/I68zcIQzmhJcfiNgl75RaO6O8gbLyFDaTsk8
	 0cwh0BuJOuylzoVKYrGLEj4sbNYA1HABSjjmD1jjo7ZtzPstNqXS51SKrNSOLgKFKj
	 Jpq6QC4XK8RNQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69857dc1d5eso3683631a12.3
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 21:27:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YzPphNzw0yRhefZhNCiiP+JLkpbCW2f/XSRyLGSuuvwvQO4yaG4
	mWYR+SH0HomiTkOAiBN680Cbtj3e0tngKR4zk7C/3R/1besxbNeIR3/ubyAx9+SjG5pIAak+IlB
	Pxe7WkirM5jgApXBVY2NZTnqLskhGK5A=
X-Received: by 2002:a05:6402:4415:b0:698:3b7c:3b33 with SMTP id
 4fb4d7f45d1cf-69879e4bb30mr737165a12.31.1782793651295; Mon, 29 Jun 2026
 21:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629023213.597030-1-maobibo@loongson.cn> <20260629023213.597030-3-maobibo@loongson.cn>
In-Reply-To: <20260629023213.597030-3-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 30 Jun 2026 12:27:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7OHMnugy2bT85jTHkW=NBchSCzuKywKMkq4-mdK07rKg@mail.gmail.com>
X-Gm-Features: AVVi8CewrltEH45AJ4erezyHGZzpSd0R16uQczvhMYBGa9OC7JJ-SFUg_g84SPM
Message-ID: <CAAhV-H7OHMnugy2bT85jTHkW=NBchSCzuKywKMkq4-mdK07rKg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] LoongArch: KVM: Replace kvm_err() with WARN_ONCE()
To: Bibo Mao <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Mon, Jun 29, 2026 at 10:32=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> Since guest kernel and ioctl parameter from user mode is untrusted,
> there may be noise kernel log output in host hypervisor with abnormal
> state. Here replace kvm_err() with WARN_ONCE() to reduce this kind
> of noise kernel log, and there is no function change.
Maybe kvm_pr_unimpl() is a little better than WARN_ONCE()? At least it
is a KVM API.

Huacai
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/kvm/exit.c         | 15 +++++++--------
>  arch/loongarch/kvm/intc/dmsintc.c |  8 ++++----
>  arch/loongarch/kvm/intc/eiointc.c | 18 ++++++++---------
>  arch/loongarch/kvm/intc/ipi.c     | 32 +++++++++++++++----------------
>  arch/loongarch/kvm/intc/pch_pic.c | 12 ++++++------
>  arch/loongarch/kvm/vcpu.c         |  2 +-
>  6 files changed, 43 insertions(+), 44 deletions(-)
>
> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
> index 8572b63478bb..4ad006e27a4d 100644
> --- a/arch/loongarch/kvm/exit.c
> +++ b/arch/loongarch/kvm/exit.c
> @@ -252,7 +252,7 @@ int kvm_complete_iocsr_read(struct kvm_vcpu *vcpu, st=
ruct kvm_run *run)
>                 *gpr =3D *(s64 *)run->iocsr_io.data;
>                 break;
>         default:
> -               kvm_err("Bad IOCSR length: %d, addr is 0x%lx\n",
> +               WARN_ONCE(1, "Bad IOCSR length: %d, addr is 0x%lx\n",
>                                 run->iocsr_io.len, vcpu->arch.badv);
>                 er =3D EMULATE_FAIL;
>                 break;
> @@ -326,7 +326,7 @@ static int kvm_trap_handle_gspr(struct kvm_vcpu *vcpu=
)
>
>         /* Rollback PC only if emulation was unsuccessful */
>         if (er =3D=3D EMULATE_FAIL) {
> -               kvm_err("[%#lx]%s: unsupported gspr instruction 0x%08x\n"=
,
> +               WARN_ONCE(1, "[%#lx]%s: unsupported gspr instruction 0x%0=
8x\n",
>                         curr_pc, __func__, inst.word);
>
>                 kvm_arch_vcpu_dump_regs(vcpu);
> @@ -491,7 +491,7 @@ int kvm_emu_mmio_read(struct kvm_vcpu *vcpu, larch_in=
st inst)
>                 return EMULATE_DO_MMIO;
>         }
>
> -       kvm_err("Read not supported Inst=3D0x%08x @%lx BadVaddr:%#lx\n",
> +       WARN_ONCE(1, "Read not supported Inst=3D0x%08x @%lx BadVaddr:%#lx=
\n",
>                         inst.word, vcpu->arch.pc, vcpu->arch.badv);
>         kvm_arch_vcpu_dump_regs(vcpu);
>         vcpu->mmio_needed =3D 0;
> @@ -529,7 +529,7 @@ int kvm_complete_mmio_read(struct kvm_vcpu *vcpu, str=
uct kvm_run *run)
>                 *gpr =3D *(s64 *)run->mmio.data;
>                 break;
>         default:
> -               kvm_err("Bad MMIO length: %d, addr is 0x%lx\n",
> +               WARN_ONCE(1, "Bad MMIO length: %d, addr is 0x%lx\n",
>                                 run->mmio.len, vcpu->arch.badv);
>                 er =3D EMULATE_FAIL;
>                 break;
> @@ -656,7 +656,7 @@ int kvm_emu_mmio_write(struct kvm_vcpu *vcpu, larch_i=
nst inst)
>         }
>
>         vcpu->arch.pc =3D curr_pc;
> -       kvm_err("Write not supported Inst=3D0x%08x @%lx BadVaddr:%#lx\n",
> +       WARN_ONCE(1, "Write not supported Inst=3D0x%08x @%lx BadVaddr:%#l=
x\n",
>                         inst.word, vcpu->arch.pc, vcpu->arch.badv);
>         kvm_arch_vcpu_dump_regs(vcpu);
>         /* Rollback PC if emulation was unsuccessful */
> @@ -748,8 +748,7 @@ static int kvm_handle_fpu_disabled(struct kvm_vcpu *v=
cpu, int ecode)
>          * treated as a reserved instruction!
>          * If FPU already in use, we shouldn't get this at all.
>          */
> -       if (WARN_ON(vcpu->arch.aux_inuse & KVM_LARCH_FPU)) {
> -               kvm_err("%s internal error\n", __func__);
> +       if (WARN_ON_ONCE(vcpu->arch.aux_inuse & KVM_LARCH_FPU)) {
>                 run->exit_reason =3D KVM_EXIT_INTERNAL_ERROR;
>                 return RESUME_HOST;
>         }
> @@ -943,7 +942,7 @@ static int kvm_fault_ni(struct kvm_vcpu *vcpu, int ec=
ode)
>         /* Fetch the instruction */
>         inst =3D vcpu->arch.badi;
>         badv =3D vcpu->arch.badv;
> -       kvm_err("ECode: %d PC=3D%#lx Inst=3D0x%08x BadVaddr=3D%#lx ESTAT=
=3D%#lx\n",
> +       WARN_ONCE(1, "ECode: %d PC=3D%#lx Inst=3D0x%08x BadVaddr=3D%#lx E=
STAT=3D%#lx\n",
>                         ecode, vcpu->arch.pc, inst, badv, read_gcsr_estat=
());
>         kvm_arch_vcpu_dump_regs(vcpu);
>         kvm_queue_exception(vcpu, EXCCODE_INE, 0);
> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/=
dmsintc.c
> index de25735ce039..708abbcd55bf 100644
> --- a/arch/loongarch/kvm/intc/dmsintc.c
> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> @@ -114,7 +114,7 @@ static int kvm_dmsintc_ctrl_access(struct kvm_device =
*dev,
>                 }
>                 break;
>         default:
> -               kvm_err("%s: unknown dmsintc register, addr =3D %d\n", __=
func__, addr);
> +               WARN_ONCE(1, "%s: unknown dmsintc register, addr =3D %d\n=
", __func__, addr);
>                 return -ENXIO;
>         }
>
> @@ -128,7 +128,7 @@ static int kvm_dmsintc_set_attr(struct kvm_device *de=
v,
>         case KVM_DEV_LOONGARCH_DMSINTC_GRP_CTRL:
>                 return kvm_dmsintc_ctrl_access(dev, attr, true);
>         default:
> -               kvm_err("%s: unknown group (%d)\n", __func__, attr->group=
);
> +               WARN_ONCE(1, "%s: unknown group (%d)\n", __func__, attr->=
group);
>                 return -EINVAL;
>         }
>  }
> @@ -139,13 +139,13 @@ static int kvm_dmsintc_create(struct kvm_device *de=
v, u32 type)
>         struct loongarch_dmsintc *s;
>
>         if (!dev) {
> -               kvm_err("%s: kvm_device ptr is invalid!\n", __func__);
> +               WARN_ONCE(1, "%s: kvm_device ptr is invalid!\n", __func__=
);
>                 return -EINVAL;
>         }
>
>         kvm =3D dev->kvm;
>         if (kvm->arch.dmsintc) {
> -               kvm_err("%s: LoongArch DMSINTC has already been created!\=
n", __func__);
> +               WARN_ONCE(1, "%s: LoongArch DMSINTC has already been crea=
ted!\n", __func__);
>                 return -EINVAL;
>         }
>
> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/=
eiointc.c
> index 2b14485d14a7..555e55246f0c 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -47,7 +47,7 @@ static void eiointc_update_irq(struct loongarch_eiointc=
 *s, int irq, int level)
>         cpu =3D s->sw_coremap[irq];
>         vcpu =3D kvm_get_vcpu_by_id(s->kvm, cpu);
>         if (unlikely(vcpu =3D=3D NULL)) {
> -               kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
> +               WARN_ONCE(1, "%s: invalid target cpu: %d\n", __func__, cp=
u);
>                 return;
>         }
>
> @@ -165,12 +165,12 @@ static int kvm_eiointc_read(struct kvm_vcpu *vcpu,
>         struct loongarch_eiointc *eiointc =3D vcpu->kvm->arch.eiointc;
>
>         if (!eiointc) {
> -               kvm_err("%s: eiointc irqchip not valid!\n", __func__);
> +               WARN_ONCE(1, "%s: eiointc irqchip not valid!\n", __func__=
);
>                 return 0;
>         }
>
>         if (addr & (len - 1)) {
> -               kvm_err("%s: eiointc not aligned addr %llx len %d\n", __f=
unc__, addr, len);
> +               WARN_ONCE(1, "%s: eiointc not aligned addr %llx len %d\n"=
, __func__, addr, len);
>                 return 0;
>         }
>
> @@ -297,12 +297,12 @@ static int kvm_eiointc_write(struct kvm_vcpu *vcpu,
>         struct loongarch_eiointc *eiointc =3D vcpu->kvm->arch.eiointc;
>
>         if (!eiointc) {
> -               kvm_err("%s: eiointc irqchip not valid!\n", __func__);
> +               WARN_ONCE(1, "%s: eiointc irqchip not valid!\n", __func__=
);
>                 return 0;
>         }
>
>         if (addr & (len - 1)) {
> -               kvm_err("%s: eiointc not aligned addr %llx len %d\n", __f=
unc__, addr, len);
> +               WARN_ONCE(1, "%s: eiointc not aligned addr %llx len %d\n"=
, __func__, addr, len);
>                 return 0;
>         }
>
> @@ -345,7 +345,7 @@ static int kvm_eiointc_virt_read(struct kvm_vcpu *vcp=
u,
>         struct loongarch_eiointc *eiointc =3D vcpu->kvm->arch.eiointc;
>
>         if (!eiointc) {
> -               kvm_err("%s: eiointc irqchip not valid!\n", __func__);
> +               WARN_ONCE(1, "%s: eiointc irqchip not valid!\n", __func__=
);
>                 return 0;
>         }
>
> @@ -375,7 +375,7 @@ static int kvm_eiointc_virt_write(struct kvm_vcpu *vc=
pu,
>         struct loongarch_eiointc *eiointc =3D vcpu->kvm->arch.eiointc;
>
>         if (!eiointc) {
> -               kvm_err("%s: eiointc irqchip not valid!\n", __func__);
> +               WARN_ONCE(1, "%s: eiointc irqchip not valid!\n", __func__=
);
>                 return 0;
>         }
>
> @@ -502,7 +502,7 @@ static int kvm_eiointc_regs_access(struct kvm_device =
*dev,
>                 p =3D (void *)s->coremap + offset * 4;
>                 break;
>         default:
> -               kvm_err("%s: unknown eiointc register, addr =3D %d\n", __=
func__, addr);
> +               WARN_ONCE(1, "%s: unknown eiointc register, addr =3D %d\n=
", __func__, addr);
>                 return -EINVAL;
>         }
>
> @@ -546,7 +546,7 @@ static int kvm_eiointc_sw_status_access(struct kvm_de=
vice *dev,
>                 p =3D &s->status;
>                 break;
>         default:
> -               kvm_err("%s: unknown eiointc register, addr =3D %d\n", __=
func__, addr);
> +               WARN_ONCE(1, "%s: unknown eiointc register, addr =3D %d\n=
", __func__, addr);
>                 return -EINVAL;
>         }
>         spin_lock_irqsave(&s->lock, flags);
> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.=
c
> index d70bf415c7fc..8d9dacfc1b15 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c
> @@ -30,7 +30,7 @@ static void ipi_send(struct kvm *kvm, uint64_t data)
>         cpu =3D ((data & 0xffffffff) >> 16) & 0x3ff;
>         vcpu =3D kvm_get_vcpu_by_cpuid(kvm, cpu);
>         if (unlikely(vcpu =3D=3D NULL)) {
> -               kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
> +               WARN_ONCE(1, "%s: invalid target cpu: %d\n", __func__, cp=
u);
>                 return;
>         }
>
> @@ -105,7 +105,7 @@ static int mail_send(struct kvm *kvm, uint64_t data)
>         cpu =3D ((data & 0xffffffff) >> 16) & 0x3ff;
>         vcpu =3D kvm_get_vcpu_by_cpuid(kvm, cpu);
>         if (unlikely(vcpu =3D=3D NULL)) {
> -               kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
> +               WARN_ONCE(1, "%s: invalid target cpu: %d\n", __func__, cp=
u);
>                 return 0;
>         }
>         mailbox =3D ((data & 0xffffffff) >> 2) & 0x7;
> @@ -139,7 +139,7 @@ static int send_ipi_data(struct kvm_vcpu *vcpu, gpa_t=
 addr, uint64_t data)
>                 ret =3D kvm_io_bus_read(vcpu, KVM_IOCSR_BUS, addr, 4, &va=
l);
>                 srcu_read_unlock(&vcpu->kvm->srcu, idx);
>                 if (unlikely(ret)) {
> -                       kvm_err("%s: : read data from addr %llx failed\n"=
, __func__, addr);
> +                       WARN_ONCE(1, "%s: : read data from addr %llx fail=
ed\n", __func__, addr);
>                         return 0;
>                 }
>                 /* Construct the mask by scanning the bit 27-30 */
> @@ -155,7 +155,7 @@ static int send_ipi_data(struct kvm_vcpu *vcpu, gpa_t=
 addr, uint64_t data)
>         ret =3D kvm_io_bus_write(vcpu, KVM_IOCSR_BUS, addr, 4, &val);
>         srcu_read_unlock(&vcpu->kvm->srcu, idx);
>         if (unlikely(ret))
> -               kvm_err("%s: : write data to addr %llx failed\n", __func_=
_, addr);
> +               WARN_ONCE(1, "%s: : write data to addr %llx failed\n", __=
func__, addr);
>
>         return 0;
>  }
> @@ -168,7 +168,7 @@ static int any_send(struct kvm *kvm, uint64_t data)
>         cpu =3D ((data & 0xffffffff) >> 16) & 0x3ff;
>         vcpu =3D kvm_get_vcpu_by_cpuid(kvm, cpu);
>         if (unlikely(vcpu =3D=3D NULL)) {
> -               kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
> +               WARN_ONCE(1, "%s: invalid target cpu: %d\n", __func__, cp=
u);
>                 return 0;
>         }
>         offset =3D data & 0xffff;
> @@ -200,14 +200,14 @@ static int loongarch_ipi_readl(struct kvm_vcpu *vcp=
u, gpa_t addr, int len, void
>                 break;
>         case IOCSR_IPI_BUF_20 ... IOCSR_IPI_BUF_38 + 7:
>                 if (offset + len > IOCSR_IPI_BUF_38 + 8) {
> -                       kvm_err("%s: invalid offset or len: offset =3D %d=
, len =3D %d\n",
> +                       WARN_ONCE(1, "%s: invalid offset or len: offset =
=3D %d, len =3D %d\n",
>                                 __func__, offset, len);
>                         break;
>                 }
>                 res =3D read_mailbox(vcpu, offset, len);
>                 break;
>         default:
> -               kvm_err("%s: unknown addr: %llx\n", __func__, addr);
> +               WARN_ONCE(1, "%s: unknown addr: %llx\n", __func__, addr);
>                 break;
>         }
>         *(uint64_t *)val =3D res;
> @@ -242,7 +242,7 @@ static int loongarch_ipi_writel(struct kvm_vcpu *vcpu=
, gpa_t addr, int len, cons
>                 break;
>         case IOCSR_IPI_BUF_20 ... IOCSR_IPI_BUF_38 + 7:
>                 if (offset + len > IOCSR_IPI_BUF_38 + 8) {
> -                       kvm_err("%s: invalid offset or len: offset =3D %d=
, len =3D %d\n",
> +                       WARN_ONCE(1, "%s: invalid offset or len: offset =
=3D %d, len =3D %d\n",
>                                 __func__, offset, len);
>                         break;
>                 }
> @@ -258,7 +258,7 @@ static int loongarch_ipi_writel(struct kvm_vcpu *vcpu=
, gpa_t addr, int len, cons
>                 any_send(vcpu->kvm, data);
>                 break;
>         default:
> -               kvm_err("%s: unknown addr: %llx\n", __func__, addr);
> +               WARN_ONCE(1, "%s: unknown addr: %llx\n", __func__, addr);
>                 break;
>         }
>
> @@ -301,7 +301,7 @@ static int kvm_ipi_regs_access(struct kvm_device *dev=
,
>
>         vcpu =3D kvm_get_vcpu_by_id(dev->kvm, cpu);
>         if (unlikely(vcpu =3D=3D NULL)) {
> -               kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
> +               WARN_ONCE(1, "%s: invalid target cpu: %d\n", __func__, cp=
u);
>                 return -EINVAL;
>         }
>
> @@ -335,7 +335,7 @@ static int kvm_ipi_regs_access(struct kvm_device *dev=
,
>                 len =3D 8;
>                 break;
>         default:
> -               kvm_err("%s: unknown ipi register, addr =3D %d\n", __func=
__, addr);
> +               WARN_ONCE(1, "%s: unknown ipi register, addr =3D %d\n", _=
_func__, addr);
>                 return -EINVAL;
>         }
>
> @@ -369,7 +369,7 @@ static int kvm_ipi_get_attr(struct kvm_device *dev,
>         case KVM_DEV_LOONGARCH_IPI_GRP_REGS:
>                 return kvm_ipi_regs_access(dev, attr, false);
>         default:
> -               kvm_err("%s: unknown group (%d)\n", __func__, attr->group=
);
> +               WARN_ONCE(1, "%s: unknown group (%d)\n", __func__, attr->=
group);
>                 return -EINVAL;
>         }
>  }
> @@ -381,7 +381,7 @@ static int kvm_ipi_set_attr(struct kvm_device *dev,
>         case KVM_DEV_LOONGARCH_IPI_GRP_REGS:
>                 return kvm_ipi_regs_access(dev, attr, true);
>         default:
> -               kvm_err("%s: unknown group (%d)\n", __func__, attr->group=
);
> +               WARN_ONCE(1, "%s: unknown group (%d)\n", __func__, attr->=
group);
>                 return -EINVAL;
>         }
>  }
> @@ -394,13 +394,13 @@ static int kvm_ipi_create(struct kvm_device *dev, u=
32 type)
>         struct loongarch_ipi *s;
>
>         if (!dev) {
> -               kvm_err("%s: kvm_device ptr is invalid!\n", __func__);
> +               WARN_ONCE(1, "%s: kvm_device ptr is invalid!\n", __func__=
);
>                 return -EINVAL;
>         }
>
>         kvm =3D dev->kvm;
>         if (kvm->arch.ipi) {
> -               kvm_err("%s: LoongArch IPI has already been created!\n", =
__func__);
> +               WARN_ONCE(1, "%s: LoongArch IPI has already been created!=
\n", __func__);
>                 return -EINVAL;
>         }
>
> @@ -420,7 +420,7 @@ static int kvm_ipi_create(struct kvm_device *dev, u32=
 type)
>         ret =3D kvm_io_bus_register_dev(kvm, KVM_IOCSR_BUS, IOCSR_IPI_BAS=
E, IOCSR_IPI_SIZE, device);
>         mutex_unlock(&kvm->slots_lock);
>         if (ret < 0) {
> -               kvm_err("%s: Initialize IOCSR dev failed, ret =3D %d\n", =
__func__, ret);
> +               WARN_ONCE(1, "%s: Initialize IOCSR dev failed, ret =3D %d=
\n", __func__, ret);
>                 goto err;
>         }
>
> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/=
pch_pic.c
> index 175a630aceb4..299b4db26833 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -151,12 +151,12 @@ static int kvm_pch_pic_read(struct kvm_vcpu *vcpu,
>         struct loongarch_pch_pic *s =3D vcpu->kvm->arch.pch_pic;
>
>         if (!s) {
> -               kvm_err("%s: pch pic irqchip not valid!\n", __func__);
> +               WARN_ONCE(1, "%s: pch pic irqchip not valid!\n", __func__=
);
>                 return ret;
>         }
>
>         if (addr & (len - 1)) {
> -               kvm_err("%s: pch pic not aligned addr %llx len %d\n", __f=
unc__, addr, len);
> +               WARN_ONCE(1, "%s: pch pic not aligned addr %llx len %d\n"=
, __func__, addr, len);
>                 return ret;
>         }
>
> @@ -250,12 +250,12 @@ static int kvm_pch_pic_write(struct kvm_vcpu *vcpu,
>         struct loongarch_pch_pic *s =3D vcpu->kvm->arch.pch_pic;
>
>         if (!s) {
> -               kvm_err("%s: pch pic irqchip not valid!\n", __func__);
> +               WARN_ONCE(1, "%s: pch pic irqchip not valid!\n", __func__=
);
>                 return ret;
>         }
>
>         if (addr & (len - 1)) {
> -               kvm_err("%s: pch pic not aligned addr %llx len %d\n", __f=
unc__, addr, len);
> +               WARN_ONCE(1, "%s: pch pic not aligned addr %llx len %d\n"=
, __func__, addr, len);
>                 return ret;
>         }
>
> @@ -390,13 +390,13 @@ static int kvm_pch_pic_set_attr(struct kvm_device *=
dev,
>                                 return -EFAULT;
>
>                         if (!dev->kvm->arch.pch_pic) {
> -                               kvm_err("%s: please create pch_pic irqchi=
p first!\n", __func__);
> +                               WARN_ONCE(1, "%s: please create pch_pic i=
rqchip first\n", __func__);
>                                 return -ENODEV;
>                         }
>
>                         return kvm_pch_pic_init(dev, addr);
>                 default:
> -                       kvm_err("%s: unknown group (%d) attr (%lld)\n", _=
_func__, attr->group,
> +                       WARN_ONCE(1, "%s: unknown group (%d) attr (%lld)\=
n", __func__, attr->group,
>                                         attr->attr);
>                         return -EINVAL;
>                 }
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 20c207d80e31..361fca46e2b3 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1473,7 +1473,7 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,=
 struct kvm_interrupt *irq)
>         else if (intr < 0)
>                 kvm_dequeue_irq(vcpu, -intr);
>         else {
> -               kvm_err("%s: invalid interrupt ioctl %d\n", __func__, irq=
->irq);
> +               WARN_ONCE(1, "%s: invalid interrupt ioctl %d\n", __func__=
, irq->irq);
>                 return -EINVAL;
>         }
>
> --
> 2.39.3
>
