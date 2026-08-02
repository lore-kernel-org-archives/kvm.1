Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E23B19B3
	for <kvm@vger.kernel.org>; Sun,  2 Aug 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680022; cv=none; b=H8Z4SyeACdzTuKYjKehlZh4vufqHuMwfJz89XfU+68XTl7DA/bhHcyUu69rbWpsnddgsCFP+4/DlhsXFQMeGcXGZi+OVZYwtj6HzU74hcyOReweJuZuBm0Q9fvCoUo8TSd4h9ZlUcxlgoeuPW7dTnzupmtk06cJfpmCvuKaew+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680022; c=relaxed/simple;
	bh=zwm0ww+Wk/UlLivNJA+wRyMoNv2g+ilp3oNpgSMU34s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cz6oUse96tb5nt6Eaxi7bPhGqLchUYCeq2bcb2QVy/vXM9vH0qqJ8ZGvT7OFLXJHtJECtsY7UIUxg6bAaatFY7sncd1F7kvRSmRBz8AkoemlmMM8NMQs/cRViyDXIKU4OHUSlLVeG+KpPOcj2jyh0z8pZmERWwEJZ5gQZKyqsl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2lHztPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2lHztPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB711F00A3A
	for <kvm@vger.kernel.org>; Sun,  2 Aug 2026 14:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680021;
	bh=MKvU+/EXsXxBMCpCnryXkZZfvpasruHEM6ed/bTlRqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=n2lHztPCQXMPmQvW3aHXrSPNhlErt3Hq5Gv5spmbmsH0cgawkYkyXDaZBlQ9S3zo4
	 yePC//f60gK2aN4nlHSG/0SHpmMKSFbLZnZuNLAcRXsd5aH3fOLtEXJduZO4iDZQLJ
	 1cifWOdN+U/jjKb/6rBJDIQB9XYsbyMYTKSG4drN7w7aqKW4IWgrq/dDVQZzyDQktr
	 s4skRPSszFNVTbT8rKwUFuj+wJZrpEL3UJRxuZce3y6kL0P0osWvrliLeklgPGSlqC
	 1bkiYaZJoWZEjE52jwWO5m7teVezRvtfFQD1RfCCXi6uPUrJIJmYH2dYdheQ1/xXs1
	 xGBxydtKZiL6w==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69fec980a30so3088780a12.3
        for <kvm@vger.kernel.org>; Sun, 02 Aug 2026 07:13:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpglZxr+hs8pdyhePpsIHMfn5KzK35uP/iZBpvaaxB0Vvqtl2WIZeQsshGKU6fsQjfKpDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2h/COYpoA59waFcI771k7wmDFW5BGlmKPleMLSjPbgERobYBb
	tgKa+eMRDxotWl0yBZNX/NPi2NjqHZm9kD6dvD22V2ZSqL5BWqMij5DBtKsAaC0jMFbxrzQoHyp
	/qEDXvtaoZZgCEu8aEPYQ/zlKgfyQF2w=
X-Received: by 2002:a05:6402:a0d4:b0:6a0:927e:39e4 with SMTP id
 4fb4d7f45d1cf-6a0a7c60461mr4698669a12.5.1785680019994; Sun, 02 Aug 2026
 07:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727072109.2151675-1-maobibo@loongson.cn> <20260727072109.2151675-5-maobibo@loongson.cn>
In-Reply-To: <20260727072109.2151675-5-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 2 Aug 2026 22:13:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5uF_hzKGZZbXzj5t6TFPefDVn09F0VM-AuNiDjoJZzCQ@mail.gmail.com>
X-Gm-Features: AUfX_my14BlxXSaC8L-GWTWiaN_y2FeYOQ4epXBH4it-JheGLUegWyxC5r2LTBU
Message-ID: <CAAhV-H5uF_hzKGZZbXzj5t6TFPefDVn09F0VM-AuNiDjoJZzCQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] LoongArch: KVM: implement vmid updating logic
To: Bibo Mao <maobibo@loongson.cn>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	WANG Xuerui <kernel@xen0n.name>, Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, BIbo,

