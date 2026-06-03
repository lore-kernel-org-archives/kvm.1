Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DCE2B9A4
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449427; cv=none; b=jV6zGZQRvHWAcAHPzJFKPmj+RZNcO5x0IdIatBWScoQVC8a77hdIik/Fe7GqHiXV9J1T3BDTdv9x7ntw8X7vrPcb/DD0R8WX3JZClqeSZU0+smX9FXeAr037cfo9BrvmKndisJ66iGigXrjxwu4KEZSAtbG+c6x7FWsjoYnWeH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449427; c=relaxed/simple;
	bh=AfeOHXoP4IMONW5uOULUF2nWpillreIFP9OwYK/o6Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6DlSj1D1ZXbn5XdarsShfuWMmwX18qQ4A5XTZHs839MSitjXs19uHaPl4yYFa0HCWgIJ7klds3a8lkiHt5zIKv4vzRo8kGMhVP/Df7DXO4hMHw2TItuWU47Q7OYM3JcRQD1oymLMOBdQS7ojLCQ7CjPcTKzyqTmuLDJ2WyzLOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K5fQAgl5; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K5fQAgl5"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-91550c6ea8eso465381785a.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 18:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780449425; x=1781054225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0q9jHEvyutbUqJNds5rNSupxxEZQmy/I4DCyfn2tFo=;
        b=K5fQAgl5cBbKmPdQ6W4dsu1eUVIWDx2iw/+dSAcaYUlXAjCDlWSwRhlOqZkTPTMvyG
         2ppyTINfnxBvqLqwiOLYCdd7Z70gGsvHhykeg2bA4YrTkqlwTd15iyWb1FavzYJvzV8e
         uJfMt/vIZAdIwgPfrp758RqHaLrQVEJX2m9k1EfLHGy+gYKIUUm30JQx5TGEobSgDtlz
         QCjPGkgCrnRIanxrdmjBNYDw5kkmlSkT4tjzU4Be7P96fjTtXnowQZz+Qw0xqu2jNPHY
         QU082H+GyIe15HeJCWa6zhBub0Yvr0PlRl/3/oIxDHR+qsXxB8VZkFZIzQJt7Z0PhmQt
         6OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780449425; x=1781054225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0q9jHEvyutbUqJNds5rNSupxxEZQmy/I4DCyfn2tFo=;
        b=B0RCy8AanhmXye9UwEKp2hrvBBEewniHcoy7UmMuepqDngpxRcOdn7Vrn3HjQW4UeO
         dsQI7InDCZoyKvxZlKhUJQzUuHzLkVHX1CR1kNC3JVC6R1zD05Op46ekLTsK4k6GsjSJ
         a2832ESFofICvHOxQc/fVI8oI87kNnGN1hLjEfvSayw4p7EF+0fSM7JDSLGHhEfHLyWB
         iCkm4Go0GYqvQxSM+0+cf5PtYlLlQvEbtCTs8/mTpMjgxxmvBLqw/9oDX7vwU5dBj9hG
         aYqt7NS2W4132qoymuvXySW7arHUj7Hn9MneFCtjJSa2PFc/pmwg5Dmhexm5Z8LFeNGC
         zDVw==
X-Forwarded-Encrypted: i=1; AFNElJ8mBi2776MdZzy0zwA2K1ZxDF6NIheQZzdaSGsb2Gu6h/xTfdwIoWHMgjCqLHXykhj+gVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGsLCV39UbQYKhtXM2d3splmkPi7FziPac++T3rt3zYB0xF1uK
	divD+kj62YqUJu58bGWArokylbcgsP6sXgnk4THTR83rRqLBvb/T7Z5yH30a5+3zEw8=
X-Gm-Gg: Acq92OFzMk7t2E7jo69RXmcCL0fIV4VLKScmHv+MPT63al+WZq95e16kFjCxXBI8nSO
	mky+SS4pOCHa1qwtCjKOaJeCuspA+j+so6lTX/LP/DvSthYkcDglw25UHiB4B1GAPyUuFhcv7rd
	SbVsnTPnw3PwdSQT4e+yBPmWKVrStbuLS5blwK0xhdaaH+Rk4Lvo9eZSej9TR9IdpRc1KeZkaPi
	CWDXpNS11jrtCvxaxrH7QE2D6dlkKzTLnZkisG+OUdXT4wR63uKMKYgYb+g9icGa7DgRacuM4dJ
	k9l0PbmhzZ8RhHx53FLM7IyOURXYzKfsq5PfZKjE2u2mzVtMMcqCYSuCLGIzHphB1BNoosZQKcD
	iKkj7hBB0m7+BQnDK7nC1/H9Us7ttk/NSMi2Z+L/a53hWLffCmyJ/UDeM1N1bCgUFEE+Lh/IYmw
	p+kRdAR3l01WVVyz4VZx5Y6fIB55xa+gH0VU9n5GXea5bV/3ZW6bNCNkW7lyOACNFIVJUEpnYom
	ZeBpGSuhOXV47mN
X-Received: by 2002:a05:620a:4455:b0:914:c788:761a with SMTP id af79cd13be357-9158a84f289mr254481885a.58.1780449425306;
        Tue, 02 Jun 2026 18:17:05 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a009fe7sm102378285a.8.2026.06.02.18.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:17:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUaEC-00000004yu4-0q6Q;
	Tue, 02 Jun 2026 22:17:04 -0300
Date: Tue, 2 Jun 2026 22:17:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
	baolu.lu@linux.intel.com, boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org, dwmw2@infradead.org,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	oliver.yang@linux.alibaba.com, robh@kernel.org,
	robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com, suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
	will@kernel.org, xlpang@linux.alibaba.com,
	alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v2 11/30] iommu/mtk_iommu: implement iova_to_phys_length
Message-ID: <20260603011704.GT2487554@ziepe.ca>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-12-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602104637.1219810-12-guanghuifeng@linux.alibaba.com>

On Tue, Jun 02, 2026 at 06:46:18PM +0800, Guanghui Feng wrote:
> -	pa = dom->iop->iova_to_phys(dom->iop, iova);
> +	if (mapped_length)
> +		*mapped_length = 0;
> +
> +	pa = dom->iop->iova_to_phys_length(dom->iop, iova, mapped_length);
> +	if (pa == PHYS_ADDR_MAX)
> +		return PHYS_ADDR_MAX;

???

I guess lots of AI made this right? Please review the AI output for
the little slop things left over..

I saw enough unnecessary hunks, and goofy things like putting the
mapped_len zero in every driver instead of in the core caller.

That said it looks pretty close overall..

Jason
