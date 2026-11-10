Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327836;
	b=PPawI47qPboKwHWfQJKQI+63mK5UmHnbqVUhNW1LB7P6B2x2SMJP3o5YuMjceQWyGBiO
	 a5+Wl7VyVP9FebTWkxQs4qDNoimfmZLLQ3YrMbJr09cjjJrpkj2hgMBYQ+ljbZaFsn5hW
	 sWLGhCNJVkZhUpil6PUJIgkBGHJQAsEEInxD6r1wfCyH9fbn4HXggv8O1CHlpnD8mWIjn
	 ouKAJloMudwOprmV4UjZszeOrLINTmHPR0AqLJTWT03eoR2MwcrHKaJZrkkGRNhwCIK9j
	 3o1jqpMvueCAYzdqFh+Yx3EwpLa21krC+0Fx44zk/TJLZulOokkj63lEIxdlZwUsyAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=Mw9iOCkEBWkvxdLSgoJVCB6jT3T4ThA8jIPRTFH0lnY=;
	b=zN0cwEeC1dfVm+2rYmqQpUutvoRPPluvXYXPEBICzaeDU3i5n8HAzuBztBu4/x3xn1zT
	 l3UdMf4P7blH5Vc2Ut+qTmYvCcDFjihN4Q0wlS68Lmu7+Q6G5DnG56pwJPGTOliUMPXxx
	 8MHKq67Rptesapf3Db9RvlCHjGO4fm+znCpm87BdJOqaVzEJ5KHJ57rziAJPo9UOqpNQL
	 eT/sjhLmMqZIoMcjkf4sIHbebpKwdMTd2KXmy4y6CjyzfiXwsPei+dzsNp2bbMzwZmRgo
	 MJdReODb7ykzAqXF6I400iB1i63B/i2DfpTDfupvAsJ8gs94ywQxJJ774pW3d8dT6bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VSPzJL76;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383F4606A326
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 16:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 383F4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VSPzJL76
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e987a2ba0cso13295045ad.3
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 08:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794327836; x=1794932636; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mw9iOCkEBWkvxdLSgoJVCB6jT3T4ThA8jIPRTFH0lnY=;
        b=VSPzJL76+wTF7+tRHaTvgknu/rdXasZus90UA5dew9kegykwMMzKH/F1V6GxO7RQBH
         4/OoTFVOHyB4E03Dq2sjac2puiHJm+c4fvoFKJLJ6EEpCLTW90+KxQKP8Xk4x1JCosEq
         Qn1NC6kr4qdwt4JzE8ObsRxCsUeZmKjtT2SBeeizeKBMIl7bOARS8kw8yLezlhGZJVv0
         o52jzOWxsMkIIBT3ThUaLCPi/QAmSZxKSqqb6hMrak99PMeAxD3u0dk/TP7xs21D2Iw/
         Ez/eieBRGPY5ouf/XdRZ3e00nlnuno9Ot9UU0ZRzVZtwWy7hL9Ca1MHSbWRqNGS8EsIb
         6SQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327836; x=1794932636;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mw9iOCkEBWkvxdLSgoJVCB6jT3T4ThA8jIPRTFH0lnY=;
        b=u5ntUKsYMTkzTUx+gnUK6dXjZNDp5dpmFxEYFntW9qSBDjw9gv5S7lbNmdbp4hZsok
         2J5/1AoRdIl4CspLXlHIH2TFnUs8DRObAhMPeHG05fxEZlaqUrsvmjqTtLmLw/+0danM
         QecFm/bUFjZCim7r7adhVEOOS6gVLJIbK61n0Seu9hn+I7r7X8YhaHCaeOx/POctx+k+
         PHo1NSOI9kq8ZSJ2rMlUF6Ae36+yx7sshu9O4g2iB0e7LRNSHVtoa4fO2sa5maFNENEA
         ZGmWs2CMp+euTBSGOUi2NfRda7JaQiXAkHiLIBf4dW7Nygx8O0JZ2skJQP+o8FsWbpZT
         rpdA==
X-Forwarded-Encrypted: i=1; AL+hErGVLy/tK2P61NRoPQ2mTtguT3Kju0EyYqynroWSI56Y6KtZzV8zSdfy/uTTXRdwtWQ1isM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gfWvy0d02cWvxEcuRcIC9h+fTfIxlxjIqknbyyMx4Jgff0BcQ
	XF1Ch39ovD14F4lWF2vdJJ8RPVMYUduFNan90cxohRHU3/+unBgiTEg0o9uombW4+Q==
