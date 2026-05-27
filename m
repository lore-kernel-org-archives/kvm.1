Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5853FBB79
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885402; cv=none; b=INCaWMcosN75CiEyQuelmuZ++QwQtWUGOIbKLL9RA7aCylb/XQy9ly5SkDWTjAXTIrNQVKA+YgrKVcttb8yAuQQyL+a9vZlk+9Q1mvp84c2+2D8dPZX+nFEC3BwUBzCvM/hHvsJ2W6V6gD4hxDmf3lBukku/2E8tcekRVaGQDRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885402; c=relaxed/simple;
	bh=H7p6mpDtDLxmKvgOZ4pgS/ak1T+DvZzVyyf47SslWwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHuj0uioZlH4P684y4J2BHb0iwJ/5z2b+3Rn4EFP5B0pKHUrK2gdW/SmVrZ4JOYK2lqxQWhDQpXwW8kO/4z7MNu94s+tDZnDp9t1dB9hSfw3RKE6GgyXoVCW0klTg8FkjK4Q95SHq0goxyPQyCxK7TNSOcFnUJUGtCXoYBJFLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UVUIw1Pe; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UVUIw1Pe"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-914bf787977so389675685a.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779885396; x=1780490196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oAXF5UZCW6iJvbxUWxjJToe/IDClMd9U7HBLuJfAyw0=;
        b=UVUIw1Pe+iVgP2MaWntCCcmTVdFtxJ43P4b9vkG6V1hz2oZ71ktASAYU+aXvwRtFzI
         4rmquspQgOIxfrJO7NE5Dfk+n3R9xiugHdCOzkWe7AYTGau3DVbRW89DDJrhC81sLaE+
         o6a6B18gLyrs7UQieFJwpEBol3hnlgs0gxkWfow1CvLpCIRXlNPoMJCkG96es13xPOin
         4d0BYlETpf3nX4upGpx0q00LdG5X8YdDbvKEf+fu3iB+XUkiBHhr4sI76mCB3WkEdpEj
         PTk67x4NA2ZHuWq9h9KCgW/rVZvP8Ncl51og1pGtrBnuYvzZHf6c6yfaTHPsQzPzcR1n
         17pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779885396; x=1780490196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAXF5UZCW6iJvbxUWxjJToe/IDClMd9U7HBLuJfAyw0=;
        b=TSmD1Lc/U0zK8ktrQ5hP6nncDM91ZAl5qJWR8BEymJq0YmAkAvvGTmQkVlpfJGUDqY
         eI22EJECYDx560OgdnH8G1ovy78t+Em2YkhemzFrykP1msMARVCLMgkijnGT2IWCn4cf
         ctCgKeRXlyN3mRfbLe2D3/FaO2IYYcZR8NLcIr8PO3Ff8oZVs42W7ZwwscIDNixUbrK/
         zGDU9qP+qDQwiOu9zxEFUmPYoZRiF4+OLlR4x3WDvrBetghvycuzNarwEEWp3ylg4Khz
         gd5khn6aDq2aNhKoHDaN+BnDraEPNxRdtiNo9kMs3JNSFPK7JZQUSlxHzA2MO5oSMY0T
         7EBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Rtks/vheWiuokhuyYceksUs33K7hZSAna26o7KeED2awjQlDx399MrB6aJRtE+X/0Rgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOnaGK3mm8UeJB/oIWZb4SigsxadkAxoeokNXh/TjUr5A9H6XY
	Z1YaQ50IEcu88NvBPzONaekG/cVYfEZBIUOmb4yE7gekwUo81nzIo7TYr4v+sti61mg=
X-Gm-Gg: Acq92OEdY0AZEZhyoyM9hnpTfFlWNFTAu1Di3n3/C9wMEAFXBL2ZvGm+uvz/QlqRDJF
	cqOj8/66+SsgOtq6Yh8OFkrGfrCIAxf3QigYOg5VYoyQJ5Eyi0OV94nzWkiY67FTrwew2Qpe1h+
	cJxNwKk4qoR7B/VxRdmrcmyJZa7fUZ/qg31zDmIxCIw1D6MbJaiZaPzV9vAdod0fcgplIR5S2HJ
	Yg+FTG6VCWXguo+nzYP0Tb0yb8p/F6KCF2yOk9YADULIdFpZ1GLdMhlrM7WbZrkO4rYIRByMYdg
	l/q4NfjuhMT/D3sVwyUvuRwUtYSizY7+FJfgCLsuHrVSjimBoIsrSrP4fXYGNkgzlMWeqfGr7Hu
	6nLaalZyFN7NknvObL41gsFLkNP8sxzgNVGA4laxH9WprYjwUCMVDErKHGS9WwN2o5v1IS9gzHR
	6UxwhGkpIFvP0po+SfPpVpPXT5W1ksxkFgQ4wv8rwxcrg0n3yZJUrN3CDdMrC6uhrl70tkMVY7R
	blvoA==
X-Received: by 2002:a05:620a:438a:b0:914:aaba:8d2e with SMTP id af79cd13be357-914b49336ddmr3211226285a.14.1779885395945;
        Wed, 27 May 2026 05:36:35 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8800e1dsm455621385a.34.2026.05.27.05.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:36:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSDUw-0000000EOYw-0lyZ;
	Wed, 27 May 2026 09:36:34 -0300
Date: Wed, 27 May 2026 09:36:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260527123634.GK2487554@ziepe.ca>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>

On Wed, May 27, 2026 at 02:23:46PM +0200, Christian König wrote:

> Yeah that's a good point, I should probably rephrase the question.
> 
> I'm aware of how TPH works by adding the extra ST to the TLP.
> 
> But my question is how is that useful to a PCIe endpoint? What is the effect of the ST here?

TBH I've never heard Meta explain what their device is doing with
it. At least it seems to be super important to their device..

Jason
