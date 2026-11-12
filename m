Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495378;
	b=EB+n/2dnB3K3MyVn+x1584aiFY/MzNNeRVfRgLtKECFcg9nLosoUwOiD2N7lXRVgM0fA
	 SOt1bJDqjUHpwZhSPK3vwNlPBlDpmNeaMPjoETIFeouYJsC5TbNwDJXmsWb3fDn55aOUO
	 Nk3CQiPeEyf22FiUEXmG889quC54/x7RLEInwewv2wqF6BE3PRrMHy55uXItkfVJN+/Cq
	 uePWaYepVYTea0jfK5IOrTLz8xFlW1LgngAsITS8rPpeX08OpAFP9wrCKnf/gLhAE/Mix
	 P+pzGfveTNpyqmw2e6xhL3TMrDs3olooILUDrkoigbrUx7kxMdcCWZYQUXiFNd7zHlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495378;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=drI7YW+rbAkwIm9rmABdE7AZY9M1Yv27P1SFsyoqhTc=;
	b=AslB9wV3O/YepHcYNxRO+Y7OGBvOvFoUCp1eUibC08BDY6cCBXKWJmzkPys6lC/UisJr
	 Q/CDcpuRJX/r4JV6xNTZedLPl52UivumV8hTR4GsUVXXAuxX7hupalhPNJxoHKdmiw/hA
	 xAGGH53jJvuZkS8LyegrhkTM72UI9WKWdibkcNsiMc9opvw9mqb+sND8Q9wYI0E2M64Fj
	 EsgzyZ96ffQ1RITDAdm6RdifqR/Yko4BGigfRxLNywzavgchghpGZaxPWqQuanXI7wcQc
	 Gu1AoOfkdh8p4VDhBI0jRO+xjfiVIMLyUNeWp9VOmwQ2iNEMXZxLkmiQCV6Q9MhYIPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jZZCfzVi;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC0E606A323
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 14:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBC0E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jZZCfzVi
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20AA51516;
	Thu, 12 Nov 2026 06:56:14 -0800 (PST)
Received: from [10.0.154.42] (e121487-lin.cambridge.arm.com [10.0.154.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCE3D3F673;
	Thu, 12 Nov 2026 06:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794495377; bh=2E5xPrkVQecMRwgFADD/aTvAregKoAzz/VQIgok24e4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jZZCfzViCB5DuE0S7PxmAdRmg9ytAGB46AtA0nswFBE2nOmrSpjkRCQ0Kq+2jOcLn
	 6gWUfaQEPveh3+w06R7vxLAGGi3Qr/7Sca5WhSV+dyYQe5cgxKLnCSFwQKSTLi8ci9
	 T2Vz3k8ddR3tOJax3EUM3Ik67wcpEMRApaGwWQMo=
Message-ID: <195b1140-c997-4d18-80a0-a0f4ed918606@arm.com>
Date: Thu, 12 Nov 2026 14:56:14 +0000
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
Subject: Re: [PATCH kvmtool v4 22/23] arm64: Map PCI MSI requester IDs to the
 GICv5 ITS
To: Sascha Bischoff <sascha.bischoff@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261102213413.4136118-1-sascha.bischoff@arm.com>
 <20261102213413.4136118-23-sascha.bischoff@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261102213413.4136118-23-sascha.bischoff@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 21:34, Sascha Bischoff wrote:
> The GICv5 ITS MSI controller requires one MSI cell carrying the
> DeviceID. Describe an identity mapping from the 16-bit PCI requester
> ID to the ITS DeviceID with msi-map. Keep the existing msi-parent
> property for GICv2m and GICv3 ITS.
> 
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  arm64/pci.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arm64/pci.c b/arm64/pci.c
> index 91265f67..69aca4d0 100644
> --- a/arm64/pci.c
> +++ b/arm64/pci.c
> @@ -32,6 +32,12 @@ void pci__generate_fdt_nodes(void *fdt, struct kvm *kvm)
>  	unsigned nentries = 0;
>  	/* Bus range */
>  	u32 bus_range[] = { cpu_to_fdt32(0), cpu_to_fdt32(0), };
> +	u32 msi_map[] = {
> +		cpu_to_fdt32(0),
> +		cpu_to_fdt32(PHANDLE_MSI),
> +		cpu_to_fdt32(0),
> +		cpu_to_fdt32(0x10000),
> +	};
>  	/* Configuration Space */
>  	u64 cfg_reg_prop[] = { cpu_to_fdt64(KVM_PCI_CFG_AREA),
>  			       cpu_to_fdt64(ARM_PCI_CFG_SIZE), };
> @@ -70,7 +76,9 @@ void pci__generate_fdt_nodes(void *fdt, struct kvm *kvm)
>  	_FDT(fdt_property(fdt, "reg", &cfg_reg_prop, sizeof(cfg_reg_prop)));
>  	_FDT(fdt_property(fdt, "ranges", ranges, sizeof(ranges)));
>  
> -	if (irqchip == IRQCHIP_GICV2M || irqchip == IRQCHIP_GICV3_ITS)
> +	if (irqchip == IRQCHIP_GICV5_ITS)
> +		_FDT(fdt_property(fdt, "msi-map", msi_map, sizeof(msi_map)));
> +	else if (irqchip == IRQCHIP_GICV2M || irqchip == IRQCHIP_GICV3_ITS)
>  		_FDT(fdt_property_cell(fdt, "msi-parent", PHANDLE_MSI));
>  

Nitpick: maybe it is time for switch :)

	switch (irqchip) {
	case IRQCHIP_GICV2M:
	case IRQCHIP_GICV3_ITS:
		_FDT(fdt_property_cell(fdt, "msi-parent", PHANDLE_MSI));
		break;
	case IRQCHIP_GICV5_ITS:
		_FDT(fdt_property(fdt, "msi-map", msi_map, sizeof(msi_map)));
		break;
	default:
		/* No MSI */
	}

Cheers
Vladimir

>  	generate_dma_region_prop(fdt);
> -- 2.34.1
> 

