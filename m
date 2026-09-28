Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65464499A4
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600929; cv=none; b=fsuWvXl0MJbjPY0UrExRDA8/0cSX1WmTXQE6EMoJXjnqYbE/GxiXBm1aAjJ7qA0AEoR85qdp2g3MvWUPm7miKtUw81RU9PrWdJfnPStmhKWtv2e5obAVi4JCfgd6VHIrtuklRUgFAPRkdhZPs0N+8Ailk8VssN+pLyt/UlXT4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600929; c=relaxed/simple;
	bh=HMf8sz6h2dnybYBuZGK7jThBHP4dhPBd75prPtkOxHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DopcPhFDT9+5r41Zw3Lt2xYJHXPbjkzXZJhS8eBT7GGhiR1bHOE68xQd/gu3IcoHpEdy80+hMAvPziFgsSNJh0wlGCB0C/4SAB+9LFlGhxmlqqyUTB4s1LpImrBzHjjRuLM4zxAB8V4aSzneMO/bvz/fuKjkgPIYu5yjYsMHAIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=I6beTdRn; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I6beTdRn"
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-6740dd8b4b0so2489743d50.2
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790600926; x=1791205726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HMf8sz6h2dnybYBuZGK7jThBHP4dhPBd75prPtkOxHo=;
        b=I6beTdRnHM0vxBbyWAIvdsuliwmJuQiZ1uwYcuF6xAcl4UBeUHjI6jkSbfevKeNiKa
         g92hWx9wOkrWT8CZ+80nk0+QTjNsWHVjROiN8iDmGZh6jX3ivB2Hlb4L+cHPoe6mvGGl
         0m1mseEXm+uVUYzgB7UeDWP3lN5TTpswuh218400/9VKJ5WoRFcwdyenjXShkWtTRLXc
         REB46M7RsmLPkwMG2RGutlPwuH8rnQFMOvleuDoh65pfFBfMXt7mTs1NnKnmTDIO9np4
         ZuFDSXvvkCIoeZmuVxfhoCWuCo1pfvxdcGuPyRM3lEMmfxCJNbVD6bHNiYqLEbJColVi
         YKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790600926; x=1791205726;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HMf8sz6h2dnybYBuZGK7jThBHP4dhPBd75prPtkOxHo=;
        b=gAjsTJ9bj5/1EUpZ3g2ymz4NbtfQnkU+QZufQqio/MxlZZIifxFnCXNLosSunLP1RH
         Sfi6ZqYs8rWA/MueqSKVnMdU7is89y/r5YM2sqeUZVk0y28UWsgs6nt4SN8oy7hrfBkG
         I655CiFViurXKVGgzIWebwqEoNeMBsxOiqftAQxfKTm4kGGdNu4tN1yqgfqhnLSirNK/
         HAB8hH4os9Umhw8C03ihpLTF81aaplnUnATv5Gyn8VvrHmsYbRxDjlkxGnpUlKbsyPgx
         ir0OiKolOrjF5uG+WKJ6scsKY3iF9G76FuPLJ1TXt1mCAdSZAmqQICPD488c9DM4fQHm
         5OIg==
X-Forwarded-Encrypted: i=1; AKwUvByuTTSTgr2F/xguwjO9CtY1dlX4ZhJkPumtNj+uUPyTB2E9k4jGvPKO60myOlVhJ80TFB0=@vger.kernel.org
X-Gm-Message-State: AFuF++m4w9l9VP7IKt1+7ATimT4X+MQ3vz4IkUu/ZNhRprCAy+M6lTgy
	/SRZLCvjefAlCgLUTh79gExXTmbzPalkWfDZaHa6GPAoRHAfX1ko2/LO2A/hE7U72n4=
X-Gm-Gg: AYBFou2ZnzwDIGTJCFGSx7zuZ+DH6kXUdk/sCWTbDxupZiz4rABzzhfmEmU+hoXxSXc
	Pwxe30XqB4G0UZlJHfx11lO9NNpVZERkinOcSHx2tjqVcVCGv1Mqx4betCO1RoSmq2UZvidBDF1
	51/bGHyygwFqQmC9yMKQYjrHegNXwqNhmRvui90LLTb1P6NBpCvO+EJqWhsH/uBRB5lUMdWgnrg
	AKOkJ5t8folyuiTVCnp6JuYsWDMkAF0Wti4y21XkND8ePAuOQmshNZtNPA0WnU65OZIJqVEeKN2
	oZFOe8pQBG85qgBmOttfupzCdgz0OfubiRSHjxm2K1G/oei2hkXO3VObdBhd4z4v9VIZYCsEerO
	fzBXun0T2yLDhg3dw5AGviljLQ+j997qEPCAornZIop2Ao/S6HXYKbGFPbEUvY6XV11X4AQltkG
	sxIYauj3O/DhphX/X4FXuPqZ/q9shyOpaqQdREb7KWmLKV
X-Received: by 2002:a05:690e:128c:b0:675:40e7:8e58 with SMTP id 956f58d0204a3-67540e7c5aamr1608190d50.20.1790600926197;
        Mon, 28 Sep 2026 06:08:46 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ef28dfasm4604200d50.11.2026.09.28.06.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:08:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xBB63-00000006mlN-3bcU;
	Mon, 28 Sep 2026 10:08:43 -0300
Date: Mon, 28 Sep 2026 10:08:43 -0300
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
Message-ID: <20260928130843.GH163130@ziepe.ca>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <CO1PR11MB48358E3116CC6CF34E6437658C812@CO1PR11MB4835.namprd11.prod.outlook.com>
 <20260924192054.GA16465@ziepe.ca>
 <SA2PR11MB484477E4875E71E4C78854A18C8D2@SA2PR11MB4844.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA2PR11MB484477E4875E71E4C78854A18C8D2@SA2PR11MB4844.namprd11.prod.outlook.com>

On Mon, Sep 28, 2026 at 03:35:29AM +0000, Tian, Kevin wrote:

> Looks there are some resource shared between the untrust and
> trust invalidation paths, as iommu->qi->q_lock is also acquired
> in the trust path. I still need to understand the motivation behind,
> but this can be resolved properly by exporting a helper to the
> TSM driver even if it's truly required.

That seems a bit suspicious from a security POV.. The secure side
shouldn't be sharing anything like this with the insecure side, that's
just inviting invalidation integrity attacks???

Jason
