Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5F433041
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213244; cv=none; b=dNUthMvrN6ClFPQylCFVRbYoJnvvg46gkhe1RNXrnrNXVN0BWeEdGOgmZ+YRSAQMcrKrXiDLLlYS1jnQpOB6dOENCxfJjIiuvbhUyih3BM333/4FU5hry3LRImzr6OhZPkZoEdmByYnls6edihQcdT8Xg0fpeY4O+nWbcRRLcNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213244; c=relaxed/simple;
	bh=qeHYNuBQJ85xO4pHC/1GrXrbttQdCZhEoDnW/IVqBNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRWFUkq7yPeYwCVXWbj2zeCOfyc6f9LlR1RUFbU3heRFsk+RQjV2icopRMBVARqrTpi5AxKO5juJwPVLKxaaM1OVvFBwSoCrLa7ZwtMjScWjxYbYGdz5excgOhE7s4CDU0mPyQxiTlhKWQkRMfttL6mLDng6dgWODg3KWz7NUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oDVxF7p3; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oDVxF7p3"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92ea24a2dbfso503538685a.0
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 07:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784213230; x=1784818030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qeHYNuBQJ85xO4pHC/1GrXrbttQdCZhEoDnW/IVqBNU=;
        b=oDVxF7p30emqLYl1Y/5PXRuiZ0gRznz7ZJa68Pzgax9eUTMYGaZE+24qyOFCvzy0LY
         wAsfOFXwomSYoSM/EfuR7jyMPzSn0Gcij0mhQ9rDCLBCKyiqOZUQzyqelLarSrmG6pUC
         OOu1/4SPuIHCI5Fz9azs+yN65kNOgPdvOotXUyZFwNk9MWBj1vwnP8Ede8laEQ8T8vgs
         kq89E/wthT28pRh/ph4hExErCjung7VxyXgrygjdH9iU1DwdcG3QPpXV3MKsybOQNJee
         zq2FXJxQJ7jC9OgPjo3v+uRuGyyc6WyZC/tXu+ptnmTPw3M/YkFUkKBilxGxtJrXXpZ/
         a2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784213230; x=1784818030;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qeHYNuBQJ85xO4pHC/1GrXrbttQdCZhEoDnW/IVqBNU=;
        b=UsgAznlksufLjiPoh3Xf3NVUNGEuqf0DjDhw9obtwxdyiY9lXSLz6Qe6yBfHWLSiPL
         nf0M9XfeSFKJ1cQ+0xjNAscCB8uDbKoj2Pc8NhzgS6/OqaqhKF47pGNdvpBw7k2InOsA
         ZA6RFWyQuIHRCJocT3RkQHIaZm1soa4BErag39EpzuldgzMt2a1p1lW5QqKtnqDK7xJk
         TcTcpkls6RbIEfYHrOyye2bF8oQK7s/Bb9kRRKDgG8PB1KoU21YuRpRe1gTyiVnOndci
         P/nPb0SinDs6l665t1HJeVmYNTYvRKBZnNJ/2Fb2XuW7kjKxsMmqJJOSyKXQxZWSPcmr
         ig6w==
X-Forwarded-Encrypted: i=1; AHgh+RqUg62Lm5J51QhZcSnuz0p3VXTXTxhiQd/ByLrlVBcL3HzLCfp47y+5KbACBowDqGoGWrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZLpE9in+wHtxBMNEYzYKVSnFSGpI1hXA7PT6e/iCB99Tmkb1
	CQSwBcBkMtGaPvdXl1BfNallWba0N1oVl5i4rhdbTQIlQx6aDl3doruAIeTZ9stUeQM=
X-Gm-Gg: AfdE7cnvxeVh33lfak75Nc/XQagim4f0l5FZtFxkAbWvGYqBsrTsTbDHrJd21YBZqj8
	E4asg/TSYC8RE0vLSIGpLlxemGqG/71Bz7IPAD5i4IibxoAhZ7smtc8ho8VFE4HrhFyJdcnQI8j
	+M889slCBOycyJAJkBvPMvostL7yhajqs9yq2xvqyoydz6O2gT46pA6SUasw56xlHCd7q+ECOA+
	Q48Lk6mxwgd5FGNLCLSZHrCkt9hoebOD9JXmIBz0k1hILunDm9MkvkP0/vhOEZpcC8N/L6k26J5
	B4YjsM6i7DDebuyTU4qsiYxriu7S0VTiUZ3280cLWno704BYgIYsg/1q0Iw5UhiMCVqrVt7P6XB
	GMMl/XJcWEi6lJ5ODVAjKhYq+o9hwQgmveTjORZYIphyLR38mMgJQ82Ndzp24i0Y60SzlHeM=
X-Received: by 2002:a05:620a:3952:b0:92e:ee51:e9d5 with SMTP id af79cd13be357-9309627ac1bmr854483285a.43.1784213229539;
        Thu, 16 Jul 2026 07:47:09 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930ada3a1c3sm36671085a.20.2026.07.16.07.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:47:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wkNMi-00000002Yhx-0bks;
	Thu, 16 Jul 2026 11:47:08 -0300
Date: Thu, 16 Jul 2026 11:47:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Leon Romanovsky <leon@kernel.org>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian Konig <christian.koenig@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v12 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260716144708.GD210048@ziepe.ca>
References: <20260715204008.3911275-1-zhipingz@meta.com>
 <7dd5c995-a23c-4d3a-9ba0-7fc77972339f@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dd5c995-a23c-4d3a-9ba0-7fc77972339f@huawei.com>

On Thu, Jul 16, 2026 at 09:07:35AM +0800, fengchengwen wrote:
> Because cross-Root-Port P2P traffic with ST does not affect the host, but
> merely the completer may experience some performance degradation because
> it lacks the TPH hint. In this case, I suggest adding restrictions in the
> uAPI.

I don't think this is complexity is worth doing for something that has
no functional impact.

There is no difference between supplying the TPH and not supplying it,
so may as well supply it.

Jason
