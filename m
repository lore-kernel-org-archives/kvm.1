Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182696;
	b=1IPjqCXAQSwN5xTOXAQ/xI1tRY/ZrOrqSmn6U1azFwUdBo19MGwRps0k2Hy55GLGjnZ3
	 qzQpvXGmCPeYGqSDx3hqlLLY1Ofsi1lzPnV5jU5p4z4NBLjCXhyOczAZnuSHHp4O9BLx5
	 qtzQXXbsOGiggM6ShUGkFuTSqI+VtgqABueNVOmhl/vUVMmbPgpUQZXnT8dJpp3O6KAYA
	 IdN7cphV0MjCFznuKpLrRkNPmX5NhiHPbux6gVPQKIxprovIABLctK5b3f2sOZBwKmZVe
	 M980Q6kEaCgWT7tUp0I83l0wqpMlE1ogxJsUc1aEaYIFOMPmEuOKFADuF1XRX0LoOxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182696;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uVBGHawbfsTuJsQ7Bm6pVz54iIRR86y1XPoWsEdwa3Q=;
	b=TryLPjsPwwqHVkpzR/RhagxB2hZKXt12SYOLiRilA2gLt+PRbVb1CoCYRUwN49DJoY66
	 +T/Kjrbxp19xkOBWwi6QLd4SQGQAVsdQg5tHeMdHvzD/vJu3mp5evkuH8Ugdaf307HnE1
	 WEagFNkAsvIJY0ScuezwpWvxh9viTnGeqsAky7Efl1F5EjQNr24WG6khIY4qTl3xJ0Y8B
	 Q2lNh5wSLBhzlgwgj5ii8adKEAEj9RcbQu7ksjzMb8s+4+lQj96eqHarRor1xnUAazcQ6
	 Ztao5IX+X14YkCZEYsEg9d0wr+9F/LGHI07Gl+mPQDHd2Nte2+V5Ho60y3XKU7ud7fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Xa4FK9Bm;
	arc=none smtp.remote-ip=91.218.175.240
Received: from mta0.migadu.com (out-240.mta0.migadu.com [91.218.175.240])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6B60A2618
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 13:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DE6B60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Xa4FK9Bm
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8Ps6GGoXNICr5SN/Qj56AMlLGmskLlThcLaD1co4uGo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795182694; v=1; x=1795787494;
 b=Xa4FK9BmxtlNfJv+j9MEuwW8GFXQ0i1NUDUV4h9UnyK60Y4rM3e7YByY/YpcNFECChO89hrW
 4tcmykh+PB70nPO1S1Ub3Ui+pPLwKx04Q8j1Yl90suWkBchQY5n5yV5tkf+ipnyKRkrIza/JWpZ
 uuBQR4IzAEXxPv1dgsUy8W/c=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ebafcd7b095d4e2d;
	Fri, 20 Nov 2026 13:51:34 +0000
X-Mizu-Trace-ID: ebafcd7b095d4e2d
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 14:51:00 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v2 3/8] riscv: Add ACPI support for timer
 frequency discovery
Message-ID: <awBQL-e_PtSmrfm-@orel>
References: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
 <20261105082035.133680-4-wangxiang@iscas.ac.cn>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105082035.133680-4-wangxiang@iscas.ac.cn>

On Thu, Nov 05, 2026 at 04:20:30PM +0800, Xiang W wrote:
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
>  lib/riscv/timer.c | 38 ++++++++++++++++++++++++++------------
>  2 files changed, 35 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/acpi.h b/lib/acpi.h
> index f6c92d28..0589669b 100644
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
> @@ -325,6 +326,14 @@ struct acpi_table_gtdt {
>  	u32 virtual_el2_timer_flags;
>  };
>  
> +struct acpi_table_rhct {
> +	ACPI_TABLE_HEADER_DEF
> +	u32 flags;
> +	u64 time_base_freq;
> +	u32 node_count;
> +	u32 node_offset;
> +};
> +
>  /* Reset to default packing */
>  #pragma pack()
>  
> diff --git a/lib/riscv/timer.c b/lib/riscv/timer.c
> index 18063b7e..a3af7e2b 100644
> --- a/lib/riscv/timer.c
> +++ b/lib/riscv/timer.c
> @@ -13,24 +13,38 @@
>  #include <asm/smp.h>
>  #include <asm/timer.h>
>  
> +#ifdef CONFIG_EFI
> +#include <acpi.h>
> +#endif

No need for this EFI guard.

Thanks,
drew
