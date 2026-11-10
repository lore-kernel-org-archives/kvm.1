Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328774;
	b=OyG7AHxhTNHLVwgYmpa6cT9PI6X8uTRKWk2CdG5tt8jEwoxfmhGUbQH7mL5DoWUEo/2a
	 2BK8HOc+gY6ob+5N0du5KSht2tH96Il1KH71OYlDI5QmXz5PRNSZaK2Ss9YzWVNtYjIKu
	 pENotB7fLTIctzsYdUNryclCgM89Efer1LSyXoL86gLiCo/KivGhddPFYiY5KtxbOGG61
	 fnRXRkVUZ0vDYcd7mwqwIIKPRMz5T1wi1dTA+GMgnB9Xlfhadhw5aDV2+xNROgqTyXYkj
	 oKQnJVURJjBCB2DJMuYxHhakiqLsiM+vC5hChjND9Eg2NudrL6yL77omdru3E7PtTPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=KprtAoIZUPQy03e7SCEXrO4BhVdW6Lml6VdK8wkVG2w=;
	b=f19tELDtOBigGAS0KFPij/0gaiIRpLlkP61rmKZA2l+qA+3yC/LWeTKzofTH7AMIaRFx
	 JlepgpuBaTdSKBx5SMnX34BWDbzW5dun9ncjMuWJysqhy6qEnsRUO3t2hzsvK7Xkxn6jJ
	 R4bouBo5n86YsqRYrPrKj+G/H5VtM0ib+eBWoe/oPOaz02HsjkK1tBNk7FAJqVWujaFZd
	 5kIL82aR+hXNjF+ZpwmAd1jM6vhodB8pqbMP8A1V/qpL6aSelPuBCBXg7nOCnUkc/nGPd
	 UaL8D6xZTtosrBfZjlNiReUUVb/tnDi14qA78e/10NyxnF+wUKRugOOo5l+s5wXRemQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Af3onASr;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B68660A263A
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 16:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B68660A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Af3onASr
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so1424821a91.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 08:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794328774; x=1794933574; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KprtAoIZUPQy03e7SCEXrO4BhVdW6Lml6VdK8wkVG2w=;
        b=Af3onASrXSp7ZkNpgiwe/Q2+oXpI2XjcCAiLbtB+390MxJDRDjSFaW1jd9q05Yg8tN
         JlwAwdyX7S+G/Tn5f64UiFDiRZlle3R5xR0Jw9PSv3k3c3Mh6pWQZ1CGzhvf+hw38y5X
         dU8RoU0RUVyNKFjWhU9rF0Vf1Z6e73VWXTGSSlYsDn9yMfJsKqoBa9utqC0AN7pUvUvn
         iHzNcnQeTol0BMW07/jYQ/6NveZ+1XR51qNPvL0SG7sBtMz0KYYFVBgzvWx1EUDw7Jym
         huQ7iDW1WlGdR43JlVdcrlnpjIjyp5m2PtmwMdYy5JhTpS5krOGamd/BQhmEp5dJQ1Oi
         hSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328774; x=1794933574;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KprtAoIZUPQy03e7SCEXrO4BhVdW6Lml6VdK8wkVG2w=;
        b=G2rIQ307r/3VDzINj8oVPL75QU4mh8V4F1FvS9MZM6V+SSEU1BjkjzHXiXSW6q4eiv
         jVyV4Or7ANSjUobtUiCc+GoykOS24f8TuKxTzib0BuUOQhQArLpxJlP244SPVvaFE/fJ
         XWprNid0z+78V/5Rhs9U77D14o7RdOQmbRyPWETkwNw/xrI1DmW4qtvYBqQAqZRoT5Ix
         TfL/ioqsDc+gLawhkiUDDQzQDkTpxqhG2wQHCx9yRiJ8V6rBa0YzjDhC2S3JPn2OYeZN
         a2463naOIFtthCykyL9W7dxD0H48xpL/xN60PSseMAgEqSwOLGbbokd89l1c4TUHZpO5
         whiA==
X-Forwarded-Encrypted: i=1; AL+hErGgRzWCl1DcBoD0nB46W2lYv5Y84nYAyGEDVJ92c/1XtUx2SRpuhU7hBtOt1KMQiVCf6qc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/12+Ck5sfkcRaWsMGLzvDCUSJZPtpyT+CgLW9eMAo7cgzAaDUM
	5F8bTt7W8EnBumkWeE4tZxSLoW5l9wUZOILtI/BkfQTfDBh40ha7lKGRe/hMyfB8TA==
