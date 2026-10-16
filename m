Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ABA4DA9DE
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162727; cv=none; b=ePjIS2ROkCxisp+cEJitM6t0I2YoNDcoo/KLjOOnmSclwIP+mmOwfsgfx3pLbThsiIQKhSR+RxU182baysH1NmMuIYl2a17NMrhrpjZlzMCtxGsXS1aewn1KmC5sVykfZzJFxwGQl/MlGB/ArNvJAQ44pgMAttkx53+dsCrK/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162727; c=relaxed/simple;
	bh=Gs6UDVs85lAeYcbz5natlQddcSkvTtyPzng7JiqW+ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Visj1Y2/80GuxC4ASuTLFkC0onXVwJ31hdA+Rc16xYGbjM+PNSZmmRg4MlXB3+6tSGkBzmwcxGNSPHcZaaglpiR+tss+am1NnUkcYMP5XQyAIRI8tKC/q3DmMUuffRhp/rjT9ZBRxbVqgX+ok6a5+XXnjQLNvb6/KbaXSEYoOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kr4Iy/B5; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kr4Iy/B5"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e515769d3so2974385a.3
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792162725; x=1792767525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q4TOl9JQUahFIQiKudG6oBPl46TqBGSAJ68OWGmu91g=;
        b=kr4Iy/B5tc9MOgeuxrJ3WzD0XUewK3GJl5jbxA3cSu/cFyxm2FwiGsrOeO31JtRBrV
         XR5kLz4ptzN/7j9h+J5noZdbHPSw5ffk+0Lz5P1Y3k9vSbPrlSX8zmkot3DC19Co6QxE
         mu6eP/OnDY3uSLEiTfB/0CwIJt7fLWQ7IF3DhQMwOrY3w2i3DQXUnfkbq2V82ntbNvv9
         92mBBGv161rgCmqQkvkRO+0oR9ABJO5LOfZQcbnfEGNrNWhOxnQUUBDOptOuRf99BKuX
         ZBUSEJq2lFe/oonJaMGYCn7u2hLCgA3DAKKqZvz0tQGTwEx/s8t0ojJzObGgnPPEC1Sn
         5ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792162725; x=1792767525;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q4TOl9JQUahFIQiKudG6oBPl46TqBGSAJ68OWGmu91g=;
        b=sIGxuE5T7H+AjyCG3yeiwwCKeO5YdMm1rWNraryL6t5KAVbycWYFT+n+EtjDqCPYI+
         jHT0YoxtP1MOwDDwvKmHwieCkgWlbW/DDEk4KcZIjQ3NfkqN3z9IPYRtZplUmkHMTzAS
         cSB/WMHKvrtBFgosDCsILCOEwPpTu59C3O7Xh5lEJ/I79ragY/Rkqb0mGfImEsHpTF46
         6ZKfhEAT1oQw3WHzr/HxuSSNymRMhEM2O+mdl0Z9T04dw9EElNxFNgaGUaNwc9kMZvjG
         zxqJBZEex1PcnNt+IDh37KVteidnUdhYhzeR6sLB92bm/vgAwrN3kHGg/3I6a0YBxI9k
         sVMw==
X-Forwarded-Encrypted: i=1; AKwUvBwQYbHr9KHG8ZJwVoODYns6zuabmSIGH2wk3wDciJhOEX9T1hh15nnSl9ds/IlUjEJR578=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTzdGuWwwPXGWvqw+kUKWTLo15WHB4H2IxPtIsHagZn1nmwqb8
	KvA59QXT7cYAn74g+C7uwk4vJOkinW2rMtsVIaJPEEvyQudNoK4WdkuuIXFbh1V3if8=
X-Gm-Gg: AYBFou18iJPeR1ciGed5Y54OZ5R7axQfVu74afvB/Xa3kqKLgz9yNNmiGuSFJO1b2Gc
	DUhRRBx4dYvlb6UfSNBDnRd+6trPtb0UZB5qgzzGzLPGz/TBxp/eJ9hBbd0Av+u/mRJll853NpP
	VSGUo9WytlFkWsEgV7MxX/RMMRfbba36C4hQczoePXORtvp1jVADsi1X+SPoeiS2mI1VmGlRoxK
	87zl68Fzij+DPuFyLze2qPLYYHmvcUmSqn03zmMWByaSC/6j3O668PvDcL/WfVUhbjRb8ojZMb3
	F4AhKaHEEoKPuB/uzM6ciTpsco12zYwhX6SyNKwwouq3FxDeX7RcJ0sfKaLBrYLjpHW3nPci9/x
	4WqboWz91NiEbjrUOm7xXJ5rVrf70xKrdSMISKYGMXNvNW6zJoWrZomPvZ9OWSuGHjw2Ts+/2G0
	bBY1Gl5qpTnZkt5yXEqM3RnFu7Z/CkM+K8+lal9R3MlNmITalZqTaimDASMnq5k3Il9OhSv/OIx
	KN86DUmHwvlIa2100y7MssHDvIA3HFhyZsRDuLXDDoVmha71DXW5rcq
X-Received: by 2002:a05:620a:7113:b0:93e:96cb:3083 with SMTP id af79cd13be357-93f29d38660mr12133885a.33.1792162725326;
        Fri, 16 Oct 2026 07:58:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a197bd2sm231474285a.29.2026.10.16.07.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:58:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHjON-00000001tP5-3WxW;
	Fri, 16 Oct 2026 11:58:43 -0300
Date: Fri, 16 Oct 2026 11:58:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, iommu@lists.linux.dev,
	x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
Message-ID: <20261016145843.GF14213@ziepe.ca>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050>
 <20261015173707.GV14213@ziepe.ca>
 <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>

On Fri, Oct 16, 2026 at 03:03:23PM +0800, Baolu Lu wrote:
> On 10/16/2026 1:37 AM, Jason Gunthorpe wrote:
> > On Thu, Oct 15, 2026 at 04:31:31PM +0800, Xu Yilun wrote:
> > 
> > > An alternative could be, bringing up one IOMMU when an associated
> > > device requests link encryption. Then a no-tdx-support iommu fails the
> > > encryption request naturally.
> > That is what ARM is planning to do. I think it is reasonable to
> > trigger creation of the secure iommu when the TSM is connected to TDX.
> > 
> > Fail connect if the iommu could not be created.
> 
> Yes, agreed. The Intel iommu driver could use per-device interfaces,
> just as ARM is planning. There are some differences, though.
> 
> ARM's interaction with the iommu driver in viommu_init() appears to
> consist of two steps:
> 
>  - arm_smmu_get_realm_params(dev, &params): get and validate the
>    physical iommu information from the arm-smmu-v3 driver;
>  - cca_psmmu_get(&params): activate the physical smmu for Realm use.

Okay, I haven't looked, not sure what is in cca_psmmu_get() yet

> So the Intel iommu driver will probably end up with interfaces like:
>
>  - dmar_tdxcs_iommu_init(struct device *dev, ...);
>  - dmar_tdxcs_iommu_release(struct device *dev, ...);
> 
> These would be called from the connect and disconnect callbacks of
> the TDX link ops:

It seems OK

It sounds like you will have a one time init of the secure iommu at
the time the first PCI device wants to use the TSM? It seems like no
problem.

Jason
