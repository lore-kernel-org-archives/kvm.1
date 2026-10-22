Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693739;
	b=Icb2lkNivK5TcSuGw7WrET9yoaTj95KRbwp48oyhIkphTpWLVFt6mfMg5G6rFM1mOpzz
	 wCmR+mnxbf2l16Z+48f8qcvVDpelIrtbziMYftbofrX4/WS+SvdObjucvLvD3om5hAIxQ
	 o0fCoKT2zZF7OSEb/HGC/QDFL6XtPhy/WrVY5qJmrFAMB+VGSMQjw4aGTv137pY8DTcdF
	 mOQVTsSdZVyq/D8RiPi261NIpF68tk9YqmUZSfpUeNH+pM7yxHFinkKLfuctI956TVJ7a
	 XEWqpbPFJZqw6wJin2tJ2cXDtBvXotszapjdQd9EOEWbc6gGTFmrtcLwaRIUY84n5xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693739;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=f4pcoA9nQGiHGalq0OROLcmBR13f0e2VRwXmUp7izys=;
	b=geBtqjI0xOZgj/bXq1JjctX15+utmvQv1Pjdl7DOpoIYDwR2+VSwQ0SpvptfXrSEvCZK
	 B8qFdfynP/h/CVMj+Ln2odPOOWra15YCx+nqFgIYomRTicOdnTC4UAjIf6Jo9gY4ackIz
	 bQOm3h2y5DePWiv6NwvrAfRbM0Yb/Vpk8ftTxHYo3xAIsbM1pCF8Rx38lA2OpyLiqZ7UD
	 Ot9PqQ5WI5xuw4dy1eIBca89juBoKAHJ9UCfFCLdEm5hGogPaSfG7p83waxPhrMq2isCJ
	 rL8fhoceannZBIOAhuthB+QkC5Zo+fWSgOzFBirAwJCfVeZlugoaE6Y4Ow2OiK/3qbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=d4dKmAYP;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B510606A31A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 18:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B510606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=d4dKmAYP
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 890E41692;
	Thu, 22 Oct 2026 11:28:54 -0700 (PDT)
Received: from [10.57.76.220] (unknown [10.57.76.220])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC9923F7B4;
	Thu, 22 Oct 2026 11:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792693737; bh=kun4vjW3lFkClvQKsGmACc8or4uvwpYyY+ppKVRza+Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d4dKmAYPcUSumSMZQ+j7v2NTkfN8tOCBkRahw4SStQ0Net+HnMXCGjyY2pYokix9w
	 FUwHmCMg2e7sBp/jSLH6q0xXEoDjHXbB5iFDwljLE/ZoC4loiYy4vjZmy/WAGLEow+
	 2f9HqX2SrcYyduTFOH9Q5ueHme52kfMwckL0qEFg=
Message-ID: <a754d5cb-dc7f-49f9-a815-98efa3d57574@arm.com>
Date: Thu, 22 Oct 2026 19:28:53 +0100
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
Subject: Re: [PATCH kvmtool v3 08/21] arm64: Define GICv5 interrupt types
To: Sascha Bischoff <sascha.bischoff@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261016153939.913764-1-sascha.bischoff@arm.com>
 <20261016153939.913764-9-sascha.bischoff@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261016153939.913764-9-sascha.bischoff@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 16:39, Sascha Bischoff wrote:
> Define the PPI and SPI type values used by GICv5 interrupt specifiers,
> and the type-field shift used to construct a full GICv5 INTID for
> KVM's PMU IRQ attribute.
> 
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  arm64/include/kvm/gic.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arm64/include/kvm/gic.h b/arm64/include/kvm/gic.h
> index 991aa912..bef871be 100644
> --- a/arm64/include/kvm/gic.h
> +++ b/arm64/include/kvm/gic.h
> @@ -10,6 +10,10 @@
>  #define GIC_FDT_IRQ_TYPE_SPI		0
>  #define GIC_FDT_IRQ_TYPE_PPI		1
>  
> +#define GICV5_IRQ_TYPE_PPI		1
> +#define GICV5_IRQ_TYPE_SPI		3
> +#define GICV5_IRQ_TYPE_SHIFT		29
> +

Can we also add

#define GICV5_FDT_IRQ_TYPE_PPI          GICV5_IRQ_TYPE_PPI
#define GICV5_FDT_IRQ_TYPE_SPI          GICV5_IRQ_TYPE_SPI

since seeing both GIC_FDT_IRQ_... and GICV5_IRQ_... back to
back in FDT code is slightly confusing.

Cheers
Vladimir

>  #define GIC_FDT_IRQ_PPI_CPU_SHIFT	8
>  #define GIC_FDT_IRQ_PPI_CPU_MASK	(0xff << GIC_FDT_IRQ_PPI_CPU_SHIFT)
>  
> -- 2.34.1
> 

