Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713763;
	b=gDLaTX59NHz2ElBhyH/fUm26jzZDLS3jb9U68d23YZU6riMV2e49i9ozep2bjIOR+uaC
	 eAgedflkzMXE//7GHa6rSWzoilK/QgLFzLX6Yhj7sxSp5w/fiB6q/eD+mSV/2UZW0DgGt
	 1brL7FWNZau29JY5jKa9an5LC5PWTXBPTEOKzJXAqk/HoE86aRPgnUnohOjqdoNTjmOJr
	 IfxVc9m/XcNBtsouB7ktPq0pfrzTKH97b0Kue4RjKaQoJwCTl+UAHFAe7xjRyDVSc+AOg
	 rcbJUn/VWEEI7ilyx9CSiMLtYxBMqW271MRu/I5eR4fCMV0nMVnHzji2/V8womyWHPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713763;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Vj7nnf3+hX6pDD4kkVdX7ATUkAs5lwT8YtIid3wScRU=;
	b=QSydo86ufcM7uQUjBkp9AaCsdPPqGfFi4o1UMV19LyVCLpH8E5WI/7yo7ztorL5YP2qA
	 FUxtHq8KPYjLKrLoE+aqiKnRBSN7BhiaE1VWmXj2dMh2Cfmzp+Xz3TJ+mZ4TpGV0KXDX/
	 TunGhAxIlAUFmBSjDHBUvb+Xgsbl+juXVE9Nxv+ZMiqKS0jHXL3IjPQk5vhGWfY39uXMD
	 Iv62SOc064w1aFSkCDKvJ7UkQ83aAT5bVDS5j+Jb54BoJWyJfYSyk/tt79fj8bpbFFiNI
	 4T6YCzb3CJ80oOUOxfz5z4ojtjR5/HTL+TSBjMiip88aQix60ma1pH3GE/CezbcEOww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=r7JWYG3c;
	arc=none smtp.remote-ip=91.218.175.232
Received: from mta0.migadu.com (out-232.mta0.migadu.com [91.218.175.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDA3606A329
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 13:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EDA3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=r7JWYG3c
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lJFSAvh/s8cWO+ylQ8b65jdqU55xiRLoOy5tUADRJVg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793713760; v=1; x=1794318560;
 b=r7JWYG3c7BIrxkAljVzNY1DrJacPoGeZT55URSD98a4Ue5l68T5oJX0XieZbwiizBRRluoeX
 TP35iDJf9wLFVVoHJq6HIpaZNq3yzdbLoM7RzfYVs3LZZXrhktTG/riU6eIXDoOxuuwiknAdBU5
 j7iOZT67AC1JegSFAkrrFtuM=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 36182067f2dee993;
	Tue, 03 Nov 2026 13:49:20 +0000
X-Mizu-Trace-ID: 36182067f2dee993
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be58ad9600so7390e87.0
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 05:49:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBznygdHUHA4BrOp+sWYpvqeVM0jh7TTyPL5XpgM8KrM1mRYfMNf8LqiH3cXp2/pcYsN9Uw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9IEv2PDm3wg+yCsf/X5/cq5MltLceEW1IKQL2r6sM1nRhPwn0u
	wySdeLnqsDen5zwnq1YImnmbofp+lbvtjDvm0MgRGtjHsdbmjlV14cjWyBelZIGVr0IpTLJxLbO
	OwfLXrax7rk3FcZq6X8HEEVMAo7XgnTvhdmTESgj1
X-Received: by 2002:a05:6512:4013:b0:5be:b32e:c309 with SMTP id
 2adb3069b0e04-5bff0f075b2mr105344e87.13.1793713759125; Tue, 03 Nov 2026
 05:49:19 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102194454.4086911-1-sascha.bischoff@arm.com> <20261102194454.4086911-7-sascha.bischoff@arm.com>
In-Reply-To: <20261102194454.4086911-7-sascha.bischoff@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 3 Nov 2026 13:48:42 +0000
X-Gmail-Original-Message-ID: <CA+EHjTwWFobMXrVcm2iFhWXoWfudk6dGL8ed5mCs7u9LTsTpKQ@mail.gmail.com>
X-Gm-Features: AclHuK9t40SuunANo3L6wQKi_X9nYoI88mdBFeXlfd2RawDyjQ21UrVXIFQXO9Y
Message-ID: <CA+EHjTwWFobMXrVcm2iFhWXoWfudk6dGL8ed5mCs7u9LTsTpKQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] KVM: arm64: gic-v5: Add ITS MMIO state emulation
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	peter.maydell@linaro.org, lpieralisi@kernel.org, timothy.hayes@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 02 Nov 2026 19:44:44 +0000, Sascha Bischoff
<sascha.bischoff@arm.com> wrote:
[...]
> diff --git a/arch/arm64/kvm/vgic/vgic-its-v5.c b/arch/arm64/kvm/vgic/vgic-its-v5.c
[...]
> +static void vgic_v5_its_reset(struct vgic_v5_its *its)
> +{
[...]
> +        its->idr1.dt_levels = 1;
> +        its->idr1.itt_levels = 1;
> +        its->idr1.l2sz = 0;

L2SZ 0 is reserved in the spec when either LEVELS bit is set. Could
this advertise 0b111, as the spec recommends? (Sashiko [1])

Thanks!
/fuad

[1] https://lore.kernel.org/all/sashiko-outbox-194056@kernel.org/
