Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314919;
	b=As9dzSZ5x5jnwRLCyolaSDtGTb9cg/pRH+SHwghJRsalinrfRElaQKl53HPZ8iQsu6jQ
	 QrL183q20EbUXPLMF2QfvXj7bkRSISwrKniQJ/NfPNsnAwOJhgNh882HGAaffglnMvS1B
	 ODcniO0n+/YsWbmvI3djV/NE3Tfx+bLp7XrPdpjFrdVH1Ak73MdygbZs43rYVsQx1Od9X
	 soXgtIuwboRSFaP004DagIMlzkALzgQfHakeZFbSlKK7fii28Iej5FDxuPZSHyluRucbq
	 XH7M4GCoPGnFNlhbxPkw8OEGkMhj3GZRCIfzMTTC9yOmV1mRxRIbsxxjcXHK+3IEYbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=ZGhJU+UzWHjWLO2uCHz/PaJEOnJdiVDGFcBGvFMPQDM=;
	b=udNgxYpz07PgtioOaz7Qd3kV7dWgAvySIw7Tz73oEqb580vQgzBqGV9EiayAuKVO+RJl
	 8V0gUYzkZ64xnlNMnPIWfh6WF+AzfiW8zDwOFQNiNSPJ+OgX+Fh3fnfU+sj7aZE+KMGgE
	 cOhwrmA6UZRBDVXsZo7m2ge4YQkLAGDb/SS56Axg5RXpLyw5807xbRX9Yh/a6SVSt3LwQ
	 glfzB11p+661RlwFnlOE5S95Q0bovtPnljT0mPliQFzVtYfaU9yGXmQddTtRdfpQhZWRU
	 VGB5IPAeWOHBH5tHU7PwADPqZXx60ZLLLCaGYKQo+vPfQyTI/OQrslUS0uN2m8aqCmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=dsBbq5KO;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B73606A33D
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 12:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69B73606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=dsBbq5KO
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so1304077e0c.3
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 04:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794314918; x=1794919718; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZGhJU+UzWHjWLO2uCHz/PaJEOnJdiVDGFcBGvFMPQDM=;
        b=dsBbq5KOnMazC5mXTdmBJUmpnmxAJ9stpdG1ZK4VhrJSVsiUqApOhgOZP5UQsc9fPC
         bylnE8u5JvqmMPVDCOLJRGMGVmsY/uuhglwOP0Up3Y/FYDzu7ww/clI0XK63cih1jz0z
         cRBEmk14Bxs7np5BoBCvTSEZZwNs1IhNWcUU2kpBXHszqUUfjWdvx7p5Z6oWFEKT7nDT
         0nfRnkW2EH7Uhn9zo5tS94scUsMNfs7pypANJg9jRm9+H1VC8E/FoTH0vZ6swv2eUj/q
         clEhV7+ZwbICuHdSd4YmTpeJnqcBIKxe+HHNl+yAkB7VlEMOQLwhZnaYNrqImJiz3Iu8
         AMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794314918; x=1794919718;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGhJU+UzWHjWLO2uCHz/PaJEOnJdiVDGFcBGvFMPQDM=;
        b=X+HUdrkZWHuQ0PP0EdBcfkn7eQFtItbby/Fz5HlKRXdU6G8oA76J4J3Jg697m/zJ8K
         H0dePuFgkM2mL/Zrwe8YSr7LhdoGFGRh4XEYQYxPB/6gPuajeBfBZr0GDBUU/0az4yeP
         aCshKDxjp9NCjZno0HoKaxyPhVTJ8pQB3Camz6LkwXixFLBvQfhtAK0qthrDGKYFTkwU
         wBylR/VlJwSdwUTkHmwrWY0jvkLOAHkAHxzkWp6BjRC9tu/KARzA5FEMVSj9CFSXFnb/
         4582LPLb7z7RZonFQ6duZ2UftGV/Y5UTdeUKiLov/QT6ErQwadY1ojiXVQPJANaVC2xD
         LCLg==