On Mon, Jul 27, 2026 at 3:30=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> For every physical CPU, there is one vmid calculation method. For
> vCPUs on the same VM, vmid is the same. However for vCPUs on
> different VM, vmid is different. When vCPU is scheduled on the
> physical CPU, it checked vmid of this VM and the global cached
> vmid, and judge whether it is valid or not.
I think Patch#2/3/4 can be folded into one.


Huacai

>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/kvm_host.h |  2 ++
>  arch/loongarch/kvm/main.c             | 42 ++++++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/inclu=
de/asm/kvm_host.h
> index e93307cbe740..a01623c42c7a 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -79,6 +79,7 @@ struct kvm_arch_memory_slot {
>  #define HOST_MAX_PMNUM                 16
>  struct kvm_context {
>         unsigned long vpid_cache;
> +       unsigned long vmid_cache;
>         struct kvm_vcpu *last_vcpu;
>         /* Host PMU CSR */
>         u64 perf_ctrl[HOST_MAX_PMNUM];
> @@ -132,6 +133,7 @@ struct kvm_arch {
>         unsigned long kvm_features;
>
>         s64 time_offset;
> +       unsigned long vmid[NR_CPUS];
>         struct kvm_context __percpu *vmcs;
>         struct loongarch_ipi *ipi;
>         struct loongarch_dmsintc *dmsintc;
> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 3df46e02594f..7b3661da8958 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -281,9 +281,33 @@ static void kvm_check_vcpuid(struct kvm_vcpu *vcpu)
>         }
>  }
>
> -static void kvm_check_vmid(struct kvm_vcpu *vcpu)
> +static void kvm_update_vmid(struct kvm_vcpu *vcpu, int cpu)
>  {
>         unsigned long vmid;
> +       struct kvm_context *context;
> +
> +       context =3D per_cpu_ptr(vcpu->kvm->arch.vmcs, cpu);
> +       vmid =3D context->vmid_cache + 1;
> +       if (!(vmid & vpid_mask)) {
> +               /* finish round of vmid loop */
> +               if (unlikely(!vmid))
> +                       vmid =3D vpid_mask + 1;
> +
> +               ++vmid; /* vmid 0 reserved for root */
> +
> +               /* start new vmid cycle */
> +               kvm_flush_tlb_all_stage2();
> +       }
> +
> +       context->vmid_cache =3D vmid;
> +       vcpu->kvm->arch.vmid[cpu] =3D vmid;
> +}
> +
> +static void kvm_check_vmid(struct kvm_vcpu *vcpu)
> +{
> +       int cpu;
> +       unsigned long ver, old, vmid;
> +       struct kvm_context *context;
>
>         /* On some machines like 3A5000, vmid needs the same with vpid */
>         if (!cpu_has_guestid) {
> @@ -295,6 +319,21 @@ static void kvm_check_vmid(struct kvm_vcpu *vcpu)
>
>                 return;
>         }
> +
> +       cpu =3D smp_processor_id();
> +       context =3D per_cpu_ptr(vcpu->kvm->arch.vmcs, cpu);
> +
> +       /*
> +        * Check if our vmid is of an older version
> +        */
> +       ver =3D vcpu->kvm->arch.vmid[cpu] & ~vpid_mask;
> +       old =3D context->vmid_cache & ~vpid_mask;
> +       if (ver !=3D old) {
> +               kvm_update_vmid(vcpu, cpu);
> +               kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +       }
> +
> +       vcpu->arch.vmid =3D vcpu->kvm->arch.vmid[cpu] & vpid_mask;
>  }
>
>  void kvm_check_vpid(struct kvm_vcpu *vcpu)
> @@ -400,6 +439,7 @@ static int kvm_loongarch_env_init(void)
>         for_each_possible_cpu(cpu) {
>                 context =3D per_cpu_ptr(vmcs, cpu);
>                 context->vpid_cache =3D vpid_mask + 1;
> +               context->vmid_cache =3D vpid_mask + 1;
>                 context->last_vcpu =3D NULL;
>         }
>
> --
> 2.39.3
>
