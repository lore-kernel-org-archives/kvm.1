Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0FC3F20EE
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497145; cv=none; b=cEZUqdonMd8q5QguHEWP4i3eJzuUJvIO5Xxcay5EMykeKIexUds5LkJMZ2AbA5PR1dWbTiCIIvHZCS6ywkpzWGIlVvxLcRCUHQhtjRfDkBK6jKlAJVQ8dNg5VpAT3pg4Hxe3l0j61r3rvct/fbyOvFNcdaHmpl4zfgTq1sRwHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497145; c=relaxed/simple;
	bh=pjB8XBmcLwr9zPI1lqewzOgCHaxXQGsSaHUZ1PExv5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dll+tu6BD5hAF7YovXWJ178EmVok3aSYg7GvEqSx8anb2G3ATM5tv2542jVGkTl/OKVb0mejXSDm6FIdEiQUWq6XFZdAoj/Ts8SV10ouXXVUsYMsJe3BbCz5sBpZGlsA5M57sDauN1ckcigT5v5eG67NfBda0oTmeuctdEhVSmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UMKVEU6Z; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UMKVEU6Z"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so3776855e9.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 00:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783497132; x=1784101932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1z5ci1yV4mbIoJ3VVwr6wBXV3Qix2cWYJIljHwqOWVc=;
        b=UMKVEU6ZxuvAGJYmFQkc+bpB3BbPU3nCZkF4JTq5pC74CRKrWWyjkgLSrz1e/cShPJ
         inzRVvNFnhYwPEXIiVByGjGQQZikC5ujr/m2jfIhfWv5MVdoSzqKrGtUPYumCwr5qmWu
         sXZvpFFwBDEumTJEykNau2ETzZlqBX2IqGqz4d5bygV9OU4E6zpg8ycJITafyQVlmX8Q
         vO3U0UgwbUMmd28vdFdCUQu0XF3TmIZoj0VkrzeyrzBEa5bEIgKRU079HmbjwfsdZzWG
         8LccoHI56oSDgTVItg6MgfNHXOZZDNCvznLZqskUg0sLz8pmBvY5H1bgSq3xoAMMtcb0
         mlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783497132; x=1784101932;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1z5ci1yV4mbIoJ3VVwr6wBXV3Qix2cWYJIljHwqOWVc=;
        b=des/GT8RE3J1YQqVbxCMkLcXl5RC1CtR13bpZBLwrisG5azdcw7KcOqNump1E/B5B6
         450OZPui6RQuQlJZ2RGRWRifCtEIgwok8Tv45hz/Xk7pl3+JRClNg5gtJIn7TLApmTG5
         yFQc5mkpdrmx56QA+N3S9u9Hq7+eUBb7JhXSXCWJFlRdtwuS7ATW7XseitI3SbzlYn+d
         FsbqMCFnUXc3qHT4xBi7N+6ageK+gvbLirKGA0owWEywUzVVkjcXUTiQwRNb36c7+N3R
         4oSKLES4LYcVrxjCmm6L4luqzmPXTJGFerKhxv8Ge64JK1PurFTxeN1VyGS5oRnC3rpI
         LMyQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYFTgL/Ot8zauQQwC+iXRLNsUvWuMs2RcoAC0GyVTxYZB6UGKh+Anp+4IbsBCiMtxR2a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDcvDdrR15FMRMbE8wWIVyrAqnVMU9bgEPN5/xB/X1ZtIqHMPS
	7TtkyP9so1c5bA7SyVnfn8fHyvzjGB6MWO5snQYaFGtGjva26bAD5Mw6IZ8vCodWzMA=
X-Gm-Gg: AfdE7ckdbk6VWZPsQALIbOrDFQGKXJBOxBkYUbSIckxq4+L8TBYR7OVDzwkmte1FFqK
	5onWL3eKUhcUptvRQ6KsFtokAxnVkvBns5NB+qbRiZjLFLRWa5TtJuclgRdQARpsVWSF/+8ahy0
	l7mVQgdq+biCk2KxeCOVYN582L1egDgSIBW3BueMCvD+uDXZLhptsaXuBO7deEEJKn5C2bxaWkX
	5J/BcijCm/wVrcUbzwLREdxFmrweezBXRltOFtEQTJA403gRnfBWYgdW1RyFAJwgGIAyHhmftM6
	gZeYzLdPoc6DeUmrOdwGcMzbGaji+80RpkTNBuz5Uvxsr6+d9HcAzokZvtrnIRnL/0D1xnFyCDr
	/7v8XSDrCjnvb6JWVv06NpN4htfS/my+3EKB4z3/zku5nsTWsk4gNihLWKFckGsvBOD8XusT96G
	um+hUkLLQ94AyG2o8=
