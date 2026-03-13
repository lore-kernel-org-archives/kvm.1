Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA03CCFDF
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426448; cv=none; b=og8ftVz2ZQccv8WdXY7r7nW7EWkU5j07k3dCrzdGixDoB9Tx7xl+ApuW34+V5S79exLGQo1JJvoL9W2giYlwP/lALSkGxIKZ28oBGyP8+3p+aRtTxQb+ubC0rOnJYvI5zzpx7KUZcQvUA+xE4EBi4tEr0SanlUTVLx4rb5sR0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426448; c=relaxed/simple;
	bh=r+8WDj17D0ahzMmsV26yBAG5Il5FyUsQjbgg7T++RDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkUDOMEkEx0w5PeS46yczgxqUIiFFkgvc4trQVYWiAWB35ClStCr4NBzDtG/5ATOr25tBxOGeGl7qxXlWCe58tySZEtiU9WeMRYqKL9A5rao+5s+lqZF5vtg0ysFbFRPeLdkGWukqscPvJq8siZBgsoqhf+hsis1EtK0G/BbsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q5Hdyljx; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q5Hdyljx"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89a1347051aso27426416d6.2
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773426446; x=1774031246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sD7gZdLIbR12oWsuwP0hMyRwjWKcXWNRvnOkCD9lgq8=;
        b=Q5HdyljxeDnCzW3ppiaOKcUAMzk/0W9w5V/QZ6ys3FiBZiMevIVNMgUnI8t5f8dI7m
         SRw+Yjtoym1B4rG4+Q32fT/KY4XoZ4Y5OveRmLi59SH/rdWZsCrHxsoY9+1Shc75UNi9
         qMNucUadnEIYk3+PhkwJ5CcGzqojZBGUVIZpUEAMTiv/iYetPdK1weiLdwlfKf7JJcbI
         RZTlPwlibjhm2QHko+/MHc2UZb/rESinRXuzd/n3jFZQdkA22wMXTjL372sq4K9T+XHz
         fojxWJuj4IP1I2OwMoEDJf3NGHD2i529d+UWXmyHBkL2DC7jSMuvOCU1E6z7Nah2F+tC
         Rdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426446; x=1774031246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sD7gZdLIbR12oWsuwP0hMyRwjWKcXWNRvnOkCD9lgq8=;
        b=Fyd3pd54tKMn4/+IFvhaT1T90/Cb6aFhcC4lztDZVQfY4AcG0p93DPBOH+0PcVq6gy
         KDHCRm3DIgMyjCTDh9fKOM+xa88RsKoHOMv490ALTm5DYiw2Vq4jGQDHw3nT7VKPPAh1
         YlXrMWsMAkLGZrmtefVH6YS2znlYi2OWXJr7bSRIFqK550pFG1SjMk/agfduoGy6Hrpz
         /JmuaATK19NDelHVuYIEdGhQVFsMMWQBw8Jgb/qrCdAx1DYk5wnDpf5RHszNNjCQrWvT
         fJE2rvJbr4c/KTudOHv91YcxhFKRwUknxM/g1zki6Y+chowoIGXWcQYKQT/NAksMwwvT
         qY3A==
X-Forwarded-Encrypted: i=1; AJvYcCVFQwSXtwGejpi+vJpJyoT7T1l5/KELH/IhE7yz0AaKe8SAhSvWUxuSa3AlLcxSohXBK1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN9hI963ksHfsncEewzqQU8Ly5UIQW/rmlWeyUACtqPKF3MAgI
	SmQTuy8QdZhm4Bxj6Cri1NPksCZZPFcI1rGNxa2x+Hehb+Uqu1CyYWSQDfZqTcA6Tkg=
X-Gm-Gg: ATEYQzxNqhZsY2o3wciUYVdEDQvzGSesqiQy3Cw+vCIruChBYNjdKyS4LiwYM2ENhPr
	albMrYB15L6iabG1wEGhLqeNUJOO1W1G9/ooF3NJLAbho6lPWifAhb8SE1AjzC3x3KEGnRaZCh4
	koSgyjztuDQ/cmyvGCjUAMUdXRseLsnk8I519vDQ1PrN4ve1RH6kOeKeAvyVG0/bDYWLIRBm2lo
	pCGx71LviiBJ80aGFm4J23nGkNRS76nVbagF5axaftSdyaOGlevwmIB3LfYlQkgiCSARn0/oOz6
	L8FSNESfsr38N69hTYH1AcYrQP0SpEUG+o9SXu0GV962BzebNGtdHMlEuEN382w7mrOvjyeNS0X
	NjYR7IVAXQNBLgxL4h13m7TVzmo6pirxwf61ztAz3Anl7nkXlRIunQrgPASP51KNSOuDYw/IceH
	L9BB3bpd7U+fdO3Y/q+XiqV0xcOg/WyIz7VRwLFAD6yWokw76xYqBDndL7edqgq7A3yCpe9enj4
	gyor+xe
X-Received: by 2002:a05:6214:1d26:b0:896:f61e:15f7 with SMTP id 6a1803df08f44-89a81d942f0mr61721186d6.15.1773426446090;
        Fri, 13 Mar 2026 11:27:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65d2ab43sm61664086d6.53.2026.03.13.11.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:27:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w17EK-00000007Ln4-3lxb;
	Fri, 13 Mar 2026 15:27:24 -0300
Date: Fri, 13 Mar 2026 15:27:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 1/3] iommufd/viommu: Allow associating a KVM VM fd
 with a vIOMMU
Message-ID: <20260313182724.GJ1704121@ziepe.ca>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-2-aneesh.kumar@kernel.org>
 <20260311211742.0000391c@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311211742.0000391c@huawei.com>

On Wed, Mar 11, 2026 at 09:18:07PM +0000, Jonathan Cameron wrote:
> > +#if IS_ENABLED(CONFIG_KVM)
> 
> Hmm. Really a question for Jason / Kevin, but so far this file is ifdef free.
> Should we keep it that way by spinning this stuff off to a separate .c file,
> or maybe use if (IS_ENABLED()) the implementation which I think means
> we need a stub for file_is_kvm()?

I'd prefer we add the stub, then you don't need any of these ifdefs
either..

Jason
