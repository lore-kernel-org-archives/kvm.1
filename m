Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166088;
	b=Bsv4KLPFy6Ablr+XaKHIPMWIXru6tHKRksRR4O3giFX8VKZSy2fDAPuohbpPrNGoqcJQ
	 PrS2DiAX8Q0cFOeKjdbre5MfBRtP6gZErs3N/AKyhYw8A1tubY9nKluy/xN0NgZPdpZ2r
	 fn1BTcmhkvXIRowhPg93PladZCr4s5INC3Kzk4lbtlTv+ji/9U3o+SQXIli5SHt2LieZh
	 kc/WKwbMcqyQGUS/Yor5GCzrByOIxhO277LBQ3d2/MZcxb8Eo/PeAveCf45xyxM1CU3St
	 Chmnz/E7eHCkbQT8wi9+XJbrVW4AiH/rfgQtMjLpxIbKtcnsttPuYlApA6GaG+xlI/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166088;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eJEZijoyJwAJ1iYg0RqPHalSgS8AeupSa9kFOgar1fA=;
	b=kYmfuORIYMMGeHaRqEyBtsZamViASf2WFqg1aFJe1ZNhbCda//GmmyMfiHrQUGKGKdGu
	 Z0vDf59wH0ur04HngfOPNHG1tw4U7qrgRsne28nX9I4MRudR+mly8iMcWrKA+hmjB4UtG
	 +3PGx7nxRIy94wrtcelzEjZHw8xRZvqjkvijDswJ0UNPhqdAmQNtF5tVczFOAytjJzTey
	 Q6UbPixeD5BaOtfqPiZEVlnfPYbQVdk6kDVWl6pSWibzZEAX/wirgMr6mvM/J5l3MHHRJ
	 1KdGhZpK6LwnAhxs017jZkgowlw8e9gsLyixPScbvxYNUkVPORLZj0PATnnj9JRMP9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IP3LqZIQ;
	arc=none smtp.remote-ip=95.215.58.131
Received: from mta1.migadu.com (out-131.mta1.migadu.com [95.215.58.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176D606A326
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 09:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1176D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IP3LqZIQ
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uRITAmfSiSUdZSBQ2vzurT5jha/a7G3BdG1Vu73+siU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795166085; v=1; x=1795770885;
 b=IP3LqZIQFet7yFL1AEDFOL8PjNnd7keZwe49KIrdK3nQvpmxtfYr3AdAJN98EDl5A6TJXaTE
 k8O7o1Wt5Yj4/tImSGhqVQayuzxfPQkvmPaY54x8E71Q5RvuSOUqHZaDqNxU2PS7+lDaMVRsNIq
 Yxia9NSyT4PjPASK6PTJhzPo=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cf8e84fe6a0cfa9f;
	Fri, 20 Nov 2026 09:14:45 +0000
X-Mizu-Trace-ID: cf8e84fe6a0cfa9f
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 10:14:13 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v2 4/8] riscv: Add ACPI support for ISA
 string discovery
Message-ID: <awAMfrnZbDemHE8o@orel>
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
...
> +static int acpi_rhct_for_each_hart(void (*func)(struct acpi_table_rhct *,
> +						 struct acpi_rhct_node_hart_info *,
> +						 void *), void *data)

Check the alignment of these parameters. There's an extra space.

> +{
> +	u32 offset;
> +	struct acpi_table_rhct *rhct;
> +	struct acpi_rhct_node *node;
> +	struct acpi_rhct_node_hart_info *hart_info;
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
>  	} else {
> -		isa_init_acpi();
> +#ifdef CONFIG_EFI
> +		info.id = ti->uid;
> +		ret = acpi_rhct_for_each_hart(isa_parse_acpi, &info);
> +		assert(ret == 0);

assert_msg(ret == 0, "ACPI: Failed to parse RHCT");

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
>  	} else {
> +#ifdef CONFIG_EFI
> +		info.id = cpus[cpu].uid;
> +		ret = acpi_rhct_for_each_hart(isa_parse_acpi, &info);
> +		assert(ret == 0);

assert_msg(ret == 0, "ACPI: Failed to parse RHCT");

> +#else
>  		assert_msg(false, "ACPI not available");
> +#endif
>  	}
>  
>  	return check->found;
> -- 
> 2.47.3
> 
