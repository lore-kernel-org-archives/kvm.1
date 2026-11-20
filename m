Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173689;
	b=qAOO7TeUoaS1o7F6MqboNN2V7HSoWB6dK3DMbtOXwHOrefOiSJjKezfW5pFn4CggJIMr
	 0/Hylpy9AKFr0W/7ADC3ia4tBz1PtlPxYBzpuSOudrUP66xOlwexZC0xBz8qmAcc69KbX
	 yhmfLq6j9rj+26pbOMK9i2SoDBQ/mZrK2p1BXmYjoPEsbhHqOuB+cuzClxcDza/RqS7TY
	 graArmYq/FIxuLz+pEHuGsY6aYQkhlREjejKNdTjSFQBB3++PWpbvk6fsekcMVeBhB+JV
	 OdBgb6cFNXE0NAv2d5nbbLgiX5B5Q8oO0rONCAepU93PTDxom+MEK0m6xfOMEy5EKmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173689;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9fko5sF49v7a9mwemZP4CJO6X4nvg3fCG4hUhYF0oMI=;
	b=P90tIctQ9246+xRY4STiXqUPuzWlyXsIhb406I3AkXZFvp3P4PaQL2psAYrHZWSq2gS/
	 LNnsDnTbEwD0B1GXNSFO8lriIkSpclSOBSBmPN8oKWBXU4O8lnjBCd3yU33KowBWkL4PH
	 2r8Bhwc914eie+MNeKKDiiCyn9gUJXTeBlt5tH54SDfsxrVB2iflSmSeqXqMdX7XbpCwm
	 3izT83eBnINYTvCln0zIKRH5CJ596owCM5LOKtb9FXyLd7bEMWEI3ffVJVmgrV/TeWyfU
	 uZKpZERiKXCa67BU8maJEpaBYkQFQfjZypUibxb5weXXv1lNOPMJgIs1iGQXuTjVtSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hH29Jo7+;
	arc=none smtp.remote-ip=91.218.175.206
Received: from mta0.migadu.com (out-206.mta0.migadu.com [91.218.175.206])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF4606A331
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 11:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3AF4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hH29Jo7+
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9n4cByJoPdB+kW90lGIyuXDMxhLTitfTJHK9dWQrb3I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795173685; v=1; x=1795778485;
 b=hH29Jo7+zJfKejZ41WbucKWE1dBqgxHKhh7TLXoqRSanLeHRul2hH1eS6mZkgPUCohTc7600
 zcfRMgk36oX0uUi2X9OfZ5HNRHpexnQUhkNdsX9RL81vcq4CKDRjLif1u/GL4UKw82lJpt3MRW0
 pqqu7kdY3E13JRV6TcwsAjWo=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d22eb9c66bf70ffc;
	Fri, 20 Nov 2026 11:21:25 +0000
X-Mizu-Trace-ID: d22eb9c66bf70ffc
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 12:20:50 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v2 4/8] riscv: Add ACPI support for ISA
 string discovery
Message-ID: <awAsCpi2bTlRh6lu@orel>
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

nit: I prefer reverse fir tree

> +
> +	if (hart_info->uid != info->id)
> +		return;
> +
> +	for (int i = 0; i < hart_info->num_offsets; i++) {
> +		offset = hart_info->nodes[i];
> +		if (offset >= rhct->length)
> +			break;

Shouldn't this be an assert instead of a silent return?

> +		node = (void *)rhct + offset;
> +		if (node->type == ACPI_RHCT_NODE_TYPE_ISA_STRING) {
> +			isa_string = (void *) node;
> +			isa_parse(isa_string->isa, isa_string->isa_length, info);
> +		}
> +	}
> +}
> +
> +static int acpi_rhct_for_each_hart(void (*func)(struct acpi_table_rhct *,
> +						 struct acpi_rhct_node_hart_info *,
> +						 void *), void *data)
> +{
> +	u32 offset;
> +	struct acpi_table_rhct *rhct;
> +	struct acpi_rhct_node *node;
> +	struct acpi_rhct_node_hart_info *hart_info;

same fir tree nit (and likely elsewhere in the series)

> +
> +	rhct = find_acpi_table_addr(RHCT_SIGNATURE);
> +	if (rhct == NULL)
> +		return -1;
> +
> +	offset = rhct->node_offset;
> +	for (int i = 0; i < rhct->node_count; i++) {
> +		if (offset >= rhct->length)
> +			return -1;
> +
> +		node = (void *)rhct + offset;
> +		if (node->length < sizeof(*node))
> +			return -1;
> +
> +		if (node->type == ACPI_RHCT_NODE_TYPE_HART_INFO) {
> +			hart_info = (void *)node;
> +			func(rhct, hart_info, data);
> +		}
> +
> +		offset += node->length;
> +	}
> +
> +	return 0;
>  }
> +#endif
>  
>  void isa_init(struct thread_info *ti)
>  {
>  	struct isa_info info = {
> -		.hartid = ti->hartid,
>  		.func = isa_bit,
>  		.data = ti,
>  	};
>  	int ret;
>  
>  	if (dt_available()) {
> +		info.id = ti->hartid;
>  		ret = dt_for_each_cpu_node(isa_parse_fdt, &info);
>  		assert(ret == 0);

While touching this code you can add assert_msg here too like I suggested
for your asserts below in my other reply.

>  	} else {
> -		isa_init_acpi();
> +#ifdef CONFIG_EFI
> +		info.id = ti->uid;
> +		ret = acpi_rhct_for_each_hart(isa_parse_acpi, &info);
> +		assert(ret == 0);
> +#else
> +		assert_msg(false, "ACPI not available");
> +#endif
>  	}
>  }
>  
>  bool cpu_has_extension_name(int cpu, const char *ext)
>  {
>  	struct isa_info info = {
> -		.hartid = cpus[cpu].hartid,
>  		.func = isa_name,
>  		.data = &(struct isa_check){ .ext = ext, },
>  	};
> @@ -116,10 +176,17 @@ bool cpu_has_extension_name(int cpu, const char *ext)
>  	int ret;
>  
>  	if (dt_available()) {
> +		info.id = cpus[cpu].hartid;
>  		ret = dt_for_each_cpu_node(isa_parse_fdt, &info);
>  		assert(ret == 0);

and assert_msg here too, please

>  	} else {
> +#ifdef CONFIG_EFI
> +		info.id = cpus[cpu].uid;
> +		ret = acpi_rhct_for_each_hart(isa_parse_acpi, &info);
> +		assert(ret == 0);
> +#else
>  		assert_msg(false, "ACPI not available");
> +#endif
>  	}
>  
>  	return check->found;
> -- 
> 2.47.3
> 
