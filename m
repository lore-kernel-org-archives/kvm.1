Received: from mta0.migadu.com (out-115.mta0.migadu.com [91.218.175.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C045439B969
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761168; cv=none; b=ff+pkKjSCDp50djjkqvgJc52GdtYzYzC4Vdgu2+2Df+97P987+DlsPGj+u46t+LBLzWC3NzNFphB0/L5WLCkjYRHG6X8BFu8vviDI3/Sd9I6/BGuFdFg1wwW5TBaij73HHkfUtUhKWNGTxyGkL55iihjcP8gYbfpRXRhAPSC4yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761168; c=relaxed/simple;
	bh=khkThFf1oWq6SIxcHnXgeQNtm2wlSpOWtw7vvacr42A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s81HgF7duJ0nc0TRVZQm7lQSNzu/rnm98Yafi8yY9CNany5ej5DVO3sLAx7mEsTPJxo+pH5ykgBu6eRIQchroQO7L2UFi3vQRajzQ6lMdjtlGX9MqguzQy03sxSySxc6XW8H/P7hRjoxTOsR8+ZnVcw0J/oau5LIURghqBqCEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eMMqbYsc; arc=none smtp.client-ip=91.218.175.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eMMqbYsc"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=khkThFf1oWq6SIxcHnXgeQNtm2wlSpOWtw7vvacr42A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790761164; v=1; x=1791365964;
 b=eMMqbYscHWNSBzHkNX1SHuCbMlMBu+y1SRS4LOH2mkg2Wkyr8twIwEVwSkCy0C+yFgCcwCH6
 A2enMzUJRtjGKLQG8MXOjFLSenWzujIiNKiwdbCS6p929+6kJ2rnAsoy56c2Eu7L6XNBBfeH9vX
 Ru/sibBrycebAN8KzMguK+Tw=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 81ce95a8489771b1;
	Wed, 30 Sep 2026 09:39:24 +0000
X-Mizu-Trace-ID: 81ce95a8489771b1
X-Migadu-Flow: FLOW_OUT
Date: Wed, 30 Sep 2026 11:39:19 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH 2/7] riscv: Add ACPI support for CPU
 initialization
Message-ID: <jl443rrfxhnjlxzysd33dd2mflqtiuj44tiolkihcjrncolnuh@gvz7zjdh2sog>
References: <20260924033945.176581-1-wangxiang@iscas.ac.cn>
 <20260924033945.176581-3-wangxiang@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924033945.176581-3-wangxiang@iscas.ac.cn>

On Thu, Sep 24, 2026 at 11:39:40AM +0800, Xiang W wrote:
> When a DT is not provided, discover harts from the MADT RINTC
> subtables (ACPI 6.6 type 24) instead of aborting in cpu_init_acpi().
> 
> Parse each RINTC entry for hart_id and ACPI UID, record them in
> thread_info, and mark the CPU present only if it is Enabled in
> the RINTC flags and SBI reports the hart as available.
> 
> Also add the RINTC MADT structure and the MADT types introduced
> after GENERIC_TRANSLATOR so the RISC-V interrupt controller
> entries can be identified.
> 
> Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
> ---
>  lib/acpi.h                | 30 +++++++++++++++++++++++++++++-
>  lib/riscv/asm/processor.h |  1 +
>  lib/riscv/setup.c         | 28 +++++++++++++++++++++++++++-
>  3 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/acpi.h b/lib/acpi.h
> index a62cd3a9..a905807d 100644
> --- a/lib/acpi.h
> +++ b/lib/acpi.h
> @@ -226,6 +226,22 @@ struct acpi_madt_generic_translator {
>  	u32 reserved2;
>  };
>  
> +/* 24: RISC-V Interrupt Controller (RINTC) Structure (ACPI 6.6) */
> +struct acpi_madt_rintc {
> +	u8 type;
> +	u8 length;
> +	u8 version;
> +	u8 reserved;		/* reserved - must be zero */
> +	u32 flags;
> +	u64 hart_id;
> +	u32 uid;
> +	u32 ext_intc_id;
> +	u64 imsic_addr;
> +	u32 imsic_size;
> +};
> +
> +#define ACPI_RINTC_FLAGS_ENABLED	1
> +
>  /* Values for MADT subtable type in struct acpi_subtable_header */
>  
>  enum acpi_madt_type {
> @@ -245,7 +261,19 @@ enum acpi_madt_type {
>  	ACPI_MADT_TYPE_GENERIC_MSI_FRAME = 13,
>  	ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR = 14,
>  	ACPI_MADT_TYPE_GENERIC_TRANSLATOR = 15,
> -	ACPI_MADT_TYPE_RESERVED = 16	/* 16 and greater are reserved */
> +	ACPI_MADT_TYPE_MULTIPROCESSOR_WAKEUP = 16,

Linux calls this ACPI_MADT_TYPE_MULTIPROC_WAKEUP

Thanks,
drew