X-Received: by 2002:a05:600c:6094:b0:492:28be:6098 with SMTP id 5b1f17b1804b1-493e68bef5dmr13224725e9.11.1783497132263;
        Wed, 08 Jul 2026 00:52:12 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.207.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm39654309f8f.14.2026.07.08.00.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 00:52:11 -0700 (PDT)
Message-ID: <d13c4073-b248-40ac-aa28-1c0dfc6b9043@suse.com>
Date: Wed, 8 Jul 2026 10:52:07 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/17] x86/virt/tdx: Prepare Quote buffer during
 extension bringup
To: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: djbw@kernel.org, kas@kernel.org, rick.p.edgecombe@intel.com,
 yilun.xu@intel.com, xiaoyao.li@intel.com, sohil.mehta@intel.com,
 adrian.hunter@intel.com, kishen.maloor@intel.com,
 tony.lindgren@linux.intel.com, peter.fang@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, dave.hansen@intel.com,
 dave.hansen@linux.intel.com, seanjc@google.com
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-9-yilun.xu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 xsFNBGcrpvIBEAD5cAR5+qu30GnmPrK9veWX5RVzzbgtkk9C/EESHy9Yz0+HWgCVRoNyRQsZ
 7DW7vE1KhioDLXjDmeu8/0A8u5nFMqv6d1Gt1lb7XzSAYw7uSWXLPEjFBtz9+fBJJLgbYU7G
 OpTKy6gRr6GaItZze+r04PGWjeyVUuHZuncTO7B2huxcwIk9tFtRX21gVSOOC96HcxSVVA7X
 N/LLM2EOL7kg4/yDWEhAdLQDChswhmdpHkp5g6ytj9TM8bNlq9I41hl/3cBEeAkxtb/eS5YR
 88LBb/2FkcGnhxkGJPNB+4Siku7K8Mk2Y6elnkOctJcDvk29DajYbQnnW4nhfelZuLNupb1O
 M0912EvzOVI0dIVgR+xtosp66bYTOpX4Xb0fylED9kYGiuEAeoQZaDQ2eICDcHPiaLzh+6cc
 pkVTB0sXkWHUsPamtPum6/PgWLE9vGI5s+FaqBaqBYDKyvtJfLK4BdZng0Uc3ijycPs3bpbQ
 bOnK9LD8TYmYaeTenoNILQ7Ut54CCEXkP446skUMKrEo/HabvkykyWqWiIE/UlAYAx9+Ckho
 TT1d2QsmsAiYYWwjU8igXBecIbC0uRtF/cTfelNGrQwbICUT6kJjcOTpQDaVyIgRSlUMrlNZ
 XPVEQ6Zq3/aENA8ObhFxE5PLJPizJH6SC89BMKF3zg6SKx0qzQARAQABzSZOaWtvbGF5IEJv
 cmlzb3YgPG5pay5ib3Jpc292QHN1c2UuY29tPsLBkQQTAQoAOxYhBDuWB8EJLBUZCPjT3SRn
 XZEnyhfsBQJnK6byAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJECRnXZEnyhfs
 XbIQAJxuUnelGdXbSbtovBNm+HF3LtT0XnZ0+DoR0DemUGuA1bZAlaOXGr5mvVbTgaoGUQIJ
 3Ejx3UBEG7ZSJcfJobB34w1qHEDO0pN9orGIFT9Bic3lqhawD2r85QMcWwjsZH5FhyRx7P2o
 DTuUClLMO95GuHYQngBF2rHHl8QMJPVKsR18w4IWAhALpEApxa3luyV7pAAqKllfCNt7tmed
 uKmclf/Sz6qoP75CvEtRbfAOqYgG1Uk9A62C51iAPe35neMre3WGLsdgyMj4/15jPYi+tOUX
 Tc7AAWgc95LXyPJo8069MOU73htZmgH4OYy+S7f+ArXD7h8lTLT1niff2bCPi6eiAQq6b5CJ
 Ka4/27IiZo8tm1XjLYmoBmaCovqx5y5Xt2koibIWG3ZGD2I+qRwZ0UohKRH6kKVHGcrmCv0J
 YO8yIprxgoYmA7gq21BpTqw3D4+8xujn/6LgndLKmGESM1FuY3ymXgj5983eqaxicKpT9iq8
 /a1j31tms4azR7+6Dt8H4SagfN6VbJ0luPzobrrNFxUgpjR4ZyQQ++G7oSRdwjfIh1wuCF6/
 mDUNcb6/kA0JS9otiC3omfht47yQnvod+MxFk1lTNUu3hePJUwg1vT1te3vO5oln8lkUo9BU
 knlYpQ7QA2rDEKs+YWqUstr4pDtHzwQ6mo0rqP+zzsFNBGcrpvIBEADGYTFkNVttZkt6e7yA
 LNkv3Q39zQCt8qe7qkPdlj3CqygVXfw+h7GlcT9fuc4kd7YxFys4/Wd9icj9ZatGMwffONmi
 LnUotIq2N7+xvc4Xu76wv+QJpiuGEfCDB+VdZOmOzUPlmMkcJc/EDSH4qGogIYRu72uweKEq
 VfBI43PZIGpGJ7TjS3THX5WVI2YNSmuwqxnQF/iVqDtD2N72ObkBwIf9GnrOgxEyJ/SQq2R0
 g7hd6IYk7SOKt1a8ZGCN6hXXKzmM6gHRC8fyWeTqJcK4BKSdX8PzEuYmAJjSfx4w6DoxdK5/
 9sVrNzaVgDHS0ThH/5kNkZ65KNR7K2nk45LT5Crjbg7w5/kKDY6/XiXDx7v/BOR/a+Ryo+lM
 MffN3XSnAex8cmIhNINl5Z8CAvDLUtItLcbDOv7hdXt6DSyb65CdyY8JwOt6CWno1tdjyDEG
 5ANwVPYY878IFkOJLRTJuUd5ltybaSWjKIwjYJfIXuoyzE7OL63856MC/Os8PcLfY7vYY2LB
 cvKH1qOcs+an86DWX17+dkcKD/YLrpzwvRMur5+kTgVfXcC0TAl39N4YtaCKM/3ugAaVS1Mw
 MrbyGnGqVMqlCpjnpYREzapSk8XxbO2kYRsZQd8J9ei98OSqgPf8xM7NCULd/xaZLJUydql1
 JdSREId2C15jut21aQARAQABwsF2BBgBCgAgFiEEO5YHwQksFRkI+NPdJGddkSfKF+wFAmcr
 pvICGwwACgkQJGddkSfKF+xuuxAA4F9iQc61wvAOAidktv4Rztn4QKy8TAyGN3M8zYf/A5Zx
 VcGgX4J4MhRUoPQNrzmVlrrtE2KILHxQZx5eQyPgixPXri42oG5ePEXZoLU5GFRYSPjjTYmP
 ypyTPN7uoWLfw4TxJqWCGRLsjnkwvyN3R4161Dty4Uhzqp1IkNhl3ifTDYEvbnmHaNvlvvna
 7+9jjEBDEFYDMuO/CA8UtoVQXjy5gtOhZZkEsptfwQYc+E9U99yxGofDul7xH41VdXGpIhUj
 4wjd3IbgaCiHxxj/M9eM99ybu5asvHyMo3EFPkyWxZsBlUN/riFXGspG4sT0cwOUhG2ZnExv
 XXhOGKs/y3VGhjZeCDWZ+0ZQHPCL3HUebLxW49wwLxvXU6sLNfYnTJxdqn58Aq4sBXW5Un0Q
 vfbd9VFV/bKFfvUscYk2UKPi9vgn1hY38IfmsnoS8b0uwDq75IBvup9pYFyNyPf5SutxhFfP
 JDjakbdjBoYDWVoaPbp5KAQ2VQRiR54lir/inyqGX+dwzPX/F4OHfB5RTiAFLJliCxniKFsM
 d8eHe88jWjm6/ilx4IlLl9/MdVUGjLpBi18X7ejLz3U2quYD8DBAGzCjy49wJ4Di4qQjblb2
 pTXoEyM2L6E604NbDu0VDvHg7EXh1WwmijEu28c/hEB6DwtzslLpBSsJV0s1/jE=
