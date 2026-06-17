Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09782E739E
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 03:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781668429; cv=none; b=GdTogXOCfE5C4RNHc4cQuuM0V6azvj6B6ekK6sAmif+errMbA0xNEIk3W2JVftUzyK9ZnHB9yZQoiylbRsPvqG0osrOiNdkFq/TqEaNxWU+FB3nR5Qgl8Gmjhb/ar/ZWlJ4AT+DwEsE68Kblxz6AZvYgCxVjiQghoLA7RsTKyLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781668429; c=relaxed/simple;
	bh=M+sJwbZjGprqJ5P6dzrfQG1U9gug3I7000Ogu/10Zeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Geguc3qmEUd9hTVP2rtMLtskQvlVfmzQQCGz52mjPb/EPVOVA+zBNI7WMnShoqV0mppBeXAYmzB7vl6tSJ2vSYiGp3QL3ixXxL5FXUvdExzBqkRi/tFx0ifzeRLTHMIJPHQ1WPmtRMbI9DRx6GpB/FwreouLvgbeuHE5rqAL4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso4429311a91.3
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 20:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781668428; x=1782273228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F12h5agOgtTKhK7bZXDhJCivRbCg78HbH6b0jQZn4DI=;
        b=YvZXK2f1eXuSq7xYT+GRQ1RWVS/s9aI8zkNz9Ynst2SugP7+elAUcln1SiHFuYn+9S
         4aLV5I9Ib47/bj8l0UUWDJ983BplmxDJIuqlwPQqAFjVvOKaxsz/GaOsHXfL6MQNyoef
         9yvWXX/MwHjF+Y1gnqqn7EVfST0wzvC/nTSSP0LUEYzrOQNA7U/KZsPf3rxzbQOX1A5P
         NDb2sYV0S9xrgHCX4ksJAC/nJrI/qOEiOnnf5vnF9GF8IIDstt45YGqHXv+C0g/oyL/I
         YgRCm8Is7upoQlG92sgQXQMfSmJITHupOuLfhBZOCja5CbDcbCkd2k6ieeo/C9sraQ3e
         y2UA==
X-Forwarded-Encrypted: i=1; AFNElJ8PYOUV5jr2fxeI0x7hH+ijSuCLaPO0hbI0trWKw+zuHKqVPeaKY6U42iJpRSst+upcUXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD8iyCSod24V9btYXVOvqF/dLgL1/Kv75rCUgJeAiCFxSM3dMK
	ZHwvPwUi2iD6Ihar7OsjMdOFcqbYF1xP9la6DaW9jn84sPhBeoo3OkH+
X-Gm-Gg: AfdE7cm/6SWE0os45phQFN4kcvVVzEprP4eSkZ0YPOrUrqqHWUMbr/BmaXeKOvnYWnT
	kR3u0/JIkEjZSt1CC+yVckiNvAem1p0O8gfAlsDZNKQc9dKj1tP0LCjX1MieuZR3lRG1b2o+mz2
	6c5P7HtwqUHOCx4TC7P6KKdHhU/bSFR2j/f/n5rBY5eXs6M7xi32xfjJMn4sQVj+gVusSkc76Ed
	CMCtX0Ku8qnU7rN306FAxe+dUHI0YBcS9O9O3hwt4swQ8AK53mwcw/vEXxzIV3LH66l9wM1PcbP
	0/AfN8WL9MykB1NnYm8bmIVgsCaOkZ0X+X9S+hmiXtYzFeForX+ivBG9PQBysCe3i/L95iBC0Tw
	P0CjNnBjIDj/H5h1rJ1KP3Cm/Qe2IivVEVv4L299gb5wKEkvJgE5ioaqeQ0W6L79/pWaE8YpmJ6
	3mfdN6HeKJKzCBvZsoDP5lbX2B0CX9XYzc3MMWEOZGF1imZTMsqeRpUZJDTbwaSEyi0ef11xte7
	RslpRb6pyF5FdGrSPeJDVGlxLMGnIYZ5po2bLBQn02Y+bh8dN+8+2Eca28PG1AGSsfwx2eMgSN3
	UAs2PR958vpFfM/S9vw7
X-Received: by 2002:a17:90b:3d44:b0:36d:b12f:613c with SMTP id 98e67ed59e1d1-37c9ddbd514mr1772249a91.10.1781668427949;
        Tue, 16 Jun 2026 20:53:47 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ae78csm4435118a91.4.2026.06.16.20.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 20:53:47 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:53:46 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	helgaas@kernel.org, wathsala.vithanage@arm.com, wei.huang2@amd.com, 
	zhipingz@meta.com, wangzhou1@hisilicon.com, wangyushan12@huawei.com, 
	liuyonglong@huawei.com, kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU
 to steering-tag mapping
Message-ID: <20260617035003.GA1415869@rocinante>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
 <20260616104621.41915-9-fengchengwen@huawei.com>
 <20260616144224.GB3577091@ziepe.ca>
 <20260616105754.784be22d@shazbot.org>
 <20260616172728.GC3577091@ziepe.ca>
 <c913116a-35b4-4934-b78b-8fa0a08a00ae@huawei.com>
 <a81c3479-1749-4b9b-b913-cfb20c621690@app.fastmail.com>
 <e2db72ab-6d51-4d19-8dba-0612207008a3@huawei.com>
 <c3d7ce59-bf5e-40fc-8f0c-6232c58c7495@app.fastmail.com>
 <c1ae7910-6028-4dae-a462-e7464a35028f@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1ae7910-6028-4dae-a462-e7464a35028f@huawei.com>

Hello,

[...]
> If the community still prefers option 1 after this discussion, I will fully
> rework the binattr implementation and send out v18 following all your review
> feedback.

Perhaps configfs or debugfs would be a viable alternative, if this is
something that does not have to exposed all the time?

Just thinking out loud...

Thank you!

	Krzysztof
