Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E2446C4BF
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648575; cv=none; b=e0oBcRpI/kWogUxiIsCBfVqG3l7o/guwkm8aNPioiau2/NFnhaqltgbXh9VnG/sDfLlyoj4sLtSpyqVYthkMovGrHxXG5dRgLDwBUYEzNdtfiyxX/8wwjLfEy52AMY2nIdqJvhzKjIUnKLNQmp+r8PPXDLm3Wz4FpV2JSLy0y8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648575; c=relaxed/simple;
	bh=dEg/xk5pG1vBiItxvEEZyeqvpuox2nryklNQjghqD3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9hk84Fm0CajtWk4NvG/W+NZCVdu76alsnnmqBDoezwJ6pRQ1RTv+ycEUiqyzQUauLEilaXnXF/+DSYYpXA12UwNVn0nBu4qhuB1u4Hy/kTnjSvusNIeyGl7bklIufdKDavD1EkGo2v3yfyzu2mJ4pXaMzVg4qj8pLpm+DyrE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X+FGAmC6; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X+FGAmC6"
X-Forwarded-Encrypted: i=1; AHgh+RqAYQoZS/vYpE2bZXwlBsG2JK/HWG+X1ezk/bSyrkifJjfZNH4JsFtgFPusmiGPP1mgVGc=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784648571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fWBKtHpQs7Mjv5sBBU83pNN7Nd/6AUX8CaJlXFspUiY=;
	b=X+FGAmC6yqnf3mO1sbJG0nXKFmo6OoCk7JSWLaoOFdfkZraQlQpOzI165glRGjz5okJCl6
	3i2cQHhFiFRl9HHpatRNCNfN5cgowKzwCqtxvmUHVS9oXjxLhwlI8dnyGAsFE9kitwA4hL
	1I1Ssa6mDEQGvwGJJLbzMFY1AJFPUzU=
X-Gm-Message-State: AOJu0Yx3e0MfSKHjRlIVbonJ4UEiN49I6qAX1MPRfHyq6/HcXm2xnoxe
	NCPNgcTZrahFY4ViE9T7PLHJ/DixA9993qfShC0XSc5qq0qu/mWIZn/mzjTEZc5NfHgOvT+Jivi
	ucosI15d81uQGBcO2StMb2Kb89jUfxTxbC76rWipy
X-Received: by 2002:a05:622a:d0e:b0:51c:ca9:3d17 with SMTP id
 d75a77b69052e-52601f03537mr16476711cf.12.1784648547786; Tue, 21 Jul 2026
 08:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703154811.3355680-1-sascha.bischoff@arm.com> <20260703154811.3355680-37-sascha.bischoff@arm.com>
In-Reply-To: <20260703154811.3355680-37-sascha.bischoff@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 21 Jul 2026 16:42:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTybDSAgr44jXNFnssnYq_vVeuZ+1qORS8f4dtQgMzOZ5A@mail.gmail.com>
X-Gm-Features: AUfX_mxjsFrqC8Gpjv6b_a6EYXug8lYIGCF5p9ytlWNhOuKnl9fC4c65x8uK9Mc
Message-ID: <CA+EHjTybDSAgr44jXNFnssnYq_vVeuZ+1qORS8f4dtQgMzOZ5A@mail.gmail.com>
Subject: Re: [PATCH v3 36/40] KVM: arm64: gic-v5: Implement save/restore
 mechanisms for ISTs
To: Sascha Bischoff <Sascha.Bischoff@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, nd <nd@arm.com>, 
	"maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>, Joey Gouly <Joey.Gouly@arm.com>, 
	Suzuki Poulose <Suzuki.Poulose@arm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"peter.maydell@linaro.org" <peter.maydell@linaro.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	Timothy Hayes <Timothy.Hayes@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hi Sascha,

Two things about the new KVM_DEV_ARM_VGIC_GRP_IST interface. Both are
about the userspace ABI rather than the mechanism.

...

> +int vgic_v5_save_spi_ist(struct kvm *kvm, struct kvm_device_attr *attr)
> +{
> +    u32 __user *uaddr = (u32 __user *)(unsigned long)attr->addr;
...
> +    for (unsigned int i = 0; i < kvm->arch.vgic.nr_spis; ++i) {
...
> +        __le32 *h_iste_addr = ist.base + i * ist.iste_size;
> +
> +        h_iste = READ_ONCE(*h_iste_addr);
> +        ret = put_user(h_iste, uaddr);
> +        if (ret)
> +            return ret;
> +
> +        uaddr++;
> +    }

The kernel writes nr_spis * 4 bytes into attr->addr, but struct
kvm_device_attr has no length field, so userspace has no way to
declare how large its buffer is and the kernel has no way to check it.
The size is implied by nr_spis, which userspace set earlier through
KVM_DEV_ARM_VGIC_GRP_NR_IRQS, or never set, in which case it defaulted
to 32.

put_user() has no idea how large the caller's buffer is. It only fails
if the address itself is not writable, so writes past the end of a
short buffer land in whatever happens to be next, with no error
reported. The documentation states the required size, but nothing
enforces it.

It is also the only variable length buffer in the VGICv5 interface.
GRP_IRS_REGS is a __u64, USERSPACE_PPIS is a __u64[2], GRP_NR_IRQS is
a __u32, and none of those can be got wrong.

kvm_device_attr itself is fixed, so no length can be added there.
Changing what addr points at is still possible while this is unmerged,
but would not be afterwards. Would it make sense for addr to point at
a small structure carrying an explicit size, so that the kernel can
reject a mismatch?

The second point is the LPI IST going into guest memory. I understand
from the commit message that the shadowing is deliberate and that the
guest has already allocated the storage, so this is about the
interface rather than that decision.

Saving the ISTs is a KVM_GET_DEVICE_ATTR, and it writes into guest
memory. Several of the documented ordering constraints are enforced,
with -EBUSY when the VGIC is not initialised or when a restore is
attempted after the VM has run. This one cannot be, because it is
about when the VMM serialises guest memory:

> These two steps may be performed in either order. However, the guest memory
> must be serialised after the ISTs have been saved, as saving the LPI IST writes
> the IST state back into guest memory.

A VMM that snapshots guest memory before saving the ISTs gets no
error, and the IST contents simply never reach the destination. Live
migration looks fine to me, since kvm_write_guest() marks the pages
dirty and a later pass picks them up, but a stop and copy save done in
the natural order would lose them silently.

Was a userspace buffer considered for the LPI IST as well, the way the
SPI IST already works? That would remove the ordering requirement
entirely, and by my reading the worst case is 65536 entries at 32
bits, so 256 KiB, given the 16 bit clamp on the guest's LPI ID bits.

Cheers,
/fuad
