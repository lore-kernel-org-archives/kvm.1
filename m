Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379518;
	b=w7CZ/bv6wP3Dw73I9F3alkxZhtBL1iv/a/sTxrcXdlYbGVAQ/pXE2TxHA1MIstnAu8K1
	 MFJeZH1VZAQ/YXtv7JWTOJgWb7m1tbXDpZqBHHiCbxvnlARoj6J2teGmKVopM2mi9LhDS
	 rCI/hPc1fCN+uRckPK5ALGyhDn1G/T4RI2cQJimettYwP3E1AKb/4zxTWdUvRniUMMRUi
	 41Cz5W0aLeHpvjgxyYpmCIIBOrTqSF01HH7Qmy+ccLgQnmqB4akQoEY3qzZaTFxlVygV1
	 9EaVZwwkT3tfORxITkZv+Qk1XQrU0/njfokhamMTh8PTgB8ZqbuRjYH29KfxERpqA4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Of8qcGhrASNngOAxz8m59rDteGhCMKDYRjobFeTSxhE=;
	b=GWwmOwIGRDeSWCsITFEm5NGGssZSxjAuMIAGqVm2hu2abO7Nm6/FUW4EOgdidWET6aK8
	 CzwimC1YaUsh+/dVfo6eloypQpO2KLZ8qa1dUAgAktuTzc9PrIZzQQPGocK7nL1NdmfGB
	 WKrb0GORRoYG0mMudkE1jv0yJMtoXHWvegNILrxjAvcZc4jXSJTPDZXpt4iNlgzO7jT5D
	 M3V1KA+bwEyk7tYuLcybjg7c5DTReLfdJ1Y45qTW6AFzi9qE470tkc4LjfSFZkdiipMwk
	 Vcc1+dwseVGLYcMT+eJUF+2LT2nmhHlBTQXrg3AqCUNV6Tld3p73sZ26AQ+HvfPyylQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF09E606A31C
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 16:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF09E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91c79f306e9so10969416d6.3
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 09:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793379506; x=1793984306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Of8qcGhrASNngOAxz8m59rDteGhCMKDYRjobFeTSxhE=;
        b=bhjVVBdqP0p5ncqFTagx6Bs8saftcLn5bietHySzPVy+OkEz6ZQ9M/fOli6KxslP2k
         EkGkkKWXOROR+xZ5Y66zJosRACFVLr3t/huYutlqxtRTvemmBSyY8XCDaB4+AHAme/cE
         TUzJOIx69n/1h++BVedB8bNC+bSirPirKyjQj4ta1JNOyf0n7xCiBi3Sgqnppr3n74jW
         MRXn8TAOSdTG77kw9kIjE6+ApVorj0R20JMOvkgwCfupAdhbz9Ne3709GxfyCy0J6QCA
         hcNNS7dNywL5KAaD63ZlJ3I9EzgudyhIHPI13g7bUNcUrkZTtmh9+K8wnpmq1kIruP9q
         kJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379506; x=1793984306;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Of8qcGhrASNngOAxz8m59rDteGhCMKDYRjobFeTSxhE=;
        b=bquLQlqEiaEFwraJgKq6vr9PBCT1ErDDzJLxR+uV0OI+8JrakM9X9g3yL9LD+uSrqI
         13NHyoYhCzNcRXmA1SXEE4axesNmj34Mw4zxgbyfKibZH1QUu7X5F/tD+kB9wVQQSkmD
         DWSD8BSvx/xLeFmjA67q3azba1l/CipmVOnkUwEyJhLoVEhYbFGDL6SXQYBfycZacTeK
         2hH6rultKZyTSZnrrYlhFIBkdV3SrKhpBzlnX1vGtiXoBiJ60A5B8skX5idqtvvOQSnn
         QabxAp6AhR71r8D6eLGXtcgyHBfJPURGf56qVxrREKRKxrbml5brcNHpl+gqA5cstnb1
         +zFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvk4xo2H7Qxq4eUPrEnFgOwgrob8bEA+MP3Uta0fISvyioSZrYx1Mi2u8Xj+zPL8B7wNA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbKWZQ0JmkKePbArwkuZQi30FK/FzxqrysAq9xoPgigvh1Vbci
	JgagViZMGhZAP9Yhuj1VdBA+PCnHRmr6f2xxR3Ddp9HJL43qrzrQJcjptYvuqC3UGrw=
X-Gm-Gg: AYBFou08D1R2TQu2a/Ec/FUtiZsTSMiPkQO5rLNZxR9xA3hkHwd2BwhxBusfMM/Jntm
	33xSCy2IqcXFtDgL0hUM5p1sBoNr5eZtqyNmtA6ZAAdJIuK46oVwHYpMJCUBNqLnQ0z+kYi+sBb
	HvUhR96aWC2WQuSg2UmfsXDOZ0BUakX22Z2FKfqoVOmMnCoBow2cHDFI3JRAfYBPtqk51i9yv6H
	5j93oKdDY0iB9gJoAN6zfpo4r0IGek+z7Vc4EX42ennJgVguS1pi69AH/es9HkLo8mUcR9AiItB
	BY/GVIYDWzN06rzlthdEX1MmAhoLE/sIidCqa+9+o+UyVexRgjG+qMtFhxycraooTkOW2+50fyN
	S3tG/E6FfZ09JWZSJownKNQeA9BrRZkApvw/UMMHfVDfYUuv4P4m9m5FukuCyOiZUzvRNC285N3
	pyIrNLHviVsEA6ZP8VeKUSyoBO/ONaywu0BW+xpMR8r0wYnfuY36NZf6ayYiRfb6eG23L2Ggv9J
	mwhM+o1kWd0U8wpTGjkKsLr5Jpy3OA2QYT8FcASCY5ymld3IS/OxWn9xVgiNolBSehw5ekpFDoq
	cfXR6yKg/YsVOf8+2y1I5Lt9THDFnBpY2L39T8q+nG7JbmoNS1+bgJarrpKfIIfTtmEnG61bXQg
	U5X0AKOrpGZA=
X-Received: by 2002:a05:6214:226b:b0:91b:ec0b:9671 with SMTP id 6a1803df08f44-91ca4b9a540mr46456036d6.52.1793379506439;
        Fri, 30 Oct 2026 09:58:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca80700b5sm19825486d6.38.2026.10.30.09.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:58:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xMpvt-000000019rO-0nKn;
	Fri, 30 Oct 2026 13:58:25 -0300
Date: Fri, 30 Oct 2026 13:58:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
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
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v7 08/16] iommufd/viommu: Keep a reference to the KVM file
Message-ID: <20261030165825.GE3889730@ziepe.ca>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-9-aneesh.kumar@kernel.org>
 <20261014105913.00001217@linux.microsoft.com>
 <yq5aecd9aupx.fsf@kernel.org>
 <CO1PR11MB48351C4BD0BAD3BF6AFB2E0C8C6D2@CO1PR11MB4835.namprd11.prod.outlook.com>
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
In-Reply-To: <CO1PR11MB48351C4BD0BAD3BF6AFB2E0C8C6D2@CO1PR11MB4835.namprd11.prod.outlook.com>

On Fri, Oct 30, 2026 at 07:54:04AM +0000, Tian, Kevin wrote:

> Besides, it might be a good idea to return an error if idev->kvm_file is
> NULL in iommufd_viommu_alloc_ioctl(). I don't think the viommu logic
> is designed for native application...

That's probably going too far..

It should be possible to fully test most of the viommu stuff without
an actual kvm, for example.

Jason
