Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9DC3F0749
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018958; cv=none; b=ZRgs8uj6y63t/srx1DlGXRSwA0mrRxPQkZN0KFZkdoGXdhp01J39R2epeDgdoB3GgPxvsZViHT1n7JgOs2qmxqXOlCo46p5U01vhSSav/bvNOtfK3j/EiDBWV3osGreqW3kvRwT2mcn0//cem+iELy9izFL5uU/WzsalsZ8P7VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018958; c=relaxed/simple;
	bh=hnf4hqy69IQdbWBygkWSRpLlXwajx1CU04pakKqyZG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMSX7rZDiTpOxavDP6gIUsgPaZNpEXilRQWUcU+2AYsAHzDLqjYw6NyqfxM0gIM5DBBsqc5CmBuUWz7AdbF+sESrTeHgoGd+KrLF1HnGgXUN/ATF+QI479kteIV/TZDp8b01j+XOoYzdq9MEtmXUW3dEohIXL6v5zDAAFekYm70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJdbXw8n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJdbXw8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299911F00AC4
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 12:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786018957;
	bh=iCsijIwkaNymZGj1vk+tTx1FeRBXQYksHd8ZjnFTCaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UJdbXw8nth7UzFXh2+VAPq7VFFlrY/HXPZ3KxqyaIYouVwe/PUY4NuB6Vh4OBB9dA
	 2dIgs5tXzE/kwqtk7b0B2qQyndPIG8beFYBMrUA20ftfucSTbswRUekGs+IH//2pT5
	 XrqvioHOMRO9GeH6y2Yy9Ro83UTEHwW8pWYKn3Ps8MB/GnV7v8VgkC4kNLQ5QTvd7G
	 n1ymsar+qdnhLosFcyALcDeSc88D+Uci+hjWCO7MqQxPZ/j2HPjc5Xc3fpRUaQV4fw
	 1x9c40Dus4FC+5na20u+bR8q8jmJ27XzkVOrfVOyS0veK0Egh3fqdAoZazsv+Zj3hZ
	 qEgMm0qUjM3Lg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso2978903a12.3
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 05:22:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrLYZTtC/UmPZV8AXhvZNNuh8W+HJnu6YU078WJStzXMcUaXhXdP9HX++qmS8JU0pGuu40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6RctUGosDJsDGqm4xm4/0QLUWeKwhYexDhC5lO8WWDaP8biUY
	KM/r5vwIkR3441yz/xQqQlgx4mGmyTO3UkLnVnPnr1jFksnRtv4AHWsco2k3IxEw5L8Z+wxgx+w
	UX8iJ6VUWWilitw/Uw+ov2h2cgsNVV38=
X-Received: by 2002:a05:6402:3222:b0:69c:72e2:a3d9 with SMTP id
 4fb4d7f45d1cf-6a14f26c0f4mr8060415a12.21.1786018955737; Thu, 06 Aug 2026
 05:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020739.2149268-1-maobibo@loongson.cn> <20260806020739.2149268-4-maobibo@loongson.cn>
In-Reply-To: <20260806020739.2149268-4-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 6 Aug 2026 20:23:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5vPyKNR63hzxWkyZzyEJ09DtuudqTaiQHCfxai6S23DQ@mail.gmail.com>
X-Gm-Features: AUfX_myhEc5vr2_ySaQBGF3U0VQwxpWXtrvWI31rwOQmqUfAo6z_2KKUHl_Oo0Y
Message-ID: <CAAhV-H5vPyKNR63hzxWkyZzyEJ09DtuudqTaiQHCfxai6S23DQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] LoongArch: KVM: Add separate vmid feature support
To: Bibo Mao <maobibo@loongson.cn>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	WANG Xuerui <kernel@xen0n.name>, Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Thu, Aug 6, 2026 at 10:15=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> Feature cpu_has_guestid is used to check whether separate vmid/vpid
> is supported or not. It is disabled by default, add this feature
> checking, there is no function change.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/kvm/main.c | 14 +++++++++-----
>  arch/loongarch/kvm/mmu.c  |  6 ++++--
>  arch/loongarch/kvm/vcpu.c |  3 ++-
>  3 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index ac804e77e844..c36e62ab0d91 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -218,7 +218,8 @@ static void kvm_update_vpid(struct kvm_vcpu *vcpu, in=
t cpu)
>                 ++vpid; /* vpid 0 reserved for root */
>
>                 /* start new vpid cycle */
> -               kvm_flush_tlb_all();
> +               if (!cpu_has_guestid)
> +                       kvm_flush_tlb_all();
>         }
>
>         context->vpid_cache =3D vpid;
> @@ -282,10 +283,13 @@ static void __kvm_check_vmid(struct kvm_vcpu *vcpu)
>  {
>         unsigned long vmid;
>
> -       vmid =3D vcpu->arch.vpid & vpid_mask;
> -       if (vcpu->arch.hw_vmid !=3D vmid) {
> -               vcpu->arch.hw_vmid =3D vcpu->arch.vpid & vpid_mask;
> -               kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +       /* On some machines like 3A5000, vmid needs the same with vpid */
> +       if (!cpu_has_guestid) {
> +               vmid =3D vcpu->arch.vpid & vpid_mask;
> +               if (vcpu->arch.hw_vmid !=3D vmid) {
> +                       vcpu->arch.hw_vmid =3D vcpu->arch.vpid & vpid_mas=
k;
> +                       kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +               }
Merge Patch#3 and Patch#4, then __kvm_check_vmid() can handle both
cpu_has_guestid and !cpu_has_guestid cases together.


Huacai

>         }
>  }
>
> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> index e104897aa532..714640a2e614 100644
> --- a/arch/loongarch/kvm/mmu.c
> +++ b/arch/loongarch/kvm/mmu.c
> @@ -929,8 +929,10 @@ int kvm_handle_mm_fault(struct kvm_vcpu *vcpu, unsig=
ned long gpa, bool write, in
>                  *
>                  * With SW PTW, invalid TLB is added in TLB refill except=
ion.
>                  */
> -               vcpu->arch.flush_gpa =3D gpa;
> -               kvm_make_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +               if (!cpu_has_guestid) {
> +                       vcpu->arch.flush_gpa =3D gpa;
> +                       kvm_make_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +               }
>         }
>
>         return 0;
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 20c207d80e31..0b2355aec932 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -210,7 +210,8 @@ static int kvm_check_requests(struct kvm_vcpu *vcpu)
>                 return RESUME_GUEST;
>
>         if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu))
> -               vcpu->arch.vpid =3D 0;  /* Drop vpid for this vCPU */
> +               if (!cpu_has_guestid)
> +                       vcpu->arch.vpid =3D 0;  /* Drop vpid for this vCP=
U */
>
>         if (kvm_dirty_ring_check_request(vcpu))
>                 return RESUME_HOST;
> --
> 2.39.3
>
