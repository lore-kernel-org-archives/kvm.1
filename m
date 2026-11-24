Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540081;
	b=kmRaExIkYF25Luh69bFuPZEiq4+CtqAg83/GTP1+B0RE4gCkq/jf0toYctuA/6AVDIVm
	 /ThiAr+DjAd4oea1nUhyAUDL2/KqkM70F6fWpDnuuSQa7VkKu9NPBG/R/8DC50cZWhi58
	 p9cVzL/th3HJ3F+v6Ybzd0XxjItNvzrg5kueaitczHEXNKUjZ/R1mLGBBVW5pwkvkeivR
	 lNB98kTN296T0MjM2/3wcmcFEtJzlIiRatavFQrEf+cszqOCCsxpyxkm6L2AClYuzzY7z
	 f8ulVqEU/jF507U+od6Ah8Y7d2+KBrNlx4sOnRd4fu6amvy7Gqfa6HgZTz2ldgltKOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=u9RNgucBnI08qUwk1iWfTQpaGbeV2FiwOEeQoPQxy0A=;
	b=i+BzALEYq0tF2SpG6dqJ8YVlJ9DwKG3+LZ5Huk1ef88oBLqbNb4WsP9byjAZSj31vDDu
	 9Dj9RTfoHueua+N4kaxNK22fPbXeJQUVSbDarN6FAfygZN/KVDIXkycNfzghIWhR/VVfy
	 y/vqboM1OTRAqFJpvDJ9U5iyfgQnH8gTHk0ur7DZ0gBju6DZXg1a1l6Cdvw0q1O5vrrZA
	 AtNJ3EL8+csL2vw8tiK6sWRWsyj1g1bRtWLLqPV7K6GHjtLPwHrFgV0fsgMv/yvuS5Of5
	 8zKSa4NndR4w5ZQUPEsHlCauJ37g9KzS67p2S/9rM3Ug1uILgnK5gSUT9ck0UdMgfHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=eoJBA6IG;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789A606A327
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 17:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5789A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=eoJBA6IG
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-99e0db26c4bso1323005241.2
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 09:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795540075; x=1796144875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u9RNgucBnI08qUwk1iWfTQpaGbeV2FiwOEeQoPQxy0A=;
        b=eoJBA6IGpXZKdesYLQ+KB7Xjo6AJ4qRDJ03h5h0ODj6CqwajC0zq1sBm2lyIx5+pT5
         IXc4kIUNGgUGsr0o898YmiiT2U3e9ADqu6XarwH7ZxdSIR3vZn8VMNk2X/hSArEggZCy
         cv6eUweUN7Z2Kp1cApPyTPLuNcHcH3WHLXweCYjUSUbkauY+BzaF0U40ELSTaaRza63t
         m2XUT2IjlkHJ4noO2/vGjR/INqfPTp3RzTPSCKeFavLhn8uRz/VT3jLU94VbyEK+nlr6
         TSgtGiodl0JoPkqmm3ro16Vt9N2/MPHVnYAhCLMtCCYwZke34x9sp/aOTSzfBJ+fMnF2
         wR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540075; x=1796144875;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9RNgucBnI08qUwk1iWfTQpaGbeV2FiwOEeQoPQxy0A=;
        b=MDDUFVnXUAKfsVDjlqnMSMDNpVQrRURDULsT0ZtTWgP5csVL8l2pXWLlAmTfueN99o
         UCMizPbY5AbatGRU+vnzgAiKitYlXguCrJ51to/nDYJ5iD+LMMxDDmbebnK6/a+56ySe
         5lm3RI7c9SADDWvPW4BKuSTws4wFdbR3or7iEI36Ddw9cB+CtjoBYTI03I3m/ATuf5qK
         souaFdrbWzRG7wm6OiywHOOSlmeyW+H606RW3S3ab+O6SBlfcRBgfupKcZpghCRJd45s
         L0SXEs7pzCdT2x3xK+7s+rsP+80XPizkvpuAwAFc2keLUjIGLfI1l5/3OrTmGzINBkMU
         WCEA==
