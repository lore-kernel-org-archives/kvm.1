Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA10343D8A
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085494; cv=none; b=Xtanok+pKQJxF84Xnk+T2FGjDKkIyYOqWsoki3zrp/LxM8aPZI3ocE9h3O1RrJktkoAXPZtvem1OrCFUQd3y9keUF7q3D3Nk0DD9Af30SNSjIMLlq9TDCZYzT09bOZqDam/BPGu1inA1rS8GiNkLWVosHKyd2FRJPAl4sA7Hjhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085494; c=relaxed/simple;
	bh=yIjjEsSzcNVlj5Jerb5VL9COIWs3RWb5zUy94AhWr9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pS/TxtNSB3wdShL4/oV5OHQDYsSY4alSgZt7TFJHTWzy5W0n4Z0StymmTr9LQi3YaW2RQhJl79BFjuvTCGoU8k6wH+eRaH1nNsVCfyT8fgAN7AbmfOXYA04rWF/BdjPullgueZxt+bSs2BJqC4aQNb6NHeeJd5tvEVb8kMzNfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=W6mucJMI; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W6mucJMI"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-914c5898245so566363285a.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780085492; x=1780690292; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x50nMfXuC2+erTFJFRG2pVEkXmZORi5k9T8WBzn0C8s=;
        b=W6mucJMILm76P1OvgIkeoQrHk1o7XL8eEki7XJZS1XS2OjCf+Mt31OyMtZjR2qaphh
         JYplHQ+jawZn32wdHnTUZ7/BfzMzKsTBm8Fig6rF907+pur3pR03NcbXI3r1E4jPnjWi
         Pj4l7r9Cd2P7VD6P6PcOKOr4ri/urmF4R+FIVF9YA78pTdvWQQSYvF7Z7feosxpyprw7
         +tFE69MQ32W/Mxl0Hefoqfx48geK4OASrV2q31UfG3eYxFQEg3WoFwURPR8t8K7LU6Z6
         3WzIrlfGGwk+6WgLZUiy5+fga84k7c35MG0crSnEaA2c5absa3at7TeFsmJ2pdiwI3bK
         qt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780085492; x=1780690292;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x50nMfXuC2+erTFJFRG2pVEkXmZORi5k9T8WBzn0C8s=;
        b=OKzvWcAmBVkExL+U+jV4W/1OQE6sogX1VUi3nZS1+GuOKZtb27/9A1hMERYjp8ULjv
         Jwqwy5vzrxJw5ddqi7SwYInMw0T9kP6ALHMa9La83icnY45NId8puEeoqAuc8Ew+USbd
         RjwXro42h5aY3h8n0kIy+xrG1zQvojRFUmE8rofyRonFco2jKuejDqf6F0e6HDWAO7mL
         Z+gBhA3zt9sjer2YIbTzgcylwgYzYVlz7d9zfA5xhIbM0D9xa2vnI+khKaoxk20nL59d
         30ef7uxJPWkJ8b5r//cCe4CvioYzkP7aKz3j5+X72NVnSHeYA/i+LNOKO0lw/G+Fp1KP
         JiSg==
X-Forwarded-Encrypted: i=1; AFNElJ8PLMcU1RlsAMiw1q4drPG76dn1ULZuQVJqe+DNQN4oSmf3dJ/O3GFdtbAODpTARC1kQKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgYZ+IWqzhEi8fHRFbq68plEWSfgb6Npw9qrgw5CI8CTzP+lb
	EilUBxwEJAWjAhe6mmsKp5Qh9LEXnP/+6Cv0Mx/GDVenCg/GfBy4CJk2rJpOAGYHpmo=
X-Gm-Gg: Acq92OEN/rcllyxDgUffzMhtAZp0ELJpGwK/zXVRHuiSSnNwVBp/0fkWN9TvUY3s2aw
	Ic7Fk+2/0raw1bFM8+XjHTLvlU5kcafdG8bH3hL0/ALT58figpTe+Qah/t0CfCHRS+GVuw8vp/r
	JVU8WI2hvh7IqGf/BYzF4tBcizSYGK1WEt/pXRAOoww9/zU4GMmdWmj/Q4wBiOMgeaM/NU/kGXd
	v0qCAl31DjN/GMREGcGLCb0K64R5zsSNE1dquFucjPpswDcDHkyNRu93cv4lwPL7xZ890P1Rf8F
	DdNjn4EPWk9PmrcEfs0kAQ7pQMMFmmYl6aA+2ZJYULn9ONFCyN2prBbGMbWdcDeRiX0ygvcLJ7e
	Dw1dZtU6Qg26n78BBhvt2O9CBUYHcpUw2wHRLDwDLsJUgEJ5oTYLvFmOg3Xl8Jggh2UUOJOJiN2
	98m9Zx62sHgiSFZG7hNDN+xEjzBLcfbJa8hoQo1nAfF77a/W6qVtfEFushrcG1Uk5qi4hfDyGe/
	5dzGyHzh71l5QkO
X-Received: by 2002:a05:620a:649c:b0:912:671b:d090 with SMTP id af79cd13be357-9153d999728mr194543785a.24.1780085492316;
        Fri, 29 May 2026 13:11:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153244de53sm312617585a.8.2026.05.29.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:11:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wT3YI-00000000q8h-45Mx;
	Fri, 29 May 2026 17:11:30 -0300
Date: Fri, 29 May 2026 17:11:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260529201130.GU2487554@ziepe.ca>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>

On Fri, May 29, 2026 at 09:36:00AM +0200, Christian König wrote:
> On 5/29/26 08:34, Zhiping Zhang wrote:
> ...
> > There's no in-tree vendor PF driver
> 
> Well I have to admit it's a bit on the edge but this sentence is a
> show stopper.

I think he means the device is not SRIOV. vfio-pci is the in-kernel PF
driver.

> DMA-buf is an in kernel interface for buffer sharing between drivers
> and any change to it needs an in kernel driver as justification for
> the added complexity.

vfio is the in-kernel driver, this series fully shows the in-kernel
API using vfio as the exporter and mlx5 as the importer. It certainly
meets the standard required to show in-tree users.

> When you have a complete open source driver stack which utilizes
> VFIO passthrough as the interface to communicate with the kernel
> drivers then we can eventually talk about that.

That decision is not up to dmabuf - what VFIO subsystem requires to
accept a new UAPI is up to the VFIO maintainers.

DRM and VFIO have very different views on what is required to merge a
new uAPI.

Jason
