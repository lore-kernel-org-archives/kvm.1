Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAD3EFFD7
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277664; cv=none; b=e2J6Sxc096e5RjeupqufXg1VGMC7QHhoS5S5AYcBokZLEFvsOCER7pKgN2AXIw6tNWd1HqBrfX+YKuF+VCPr4GwPrRHh/TqG3FGcfF1Aa/XUk940XgpiAClMAinQp3svXKlQn5/dONTxmsICFQnjBYp8hqo0rQ80ThwDJbmGzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277664; c=relaxed/simple;
	bh=Rj3lvDiN2NQIPY8+Fcb1qFFhsTlk6MawBPpka9LgHOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/zkg71q3zF+/uIQ+umR0pYL3iYlfuRM0snDF2eoL69WMD3zuzYqWZjdsuUEn0fZvv4ROlJWo52+D/mxX9mCoZkkBw3jsgHSRWMAcWsGeyx1Gy5qahnQwEqVBMH67JMg7Q/+rn6GOaOcqFAgiZfzcLldJPjWGGMSAvlSAev7jnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kxGdh5Dh; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kxGdh5Dh"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dce6e235so176189c88.1
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 12:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790277658; x=1790882458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wndndcOgS9UQetfbY1PV7Ii3PybmfQMjB1dSgomByBI=;
        b=kxGdh5Dh3xpWmyrrint4b6fn3ol1Job9IB/YcGYPgHcBOcWkMqpd+0txld/GPxEZWm
         yxlyAe5YdGWOD0v9U0JbQOR6SyUay4K5qsDKcuJDK8X7YOYpOhDzd69U6itnNOdPcTlA
         j2VTWktT0rry6EvJ90lSlcMPhdJbHKCpPm+166oXeH9UJ3p5rEDafomTiu6HI2HTW9uh
         5QPcMCW8BwMYWSw6rgmPC+fcBiRpcmU/y82JrqsEz9B1LbNoCt5H2DTcx9xgoCQeUAQ7
         Vo7O+plw+k0imyya5zGtkm1hjcat4MgWivWrRBBWFrG1PXHQ4K5W75f+LkBZ7OaM/K9d
         koWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790277658; x=1790882458;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wndndcOgS9UQetfbY1PV7Ii3PybmfQMjB1dSgomByBI=;
        b=Nh6uaKgxSI/YOGfl0IB12DBmUYI3bXprOHSFb/UvUU7OELpSHyT4ANJZvhlVV4H70T
         aQD+G5iEsL4hbUQgatnd5k3r/S8Juz7Vv3R0fZ5L3u4e+Yb1CvrC+j/+rhbb82uONIWg
         jYItbmTY3aCxay9RnZIerM5j/ZhFBK/vbqgErvxoqpJ99H97/e7UuYV1GDxJNGfWTdT5
         LYjsGjR6KTO/3cRnbBqkLanacniflLF19F4P3UpW1WwqwOnVfDGhJ83bQmC7SJ516roJ
         KpmzO5n3SEuOmaz2fbYEzyJ31txHQudzA6UEoneM75+HeG9aM6bdHHJtjydOmdWr92ZU
         P6nw==
X-Forwarded-Encrypted: i=1; AKwUvBw3hgUSyNPsDjWfgYFfXNaZK8r591L+V28sNyRE8yC7DMli/QbXthTa4cfcmWmycZCIBZ4=@vger.kernel.org
X-Gm-Message-State: AFuF++lfXtEEF5T9hNNyGyTk7eNNPJj34RYnuEh7sXSbLce886eKwIXd
	TLp9J1fP36GfprnB8QfnG3gP6PN1VtajVhNfta/q7npexl1HIEWT2WF800GFWM1PTNM=
