Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A833CB2C7
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884082; cv=none; b=YnbmiE8AECVNkdsOeh9tQrul9Ty89QiZGDFCEAcYb4FE0t1ibihgPds/lt+fZHTU7eQGVIGAATmpp0k6IXvU9WdZ+XNliSnxH9kXzPVWACCik/Xjqmju6Qv3Ptlt4f70jDkqlmLSlQ7+ygWZ3Ut7TPeHgDNMOUkMRz/CwExpLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884082; c=relaxed/simple;
	bh=r4H4etJpbxgvnWsKcOTGgVwJdweQQvXvLKk8S0w3cbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMjZ5a5S7dXFKI5gMJog0NTdiYb2Bn1dheTxIFuT9vWs5QDekxK6AjL/CQ7GZBEVlsSDKEmVGW4zzgygYizurkjbfIfnV60xE3cLYqB2TR8zSdm3WWJXoCNufyoxLJmBPYHwJcXgUrwfi0Mah63cAouUG4SGlLNkqp9PL0pNH7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eextby6a; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eextby6a"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51306c9f2a8so139674681cf.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779884080; x=1780488880; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zjybRMBUQubASldC260OK8MJUJyjzZlOHF/HoeFPi84=;
        b=eextby6ajjRyi73ugcPsaBcUGRyCiEHcrXw76GIcT6DqzMhVcYWiRuYzmmZymJL5kt
         1+DVEbLNgptJKvePXRcfFXDqxThs0EKdBV41MXXGetuT7WYVSf45tsGExGzxd4+PNyeS
         s8CySgQpiGAy0BBvKWE/+8RwhL9Z1kUH5hiNlwkf6FlLfSuzb5uITtJ1ePhC9r2icohc
         gQsQUs2pPEES+kZcFIQfejPDIqTq8H88nH7TpLJXKZz2RHRjxIt+0BsubVGcN5Uc7vzo
         Kk5EjfwzrO+iar6IR8Czp78sN4qOO6nQW0KvinjW+4mtCSbvarN4nojzvZtvidIWxt5w
         KlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779884080; x=1780488880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjybRMBUQubASldC260OK8MJUJyjzZlOHF/HoeFPi84=;
        b=L5qxJVXEDyJsImYQgt16U5g8D9dhT1eDQzjPew1mtIZgzOaAAwZGajVWmfMtJcb+pH
         VMSYXMsF2JsU7ekNlHuBL4P9xLy7e33E7MCZviOhvhggiyCH3YPWWUkCyguBlX7CGsOg
         OWEly0TWjLgDHFogepW9+wGiDI+pLMVKApM7rZx06VD8xquQzWFaXjrN65DFjjsxmmD/
         BBbkHgKxkdO67J6oWLC5niVy0VJ4uOh5rTF4v+YLc98Y/vUVEMd7tlhOjiqXEsDqZ4Wi
         KnGNgS+2FbEkjs+KxlyraXekbRFUMVpwgoAUlxNYlqQGoKuP4hm9HIw2StzNwf+8l85s
         p6Hg==
X-Forwarded-Encrypted: i=1; AFNElJ850hCEOYHfEeZ+XZe0ajn82j7Yct//uDezGjSRhqLiX+y4L8y/Na3SyuVDwQ4SvsTuKZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGqeTjU6wAA3L1C9CTmWl/hByNlyUvpYu5SAk9GQMPQ0zqPcT1
	PTEvjeFQg3q5kjjuzWXC+Fxf/szmTvCMVfLshkKluoLMjp+3OWFr9bCYdYVkdxRS0rk=
X-Gm-Gg: Acq92OEj2Y8rL1vyycoFPYIEPYOz7GiFcGFRWLw3gXygrMvaCifrHYFhrimLDi0URK5
	WIuR6tfsXXqfDuGoUt0NZZQ0v3UmW/aLlJESmZWYodQkn1856r5+KENdjSzo/z4NJ1XHjEwtOT5
	YnJfvmRjGdTOa+QPsCBCrWQeVer1G8RJae3QRibq2MBELw1jE+flY4QX2dtCP/NLVIEMCDICdeV
	3xF53HbrYFoO7UoAWNEYqIXhbSBjEp0QxPQ3BNeOKt5Tt7PhuV+XWCfjTByn6oGs20mftyuW2kH
	aiZihYdiq2nR0pgc1cyBIhrLqwZLwmUL/E22N8S2xe2gebU7ryZrKuqBq88zLAP9NVwRiFYi4iQ
	uYJ2cAjPd7dV89sQE7P4P9VvkAjlFFNs9eqRu5KouRPBw6WSBsU1tQ32pFOXpROttfDAQ0bdyu2
	qwCmcNRzsBzYDv/N1CgU66M+bwD7wLfBpYCiJ+/yqRrn5IdFgnFDUb/Xwh5Ms8QpG1l5PqHOPh3
	MYT2hRhaGZdTNGU
X-Received: by 2002:ac8:58d4:0:b0:516:d2cc:5160 with SMTP id d75a77b69052e-516d459212fmr302395201cf.32.1779884079723;
        Wed, 27 May 2026 05:14:39 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706adc446sm39991901cf.15.2026.05.27.05.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:14:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSD9i-0000000ENnz-0tj0;
	Wed, 27 May 2026 09:14:38 -0300
Date: Wed, 27 May 2026 09:14:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260527121438.GJ2487554@ziepe.ca>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>

On Wed, May 27, 2026 at 08:55:49AM +0200, Christian König wrote:
> On 5/26/26 16:43, Zhiping Zhang wrote:
> > This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
> > export path, allowing importing drivers (e.g. mlx5) to use the
> > exporter's steering tag when performing peer-to-peer DMA into a
> > VFIO-owned device.
> 
> I'm not an expert for TPH, but that sounds very strange to me.
> 
> As far as I know the TLP Processing Hints allow devices to give a
> steering tag to the root complex together with memory accesses to
> give fine grained control about cache usage. In other words it is an
> extension to the classic snoop bit.

TPHS includes an bit of data on every TLP and the data transits to the
eventual completer.

It does not have to be a root port.
 
> For P2P that is obviously nonsense because we don't have P2P support
> for cached accesses.

For P2P the TPH data on the TLP will transit to the P2P completer
unchanged.

It is up to the completer do define what it does with the TPH data.

Typically root ports in CPUs will use TPH data for cache placement
instructions. But who knows what a P2P device will use it for.

In Linux the driver that owns the completing address space gets to
specify how the TPH data works based on its own device specific
knowledge.

Jason
