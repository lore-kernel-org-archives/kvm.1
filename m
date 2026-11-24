Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509355;
	b=M7/lc8gUnmYjAwmH+TLSnNKRMCFif0EZcu9WSAAdfOIci/b74VyaB8SEk/TFInMmLIHa
	 tU5r4uqubNYXwD0uTYq+ZNxMFao4mHMYmBpZKrVHMc6YKEVy3bOtRigMpLy1guT69UeXe
	 sqA9qX/LsQzfs4Qsf+OjqIL4M76ZpD+t195ZjYu3FWOLHq+gC6DPiGeqCM7CGoKFvB2mp
	 aYAdtp8H1pEY/7UGoqRcRV/D6ppL8qtt5Agj4HYvkjZLOCywsLt9CtebqZWEFhj2XdPye
	 Slg6HZ2vFUvtmlZ/I2v4FQfmySObao30S1EIMX/m2MllHrTSzwwtBA2shiAM+exF55A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509355;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Y/9Z+Oxaa18zcAW8dXB36QsjKCZKOxK0vvzwf7T1dLM=;
	b=AHDhHwNzFhZg4UlTajFHxOgDwDqw0OAD9RZAx+4HR8DCwVHVj9nFymrhQOWsJBtN9p9c
	 Ie9CLHboEFdzhBwR7gs73rFLeGa70kSPUd3roWigiLujNTbiJ2CMqpKltM7jC+R8dtU8C
	 5OHLT2BpplOXxeKKHYNFszGvlLu0Hceue7nTd3KCk36UotvyKsMMn6xXUGEsiMQ9pwfls
	 LJHUXZYbmh+F1jIIm+HbkxWk+egla2su5EMOFi4IQgwsbAKXXC26WvOzOkAw9uttisfpd
	 oaANSLdlIzco08fvoI8F+fhclplOP6hBy68WewN3JA23wWdiedvJwUQLplK7vWN2q4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GjIn1OSR;
	arc=none smtp.remote-ip=95.215.58.69
Received: from mta1.migadu.com (out-69.mta1.migadu.com [95.215.58.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F08606A321
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 08:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31F08606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GjIn1OSR
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=frRhWONZHUb4W+PwfONUFPXQmHE/jfkhamJXvxAVQwE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795509353; v=1; x=1796114153;
 b=GjIn1OSRQIiv/fPRI6Bm5GWJLmBdmI1KitLf6XK9SsvBo8KevU3KfOOFe7oMA4Yh0I0/6T+9
 FfBI0pP1NXtpJf7EfMkItqzSXqPBVMdQ2AGuaPl6c228lmB9g4U8HQ4k+UW1xq3cMkQoouf4FsY
 c1hVqV2WIrcQuXIqGSDeN0UU=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ca6e55ca13d99348;
	Tue, 24 Nov 2026 08:35:53 +0000
X-Mizu-Trace-ID: ca6e55ca13d99348
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so20446e87.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 00:35:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH4K98hXFiimA4hPn1DcxJI693GS7Akn1mqcvvlgjKVkrn8drJFnvJsHyuSFiZ4HKEgat4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5hS6vIMD/fwwLk/XMMbvLb+Xjhh+x6AuXVM/Q3zl9QBnIGksV
	GSlg9EgBeNPfbn8FUMPss0bC/f/iK5sxFf4uGKUiSozu55MUftuUxQFi7PaSLhjcGpj0ohbY5+r
	cIlw56qXHkxjxWyj/BuvTQ4YfzVAWxr3GXCHCaF2Y
X-Received: by 2002:a05:6512:3ca7:b0:5bf:f060:c0f3 with SMTP id
 2adb3069b0e04-5c21a26fab2mr329358e87.12.1795509350390; Tue, 24 Nov 2026
 00:35:50 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123192457.8700-1-maz@kernel.org> <20261123192457.8700-2-maz@kernel.org>
In-Reply-To: <20261123192457.8700-2-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 24 Nov 2026 08:35:14 +0000
X-Gmail-Original-Message-ID: <CA+EHjTwsRNp+ThVP77L42OMV+CwMFMpRNzqAeKRjMHrpa1YLbQ@mail.gmail.com>
X-Gm-Features: Aa3M54rxabL4rIXwrzfAj-LSW2gkv_0xvrJLgjhQwGE1NK_mFU7OAUw9n46ykdw
Message-ID: <CA+EHjTwsRNp+ThVP77L42OMV+CwMFMpRNzqAeKRjMHrpa1YLbQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: arm64: Add enum support to idreg sanitisation
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Mon, 23 Nov 2026 19:24:55 +0000, Marc Zyngier <maz@kernel.org> wrote:
[...]
> diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
[...]
> +static struct resx compute_idreg_field_deps(struct kvm *kvm,
> +                                            const struct reg_bits_to_feat_map *map)
> +{
[...]
> +        for (tmp = map->idreg_field_deps; tmp->match; tmp++)
> +                if (tmp->match(kvm))
> +                        break;
> +
> +        resx.res0 = field_prep(map->bits, ~(tmp->bits));
> +        resx.res1 = field_prep(map->bits, tmp->bits);

Sashiko flagged the res0 line [1]. With the tables in patch 2 the loop
picks tmp at run time, and GCC 14 and clang 23 builds of config.c
don't trip the BUILD_BUG it describes.

nit: could you still compute res1 first and derive res0 from it, as
Sashiko suggests (res0 = map->bits & ~resx.res1)? That way
field_prep() is only passed values that fit the field, whatever the
compiler folds.

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

[1] https://lore.kernel.org/all/sashiko-outbox-229945@kernel.org/