X-Gm-Gg: AYBFou1c0XibtITID2fhVyvvAxxP98L0mFk06zMBV3sDQS+xHZUqPEP6d4GxcNmrwuP
	gaHOK5ffsyAbdExisKVZMBfiroJ89nwbv+NyPPcBlHP8IlWn18CSfRFujWQoB/marSHGDaEooa0
	TCo4hmAgcyJL1lPJHvO9aMpbGsqkSG8YoQuWIb8CyvudRJvJxiHN/alnopF2UlTv9A8aGlXZGsQ
	+ikI2ICm9OPGztWm4+T4qMwlSjWH1mTdd1AQbCjKUS7hZzDSPOfNITy226JQAgnPuPikIeOFMHl
	w1G7azAH0hVwcoSRLLZxfDuQBlyV7d5+16Ag+c9gOLWQ7ws7xZUujEAMnrr/G44H1apaicBzc0J
	YuZz1Bnk3YlaGVfbYBRGm1ECcY8ZU0OFVjrP2TFkhagwhzJlC1XLX9lYAR8v5L3QdzofAyi9ULj
	hQToprd9aqdO+3t+ug354qWdcOWV/HYEZmqv5Zr2oIhegG
X-Received: by 2002:a05:693c:8201:b0:339:7572:7b2b with SMTP id 5a478bee46e88-34000737ac9mr2950958eec.24.1790277658136;
        Thu, 24 Sep 2026 12:20:58 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145632298sm611644eec.22.2026.09.24.12.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:20:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x9p02-00000000UV0-1Zib;
	Thu, 24 Sep 2026 16:20:54 -0300
Date: Thu, 24 Sep 2026 16:20:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU creation
 for confidential guests and guest TSM requests
Message-ID: <20260924192054.GA16465@ziepe.ca>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <CO1PR11MB48358E3116CC6CF34E6437658C812@CO1PR11MB4835.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB48358E3116CC6CF34E6437658C812@CO1PR11MB4835.namprd11.prod.outlook.com>

On Thu, Sep 24, 2026 at 07:48:08AM +0000, Tian, Kevin wrote:
> > From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > Sent: Thursday, September 17, 2026 10:02 PM
> > 
> > This series adds the IOMMUFD and PCI/TSM infrastructure required for device
> > assignment. It introduces an IOMMUFD-owned vIOMMU provider registry and
> > the
> > IOMMU_VDEVICE_TSM_REQ ioctl.
> > 
> > The series adds a vIOMMU provider abstraction that allows a subsystem
> > other than the physical IOMMU driver to implement a vIOMMU type. It groups
> > the vIOMMU operations with their module owner and private data, and makes
> > that implementation discoverable during vIOMMU allocation.
> > 
> > External providers are selected by exact vIOMMU type. When no provider
> > matches, vIOMMU creation falls back to the physical IOMMU driver. Once a
> > provider matches, its result is authoritative and failures do not trigger
> > fallback.
> > 
> 
> I wonder whether this abstraction is necessary.

The main purpose and point would be to keep the TSM code in TSM and
out of iommu drivers.

And we don't want a module dependency from iommu -> tsm either..

> The underlying IOMMU driver still needs to understand this vIOMMU type
> to check vendor-specific compatibility and provide the relevant hardware
> parameters.

It shouldn't, if the user requestes a TSM iommu type that should go
directly to the TSM driver, and the TSM driver should involve its
physical iommu as necessary.

> There may also be further vendor-specific interactions between
> the IOMMU and TSM drivers.

This is the big question - how big is the entanglement. ARM's is
small. What is Intel like?

If Intel and ARM are small, and they should be because the T=1 VIOMMU
is entirely handled by TDX/RMM for security, then I feel this is the
right way for them. It keeps the code nicely isolated with only a tiny
bridge.

AMD is probably not like that.

> In that case, the abstraction risks becoming little more than a
> connection between two vendor-specific drivers, while making it
> harder to maintain a clear scope for its operations.

Glancing through these patches I think the abstraction may be too big,
really the point is to allow TSM to create a viommu, I'm a little
confused why there is so much stuff here.

> Would it be simpler to provide helper APIs and let the IOMMU driver use
> its own interface to delegate vIOMMU operations to the TSM driver? 

Now iommu driver module depends on TSM, do not want.

Jason