X-Forwarded-Encrypted: i=1; AL+hErHBKEYKTIQloJmNtVPKrCqlRyesdn9eFEQ5CqF0Q7/GK85ccTn3bEgJQnJz5WbOc4gU9EY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PnhruK9wbh8uVLklffn6Y9YDAJqLXyTJQTUzNIhK2le+dJi7A
	HhxmlL/ld1a1X44n0ZYVnofqPFhN/0oESsNJONdxEqkSnzBBb+s2J1UsNahlsSgjaUA=
X-Gm-Gg: AYBFou2v7/HoJcgd8W2OGBBtsGnPr6asx1efyPjNvvj9my8rpj73TR+57CvOd/hGuQY
	S5HClApCzoe+fm/J2vmCZ/iBTVhfutLHELdSKj3cHtilMwKEy2yo6GYMooixMILmCCSrd8pc/Au
	Ut9faSEE8w0m6P8l0Qw/J2Ucij8+WK5Qkl+Aw0745Pz2UNILBlniJUGu47/xjin4uFfXMAAkciZ
	ysCqLpRXBU7l9PdgGCm59UP89Ksda0SaJVS0/dYxsJuarVnW3bHxlrTELivfny/jRZRTxF9CEdm
	pI5865LW3HTq8O0ACOQjUF+EEm72S3VXr7C8CFu7bYV7LUnHU2xZRLG4ziNBIkPK1vA7Kw0flLQ
	WVVb1J5x6J7szSqbz6aaHRAgM9hfTcRqzr39De06C0uhvnAF20PuvmhiazEun7LD3a4EGMRGDBs
	LlZkir1bRLaAmnFCwlMl2zENuGgPfD52V12cnwmzlLIDKqtwytsdy7roFQiAch0Ck+j8x6Z0V1S
	Ch3uk/wqA5OhEXb8iieHCne33pGXviJJw2S9AqpGuyTdx/6FWh2YrmEYJtmAwogirfirUGO8p3F
	T6eA4c5RCTRvH1o7Dnwx2A9UogW7cuVCntSuWbMknZ0EIMtXHqhi26xgS7k0ATc4vmVdomGo+rl
	BBp3wTvSTZ/qMFPBFOkC2ZbAWU9AQtiRAOQrRu+y/4SOFYIdWW2qq
X-Received: by 2002:a05:6122:32ce:b0:5ea:b972:1403 with SMTP id 71dfb90a1353d-5ee0cf152b1mr755444e0c.3.1794314918133;
        Tue, 10 Nov 2026 04:48:38 -0800 (PST)
