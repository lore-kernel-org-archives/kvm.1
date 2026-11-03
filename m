Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731023;
	b=aZHWcup9GESeyCK0g6yxXz2oY/9MuWkeDQn+rDj1antxG3JtPbk2g8d4xCsKDYRjp6Te
	 QTPynnq1hlzbhJ71i72F2MuLvDi8b+HP1FCUUmN41w9ZG7+iJpBGZU7d5fyaiDGwskPql
	 kfhKZuE/TmTPBl5qeFQ/u/HOLWtae3CPjSVVRiBun2xFjvOeeNoCNvcrNcZGRq6AyorLi
	 9w3wqCOrlxEf+WPFwBL4K6x1H6E2iPYsHFdxGNdpL/b4XM/Jgfwp7Fz0lAOus7LeL7Le0
	 lHdyeAeUWcDS13+istOfAHkkKKp+65sELV79VQSXs5BLsjohUJCKYVeGoCmuUpDipkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MtYqIPmCoO6r7ieWdDjT3mJHSPCz3ZeRLZvBXwBPxaI=;
	b=06aUceGaTBJp9iONBpd36Im3lbki+P2vGUw2mFwZFWQUe+JPErzyLTERnuLXjlaAMhp9
	 GBCoFLZhf7Fw96mNMnkixsWMBlUOzQ0P8vHedZqkZplt2+5v4DckED+smj7KB3nJIZKb5
	 Fyt+Nb9lrzfqMFC42By2Y0A3wJmSGGBRkznJOseWe9gb91OaZiO0gFfSarTxK9Yah6wO1
	 lSq8ngIPiO9/9F4T9lkkLabgVz4W4uEHeDJcuYjQGuQVNTVhaV0rT7spgXcdaepaB34VN
	 rXPwnuwFKV284FvO+7YeYX5iYzcHTVLYEEk2zXMb07fntQ8eGWPgb15Mksx4RRuMWtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="BQL/b/eL";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7225606A328
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 18:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7225606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BQL/b/eL
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so36734795e9.0
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 10:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793731021; x=1794335821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MtYqIPmCoO6r7ieWdDjT3mJHSPCz3ZeRLZvBXwBPxaI=;
        b=BQL/b/eLVITLd4UmF+Oph9l1+/n1PjUoywo1PaTaxLXhfTMks4LRR95gFd7fke+p5j
         jM8eoaI+cL2iX1rM8HJJuxyrMb1YAy2MPG93Bz2Vf/TNiZp6x3Hu79S/ivtKSfnEoBQi
         GA8V5fmkIOmSSxklZfRjoJc/Rl5EwXP9Pre83e6OIqma6AHGl2gM1ladxMXCBt6XlSQo
         XK6L8gV/xOi7zCnaZWgulWoECy91fEbBUQ5vIJmTkqrZZjZ/l5gwC7quRHDnXkJlxJTc
         uDOunS4siQnctExCcF+qqF7dpZxboOqwolJLZmxEFg/wWOConckrPM9hYyv/bI8bFWFz
         zZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793731021; x=1794335821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MtYqIPmCoO6r7ieWdDjT3mJHSPCz3ZeRLZvBXwBPxaI=;
        b=lPKDd7vSV8t5k7EnjtcR2hRAFP7r0/VlJjdkjWDeJt8KQcApdyLPC6H0nP1Eb6zGB+
         tsaLCb1g3LA5Iq01aukYThfwRs0kjS8P/pttua+73P58UvmfqFJYJjqn/oJzCJK7Iv3A
         +1M/sT+q4orkTR+uFGen2dfNdCL/GH/0XshwxxUjrq9Y2JjHVzLfjMBEjaQ14FBH6MMQ
         +LLrrMjjgka1FK+6tpZkyXxUax7P1JqDVr+UOP99IowJVTj7lJ01l/+37ChGvYWvStPz
         Pz1fNfMiZF3gV2v8Q2rB+Anrwe1NLRG35FnBgf+JDQaI5Vn+4Qz+NPZ7iiU+L2jSB31J
         SviA==
X-Forwarded-Encrypted: i=1; AKwUvBzCdC9X3nbEfMH+8s32JclpmvSkRYnVqr/jzs/fQ8mzx8WFwjZe37qgpVMbBewfSUe0xeA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Q2jRCa6yAqc9K+gfaFZjMiPDtURguf7X1UZZ7Hoauag/ahbPU
	4WD4ylKPcIM5dOuHGRcCPUDzqWTYq75avyIP0NTyzgKpuFxykkZaO/86