X-Gm-Gg: AYBFou01+WZUhHXAgX++P82603jr01BbKtbRBiRyMs+x+9lueNHEm9NrkQEkt00b7gJ
	Jh3U699qAeyjOFiFZgtl+D1cKNvidIPByyuhJLI/2vhsEjG7GP4sRMtE/ra84eiN5nH5GUaD1Ev
	AEdeqpaYsJmpwxhe5v4ZsUVvvPDorBb96FoZzxn0epNKW8IbsOQVxF1Yg4odmvs5zdHlE/jUaLV
	0YIMNq5ZZexXPW1QZvOCrSUvPfjj002HmWYthg/3gyPivO2tIlryLCqTb4VBW/XDDpDD608G0Mb
	p8+H+PaNmMOK209FhOrrVx4fpJVXHq9RTKWuZtdSssxr4/wydLJMheC9kOo1MqzrFo4FIHWtKw3
	1Fwtvekj19WnfeQArn6hPnZsBcS0mHrcpaUm6Rx6gqQfxQoM4s4/uYee+YK1TX1ZZq9YNe9D1w8
	tQXGXuGwidPxaBmZvJ7rv+rNg9fibERNoC9MGfCyrKtJ4nippReR+GvnmCzBPoyZfJaFYWkJWHU
	Oeg/8V42o0vJDb5wsLqWD+8Vet5mo7T/9VYQ6dt/6jMe0TxFnkfmb0FvPokh26etO86FeCmyAc2
	Wx0JvzTLEMxJwHTB2l5pOoY3vfl4yj8V78bmNs6yI1uXnvWZvV7H9ArAPahNhggc
X-Received: by 2002:a17:902:d4cc:b0:2e8:18ca:5f46 with SMTP id d9443c01a7336-2edb9146ba8mr28990585ad.14.1794327834955;
        Tue, 10 Nov 2026 08:23:54 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d7d964sm11306915ad.32.2026.11.10.08.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:23:54 -0800 (PST)
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
Date: Tue, 10 Nov 2026 16:23:53 +0000
Message-Id: <DMRO4QXXB8H4.127C1CPT3RZ18@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 16/19] PCI: liveupdate: Add feature header to struct
 pci_dev_ser
From: "David Matlack" <dmatlack@google.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-17-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-17-tarunsahu@google.com>

On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
> Precede each serialized PCI device entry in the PCI Live Update KHO block
> set with struct kho_ser_hdr via DECLARE_KHO_SER so future per-device PCI
> Live Update features can append fields to struct pci_dev_ser without
> breaking compatibility between adjacent kernels.

Elements of a collection should not have their own feature headers. This
applies to patches 10, 12, 14, 16 and 18. I raised this during the v2
discussion [1][2], but I don't think it was addressed.

All entries in a KHO block set are written by the same kernel using the
same struct, and the block set has a single entry_size, so every entry
header is necessarily identical. They don't convey anything that the
header of the struct that owns the collection can't. In this case,
struct pci_ser's header can define features that describe fields in
struct pci_dev_ser, and the PCI core checks them once before iterating.
If a feature only applies to some devices, the field's value in each
entry says whether that device uses it.

Per-entry headers also cost a lot for small entries. struct pci_dev_ser
goes from 8 to 16 bytes, and to 24 bytes once the first feature is
added. Patch 18 does the same for every preserved memfd folio, which for
a large guest backed by 4K pages adds gigabytes of preserved metadata.

They also add new ways to read out of bounds. kho_ser_payload() trusts
nr_required/nr_optional in each entry, and nothing checks that the entry
header plus payload fit within entry_size. In patches 14 and 18 the walk
uses each entry's fhdr->size to find the next entry, so one bad header
throws off every entry after it.

Instead I would keep struct pci_dev_ser as a plain struct, take the
entry size from the KHO block header (patch 2), and in pci_flb_retrieve()
check once that the entry size covers the base fields, plus the fields
of any features set in struct pci_ser's header, e.g.:

	entry_size =3D kho_block_set_entry_size(&incoming->block_set);
	if (entry_size < offsetofend(struct pci_dev_ser, refcount))
		panic(...);

That also restores the minimum entry size check that the v10 PCI series
had with PCI_DEV_SER_MIN_SIZE, which this version drops.

[...]

> -	kho_block_set_init(&incoming->block_set, sizeof(struct pci_dev_ser));
> +	kho_block_set_init(&incoming->block_set, kho_ser_size(pci_dev_ser));

This size is never used. kho_block_set_restore() overwrites it with the
entry size recorded by the previous kernel. Passing this kernel's size
here is misleading: pci_flb_retrieve() (and the LUO session/file restore
paths) read as if they iterate incoming entries with the outgoing entry
size, which would be a bug.

Incoming block sets should not take an entry size at all.
kho_block_set_restore() should initialize the block set itself from the
incoming block headers, and the incoming paths should drop the
kho_block_set_init() call.

[1] https://lore.kernel.org/kexec/atl6K2Juy6Bh29lh@google.com/
[2] https://lore.kernel.org/kexec/at-8vkVpN2SF3XgB@google.com/

