Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794924487;
	b=Yq3ANRiDNTYqrJgr/3k1SMGhuNyrXvyuOPnMv/Cb/5bSEehzZgFMrALCzKKPrDs00eru
	 nflu++f63dCKa6hNFh/7izskgfOeUBlwmbsp+OdKPfVoxq/peMK7Uu659iQLMP9fiL2pn
	 QVButghwvNq1TrCuP+gjl95L04UuB9UA3YspH+Ky/gM7CzkkzKJnFJQAv4Xj6DAgoYPRx
	 4Rw+YfOaj4MkgeD+VxsQ66CTARt8w/6v82yPiY3SmjPX6P9GT+cQOjbALmMqYHhmmFJsJ
	 kg5j3q9JQNEj2tR8Wxo8C4FJsYLLMQuI/Cn3qJwM5De0ptwerICrQlWyFrtvUVBX/pA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=htWpbWvWjkzp2iYbY9MWMmeINInucOJuS3Dv1JVxhx8=;
	b=mV+UWAa7Kprt3R6pWQMQmNbbEkCXS6WZc+BkqVvi9aByrWVdnodJo2rzG4Xw7wEKbeR4
	 rzragEn2jihzghdtNABR/fKjv/JMZyGznfvHe6tCHrIoup5SyRmOjE6C6WEQWBYbszrnu
	 PnbULsLE+UvL8HfvIr+BfUnqldnU6q1atx/6SfZtTutcx0yxaWWRpH1zKGdmI9wIfqZEC
	 ecaE9Yjsog1xKfgHk5DZqpczwX13wxBa9PGM+Nnbq4tmo/RZZc5ssxqrR6MmA5uuTjyGI
	 FBrllzjhPS5feLLuVlCWS2kiKc3NYsoWhQFk5n1LtblDz3OfaTSnOW22qJpyZLpMABg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O2MXcFTx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B39606A331
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 14:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56B39606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O2MXcFTx
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so9373e87.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 06:08:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794924485; cv=none;
        d=google.com; s=arc-20260327;
        b=i3Z/R5WTGrVYC99q49KtSXrU42Lq64HUT/T4uaaWmb0HJB60I5n9Bf4QA9sluDCuj7
         MyPAj+nxdLbJQMDaC042930Ed/slgfBidCel+AtyxF4gsN/IvaOzeiyOIz0G3tQUrdnT
         UVd3NW8obwvgp/wp2dxH4gytSCYdsgpEb5WJiYS0wAtHMFeGnhGsHTLGQTkigSMS20DU
         rlGWYx2mHQ/V67g4srnq7C7CpJStW2xLhJ3zE4vLqek2+Bihyt4yJ+Q6+rLD1j7UhEG0
         5LUa+g9EtDBbhIULLOugQAzg/EOiSBzLJYBojv4+3k1z3dw+8Qjw0/0rguU41hMqs6cY
         2f+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=htWpbWvWjkzp2iYbY9MWMmeINInucOJuS3Dv1JVxhx8=;
        fh=ShOtn3DH2JacjDhhRuDN/ZzoL2uaqKg1U53ZjQaTW3g=;
        b=VHB27QPlyKNsu/4j57fwZx4nJkoDAQZEsNLUAzZN40mPZtuA5QtkiGKVfMz363hhQC
         cr8XzVsLfKCKH2OtTpo0V14dvj0L2u5ypxFGDSt8ajFPFMZnDgVXt5+U8HFQaHGdpv83
         YbGeP2Fw/6P7obFRGa2suXb+6wTZBmXzopft+MSXO/GaOhVqUOW6/7ROrPGbz2rHDhSv
         JpZvzAuGFjfQtVo+HcMXjsNBdwYBbMAM6gh5zjCZ3p8L0IVJovdMuKuG9P9tT809RH6E
         kwCYIAhmVmHVZShiwcnmTvGjVW3qc+9bV17dQoyFBIWPqNwahRZXFscpkHZqAjZ7jTWp
         Yxlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794924485; x=1795529285; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=htWpbWvWjkzp2iYbY9MWMmeINInucOJuS3Dv1JVxhx8=;
        b=O2MXcFTxaYhVSzP8sKYxuSFIgq9l9y02jAa+4/Cn3o/EO7Nkr21qsMFrwOS+TsHJUn
         ZFakCfwFtdgWK5T8jNky2Vyd+yBjvUmzAkSPajBpNjvOaE6z1D9PeqMS7Pq2mZxtIdt8
         q73nfzlg1UHJVZhLbLlNDNhx4v5wVkw/xIKRPh8nNGUDVyDuTZ5ea1TBUY9DUKR3DNDw
         G0QsPfCBtwy13Pu+tFqZ9payoZzErGHL074vg6ZcxKtFaZAB6y21U6E8QmoWg8Wb+qGA
         e1EO5UiWSVyJsKLrlkrAP6viDbnV6t/fN3+vh6rKfGOQefhZHMVAsXWFlG+XDwRv8DFd
         j92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794924485; x=1795529285;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=htWpbWvWjkzp2iYbY9MWMmeINInucOJuS3Dv1JVxhx8=;
        b=Sm1NDHqwhokxbzEJZXiepqp+qIMtlZzWG+rMVeyslO7QjpjkZUF+bymrQ+vYCdiqmB
         AlCY7mMXhcaKOLVcDyiGuBVSHbPqcJOz54U3d2fgyeRlhRB4npm7dSGRjV30tHdaNq43
         ljzlKF1VjrW4tBsWMHiaqu1e9RK80IobQWnxh4uVmnZ+3QiwJNE/tfEunE+HH9EKaRKz
         lrUGK1cZnSXYK9A1J9UFEu+3cUsFa9zChTgbpEwNvgvN/5W5H9og5Je7+mWxHE7Dba3k
         Lxkev5349PAQ7FasZXiQkW1tqRE05yOiz06T89yv6RbByuHkkjuJW3MS6DaRxOsw6Voo
         GTUA==
