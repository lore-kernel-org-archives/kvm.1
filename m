Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697730;
	b=z9rb2N9D23Rzgn34pA6f7jZPh+T+Lc5VVJaditHEkdOaIPEl6+9KjHoibQStbQoEt5m0
	 JHmDB4slXkClA4AggJ29djOMZgMmxTrnPltHHbTad8QQDWCQNK+pSTMxnXxnhID2pvyo1
	 zngFKVJ0JhsYACO+5FDOEAV/AWWqo2Yq5C3GHpEUHFSMC7/v3weMo3Gp9sJLF0TpL4u2C
	 C9A6Mf1WC/zA+ZJMcEv12uNekiTo7BMwKMx6al6f7+2DF/LvzHcfFdD0YeLQZa7tuQTqb
	 RRj7+oR+ToGCOlMYfZSkqTwU9x7D6+snIxd4RBK5EgjtoUmviJF48sSIOK79qjRJF8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=56b7HTZvlpKC4tZk577CJ8+w/mtcoo97dNOMSZZwtIA=;
	b=qlybnE8wYB+s9HuixyWbaMGxLvC3mOO12Im0DA22tpKXPVCPGUCI99UjGzHzx+cnSP6i
	 9s8N1YhN4idVtPlu3sIaSDEJSBAT8pFhhwCdrMXfFugPrtM4J854wu74OKKeWA02sVIMv
	 ZMHojPZ43Appe3iBkCaX3/we6/daN9BgIepDwon1UN2pFt1H3syos1zkHMVCLkllMzfgC
	 1k6hOXI/SGFWCkYPErtakD72DuyiQHn4EkfJlWdn34OtmfxR72E4PYlR9XVBL/I4QLDqv
	 KbxzYoC2SeJZY2sZRMGECIu4sx3SJdIz+vs3rha0fHYadG5LT5esH8PKf8wRVqDY8/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="PMdp/ssP";
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC373606A323
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 19:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC373606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=PMdp/ssP
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e635220b4so11533985a.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792697728; x=1793302528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=56b7HTZvlpKC4tZk577CJ8+w/mtcoo97dNOMSZZwtIA=;
        b=PMdp/ssPxgZMUrGwNR3Bi1/qfM8gMx+PxIvSc1WnlPJyDTsjgIIkEzrC6lRq6jruVG
         LF8YN3PvUoRYi+pwrW0xef1REaOMVCXkVv52uKDGmTuMWiXRGcOlkvkxhydApZh1H3iJ
         30+lFkiaiUACZsDIJXmowV9Btzkwb/7tEafCfP9QRb/YTWXqP7XEQlJ/glhbRu30OZAZ
         Ibo1AqpENbfBnwrk0BmlzhkDHWGVyvB7pVn4WjtFsWPGXAAOTb/CCmselXNXTJGj6rLv
         HR7zepmdgC9fDWadX4wGSaqHNzCLsFjS8xcgtalMfGJQRg+taGWoC+N1brAzEuWLRdsQ
         HGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792697728; x=1793302528;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56b7HTZvlpKC4tZk577CJ8+w/mtcoo97dNOMSZZwtIA=;
        b=q1nrYIkP1EkV73Dbf614RAR22+Ti5Y6QuT1DI/+U9pHE5zRCI7BswigxSA5OxUq3FB
         wudryQ/dqmq8X5pBLG6pZyeR8SAIefR7nY0pcYAXShT4qqk/wtggA5uZArEw/H/xaOtx
         cyGKLvGHZ8yXrjMb5/piRvRdbwoxHh6+2097JsT96XxXsPk6/BxZzhGO0dgSeRa0b7P0
         vBvAE34PoWejnA3S3Lnv9AmGE5e6NwfD10zIq+rfARHzm+MH5ZzDP9Z/lRc77AniGuLR
         6/fxTakGXbFDDEDP/9h2w+B1GwiGY0F0BBthwLTYvDL1cEfbof/NQqxXkS1TASqwOCVO
         y8Bg==