X-Gm-Gg: AYBFou0Va9jeke0H5LZx34Q9zwhxtSbICW2jaaD8T4VDlIXs5lth64rTHEbRE0Ry3jJ
	0xAITNWDHwylsP5And9R0OZeHY2Ie/0rXI9kzYwX0eivCKczxme7GmJENTe+l1leiiwvaDvh62t
	jxtRpP8W20EPc+iDJrXr+Mb3MqeVyOSj8M1JFUqcdnW1OAeQ0FgU249DCPpjh39s0wp9uSWSr1S
	q11TypRxOgnNcLoJVh1yIKboFkx1Ww0jaoz0eR+YWVvYsa9h78xtA8Pa8pp3iFe3kY9Mu1zYKrD
	nW2z35qc9Ktc2pygDjIlGajDI0TPeWH8l4UbOcAh2cSjYBX1u3mEcz16Lfuur2Wci6QJ+ftqbXs
	cKJkzwWKbBWwnYi5yCfyevoOrE2Gt7uUMcUMYNOHXLLVn593ZyVZqLbdHUkmgWGQuJkgsCtrnkv
	DFJOfN00b7oyn3smiPR3aybYpa2aWu3U4OUplyP93Znc0P1HUBqE+T4e0albe9Ce1d6/uauVz1s
	FewnpDQgcwjnFCM9nOC4qncEJoQDbTwiOeVkNOxNc1oXhvshDuXi+W9zp+fER70u3o3IVxAmGbF
	Al8bvKeAO8r9It9HvRa9v7GwQ0nuCUJmMMlSVZeiognNITBre8CKDwGMb9Q+r+su
X-Received: by 2002:a17:90a:d444:b0:3ac:9d83:8861 with SMTP id 98e67ed59e1d1-3b166e3c924mr3152630a91.67.1794328773194;
        Tue, 10 Nov 2026 08:39:33 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168a8de09sm2418499a91.0.2026.11.10.08.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:39:31 -0800 (PST)
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
Date: Tue, 10 Nov 2026 16:39:31 +0000
Message-Id: <DMROGPTP93G4.13PA42UFKZJNJ@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 15/19] PCI: liveupdate: Add feature header to struct
 pci_ser
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
 <20261110050202.529473-16-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-16-tarunsahu@google.com>

On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
> PCI_SER_REQUIRED_FLAGS_SUPPORTED. Remove dev_ser_size and
> PCI_DEV_SER_MIN_SIZE so restoration derives the struct pci_dev_ser stride
> from the KHO block header entry_size. Drop __packed from struct pci_ser

Taking the stride from the block header is good, but dropping
PCI_DEV_SER_MIN_SIZE removes the only check that incoming entries are
large enough to hold the fields this kernel reads.
kho_block_set_restore() only rejects an entry_size of 0, so
pci_flb_retrieve() will now read past the end of entries smaller than
offsetofend(struct pci_dev_ser, refcount) instead of panicking. Please
keep an equivalent check against the incoming entry size.

> from the KHO block header entry_size. Drop __packed from struct pci_ser
> and struct pci_dev_ser, adding an explicit u32 reserved field to struct
> pci_ser for 8-byte alignment, and bump PCI_LUO_FLB_COMPATIBLE from pci to

Please move this to patch 1, which drops __packed from the other ABI
structs.

> pci_ser for 8-byte alignment, and bump PCI_LUO_FLB_COMPATIBLE from pci to
> pci-v2.

The PCI Live Update ABI hasn't been in a release yet, so maybe we don't
need a version bump?

[...]

> - *  * The size of each struct pci_dev_ser is recorded in
> - *    ``pci_ser.dev_ser_size`` and is never smaller than
> - *    ``PCI_DEV_SER_MIN_SIZE``. The next kernel ignores any fields beyon=
d the
> - *    ones it knows about, and must handle entries that are smaller than=
 its
> - *    own struct pci_dev_ser.
> + * Preserved devices are serialized as struct pci_dev_ser entries stored=
 in
> + * a KHO block set. The block header records the entry size, allowing th=
e
> + * next kernel to step through entries using the source kernel's stride
> + * even if fields are added in later versions.

Please keep the rules for extending struct pci_dev_ser. I'd say
something like: fields appended to struct pci_dev_ser must be gated by
a feature in struct pci_ser's header, entries are never smaller than
PCI_DEV_SER_MIN_SIZE, and the next kernel must not read fields beyond
the incoming entry size.

[...]

>  struct pci_flb_outgoing {
> -	struct pci_ser *ser;
> +	DECLARE_KHO_SER_HDR(pci_ser, *fhdr);
>  	struct kho_block_set block_set;
>  };

I'd keep the ser pointer here (and in struct pci_flb_incoming) and add
the header pointer alongside it. The header is only needed to free the
allocation and for args->data, and keeping ser avoids sprinkling
kho_ser_payload(outgoing->fhdr, pci_ser)-> throughout the file.

Also, please call it header rather than fhdr, here and throughout the
series. fhdr isn't obvious to someone reading this code for the first
time, whereas header is very obvious and clear.

[...]

> + * @reserved: Reserved for alignment.

Please document that this must be zero, so it can be used by a future
feature.