X-Forwarded-Encrypted: i=1; AL+hErHG+iHuDcz6ExZ6prhms8/wnJD5m/xoLYUCPW4BrOTyo/4wNikfuWLvnIXuo/K8PUWTcrA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YZ62WqO85FWhtZMd6Wf8uaZccGuX3K3Jlg/xkPpuVPylM1Q8B
	wu4VbMgshAOQFBXdGWIjl1b4IpUSi2m1reEW5fLT7QexxKuFn8lWZp6fBPfmgo0eTcw=
X-Gm-Gg: AZFdTZeg+8IbhqWAJnuP7bRtoWvMFOk+2Ck9Iy5c8zrBwzGl/jApqAUGxEVDKPgb0HH
	6ffIIZr2p4vWHlNUdWGkLE9/yruQ3yqOAAMrvpIUsogaNQcULWL+MwIZBSgPFuAwUNao6hBmnLf
	BKMBBJtFWlm44aGm7i4MQX38bAA8g7AlOcBuo+m2F+jShF7emf6z6Ikh9PYItYQX63Mao8ySonC
	tfSPq0KdMB/02qeGRokiqyOf5JZVaBpUjt9eiQUmk7h1Zu4BlCnjUKrRMlW7NA3BmmLM1Uyx391
	usr/fKC7A1EDWgOFA9s8bxcufOq8s/ZUi8r3mlifNwnPziKP1Zflg4dCnrNC/jpKcVKmxnzlOD7
	PhN0Z9r7ejdMwSQndrVDp9I+UuMV8y3LkZffwYGtdHjQoaaIUtbif9FKh53uLXIe9hlp/q2TVK0
	PdhF/bZ4NJ3CE82fMQRf+7vS6jBpgTm457I6ffuCjWRkt/jeebg0uaVZfB7AW3HYo+lF/L8+29i
	PTGUz3d9XmpPKGeW7uaRy8Vkn8l96cPIgotUd2dlaw8/0MqRZzd4z93tu3polUmRMQsth3ToR6v
	Wk3wmQ==
X-Received: by 2002:a05:6102:688c:b0:7ce:a69d:b020 with SMTP id ada2fe7eead31-7d72b36164amr6731183137.5.1795540075186;
        Tue, 24 Nov 2026 09:07:55 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921366d853esm132634586d6.27.2026.11.24.09.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:07:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVtzm-00000000uyF-0Lng;
	Tue, 24 Nov 2026 13:07:54 -0400
Date: Tue, 24 Nov 2026 13:07:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 02/10] coco: tsm: Register the TSM class before device
 drivers
Message-ID: <20261124170754.GB114530@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-3-aneesh.kumar@kernel.org>
 <20261123152903.GG179082@ziepe.ca>
 <9f92f7ed-5198-45aa-9cef-515ccbf98398@amd.com>
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
In-Reply-To: <9f92f7ed-5198-45aa-9cef-515ccbf98398@amd.com>

On Tue, Nov 24, 2026 at 11:40:16AM +1100, Alexey Kardashevskiy wrote:
> On 24/11/26 02:29, Jason Gunthorpe wrote:
> > On Mon, Nov 23, 2026 at 02:03:29PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > > Register the built-in TSM class with subsys_initcall() so it exists
> > > before a platform TSM driver probes, independently of object link order.
> > > CONFIG_TSM is boolean; remove the unused module exit path.
> > 
> > Why isn't it modular? This is going to force alot of stuff to be
> > non-modular.
> 
> The TSM core registers a class. The platform TSM drivers register
> TSM devices of that class. If a platform module loads before the TSM
> code - the class is not registered yet so it fails. We could either
> teach modprobe or have dependencies in the module or do this:

I understand that and Aneesh's patch is fine to solve that problem.

I'm asking why it isn't modular. They don't conflict, using
subsys_initcall works just fine as a module.

Jason