Received: from localhost (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5fd00esm1555554e0c.16.2026.11.10.04.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 04:48:37 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 07:48:36 -0500
Message-Id: <DMRJJX2ZSYQT.2U1TTBGE7R4RA@soleen.com>
Subject: Re: [PATCH v4 00/19] kho, liveupdate: Add feature header for
 fine-grained ABI compatibility
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261110050202.529473-1-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>

On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:
> This v4 of feature flags support for LUO and KHO is no longer an RFC.
> This has gone through multiple design changes over the past few months,
> and I thank everyone for providing their suggestions and reviewing it
> promptly. Below I talk briefly about the evolution of this series to set
> context and try to make it easy for everyone to review.
>
> Initially, Logan proposed the feature flags in RFC v1 [1], which tried
> to solve the problem of dependency on the compatible string. Feature
> flags introduced finer-grained compatibility. This series had three
> fields: active, supported, and required. The number of flags was limited
> and didn't have flexibility, which reduced the complexity of the patch,
> but put a limitation on the extensibility of the features.
>
> After LPC and a few design discussions, I proposed RFC v2 [2], which
> changed the flags to optional and required and converted the encoding to
> 2 bits per feature instead of having two separate variables. But This sti=
ll
> has the number of flags limited and fixed the feature header size to
> 128 bytes. Though each serialized structure is being allocated in
> multiples of PAGE_SIZE (folio order =3D 0, 1, 2...), where 128 bytes is
> not a problem, it still carries two fundamental issues: limited feature
> flags, and a fixed 128-byte memory overhead for each preserved file. In
> the future, as there are plans for moving to KHO slab, the allocation
> for serialized structures can be significantly reduced and this 128-byte
> size will be a problem again.
>
> Based on the RFC v2 discussion, this v4 (v3 [3] was intentionally ignored=
)
> moves to extensible feature flags with a variable-length flags[] array,
> avoiding the fixed 128-byte overhead and feature-count limit.
>
> Along with this, as discussed on RFC v2, v4 uses separate bit ranges for
> required and optional flags (1 bit per feature). It builds on the
> consideration that a feature in its lifetime will either be required or
> optional; it can't be toggled into the other. In the future, if such a
> need arises, a new feature flag can be introduced to replicate the
> feature as optional or required, opposite to its ancestor flag.
>
> This new layout and encoding in memory is as follows:
>
> struct kho_ser_hdr {
> 	u32 size;
> 	u16 nr_required;
> 	u16 nr_optional;
> 	u64 flags[];
> }
>
> where,
> 	flags[i] =3D (BIT_MAP(optional_features) << nr_required) |
> 		   BIT_MAP(required_features)
>
> This series introduces the feature header in the KHO subsystem, and it
> is used by serialized structures across KHO and LUO. A few of the
> serialized structures embed other serialized structures directly. To
> keep the relative offsets of fields to be same across kernels, we cannot
> have an embedded serialized structure's size changed; otherwise, direct
> casting will not be possible. To solve this, this series converts those
> embedded structures to KHOSER_PTR, which points to the memory just after
> the parent serialized structure, and allocation and preservation happen
> for the total memory (parent_ser_size + embedded_ser_size).
>
> <Iamparent>_ser {
> 	u64 a;
> 	u64 b;
> 	struct <Iamembedded>_ser e_ser;
> 	u64 d;
> }
> 	CONVERTS TO =3D=3D=3D>
>
> <Iamparent>_ser {
> 	u64 a;
> 	u64 b;
> 	DECLARE_KHOSER_PTR(e_ser, <Iamembedded>_ser);
> 	u64 d;
> }
>
> There are only two such instances: kho_vmalloc and luo_file_set_ser.
>
> This series introduces kho_ser_hdr for the following structures:
>
>   - struct kho_kexec_metadata
>   - struct kho_vmalloc
>   - struct kho_block_header_ser
>   - struct luo_ser
>   - struct luo_session_ser
>   - struct luo_file_set_ser
>   - struct luo_file_ser
>   - struct luo_flb_header_ser
>   - struct luo_flb_ser
>   - struct pci_ser
>   - struct pci_dev_ser
>   - struct memfd_luo_ser
>   - struct memfd_luo_folio_ser
>
> If you notice, this also includes the PCI ser structures. PCI LUO
> support is merged in liveupdate/next, and this series is developed on
> top of it.
>
> Each serialized structure is preceded in memory by struct kho_ser_hdr
> and registered via DECLARE_KHO_SER(name, payload_size, nr_required,
> nr_optional). Both struct kho_kexec_metadata and struct pci_dev_ser are
> explicitly marked with __aligned(8) because their largest member is a
> 32-bit integer, and 8-byte alignment is required by DECLARE_KHO_SER() so

I do not believe we need __aligned(8), because the struct immediately=20
follows the newly introduced kho_ser_hdr, which is 8-byte aligned.=20
However, we should verify that the combined size (header + payload)=20
is 8-byte aligned.

> trailing feature payloads remain 8-byte aligned across 32-bit and 64-bit
> kernels.
>
> Also, Introduce DECLARE_KHO_SER_HDR(ser_name, fhdr) which is just the
> wrapper for struct kho_ser_hdr fhdr, This makes it clear
> To which ser_name, this fhdr belongs to.
>
>
> Series structure:
>   - Patch 1 removes __packed from KHO, LUO, and memfd ABI structures and
>     asserts their natural size and 8-byte alignment under CONFIG_64BIT.
>   - Patch 2 records entry_size in struct kho_block_header_ser so the
>     incoming kernel derives the entry stride from the block header.
>   - Patch 3 converts callers that embedded struct kho_vmalloc by value
>     (memfd_luo and test_kho) to reference it via DECLARE_KHOSER_PTR so
>     struct kho_vmalloc can grow independently.
>   - Patch 4 converts struct luo_session_ser to reference
>     struct luo_file_set_ser via DECLARE_KHOSER_PTR instead of embedding
>     it by value so both structures can grow independently.
>   - Patch 5 introduces struct kho_ser_hdr, DECLARE_KHO_SER(),
>     DECLARE_KHO_SER_HDR(), and the serialization/validation helpers in
>     include/linux/kho/abi/feature.h.
>   - Patches 6-18 add the feature header to each of the 13 KHO, LUO, PCI,
>     and memfd serialized structures in independent patches.
>   - Patch 19 adds a KUnit test suite (kho_feature) covering the feature
>     header helpers.
>
> [1] https://lore.kernel.org/all/20260903023452.721732-1-loganodell@google=
.com/
> [2] https://lore.kernel.org/all/20261021152527.375070-1-tarunsahu@google.=
com/
> [3] https://lore.kernel.org/all/20261026174217.603114-1-tarunsahu@google.=
com/
>
> Tarun Sahu (19):
>   liveupdate, kho: Remove __packed from KHO, LUO and memfd ABI
>     structures
>   kho: block: Record the entry size in the block header
>   kho, memfd_luo: Reference struct kho_vmalloc via serialized pointer
>   liveupdate: Reference struct luo_file_set_ser via serialized pointer
>   kho: Add feature header for fine-grained ABI compatibility
>   kho: kexec_metadata: Add the feature header
>   kho: vmalloc: Add the feature header
>   kho: block: Add the feature header to blocks
>   liveupdate: Add feature header to struct luo_ser
>   liveupdate: Add feature header to struct luo_session_ser
>   liveupdate: Add feature header to struct luo_file_set_ser
>   liveupdate: Add feature header to struct luo_file_ser
>   liveupdate: Add feature header to struct luo_flb_header_ser
>   liveupdate: Add feature header to struct luo_flb_ser
>   PCI: liveupdate: Add feature header to struct pci_ser
>   PCI: liveupdate: Add feature header to struct pci_dev_ser
>   mm: memfd_luo: Add feature header to struct memfd_luo_ser
>   mm: memfd_luo: Add feature header to struct memfd_luo_folio_ser
>   kho: Add KUnit test for the feature header helpers
>
>  MAINTAINERS                            |   1 +
>  drivers/pci/liveupdate.c               |  99 +++----
>  include/linux/kexec_handover.h         |  15 +-
>  include/linux/kho/abi/block.h          |  21 +-
>  include/linux/kho/abi/feature.h        | 372 +++++++++++++++++++++++++
>  include/linux/kho/abi/kexec_handover.h |  11 +-
>  include/linux/kho/abi/kexec_metadata.h |  17 +-
>  include/linux/kho/abi/luo.h            | 102 ++++---
>  include/linux/kho/abi/memfd.h          |  27 +-
>  include/linux/kho/abi/pci.h            |  66 ++---
>  include/linux/kho_block.h              |   8 +-
>  kernel/liveupdate/kexec_handover.c     |  98 ++++---
>  kernel/liveupdate/kho_block.c          | 172 +++++++++---
>  kernel/liveupdate/luo_core.c           |  43 +--
>  kernel/liveupdate/luo_file.c           |  58 ++--
>  kernel/liveupdate/luo_flb.c            |  69 +++--
>  kernel/liveupdate/luo_internal.h       |   9 +-
>  kernel/liveupdate/luo_session.c        |  55 +++-
>  lib/Kconfig.debug                      |  13 +
>  lib/test_kho.c                         |  38 ++-
>  lib/tests/Makefile                     |   1 +
>  lib/tests/kho_feature_kunit.c          | 184 ++++++++++++
>  mm/memfd_luo.c                         | 183 ++++++++----
>  23 files changed, 1271 insertions(+), 391 deletions(-)
>  create mode 100644 include/linux/kho/abi/feature.h
>  create mode 100644 lib/tests/kho_feature_kunit.c

--=20
Pasha

