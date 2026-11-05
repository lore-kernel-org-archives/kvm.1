Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839783;
	b=ky5pV3Qud2dtMRgXQJVjXpGEBeVQon5rV/Uu5oCxw0T80c53t85ZsFmwUPzgkAJmBo4N
	 nl9vsxxQH1S6sz+mSHUzPrySwz1KJWH/vFRzfpCazGPIJqcNYWB59fjfxgfNmaPgz8Zlf
	 wdVhUMVNgPE0b9rlb7Vl68PrG6nyz5eRqfWSqwn6L/Cs4723/YiyJOFXTxER+GzoTqzb1
	 6CgDzbRBwl6usujNUo1+jFkaKGQkFXg6/WeUhaL2R+ncVMEcD6D57rgVkIXAx45eb2gw3
	 LyUD0NpTyRSezG7Q4uvWWs3qcWWLPmraP94Zt+Xix66LtNbqISMM69qKHuzuPiQfJiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=LRIt6wL5JukeI7CutNHrB30kNWGfRXMCU9CjLoUJZrc=;
	b=vTsA+IFLLTbxQFCr+zmmZpTbduGGdfObmYR7/qtzpzpemJUojtBigyJwaXSI3VLOctQ0
	 oX2w2Zw99gD7tCv6ze3yiZn9F4UItR9SbsukciVRBt4fws31kPsiGMTp66U8cxBebGVta
	 YJXlWiFRkIyNHU0kHaFf0OqxnGRP2GVchzZB9fLCP3Fq5emH6pnnczeCI8KAs2t9okwGt
	 aS1RNOTmtuehJrvfsrDqRwD9i7fhF28W2AgUBflAFKjMVX1yDbzslz2aYIRBlUpn1J3pP
	 zjO75sauocj9shlywCQSiGUcawLC1Dd8cA3IZFS8tMQTevypN9WtVmvMZoGpN2+tpUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Vrr7HJ5Z;
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D03E606A32E
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 00:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D03E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Vrr7HJ5Z
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9999f21f617so301519241.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 16:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793839776; x=1794444576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LRIt6wL5JukeI7CutNHrB30kNWGfRXMCU9CjLoUJZrc=;
        b=Vrr7HJ5ZqhVHrUH4gQ1nhUYTf6eI4jAFUgOXuIroG+8vYSC8wq9FMKyRpAS0X3S8Ia
         X1WvaOw/i4Kvigi7NNddiUqbBVXB0bl8fUKtHXcRmXnwjafymJGOic0zOT0I6oSflaLk
         NOUATYSym2MCrlG4yos53f9Oevky9c0aEBqEq6qkq82K/dxjsJuVvv0TmlNCrPGnNsvZ
         FAiUD7z3B7GJMVLpYW2SE1rjX1GAd8E6xXhVi7LPD3Ev25HhFl5bCAGXS/2HTyk1k0Wu
         WdSBZyZbyw2N/RIxEj2XlnVmCNcH65D4QX9iezm0KOHSHS4RBEb3WjnO1Olgkp9XzRqW
         1OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793839776; x=1794444576;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRIt6wL5JukeI7CutNHrB30kNWGfRXMCU9CjLoUJZrc=;
        b=jGnuQJ4pcwHOpnA8HtDceQdLWfKj6PP5Pc+VEeWH09GSoYl24FYUIq4V27Xau8R/Vg
         ebu3jKxPmXj50FavS8yIw0bLGmtBAToxFZjajUScb8eb8pF2NdrAt8EmsZs5etxQm2E8
         x1UiaPpcOWiH1E9igdRHb+0APlpFmrKVdYUAsjcMiIpP4QSxittK+Ms683nXsj8s8y/9
         b6D0DaM8ZR6ZqoIOPu+DdlK3IPpE1UKlICRXGpOJVzq0EKnQos159T+E71fkdKqIGAxS
         RZXxeLSYt83dUELdmZDpVgkBJX4vKj39LUVtkxJcdTkIKtSR2yA1uu0sfJbhzRtnPWku
         KsHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCSWju57g8R9TT8RMmOHj5KqlACGzrbXAqnBO1jW7jzRhKMlYocwx5ZzPWlbGU/lGGuqs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xz6zC/8TPXpa3rmAj8Q9aV4xmd82Khrj6GunUBHzoQ58S6wC1
	I4k1k9SxRE2HKTDijN/iShISsahcYAsry2NMJzEmu09HRT4gMl+ZuHlCdn3JMy7e8Gs=