In-Reply-To: <20260618081355.3253581-9-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/26 11:13, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> During TDX attestation, the TDX guest asks the host to generate a
> signed, verifiable structure (a "Quote"). With the Quoting extension,
> the TDX module returns the Quote in pages that the host shares via an
> Extension-SEAMCALL.

nit: Just say the host provides the pages to the TDX module, no need to 
specify if it's via an ext seamcall or some otherway. One can infer this 
from the code itself.

> 
> The SEAMCALL accepts the host buffer pages as a linked list of 4KB
> "HPA_LINKED_LIST" nodes. Each entry holds the physical address of a 4KB
> data page, except for the last entry, which points to the next node. The
> TDX module reports the required Quote buffer size through a global
> metadata field. See [1] for details.

That HPA_LINKED_LIST is basically a linked list of arrays, each node 
into the linked list being the array, and each entry of that array being 
the HPA witht he last being a pointer to the next HPA_LINKED_LIST, so in 
a way a 2 level data structure. Can you be more explicit and just say 
something along the lines of :

"SEAMCALL accepts host buffer pages arranged in a custom data structure, 
consisting of nodes containing HPAs, arranged linearly, and each node is 
linked to the next one via the last entry"

> 
> For simplicity, let all guests share a global buffer. Build the buffer's
> HPA_LINKED_LIST at Quoting extension bringup. This saves a bunch of
> va-to-pa conversions at runtime.
> 
> [1] Intel TDX Module ABI specification, Section "Physical Memory
>      Management Types"
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>   arch/x86/include/asm/tdx_global_metadata.h  |   4 +
>   arch/x86/virt/vmx/tdx/tdx.c                 | 115 +++++++++++++++++++-
>   arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  14 +++
>   3 files changed, 129 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
> index b3442b7c88bb..17cb13a1bb40 100644
> --- a/arch/x86/include/asm/tdx_global_metadata.h
> +++ b/arch/x86/include/asm/tdx_global_metadata.h
> @@ -57,4 +57,8 @@ struct tdx_sys_info_ext {
>   	bool ext_required;
>   };
>   
> +struct tdx_sys_info_quote {
> +	u32 max_quote_size;
> +};
> +
>   #endif
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 06c42b86b05e..9716424a301f 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -32,6 +32,7 @@
>   #include <linux/idr.h>
>   #include <linux/kvm_types.h>
>   #include <linux/bitfield.h>
> +#include <linux/vmalloc.h>
>   #include <asm/page.h>
>   #include <asm/special_insns.h>
>   #include <asm/msr-index.h>
> @@ -71,6 +72,24 @@ static LIST_HEAD(tdx_memlist);
>   
>   static struct tdx_sys_info tdx_sysinfo;
>   
> +/*
> + * Quote buffer shared with the TDX module for quote generation, in HPA linked
> + * list format.
> + *
> + * @buf: Virtual address of the quote buffer.
> + * @buf_len: Size of @buf in bytes.
> + * @hpa_entries: HPA entries, starting at the first list node.
> + * @hpa_entries_pa: Physical address for @hpa_entries.
> + */
> +struct tdx_quote_data {
> +	void		*buf;
> +	u64		buf_len;
> +	u64		*hpa_entries;
> +	phys_addr_t	hpa_entries_pa;
> +};
> +
> +static struct tdx_quote_data tdx_quote;
> +
>   static DEFINE_RAW_SPINLOCK(sysinit_lock);
>   
>   /*
> @@ -1167,6 +1186,81 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
>   	return 0;
>   }
>   
> +static inline phys_addr_t tdx_vmalloc_to_pa(const void *addr)
> +{
> +	unsigned long pfn = vmalloc_to_pfn(addr);
> +
> +	return PFN_PHYS(pfn);
> +}
> +
> +#define HPAS_PER_NODE			(PAGE_SIZE / sizeof(u64))
> +
> +/*
> + * Pass the quote buffer to the TDX module as an HPA linked list, where each
> + * node holds 4KB page HPAs and the last entry points to the next node.
> + */
> +static __init int tdx_quote_create_buf(unsigned int npages,
> +				       struct tdx_quote_data *qdata)
> +{
> +	unsigned int nnodes;
> +	u64 *hpas;
> +	void *qbuf;
> +	int i, j;
> +
> +	if (!npages)
> +		return -EINVAL;
> +
> +	/*
> +	 * Each node holds up to (HPAS_PER_NODE - 1) 4KB page HPAs.
> +	 * The last entry of the node points to the next node.
> +	 */
> +	nnodes = DIV_ROUND_UP(npages, HPAS_PER_NODE - 1);
nit: It's somewhat arbitrary but num_nodes seems more explicit, saving 3 
chars is not worth it.
> +
> +	hpas = vmalloc_array(nnodes, PAGE_SIZE);

hpas is basically the starting node, so name it "nodes". Also I'm 
slightly confused why you use vmalloc to allocate a contiguous address 
space when the nodes are linked in a list? I.e you keep referring to 
list in the changelog and the code seems to be working in an array chunks?

> +	if (!hpas)
> +		return -ENOMEM;
> +
> +	/*
> +	 * ~0ULL is the list terminator for HPA_LINKED_LIST.
> +	 *
> +	 * Pre-fill the last node with 0xff bytes so that unused entries are
> +	 * terminators. Overwrite populated entries later.
> +	 */
> +	memset((u8 *)hpas + (nnodes - 1) * PAGE_SIZE, 0xff, PAGE_SIZE);
> +
> +	qbuf = vcalloc(npages, PAGE_SIZE);
> +	if (!qbuf)
> +		goto out_nomem;

'qbuf' is rather arbitrary here. You simply pre-allocate a bunch of 
pages which you then initialize into the nodes. Can't this allocation be 
moved inside the loop itself, of course it will increase the number of 
allocs happening but this is during initialization so it's not 
performance critical, yes?



> +
> +	/* Populate the linked list */
> +	for (i = 0, j = 0; j < npages; i++) {

nit: This feedback was given before, but both variables can be defined 
in this loop.


> +		if ((i % HPAS_PER_NODE) == HPAS_PER_NODE - 1) {
> +			/*
> +			 * The last node entry always points to the next node.
> +			 * The address of the following entry must be on next
> +			 * node's page boundary.
> +			 */
> +			hpas[i] = tdx_vmalloc_to_pa(&hpas[i + 1]);
> +			continue;
> +		}
> +
> +		hpas[i] = tdx_vmalloc_to_pa((u8 *)qbuf + j * PAGE_SIZE);
> +		j++;
> +	}
 > +> +	qdata->buf = qbuf;
> +	qdata->buf_len = (u64)npages * PAGE_SIZE;
> +	qdata->hpa_entries = hpas;
> +	qdata->hpa_entries_pa = tdx_vmalloc_to_pa(hpas);
> +
> +	return 0;
> +
> +out_nomem:
> +	vfree(hpas);
> +
> +	return -ENOMEM;
> +}
> +
>   /* Initialize quoting extension */
>   static __init int tdx_quote_init(void)
>   {
> @@ -1185,12 +1279,25 @@ static __init int tdx_quote_init(void)
>   
>   static __init void init_tdx_quoting_extension(void)
>   {
> -	int ret;
> +	struct tdx_sys_info_quote sysinfo_quote;
> +	unsigned int nr_quote_pages;
> +
> +	if (!(tdx_addon_feature0 & TDX_FEATURES0_QUOTE))
> +		return;
>   
> -	if (tdx_addon_feature0 & TDX_FEATURES0_QUOTE) {
> -		ret = tdx_quote_init();
> -		WARN_ON_ONCE(ret);
> +	if (tdx_quote_init()) {
> +		WARN_ON_ONCE(1);
> +		return;
>   	}
> +
> +	/* Quoting metadata is valid only after initialization */
> +	if (get_tdx_sys_info_quote(&sysinfo_quote))
> +		return;
> +
> +	nr_quote_pages = PAGE_ALIGN(sysinfo_quote.max_quote_size) /
> +			 PAGE_SIZE;
> +	if (tdx_quote_create_buf(nr_quote_pages, &tdx_quote))
> +		pr_err("Failed to create quote buffer\n");
>   }
>   
>   /* Initialize TDX module extensions for extension SEAMCALLs */
> diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> index 84364da89649..1eb2985307c6 100644
> --- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> +++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> @@ -151,3 +151,17 @@ static int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
>   
>   	return 0;
>   }
> +
> +static __init int get_tdx_sys_info_quote(struct tdx_sys_info_quote *sysinfo_quote)
> +{
> +	int ret;
> +	u64 val;
> +
> +	ret = read_sys_metadata_field(0x2300000200000002, &val);
> +	if (ret)
> +		return ret;
> +
> +	sysinfo_quote->max_quote_size = val;
> +
> +	return 0;
> +}

