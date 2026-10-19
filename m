Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423999;
	b=d+TggoXYTlT+fRFyt34oABL/EXVB/C7ZlJq6SFJ8PhlaStCTLABLCRVhfGpWKM7l21Aq
	 Mw1xNktNUXzYo48RG49JZ3G57pDdi/yh0wIo+FBjUft3AH2HqbgkBFnXjdo/nkL1U9vm7
	 fTAFt8VAPsjv9VS0nsqKNCPur605o9FNYnV2J0Re7DMx8IPAoTsAz71rmW1pg4PDgT3BS
	 VjcvEImjo0a+l4DzjOVtidBturMgGtRxtzZkhH4KY+RmQSJ3OQl2btUUsMrCKaBxMXLK+
	 8flDLAm8K0xPyvSj3hGkaA3w0rorTQivcGcGYTFIA/1fkLHUFcXnsWV/7+ZWOEhOPbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423999;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=chgIyerIQUJ4MpBdj3CzM7sYFHniQ/ji6TFUETNF7sE=;
	b=z6rCXT6WKhIlFQrWgqENEIEIBTR63m1WccFYm+z4iFWAYfMKBiCsQLdNVqMP9cvOf23C
	 uj5cAb7AeurCaLLIw1QnQIbThu/VJBlAt03A4DM8+uvRgMDjdbTkmkb/S6B1tHrTQu1qd
	 2keJJS/+1fRvAQoiu2wIEOeVj2rRd0eiJ6qPzNcKeYMQwLJhkFlJ8go41J2un3mA1nIRU
	 BdFXb7Jo1n/pFngSNxoTyM93P9rFynogwpFl457lQhLj1gUHLOOAqUpbSkcBgt5O9cTGF
	 fYFmd+NSvA7L7aF6Jyaj4mFMhyaQXeWOR/fOEhA2nfhizDEFWpRhggaYqbcY/VWOhMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pLUGfr7o;
	arc=none smtp.remote-ip=95.215.58.232
Received: from mta1.migadu.com (out-232.mta1.migadu.com [95.215.58.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB360740A9
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 15:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DBB360740A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pLUGfr7o
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1U6BfBwCfq4V3+m41gJdoq8QfWpdRN+npCvu9W+LDfU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792423996; v=1; x=1793028796;
 b=pLUGfr7oRZbX4oqLyLg7KpxyMYl3j00MH9rAR/TSgHv1DhjMP5zV/T9G+i9QDU820IK18QQ2
 UGVq2MbDvI9qIfFz0hEX00GyVEFeiGpcwo8Kep1jJ625CHR7A1Re9StRqhUUmA+4lA9brS2gTj1
 c3MOarw3I4N/7tnUX7HmOygQ=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 739c1306116241c0;
	Mon, 19 Oct 2026 15:33:16 +0000
X-Mizu-Trace-ID: 739c1306116241c0
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be58ad9600so7331e87.0
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 08:33:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByN0R6b/NG6p40sVro0wN3W8i46LeSNMgp9XzF+LmmA0Ri9FaG9JzlLQEGdNLOgLPoDd0E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGhthE+bBFSTbw8oG8gxP+y9Ub4+sz9fKjkxF5CMPibZCmzF32
	wfIcPbz6Tcu6LMqdKsvD/WZBTYSQXhl9A10UJgoD3uGsD82VAwOwxi77I16n5MCMDripjTvMyu1
	2jUrZUSSXbAUlvuiz2gQhMCY7GL7/XGyGwuG0BxjQ
X-Received: by 2002:a05:6512:3096:b0:5b7:6707:e44c with SMTP id
 2adb3069b0e04-5be51d36f63mr209729e87.12.1792423991379; Mon, 19 Oct 2026
 08:33:11 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019134242.1289002-1-sascha.bischoff@arm.com> <20261019134242.1289002-2-sascha.bischoff@arm.com>
In-Reply-To: <20261019134242.1289002-2-sascha.bischoff@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 19 Oct 2026 16:32:34 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzqKiWr2tnV0rUiA4VVCs5a0E2XQQTdwvH0bTKZ5dxe5A@mail.gmail.com>
X-Gm-Features: AclHuK9YsVMfbpulg4gsG40qG2ygFeEoSjoGnDJEH8FVka3Piy823C8uPTVEmEs
Message-ID: <CA+EHjTzqKiWr2tnV0rUiA4VVCs5a0E2XQQTdwvH0bTKZ5dxe5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: arm64: vgic: Require matching VGIC model for
 GICv3 ITS
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, 
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hi Sascha,

On Mon, 19 Oct 2026 14:42:41 +0100, Sascha Bischoff
<sascha.bischoff@arm.com> wrote:
> On a GICv5 host with legacy support, KVM registers both VGICv3 and
> VGICv5 devices. Without a model check, a VM can create a GICv3 ITS
> alongside an incompatible VGIC, regardless of creation order.

Could you add to the commit message that the new checks apply on every
host? A GICv2 VGIC and an ITS, in either order, now fail with -ENODEV,
where before both were created and the ITS was ignored.

[...]
> diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
[...]
> @@ -42,10 +42,7 @@ bool vgic_has_its(struct kvm *kvm)
>  {
>          struct vgic_dist *dist = &kvm->arch.vgic;
>
> -        if (dist->vgic_model != KVM_DEV_TYPE_ARM_VGIC_V3)
> -                return false;
> -
> -        return dist->has_its;
> +        return !!dist->its_model;
>  }

I think this should check vgic_model as well, as Sashiko raised [1].
vgic_its_create() accepts an ITS when there's no in-kernel VGIC, and
the VM can then run with a userspace irqchip. On a GICv4.0 host,
kvm_vgic_flush_hwstate() then calls vgic_v4_commit() on every entry,
for a vPE that vgic_v4_init() never set up. irq_set_vcpu_affinity()
fails on irq 0 and the error is ignored, so nothing crashes, but this
patch makes that path reachable. The MSI paths Sashiko lists are fine,
since KVM_SIGNAL_MSI requires an in-kernel irqchip and irqfd an
initialised VGIC.

Something like this would keep the 0 == 0 case you pointed out for
Marc's version false:

        return dist->its_model && dist->its_model == dist->vgic_model;

Cheers,
/fuad

[1] https://lore.kernel.org/all/sashiko-outbox-177254@kernel.org/
