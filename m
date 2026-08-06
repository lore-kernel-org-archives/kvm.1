Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C1747A89D
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018802; cv=none; b=OZ4vAjHxbXO8a5wLEGHQa7J0JNGBc1pTT6uznjt1LJgjrMynmzHllD4HLLAYw36R2CvgMty6OiGtS2Rf4y2wtvCfV0pGfzyEf9hi6Xl7h8UHoFxNP0JhJ23fSiD6xggTdd9KL/I1RCa41dROcCWnpYN7MZ97pxYXLZqFhbtk7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018802; c=relaxed/simple;
	bh=ZDUdqg0GT6z/Ew2H+PbtNLlYMwA/2zC8ZELf7UqhWLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVdbfuV4ItpllKVmcb7e2KEs/xFKTRYtt7o0pIthbwL6EKS/2gY82jy0yatovXCtgulNf5IfJZh9Pgc+/pzjYQvGEAtQ07pxSo5nhwIHt0ZQMi7/M6T8h35tcvWvBTsjBteFK/C4wMsXtG+7H27CLUxqc8jRI5tEbr1Up34ITiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRHLi2U3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRHLi2U3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA531F00ACA
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 12:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786018801;
	bh=Xc+U+TDw+WwC711T0oP5kgNp4GKrrHajAHm5+7UYGkg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iRHLi2U3Icn0tvTRyWoSRg433TdjGHk4pq6u8S2H8Wq9N0xiHKeol+1bT23bNTt19
	 w7Vp18dHwqMREzHrnn26zXgWSwYUDeWDyPeF2+pH5IU/AOG1JdjyHkSoU62LV+ZQoe
	 AJlSOQBcstdvWuXHlL7FxHRbXIIG12LCRgE022X1kwskdU9NRcZir5GNmydazJZOot
	 7cHqdQO1SE4F9cU/b0rPGczG6nF+TXBXz/xE3cJUzL4YxISOpVK2pKDeducMNHQbIG
	 GMlkjNQ7Ef89TaW/Z+8wpCUsFKurmULVG2yH20rez5J8iEaHAP3bPmfY3HRBo78YLY
	 wDt3j54upgVGg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a063d211ebso2798074a12.3
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 05:20:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp7HC0JwJ61vtI6VQE8577xHrxCybQKakUtpmIbtMohYZakzbfBsJDos4g/u+oAdZgVUZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVdFr7VWt1Qt5GB2WcVoizJtcD28NZi0W6tRHV4P6GuZsqccs
	OqqBdmHknp/SqtcReZqEo7WZVwGN81ViHT3hTKUiyu0+sUWKoaUi+1TPqr6OIkHM74j+d2mrpi9
	2W6T8PF3GZ/crifW/4a0pZyHhwtBhT/c=
X-Received: by 2002:a05:6402:551b:b0:6a0:7a06:3031 with SMTP id
 4fb4d7f45d1cf-6a14f0a151cmr7823036a12.3.1786018799598; Thu, 06 Aug 2026
 05:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020739.2149268-1-maobibo@loongson.cn> <20260806020739.2149268-2-maobibo@loongson.cn>
In-Reply-To: <20260806020739.2149268-2-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 6 Aug 2026 20:20:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6TLMaD9iv4eksPB+=VjjyR_YXVyzdx8ou9LF0mSYz_4g@mail.gmail.com>
X-Gm-Features: AUfX_myrIoDmH_xGqvAw0UpS82Ox6-HCNIghtK9T2ar-By_lxQPEXnHbz4nf5bE
Message-ID: <CAAhV-H6TLMaD9iv4eksPB+=VjjyR_YXVyzdx8ou9LF0mSYz_4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] LoongArch: KVM: Add vmid support for stage2 MMU
To: Bibo Mao <maobibo@loongson.cn>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	WANG Xuerui <kernel@xen0n.name>, Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Thu, Aug 6, 2026 at 10:14=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> LoongArch KVM hypervisor supports two-level MMU, vpid index is used
> for stage1 MMU and vmid index is used for stage2 MMU.
>
> On 3A5000, vmid must be the same with vpid. On 3A6000 platform vmid
> may separate from vpid. If vCPU migrate to different physical CPUs,
> vpid need change however vmid can keep unchanged, so that TLB entries
> for stage2 MMU is valid still. Also vmid index of the whole VM machine
> is the same on one physical CPU, all vCPUs on the VM can share the
> same vmid index on one physical CPU.
>
> Here hw vmid index is added and it keeps the same with hw vpid still.
HW VPID means GSTAT.GID, HW VMID means GTLBC.TGID, right? It is useful
to describe it in the commit message.


