Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B332551FCC6
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651045; cv=pass; b=WN7b/kMOmZ1s5pRLg6NZoTbzxY6Rz+30pdNNtiFlO33NIjjvTj7ahJpSwQRWiqiPoD0/bEgzIh42nM/7SsdZhiLAwHt63Lg79CuTSYvRi5ctFHr3M4C1CMNaPGRLiWO9wzCpaAyBcq3ghxtyCFoZ9CtSdyQuieZFb3JyAMqW3rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651045; c=relaxed/simple;
	bh=kO4HLKikSv+g/tlkono8w2r9mfJw0DOnYzMEnSqFOZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HV9+yEI7cgtmZ8pYoqAyaf7BgM4E0ijBqTB4Kj3rJFJiXZ7xfaii46gCd+RZQZ542/v5N3y526h0Xl8NY7HIQvcPnOsQMUNph0KumDGZz7NR8EGhuNwcgaVtWHcUZicuHHDpXx7pXDbZtdInvAd9nBqUwTk5ivEcfzT1tl1JFY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q92k0f+6; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q92k0f+6"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b83c1421ecso1846e87.1
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 06:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789651041; cv=none;
        d=google.com; s=arc-20260327;
        b=qM3vDxtN9ZKgC9J589BdEFGpN0WqqkJJC2Fb+kCVpzqzSEkeI62R1++T0y9h51hJBL
         zmg+nXZgzvom5I6ojFzbAe6J8DiNf17bs0s2679dNissF0govZPkJLni/ZvkMcXQ/gVB
         xKsBYog/QEbHfux2IOo94bwbzv7BE+k90VbwxsWol1zUCbJlevqV8nRClLR9BdBfKsyD
         8Z0mvp+qgox9RHcbS3LWD8KduiVt8BGm00K4CeM/c7iraPO3+MPUtjMGBred8mpxUHtR
         v5b7HFPPcS7iCOkV0zE/IwmEJRYG9mZ6rIHX3bAqcPmZtxOklPV+d04N0YM9gSIHSffi
         w71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yvMJselGvAoMrhysUaGitx662yndDSgH+0mQM9lz22E=;
        fh=Ez8NpNZlYpJMs5FsbI2d5a16stCZJhW3aTDCQxMMJyU=;
        b=hajfgsDiU0UoJtnm+XZsh6Jwz/h4WjcXa0rDSAD0Q3cpZcWeqcgVrFYtTrns0Xl5Z8
         Ec992+xlcTv6CVnb4AqgYFQpShAFJIJO/lrgrMznB3Okv8LvLSTcnl4Ql5YEY+6NCgPe
         6TQYp091ACZ+E26F3U5r6jiN94pj4TZrKZbE3pgRRg0LK05RINB3fdnx4pQoOJw/RKbW
         XDgxmK8sNwwfyclHkS1JIVj2n2lCAbZpL0neIUjtLLFrIPf0H7UbkEOGFYoBdFHtTOXS
         KZPBbSlUYe/Zs49F9u7nmXJ6TmVgh3hnGCJgM8ol95pYCwCx153mm9d1uqmwEbi0sV1l
         sOEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789651041; x=1790255841; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yvMJselGvAoMrhysUaGitx662yndDSgH+0mQM9lz22E=;
        b=Q92k0f+670Kr1ZD6hDc/zvz5x+WOR9HSEoqtUUPLPtqzFfCxFDH0tmU7NOxFqW7B/o
         Eor5tntFJW/2CRZyFRxEgGiX89+lRWzz2dJ74I1GX/U0YAUTe08ouDjDS/DMeKl/I+hG
         jbE9zOd70fHWTtLJbTW7jAoj9GubzY4pLFtkQMf7ScZpT8fw/grb2Su4U5MUmoTJMfI/
         04F8xR8oAriYOmp4KwqbQjtXUBBQKR9UD1IIDZoxn+vhhE8xme6tDoOy/rW+jepL1LKZ
         itcZGaobZAbLsn7wdr2MkJGwoZU16ht2z1EiyGrhHJWx69vHpaYRjE5+rKtXPttRZMwg
         gamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651041; x=1790255841;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yvMJselGvAoMrhysUaGitx662yndDSgH+0mQM9lz22E=;
        b=N+3RrIxw9gAmBjANFTB9t/EiK32JzLYp//CYOVduW5ladIRSU7kcqwGUyJ1koGY2he
         KIHuMJhXwoQkvPgWhEJzSbp2o/ojZHFpiYhW1CldSdyG+IGrstSBUoeaA32Fk5HIvUkD
         EqkGOfLdjLAjrzJlpwGS+Nf6Y5vbTnIZux1ClLP+4X71gzg06cdhi4NOK5ONhgLWLJ85
         rqkghEs+gFAc9/RMUbhSbrLjlBcVOn9RWs6s+kZ019Vx/D8y82D08ZdHUYwNcWm1QCa6
         myTfOWLI8p6uIV5SfSetx/HU+DPgQlcs773XDnBdzOmwqfLHlRz1tOyZTMHZKj3yc+bz
         T87A==
