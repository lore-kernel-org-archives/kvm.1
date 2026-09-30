Received: from mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C983FFACC
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763320; cv=none; b=QiSX4ca631nnhP4eXfkNTkvBWLDr12VT6aVM3q01+37uqdhL1qybmgfQp4EtnEA1dvntqQW2OpAmTnqBFtCtCmPM8Yq1dkcstyYdH13bSLAO3ZeeDclCQvsOhSCOtR5c+e9t7mXGaPdK+rQxQa0/8kQRETFBPalspcPHfG0hIjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763320; c=relaxed/simple;
	bh=RkoJMjZHl4KBOU2SB7z3AE78J0AfcJkGV0pZkQsN8og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWkPBWgNAaC+ZRayN0uMmqIr/ybPtiYtyyuajXpg5KsFDhH9ebbXVf7jz2QPrlVQBz0SjF95XS3iLPZ8wKWieEo+k4hesExxGMPgxvAaQ3AXNIwHVtMadGDklGIintnt0n39gwNrhm64968jj+PLi7TFPn4bpl1dXPNxlQVWgow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C7Cc3vNY; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C7Cc3vNY"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RkoJMjZHl4KBOU2SB7z3AE78J0AfcJkGV0pZkQsN8og=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790763316; v=1; x=1791368116;
 b=C7Cc3vNYBCN+4o4hJzJ5K4iZ5h38qF6aQXIJ4ykC1iZryRvwlUX4QI/F6Y+oN4zhByqPbHEw
 DAEG2P4HxraKSOMeETbfBgaG9SAGyY5g5HHtCxT2wnQWNgN1BOqBG1V51G3kpzoOtsPwOAKc0Vx
 HNI59P2yNoFPkU6xxVrwiho8=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6792861cd6e12caf;
	Wed, 30 Sep 2026 10:15:15 +0000
X-Mizu-Trace-ID: 6792861cd6e12caf
X-Migadu-Flow: FLOW_OUT
Date: Wed, 30 Sep 2026 12:15:10 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH 4/7] riscv: Add ACPI support for ISA
 string discovery
Message-ID: <it2vpvd5lo7rats2r6dbbtxyb4n4n5zwextkteccognilhzudj@7c5exktlyrr3>
References: <20260924033945.176581-1-wangxiang@iscas.ac.cn>
 <20260924033945.176581-5-wangxiang@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924033945.176581-5-wangxiang@iscas.ac.cn>

On Thu, Sep 24, 2026 at 11:39:42AM +0800, Xiang W wrote:
> When a DT is not provided, walk the RHCT Hart Info nodes and parse
> the referenced ISA String node instead of aborting in isa_init()
> and cpu_has_extension_name().
> 
> Match the current hart by ACPI UID (DT still matches by hartid)
> and feed the ISA string into the existing isa_parse() helper so
> extension detection is shared by both firmware descriptions.
> 
> Rename isa_info.hartid to isa_info.id so the same iterator state
> can hold either identifier.
> 
> Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
> ---
>  lib/acpi.h      | 28 ++++++++++++++++++++
>  lib/riscv/isa.c | 68 ++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 89 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/acpi.h b/lib/acpi.h
> index 2597e8ce..3db382b7 100644
> --- a/lib/acpi.h
> +++ b/lib/acpi.h
> @@ -337,6 +337,34 @@ struct acpi_table_rhct {
>  	u32 node_offset;
>  };
>  
> +#define ACPI_RHCT_NODE_HEADER_DEF \
> +	u16 type;	\
> +	u16 length;	\
> +	u16 revision;	\
> +
> +struct acpi_rhct_node {
> +	ACPI_RHCT_NODE_HEADER_DEF
> +	char data[];
> +};
> +
> +enum acpi_rhct_node_type {
> +	RHCT_NODE_ISA_STRING = 0x0,
> +	RHCT_NODE_HART_INFO = 0xFFFF

ACPI_RHCT_NODE_TYPE_ISA_STRING
ACPI_RHCT_NODE_TYPE_HART_INFO

> +};
> +
> +struct acpi_rhct_node_isa_string {
> +	ACPI_RHCT_NODE_HEADER_DEF
> +	u16 isa_length;
> +	char isa[];
> +};
> +
> +struct acpi_rhct_node_hart_info {
> +	ACPI_RHCT_NODE_HEADER_DEF
> +	u16 num_offsets;
> +	u32 uid;
> +	u32 nodes[];
> +};
> +
>  /* Reset to default packing */
>  #pragma pack()
>  
> diff --git a/lib/riscv/isa.c b/lib/riscv/isa.c
> index bc1c9c72..b0257979 100644
> --- a/lib/riscv/isa.c
> +++ b/lib/riscv/isa.c
> @@ -12,7 +12,7 @@
>  typedef void (*isa_func_t)(const char *, int, void *);
>  
>  struct isa_info {
> -	unsigned long hartid;
> +	unsigned long id;
>  	isa_func_t func;
>  	void *data;
>  };
> @@ -74,7 +74,7 @@ static void isa_parse_fdt(int cpu_node, u64 hartid, void *data)
>  	const struct fdt_property *prop;
>  	int len;
>  
> -	if (hartid != info->hartid)
> +	if (hartid != info->id)
>  		return;
>  
>  	prop = fdt_get_property(dt_fdt(), cpu_node, "riscv,isa", &len);
> @@ -83,32 +83,80 @@ static void isa_parse_fdt(int cpu_node, u64 hartid, void *data)
>  	isa_parse(prop->data, len, info);
>  }
>  
> -static void isa_init_acpi(void)
> +#ifdef CONFIG_EFI
> +#include <acpi.h>
> +
> +static void isa_parse_acpi(struct acpi_table_rhct *rhct, struct acpi_rhct_node_hart_info *hart_info, void *data)

Let's keep it under 100

static void isa_parse_acpi(struct acpi_table_rhct *rhct,
			   struct acpi_rhct_node_hart_info *hart_info, void *data)

> +{
> +	u32 offset;
> +	struct acpi_rhct_node *node;
> +	struct acpi_rhct_node_isa_string *isa_string;
> +	struct isa_info *info = (struct isa_info *)data;
> +
> +	if (hart_info->uid != info->id)
> +		return;
> +
> +	for (int i = 0; i < hart_info->num_offsets; i++) {
> +		offset = hart_info->nodes[i];
> +		if (offset >= rhct->length)
> +			break;
> +		node = (void *)rhct + offset;
> +		if (node->type == RHCT_NODE_ISA_STRING) {
> +			isa_string = (void *) node;

 isa_string = (void *)node

I thought checkpatch would catch something like that. Did you run it?

> +			isa_parse(isa_string->isa, isa_string->isa_length, info);
> +		}
> +	}
> +}
> +
> +static void acpi_rhct_for_each_hart(
> +	void (*func)(struct acpi_table_rhct *, struct acpi_rhct_node_hart_info *, void *), void *data)

static void acpi_rhct_for_each_hart(void (*func)(struct acpi_table_rhct *,
						 struct acpi_rhct_node_hart_info *,
						 void *), void *data)

>  {
> -	assert_msg(false, "ACPI not available");
> +	u32 offset;
> +	struct acpi_table_rhct *rhct;
> +	struct acpi_rhct_node *node;
> +	struct acpi_rhct_node_hart_info *hart_info;

Need a blank line here. I'm thinking checkpatch wasn't run, since I'm sure
that would have been caught.

Thanks,
drew
