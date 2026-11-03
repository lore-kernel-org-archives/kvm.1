Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.219.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793747565;
	b=Dv8ZUum8qNfMC7SJOuCSLWwZUE7QZYri2o4Tps4Mi4qd+CrErOPSIkZ4F/sUaHOz+Ej8
	 aWS6OdKJe5rI3t6+c7pkep4tTYlz1AXbR0zbm1TxZXp3Plor4EAkvkEKBM9WcfvzYNOFE
	 XZ4JzzX+5NS3Gp/N4n2eZoMAAIGrj5K0xjKRMuRC/Ioz7t3A9ffg1bntxttWVB7oKxwYc
	 /jOblRqA7xMBmjPIc35gtesMWuJnU0PXLnMe6JPBlGIHvd8hEv5En0y0JZVHr74LXY7lz
	 YRiXxDTkd1khzpWAtXxJZjwRu/41i/a0Fb6xJaFr8PsgNhPnoj9ZzkptJFTx87i6WQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ryvB2JGWPuZAAGR2GMJJClI5Kf6c0Mg6JzyuuAdWS2w=;
	b=cRsNu36m2R0wd9mUVQzC/rVhyOkl2vSH1z18DCiVDydq/mqPScBo4mVxt6UF+2NOMVRC
	 l+6IY1J0/sel9Kd5ayFe3oq2X7n5ye07IIfyFN7uYYAs1Htl0R092xEeHYsbYdL+y9Fh8
	 ie0/6oi0jFWcaEQ4k/pKdfAv5kcTBs8rDKbhMgwhfc94XmzqMcOi2sDMswSZ7iZQMJqEI
	 NrFlzxxg9gD4MPRwqYJRzi2qOaYHJytnmcZUEF4M6TS2jXZ5FvXv/I5vN2DjK0DVbySPA
	 fsE6GRH6yKYZkNW2CXYl/oVx7lhrwxi36M5N4Ejbgc+oJ6qaFJRv67gJlGuPJk8C6Gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="dfv4/YrN";
	arc=fail smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2105606A31B
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 23:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2105606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dfv4/YrN
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91c11468b5fso1738466d6.0
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 15:12:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793747564; cv=none;
        d=google.com; s=arc-20260327;
        b=ZhwaId0mLdkdOdupMTzdj5gLKtr6WQGF+83DINasYXEmE1g3YarGMPZkgRJveGrJx2
         Z3yNqKTt+rN9wcaZcXWOJslSC6YZhMphZ5DaIZNfWMq7hpabhtp+nRDvKAL6T0nNbA7B
         VSmQIT2EshJBfrHgYJgsEXv+oBfmDUWV08Bur2alKA6fBmRq7XJimILkYaFSPPFfEHAE
         n6VzupC5gaBzz5ARj6YIMTZKavRY1VtdDoxMbON+t6627ch35hnNtiNzLlIa8vZRga/J
         44JsCRdcWJKvXSzhJ6m2M1G5FyqfyXBBVhgHGY8R6tgmBUcuVJ0ZycuXzC9pE3WMrB7b
         UJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ryvB2JGWPuZAAGR2GMJJClI5Kf6c0Mg6JzyuuAdWS2w=;
        fh=c6BauxIrYUNGm1QI+jJRI/ZtYNTy/JWCwR6ZTRjkIVE=;
        b=hzjvHcSemzHuRPf40zBVTnXHv3x7j4j0fRIUnM+qburgAZUnSlOAEKN473BJwwgUv9
         R16aespnyEtMP/X8SnGjhnBeuLSUCxjivSyqbnDtZjBPtZwck1wAQrCGIJfzTCvfecPS
         ZwgJaOCHc4pB346/VmhT+Q05snjXHn3ysOqF0NU1wGqmMKXJPf1+UxGD5kdiTTyuxGPP
         Rm8EBbudYaW/aRYEFSuadni02Oobaz7k+WrZFzKxZOZH4r78dLbHkD9/sfX7Jo1RxfAj
         fQESz4E2d+oFJ8FSlCgoc9la75q58furLomCmlKRZOV8jP7IRHiVSVkgcwjxhc7nBEHL
         TafA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793747564; x=1794352364; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ryvB2JGWPuZAAGR2GMJJClI5Kf6c0Mg6JzyuuAdWS2w=;
        b=dfv4/YrNrWajbl+f5Dd5g5N04i4XaBjDX4Khx4jB1GJL7qGwpNqbR8mp4AFQQTgHUf
         KfTu2MZ1ucrKUd9FzcLa4GYI7L7UAhH/BTUL46wZBF+YrPG6K6Vt2EMzNU7auVggmtTc
         TUaUY/7hnlvnPnMQOpg5UjJB7A9qLE38IOnXhkusNF8OOYgJRJG3t12ByOxKUb98TeGI
         ywIGW3Qi2fhRK0le93P/9A1VoATXHPi8ykz4vBTx3jhzZ+E8Rl9cR9A3xOxPJOszPu6W
         Q5xD+93pqQw/pbw2Kh9O8uq2MuzpIRNJjdJHFsQNB5SLNG0w9965n7XobNxL3AOnht6o
         Djeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793747564; x=1794352364;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryvB2JGWPuZAAGR2GMJJClI5Kf6c0Mg6JzyuuAdWS2w=;
        b=N1FOwRr+vCyb9kY2half+iX6A7VIvZlcBDo6u7cAXgbXIxtY2wAjVytAGNPe0KUTnR
         z7g/KptHzSG8EnRw9ICP4qOQFiq2UY8ij8pEV8EHl8N4L1yBil+5pU0/UHJ/ATS3El2i
         SZeQ1aJuoSkEsngSNZG9b2R5j5H/Lt6Ja9+0CMN1v8sk0sFH6CseZ9Z0tR526oj8sNCW
         wCWTzqDhEa/hUZR74kAdtE8LOGk2VDDJi0h3/DuiFaIatAtVburL4knO6yu/ufHm8IKK
         2X7dmy5JavXP/dyo7EGa5L55bz1aqrJIJtUGaURU40sZLo3My1clXTFvcTPLAPi94ngD
         L5Hw==
