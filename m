Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794375422;
	b=uOHXN9WKXySKZAQvcuYEzPpwc5gVKvFv9FzGVYjE0VKTmPErVwbq7jykw/mParH60f5E
	 l9y0xE2zHuaHSBfj8xI5/HDmacr5OzGUEqQNTDaRWQuCeXM8v9i0dQZhOVybW+vy1+jBH
	 21+6FsoFnLJqp6yxy29sKc0gd4H0E5UuxEswaUFXQbMTuOd6YRqEJYdeaOURNeAu+8LYJ
	 CSEt/xNFzGQKw84ImmtmajVZ0444k3oqe1M1qfzljWNqiaQkusgsfjuV/fFBv4OTuSClk
	 s0f40UGPDRk3xgVrUZpKRAdNE1nxXmzONEuf1XHSO4gaIn4KQOdefw51xXFZgJR9WZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794375422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=eLmVTYOfswJ+cGfMoCZUFy1VK5TCu4veYLS+0REM4CM=;
	b=thcuo+M+ZesMFvNflYJf1WLRamCvGk60vrFNRh7HwmL02f3Os13s037Rc5hD/Z5igd69
	 jwp1CbzDa6+O6qRjtumafZ5QMOydWISe8qmTSmiPIyCaDhoT9RLlRGTRHSxLvXf17BfQd
	 M21oXp/z2tDrBSskiHYgEz2CgHv3czW971dFuB8p55Dv4iiovVbOfXDWxLR2Wbr3yGmf+
	 8Mk4N5GD4mEB4E/6mipIblZmFVb3y2e4N+j2dKuvX5X3JnvI2ZOq9BTm4H8MbqUkdXh8Q
	 fUp5x/q6CyZIzYgf1MaT9tgSsqF/Bpkw4EsC9YCISJR0j7TglYZz2Bn4VP5CLhtK3rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j0h7t6W2;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEFF606A321
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 05:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AEFF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j0h7t6W2
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so20822405e9.3
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 21:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794375420; x=1794980220; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eLmVTYOfswJ+cGfMoCZUFy1VK5TCu4veYLS+0REM4CM=;
        b=j0h7t6W2DhVdMUK6Ake7JqZjqrnTvHtViAvJAdnP83aR3NfgvIHJywMNNZw2qDFFYJ
         pZVHUlmqFSM0KTJ6KVSrk78AmbGhzrjkNyJThYbaCbowANuc6lSdDGXt5hINeyqJspkW
         6+9+aP/K6t57zRXMZvIa1sdCqATbWCBs0Af0GV+w/9ssx/kDyne1QjMnI7LNbeKsR2nY
         z2sf5dPvG4eOvKvELtfHTr97/MUcE9vGfDqwxg7s9FgiDgwLaLfE15EIe132P5/hGL2M
         iHhvk0FcES6c9vCnyFTpsE2akeQay/L41FGbDg0wZPy0W0HZvzH2GkJkEQUovdYlXLBz
         EZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794375420; x=1794980220;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eLmVTYOfswJ+cGfMoCZUFy1VK5TCu4veYLS+0REM4CM=;
        b=j+KVr5QbSkgrcdOiTiNMAIa+Fugqv+O/hhQlxP/0Z8qiIq1In0ZKgVoMHLW+/Fm05R
         tgudItTR78hN5PlNxF75/r8xULOYN8hmY+z9ScjFDDwZVvfWkC5sTNaoNX8lSypBaER1
         Xc8dY46/fBV0KQaOXyJT9NJYKpuNP32jwJaF6QDKJY3XNcpC6kHyO0woqJW7j90UWGwX
         qE6ZnrYag+XhdXvkzGRPQdrK/ZiZ3VKpBOotesmLYOi99+A56SqjIkeHjgJIk0/8j21N
         49tpehb9fap83ExOky9VQY3YwVr4cj8BKOEWH7jazuOeOkTz89Jh7JDG8W/PoinhEda0
         C55g==
X-Forwarded-Encrypted: i=1; AL+hErGuH+42+eLCRJk/ODveSCj9MVK6YIZyxEgm06uW0ZgtC0MXWH/rzv8RyGIYCEWVz5zPnU4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SXdjWqCxBN9b+uuNLozKSSUhRSFMNZi39rHMz5R76f0gEE0fP
	uJwNilgcx+w4Zo9TIf2ednMJNUEJnOhySKVQWR4HRGhhjVekteqmrMnfWi60BuDiPPoIJipbaLv
	O3b7yaDOEFeWh6pCsXA==
X-Received: from wmsl10.prod.google.com ([2002:a05:600c:1d0a:b0:4a3:5d5b:9ad9])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:810c:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4ba09379cc1mr15865455e9.7.1794375419814;
 Tue, 10 Nov 2026 21:36:59 -0800 (PST)
Date: Wed, 11 Nov 2026 05:36:58 +0000
In-Reply-To: <DMRJJX2ZSYQT.2U1TTBGE7R4RA@soleen.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <DMRJJX2ZSYQT.2U1TTBGE7R4RA@soleen.com>
Message-ID: <9huz5wy4q685.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 00/19] kho, liveupdate: Add feature header for
 fine-grained ABI compatibility
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
>> This v4 of feature flags support for LUO and KHO is no longer an RFC.
...skip
>>
>> Each serialized structure is preceded in memory by struct kho_ser_hdr
>> and registered via DECLARE_KHO_SER(name, payload_size, nr_required,
>> nr_optional). Both struct kho_kexec_metadata and struct pci_dev_ser are
>> explicitly marked with __aligned(8) because their largest member is a
>> 32-bit integer, and 8-byte alignment is required by DECLARE_KHO_SER() so
>
> I do not believe we need __aligned(8), because the struct immediately 
> follows the newly introduced kho_ser_hdr, which is 8-byte aligned. 
> However, we should verify that the combined size (header + payload) 
> is 8-byte aligned.