X-Forwarded-Encrypted: i=1; AKwUvBxOZH3wilQR95g9d7DnRcbNVVQFyLLPv/0yYrNSguNe55Ue7ywNntC/vWltR51kQYzlSHo=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3ou50O/UQHpwxMotslGUh2HTi9dWEVZYDOm5el2ANjgBZHvqU
	8G3106WdoFG2jc1ndCA5tAYKULFzaEdE/p2M7JrO49jwjYc/K0pHuKYxLEiDC/Givd4=
X-Gm-Gg: AYBFou3fxAB1WVNPcPwNBhEJU7bOd/4k33R+IycZIYOY0rg2kjBPQ84S2OpOBVRuI8T
	s2mQRsPZGk63Y08p+DuQy1T6EdnoLg0yQoVoiNdIFMkdYL30sFs7/RL5cYF2W6UVyU5/73l/zp4
	n+rNZ87ttNmdDCY+8/RnE7MH+oAoYDy9599qPKoJtZu/3kdYyGXDlZ924WPkReXZLwRdAszbad2
	qr9mF0frBYgLNN7kqKncrwtYWA1c5WulfXO3c1dsB5OQ5QV/v9MMa6Xy42XThPmuguI6GrwDsYU
	dpxUlaw7jw8bNGgIbniSQNlWZUtYDxnWvzuAWrvjTdFybGVr0D4JrNhqzmemTdWek9l56eTaIz+
	rKq8fCCGvORCB52fw9NqobG/ldY7Tj9gK6VmnCbCRyq9yLBBuJXDe5CF3GkZuzcnSJg6yskrxXY
	Jd+nmb6LtxvW0fGeNNOUSHneOpxoB56sRXvLRh26j7g4MmvKOoXtUc1+c9ubQNVIUQa+MeCGYuD
	en4jfKWPc0/qOzNLwscI2W7TzfXU5Z5a4fTJc2Rzm5QcKFh/+t8IPmxH49aFZcTpAtUKvXypzUL
	dw0SWvQuBf3HEK04rQUZE1t1B59akZ4Z/8MrTQ==
X-Received: by 2002:a05:620a:2794:b0:93e:c6fc:7f50 with SMTP id af79cd13be357-93f6f79dc27mr75461785a.5.1792697728579;
        Thu, 22 Oct 2026 12:35:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c39766a93sm366276d6.43.2026.10.22.12.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 12:35:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xJyZT-0000000FmQW-2RHj;
	Thu, 22 Oct 2026 16:35:27 -0300
Date: Thu, 22 Oct 2026 16:35:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: alex@shazbot.org, iommu@lists.linux.dev, joro@8bytes.org,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v3 1/2] iommu: Add iommu_get_pci_resv_windows() helper
Message-ID: <20261022193527.GG3381610@ziepe.ca>
References: <20260921115513.GK11599@ziepe.ca>
 <20261004162213.3787623-1-guanghuifeng@linux.alibaba.com>
 <20261004162213.3787623-2-guanghuifeng@linux.alibaba.com>
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
In-Reply-To: <20261004162213.3787623-2-guanghuifeng@linux.alibaba.com>

On Mon, Oct 05, 2026 at 12:22:12AM +0800, Guanghui Feng wrote:

> +int iommu_get_pci_resv_windows(struct pci_dev *dev, struct list_head *head)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> +	struct iommu_resv_region *region, *next;
> +	struct resource_entry *window;
> +	LIST_HEAD(resv_windows);
> +	int ret;
> +
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		struct iommu_resv_region tmp = {
> +			.type = IOMMU_RESV_RESERVED,
> +		};

I didn't try to look, but if you are going to add a function to the
iommu core then dma-iommu.c should also use it so we are sharing the
same algorithm.

Maybe a callback function would work better to that end than returning
a linked list?

Jason
