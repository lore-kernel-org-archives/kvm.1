Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199705;
	b=RApV30wlvnopvswPkA8BvcdkGNP3Xb9z0EpUOYLunLJwyCBZVnEbnIVqY3Jbv0eHwviy
	 /+Ug0uqKUD1gQVWLHlIWEyepTLLdEJa+6eh6u0muR75kqXqOL+DEnToDQVeNnCvhC6LQn
	 gTtXpmeS8wz0Fagkkehde5s6pSapOFXdMKCuCiAQkZ7T4t6ZTZakxU/h4f8rHBs42mi1V
	 LcO/OTjKCVC5A2RBd65QcpACGn9DjkH6mSTGSqhnkMhfQ9uz/FV4AUFywicORnXSO9BR5
	 8aG/3E1BCmiXJB5CLmR5BILrdjcKHGiWbU58eLFKej5/FV9RxkBFB1wpV8F2EUX5bfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jPtMMj+TNQI4z5t6onBp93FYMjBvk5RvCFaoZZ65vCY=;
	b=5o+dXZK0rpd4PAW1y7dUnIClGqPaqoWYe+ErGONLT9QwK2NQ8lQY8LKvVFGRmLuU/Fvj
	 4JJDZFdb38WTI587t/Utladd6yTx13e6zYJxHsTzLeTVIMogx+V1ru1V4c4GVSOpMF861
	 H/VHEetxpW2mFLAXEJ9b4bndlKsgihBKVTRtlC+uFzraONIzcjbUPkr7jdrYSUX/e3AQl
	 CrLo8/KEITE3IdgEr6DyLliO57SGJECpFK+9lu6zh5/6ClRDHiEMIdwQEW8lQBF7xGdj3
	 GGaKT2cgGzg+ZjNRQ3upRmJ+guK3CDw95qneYEdfd/Ep9dEweXF2irF+h0XgQkNquqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JM5nliiE;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A23D60A2614
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 18:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A23D60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JM5nliiE
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-9212aaefc11so12974766d6.1
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 10:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795199699; x=1795804499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jPtMMj+TNQI4z5t6onBp93FYMjBvk5RvCFaoZZ65vCY=;
        b=JM5nliiElBRIEJ+B90qYXzTnYzd/+stv+wN4hwHPgqTVP8FYNDHiBWaWDvaGRGBFxN
         DqILVZ3+XhMDQbPxlO8nhrLm/3w+AS8V4/RKa0SdUR6IexGhtW/Uv60cJ4DkbyFlLhOE
         Pl5l+2oZREQoIwCUMY+E4wr8rSVuY88AyEEMkOvGbhgTCninzjOvTw2NxmuFvZ7F+iej
         DSP94PiPMzI29zQ2p9efX119ggGHZGyIOl6SqlcuiuwZZ8zvQMORhl9uXP/+Kg0BjB6g
         LN1AMmDfqP8DHpgXbQTq5ecBBCz9h9vFIy3naJJn1zHRpF8CqaAU+DUip0emRErZQjgp
         a4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795199699; x=1795804499;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPtMMj+TNQI4z5t6onBp93FYMjBvk5RvCFaoZZ65vCY=;
        b=ACqWZI0eolrXugWFMgCsMxf1xBCKDjq+LjSLgm8jWxvQ3iCDNCFsXjCpSqT01RhEE5
         CkpjD26t8sYyYlriTc7SYSuzBO/QSpVWzhurRBt4aPQ9zmAzGI0jZ8SD1G68LKMHarlc
         Hw2T1A7hF/6RZruRFSZoNmxONcw80EEmfjjXUItnTIHbPU+WMZPtsFX3wVPBmsy/KrEi
         FgytmSR023Bwd+v9T9pFNeBHVjWk/9ZEZRaj+TLIsdjJqccc2nkf/ILqZ+OIT2XY+dvX
         bYMHqs6Gq9wh4v9f5erBPzJEyYF/qJEJpHQCqD2Rm7GpActHJb5KQSChP7JcpdJz7Yg6
         5h/w==
X-Forwarded-Encrypted: i=1; AL+hErFU07ziLIpYDN/NXxs6Xs+dC0YQTBbewRbRmUJeiFqoU8pKldtV5zFX5wJOVEguZl8mAMk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+z/Spp6giwpC+dRXxoqTgvO7z1AmMsa11lBG8sr99aAvkl/SgR
	dgcXA8v6SIk7k4Kr8XM+mwK0xfQLpJ5siOT8sF3b+NtNMimf6jC5NmhkCYUrRgMrxb0=
X-Gm-Gg: AZFdTZd9u7veS+Y50YVPSl9C0auyFoCH9XGge/qd/nbuUWdgKTM3Gm6d0mUIGFzTUuv
	XU4umfxsLlNuRUqZoDUh4SBGHlCORMuFiXe+rvjWreOEKKrUVCXKOEoCEWd6SRUiNrBd2TKch5E
	zcfb5AXRU3LFYJpOubNkm2BvdBPOhytHObAOqKzEY641H+JSS6N+/vhk8lqRyCLnMi33CeO8R0U
	wQsREh7e3G2/WuUCWVvCnKXsj6FySJTE2dTjSdYgWvHoXYXlCHPYu9D7jHxVbhpCX7Anp1C+cNq
	Zb+JA3ZBjzQfemrIG3iEjbFvViNgqwFwFuSf5eYyJ0GXipPCyVKoKDqfT9xW2Bf3P7VNdxOwsjI
	RJI/FcYxEvGFrvzRMv4BX0lWztc1H1ghw41n7PngofRJxB1lHXQDSuE5eaFhZ3uhLaTlTFy44YW
	t/uNGt9ooBEhabruaEs+MYxUcr0+tQ5Um6N6RdEXGhWJNfN63/m6eR/cc7kIXCUOsU/aMS36K2T
	FwCMRatJKNDFP8knSWSqsj1M9zbsKvX9MbNTldp+dmYmuHEeT1NGOLZP+lJQLDDcY784UiC4rI6
	GEHT7g==
X-Received: by 2002:a05:6214:4881:b0:921:152a:4e48 with SMTP id 6a1803df08f44-92134b1abb5mr65747176d6.32.1795199698766;
        Fri, 20 Nov 2026 10:34:58 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a16754sm32821016d6.39.2026.11.20.10.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:34:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xUTRp-00000004jZ9-0OT6;
	Fri, 20 Nov 2026 14:34:57 -0400
Date: Fri, 20 Nov 2026 14:34:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, iommu@lists.linux.dev,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v9 09/13] iommufd/viommu: Select vIOMMU operations before
 allocation
Message-ID: <20261120183457.GQ3115493@ziepe.ca>
References: <20261116081935.85372-1-aneesh.kumar@kernel.org>
 <20261116081935.85372-10-aneesh.kumar@kernel.org>
 <20261120094207.00002e89@linux.microsoft.com>
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
In-Reply-To: <20261120094207.00002e89@linux.microsoft.com>

On Fri, Nov 20, 2026 at 09:42:07AM -0800, Jacob Pan wrote:
> > Temporarily disable AMD vIOMMU allocation by returning NULL from
> > amd_iommufd_get_viommu_ops() while the vIOMMU interfaces are being
> > updated.
> > 
> why? if this merged, it would break AMD driver vIOMMU functionality.
> And not temporary as I didn't see enabling in this set.

It is broken already, it is missing some series to finish it. It was a
mistake to leave it on like this.

Jason
