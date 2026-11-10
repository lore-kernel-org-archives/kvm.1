Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331698;
	b=fxlYk87i8vLA52diCimQb/zjtwXv3C4Aw03QBvZ8/FQYPW2H4wsxC0YAHJATeHXU44nI
	 2vqBBX/YWNRkM3LVn0r5K98pzP01+5ZCVh3SX3INkkZx7QbxN3E+E82ApI5HUKMa3qChS
	 AeUFcOb7kftzK3clj4HOf/nqCt335+OHpM138rCQLtiAn1wWM9dYJUmPngefEgnqvKa5f
	 iyQZyPqc1G56+/d8Bkb42dSOIHu9+VexWt92fm38T5T+v2re8owoeG8erGh1Kvw9yIyZi
	 EjLIBQ8+yyg/SgocXw8rlPTOEy8loGmnTe9mwTWSD65CEkYM0GOlPHCdSkdpsfPywbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=+yZhs6ZDC6QJyZznmfCr4E8e0ia6+c834e+dfc1J9VY=;
	b=mh2gH5/g9YFphCpVyVwCO3IvNoTXW3tfmK9crsjfYTYOOGn3YiKGCslteLJK1LZjYdBM
	 2669abrAAaqpVYufhcC/xSGd5bPBqr6Weygx0N56wDH6VlUFztgQzX1+OnKVOTD/lm2wo
	 zlgfT4xEcKdLjh7wuh4evnLB0OcF+3q9j2lH1oKICKkoYMOSpy5mNiYWeUl26sD8/qf5V
	 E6YZLuCjAYNz2tFab75uaMar2r1w8AoABlM937nnhIbHd7SBGUleSyXhWFOrj/YJfBGpF
	 r9ijCp/sqTEjpXMSSt2iZXeb8/NB/4wOKYnq8tRYdI+ETJPLU2mqvZQsXUKUR/5+FAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fgwTT27Z;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF21D606A326
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 17:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF21D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fgwTT27Z
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c4d4d132bbeso268884066b.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 09:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794331696; x=1794936496; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+yZhs6ZDC6QJyZznmfCr4E8e0ia6+c834e+dfc1J9VY=;
        b=fgwTT27ZEHO8Zor9nHQ6ZTNIcAITVVSiZLZEA1unn4+IRDU37edYkEwPqFX3hbwj1d
         a/zhFQo/ErrbVLNsSb3ret8hlQX44drlL7hrbzadCUe9exKsYRgc/qO5FEQpspCU4Q+e
         cCpk4odLTHX9nvc9aM3gpKzUy0CJgcLiIg5rgSVYA2h7/H9io8l5duFt8ahruEvx3R1z
         pKS/QNO9N7z4h9XQalUTYMzkkn4anhbHXPAU6Wzm3uATLUCyW/gOXZhea85VjXynq3Xg
         eqFs7h+rJ80ColGg8eWunxZhDpTKvkbgOxVi+cedLoC0bGTxW87V2t+2IGkWf1uF1jKu
         GVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794331696; x=1794936496;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+yZhs6ZDC6QJyZznmfCr4E8e0ia6+c834e+dfc1J9VY=;
        b=ufS3YAN09HH/OIexTVudhTqMEKkecGgo3HgBws9S00bgWubnSvqz0z+9a4pjbN6gqz
         ZuehVgr2UUyWM4t37Bww3IOq1fNazDxL1gaNG9fiX+2TycuijwYnAVUkzqLa4aakaZ0e
         +nN8XYHdaAXcyu/aY16ufp2q2DuQCAdbKP12IcHFzdlsB08qi1RQlcJjgoomAfwJ976v
         GLkw8ACAhO3TAXc8M+ItquFswKefT7IUX/85B1yQddqlj6YKYFfrdseLIWiL8jkU6Bov
         9zm97S/XmKRhy7pwPhjnR+RpdAvfi/hAqxJJhQ4VF+TcUckKOktoFWm4hTUCjF0aiiUf
         HFBA==
X-Forwarded-Encrypted: i=1; AL+hErF+2b81qcDLg8KPvKxnltt1h+kILcBVHl4nJhusWVMxPplmkc46new2SilSuo4c2PYW6FA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LMpZA1Rns1mtiwkiiajqEZaga3vLEil/Lxk+AlnIIa/PAmOFw
	caGX0ZiOoKYj3lCZc9RpFFC52h3f0WYCAcn/Hpc+lLSdJOPHD+wLFww9x7jIDGFi+ghfQxObKZZ
	afocqOohYQrkMfQU6qw==
