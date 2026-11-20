Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164927;
	b=5DUtTjG5aII2H+xK2euReMxGG9nkVo/pM/SwaDJbkVcDq0nD8Xki6MKfb3ccQw+lEMl4
	 7WJ2ewrviU5jN92VqtnMJisTLMe5Ue5Ec7BBMgSuxZwcKwYH4TjDVISvVBxI+l66mLYfa
	 aFqEHkLgsGkgng4K4+I2tJ8y5+vccIJPcjunLy39D5Sa/K7jGudQ+13aPP8032v/P1M+G
	 X8D1dsAVPP442UZHOdNlperxbI03iM1jg3zmjuX4e8qBK+nu3HQf9HxEkCcp8cvCu7YiT
	 gjlUsl/Il53lUPpAM9T8nJkmjdmmPt3HesAWyfixMBInIO6e6xdNWIdZ1+eETqktx6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164927;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=n/JB8bIsfCMIbqHm2QgRJ/7ZEvIjTVo4GZGs2lOrCWs=;
	b=XfayP3QFfMQc8S1vWJl/T7esOePcrH+ZI/j2h32Y3ztZImk5gqmM5p4AZ0QnW4pcrVTW
	 gI5pS2ikkX8H/V8jEi87Nj3kbDdhCkbI5KE8iLaAyU0T3VBiwFgweNedHUNjJdNza0fg6
	 B3oGM3XYOSZ5srng0DDPzvlNWb3regLVvPWlgibSlmbha/9yYcwgUMxcEpmIb3pfHmeHN
	 RdOLWzuvRVM1SRAIAYeAcZ7H6VZQok01ZRfNbEqWoE7q7WKLCeejF/hR/IZFX4LZOux3b
	 ck8f2+ZytqRkB0LtnU9mFO4ZZCj4Y6Fb02w6E6wlW3aslJcb4kcQ8138Z21pkg4jcAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ikExANiX;
	arc=none smtp.remote-ip=95.215.58.15
Received: from mta1.migadu.com (out-15.mta1.migadu.com [95.215.58.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D95F606A33B
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 08:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D95F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ikExANiX
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AMQp0GfzBfokKPQdG0ah10319ae3QMcosZHAYVir9mo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795164924; v=1; x=1795769724;
 b=ikExANiXN/B+x4+FxyrSLabyg23OvWnuS/33nD0aE/tbE/S4UEvBM2/cDFskh+mqu8q7cpXG
 CeikZqy4+6u5whMN2p7K4YJmgSXLqJPgzbBHQaEvK8PmUrjE27sSUgse02DClDb0DIEg/oyDLKk
 vY1xiMh9rgZO9avCo+5DrFCI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 53741bf653518542;
	Fri, 20 Nov 2026 08:55:24 +0000
X-Mizu-Trace-ID: 53741bf653518542
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 09:54:49 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v2 4/8] riscv: Add ACPI support for ISA
 string discovery
Message-ID: <awAKq3jFCaVvxVA0@orel>
References: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
 <20261105082035.133680-5-wangxiang@iscas.ac.cn>
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
In-Reply-To: <20261105082035.133680-5-wangxiang@iscas.ac.cn>

On Thu, Nov 05, 2026 at 04:20:31PM +0800, Xiang W wrote:
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
>  lib/acpi.h      | 28 +++++++++++++++++
>  lib/riscv/isa.c | 81 ++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 102 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/acpi.h b/lib/acpi.h
> index 0589669b..d5e238a9 100644
> --- a/lib/acpi.h
> +++ b/lib/acpi.h
> @@ -334,6 +334,34 @@ struct acpi_table_rhct {
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
> +	ACPI_RHCT_NODE_TYPE_ISA_STRING = 0x0,
> +	ACPI_RHCT_NODE_TYPE_HART_INFO = 0xFFFF
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
> index bc1c9c72..91c7302c 100644
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
> @@ -83,32 +83,92 @@ static void isa_parse_fdt(int cpu_node, u64 hartid, void *data)
>  	isa_parse(prop->data, len, info);
>  }
>  
> -static void isa_init_acpi(void)
> +#ifdef CONFIG_EFI
> +#include <acpi.h>
> +
> +static void isa_parse_acpi(struct acpi_table_rhct *rhct,
> +			   struct acpi_rhct_node_hart_info *hart_info, void *data)
>  {
> -	assert_msg(false, "ACPI not available");
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
> +		if (node->type == ACPI_RHCT_NODE_TYPE_ISA_STRING) {
> +			isa_string = (void *) node;

(void *)node

Thanks,
drew
