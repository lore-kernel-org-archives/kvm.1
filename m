Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578936;
	b=dTC4XsJ/foaLImkAUSO6bKyIwGsUleJW+rKmkI/MsCCKemA1zD+328keD4xeClqAlaKs
	 3ANaydBXBhoftfo8K/wDXPCh8uJHtXwsfr1odxh14B2bAD3rKhqtNw6GAwRT6wgbapqgo
	 Qfy/nLmegNjJrf/0Iy054U4t5i2Yc9hYB6DY+MB2X2ro14A2UIXcPqYjzZ9twqcLn5AO3
	 W0sVP0//PzTxb3Z8aeAAWtln00mVdwNKp75zsWXRZi62evxxguA2v2TT7QjbtlkpoqGbL
	 LPmQFLa/k+kqNWB4XGhF+IUx0htd7fmPSm4B2fQ9E4RfwzF0HMYxPyg/jiSAnaac2FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578936;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=hPLzdvCJGykwL2y3rICFM79srKCNKSx/p5qwSLEhJPE=;
	b=uGSF0OXC32bNHq9jECUu98BlTF7gR3eSjRwR29oB/3i88N024Fxsw8LorWhf5q9tZwZs
	 fvhmFz6jxjZ4v5+f1Jr7l2EFsWPStRWC+qvPJLOeQOQatDxVtkOjHO9WUbLn6q0iT2y/d
	 GevFQryoXJYKs5ofecXUPdwoWMNqJB2iDCIJK9QhDFsODuuoRrqvkQfU3UM/7mE6XHPyy
	 IsWrEsy9z+IM4vNmYw8gUHGZoX6V2EvNUPTV6V3TpVQJdwbyn5xAfMkXn86qeZWARVTY7
	 XYuAhnTewP3BFrV1MPyK4wa1Uc7JI10tL19BA9bTmb0+W4VIzV+16KBjMHhYr4DZstg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bmO+naBc;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EF4606A31E
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 10:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79EF4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bmO+naBc
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 932852720;
	Wed, 21 Oct 2026 03:35:31 -0700 (PDT)
Received: from [10.0.152.204] (e121487-lin.cambridge.arm.com [10.0.152.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BC9D3F7D8;
	Wed, 21 Oct 2026 03:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792578934; bh=vyNBvJ+nnDRHCk/KoMeZ8Wpl4kv4Vz/nK8psg4EsgBg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bmO+naBcBKw3zU725Z1Gucdtz2ZDwDtYZQU5hakq6JAP6iEPFM11mfHNrZIjlqnQ1
	 NxUwX1/D1+Mzr6Bf9TFAofwHnXGmZsyiG8kXXiHmowl7PxNv/6XkxXprtu8BwktIrD
	 qfOcDw24Z3L1R2Orye15l6EZUsied80vCKXM4OY4=
Message-ID: <8658049d-fdd3-49a5-9b8e-acf3c3467c1d@arm.com>
Date: Wed, 21 Oct 2026 11:35:31 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvmtool v3 00/21] arm64: Support GICv5-based guests
To: Sascha Bischoff <sascha.bischoff@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261016153939.913764-1-sascha.bischoff@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261016153939.913764-1-sascha.bischoff@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sascha,

On 10/16/26 16:39, Sascha Bischoff wrote:
> This series adds support for GICv5-based VMs to kvmtool. These are
> exposed as --irqchip=gicv5 and --irqchip=gicv5-its, where the former
> only creates a vGICv5 device and the latter adds in a GICv5 ITS. The
> GICv5 specification can be found at [1].
> 
> The GICv5 support in KVM needed by --irqchip=gicv5 is expected to
> land in Linux v7.4. KVM support for GICv5 ITS has yet to be posted,
> but should follow shortly. Thus, --irqchip=gicv5 works with the
> corresponding KVM changes, while --irqchip=gicv5-its cannot yet be
> used with upstream KVM.
> 

I successfully booted a Linux guest on GICv5 FVP (with FEAT_GCIE_LEGACY)
using both --irqchip=gicv5 and --irqchip=gicv3. I also used this series
to boot a Linux guest on GICv3 FVP with kvmtool's automatic irqchip selection.
Everything worked fine.

FWIW, feel free to add

Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>

for non-ITS parts.

Since --irqchip=gicv5 already provides a usable Linux guest and is
aligned with upstream vGICv5 support, it would be nice to get these
parts merged sooner (which would also reduce the series to just ITS
support). So I'll do my best to review non-ITS bits.

Cheers
Vladimir