X-Gm-Message-State: AFuF++nO916plgnkNS4OIdSQZASDwBpuAPFB8XzMXdpl7VdxbLik5bNC
	5hKKQqrp/MCPaxk9RasmTuVHnyjquatVmM6fm9bi4CXkBRhNsrFV55N4Kpvyi5GmXKnvlJcVYsN
	khAqcALFzbB+feiVih+kspDH97zQYLniNCAT6SK9Y
X-Gm-Gg: AYBFou3TiUAiO9omh5Agz50cnQF6dlFyvHX9yfE0CVvdChbJkMQfuT4DM53iBAE76Fk
	L5/xodkoSef8DGd95jFTYNo3ZnVe2ITlPhTXgG1ndyqn1qTU5zlHnvEAGRjRagMxoJRbRRFKQqA
	v1Ootf14BG8WYM4l80dgTYafKeJxecmCqsI/WwwZc+ccJ5B1Iygztio6GmVSp+pusS0A9RDhv88
	TcAwCN4rSXq82v6jEYhM80B/ldrqdEoYKQXN8pE9FM4gZjVMY4C2PbTiFH7fNrxT2jcKkvaaH1g
	GPsGuPzAcsSocaGxAFK+gSjFY6iIqrnnHFvHxmDhx50mmYO9SOMgQB5HKZvJyPnU/wAfwboDu9W
	oHJuRxm+Z/LcW5A==
X-Received: by 2002:ac2:4c50:0:b0:5b2:8963:e5d4 with SMTP id
 2adb3069b0e04-5b8bff1d051mr39681e87.5.1789651041084; Thu, 17 Sep 2026
 06:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915160141.3543048-1-suzuki.poulose@arm.com> <20260915160141.3543048-21-suzuki.poulose@arm.com>
In-Reply-To: <20260915160141.3543048-21-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 17 Sep 2026 14:16:44 +0100
X-Gm-Features: AcwNN1VtWWKyrr6h6sFHMUccgZH0Chs5OMidTNSOoiZ_fDx_6ZmQhtU1SR2DO2Y
Message-ID: <CA+EHjTwYqTFzGdNPproWW5L6j5pNqmuWeFuu9HbHa8LBLPvY2A@mail.gmail.com>
Subject: Re: [PATCH v18 20/23] KVM: arm64: CCA: Don't expose unsupported
 capabilities for realm guests
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

On Tue, 15 Sep 2026 17:01:38 +0100, Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
[...]
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
[...]
> +static inline bool kvm_realm_ext_allowed(long ext)
> +{
> +        switch (ext) {
> +        case KVM_CAP_ARM_PSCI:
> +        case KVM_CAP_ARM_PSCI_0_2:
> +        case KVM_CAP_NR_VCPUS:
> +        case KVM_CAP_MAX_VCPUS:
> +        case KVM_CAP_MAX_VCPU_ID:
> +        case KVM_CAP_MSI_DEVID:
> +        case KVM_CAP_ARM_VM_IPA_SIZE:
> +        case KVM_CAP_ARM_SVE:
> +        case KVM_CAP_ONE_REG:
> +        case KVM_CAP_ARM_PTRAUTH_ADDRESS:
> +        case KVM_CAP_ARM_PTRAUTH_GENERIC:
> +        case KVM_CAP_SYNC_MMU:
> +                return true;
> +        }
> +        return false;
> +}

I'd keep KVM_CAP_IRQCHIP in this list. api.rst has it advertising
KVM_IRQ_LINE as well as KVM_CREATE_IRQCHIP, so the cap means in-kernel
irqchip rather than GICv2, and the GICv2 case is already rejected by
patch 18 in kvm_vgic_create(). It also keeps the two protected lists
the same where the support is the same. And could this live in
kvm_rmi.h, next to where kvm_pkvm_ext_allowed() lives in kvm_pkvm.h,
rather than in arm.c?

[...]
> +static inline bool kvm_arch_vm_ioctl_allowed(struct kvm *kvm, unsigned int ioctl)
> +{
> +        long ext;
> +        int r;
> +
> +        r = kvm_get_cap_for_kvm_ioctl(ioctl, &ext);
> +        if (WARN_ON_ONCE(r < 0))
> +                return false;

You told Sashiko my fix covers this one [1], but that fix changes
kvm_pkvm_ioctl_allowed(), which this patch deletes, so the `if (r <
0)` has to go into this copy too. The guard you posted for the second
finding still leaves the WARN reachable on pKVM and Realm hosts, which
is the case the fix removed.

nit: kvm_arch_ is the prefix generic KVM uses for the hooks it calls
into the arch. For two static helpers in arm.c, kvm_vm_ext_allowed()
and kvm_vm_ioctl_allowed() would avoid the collision, and the same for
kvm_arch_vm_ext_allowed() above.

Cheers,
/fuad

[1] https://lore.kernel.org/all/20260914093838.1082637-1-fuad.tabba@linux.dev/
