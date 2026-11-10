Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324219;
	b=qCVuqdMQMkKVzcYcs1KTiqdx8WmkzQwUBd6K1SSLyvXFAUhxgcu2psSKR4sSaDAYscc3
	 fWMQnwaixQIc0hBDL7dtkBgvkk11v8pvv5sSRDmGi4hA3tkdzfWTpDwISzKYN/njyDKh9
	 lyu4Rw/8AhWPWQb6Ub3I3+ZxgY/JjVwNJb8OoVWeVqgpHP8susuO+CFxNGJY6nGz+Qbwk
	 Zk3m2cVuf66pmuT2BmV7bt8PDlTKrMRGGYMBDGMcp4/yu6CQwZ117NS+qQi2gT8kXAb9a
	 mZFaWNPKj6tBF0zHJ0/V1hVAdVhfyhD55XLkAzEHbdNniWLPoa54NsRt8e+GeunOMdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324219;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=AOh92pz7pNtPA8t37ZC/m8LXet3xoQREEST4L5yuw5k=;
	b=YUFWkZsuTCChmjb5ueFY0C7EF+3TkYQ7E0xK8jojw5SWC9wsETd/GncWFr5+ClotIlGV
	 wpue0NUSCh8vdWr+t3aRDImwYuR4sCh1/6ldAtuOKiVqZHX2WhLsyXnuRqKc/uq1AuXyc
	 zF+sbqK+yn1uD0RNXWcQ3qaGio0Djl7x066l2PayqeQXMGzlFmp34J4VLJxvzyXfSzd9P
	 ppW3jIvqgxOLblXNvBWdGsTgVCMFcXZRHaA2v4/8qUh5o09QvRtrJbGp6lVyocD5o2A7I
	 kubzF0KZQZpZKZb8vqkV4iWjBnkEY5ht5SD44Z5hsPzqmbBDQWb8SmyFaulWU/KYrdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UAd9csSF;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB33606A320
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 15:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EB33606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UAd9csSF
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 797CA1477;
	Tue, 10 Nov 2026 07:23:35 -0800 (PST)
Received: from [10.0.154.42] (e121487-lin.cambridge.arm.com [10.0.154.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 263043F85F;
	Tue, 10 Nov 2026 07:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794324218; bh=8eRWx5xl+dtrtbPHc8F8PIViLNDW/+WoUO3pY3HV8uo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UAd9csSFPed6w+0P4eoVV5vwuC0d32+EiANPIBzr7kIxyCIlIyP4dTmPKwfpGczc2
	 +rmbxBC0A+1iWcYKjfH7Rgj7+2YorXVlvauUEVCzRPP10JE/agBU77XVJNfDIIGmWB
	 zuEDEsrnCgcWasKlNo5KFUDHVBqWN3ZPxA5hUY6U=
Message-ID: <6286fa85-fd00-44cb-b03e-87dae6a7107f@arm.com>
Date: Tue, 10 Nov 2026 15:23:35 +0000
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
Subject: Re: [PATCH kvmtool v4 12/23] arm64: Describe timer PPIs for GICv5
To: Sascha Bischoff <sascha.bischoff@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261102213413.4136118-1-sascha.bischoff@arm.com>
 <20261102213413.4136118-13-sascha.bischoff@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261102213413.4136118-13-sascha.bischoff@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 21:34, Sascha Bischoff wrote:
> GICv5 DT specifiers use absolute PPI numbers due to having separate
> namespaces for the different interrupt types. Keep the existing
> GICv2/v3 specifiers by subtracting the legacy PPI base for those
> irqchips.
> 
> Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  arm64/timer.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arm64/timer.c b/arm64/timer.c
> index 2ac6144f..01b9875c 100644
> --- a/arm64/timer.c
> +++ b/arm64/timer.c
> @@ -9,16 +9,18 @@ void timer__generate_fdt_nodes(void *fdt, struct kvm *kvm)
>  {
>  	const char compatible[] = "arm,armv8-timer\0arm,armv7-timer";
>  	u32 cpu_mask = gic__get_fdt_irq_cpumask(kvm);
> -	int irqs[5] = {13, 14, 11, 10, 12};
> +	const int irqs[5] = { 29, 30, 27, 26, 28 };
>  	int nr = ARRAY_SIZE(irqs);
>  	u32 irq_prop[nr * 3];
> +	u32 type = gic__get_ppi_fdt_type();
> +	int ppi_base = gic__get_ppi_base();
>  
>  	if (!kvm->cfg.arch.nested_virt)
>  		nr--;
>  
>  	for (int i = 0; i < nr; i++) {
> -		irq_prop[i * 3 + 0] = cpu_to_fdt32(GIC_FDT_IRQ_TYPE_PPI);
> -		irq_prop[i * 3 + 1] = cpu_to_fdt32(irqs[i]);
> +		irq_prop[i * 3 + 0] = cpu_to_fdt32(type);
> +		irq_prop[i * 3 + 1] = cpu_to_fdt32(irqs[i] - ppi_base);
>  		irq_prop[i * 3 + 2] = cpu_to_fdt32(cpu_mask | IRQ_TYPE_LEVEL_LOW);
>  	}
>  
> @@ -30,4 +32,3 @@ void timer__generate_fdt_nodes(void *fdt, struct kvm *kvm)
>  		_FDT(fdt_property_cell(fdt, "clock-frequency", kvm->cfg.arch.force_cntfrq));
>  	_FDT(fdt_end_node(fdt));
>  }
> -

Unintentional change?

> -- 2.34.1
> 


Otherwise,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

