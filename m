Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9E819004A
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779543000; cv=none; b=m4nh7NLlqUNbXw5AkT3lIMA+pPp7n+ONzxYvjOz1DOsGAhTQt4Ka8v2AO3zqG62ayrOyRgA84TWX5i5m2XQPeUWqN7oe0h0cQCfw7U2e2469KqF25XAl4xU4A/eTManS2aZgEfrEvESTSjnyuPfn2jiwqZyAQ4ppOMvMVMP2d7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779543000; c=relaxed/simple;
	bh=RgYvcoPplhdqI9CdTTZ6C7ti/+tt7zM/oaJIqfNBkWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM9YXazyOIYIKtPp0N5NHqc3dY33qa9ANPaCf5srpdHpO6jRHvtfvZ7k9OAm7obGf5sI6fq0C6KB+oEPF9xe14Fu0CfrjsfsV/nUGTDq9uVndLnygTmysknvj+sugeqKA1uXriQvOlCdTUMP9aNpqh8BSYrBTe+CG7+9g97BRgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=D7+anw4q; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D7+anw4q"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8cbe69b122bso39445156d6.2
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779542998; x=1780147798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mynkKK2hhJL7CehQlWlPJPsBrNct9+41+jY7GnTD+Ds=;
        b=D7+anw4qINDaierLtHXM7V7LKYD9V3OexFvPuyf8IZbqVvWuFqNgY+qLKvirOgoFL2
         X436hL6XLE1aJZ2baQeRVfcfsahxsvcCuJccdg8WXNSXE7ICPMptjDdmlkERKQup39cG
         C8NWGsqidqQgQZy+fyqEBF38seeiC25lYfvQUuSxVzL/xEQWszjHAiyAcA8NSZBqDFn0
         Qmck1tlSb6y1WrtMSV/LicXzSppDC6fe7vJ98YNYnb3cTmRUUniVZRWzErKSQkmAvuzs
         eHtX6oKIlG/ricMpDGjaBru8CkdK8wwKLgFDvq5XJA1b4p1UghevhrWCIrUsJC7fumff
         xV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779542998; x=1780147798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mynkKK2hhJL7CehQlWlPJPsBrNct9+41+jY7GnTD+Ds=;
        b=IcC7aR6Qv+6ujaCPbAQjJK51ljcap76ZQFS+qiyGyII5lQRCP0nTMjDDn4O7/D2+vH
         9+E0SnFp+OobuwSnpG2V6k1USEeKxLe8nSlr1Fbv32icZU7Nsx9O8oTVhyD4gL2juQHp
         h9E9/Famj3ExthFsJBEjQCAqpCFQPpQWP380iuU3kZo5UQ0UH3oaJGAwQdTEV4vNegDD
         SmkAvB8Ag8oUEpOaM7ReEvFdicDIQkhrvFL4XirD2givAMzjsIK/1J+ANe0QV21iJNX7
         k+BBLixs3GYgXY7x5G/9w6HKgj2G1O1JzmACRjv7dfCCIPyfyDCPAGWDE9vpkLDV4FGh
         n54Q==
X-Forwarded-Encrypted: i=1; AFNElJ8eeKL9xtNgjiu6frXvI2aVKgMG9pGahLGO1WVTxvmwp3yQeY785W4n0eASrkC4+rGhdGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxapSf3rSCQXTaLlOv/jmC6l/ufMNfHfHLGPBvOsN7kp5umbIt9
	XULtwYUg/R68yws8XdrVzly5rD4tpvFf6Gfsag+Az+Wtq6QhgxOPLezYt3/eSHfvQcQ=
X-Gm-Gg: Acq92OG6UC82/Sc+pM8bABps1PRT07/Xmhm6a84RbEShNq33wVOo7CNhr8jeA6lX6OW
	Z6twB+fHJDWR5Q8iPrGLhoLCbV2rfmPEK/s/q1oXDGzcpaOQEFCOcoFNlFJfBt5/f3W7RMcB87k
	/aFs+kB2P1s9iokknQdlqF9vr0zPm7Gau0xdFoBLEF8mrIqnmMpoJpQi5Czmu5ZjArUS8VVq3rL
	C2W97b9xFAe0eFtH02O4j6/Z4WauSW1hHeTOJa8s6uWepE5NdbV71GLX5XFs2+icFUy+TKn3PRi
	J/Mq/4DzYcf0B5sheXd87alpo0czE8+vtWP23XsgZg7WCsRfgPN1TA28YCqhnrOPvmynUADvCOY
	HPGMPNZbP7a28WFYvixEvSnl0I2cxJsMxTQJd4epePX5Ghf2egMEviAjlwjKZAtaVcpmpUYPWR3
	7Y0+etwp2M4yk527NTm84zL1JFKNupRU/HiHAMwxCsfFIyv1AZ1x5jiIZj40djmj4KzYstWT2oz
	S2QUg==
X-Received: by 2002:a05:6214:1c43:b0:8b5:84:aa1b with SMTP id 6a1803df08f44-8cc7b50024dmr122990516d6.9.1779542998086;
        Sat, 23 May 2026 06:29:58 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80deae74sm46895946d6.11.2026.05.23.06.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 06:29:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wQmQO-00000006HXM-46jw;
	Sat, 23 May 2026 10:29:56 -0300
Date: Sat, 23 May 2026 10:29:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260523132956.GG7702@ziepe.ca>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-3-skhawaja@google.com>
 <afUe71D8JfgmA0BG@google.com>
 <agr9ggdY3GYltteV@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agr9ggdY3GYltteV@google.com>

On Mon, May 18, 2026 at 11:52:34AM +0000, Pranjal Shrivastava wrote:
> On Fri, May 01, 2026 at 09:45:19PM +0000, David Matlack wrote:
> 
> [...]
> 
> > > +
> > > +/**
> > > + * struct iommu_hdr_ser - Common header for all serialized IOMMU objects
> > > + * @ref_count: Reference count for the object
> > > + * @deleted: Flag indicating if the object is deleted
> > > + * @incoming: Flag indicating if the object was preserved in previous kernel
> > > + */
> > > +struct iommu_hdr_ser {
> > > +	u32 ref_count;
> > > +	u32 deleted:1;
> > > +	u32 incoming:1;
> > 
> > Are C bitfields safe to use in Live Update ABI?
> > 
> 
> AFAIU, they aren't. The C standard does not dictate how bitfields are
> packed into their underlying types (e.g., whether they are packed MSB to
> LSB or vice-versa), making them highly dependent on the compiler and arch
> endianness.

Bitfield are defined in the SYSV UNIX ELF ABIs, they are stable for
kexec, but variable across arches how they lay out in memory.

Jason
