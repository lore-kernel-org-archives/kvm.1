Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C84D2EC4
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085839; cv=none; b=E8pS0Wqn4vpMw8KY/oFrEndkCiH/e/uGtqET/Mj1tsJqkViFwaDJVSFBPN1Hqftn2ORYFKRJEZTpqwPWCbMEwda6GoN1Kt11lc6X5U3Pbf3HunHsvBAgOeKePTZSYPAwqwR48p5hfY8QrY7iV0ZFzJw5pjHuMgYc74FuV7We5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085839; c=relaxed/simple;
	bh=OLr+uTnUVK7S9B5QUknUbFXuyG9qUE76WCenfq8svv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liCzFqYWyqMQXIhGk8/ux/3K5mdvtb1rSb0En4M7RUjAHIPSkCDQqSJo72KJ45/zKz7nbT21XdUxqKBtFOzOZamXGm0516ec9p7cQ5nHoT/rP9HAjCJ+YG4FpsH8Ko4KOef2tpCvvTxBsgCB/fn6OvtoLhtI66sE3IzfSJSJq2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E9cwhVSU; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E9cwhVSU"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93cb9e9405fso98505585a.2
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792085829; x=1792690629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OLr+uTnUVK7S9B5QUknUbFXuyG9qUE76WCenfq8svv4=;
        b=E9cwhVSUoV082NHfuOhuKezWHFJFvT7mja8Z7lvBf7ZYogcnrRf9G+2quRsuORXMIR
         q6y8vntCZou2qQ1Tc+7Ok2uN2bTQ5u3MBYIg1KxH0VL2YM4NrsgTOAlSKLwYKJ07dNOn
         uplgEx5pmtz69A2aCMJ7yOe2oi8Uwql0AWsxWPuZtm/ChNf5QMWxBBYeIqcmsDZPQ/ke
         lDMHFIG7Cm/P/1VWbMVAu4gFkJ7Rd8L4VmfWRmt3uJrFfmCt/W+l3Eo1imYijSup+HUz
         U1py5lmI/51s9lYjTfEqMCkNLlGlY7RYl7Y3VKJkxUjARyupt7d2izKcalFqiU1kN+v0
         6Vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792085829; x=1792690629;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLr+uTnUVK7S9B5QUknUbFXuyG9qUE76WCenfq8svv4=;
        b=R6FBlX4yvT20yGFiqLV0WQt6H4M0bhTsumGwKBqXuSIPmDew4/pZfowxbmPh4AEEtc
         O/+fUMtj3vdc9I972sFyTQD4vKvfqBYrIELTjjiTXeI4wju8JCHyM9LCGdfd4iik+NYV
         cEg4cp506OLILwxf96aITaKmkO9XULc0f9C3Os6fsoBkZOxr8aS/Hc9Ar+sat74mfUd6
         Bhl/ZMRMsEUnAjdVcirCQJmFfTfBKlPqwtFck8Qb1aI6QPSwb8XOajne8QV3O15N+5fc
         u620sRwdLdv0BrfATZ58zY80cnVvdRqQP8Hp1su3o/MxQow550C6WjCc3AhgKC6rtZE+
         ZEpA==
X-Forwarded-Encrypted: i=1; AKwUvBxJJQ5pO54zXMuFfjVe7cx86zV2pPX6vXovBN4IDQb72bp152qQC637tCBSdp7ADjcEgbc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKOsjqtI+dQXw1x/TvEaM21kz7dDQoXXD+rFwIS1k5dEnj/cBv
	8k+PWm6snFL9TPCEIkxTHb81DdfI9TbbomQVJSQe/MwvfRzV1o8u7rkeISINoVQOYko=
X-Gm-Gg: AYBFou01hLDsZ8/QbluupjGXzx9OA0VK3hDXRAcEt3Wpbimv9abyHTqcNnS321NTqd+
	ncz1WaGnZdMOXhcG2O9c7PXgZFAnMc+qy9s6SWt0zsZtz1bZ+UAofsXTMIw8dxlvIFhj3dVc2ZV
	iVoBkQ7fraZ0Cum/oGOu1Wsycj3MCYP7r5gt9W+mwEze1iSxwCJWk/RG+11JBSrgQsuNMcXnVpg
	Lv9zbV3MzmfgYFFaHL04JR/cHlhuBvdO/aSYFsEO6plCBNvGyZhWkC2A7/S5ZG+WKTkVOGebs4V
	BED8fl/n3ou/FNWW7QZZazk5Vlbblv5OPIxLLDwTEC7uzzGmXq8c1Ri3am09U3E4AqSI9rrby1d
	4+WB86id0vpy4L9A02X7XaXzAIcg8DKLvFP8wrWYZtCVnR8Cc52yDmlY4y5wBp+eFSTUdS3EiAp
	ZsMCP1cAS8Nj68AC88QKZSkl6EcwiYEtsulMOF9AdT3ax7zR5cG0naBU5fb5jHV2mhVmRiPeiyb
	3acYHU3q0FzdMEAo8uxQrIxJOwFJGPPqEcJxmDECnNnT25gHGb0Bg1x
X-Received: by 2002:a05:620a:469e:b0:93e:c12c:fbce with SMTP id af79cd13be357-93ec12d06a0mr3209910285a.74.1792085829213;
        Thu, 15 Oct 2026 10:37:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5086fe3sm818646485a.37.2026.10.15.10.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:37:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHPO7-0000000H6B3-44RG;
	Thu, 15 Oct 2026 14:37:07 -0300
Date: Thu, 15 Oct 2026 14:37:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
Message-ID: <20261015173707.GV14213@ziepe.ca>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050>

On Thu, Oct 15, 2026 at 04:31:31PM +0800, Xu Yilun wrote:

> An alternative could be, bringing up one IOMMU when an associated
> device requests link encryption. Then a no-tdx-support iommu fails the
> encryption request naturally.

That is what ARM is planning to do. I think it is reasonable to
trigger creation of the secure iommu when the TSM is connected to TDX.

Fail connect if the iommu could not be created.

Jason