>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/kvm_host.h | 3 +++
>  arch/loongarch/kernel/asm-offsets.c   | 1 +
>  arch/loongarch/kvm/main.c             | 1 +
>  arch/loongarch/kvm/switch.S           | 5 ++---
>  arch/loongarch/kvm/tlb.c              | 5 ++++-
>  5 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/inclu=
de/asm/kvm_host.h
> index 23cfbecebbd7..78f97dea124d 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -232,6 +232,9 @@ struct kvm_vcpu_arch {
>         /* Cache for pages needed inside spinlock regions */
>         struct kvm_mmu_memory_cache mmu_page_cache;
>
> +       /* hw vmid info for guest VM */
> +       unsigned long hw_vmid;
Since this is only used to write GCNTC.TGID, simply rename it to tgid
can eliminate confusion.

> +
>         /* vcpu's vpid */
>         u64 vpid;
>         gpa_t flush_gpa;
> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/=
asm-offsets.c
> index 1b861cbc5e10..065ced1f3c1f 100644
> --- a/arch/loongarch/kernel/asm-offsets.c
> +++ b/arch/loongarch/kernel/asm-offsets.c
> @@ -300,6 +300,7 @@ static void __used output_kvm_defines(void)
>         OFFSET(KVM_ARCH_HSP, kvm_vcpu_arch, host_sp);
>         OFFSET(KVM_ARCH_HTP, kvm_vcpu_arch, host_tp);
>         OFFSET(KVM_ARCH_HPGD, kvm_vcpu_arch, host_pgd);
> +       OFFSET(KVM_ARCH_VMID, kvm_vcpu_arch, hw_vmid);
>         OFFSET(KVM_ARCH_KVMPGD, kvm_vcpu_arch, kvm_pgd);
>         OFFSET(KVM_ARCH_HANDLE_EXIT, kvm_vcpu_arch, handle_exit);
>         OFFSET(KVM_ARCH_HEENTRY, kvm_vcpu_arch, host_eentry);
> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 3e1005526f4b..401c84f38e8c 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -223,6 +223,7 @@ static void kvm_update_vpid(struct kvm_vcpu *vcpu, in=
t cpu)
>
>         context->vpid_cache =3D vpid;
>         vcpu->arch.vpid =3D vpid;
> +       vcpu->arch.hw_vmid =3D vcpu->arch.vpid & vpid_mask;
Merge Patch#1 and Patch#2, then we can avoid adding this line and then
remove it immediately.


>  }
>
>  void kvm_check_vpid(struct kvm_vcpu *vcpu)
> diff --git a/arch/loongarch/kvm/switch.S b/arch/loongarch/kvm/switch.S
> index 936e4ae3e408..af972394fd55 100644
> --- a/arch/loongarch/kvm/switch.S
> +++ b/arch/loongarch/kvm/switch.S
> @@ -66,9 +66,8 @@
>         ld.d    t0, a2, KVM_ARCH_KVMPGD
>         csrwr   t0, LOONGARCH_CSR_PGDL
>
> -       /* Mix GID and RID */
> -       csrrd           t1, LOONGARCH_CSR_GSTAT
> -       bstrpick.w      t1, t1, CSR_GSTAT_GID_SHIFT_END, CSR_GSTAT_GID_SH=
IFT
> +       /* Set VMID for gpa --> hpa mapping */
> +       ld.d            t1, a2, KVM_ARCH_VMID
>         csrrd           t0, LOONGARCH_CSR_GTLBC
>         bstrins.w       t0, t1, CSR_GTLBC_TGID_SHIFT_END, CSR_GTLBC_TGID_=
SHIFT
>         csrwr           t0, LOONGARCH_CSR_GTLBC
> diff --git a/arch/loongarch/kvm/tlb.c b/arch/loongarch/kvm/tlb.c
> index ebdbe9264e9c..b25847aab968 100644
> --- a/arch/loongarch/kvm/tlb.c
> +++ b/arch/loongarch/kvm/tlb.c
> @@ -23,7 +23,10 @@ void kvm_flush_tlb_all(void)
>
>  void kvm_flush_tlb_gpa(struct kvm_vcpu *vcpu, unsigned long gpa)
>  {
> +       unsigned int vmid;
> +
>         lockdep_assert_irqs_disabled();
>         gpa &=3D (PAGE_MASK << 1);
> -       invtlb(INVTLB_GID_ADDR, read_csr_gstat() & CSR_GSTAT_GID, gpa);
> +       vmid =3D (vcpu->arch.hw_vmid << CSR_GSTAT_GID_SHIFT) & CSR_GSTAT_=
GID;
> +       invtlb(INVTLB_GID_ADDR, vmid, gpa);
>  }
> --
> 2.39.3
>