X-Forwarded-Encrypted: i=1; AKwUvBwf8XAxUZq0J0eJAmJTO9zW+43ZPgfmsFQRLKwUMhP31HcB4HowoCYscMf9Zpn92JcBYQ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TouNfnzrSakbqKdAAj/JCaD8i4vj4tm0QdXp0HCGYVfmBkDK6
	2dhyQNGIoT5bj+p01sgOvmhTfkPxODFVtI2lyngiRd6gst4/XqhuvfEMDl9+WWAwJMDv1rOLs5N
	wQaguQ5wToxPe5z300AAYkOf0T6zEd0+3Fu1aAkcT
X-Gm-Gg: AYBFou23da79akNbcAdksyzP36eisY6Sxidbgq1m8d2vnfhX7o8wWkrHOqlvRE8M8DO
	Te/WNVrFJWcHWyHhfhzmLa+slxkornnBg91BgHuSoWWrRCcAevlb5zMGpsHDDlexI+K58Aha6o+
	kw1ds1U98ekEkbKLIVhpwX1fIKzecCckUJyl0I7jU/h7huzeKIaOzhO7JVCW/2zvA6c8l0UESfo
	EhE0gOAkTKnI06zqKzj61oDlwO5mQVO8wAPVcokhBLyB0Kdi0acPsiTysybcwGRE2aDj/8uRlEz
	y5VXTdsgXTFub45eboxaP4a/m1BYc5zIt3dSJzjsUqiQ5ydVwfUNMg5hULPoKO2V5sZ6xnnVMsh
	MynKRsI4mkMr7w5LuFASEOHhk1JSHbDwxnUzGwSGmltXvoaA+mZvKWi2W+mjAtC1gqFifAbH1oL
	W/EHwFrGVD9jHeUuzLk88BPJI=
X-Received: by 2002:a05:6214:570d:b0:91b:832d:ce5a with SMTP id
 6a1803df08f44-91ca4b833acmr247908926d6.48.1793747563253; Tue, 03 Nov 2026
 15:12:43 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 15:12:42 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261101071928.2462549-7-aneesh.kumar@kernel.org>
References: <20261101071928.2462549-1-aneesh.kumar@kernel.org> <20261101071928.2462549-7-aneesh.kumar@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 3 Nov 2026 15:12:42 -0800
X-Gm-Features: AclHuK-a6U90XRQ86I28YCLgetKuFVa0CnGLyQ5k0MglUtI4Y2OMEO9n6VKxkJo
Message-ID: <CAEvNRgEL5SuPBwGqwrUzD3Gb1iUonhvM488-3khHpQk8OkWr+A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/13] KVM: guest_memfd: Support device-backed PFN providers
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev
Cc: Alex Williamson <alex@shazbot.org>, David Woodhouse <dwmw2@infradead.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Steven Price <steven.price@arm.com>, Fred Griffoul <griffoul@gmail.com>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> Device resources such as PCI BARs supply PFNs directly and cannot use
> the folio allocation path. Store the mapping owner and device ID in the
> core context during attach(), and use them when preparing device
> memslots. Keep device memory separate from ordinary PFN-backed RAM.
>

I'm really hoping that device providers are just another kind of PFN
providers and not special in some way.

Please give me some time to prototype so I can see what can't be
achieved.

> Require device providers to use PFN_MODE and INIT_SHARED with
> architecture support for protected device mappings. Device providers
> require get_pfn(), but not the lookup_pfn_range() callback.
>
> Mark device memslots as guest_memfd-only and pass their device binding
> to the architecture. Resolve guest PFN lookup through get_pfn() for
> either shared or private attributes; the architecture decides how to
> establish mappings. Include both mapping types in generic invalidation,
> using the memslot binding to select the architecture unmap path. Host
> userspace access still requires shared attributes.
>
> Skip RAM population and PFN reclamation for device MMIO, which has no
> RAM pages to initialize or reclaim.
>
> Keep mmap, fallocate and attribute changes on device-backed guest_memfd
> files disabled until device mapping and conversion support is added.
>
>
> [...snip...]
>