X-Gm-Message-State: APuU4Z9hBWT11NeoC0uT3sFMtJZor0u4q2ZBwz5H+vIPQvmADSVo7kox
	mpBXEUTrqmRUqBQM4hmm0v8bLSSzVkJcsFfNtZXr2P/SOtOdTmqfZ+UOHkkzpCyN9+n6W/jBl+Y
	JhKUKe+22Et41tkUYCM0fxbc3KBGXlV+yOYARlmrK
X-Gm-Gg: AYBFou3thTRya4lMk35QTIpHYIdp8c2tnjoUHcHvcBJBoJdH1r6gEp9oevEvLWOYuoq
	cWeOPxqt7sMC5HqNLK74FGeAE+I2l3d2IoE7P5ovVEynlQXwJV+gOzEQU+bEJW/JE0pmJrfIAge
	THra3wmU8QTb5rC+CvkAqAv7KK0JZSPhrvbulbc/d9cCjj5GTUpLY+qRZl96/M3fbB9Rz0qVF3e
	AEs26SlPnSBWYWEKCYM8KwZoHMbmxeMkHEQWOyPGA1yBahCvL/tbe8XAXsYiEo4+vjO2Ur30VND
	iIgHEyS9iuAqx9yzvtiKX/T2CeHwCSvva6UjnfoRVLTgX39RSt9lcHhEdvJ/sPT/ImqlrNqyYFW
	BqInuZ2zkAP1CzwdRvNcyQkdgB1/XfCi/j+ZcMZVCoJIIdFogBDX/MR5jNNLGAggksBxLfZD9AZ
	rLgCPj41xXzg1EWzA+zRZvgms=
X-Received: by 2002:ac2:4e07:0:b0:5bf:f84f:1d74 with SMTP id
 2adb3069b0e04-5c1a2185fadmr137629e87.13.1794924484857; Tue, 17 Nov 2026
 06:08:04 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116164358.142785-1-steven.price@arm.com> <20261116164358.142785-3-steven.price@arm.com>
