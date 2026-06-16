Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D7247AF75
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630853; cv=none; b=SE/zkeNk8ObSCVeCk+u0r1JeDdtWa6MKazLI1r8P3RctNlkXolccNRGvDNtAXlmvQ4PS7+GUB5joq16BqQQ8Aov1B4QN1zlal0unWsOSmBr9s2PSBWVO2AiJXgwU/dQxC4FEudlAt7n73WocLqcbP3hMXOGhcsq6B0NNRCMsgdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630853; c=relaxed/simple;
	bh=VtjaadP+F0YUxb65uRur5r6Bmp3C/5715zYvrg4FlHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRSQUCrekX49mO+jrCp0R2OpDWTB1j7PsWHvNkOne59rtrX0X5RqqQgQ20rMgNvUML8nkKKqwwBXqI4fZxF0bkm3VB9kct0jYhyB3NiMx0F20TCXbpSIilUQsDO/C1+c1kmWIymlsNQGJjLuJ72uo856avxveOCuBefuK6BooyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jIsKFfN1; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jIsKFfN1"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5176d4c14f5so37479531cf.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 10:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781630849; x=1782235649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gbojEdCp9OpH0p8tfFcuNMVV5jC/64+CSjIGMdMdWB8=;
        b=jIsKFfN1K7t40T3Z1eYuR97Qnfs+SCeTuq9lnwCs1kzqD+2fNfVQJVjLC88sJ1Oidn
         RelY8h4rWxu3ipVELAkLDuTsF/hG3+ErzMLv9Je83yjVLgaiMrCfJ4OrqOsXSF97Y9d2
         lIDOSvroeYilx9POcj3elQqm6EIKWxAe7JpQWiHc8SKBZfQanyiUqw21vBrq2urXmG+Q
         uomDd0M1HSIjiA1yZgf+NbmZFb15Cz+wDHdm+y/YuML4iIWKpI/ZTMMJ7VacS2gw+7io
         5REGh0zAn75XqJybPBka6ZcUdZ9jzaQLNIx+Eu2Z1q7LYMK+aXjP7QmVwp1CT7seIOEY
         EvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781630849; x=1782235649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbojEdCp9OpH0p8tfFcuNMVV5jC/64+CSjIGMdMdWB8=;
        b=qWo6q93IIFWG02Z36fVb2TZnG/e2Pm/tdmrFu24v3epejN47flIKx/XuK+0wNMJ1yG
         AjvCoh5HN/3aRwHHWvGnHOzP+iy1iDi7B/D93TCbx7JTWYjz4edy4dKMW5MdY4A5VeSS
         vL+7MLWKwZYxS/V+WnSPTrWBnQDm6LEYtztJAZ5HGOFMS6OKadw+HXTO0PS0ibeqyJLt
         rwNHUPoTnGjpH6oYgCYdHuKI6h4IrLzsT+ju8+YHeERm4uzI5hKK5YranLSmzs5ByoMg
         tfmoZwSxc/qJwFlM7o51eMYcVVR/ZRcUzSM1iZ+zEKOu3B4542+TnLU3GutFUxKlxYh/
         jxvw==
X-Forwarded-Encrypted: i=1; AFNElJ/mtnxSIqKuogFwPleDlT8zdBaf4OqKuJbflIRKYAIzp87pggH79YCHF3qlHEI14A8BTBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxikImnbfgo/PnQLlpuc0ynED+5vgBgmV4UbBp1/jTdManYY1Hl
	D17unuzO0ufYyr6wbZU/BBW2/iMqk5JTvCii4IWRhCtpuKU3QsQOW13XeccnitCmCG4=
X-Gm-Gg: Acq92OFWEPUeBDky7ks7BC+EL5CB5/AA+bYu0fqunUZ4NbbJNjIi9r00pPuTx9ETRYZ
	5GeXCFBvnC+srKu9oFLTZpMp9Z5QBwcQevjJjoONgKe2Fdk5Yhwr5vCxkBAJM0fwpMHyJR0CrjI
	2MLfVUZnK1irkkcv4mUQ7Kd7wsB4cQihymFxqJ9VQc3QviViYUhGGhXr7s/rlDQ/eKoj200YBiW
	gcZHOQr3HMBRTO+RCuEWNnzY+oj1mjKyoXcLiA5ACjacQwczjN5iOPjPrSaTOg0ZrmEIQmPrW14
	1Io4VHaZHD2LVPh/riHrrUe7OtllCMVEZheTKjjG6yEvrAJgI4IAxlA7QieLgTkTNnhKnmD6roo
	hVEb59fdAjW6lD2tDhqLcHKru3P/kh6cMUXdocllNlRzMKXkdSy/i2rFBYDFE+VDa6SLtrL9bMH
	ip2+s2CvfIvJBbfUDTc4IPXcS6VuHpLwif9euL6TlEEGlp+hx+NVx1AnnH1fgMDnE2o1dEJqVFB
	NJpKA==
X-Received: by 2002:a05:622a:4897:b0:517:7d99:f32c with SMTP id d75a77b69052e-519a8e5e259mr6448551cf.32.1781630849518;
        Tue, 16 Jun 2026 10:27:29 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb83e8e6sm156638201cf.28.2026.06.16.10.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:27:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wZXZQ-0000000GYyO-259c;
	Tue, 16 Jun 2026 14:27:28 -0300
Date: Tue, 16 Jun 2026 14:27:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Chengwen Feng <fengchengwen@huawei.com>, helgaas@kernel.org,
	wathsala.vithanage@arm.com, wei.huang2@amd.com, zhipingz@meta.com,
	wangzhou1@hisilicon.com, wangyushan12@huawei.com,
	liuyonglong@huawei.com, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU
 to steering-tag mapping
Message-ID: <20260616172728.GC3577091@ziepe.ca>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
 <20260616104621.41915-9-fengchengwen@huawei.com>
 <20260616144224.GB3577091@ziepe.ca>
 <20260616105754.784be22d@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616105754.784be22d@shazbot.org>

On Tue, Jun 16, 2026 at 10:57:54AM -0600, Alex Williamson wrote:

> IMO, this implementation in sysfs more so proves that vfio is the wrong
> place for the interface.  vfio has a use case to consume STs, but it
> doesn't produce them or own any of the mechanism by which they're
> generated.  

I would argue only a VFIO user can consume this information so putting
it in general sysfs is overkill.

> The weak point is whether this bin attribute, exposing an array of
> structures, fits within the socially acceptable norms of sysfs.  

I'm pretty sure this style of sysfs is not accepted and
counter-examples are things that are ancient or slipped through.

Jason
