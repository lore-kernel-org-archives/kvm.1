Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527398;
	b=XruISuDs2TaB/Z8JGUNn34cwo0/Ql/SNDA7VCotG5+YqV85ME6jVNGbyQPxI2XOB/K7B
	 TlPQIa9KxMdCsh3TBsfcxrKXMROd/3VwQIAX3YRv/m1NsEp+u7xYMqG0/XRZMoAlulnHA
	 6ym4o1Y8NvyRsck3QPBfKW66c0fXCQa7szbHN2bBBDwekIhxwVqUzCItxiAIGsRrNK5kg
	 Xly/uqVw4MnlYOOtCX83Ex90kHk2BxvVY7r4HU9k5rBtjDJ9G1Ih/0MXpm8x4F2gJ6eHm
	 rwI1TJGVYMOQKa6AuDvP5b99P9LiqlM7O8ga4HA8WhN817bVC5hrvE3b5FtiLAiarEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=38dbhiLjfuYeyXify2hejI0unP3asaYqsevCVz0W1bQ=;
	b=ByTZ2jLqP9UC2QUsHNb0WqVVoILEIQivMaYeqqqBcV++6BEhLIVxCZC0OjTidCQRo762
	 x9nV80OKDmGYneTz51q4s+pc0vsAgnJIir0Mi2lrOHkj0Zlm+rQVZvj2XhU6dKxbCujeD
	 0k/Z3BFrxkeTwjLog9fgcpuVDnyYtJaXG+7HuYEMcVjI9Aay1hGTFtXqjDit9Ctd8fBUa
	 maNj9a/H/6+G0V9lUGOks2C8Uq7bzo3uHCFxRkM7SQGsDg2D4U7InB2lb6Fe+XH7LmmAG
	 E2duKXV88rGt+dW+o/BEH7ubSXde+3ljOqYBruobCbsiMe2vIwI99PJrgJXHxYKhzOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=jWEiKbZx;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A7D606A322
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 13:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13A7D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=jWEiKbZx
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-92119da3d37so43010046d6.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 05:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795527397; x=1796132197; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=38dbhiLjfuYeyXify2hejI0unP3asaYqsevCVz0W1bQ=;
        b=jWEiKbZxUbf23XYa4DO019H8IcOJyHi48JriuvrWNnMl/TkrZE/2w2CA+xdP8mHd0B
         bF3QgczPIfqD0I+2djEq4qJW2K85/O753X+5lrKGSgHCz5fr0ymS9Pm5z0WJYSM5wITI
         ucZZCgYeCPH53q6GduIMNWU7lD2jiavMIcQ2NNg7aLErcnXMiecoUO8h/fRmS8cvHF/z
         m5iokFSrqnSjv8RC+7djwlwebzw8hUYo8F4R8yWxEMM8m4JdAMXUe7+lWOghXoZY+H7d
         3v+ibml+ajSOLGIxoOp9yt1gYE+O6PPvMVC0qTG+afibB7VeVUu9FNoi0ab2PbNrNxyr
         klRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527397; x=1796132197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=38dbhiLjfuYeyXify2hejI0unP3asaYqsevCVz0W1bQ=;
        b=2L/zStAgoINC5L9dX7myZEHCHl/yaK3nIwkaa2miOXBu/2i6qlV1ZIMgYzAw/hak1x
         7OfBmMZk7TjMpDq9lAo3VtdHZavmrcTyIaMhp+jJ6sFmnY9ymSdFfVQoBfjylQv5HJJq
         TCvG6WWxA5mUc/xI5gjimrtEAS73H6lZGJJTyfuB0N8Y+jSWUzesJnQpdMdbbZyqvq6f
         9mrtwbvy9TzeRMD9ymb0fWqxZB4NCyEZsNFjDrREj3uZm1QZkzflioN0w0Tw2m2QG1y3
         J7Neunq9PLjqU27+v5RMjf/cf5QcDAFGAQEg5e8wHnAR7mI3v3Yn2MS97RwVZRGNNFgZ
         y4qA==
X-Forwarded-Encrypted: i=1; AL+hErGH/heOUHvh1zBfQ0np797GxrdrQ0LD8PTcYbaylxefzjAGedcJew7ZoQV8ZmzV7U+mTfY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oIoQklCDH62y1dAcI1wiIaiK7cy5qvf9D2xZF9pI6VjjbNF2L
	VTsUdUokmwOK3lzbhVFHu1/o6toI1XB56E9XEwtWkK5jfo/McjeE82o8x9XkDq7b9qg=