In-Reply-To: <20261116164358.142785-3-steven.price@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Nov 2026 14:07:28 +0000
X-Gm-Features: AclHuK_JC9RetKL5Q3HHKVX6R6ajyHm2xDLO6StGpKQMwUtLiIUPvzFbgoEna3U
Message-ID: <CA+EHjTwfp8p7uwP2LXEqSmTwL6ZHuDCYbvMie_Wr_30xJwfO6A@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] KVM: arm64: CCA: Introduce Realms
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kohei Enju <enju.kohei@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 16:43:48 +0000, Steven Price <steven.price@arm.com> wrote:
[...]
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
[...]
> @@ -1571,31 +1576,39 @@ struct kvm *kvm_arch_alloc_vm(void);
>
>  #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
>
> -#ifdef __KVM_NVHE_HYPERVISOR__
> +#define kvm_vm_is_protected(kvm)        ((kvm)->arch.vm_flavor >= __VM_PROTECTED)
>
> -#define kvm_vm_is_protected(kvm)                        \
> -        (is_protected_kvm_enabled() && ((kvm)->arch.vm_flavor == VM_PROTECTED_PKVM))
> +#ifdef __KVM_NVHE_HYPERVISOR__
>  /*
>   * Accessing vcpu->kvm from nVHE hyp stub is tricky, as we need to convert the
>   * pointer to the hyp VA. With pKVM, the nVHE code runs with the hyp_vcpu,
> - * which is populated correctly and is gated on is_protected_kvm_enabled().
> + * which is populated correctly. Always vcpu_is_protected_pkvm(), which is
> + * gated on is_protected_kvm_enabled().
>   */
> -#define vcpu_is_protected(vcpu)                                                \
> +#define vcpu_is_protected(vcpu)                BUILD_BUG_ON(1)
> +#else
> +#define vcpu_is_protected(vcpu)                kvm_vm_is_protected((vcpu)->kvm)
> +#endif
> +
> +#define kvm_vm_is_protected_pkvm(kvm)                                        \
> +        (is_protected_kvm_enabled() && ((kvm)->arch.vm_flavor == VM_PROTECTED_PKVM))
> +
> +/*
> + * Rely on is_protected_kvm_enabled() check in kvm_vm_is_protected_pkvm() to
> + * make sure the vcpu->kvm is always valid VA in the context
> + */
> +#define vcpu_is_protected_pkvm(vcpu)                                        \
>          ({                                                                \
>                  struct kvm *__kvm = READ_ONCE((vcpu)->kvm);                \
>                                                                          \
> -                (__kvm && kvm_vm_is_protected(__kvm));                        \
> +                (__kvm && kvm_vm_is_protected_pkvm(__kvm));                \
>          })
>
> -#else
> -
> -#define kvm_vm_is_protected(kvm)        ((kvm)->arch.vm_flavor >= __VM_PROTECTED)
> -#define vcpu_is_protected(vcpu)                kvm_vm_is_protected((vcpu)->kvm)

This brings back the _pkvm variants that Marc asked to drop in the
plumbing series [1]. In the nVHE hyp code, kvm_vm_is_protected() and
vcpu_is_protected() already mean pKVM-protected, so I think the hyp
side can stay as it is.

At EL1, the pKVM-only checks that a Realm vCPU also reaches are in
kvm_arm_vcpu_power_off() and kvm_psci_vcpu_on(). Could they check
vm_flavor == VM_PROTECTED_PKVM directly?

> +#define kvm_vm_is_realm(kvm)                ((kvm)->arch.vm_flavor == VM_REALM)
> +#define vcpu_is_rec(vcpu)                kvm_vm_is_realm((vcpu)->kvm)

vcpu_is_rec() isn't used anywhere in this series. Could it be dropped?

[...]
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
[...]
> @@ -906,7 +907,8 @@ static bool kvm_arm_vcpu_suspended(struct kvm_vcpu *vcpu)
>  /* Only the guest's CPU_ON may start a vCPU EL2 holds powered off. */
>  bool kvm_pkvm_vcpu_is_powered_off(struct kvm_vcpu *vcpu)
>  {
> -        return READ_ONCE(vcpu->arch.mp_state.mp_state) == KVM_MP_STATE_UNINITIALIZED;
> +        return vcpu_is_protected_pkvm(vcpu) &&
> +                READ_ONCE(vcpu->arch.mp_state.mp_state) == KVM_MP_STATE_UNINITIALIZED;

Only a pVM's vCPU can be in KVM_MP_STATE_UNINITIALIZED, so is this needed?

Cheers,
/fuad

[1] https://lore.kernel.org/all/86pkxs2npx.wl-maz@kernel.org/
