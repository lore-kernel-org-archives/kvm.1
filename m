Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293128;
	b=lGgagvoKbyR/rl27Z4tQPI/YeXV5haQsTHwbwjT8aNCbWbAo2csdlNJ8ACTv5aSlsuaz
	 yOD6arVJWuYbs5BVLQRl/cexOj4RlCm60hSHyCOWTLIoOurAUnAvjeFwNEHyl2qA8epNn
	 t5HDMEsUyJOuIyV6EEIdd4AD26ERFPUF2RWBq+oaeL/pP8/sBHkWjGEfBTdUbOov8RauY
	 uDVwQk9reho77BoG2TYKFCt0/4WDwz/St3Odu/Y4/GA0EnZ6ahMQnmya9KfaQ8dHkMZQA
	 7PGQu6dVBwoUIVLaR5ps6vzZFE6JvckqHQ4P4usx32T39WlFEXwLzMkX9aXdxaeAslw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=6bXwD83MIjcipNSA+r7WlJ6caQoTXebpCKMfW1alQus=;
	b=MXJCkdXcDtieqZyYwEV1DY7Onbye4IUCQnhW8nqZd3bW/qKeVDMPYZYO94RRsIwpA5Aq
	 kq1BDFjV4r1BvHNMkrXBp8p8jTF4SWquPGAmYasBTa4KlrL6QUF6K3JcRy5gR4maKoWNd
	 H4TAw6iMqelrq4YrNW/UqczPRaQilrcx81MGSRAPaQzv5wLUcpYlKciM5psp6FUAQabJI
	 d+zE8cFIAEPK9PWk0/GD9wnA/LPfNc21YZIZqgpPuCajdj24b3k4RqATeKwPqprSdbduc
	 VA9gmAMXu4VinfdOz9rk61Zd3/5NC5wTFTpBVg9/l8ZV8/YBgse7es6QKkHAv8W+0wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="bD+Ng8/3";
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A74606A31E
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 16:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3A74606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bD+Ng8/3
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f079a63b8so214217885a.3
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793293127; x=1793897927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6bXwD83MIjcipNSA+r7WlJ6caQoTXebpCKMfW1alQus=;
        b=bD+Ng8/3nCI/5cWKn4WtKDSPWVPk5hBHIuiXrkbElN6K0EOo4e5w1LTNRGXFCd00f3
         Jwfuew8Cj4qAcC63JhH+tGRH1YbHRvVxo6YW9k0/RoNCcXvNHdO3fsL+p7srQoYK9gCP
         dfIog/jvfA00buTc5IwNKM0mn0X83lr8anz+4kAo53fSHXwsNNNdjWFm0piYuWrBYoZT
         NEyIp44fVuFUY+ogZEPcdT044X6lvUV5KwJmKj0lUb1J7R9YDLAK8t4ELBxxSsUNCqeo
         tOzcJKDGtISKyS59KFnafl4w5KnGawAuTFyuO966T/FFgj03i6Xr3IlIcSNbesHZFjI3
         lwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293127; x=1793897927;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6bXwD83MIjcipNSA+r7WlJ6caQoTXebpCKMfW1alQus=;
        b=t2MUIHHGY86rBwD9MJ8zsUNYb8MWXbbEsXH73Z0QeMfkzaHAKc3YCI0JsTGcZx96eH
         qDAb+DlAAJPjzQlpp/wGQrr8dPaE48OOpPPABdmVUmStmyH6nsq+zn0lv+iMDVQo1XJQ
         LkAmreMEHN11KxQkLtxaKugeHtfsiCufb0z6qzLdzsPVwkfTLYwjVwZgWK2k11PNCFQ9
         hpkqqaN+/2thrMNzIWr/upK22iHG16KDC/Lj4gepjPwEjfCoiwkbo0hroUzEM6a15czH
         Mjxr6hQgkv+FHtKWX07RpyGY3dOdOSsvyoeqwMvz2I7hTK/K0K0wAvhRJEHf/b/BajNV
         P/Dg==
X-Forwarded-Encrypted: i=1; AKwUvBwj9/KgXIB955Rur5YJdvqt2d9yBU841qfW6g3RWS0ps2A4rjT5oZ8X2tjO6rmxwuKkqLA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDP+wEQIi2LHOb2oIjoEqADJlyQzYd215BflItlkmvQEy9Iof/
	yciEHJ30qznGSezN91qfy2It2N42cEfeV4AE9R0bsRJwxKhY1fGx01pszPf/R3kYuAc=
