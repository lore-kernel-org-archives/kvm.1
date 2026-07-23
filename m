Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A76C3E8351
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847533; cv=none; b=tYWVNTy2XfM4CZLTa1B+iSPCTyvuqwUzzw2GOL+0e3dlRM9lnQgLsB/4Spxy9oFOKTMifHvsvOnxcX6ExZLkuW91VLZdOVj49gipHTYTxRCj8Ivzu8ryyNQHMmsPl5xgtI6Fo3jKsMTyYXvpq5dOyElCptxL+bewDpi3x0VO7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847533; c=relaxed/simple;
	bh=yVe6z1RcUZaY3Sf56/QfYhtCxfjWa8zL2up9uH95h30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psWlgRDNLVsef6EpMZs0ppUAbHvfQDzXzJRKH6UjFXXdiMsxW5W5I28PDzGDSwb3RuU3e0R1wccGUYBLSYw+znQfHhBAGdexn3VJ5CQevwam/PzVXYkrsnHpUTQptxL823HGUnIrYNkAWlK7qDn/t/RV8ON8t/CrxE7H3zNayyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mn4LlFnP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mn4LlFnP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ccdf36f63dso4895ad.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 15:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784847531; x=1785452331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zj8yGGu0ZvQspv+dm8spEGL6AmJp5gd8JQ+4SasQ24M=;
        b=mn4LlFnPZHnhq6bgD26muuFAuTY3LEmaHjdmqYiV/FOtSRLYtcs/IryJ8ya5My0fHX
         DjwNelgeHWvdrC4iZSQvHMhwQjSOspc0MhoZ9uuia8dU3h9HozAIlHkScfQCljztzp39
         KoX0g7l/df5N/BMI/6WjwsVmI6c18nDM+N7Iwk/rHFXKoiZh5nVm3XIRg1WJOfAUQ+4V
         xfEGYOfo/wqmxDgJDXTWS//xj+3YdcnRqjLm77AgBw+utfliuI1fUBW0BMPcupzfKG2W
         O+Z3gUNErYx3rWxI16VN/F2xsD7i69tFm/Uwk2ERnWPHBYKHsMSuTFXDUtkkb9ja0KJr
         bMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784847531; x=1785452331;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zj8yGGu0ZvQspv+dm8spEGL6AmJp5gd8JQ+4SasQ24M=;
        b=cuCdZ9M216sv64xze7KnlbEpPZXyQQpVjGiTj0xTrDPapT17G+88wbi7Y5J+u/BTUL
         bbgL70WGbYclgH5+9/KjWYqzz1RieF51WpgCyhpBsFSJ3WzoqQIC3I0DNuJ18WEM2RJP
         OkTVh2njCc82ZzMJMJma/JLzAmjtxAmU0gRdE/s8SvbxSUh5DdMtV3Eu4s6jF6CMe/uO
         jHyThAL06xwKc038rwPpKVwW9YLtHrSswpJ3yZokRsBQw/OLQ/xCrmQNodSOPnQBuziv
         Cxy2O1FROyKrLLSH4LUVMVJp17aUiSNFHSwNM0HxLKS562vmUyJykDYt5rT/d1V0pwvQ
         prYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpr+cuKcN2Mbs6TdVUb0Z93HE90MboKFF2aSD9wmv5gQ+if4yR3hyPpiUaDeWXKlPHyrGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwri7K5A+SjezJD2hI1y+VSsC77wXrI5XJXvfBVb3c94R5pnDK
	gL7SZKYzVhOvtnMIOst3TO64KL/+Kn7cfgb/+E89hBBu9IcNYPY+EO9tH2L7ke00jA==
X-Gm-Gg: AR+sD12f5+MmF2Ck42CM6i0FU+h4gMwjBiA+JGd+IllbbCjyCRmZX8M8tRt9kkSxgzJ
	eFqMqeQjARyJwEAGxjaFbva7HUcxkymB1MXu5EJEiQhd4QSMnA2VSdu+KvgLrDtcAwi+mD4Whe8
	eCuqcaXxo82Vp+HB8k5wC1rbVEB/+erQZjY4RqbQx25AxbqPK6hJ0qE329fDf+59O0a/DHWKHOv
	3xooVPJvvHR6mPTvspIv4SeWzrQfKkArtMGaRFRSeQTBV4CfJjOYra5COyBn6Cc7EKG+/7jGjjd
	WBz0NC4CwgVlPge0LMuNLY4+fZ2vvVbplaXAXTFFrQeBmCHhAuaHLXWQKcmLZ5nU2oFwUdw+FDh
	9ZifjE/XV0QRqYsHyY+KsolqBhw7PqnlukduHie5Ip3UdOFwF4yJBMzQsFPT/fHhJxUkB03vYGz
	Odtm97FYXwvaCs1La16ROqoDpo3Zn5Sl+k3a739V0=
X-Received: by 2002:a17:902:d4c6:b0:2c9:a222:47e0 with SMTP id d9443c01a7336-2cfc049d8efmr1917685ad.20.1784847530903;
        Thu, 23 Jul 2026 15:58:50 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17236924sm3686474b3a.7.2026.07.23.15.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 15:58:50 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:58:45 -0700
From: Vipin Sharma <vipinsh@google.com>
To: alex@shazbot.org, rppt@kernel.org, pasha.tatashin@soleen.com, 
	pratyush@kernel.org
Cc: ajayachandra@nvidia.com, amastro@fb.com, ankita@nvidia.com, 
	apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, 
	corbet@lwn.net, dmatlack@google.com, graf@amazon.com, 
	jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, 
	julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, leon@kernel.org, 
	leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, michal.winiarski@intel.com, 
	parav@nvidia.com, praan@google.com, rananta@google.com, rientjes@google.com, 
	rodrigo.vivi@intel.com, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 00/20] vfio/pci: Base Live Update support for VFIO
Message-ID: <20260723215749.GC260824.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>

On Tue, Jul 14, 2026 at 08:14:45AM -0700, Vipin Sharma wrote:
> Hello,
> 
> This series can be found on Github:
> 
>   https://github.com/shvipin/linux vfio/liveupdate/v5
> 
> This series provides the base support to enable Live Update feature for
> VFIO PCI devices using the Live Update Orchestrator (LUO) and Kexec
> Handover (KHO).
> 

Hi Alex, Pasha, Mike, and Pratyush,

I'd like to discuss which maintainer tree should take the VFIO Live
Update series.

For context on related efforts:

  - PCI Live Update is targeting the Live Update tree (maintained by
    Pasha, Mike, and Pratyush, with David Matlack maintaining the
    PCI-specific code).
    https://lore.kernel.org/linux-pci/20260710212616.1351130-2-dmatlack@google.com/

  - IOMMU Live Update is planned to go through the IOMMU tree.
    https://lore.kernel.org/linux-iommu/20260614233728.2212104-3-skhawaja@google.com/

Given these different approaches, what is your preference for routing
the VFIO Live Update code?

Thanks
Vipin Sharma

