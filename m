Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324380;
	b=Sszehr/CJbz0b1rlrd/cFhoDQTDih1NxPrj713vXD3SfcvRVOY0jf59JbQbKLSfaJdiz
	 GHsZCdZyRd64Rg3o533gQwWIu5HDEBDNZg3SkgOtH0tF8h4k6xwVjg1yY0DVhJ3k4qoh9
	 stjuvaY4GztcyzXe+Bz4akxPYLWaoMhy3+7uGvyQ4lQwwJWfGI0r+7wdD6viiWJr0RVTO
	 84yQF+Jxb6Kbozv4tY+bVhdDb/wn21VugkmejSeW3BJMZHUows6uiKmgodBXGeWhPIBCM
	 y9oZebj3nuCvcYwo1E6oJRbCVkE5jQKK8aptBDmxePFWrPaOgvt+zGCF8l+tF6gKTdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324380;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=lMmqS7htx60skcDHbDZ9zCMv9pZXltSqU5UHaOSfJBY=;
	b=NSaIlIHuc1HpMpR9JXqwWtkdTnmQRoDCZMfFmUmPmnJ1kKXv+uFz1dDdPp88fGoOFNjF
	 7RxF6AOAbZjFjRfUDkJT8slh9w3SOlfAP/6OU7h+8+/g1sClEjSU45ltWdzh3Dm6Ekbuw
	 X+hPMKkbyiByugGgUH7aFoTmCAdqgAfA4gNodRiH4Y28MrvtRQP6k6xEFunDD/V3poNF8
	 b0rOdC8M7mIO1zDjOMsBvqNKJkOO/Bm6z/DCisSKMcwrP9aKMen6ORjBbzQ7svv6WjgHi
	 5IWfisPle7T/XJB+uK5sq5gX7at/uKx1VNvbZswNYQWScFnQ4fmUwtqK6HlZ3zozr2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AElGW1IF;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C3D606A321
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 15:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8C3D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AElGW1IF
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C8C51477;
	Tue, 10 Nov 2026 07:26:15 -0800 (PST)
Received: from [10.0.154.42] (e121487-lin.cambridge.arm.com [10.0.154.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D38123F85F;
	Tue, 10 Nov 2026 07:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794324378; bh=9omS4cAyHDEiJO/BU9pzgf/vidotnQ3dAM4+2D6/BDY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AElGW1IF+umgeoplFKYai3XezO8C2CiBk3b3dPfieSsBOgTGP1TrtV06sT7GwK2ra
	 0fJBPMFtWzMbTpbrxXZmOxB3lXsxitN+HlRCLzc+Wrhud/ltmFL9d7CPt0RynOfUh2
	 rwyHkEK3z102FnfnZa5bJGnJZlDKl13yaAjrcWsg=
Message-ID: <d3575aea-2b86-4f97-b0f9-138c685112b3@arm.com>
Date: Tue, 10 Nov 2026 15:26:14 +0000
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
Subject: Re: [PATCH kvmtool v4 16/23] arm64: Generate GICv5 SPI specifiers for
 platform devices
To: Sascha Bischoff <sascha.bischoff@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261102213413.4136118-1-sascha.bischoff@arm.com>
 <20261102213413.4136118-17-sascha.bischoff@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261102213413.4136118-17-sascha.bischoff@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 21:34, Sascha Bischoff wrote:
> Use the GICv5 interrupt type and absolute SPI number for platform
> devices. Preserve the legacy GICv2/v3 DT encoding for other VMs.
> 
> Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  arm64/fdt.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arm64/fdt.c b/arm64/fdt.c
> index 5413956d..e92ae044 100644
> --- a/arm64/fdt.c
> +++ b/arm64/fdt.c
> @@ -63,11 +63,13 @@ static void generate_cpu_nodes(void *fdt, struct kvm *kvm)
>  
>  static void generate_irq_prop(void *fdt, u8 irq, enum irq_type irq_type)
>  {
> -	u32 irq_prop[] = {
> -		cpu_to_fdt32(GIC_FDT_IRQ_TYPE_SPI),
> -		cpu_to_fdt32(irq - GIC_SPI_IRQ_BASE),
> -		cpu_to_fdt32(irq_type)
> -	};
> +	u32 irq_prop[3];
> +	u32 type = gic__get_spi_fdt_type();
> +	u32 intid = irq - gic__get_spi_base();
> +
> +	irq_prop[0] = cpu_to_fdt32(type);
> +	irq_prop[1] = cpu_to_fdt32(intid);
> +	irq_prop[2] = cpu_to_fdt32(irq_type);
>  
>  	_FDT(fdt_property(fdt, "interrupts", irq_prop, sizeof(irq_prop)));
>  }
> -- 2.34.1
> 

FWIW

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