X-Received: from ejrk24.prod.google.com ([2002:a17:906:6818:b0:c46:7e9b:6a1c])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:dc91:b0:c41:1781:a2af with SMTP id a640c23a62f3a-c506338c761mr23579166b.9.1794331695882;
 Tue, 10 Nov 2026 09:28:15 -0800 (PST)
Date: Tue, 10 Nov 2026 17:28:14 +0000
In-Reply-To: <DMRJQ42LR1D3.1GZKU9EX48KZU@soleen.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-2-tarunsahu@google.com>
 <DMRJQ42LR1D3.1GZKU9EX48KZU@soleen.com>
Message-ID: <9huzbj7wtx3l.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 01/19] liveupdate, kho: Remove __packed from KHO, LUO
 and memfd ABI structures
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Pasha Tatashin" <pasha.tatashin@soleen.com> writes:

> On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:
>> All structures in include/linux/kho/abi/block.h (struct
>> kho_block_header_ser), include/linux/kho/abi/luo.h (struct luo_ser,
>> struct luo_file_ser, struct luo_file_set_ser, struct luo_session_ser,
>> struct luo_flb_header_ser, struct luo_flb_ser) and
>> include/linux/kho/abi/memfd.h (struct memfd_luo_folio_ser, struct
>> memfd_luo_ser) have naturally aligned fields on 64-bit architectures,
>> with no padding holes between fields or tail padding. Assert both the
>> structure size and 8-byte alignment under CONFIG_64BIT at compile time.
>> Any future unaligned field addition should come with reserved field to
>> keep the structure aligned.
>
> Just state:
>
> Remove __packed, as it may break natural alignment. Instead, ensure that 
> all padding holes are explicitly covered by reserved or similar fields, 
> as is already done for KHO/LUO serialized data, so no functional changes 
> are intended by this change.

This look good. I will update it. Thanks.

>
>>
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> ---
>>  include/linux/kho/abi/block.h | 10 +++++++--
>>  include/linux/kho/abi/luo.h   | 38 +++++++++++++++++++++++++++++------
>>  include/linux/kho/abi/memfd.h | 16 ++++++++++++---
>>  3 files changed, 53 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
>> index d06d64b963be..36bdbaf9b3b8 100644
>> --- a/include/linux/kho/abi/block.h
>> +++ b/include/linux/kho/abi/block.h
>> @@ -12,7 +12,7 @@
>>   * pre-update kernel to a post-update kernel.
>>   *
>>   * This interface is a contract. Any modification to the structure fields,
>> - * compatible strings, or the layout of the `__packed` serialization
>> + * compatible strings, or the layout of the serialization
>>   * structures defined here constitutes a breaking change. Such changes require
>>   * incrementing the version number in the `KHO_FDT_COMPATIBLE` string to
>>   * prevent a new kernel from misinterpreting data from an old kernel.
>> @@ -26,6 +26,8 @@
>>  #define _LINUX_KHO_ABI_BLOCK_H
>>  
>>  #include <asm/page.h>
>> +#include <linux/build_bug.h>
>> +#include <linux/kconfig.h>
>>  #include <linux/types.h>
>>  
>>  /**
>> @@ -49,6 +51,10 @@
>>  struct kho_block_header_ser {
>>  	u64 next;
>>  	u64 count;
>> -} __packed;
>> +};
>> +
>> +static_assert(sizeof(struct kho_block_header_ser) == 16);
>> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>> +	      __alignof__(struct kho_block_header_ser) == 8);
>>  
>>  #endif /* _LINUX_KHO_ABI_BLOCK_H */
>> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
>> index 288076de6d4a..721949374fa1 100644
>> --- a/include/linux/kho/abi/luo.h
>> +++ b/include/linux/kho/abi/luo.h
>> @@ -58,6 +58,8 @@
>>  #define _LINUX_KHO_ABI_LUO_H
>>  
>>  #include <linux/align.h>
>> +#include <linux/build_bug.h>
>> +#include <linux/kconfig.h>
>>  #include <linux/kho/abi/block.h>
>>  #include <uapi/linux/liveupdate.h>
>>  
>> @@ -82,7 +84,11 @@ struct luo_ser {
>>  	u64 liveupdate_num;
>>  	u64 sessions_pa;
>>  	u64 flbs_pa;
>> -} __packed;
>> +};
>> +
>> +static_assert(sizeof(struct luo_ser) == 32);
>> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>> +	      __alignof__(struct luo_ser) == 8);
>
> Please remove the two assertions above throughout this patch, as they 
> are replaced later in the series. In general, introducing add -> remove 
> -> add churn across a patch series is discouraged, as it indicates a 
> lack of planning.