Yes, we can check total size alignment and remove the __aligned(8). I
will update it.

~Tarun

>
>> trailing feature payloads remain 8-byte aligned across 32-bit and 64-bit
>> kernels.
>>
>> Also, Introduce DECLARE_KHO_SER_HDR(ser_name, fhdr) which is just the
>> wrapper for struct kho_ser_hdr fhdr, This makes it clear
>> To which ser_name, this fhdr belongs to.
>>
>>
>> Series structure:
>>   - Patch 1 removes __packed from KHO, LUO, and memfd ABI structures and
>>     asserts their natural size and 8-byte alignment under CONFIG_64BIT.
>>   - Patch 2 records entry_size in struct kho_block_header_ser so the
>>     incoming kernel derives the entry stride from the block header.
>>   - Patch 3 converts callers that embedded struct kho_vmalloc by value
>>     (memfd_luo and test_kho) to reference it via DECLARE_KHOSER_PTR so
>>     struct kho_vmalloc can grow independently.
>>   - Patch 4 converts struct luo_session_ser to reference
>>     struct luo_file_set_ser via DECLARE_KHOSER_PTR instead of embedding
>>     it by value so both structures can grow independently.
>>   - Patch 5 introduces struct kho_ser_hdr, DECLARE_KHO_SER(),
>>     DECLARE_KHO_SER_HDR(), and the serialization/validation helpers in
>>     include/linux/kho/abi/feature.h.
>>   - Patches 6-18 add the feature header to each of the 13 KHO, LUO, PCI,
>>     and memfd serialized structures in independent patches.
>>   - Patch 19 adds a KUnit test suite (kho_feature) covering the feature
>>     header helpers.
>>
>> [1] https://lore.kernel.org/all/20260903023452.721732-1-loganodell@google.com/
>> [2] https://lore.kernel.org/all/20261021152527.375070-1-tarunsahu@google.com/
>> [3] https://lore.kernel.org/all/20261026174217.603114-1-tarunsahu@google.com/
>>
>> Tarun Sahu (19):
>>   liveupdate, kho: Remove __packed from KHO, LUO and memfd ABI
>>     structures
>>   kho: block: Record the entry size in the block header
>>   kho, memfd_luo: Reference struct kho_vmalloc via serialized pointer
>>   liveupdate: Reference struct luo_file_set_ser via serialized pointer
>>   kho: Add feature header for fine-grained ABI compatibility
>>   kho: kexec_metadata: Add the feature header
>>   kho: vmalloc: Add the feature header
>>   kho: block: Add the feature header to blocks
>>   liveupdate: Add feature header to struct luo_ser
>>   liveupdate: Add feature header to struct luo_session_ser
>>   liveupdate: Add feature header to struct luo_file_set_ser
>>   liveupdate: Add feature header to struct luo_file_ser
>>   liveupdate: Add feature header to struct luo_flb_header_ser
>>   liveupdate: Add feature header to struct luo_flb_ser
>>   PCI: liveupdate: Add feature header to struct pci_ser
>>   PCI: liveupdate: Add feature header to struct pci_dev_ser
>>   mm: memfd_luo: Add feature header to struct memfd_luo_ser
>>   mm: memfd_luo: Add feature header to struct memfd_luo_folio_ser
>>   kho: Add KUnit test for the feature header helpers
>>
>>  MAINTAINERS                            |   1 +
>>  drivers/pci/liveupdate.c               |  99 +++----
>>  include/linux/kexec_handover.h         |  15 +-
>>  include/linux/kho/abi/block.h          |  21 +-
>>  include/linux/kho/abi/feature.h        | 372 +++++++++++++++++++++++++
>>  include/linux/kho/abi/kexec_handover.h |  11 +-
>>  include/linux/kho/abi/kexec_metadata.h |  17 +-
>>  include/linux/kho/abi/luo.h            | 102 ++++---
>>  include/linux/kho/abi/memfd.h          |  27 +-
>>  include/linux/kho/abi/pci.h            |  66 ++---
>>  include/linux/kho_block.h              |   8 +-
>>  kernel/liveupdate/kexec_handover.c     |  98 ++++---
>>  kernel/liveupdate/kho_block.c          | 172 +++++++++---
>>  kernel/liveupdate/luo_core.c           |  43 +--
>>  kernel/liveupdate/luo_file.c           |  58 ++--
>>  kernel/liveupdate/luo_flb.c            |  69 +++--
>>  kernel/liveupdate/luo_internal.h       |   9 +-
>>  kernel/liveupdate/luo_session.c        |  55 +++-
>>  lib/Kconfig.debug                      |  13 +
>>  lib/test_kho.c                         |  38 ++-
>>  lib/tests/Makefile                     |   1 +
>>  lib/tests/kho_feature_kunit.c          | 184 ++++++++++++
>>  mm/memfd_luo.c                         | 183 ++++++++----
>>  23 files changed, 1271 insertions(+), 391 deletions(-)
>>  create mode 100644 include/linux/kho/abi/feature.h
>>  create mode 100644 lib/tests/kho_feature_kunit.c
>
> -- 
> Pasha
