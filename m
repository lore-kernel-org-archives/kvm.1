Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3F529ACD7
	for <kvm@vger.kernel.org>; Wed, 21 Jan 2026 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010605; cv=none; b=FAfV9Kl24GNaQrLvYnMIp3H4zT+TEJdeN9ltZv/2j1i7xfS8l2amLdFa2yK9yXBKq8VoqWy5kNlr23E431JeHpmfaXjoSvrNNM3yaLB+TKOzHTAh3p+mkw38O/MjRFkwoOpZ2MrKmDcSBVeyFGjIhDEcAb9nTKYBr+medh+tzxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010605; c=relaxed/simple;
	bh=q7hXpke/3/yOS39pnZAAHMgYMjm6i7TC9CfciaL4A2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYdT5YIh7zRB9iyscz/uIotO7lURVTAdOiBXPpYM8u9UaAAFZ9JezPvGb/M8BtAFb423FT5hnTywNQJk21bff4/jhPk+0Bm6B5kQvXPukdip06c2vtdE2fTfESwnNj1mkHqh1ykLiyKqGHzlh+HwEbTy5bL88HxKSU8vFp70N8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UZIOstkP; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UZIOstkP"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c537a42b53so993359585a.0
        for <kvm@vger.kernel.org>; Wed, 21 Jan 2026 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769010601; x=1769615401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q7hXpke/3/yOS39pnZAAHMgYMjm6i7TC9CfciaL4A2Y=;
        b=UZIOstkPydJrsgD3IcwJy0K5b0HX/cogftTYVCT9yYnxEvRH6cXvIA3FGl2IdegZSR
         R20Aehqc9EEZjuT34Da9lgA5UsLPzmY1U+k1MeoihhCEQHnYi4aI/x+QB48Er6Hf3bIC
         1iGUXDtcfhHIS/NOdgW2mvk6t3sdX4yoQbjVZEaltQ3RGTfjl2Sx+mVjuwEtHaiWMRHH
         lrPdkfEH2kEZWLBzRyYi9iDhyjlHsSTX2xv84HaDfSUANyTQmMD8oH+rRYQiJKr+BtzF
         0DdPx9B7WR23DhSJGLwtsVwkf3oCFY+2WxGWG/DRLQIvjnF0eJhqMU4/EMzs/6pQm2Qi
         CMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010601; x=1769615401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7hXpke/3/yOS39pnZAAHMgYMjm6i7TC9CfciaL4A2Y=;
        b=sgyK6A7xBwYshEXtnXjPf+h9I+FmlKfz4z0Q0u7phWZBvQHBLhPQOv97QIVpmJmuQt
         KNPHeCUhFxl0NYrp8esyu6+PlCG8LkdwsU03S6Z8ytcvRAOT/YnU5/vItnOgm7N9m0NT
         vTCYngijvTrV1fBSBLWbKuJBm1uTGrDuF1sXkiLUACgzykxk2afMO9tW/5UZOUjlZotF
         xyLgwSm86jo4P3rnlEHke5v2/DjaPN2csFXvpIb3KC2ExJUazTCKZXrMCHX9Z4GuSV6j
         ELIrq8BH6cqIcxUBl22puCA/mE8Eh8di92CnayQd8d56sCjDi7ETsTfj2GEukSmqIDK9
         m+Dw==
X-Forwarded-Encrypted: i=1; AJvYcCV3M1xIlrX6eXzslrHF8hEFmwUPQSB8BvOu618QFMJ1iqbG3kOWtuk6jHu75bZaAs/LGbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEUm8Rh7sO/nH+uLasmMSBt5UtDuRSVot6sbxuiPWW27zCfku/
	lZRu04PmP0C+Kq3Wnq6bBrBdX4jh5cCi/57pLbtQNiKKGsAKsL3tqvXuLPcAaNcxZl4=
X-Gm-Gg: AZuq6aLm4VXaqkGV1pudt/65+Pk/P1GboppotjoOrloHMi1D8BbFOnAXeYaD8isWdsd
	yCiw5X6gp6dwmpFNXYyt5cBvqWdj415oWU+Y7EdgZ1ThjYWS1do7k+rSAy237LdzCKbgqrrr1Wm
	wxe5G4qEmo6cc5xCKDEZBwqBmLZ3RC5aqf3jXqaIm6ZdBYVggJNjpjqBo0pgyYucw0EKUGl+DOJ
	42E4X8tS6sSizh4TEW7ifYQfFOalS8Twiqh+KSwD968kW9mgmI/VbeKTtAMfZO2nvsVL2O0HEU8
	1mytxyB5XiE62olf2ZTUmzR2a8MLcGd1G6+3gpe2+htKI3n0zoTRDX0g1pu8f73uOTyf9BnWHTc
	CsKKiAiNbhA1H5jGa44Pz90Vyg4/yEmlK0wkHjxod2+mbW79P7503oH1nx57nuWy330LYVjfMPm
	hq1VwwPHJ7U8nV7DYmS0mlgR9pNRVqHJ4/QCMgM/5O0tk/RSZt6FcqLy4tL9bjEuIhPc2Id+vI5
	x5nnQ==
X-Received: by 2002:a05:620a:298a:b0:8b2:7290:27da with SMTP id af79cd13be357-8c6a68ec70emr2561552085a.12.1769010601362;
        Wed, 21 Jan 2026 07:50:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6a9d97sm127467116d6.34.2026.01.21.07.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:50:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viaT2-00000006Emy-0KMB;
	Wed, 21 Jan 2026 11:50:00 -0400
Date: Wed, 21 Jan 2026 11:50:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v4 8/8] vfio: Validate dma-buf revocation semantics
Message-ID: <20260121155000.GE961572@ziepe.ca>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
 <20260121134712.GZ961572@ziepe.ca>
 <aXDhJ89Yru577jeY@google.com>
 <20260121142528.GC13201@unreal>
 <aXDnAVzTuCSZHxgF@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXDnAVzTuCSZHxgF@google.com>

On Wed, Jan 21, 2026 at 02:47:29PM +0000, Pranjal Shrivastava wrote:
> But at the same time, I'd like to discuss if we should think about
> changing the dmabuf core, NULL op == success feels like relying on a bug

Agree, IMHO, it is surprising and counter intuitive in the kernel that
a NULL op means the feature is supported and default to success.

Jason