Got it. Will remove it.

~Tarun

>
>>  
>>  #define LIVEUPDATE_HNDL_COMPAT_LENGTH	48
>>  
>> @@ -98,7 +104,11 @@ struct luo_file_ser {
>>  	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
>>  	u64 data;
>>  	u64 token;
>> -} __packed;
>> +};
>> +
>> +static_assert(sizeof(struct luo_file_ser) == 64);
>> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>> +	      __alignof__(struct luo_file_ser) == 8);
>>  
>>  /**
>>   * struct luo_file_set_ser - Represents the serialized metadata for file set
>> @@ -113,7 +123,11 @@ struct luo_file_ser {
>>  struct luo_file_set_ser {
>>  	u64 files;
>>  	u64 count;
>> -} __packed;
>> +};
>> +
>> +static_assert(sizeof(struct luo_file_set_ser) == 16);
>> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>> +	      __alignof__(struct luo_file_set_ser) == 8);
>>  
>>  /**
>>   * struct luo_session_ser - Represents the serialized metadata for a LUO session.
>> @@ -131,7 +145,11 @@ struct luo_file_set_ser {
>>  struct luo_session_ser {
>>  	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
>>  	struct luo_file_set_ser file_set_ser;
>> -} __packed;
>> +};
>> +
>> +static_assert(sizeof(struct luo_session_ser) == 80);
>> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>> +	      __alignof__(struct luo_session_ser) == 8);
>>  
>>  /* The max size is set so it can be reliably used during in serialization */
>>  #define LIVEUPDATE_FLB_COMPAT_LENGTH	48
>> @@ -152,7 +170,11 @@ struct luo_session_ser {
>>  struct luo_flb_header_ser {
>>  	u64 pgcnt;
>>  	u64 count;
>> -} __packed;
>> +};
>> +
>> +static_assert(sizeof(struct luo_flb_header_ser) == 16);
>> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>> +	      __alignof__(struct luo_flb_header_ser) == 8);
>>  
>>  /**
>>   * struct luo_flb_ser - Represents the serialized state of a single FLB object.
>> @@ -175,7 +197,11 @@ struct luo_flb_ser {
>>  	char name[LIVEUPDATE_FLB_COMPAT_LENGTH];
>>  	u64 data;
>>  	u64 count;
>> -} __packed;
>> +};
>> +
>> +static_assert(sizeof(struct luo_flb_ser) == 64);
>> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>> +	      __alignof__(struct luo_flb_ser) == 8);
>>  
>>  /* Kernel Live Update Test ABI */
>>  #ifdef CONFIG_LIVEUPDATE_TEST
>> diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
>> index 08b10fea2afc..376a724a1d8c 100644
>> --- a/include/linux/kho/abi/memfd.h
>> +++ b/include/linux/kho/abi/memfd.h
>> @@ -11,6 +11,8 @@
>>  #ifndef _LINUX_KHO_ABI_MEMFD_H
>>  #define _LINUX_KHO_ABI_MEMFD_H
>>  
>> +#include <linux/build_bug.h>
>> +#include <linux/kconfig.h>
>>  #include <linux/types.h>
>>  #include <linux/kho/abi/kexec_handover.h>
>>  
>> @@ -20,7 +22,7 @@
>>   * memfd uses the ABI defined below for preserving its state across a kexec
>>   * reboot using the LUO.
>>   *
>> - * The state is serialized into a packed structure `struct memfd_luo_ser`
>> + * The state is serialized into `struct memfd_luo_ser`
>>   * which is handed over to the next kernel via the KHO mechanism.
>>   *
>>   * This interface is a contract. Any modification to the structure layout
>> @@ -54,7 +56,11 @@ struct memfd_luo_folio_ser {
>>  	u64 pfn:52;
>>  	u64 flags:12;
>>  	u64 index;
>> -} __packed;
>> +};
>> +
>> +static_assert(sizeof(struct memfd_luo_folio_ser) == 16);
>> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>> +	      __alignof__(struct memfd_luo_folio_ser) == 8);
>>  
>>  /*
>>   * The set of seals this version supports preserving. If support for any new
>> @@ -85,7 +91,11 @@ struct memfd_luo_ser {
>>  	u32 flags;
>>  	u64 nr_folios;
>>  	struct kho_vmalloc folios;
>> -} __packed;
>> +};
>> +
>> +static_assert(sizeof(struct memfd_luo_ser) == 48);
>> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>> +	      __alignof__(struct memfd_luo_ser) == 8);
>>  
>>  /* The compatibility string for memfd file handler */
>>  #define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
>
> -- 
> Pasha