X-Gm-Gg: AZFdTZfnQzEc+z3d6XsQiigjG98W76dr3EqWuyN61ZCcJmH2CSgALna2TlgMZxUavpl
	Oh2rA2SHr7KXzV4WU3vXSJc26dCf8W/qEArPJxNMvXYj93nQhD4rdF/IlQgMMetKUjUHpL7FdXb
	+4Pnb/r0roN64TQopVVsQ7R3FjTaNk68jeU98UV33LC0RJbffTJayNdeDpONJEj3alI58j/fC3U
	MxtZ+e3kB1lBErq2Aijfh0UK6LhKSh5jcCQ+5gMgmUUrFAlxCT3AK1iDxtCirP7OySEHDF2m4gR
	LJBI7cqjBK+u4HwC79c0o0zq6g+Xv5EUJknsptPLTLBcYVo5iUBLp1IesJ4PRKfE1Z7sHubioi5
	HeU/BLeff7V93Qwp1CNGpTjoW9n69Vu5HE97pswhlOC/tVOKnb1nK8R1RYNtPEor7IlyBr6oOgr
	oTLggj9cyxTBGEm3+4J5Tdx7XocWyVInd2YjirUBxSTs7BGpKGI7RxWyKb6mArxmg5/5Bactkg8
	Evpud4KV1HtwOPrbGuhsQBGYrbzVv+vbqTGVnrkbSmM0UTqGol+kkARmXLbipG9h27Jq4BvR0ZX
	gdbc7+w=
X-Received: by 2002:a05:6214:4412:b0:921:435d:9242 with SMTP id 6a1803df08f44-921435d927fmr200448146d6.47.1795527396835;
        Tue, 24 Nov 2026 05:36:36 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134bf848dsm134683816d6.44.2026.11.24.05.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:36:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVqhH-00000000PyR-2zMF;
	Tue, 24 Nov 2026 09:36:35 -0400
Date: Tue, 24 Nov 2026 09:36:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jianxiong Gao <jxgao@google.com>, linux-coco@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev,
	Zhichuang Sun <zhichuang@google.com>,
	Piranava Tamilselvan <piranavat@google.com>,
	Erdem Aktas <erdemaktas@google.com>,
	Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH v1 10/10] PCI/TSM: Configure accepted device DMA during
 driver attachment
Message-ID: <20261124133635.GG9566@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-11-aneesh.kumar@kernel.org>
 <CAMGD6P0pNAnq9U80dnpgbz+hHbX1yH1bdmXjcie4oiq7KizU=A@mail.gmail.com>
 <yq5aeccabo46.fsf@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5aeccabo46.fsf@kernel.org>

On Tue, Nov 24, 2026 at 02:30:25PM +0530, Aneesh Kumar K.V wrote:
> Jianxiong Gao <jxgao@google.com> writes:
> 
> > On Mon, Nov 23, 2026 at 02:03:37PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> + /* driver_managed_dma is unsupported. */
> >> + if (to_pci_driver(pdev->dev.driver)->driver_managed_dma) {
> >> + ret = -EOPNOTSUPP;
> >> + goto out;
> >> + }
> >
> > Hi Aneesh,
> > A short clarification question on this check: once a guest TSM driver
> > implements dma_enable, pci_tsm_dma_prepare() will reject binding
> > vfio-pci (and other driver_managed_dma drivers like pci-stub) with
> > -EOPNOTSUPP on both locked and accepted TDIs.
> > Is rejecting driver_managed_dma just a scope limit for this series, or
> > the intended long-term policy?
> >
> 
> Wouldn't that require an IOMMU to be available inside the guest? The
> current implementation uses dma-direct, and I haven't yet looked into
> private memory access through a stage-1 IOMMU.

Touching driver_managed_dma shouldn't be part of this series.

iommu support for shared/private memory is its own thing that should
come with enabling guest vIOMMU.

> > If it's a scope limit, is the expected
> > direction for in-guest vfio-pci to enable private DMA when it claims DMA
> > ownership / attaches an IOMMU domain (via iommufd or vfio_iommu_type1),
> > rather than during pci_dma_configure()?
> > We run a userspace accelerator driver over vfio-pci inside a confidential
> > guest on an accepted TDI (similar in model to DPDK/SPDK), so knowing the
> > planned direction for driver_managed_dma — and whether any upstream work
> > is planned for in-guest vfio-pci support on TDIs — would really help us
> > plan.

Is this with vfio-noiommu?

It should eventually work, but there will be a variety of
complications along the way :\

Jason