X-Gm-Gg: AYBFou3r1mQMq4ix91hrGHcKGbbtTEcARsJbhRTfC7zwopLN1qjYTT1BTLH7/bnDIyJ
	T5eNl0Q5FvknCTkEfwfyX5bxufvbMq0G/R1an1GWSF1rNKhJToZ8W9+SIQxzFUrz6U1SAbFxDsd
	3p6QaoWNHHmhd0yyC+8wAjoN0fuLra4VRYioLFt1NoVsXqMKhymq87womtQULhhm78Kx8qSXzBu
	9KRWQDytiskzq+a5Anp41AbcCyv3F9qyfS6BEf9qBxm5lwPEABkrr3ImdglAGu3VufBznZcO2NT
	fgyX8eCMrJmxMaVWrSTI6NZ9i/VU98yWkrOE5KSVjAqVx5ejC8LU2hDTlU37/daYEj/fhR9m+k8
	x3/btYTEEzf5CfPjm3Z5GtFw97thcIFadQn5jQMhizJBRFxnPiUWiEWKkk+swm0PG/1NJlJgh7d
	l/IHBu87rCixXFv5dVEW+rxoIQMzGPnMNGfM+jk52WXThQL4SVw7bE6nBapTit5S9B5cDdajYPk
	yejqLU/auSnqXHzXGaWd1Lm0rOhl6Y85oggHauU0n2XnJWBH5Umez8reWrpXzNUQ16IFTX1Y9Jk
	BbZK3/sGcl6evqV3edIE0SkQ3QILrbkP3bpm/ieyY5kHSVnaJqSucs1w4E2K/0LxtN6/US+sbE9
	/5q9T/b0FsTA=
X-Received: by 2002:a05:6102:5126:b0:7cc:56a:58e0 with SMTP id ada2fe7eead31-7d0725e16d4mr6016853137.21.1793839776242;
        Wed, 04 Nov 2026 16:49:36 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d9a9ca31sm3266318241.10.2026.11.04.16.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 16:49:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOlfb-00000000cqL-0257;
	Wed, 04 Nov 2026 20:49:35 -0400
Date: Wed, 4 Nov 2026 20:49:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
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
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v8 12/15] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
Message-ID: <20261105004934.GE3889730@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-13-aneesh.kumar@kernel.org>
 <20261104152351.00002565@linux.microsoft.com>
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
In-Reply-To: <20261104152351.00002565@linux.microsoft.com>

On Wed, Nov 04, 2026 at 03:23:51PM -0800, Jacob Pan wrote:

> I am thinking MSHV/pKVM can register an assignment-only tsm_dev to
> leverage this? Could PCI/TSM support this role without device-security?

It is certainly not what TSM was originally imagined for, but with our
new arrangement, yah maybe so?

TSM basically just becomes this weird overlay driver on the PCI device
that does stuff. Some of the stuff it might do:
 - Register an attestation subsystem device to do SPDM
 - Register to allow iommufd to create a viommu
 - Some status sysfs ?
 - ??

It all seems separable and composable to me, so if you don't want to
launch an attestation subsystem device because there is no SPDM then I
think that might be OK?

Another option would be to somehow obtain the viommu from the kvm file
descriptor and rely on the fd to handle the module pinning/etc. I
don't know how to do that nicely with the way the modules work
though..

Jason
