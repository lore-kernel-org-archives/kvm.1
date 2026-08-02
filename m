Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7B13B3BF2
	for <kvm@vger.kernel.org>; Sun,  2 Aug 2026 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785679962; cv=none; b=IzG23dLisrrdjjNxf8RmZchsnKOD97yJACw2qOCGzqhyT++GJOMqRIgNJRgsSgxxNQYs7eo4PMA2vYq9arnu2bvHkeUGf76vco6CJ6yyt24HVssyiuwiqykLjJDv5SuEsKEfN3v4q39ifaPrnWN+CuZfPc8XuNAVurRdCE3oDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785679962; c=relaxed/simple;
	bh=RjR7+GCEFQDuDU9VPalteSEvnbzrEvRUrzRcmAJceYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKnuIE/37+XQJF0Sp7XIjYu0ZVpzv+yPNGQZ3qqQl+4KxhNAhSI96yhPGsSlKi+NIqXPQub8Lb9fLB1E3vimB2Q8uSX6xZQqKRriVUcLFvnfvFz3etxgG+rREbn/mK//xszh+7L+Hdu6+4oKMmQUMnSOre0iNi5MUl41eEvlcME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqBpR139; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqBpR139"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A021F00A3A
	for <kvm@vger.kernel.org>; Sun,  2 Aug 2026 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785679961;
	bh=JikhFbZmF09jooAq/kbmi2mkzkNIkR7OCQWT2PgSxkg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hqBpR139dVXOezqjIP7YPTNmhThfu/fazJse8KuDpHn9ww/+xrvUbKL1bR36shyor
	 JMkdKzuIUUU2WkXExM+6VZsv97fQxCXN5/rRXZPzSMf+xbS1Kr6nxOCAmKsmFfiDAY
	 2zvIuoMEek3/9YDlUaBfNb8VyNTyGf9iTyny+hmPZI/04aqRb2UUc0N/1EEztkjpNM
	 iJo93IB2GGXh7fUTle9YGKWQ5IWRK58lGZbE9uQEN79YIcdQ0weemxRdfLz+NEOsqp
	 UIGM/70aA31n9MnQ3z7J3vgSHYiz4SwWqFmtvlwKD+YZzdpqiPinWlcWmVPjs44cFD
	 QOopdVZuRbvew==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso4212356a12.1
        for <kvm@vger.kernel.org>; Sun, 02 Aug 2026 07:12:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoQGdNx69Iuz/G4tN6xe9ircnxO2CCA/byH/sPdmsvGFvz0talF8PzMr21z/6E1TH8T5aY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1WvQ0iPr7ApYdqVBEZObaITTfLOCQQZK6QL7Tt3/FNmGtjuzO
	v8+jIH4QrvwnfyPiKD6DJndY9rILfJq5yk6Afof4S0wFVKo8thXtnO+ribE54c/XVbZPOJoCrAS
	j0LOcWa4mbCy4U/VVrf/zAgdl/b3ju1M=
X-Received: by 2002:a05:6402:a0db:b0:6a0:926e:f907 with SMTP id
 4fb4d7f45d1cf-6a0a7c614ecmr4579172a12.1.1785679959856; Sun, 02 Aug 2026
 07:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727072109.2151675-1-maobibo@loongson.cn> <20260727072109.2151675-3-maobibo@loongson.cn>
In-Reply-To: <20260727072109.2151675-3-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 2 Aug 2026 22:12:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7dydcNDNh32cZS5=HhHPE01hdZzEy-vj=5cBEA_b7Xug@mail.gmail.com>
X-Gm-Features: AUfX_mwW8K00UvjukGfAm7FZ7kxZ1GLSOQGWEFG72LKWPgqtzFlEBQnQ6ZaCUQE
Message-ID: <CAAhV-H7dydcNDNh32cZS5=HhHPE01hdZzEy-vj=5cBEA_b7Xug@mail.gmail.com>
Subject: Re: [PATCH 2/6] LoongArch: KVM: Add separate vCPU and VM id update function
To: Bibo Mao <maobibo@loongson.cn>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	WANG Xuerui <kernel@xen0n.name>, Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@xry111.site>, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Mon, Jul 27, 2026 at 3:29=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> There are two-level MMU on LoongArch KVM system, the first level (stage1)
> MMU is mapping for GVA --> GPA, the second level (stage2) is mapping
> for GPA --> HPA. Similar with ASID, there is different ID management
> to support multiple VMs and vCPUs. The stage1 MMU is called vCPUID, and
> the second MMU is called VMID, the corresponding ID management function
> is kvm_check_vcpuid() and kvm_check_vmid().
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/kvm/main.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 6e3e8efa1dc2..c1e1d8424fa7 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -223,10 +223,9 @@ static void kvm_update_vpid(struct kvm_vcpu *vcpu, i=
nt cpu)
>
>         context->vpid_cache =3D vpid;
>         vcpu->arch.vpid =3D vpid;
> -       vcpu->arch.vmid =3D vcpu->arch.vpid & vpid_mask;
>  }
>
> -void kvm_check_vpid(struct kvm_vcpu *vcpu)
> +static void kvm_check_vcpuid(struct kvm_vcpu *vcpu)
>  {
>         int cpu;
>         bool migrated;
> @@ -254,7 +253,6 @@ void kvm_check_vpid(struct kvm_vcpu *vcpu)
>                 kvm_update_vpid(vcpu, cpu);
>                 trace_kvm_vpid_change(vcpu, vcpu->arch.vpid);
>                 vcpu->cpu =3D cpu;
> -               kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
>
>                 /*
>                  * LLBCTL is a separated guest CSR register from host, a =
general
> @@ -280,6 +278,23 @@ void kvm_check_vpid(struct kvm_vcpu *vcpu)
>         }
>  }
>
> +static void kvm_check_vmid(struct kvm_vcpu *vcpu)
> +{
> +       unsigned long vmid;
> +
> +       vmid =3D vcpu->arch.vpid & vpid_mask;
> +       if (vcpu->arch.vmid !=3D vmid) {
> +               vcpu->arch.vmid =3D vmid;
> +               kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +       }
> +}
> +
> +void kvm_check_vpid(struct kvm_vcpu *vcpu)
> +{
> +       kvm_check_vcpuid(vcpu);
> +       kvm_check_vmid(vcpu);
> +}
I think the previous naming is a little better:

+void kvm_check_vpid(struct kvm_vcpu *vcpu)
+{
+ __kvm_check_vpid(vcpu);
+ __kvm_check_vmid(vcpu);
+}


Huacai


> +
>  void kvm_init_vmcs(struct kvm *kvm)
>  {
>         kvm->arch.vmcs =3D vmcs;
> --
> 2.39.3
>
