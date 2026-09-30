Received: from mta1.migadu.com (out-150.mta1.migadu.com [95.215.58.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F13CC337
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761856; cv=none; b=Ei/jxP5ccMEN4MhtIm0fv6L6yN2WbCfZzdBc53Ak2G2lrMbSyMwkpvsPc0QxE1Q0hOY7QI70fNcowFfrhpK2OtQ30Zvm2bYDdNIiQqYEBq/bRMtM8KDSd7Rco8FH43d825RPIeCAQQQif7zTeNm8RnkuQJkQcCF5RqPdAxbP4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761856; c=relaxed/simple;
	bh=FKMZzLIuMUGPJesWEz83SnTluRLeLp6m+DLV2weSnBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjEwK2zO/qPqKWDekXve25eA/ordk2eZx/wubNWzHaH6c6K2O6LQ0URbOHkYkDaGkfwybVlJqQZh20we1n8yR69hhM3/PVeAkoKwhEtaHBqj6q5xFyCbgeEvDwmcH4BiB7EheoOe58+4ZvwMCHVgLeAY3z6NuG3jkr3QU0dSDqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=evjStU4K; arc=none smtp.client-ip=95.215.58.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="evjStU4K"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FKMZzLIuMUGPJesWEz83SnTluRLeLp6m+DLV2weSnBc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790761852; v=1; x=1791366652;
 b=evjStU4Kc4Ya1L24hSEl9sgDdr/c8oLIxlB7fFuu3mnfifVMgzfHnBjWn/HkmXV12UJxkmYW
 WWCgSfJGJIHdni8kkPakWLNVrPmryiEfoi1LXi9yDaQFx27xjZZ1gArjsyhZF3oPXj9ChnoaIoc
 O4qym7tPGBqeQA9BSICka68c=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e3db653f70d68817;
	Wed, 30 Sep 2026 09:50:52 +0000
X-Mizu-Trace-ID: e3db653f70d68817
X-Migadu-Flow: FLOW_OUT
Date: Wed, 30 Sep 2026 11:50:51 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH 2/7] riscv: Add ACPI support for CPU
 initialization
Message-ID: <bhisbphulilfbeouz2eap5zt6ndissa4bqwpqeksplfgmbhlc4@y6wii5vox7nl>
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

More ACPI naming comments below

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

struct acpi_subtable_header header ?

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

We already have ACPI_MADT_ENABLED

Thanks,
drew
