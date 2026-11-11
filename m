Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378825;
	b=t+9G6tRt4VOzxy6jyX2DAd9SWkRpFSKLOoL5cPR55SJMN6usMQjyfg10Uy9rckHnMWiV
	 AIWSw4ARwQuupz5BQ4dJu5KnJzcMNfXAq8JwGIInyyBck68gjaN7YbtBK/dkn3dsN0YxL
	 waAXFYk4ubA2Bs3EMO2SojJC/gPxG85pOCT0dnmD0sp7PUU91dOVpqKUAsxaDcKc4AsAg
	 e54+txU7Z37aq8WdYVFRHyEbHEwrKToj2EceZDY8QfIMglkH1UxFTGxnBAQXQEbUFhnkm
	 jaZa6PZGCoiizinIwrEha96YJTTWrfBzQZXaKBZ6xEI1eEeN+fCItLkc1LNVZW01X+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=N2mgW6LEnNu8wNmnoa3+p3F6g8tYE7yJEu2kZeiGcR0=;
	b=IFT+tIB+1Fw73/MWXYQNSkQcWGhT/vFpObsoEzzHvEwL9T2yByMMOtFXOEcPQFIPs1ZK
	 PsUXrhKEQR+1810LqYxxu4vzJbZxydvgfLICIADY3IXT7Wo+KrHzTzuIKtqN/REgSmBk1
	 /QspCMN8POZABqrYVgTcOIqVsMr+JHwk03i8DpOXAYihGxzoxtxkYjPiET4yd/uqpkMRc
	 wz/Y5hkYPsa43NaJUUcThsZ5YjJBCGRvpcYLXY5nnzTd35wC0mAwIIUAot1y5r0ggaph3
	 qVQ9v2ZlMh8zkMAQG84tA5cmX/pafgIyYZCAEjkBS+Le2qAHozDvvoHzKN+KJ7oVFhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Qms/pbQJ";
	arc=none smtp.remote-ip=209.85.208.71
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1C606A320
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51D1C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qms/pbQJ
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b787b2746eso189518a12.2
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794378824; x=1794983624; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2mgW6LEnNu8wNmnoa3+p3F6g8tYE7yJEu2kZeiGcR0=;
        b=Qms/pbQJW3ljqh8X0oJjLVKNPkfZm0ujNUtE79vHO+UL16Xvk/VRqm7w0xI7VxNgtN
         wyzqIbxIDNIS+ON/Ysasnc4MNsAPaN5eCc0IPDV+A2a4erhA0tU7vYvtFP5F0QgFirWs
         Cx5gmMw21ZzUnvbkoMJkv5gp0buI38Uq2v2H6t27d0T75Pkb+uKVMtMqGjrcw+tYvmPd
         G1z52RcWFEv7CuMQiHnZVCXwBoTlb8un4IgbRArViwjGM7XoOGmKMRXM03sV9Bs6qcO8
         1F+9nMKUPw0cGrNBtowIegT/2FlFdOTVvJvDNPqjA1VGdr0eMuPdV/9y6h9Mm4Osl73A
         5Dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794378824; x=1794983624;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2mgW6LEnNu8wNmnoa3+p3F6g8tYE7yJEu2kZeiGcR0=;
        b=Ar5oDmCzYx2lxsFpnfv9RKLCd4TeJr95bOHYOUQ2Og2IBLh4z/yGNLt4rQb8ODWfPR
         odfg3+EqrLJvbUuT/hNggJffnWSTUFOejBPhbP9f9K1cjC9dmKzSa5cXDXUA9jv8bYNS
         MJoGfsFp/65BCDKAJcd+DHdLZcwgfeURppEgTpmjEzsLW9wFdci1SeHZEKNqMN9PP+Ch
         XEJNgcJbkUD7DDIbCtbSCYejnnz0klgQjDUiDHK4L7Agy4zGTyeqbeVZN0EGKJ9T529Q
         uWUcNuQO/wJMO4WH2/LEBv2mYtafsCacR/eKimACRhrY2kPzt3WL7Z18YYNwZzwpcEft
         b7pQ==
X-Forwarded-Encrypted: i=1; AL+hErHJjgrYb/X3iG0izChR2FfgO0vjJ+CpTt0EIH1Ya/ZjYav2pT4j0e6iwUZJm5fxzvg6Vk4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NCaD0LQ6LWHpW0sM8F0b70BOs8r93feTun/hpAvM7SqZE58IP
	GqnEqPZaFNv4/Cx14UVoxORdPaxqdnbjNEZhVz/LBFST4uurHlz1ltgAqm39sttOpLeeYkSGVTZ
	0hcYPTuGn3zR0U7OiqA==
