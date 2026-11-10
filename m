Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323022;
	b=g2sbYYFPfgGBSqsSlAeJ47XIubEZJtYCA4GwoO4NuckTsoPPqyoFaDIfiwZUB9JnO3go
	 1XfwMb7um46Gp/3rsabv1SfdmL5oq9vlS6wQXINrxNNnwQPJjwUpKTyRpCF3bmA97Pd7p
	 78h8zNOCLA0sS74DzvVcaL/CuX6tQGeuEJI8qu13AMcXZPzgCv7mfr8tCrkCL74hXQUpd
	 zD9o45F4ZJoSq8aFHnGin/cpvmLfkPHTdoZuJpQ1HAdu5ZS4ZmB8V8zHoTommSJwZTLee
	 Q6E0TNqx+5NncGOL5xHKX7uDjOgCyZzYdLnm16zr2YscJmDgiUsVnnkkPf4rJjjhn1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323022;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=AMHbmw6AVtBrgvvIHxlDgD7+QXqZ2+qmHiJeu2jXxSY=;
	b=wwbDg/oyWExh9uptEpAXncex3oZRHqySxilwCAqMztjUVmAzA5om7C6dOiEF5ZF5Fb7g
	 7sTdxt0EYGPM4E6HePrXcxWODf1c1Y8HCsuolm7I2gxN7Ltjue6ae6qp+9ol2sj5qra1Q
	 2ziiDI7hMVF0CdJNZcrc9bSXr7Aed1dwtCeyOXMmN3u+KkHH0l4s4nCy1CC8fYGQfltEV
	 miQ8Jz2XOj6A0u+XuMaL+G2OBWvGfvCw9slVgFbLL/fVAKrafmnfE+n99r+bGEL0vMZkD
	 nkVNW/7SpM2BZTrZTzl05ang0wLtGCRnoD4/zo7nix4g6YYUt4Fc17vknK6/GfpiA8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BDXHlq7q;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8CD60A6F6F
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 15:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C8CD60A6F6F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BDXHlq7q
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE1241477;
	Tue, 10 Nov 2026 07:03:37 -0800 (PST)
Received: from [10.0.154.42] (e121487-lin.cambridge.arm.com [10.0.154.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E02513F85F;
	Tue, 10 Nov 2026 07:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794323020; bh=+CQQvJipOP4J7j27DlWXVN4Zz15AKszvwAXw7sWPqqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BDXHlq7qHdvVgaQ+ZYR6KGBROFyuL2TyBQrmoKdgJlTeP0i7eK/iLWAM2u1/aPBag
	 LbKPKIvrlwQa5RRvqTVytxn+T1nLmidWPm3TyDP+jXHyV9vNGDmCqSkLrlzWpc4b6x
	 s707A2RQDdfvks31yuTOBwqUr+Gd6ZU6Bikjmhw0=
Message-ID: <29794754-0152-4820-b457-33aea6a8cda2@arm.com>
Date: Tue, 10 Nov 2026 15:03:36 +0000
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
Subject: Re: [PATCH kvmtool v4 06/23] arm64: Configure GIC interrupt bases
To: Sascha Bischoff <sascha.bischoff@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261102213413.4136118-1-sascha.bischoff@arm.com>
 <20261102213413.4136118-7-sascha.bischoff@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261102213413.4136118-7-sascha.bischoff@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 21:33, Sascha Bischoff wrote:
> Record the SPI and PPI bases for the selected irqchip and expose getters
> to code that does not receive the irqchip type. Configure the bases
> after the GIC device and MSI frame have been created.
> 
> Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  arm64/gic.c             | 48 +++++++++++++++++++++++++++++++++++++++++
>  arm64/include/kvm/gic.h |  4 ++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/arm64/gic.c b/arm64/gic.c
> index 51a32159..df5689a7 100644
> --- a/arm64/gic.c
> +++ b/arm64/gic.c
> @@ -21,6 +21,18 @@ static u64 gic_redists_size;
>  static u64 gic_msi_base;
>  static u64 gic_msi_size = 0;
>  static bool vgic_is_init = false;
> +static int gic_spi_base = GIC_SPI_IRQ_BASE;
> +static int gic_ppi_base = GIC_PPI_IRQ_BASE;
> +
> +int gic__get_spi_base(void)
> +{
> +	return gic_spi_base;
> +}
> +
> +int gic__get_ppi_base(void)
> +{
> +	return gic_ppi_base;
> +}
>  
>  struct kvm_irqfd_line {
>  	unsigned int		gsi;
> @@ -211,6 +223,34 @@ static int gic__set_dist(enum irqchip_type type)
>  	}
>  }
>  
> +static int gic__set_spi(enum irqchip_type type)
> +{
> +	switch (type) {
> +	case IRQCHIP_GICV5:
> +		gic_spi_base = GICV5_SPI_IRQ_BASE;
> +		break;
> +	default:
> +		gic_spi_base = GIC_SPI_IRQ_BASE;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int gic__set_ppi(enum irqchip_type type)
> +{
> +	switch (type) {
> +	case IRQCHIP_GICV5:
> +		gic_ppi_base = GICV5_PPI_IRQ_BASE;
> +		break;
> +	default:
> +		gic_ppi_base = GIC_PPI_IRQ_BASE;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
>  {
>  	int err;
> @@ -256,6 +296,14 @@ static int gic__create_device(struct kvm *kvm, enum irqchip_type type)
>  	if (err)
>  		goto out_err;
>  
> +	err = gic__set_spi(type);
> +	if (err)
> +		goto out_err;
> +
> +	err = gic__set_ppi(type);
> +	if (err)
> +		goto out_err;
> +
>  	return 0;
>  
>  out_err:
> diff --git a/arm64/include/kvm/gic.h b/arm64/include/kvm/gic.h
> index 630f0bbd..c4f78cde 100644
> --- a/arm64/include/kvm/gic.h
> +++ b/arm64/include/kvm/gic.h
> @@ -4,6 +4,8 @@
>  #define GIC_SGI_IRQ_BASE		0
>  #define GIC_PPI_IRQ_BASE		16
>  #define GIC_SPI_IRQ_BASE		32
> +#define GICV5_PPI_IRQ_BASE		0
> +#define GICV5_SPI_IRQ_BASE		0
>  
>  #define GIC_FDT_IRQ_NUM_CELLS		3
>  
> @@ -34,6 +36,8 @@ enum irqchip_type {
>  
>  struct kvm;
>  
> +int gic__get_spi_base(void);
> +int gic__get_ppi_base(void);
>  int gic__alloc_irqnum(void);
>  int gic__create(struct kvm *kvm, enum irqchip_type type);
>  int gic__create_gicv2m_frame(struct kvm *kvm, u64 msi_frame_addr);
> -- 2.34.1
> 

FWIW

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

