Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565043F86FC
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105166; cv=none; b=slEdpGnUXVQGDKvwlcBCcLVcriq5yx7bugEPbjeuad6s5G+y1wKZvMD0puwIceQK9DBUYinnIXPAgZ1fBXM8iTWeQoC/K/9I9gcg/PiOubj+X70woOxmyg1vNQCr41NFY3wgbfg9oamKFgiLLFvip1/E4h0TpRbbXLy41FEthPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105166; c=relaxed/simple;
	bh=TSOB6Vbocoq6beDn4FEEEYUinkclZ6btSniPfWEeNtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DH+Zk+r3IMrOyqMUySCAbH8csu5eHAYpk6JlhOY4vMJwyTBi7bEp5qjmV+IhBBDhE47K/u1bWBLL4OfH4tCkC/Yy49LfNVOMk3dmVupYZJlUeFQrNhuHUHSKvj8X07v3OZbZ09nh/lthzLnRJFWRBEEShsdb31XNFnhWFUAxS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mexQEhp5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mexQEhp5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso525ad.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 04:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779105165; x=1779709965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yLlmjF/IblV5lnEQi8qY+GyBL0qWeQ1d8R8yUsdmKQ=;
        b=mexQEhp5zJyVBJS1+G6zq+V7pCfuWuiIlEDyRWUqXcHkGaZGqjS2jTLXqe7z53/WA7
         JNAvkYdCLZg7Lk50mvQq6p+tzuTKzPNSp6RewVGHGoN6+dGWM0aQnSUF9R7+DJQ8J1jH
         4ibbJRmeJCmzYoT2Fw5sBjLp88xKILoVZYPQavA8h6NNItLYUaWa/6i3bwSfMbaPWey7
         m0WsTkdl4wefCV7331m8k9mZSmuzmO8V/BpJEZVCFLnEOU2yA8EXFyI6nXfMPJ0n/BlH
         r12oKzeQGcFeJmKayY+4qEE4U9bpwOyrs4m1hq1Wjfx2qc46jiuljl1Hfi2MG4hUReVz
         mF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779105165; x=1779709965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yLlmjF/IblV5lnEQi8qY+GyBL0qWeQ1d8R8yUsdmKQ=;
        b=WZ+rAgW3CX1VU+KZDhZyUD4ywsM77U6BunssqsstQA48WDe2/xgn4t/yB+siMpQqsG
         Qfq6ro0V6v5SdnrRiz8w5WB1mRg+ktNikVdC5WMM+uaEtpXchtOIHlEjVc94voM65ktm
         DPDn+x5WonLlIA8NJuTrQw1uEOkDAwJz2WIif1keLQrDo8m/1mwuZJxp2CFIgLdS6RbK
         tJVDDAuG99P4wKM7nKbvm8ypzt4obfHDOmHwoylzVMAH1zdoTz/PeA1jYcBFO7ALK5cV
         BUNN5F4VvrCl7I7LS/6Eac1x6uTJavnyNXOKvYzxPAWxUZf05cTNbF7MKUR7NGVOjpj8
         RYBA==
X-Forwarded-Encrypted: i=1; AFNElJ/6DfdAaPqv8ZY3ndjYd3jcF5Xwql8AvuQuN72wuJBQw3bNBXhrK1/H1B2g69kLZtfZM3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbGL8/Gx8DVb/3BMDntCxlIIsom1zzEjeEt9GjD9SL49CDVI4f
	KEiGnviIpoOFhFrWQv6T9ixPm/kP+TWzyOM8f7/+xYw1+waOkurYYhDtVAloNT2yNA==
X-Gm-Gg: Acq92OEUuLMC2lyEFbTcM2radHleTmVL82lyzlajAujUi6jRBNXz/xxzkEPTfGwbLnz
	XgnjKjdYcaPPKOcuuv14cvvQwsT8cvehMG1+m9th3t5M82JB78CAXQgKJ3bEWnYxqX0X/gxxJBH
	NoWTqfIOMvLTgVgGvcESmqPyjpJx+eoba0C71MXYNyollr1idL/ifXUxUybcRkl4mchwJR4/csj
	ZVnMgzjDS+QhOHTXVhCWEFr8+50/WldVVHHv0VBHcAiV224DOcBgy6mzwhrSnNsrbwykXj00fjB
	Er3qybNxsVRNVMOAUPFrwWmOU+lwbiakvrcZ/nnxjAkQW7SuuNAHyszzTp0S+kwaQGT1izIruPj
	NdUavscrUcR+4z34h7sjUnpWF/3EA3PwYClsXLyv38BABVNrgdmQIjhftbmrBPT5ssrqEfpfKqQ
	EbzrH35LKV/VPqNhIL7SWMNUyRK31b2eBmjwSG9xbgaPYqw7rEOYTcZiLn69h/L0wgrwdc
X-Received: by 2002:a17:903:1b67:b0:2bd:6dad:7cca with SMTP id d9443c01a7336-2bdb0416740mr2770155ad.22.1779105163837;
        Mon, 18 May 2026 04:52:43 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5ceb3sm14293391b3a.34.2026.05.18.04.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:52:43 -0700 (PDT)
Date: Mon, 18 May 2026 11:52:34 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 02/16] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <agr9ggdY3GYltteV@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-3-skhawaja@google.com>
 <afUe71D8JfgmA0BG@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afUe71D8JfgmA0BG@google.com>

On Fri, May 01, 2026 at 09:45:19PM +0000, David Matlack wrote:

[...]

> > +
> > +/**
> > + * struct iommu_hdr_ser - Common header for all serialized IOMMU objects
> > + * @ref_count: Reference count for the object
> > + * @deleted: Flag indicating if the object is deleted
> > + * @incoming: Flag indicating if the object was preserved in previous kernel
> > + */
> > +struct iommu_hdr_ser {
> > +	u32 ref_count;
> > +	u32 deleted:1;
> > +	u32 incoming:1;
> 
> Are C bitfields safe to use in Live Update ABI?
> 

AFAIU, they aren't. The C standard does not dictate how bitfields are
packed into their underlying types (e.g., whether they are packed MSB to
LSB or vice-versa), making them highly dependent on the compiler and arch
endianness.

I agree that we cannot rely on bitfields. Let's convert this to something
like u32 flags; field and define explicit bitmasks.

> > +} __packed;
> 
> > +/**
> > + * struct iommu_flb_obj - FLB object allocated in current kernel pointing to
> > + *			  preserved state in FLB
> > + * @lock: Mutex protecting the object
> > + * @ser: Pointer to the serialized state in FLB
> > + * @curr_iommu_array: Pointer to the current array of IOMMU instances
> > + * @curr_domain_array: Pointer to the current array of domains
> > + * @curr_device_array: Pointer to the current array of devices
> > + */
> > +struct iommu_flb_obj {
> > +	/* @lock: Protects the serialized objects during concurrent preservation */
> > +	struct mutex lock;
> > +	struct iommu_flb_ser *ser;
> > +
> > +	struct iommu_hw_array_ser *curr_iommu_array;
> > +	struct iommu_domain_array_ser *curr_domain_array;
> > +	struct iommu_device_array_ser *curr_device_array;
> > +} __packed;
> 
> This struct is not ABI so it should not be __packed nor defined in this
> file. I haven't read the whole series yet but this definition can
> probably go in drivers/iommu/liveupdate.c.

+1. 

Thanks,
Praan