X-Gm-Gg: AYBFou2hrP3VsjE4UX2nR661gLXOCLOuCwQGtrzkJPlBQCes1nTnqVnp5YLeYr21EBk
	QMuTmfugsJe8B3XPIHXJfPnyx1ZWLH6d566M7nmLeKRiw4R/ZEto2R6berWnzpFKtNoy3tZh2S8
	yo6iA39K7p/DfOzlkPzVIrKe+1GVC41vLxoMlKwBdK4FEv/svnvw6f9fIYippHpGU9bFwQrO9/G
	cgefrqYywHUBUW3jJWd4xzpW3p5H4JOksnu2EUWpHQz9HZPjeYCOc90P2jKYVlFJF+tJqcKktS4
	sLLu/WtazCUQRQ70d4QveI20lpRtqLVfVMbOtowfU+xpnYa+fqMt0ApOeRimbkkXcQWqx38Xhvi
	X3f00QADVMtFCfZwdxcbNS4MF17vHKs6h4ydA7TSfNizfartX/ode/ZZ8bjQIJty0kVjwSpSAnV
	Rva6OjQ5zJpyXIayu46yX8cHYBQTGq97waIJRiWSCsEXvXxg29C/PW8lg88crf6cq+UeJEXfLtE
	QvwBsRdOqyVn5IVi0joZeNEgEHu78bnh6Kum4aiW3KrEZJQKc7xX3UepXZlsNNZntIIu8VtYDI/
	f9UfV2N0ixKb47Nq3CwbaW8HyU0GVdDBRSvRD8Y571jOclZDAg813wRUIHm1/tIMdoBH8SOycG6
	CeeiWXDzmz+de6j0Z6fcmnPDRxdB+KXXYX+WtechKkEA4CH4+oFM1kM5+5k6E3KOzZE7MD2rHhv
	CvD/ylovXlo8k=
X-Received: by 2002:a05:600c:470d:b0:4a2:191f:7cb8 with SMTP id 5b1f17b1804b1-4ac1899378bmr308379315e9.17.1793731020767;
        Tue, 03 Nov 2026 10:37:00 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a1dsm25588404f8f.24.2026.11.03.10.36.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 10:37:00 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev
Cc: Ackerley Tng <ackerleytng@google.com>,
	Alex Williamson <alex@shazbot.org>,
	David Woodhouse <dwmw2@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Will Deacon <will@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [RFC PATCH v3 00/13] KVM: guest_memfd: Add a common framework for device memory providers
Date: Tue,  3 Nov 2026 18:36:59 +0000
Message-ID: <20261103183659.82433-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101071928.2462549-1-aneesh.kumar@kernel.org>
References: <20261101071928.2462549-1-aneesh.kumar@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> This series adds the common guest_memfd support needed by device memory
> providers. It builds on the resource-provider API [1] and the existing
> folio and RAM PFN backing support.

Hi Aneesh,

We both build on Ackerley's PFN mode [1], so here is where my export
series [2] stands and what I think it would take for the two to fit.

The export lets iommufd map a guest_memfd file without pinning it:
iommufd looks up the frame behind each shared page, and guest_memfd
calls back on every change, so the IOMMU mapping follows conversions,
punch holes and provider revokes. In the next version, the lookup
only uses lookup_pfn_range(), since it runs outside the invalidate
lock, and frames carry attributes (read only for now), which Ackerley
has offered to take into his PFN mode series.

Your patches 01-05 fit well with this: the backing ops table is the
internal provider table Ackerley's base left as a TODO, and the export
hooks stay in the common paths you keep. I tried my series on top of
yours and the conflicts are mechanical.

For device memory, I see three things to align:

1) lookup_pfn_range(). 06/13 makes it optional for device providers,
   but it is the only lookup that works outside KVM's fault path. The
   export needs it, and 07/13 would benefit too, instead of calling
   get_pfn() page by page to find contiguous runs. For vfio-pci it is
   the same BAR start plus offset as get_pfn(). Could it stay
   mandatory for all PFN mode providers?

2) The memory type. The IOMMU needs to know a frame is MMIO, and a
   prefetchable BAR may want write combining, which the fixed
   noncached mapping does not allow. A frame attribute, next to read
   only, would carry it to KVM, the VMM mapping and the export.

3) vfio-pci for ordinary VMs. Today a device provider needs a realm
   (kvm_arch_gmem_device_supported()) and gets the VM and an RMM
   binding at attach. vfio-pci is probably what will make the case for
   PFN mode upstream, and that is easier if it first works as a plain
   provider for any VM, x86 included, shared pages only, with the
   realm parts (private conversion, binding, lock()/unlock()) on top.
   It would also bring back P2P: vfio-pci refuses to attach while a
   dma-buf of the device exists, and with the export iommufd can map
   the shared BAR pages through guest_memfd instead.

I'd be glad to see v4 posted, or I can wait for 7.4-rc1. I'll reply
to a couple of patches separately.

Thanks,
Fred

[1] https://lore.kernel.org/all/20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com/
[2] https://lore.kernel.org/all/20261027154649.91571-1-griffoul@gmail.com/
