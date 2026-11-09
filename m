Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794252990;
	b=shEY5Sm1a0Um4xRs+vdyP7odlQx4ZyM1CntKwLzk/5nlHl7m8lySHoax4rbkjQTvFQQD
	 NtyMP5579qwUiFhnSVYES33D0dvM5nRrRu7PqdoespXMWVUrwYWat6b+9MDPbv77DTMWc
	 7JbgMrsIidFmVbWEMzwQIKPOvqeEX26YidZ11PqZu92iyZx9N1IcfERLCEVQ3hgOe8Hvx
	 YBjKG3YIQZzOv4+axmnX7UgoEfrKq0DdHcRtFP5tlWI1q7CwCgsBayCh7TkvxBlts+cxg
	 smZI2aSOBXkT/XC7ST+rrsGfF9X5FSWaH5jlR7xGLZiq1nWmtEZ/J7C8RYBN/PYHBAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=FNS0rvY8L2G1kXx/9AEiQVl5+WbZi21fC5nZTW3I69E=;
	b=QzoXJKUaTt6iCikfvigzaVFkk79w4XrbpTKcCmIbFxxT9z8R4u1Dl7giMZpt9PHM1Lcg
	 HBUitQtZlQ2gUKIQYcGVU/k80UaHHda/rnBuIqY9YlNrfgwirapCIKnfEw04w3FQRDOwZ
	 Vomam8VfmKkBnsfEvRUULQqbnsmY1k3rm2gQYR/eeokJnvTF/0NVThMRWFBC21FQGIVuJ
	 34OObet5IofmpPvm2Mo4OmRg7FldDtwWhxAqF9YsRnPGLaLGEHUXOEXju30DskxQa2oIv
	 wAx38iEsS8dKwakD9p2KK9SZdoEQspalFR+O6f+t4Vdytv0q52VZbWyIh3XBlf3lU0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fpKNcnVh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ED3606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 19:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82ED3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fpKNcnVh
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91eb7d1478cso13136586d6.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 11:36:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794252989; cv=none;
        d=google.com; s=arc-20260327;
        b=QZ+W97hOgw4r89dGI3y2rsdaxaQMIFomSpMVwCnJv+ZoZUx41V+whHXdilmTUx3vdS
         oOUUF5mvGxomnexDPqp4PD+HjbQcD1cN73+BQ2xOC4mzMrIIMh6kJGRp3E8PFkgDVird
         e9DS0tRQGCu4WOhV1HXT3b0cwTAZuuAt2y5JmcgCUjfQaeJ3n1P5FDfGf44smsSRb5tS
         JdjVvarR+J4jghWTu2V+sk3jEsk65ijL3fTG+dVeXRkpTKbQxtQJ+EWb58y46+VGC8XT
         Fw32QdN/9ZbgftYlyGXf+emm6WNfBsmKxgSDPYN3u7fLDjAVB/wic8GmIiRMmhcZ4VJG
         udhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=FNS0rvY8L2G1kXx/9AEiQVl5+WbZi21fC5nZTW3I69E=;
        fh=oqGs8c4NfjB7Bxif3EQbikqd7R3h4i8vJPJDrM2cHC8=;
        b=V5Nzqv748hVWHKfT+xgc265RBZzxoXvnbhxtdiXHQwN3BPYaSMhWR56vLbohBlmzBh
         PwoCySf+fVp7ZCE09qiz8qdDFe4+jdogFTp7182BltU1RRhVPygE56Ojn9/R/fU5Hqr0
         AlkqNSxLEBd815xltw83HMX9FodZMQqKGW2/9+OwuLJooYiL38j3fe90yrujbwjTLAfX
         zPg2lx4rRTaxMSvkbD5omjfBQy5rKwqzLtE/sFvbnfBd3QcedUrqwjxf3v43YggJrSi6
         PrBWZqNbP2rk8m2DmW1ZYmLPjtEj58cMsgXvmNX0vTf0WtG4ME3uJCL6R0K9qxpJchrA
         m/GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794252989; x=1794857789; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNS0rvY8L2G1kXx/9AEiQVl5+WbZi21fC5nZTW3I69E=;
        b=fpKNcnVh/2I+iG6wihxClu2CwKcNoccri64fWdEO0ipq/RVkJMjOD222Zw3hXtrNg5
         c5wuWhzONHfOhIG7rIUvYsVZh4882YDw9HhHd8OTJwi0exuJgK9afPsOmyj+srdxrI5Y
         uK9KswQYhNbGVtJNawsDvvEt3GuVRvT+641RMqV/1NiOPinEAnpglkliHfuxFm0fdfkR
         wrEtqzqstVjBlHG9WXc3TOLxGkrKyHhkporF9CHGN5y2CWWm3Eabzyyg499wD2x/rx93
         s2zQPpA4Mf+DVx+gAmYsp0uWJ8kDas5Z8z1wvd+LD/29yo2wNby4TVy3ftswRFw6ADyz
         y3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794252989; x=1794857789;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FNS0rvY8L2G1kXx/9AEiQVl5+WbZi21fC5nZTW3I69E=;
        b=M5JtTLsCj5BX4Pv0Jr7EH8Mn5QiCbQ1G/wytJDgjck2GHgt1nw5nu64mH+OpPSLQPx
         DybkPbgKqnlOeAKeZHHll6eAKEHlYBwoczoZu60eyRPruSEG/BwzY2D+d56IISA7YSZu
         j0yqP5NjfgK4+ftl+lx97FvsndGO0I7MFjeTEaUc8aWvdbZ34aVayRwL/oMPxLZvuIjY
         w4XhCWq+i30uVLtEMRdXzVBRKXCeaN/tyAMjye5dkgxQTkdgXgpFP3nm9q+/WbCjMHfg
         LPzBjQ2U4unvKxA7zo8NNRZka6MllD5SsGjvgZIp+HtedF5f8SEu7YZuKK0MHrS2pVbo
         lXbg==
