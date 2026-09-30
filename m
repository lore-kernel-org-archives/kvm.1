Received: from mta1.migadu.com (out-169.mta1.migadu.com [95.215.58.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020BE345EA2
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762166; cv=none; b=kFV4eSnAVXPsdeActIrjVhyeE0SIkk0PGleALEtf5dynpI8v4kLcSbynpvNG3QszCHlZerIQUETk7/L1M2Z+F/Xvw4oBn15KVYedGCezd40QOBwe8MkRYwq7ZwK+wO+5KMcym2J0PUzxk7qJo49li8oVJLP4tHRGStCb1TMwKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762166; c=relaxed/simple;
	bh=WqRcRYkypUXkJWaAM46u013AeQPZl1/z1oeH4D2B+tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxnU59olGstBlGWGVrxy4jsZIXb/KRtVNHt4pVrS/6g+6IFSA14N5dwoorj5imRSw+lFrM/QGCwUxXRLFgZhBJw1SaTHAG0FwSWW44rkQyleF3IfLJxxZVu0Z0YB72opmaf5PaDateb72ra9DQzfuS1k+x2dAuzxLmH/enJS6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TkuJRLCq; arc=none smtp.client-ip=95.215.58.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TkuJRLCq"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WqRcRYkypUXkJWaAM46u013AeQPZl1/z1oeH4D2B+tY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790762162; v=1; x=1791366962;
 b=TkuJRLCqMH+SqNoO0C+cs+D8J4MzMEMh7JgktaDJ0cA8G02oVKnsMo/BBS/QstdKY3KoyNWw
 bxr2uI7NFoULJUNZas1Xrluta7+ZAZGZa8ja1zO8CVzsgdCmaRnYbyEbfJ8F08oLFD8vwiod0uv
 dVCXZWZmwiYc5OshGdCtcJkU=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0705bfacec442bd8;
	Wed, 30 Sep 2026 09:56:02 +0000
X-Mizu-Trace-ID: 0705bfacec442bd8
X-Migadu-Flow: FLOW_OUT
Date: Wed, 30 Sep 2026 11:55:57 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH 3/7] riscv: Add ACPI support for timer
 frequency discovery
Message-ID: <5mahc2yepy4xvnntxttficdtmozod6kk7jkhpgqojy7zpdzb47@bcrufz76my3j>
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

Another ACPI naming comment

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

Linux calls this time_base_freq

Thanks,
drew