X-Gm-Gg: AYBFou0POE0BPSsEg/XDEAO0mK7wxUdgo7rmhqK8krEfPEmQ29/yKfgnFYeKSyj0nJV
	RVWZinja2090dgRo+1pEdRSigx8Z83SCIIcBxXQ6nXna3COl60qXUCAvAHAS8q8lkq62k8T73cE
	iZcZhxcPShDpHxpOTsW/Nce9uiIpqluRDLXnD3wiON59uA8jMtuJmpR7XFIVKgFzPrapQ1O9ogP
	n+DI8LDVdtuhNbxRI1pqDxXzWJXal2R439tY6HqslkTynmLy6fD0Y7BzUCjp8rGuNW3EoqEeNiy
	68ShUnfg9B5LPqOyeOolpPhDD/TcqLk1lbQ8PYIpl0aZYUS8JMAXS9sQM7J4l6exJk1/8M+SnlB
	Uu966bfCzz2Nz5+UNiq2xzi+A2QGGNbP7Vw1flbU66Ff4/NtylKH/rILdCFOTvGZgvPWAdJQU4I
	xqYKJxBRAOGP172cN7qdZBN0HZOxl/A4YxCjCj0tvhTD7K0HyKm3F5vRL7Yv5l77k1D2dwueK3O
	ATnm6ZfP/6b94zEdtoR0PKyf/q1MN0xeFnBe7jiK5FcBf62NQLtN+JniP1QCj5hytUUn0P0rK7u
	3xwdDK9Qrzwr9aNr2WeZ+p/Em2cWcSvkIcnVEHBA2xuyizTjKUUwO8PSdDi7dddYcoBslu6Hnrh
	UlkdTq2d3SOlorNQVdmHtFl9S3fX1apLj
X-Received: by 2002:a05:620a:298c:b0:93f:38c7:70f4 with SMTP id af79cd13be357-94408aa100cmr927645385a.26.1793293126718;
        Thu, 29 Oct 2026 09:58:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944209818c7sm8131885a.3.2026.10.29.09.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:58:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xMTSf-0000000G2uI-1sK7;
	Thu, 29 Oct 2026 13:58:45 -0300
Date: Thu, 29 Oct 2026 13:58:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: alex@shazbot.org, pbonzini@redhat.com, seanjc@google.com,
	bhelgaas@google.com, jjohnson@kernel.org, johannes@sipsolutions.net,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, vkuznets@redhat.com, kevin.tian@intel.com,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] KVM: add PCI MSI hypercall for VFIO passthrough
Message-ID: <20261029165845.GQ1685504@ziepe.ca>
References: <20261029163713.1366077-1-jtornosm@redhat.com>
 <20261029163713.1366077-3-jtornosm@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029163713.1366077-3-jtornosm@redhat.com>

On Thu, Oct 29, 2026 at 05:37:07PM +0100, Jose Ignacio Tornos Martinez wrote:
> Some PCI devices (e.g. Qualcomm WiFi adapters) have firmware that
> programs MSI addresses directly into device BAR registers, bypassing
> the standard PCI config MSI path. When these devices are passed
> through to VMs via VFIO, the firmware programs the guest virtual MSI
> address instead of the host physical IRTE address, causing DMAR faults
> and non-functional interrupts.
> 
> Add a KVM hypercall (KVM_HC_PCI_MSI_ALLOC) that allows a guest to
> request the host's physical MSI address/data for a VFIO-assigned PCI
> device. The hypercall is dispatched from the x86 hypercall handler to
> a VFIO backend that:
> 
> 1. Finds the host PCI device matching the guest's vendor:device ID
>    using vfio_file_find_pci_device() (introduced in a previous patch)
> 2. Reads the host MSI address/data from the device's msi_desc or
>    by walking the IRQ domain compose chain
> 3. Returns the result to the guest via a GPA response buffer

This is not quite what I suggested, this still relies on the host
setting up the msi using the trapped MSI emulation, which is the
primary hack..

Was it too hard to make this an 'allocate msi' operation?

> The VFIO handler is connected to the KVM instance via a function
> pointer (pci_msi_alloc) in struct kvm, set when the VFIO device is
> created and cleared on release. This avoids a hard dependency between
> KVM and VFIO subsystems.

I feel like VFIO shouldn't be involved here, for the purpose of MSI
all we need is to inform KVM what struct pci_device * is at a vBDF and
then KVM can do the interrupt bits. Maybe this is already happening?

> +	case KVM_HC_PCI_MSI_ALLOC: {
> +		struct msi_msg msg = {};
> +		struct {
> +			u32 address_lo;
> +			u32 address_hi;
> +			u32 data;
> +			u32 reserved;
> +		} resp;
> +
> +		if (vcpu->kvm->pci_msi_alloc == NULL) {
> +			ret = -KVM_ENOSYS;
> +			break;
> +		}

Yet here it is called alloc?

Nothing should use vendor/device ID either, it should all be drive on
vBDF.

> +	irq = pci_irq_vector(pdev, vector);
> +	if (irq <= 0) {
> +		memset(msg, 0, sizeof(*msg));
> +		return 0;
> +	}
> +
> +	irqd = irq_get_irq_data(irq);
> +	if (!irqd) {
> +		memset(msg, 0, sizeof(*msg));
> +		return 0;
> +	}
> +
> +	desc = irq_get_msi_desc(irq);
> +	if (desc) {
> +		*msg = desc->msg;

And this isn't alloc, it is some query..

I think kvm maintainers would insist on a complete API here if this is
the direction.

I probably would not have selected this, it is why I suggested
virtio-msi or something that could be optional and seperate from the
core KVM guest ABI.

But maybe there is interest in doing it this way?

Jason