X-Forwarded-Encrypted: i=1; AL+hErGKALmL3ym0/c1hXyOLUdS+vdx8ayjyuI261wUEJQa2GF43F/XzU0bDi/JCCGX3k+5ZqM8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+s2d5tBvAVEd6WN3EjrC93zz+wcbVsjE+keKotwxf3LC6fmFPL
	yss4RuEVo5q2G3IhkHNtVuqY2uzX5/E6gF6ezUbBJPtXiBqMVCT2SlxhV1ZqXjmMjfM+/Eoo/Xq
	Z+2U6/7AoE4Hb1/rd3wEOqFpsa4vamQspAKvgNsY+
X-Gm-Gg: AYBFou1zTGJ0X4yVV3K7EfBCTnJ71AeRQ0Rib/wyQjVSsUjuxIKVeUDmzFoAUvYWPDm
	9H9hlePHaX5sHcNYbGk+y+2pKDLBZGyNJiltiQ3+z3qaXfkyTYAS4l9ywExTv9H2xh+F+8v/EbG
	8Z7+NSkg0tsVmC7UZkopSje2NGrcnARC7ZPah805qUxoIqkrMqYTmQ+8rYGC6dYUfZEHbRnKzRI
	QgBQ/lgE+4azUYSaJIY3GcDb75IRh8j2kaz6Px14ZTxazaAor16kLH6w6X+9ymvUByEuBDPZJDc
	I6XJ2/yJGgwAAO9YkosbwGN1HpbZq3iLYskUAzrgfci/J9DY9l4OKSMPFSIz9XXaCJVc3Rg1J4Q
	Ic1K308lnEsjZWxDwHBCRhZZ/OzBWasmm+eIu5tC7pIw9UjJHNx4TPU+GW4K1JJuPeoqMU2hi8f
	Q88mAcFnzdEMWDpeHHDKNfqRs=
X-Received: by 2002:a05:6214:5bc5:b0:91e:8cb1:b84e with SMTP id
 6a1803df08f44-91eef92240emr10728756d6.24.1794252988739; Mon, 09 Nov 2026
 11:36:28 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 11:36:27 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261105-tdx-selftests-v16-3-2024e8fa517a@google.com>
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com> <20261105-tdx-selftests-v16-3-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 11:36:27 -0800
X-Gm-Features: AclHuK-BA2NXsbSfd5J99KlC06brlgAuU8dZlouTP4cLRD_A5AkBQuIm7WWoo_s
Message-ID: <CAEvNRgHKQVLVza1dw9-OrDAt4-b6zbhx4T64D421sqb2MPWs0w@mail.gmail.com>
Subject: Re: [PATCH v16 03/20] KVM: selftests: Initialize the TDX VM
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Lisa Wang <wyihan@google.com> writes:

