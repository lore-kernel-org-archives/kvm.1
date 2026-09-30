Received: from mta0.migadu.com (out-193.mta0.migadu.com [91.218.175.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D33769E4
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761434; cv=none; b=H41QB2MoV9DSqShXy0zAweTBj63uzapstsAHqpqqIIW6Yxa/QzCe1K61cheNa+b1mgLgIrec9+7aS5v9Z97rkWVo31SMHm2Ieg/o2obc4CyJ0YsY8wuCoXqlPQmkvXazdcqUI93wUGFXLttmmKNbvhkX8Qbb9VVxU1y1d7hVGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761434; c=relaxed/simple;
	bh=U2M2xlqw/KjGQrWvHSnOVqTKZiyerNMc1PkicikEQzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIPia5HT4nBvhS7/Fw++L8xDNCrzpbsWfLRWwGiAbBYx2Zya8GlVLS8dxPhY6N/9Ksg/f12qfbkVByRAMCwQ0WZRN7jpJIYMuj6Cj+7Q7OCKT8CVL6gRySNnlqiwdSLKN+zDtszlO+8jVAZLukQN1/UmuexShEz2J856ZEdgne0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cN8Xs1J9; arc=none smtp.client-ip=91.218.175.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cN8Xs1J9"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=U2M2xlqw/KjGQrWvHSnOVqTKZiyerNMc1PkicikEQzI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790761430; v=1; x=1791366230;
 b=cN8Xs1J9fe8M9eW1hbhhXVWdp5+swtBBTsDzlOIAjCkTA10yHbRNgwGOXk5lu+LH+LHMOFt1
 YORvW3kHmXvNmquD3C3t6crNr80YamdhVx7a11xQgxxyPlVINVxVHmTk0Kga0NFKbAWxZ+g8dQj
 P1WUeXJPLanc1HX/HQcNq+x0=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 791cc7bddc75e0eb;
	Wed, 30 Sep 2026 09:43:50 +0000
X-Mizu-Trace-ID: 791cc7bddc75e0eb
X-Migadu-Flow: FLOW_OUT
Date: Wed, 30 Sep 2026 11:43:46 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH 3/7] riscv: Add ACPI support for timer
 frequency discovery
Message-ID: <2wlouhxdm3owxuybtaizrcncnekhwjscdzeuwvye3hfwautlyu@rpnkw2r5emef>
References: <20260924033945.176581-1-wangxiang@iscas.ac.cn>
 <20260924033945.176581-4-wangxiang@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924033945.176581-4-wangxiang@iscas.ac.cn>

On Thu, Sep 24, 2026 at 11:39:41AM +0800, Xiang W wrote:
> When a DT is not provided, read the system time base frequency from
> the RHCT instead of aborting in timer_get_frequency().
> 
> RHCT Time Base Frequency is the ACPI equivalent of the DT
> /cpus timebase-frequency property and is the same for all harts.
> Keep DT as the preferred path when one is available.
> 
> Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
> ---
>  lib/acpi.h        |  9 +++++++++
>  lib/riscv/timer.c | 37 +++++++++++++++++++++++++------------
>  2 files changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/acpi.h b/lib/acpi.h
> index a905807d..2597e8ce 100644
> --- a/lib/acpi.h
> +++ b/lib/acpi.h
> @@ -20,6 +20,7 @@
>  #define MADT_SIGNATURE ACPI_SIGNATURE('A','P','I','C')
>  #define SPCR_SIGNATURE ACPI_SIGNATURE('S','P','C','R')
>  #define GTDT_SIGNATURE ACPI_SIGNATURE('G','T','D','T')
> +#define RHCT_SIGNATURE ACPI_SIGNATURE('R','H','C','T')
>  
>  #define ACPI_SIGNATURE_8BYTE(c1, c2, c3, c4, c5, c6, c7, c8) \
>  	(((uint64_t)(ACPI_SIGNATURE(c1, c2, c3, c4))) |	     \
> @@ -328,6 +329,14 @@ struct acpi_table_gtdt {
>  	u32 virtual_el2_timer_flags;
>  };
>  
> +struct acpi_table_rhct {
> +	ACPI_TABLE_HEADER_DEF
> +	u32 flags;
> +	u64 timebase_frequency;
> +	u32 node_count;
> +	u32 node_offset;
> +};
> +
>  /* Reset to default packing */
>  #pragma pack()
>  
> diff --git a/lib/riscv/timer.c b/lib/riscv/timer.c
> index 18063b7e..2a18f0e0 100644
> --- a/lib/riscv/timer.c
> +++ b/lib/riscv/timer.c
> @@ -13,24 +13,37 @@
>  #include <asm/smp.h>
>  #include <asm/timer.h>
>  
> +#ifdef CONFIG_EFI
> +#include <acpi.h>
> +#endif
> +
>  void timer_get_frequency(void)
>  {
> -	const struct fdt_property *prop;
> -	u32 *data;
> -	int cpus, len;
> -
> -	assert_msg(dt_available(), "ACPI not yet supported");
> +	if (dt_available()) {
> +		const struct fdt_property *prop;
> +		u32 *data;
> +		int cpus, len;
>  
> -	const void *fdt = dt_fdt();
> +		const void *fdt = dt_fdt();

This should be put above 'u32 *data'

>  
> -	cpus = fdt_path_offset(fdt, "/cpus");
> -	assert(cpus >= 0);
> +		cpus = fdt_path_offset(fdt, "/cpus");
> +		assert(cpus >= 0);
>  
> -	prop = fdt_get_property(fdt, cpus, "timebase-frequency", &len);
> -	assert(prop != NULL && len == 4);
> +		prop = fdt_get_property(fdt, cpus, "timebase-frequency", &len);
> +		assert(prop != NULL && len == 4);
>  
> -	data = (u32 *)prop->data;
> -	timebase_frequency = fdt32_to_cpu(*data);
> +		data = (u32 *)prop->data;
> +		timebase_frequency = fdt32_to_cpu(*data);
> +	} else {
> +#ifdef CONFIG_EFI
> +		struct acpi_table_rhct *rhct;

Need a blank line here, or just do the find call on the same line.

> +		rhct = find_acpi_table_addr(RHCT_SIGNATURE);
> +		assert_msg(rhct, "Cannot find ACPI RHCT");
> +		timebase_frequency = rhct->timebase_frequency;
> +#else
> +		assert_msg(false, "ACPI not available");
> +#endif
> +	}
>  }
>  
>  void timer_start(unsigned long duration_us)
> -- 
> 2.47.3
>

Thanks,
drew
