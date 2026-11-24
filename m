Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511114;
	b=ykhkolmgChWkHOKPLY8R+G9rttAuubFp4B/oKoTNApGC8GBdSXp1C69zYEDY9BiiOvT9
	 ft/JPrZVrR50cV4s6vsmd3HztQy1rLVHlxDru+ahjijP5kNzIaV8bDk4kG3ed3OZtIxI3
	 3Eb1WW22vrVR+44l0cyAXuByAxungpPtW/gJ7hOvEtoXeAO4Gsn6S9o/DF65kMyJ+EOd5
	 HnI4UocVlMyiffxZlXIVd0tbzNYewbNjhQCnF5bEMplMYdd+dzx5YuXHQu2rJv6BeiGaj
	 tRkxP3ryNpzR18ozc8nckLZyzTfU6hwLLPRiqe7uG1bwM+ML2ZuQAEcfLdvgu78+i4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511114;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=H5EGPVwUvBTVCjnjKNK0pwP1iE/nYLH8FPXSomLTbJo=;
	b=vR2LrFy2e3l1GqCPuspHWqv8+oyoH5vzBA4+c9zCP6JvDpefCyIjKaWdYl7jsVVce9DP
	 oMKp8h7SbHIzWgWC1I6cCUkjqVQ3kqLmCuUDNyGLtzxsK63DAhy5Y3t6SR3dxqBMbHZBF
	 Ug9dXnfNcdIppr07WFzPKt4gw7DJwzB8YKsfyvD8K8EKCnLRbpjth4ov5t9VZsLBhF3Fk
	 bp+0Gz85KkXAzy7A6lCY+mkxK1qUevzQePVGqyzYrxWYRR94xOtJgJYUKIRFkjU6ybqX7
	 eCAIa8bKTQJvr7hRykMujLLFSEuKSWiiA9rsuxiURUuTcj3q8VQP0caNv6QJXlFZ74Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pzXozxLm;
	arc=none smtp.remote-ip=91.218.175.7
Received: from mta0.migadu.com (out-7.mta0.migadu.com [91.218.175.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7234D606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 09:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7234D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pzXozxLm
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xPij0k4CeHH9+SjKj41LaA/JfirxBcQilK4GNNYxiKg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795511108; v=1; x=1796115908;
 b=pzXozxLmhONCVD+K/9lgsvhPodMQnUBLFzNN+W0jx1o3IPSgff58r8ZRE4LpMeKKpZGHUDAf
 k/0FhN/PreX7b48b+b+uMIGwTLrYR5CiwOsxBMaoLRhqoUrmzw80tVY71kqmtXyvHTWyWgu2pR5
 aRknsdqYzFPxPjDsYqfiBx0A=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bf5091ee22c1dcf5;
	Tue, 24 Nov 2026 09:05:08 +0000
X-Mizu-Trace-ID: bf5091ee22c1dcf5
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5c00d7ac49dso15897e87.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 01:05:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGQFbyBi7pHYqN+TKm8bwmw2sCzEjTfWl24Ynh2Hm9xOHqJ0kKF2PTM/YKUO1svEYDm3M0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ND+v8k/lLMUCdvIzfjy1YRUiKFE889SAMWpiUVWNgjD2zDpzI
	DiwE8SKt/Im9Qy3Vect15JtW4dGSzI4KfLa2r/40LAvBAH9t5D+BAp9CcykTYulqy4teJnE9Ivo
	JnlJQLvctKbUpLc+xoR/U52P8bIysfstriGPu/vnR
X-Received: by 2002:a05:6512:1282:b0:5c1:a880:e5b9 with SMTP id
 2adb3069b0e04-5c1fbb1e9acmr380099e87.7.1795511106116; Tue, 24 Nov 2026
 01:05:06 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123192457.8700-1-maz@kernel.org> <20261123192457.8700-3-maz@kernel.org>
In-Reply-To: <20261123192457.8700-3-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 24 Nov 2026 09:05:00 +0000
X-Gmail-Original-Message-ID: <CA+EHjTyOc3K4vgMxONpCsQoE9sC7vGf2y1Fjjp0wCZuLUHx+RQ@mail.gmail.com>
X-Gm-Features: Aa3M54rju6I7eIYSuhEWlu6AZl7jQW3yTB9_OPRQWCxv1avPMlgvoBI00tGtVA0
Message-ID: <CA+EHjTyOc3K4vgMxONpCsQoE9sC7vGf2y1Fjjp0wCZuLUHx+RQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: arm64: Add GIC idregs sanitisation to common framework
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Mon, 23 Nov 2026 19:24:56 +0000, Marc Zyngier <maz@kernel.org> wrote:
> It takes no least than 3 ID registers to describe whether a GICv3 or
> GICv5 is supported. Define the sanitisation tables for the relevant
> fields and the set of relevant callbacks.

nit: s/no least than/no less than/

[...]
> diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
[...]
> +static bool feat_gicv3(struct kvm *kvm)
> +{
> +        return (irqchip_in_kernel(kvm) &&
> +                kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3);
> +}

nit: could this be irqchip_in_kernel(kvm) && vgic_is_v3(kvm), and
feat_gcie() use vgic_is_v5() the same way?

[...]
> +static const struct reg_bits_to_feat_map aa64pfr0_gicv3[] = {
> +        ENUM_FEAT(ID_AA64PFR0_EL1_GIC_IMP, feat_gicv3 ),
> +        ENUM_FEAT(ID_AA64PFR0_EL1_GIC_NI, NULL ),
> +};

nit: stray spaces before the closing parentheses.

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