>
> [...snip...]
>
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> new file mode 100644
> index 000000000000..564144c40f0a
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "processor.h"
> +#include "tdx/tdx_util.h"
> +
> +static const struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
> +{
> +	static struct kvm_tdx_capabilities *tdx_cap;
> +	int nr_cpuid_configs = 4;
> +	int rc = -1;
> +	int i;
> +
> +	if (tdx_cap)
> +		return tdx_cap;
> +
> +	do {
> +		nr_cpuid_configs *= 2;
> +
> +		tdx_cap = realloc(tdx_cap, sizeof(*tdx_cap) +
> +					   (sizeof(struct kvm_cpuid_entry2) * nr_cpuid_configs));

Would be nice if struct_size() could be used here instead of manual
calculation of the size. Same below.

> +		TEST_ASSERT(tdx_cap,
> +			    "Could not allocate memory for tdx capability nr_cpuid_configs %d",
> +			    nr_cpuid_configs);
> +
> +		tdx_cap->cpuid.nent = nr_cpuid_configs;
> +		rc = __tdx_vm_ioctl(vm, KVM_TDX_CAPABILITIES, 0, tdx_cap, NULL);
> +	} while (rc < 0 && errno == E2BIG);
> +
> +	TEST_ASSERT(rc == 0, "KVM_TDX_CAPABILITIES failed: %d %d",
> +		    rc, errno);
> +
> +	pr_debug("tdx_cap: supported_attrs: 0x%016llx\n"
> +		 "tdx_cap: supported_xfam 0x%016llx\n",
> +		 tdx_cap->supported_attrs, tdx_cap->supported_xfam);
> +
> +	for (i = 0; i < tdx_cap->cpuid.nent; i++) {
> +		const struct kvm_cpuid_entry2 *config = &tdx_cap->cpuid.entries[i];
> +
> +		pr_debug("cpuid config[%d]: leaf 0x%x sub_leaf 0x%x eax 0x%08x ebx 0x%08x ecx 0x%08x edx 0x%08x\n",
> +			 i, config->function, config->index,
> +			 config->eax, config->ebx, config->ecx, config->edx);
> +	}
> +
> +	return tdx_cap;
> +}
> +
> +/*
> + * For each CPUID leaf in @cpuid_data, filter out unsupported bits based on the
> + * capabilities reported by KVM.
> + */
> +static void tdx_filter_cpuid(struct kvm_vm *vm,
> +			     struct kvm_cpuid2 *cpuid_data)
> +{
> +	const struct kvm_tdx_capabilities *tdx_cap;
> +	const struct kvm_cpuid_entry2 *config;
> +	struct kvm_cpuid_entry2 *e;
> +	int i;
> +
> +	tdx_cap = tdx_read_capabilities(vm);
> +
> +	i = 0;
> +	while (i < cpuid_data->nent) {
> +		e = cpuid_data->entries + i;
> +		config = __get_cpuid_entry(&tdx_cap->cpuid, e->function, e->index);
> +
> +		if (!config) {
> +			int left = cpuid_data->nent - i - 1;
> +
> +			if (left > 0)
> +				memmove(cpuid_data->entries + i,
> +					cpuid_data->entries + i + 1,
> +					sizeof(*cpuid_data->entries) * left);
> +			cpuid_data->nent--;
> +			continue;
> +		}
> +
> +		e->eax &= config->eax;
> +		e->ebx &= config->ebx;
> +		e->ecx &= config->ecx;
> +		e->edx &= config->edx;
> +
> +		i++;
> +	}
> +}
> +
> +void tdx_init_vm(struct kvm_vm *vm)
> +{
> +	struct kvm_tdx_init_vm *init_vm;
> +	const struct kvm_cpuid2 *tmp;
> +
> +	tmp = kvm_get_supported_cpuid();
> +
> +	init_vm = calloc(1, sizeof(*init_vm) +
> +			 sizeof(init_vm->cpuid.entries[0]) * tmp->nent);

Would it be possible to use struct_size() here?
Or perhaps kvm_cpuid2_size(tmp->nent)?

> +	TEST_ASSERT(init_vm, "init_vm allocation failed");
> +
> +	memcpy(&init_vm->cpuid, tmp, kvm_cpuid2_size(tmp->nent));
> +	init_vm->cpuid.padding = 0;
> +	tdx_filter_cpuid(vm, &init_vm->cpuid);

How about something like this?

1. Query TDX capabilities first to get tdx_cap->cpuid.nent (let's say N).
2. Allocate init_vm sized for at most N entries, since the filtered
   result can never exceed TDX's supported CPUID set.
3. Iterate over the TDX CPUID capabilities, look each one up in
   kvm_get_supported_cpuid(), and append matching, masked entries
   directly into init_vm->cpuid.entries.

This would avoid the memcpy and all the memmoves, though this works
as-is. Just an optimization/different perspective.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> +
> +	/*
> +	 * Set attributes and xfam to 0 to use KVM's baseline config, as KVM
> +	 * automatically ORs in the mandatory fixed-1 bits during
> +	 * KVM_TDX_INIT_VM.  Note, TDX_TD_ATTR_SEPT_VE_DISABLE is not required
> +	 * because all initial private memory is pre-mapped before running the
> +	 * TD.
> +	 */
> +	init_vm->attributes = 0;
> +	init_vm->xfam = 0;
> +
> +	tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
> +
> +	free(init_vm);
> +}
>
> --
> 2.56.0.455.g6c5a503b38-goog
