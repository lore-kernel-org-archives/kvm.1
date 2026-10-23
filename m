Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746535;
	b=qRaTvpoBGq3J2/NUajUEiIsGrOlAY++09NcsL2w09BY69kKVsEkKtZLSB80t9whF/+P/
	 inZ4Fo38XA5pQYO/frXc1jz2ztB8sbTjf3bZwAgp8mMPgZvXZEsd1I+nTYHyUIO5sIqJ+
	 IrNR9vWZ3qr5kIR8VGTeccBF5zLtxrfKXud/5L90IAtqtqbD7aV713qtWmaNCQdIL74up
	 ITooX/ujFIXDUqZWJaYLIrA3WV4Uoo49X4M1IeLDjbVMPwV9gpXGCsU009ha7Kk9vmIU/
	 G4s6p/KxZeh8TsOLIqvS5Ec5DjmIXCa5BTBERWlzUygpIRgWW0Ye+a7EI2WKdsdVITg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746535;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=aHdZ+oKwe6OINwv5V856+JzJxIwxr2tU0lqEBlQhC6Y=;
	b=EcRYUG1zQV2la/hTzxCgaExSgW63JPRhN49h/+Q/v3cQjx/EFQ1arrMMu2liZl/B2To3
	 EZ62sDWP+Q/tEGZmacWtU9+zBlP5GvGbDdXfyCxvz045VQgH+cIKikLeyZq0wlGJ3Jaxc
	 UzXVQnOPkeWhM76IPg/YhWyyGsvN84KtT1BYqC2BlZTj3BLnxaY99lbY3ZQaRwj7zdYlE
	 kHOEDx0Dr5DKqu1gxQBAN8lnqwVrZxNnDV544PxbkyLenBzt8RIbpC7KgY4G/0BXUOxzu
	 OldK8LKeaKfW8uQ2VjnFUIt0FK2NwMRl+BinqEwvvyF6QtGmw6L9EolkUuzVtkgs5zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q+CtonFs;
	arc=none smtp.remote-ip=95.215.58.173
Received: from mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318AF606A31F
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 09:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 318AF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q+CtonFs
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aHdZ+oKwe6OINwv5V856+JzJxIwxr2tU0lqEBlQhC6Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792746533; v=1; x=1793351333;
 b=q+CtonFsq/yIiM0skPBshBA4a0cnJyCmZl0ywNg+6KYtPzv9uEvbqzU/Ll8t936D8nT9edL0
 1WjdK2yc4ipdY2VCsy/llbY+ulHP/0tpzk7p3YimKgkK2fxaLD9OHjo04LWNeQ2ctN35L7VooYx
 ovGJ3X95vLsmNWIrn1K3+jTw=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 40fcee38385a36b9;
	Fri, 23 Oct 2026 09:08:53 +0000
X-Mizu-Trace-ID: 40fcee38385a36b9
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be58ad9600so6441e87.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 02:08:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz6tjRa9jGAoPgDr9/c98iMyFjHMJvtSMymAek0rZfRTAxOSFzl935D9p6uC6vKyeoSbis=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNG2/bBp8Zo+y244v2x47/daNYcVUQRkMWLhJKgTXSZ/pbzWJB
	s7Um/qDA+y833Rt3WJ13I8kHgDwTvBKE/ds9Hb9A0rC8KPQbmst6XlbjwJjkxxMoBwr0UuxhP3D
	IhKB5ooaejYLsZn7VF/Kt7kd5K/QW4m7of+1TQbMd
X-Received: by 2002:a05:6512:3f03:b0:5bf:a49c:ddde with SMTP id
 2adb3069b0e04-5bfb06b5140mr90492e87.10.1792746528071; Fri, 23 Oct 2026
 02:08:48 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023070110.1833446-1-fuad.tabba@linux.dev>
 <20261023070110.1833446-2-fuad.tabba@linux.dev> <86fqxwzul7.wl-maz@kernel.org>
In-Reply-To: <86fqxwzul7.wl-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 23 Oct 2026 10:08:11 +0100
X-Gmail-Original-Message-ID: <CA+EHjTw08SZC_3Uodt6ew6vXVH-doW-8G41fVCF-rmaKsv+0fQ@mail.gmail.com>
X-Gm-Features: AclHuK8By_xwbQyrvckEGFfA4cAUoxoiGOv41Z9xRvku379045c1KVkkaVcFF80
Message-ID: <CA+EHjTw08SZC_3Uodt6ew6vXVH-doW-8G41fVCF-rmaKsv+0fQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: arm64: Hide FEAT_LS64_ACCDATA from guests
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Fri, 23 Oct 2026 09:31:32 +0100, Marc Zyngier <maz@kernel.org> wrote:
[...]
> Why settle for the least capable option? Context switching ACCDATA_EL1
> is easy enough, can be gated on guest features, and avoid the
> userspace horror story.
>
> I'd rather see that.

Context switching it means accessing ACCDATA_EL1 at EL2, which traps
to EL3 unless SCR_EL3.ADEn is set. booting.rst doesn't require ADEn
today, and TF-A only sets it when built with ENABLE_FEAT_LS64_ACCDATA,
which defaults to off. On such a host, KVM traps to EL3 the first time
it switches ACCDATA_EL1 for a VM, and every VM has LS64_ACCDATA by
default. The cap leaves the register alone, and the fine-grained trap
takes priority over ADEn, so it works whatever ADEn is set to.

Should we keep the cap as the fix for stable, and post ACCDATA support
on top? If you agree, I'd rebase your patches 3, 4 and 8 from [1], add
a booting.rst requirement for ADEn and EnAS0, and lift the cap and the
compat.

Cheers,
/fuad

[1] https://lore.kernel.org/all/20240815125959.2097734-1-maz@kernel.org/