X-Received: from edgi9-n1.prod.google.com ([2002:a05:6402:a589:10b0:6b7:8226:b2f0])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:613:b0:6b1:ce0f:eb6b with SMTP id 4fb4d7f45d1cf-6b777700516mr806340a12.31.1794378823419;
 Tue, 10 Nov 2026 22:33:43 -0800 (PST)
Date: Wed, 11 Nov 2026 06:33:42 +0000
In-Reply-To: <179432329215.2329176.14453669404153142360.b4-review@b4>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-7-tarunsahu@google.com>
 <179432329215.2329176.14453669404153142360.b4-review@b4>
Message-ID: <9huzv763q3ll.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 06/19] kho: kexec_metadata: Add the feature header
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org, 
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Pasha Tatashin <pasha.tatashin@soleen.com> writes:

>> The kexec metadata subtree currently uses a monolithic u32 version field
>> to identify the metadata structure layout. Any change to the structure,
>> even an optional additive field, requires incrementing the version and
>> breaks compatibility between adjacent kernels.
>> 
>> Replace the u32 version field in struct kho_kexec_metadata with
>> struct kho_ser_hdr using DECLARE_KHO_SER. Later fields can be appended
>> under new feature indices without breaking compatibility across kexec.
>> Also make the 3-byte padding hole between previous_release and kexec_count
>> explicit as reserved[3].
>> 
>> During deserialization, validate the blob size against the header size
>> and reject unknown required features. A legacy v1 metadata blob is
>> ignored with a warning.
>> 
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>>
>> diff --git a/include/linux/kho/abi/kexec_metadata.h b/include/linux/kho/abi/kexec_metadata.h
>> index e9e3f7e38a7c..316b3e5ad01b 100644
>> --- a/include/linux/kho/abi/kexec_metadata.h
>> +++ b/include/linux/kho/abi/kexec_metadata.h
>> @@ -18,28 +18,31 @@
>>  #ifndef _LINUX_KHO_ABI_KEXEC_METADATA_H
>>  #define _LINUX_KHO_ABI_KEXEC_METADATA_H
>>  
>> +#include <linux/build_bug.h>
>> +#include <linux/kho/abi/feature.h>
>>  #include <linux/types.h>
>>  #include <linux/utsname.h>
>>  
>> -#define KHO_KEXEC_METADATA_VERSION 1
>> -
>>  /**
>>   * struct kho_kexec_metadata - Kexec metadata passed between kernels
>> - * @version: ABI version of this struct (must be first field)
>>   * @previous_release: Kernel version string that initiated the kexec
>> + * @reserved: Reserved for structure alignment; must be zero
>>   * @kexec_count: Number of kexec boots since last cold boot
>>   *
>> - * This structure is preserved across kexec and allows the new kernel to
>> + * This structure is preserved across kexec and allows the target kernel to
>>   * identify which kernel it was booted from and how many kexec reboots
>> - * have occurred.
>> + * have occurred. Preceded by &struct kho_ser_hdr.
>>   *
>>   * __NEW_UTS_LEN is part of uABI, so it safe to use it in here.
>>   */
>>  struct kho_kexec_metadata {
>> -	u32 version;
>>  	char previous_release[__NEW_UTS_LEN + 1];
>> +	u8 reserved[3];
>>  	u32 kexec_count;
>> -} __packed;
>> +} __aligned(8);
>
> Why __packed was not removed in the first commit? __aligned(8) should 
> not be needed, given that it must follow DECLARE_KHO_SER which is 8-byte 
> aligned.

because this structure is not naturally aligned and we have o add
reserved[3] to make it aligned. So it will be ABI breakage. Adding
the KHO_SER_HDR is also ABI breakage, So I kept both changes in the same patch.

For the __aligned(8) part, yes we can remove it, I will update it.

>
>> +
>> +/* Register kho_kexec_metadata with KHO serialization accessors */
> here and in all other places, please remove this comment.
>
Got it.

~Tarun

>> +DECLARE_KHO_SER(kho_kexec_metadata, 72, 0, 0);
>>  
>>  #define KHO_METADATA_NODE_NAME "kexec-metadata"
>>  
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index 6f1f55fe3181..2edd772bb6d3 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -1740,6 +1740,7 @@ static __init int kho_out_fdt_setup(void)
>>  
>>  static void __init kho_in_kexec_metadata(void)
>>  {
>> +	DECLARE_KHO_SER_HDR(kho_kexec_metadata, *fhdr);
>
> Please don't do this, use kho_ser_hdr directly.
>
> -- 
> Pasha
