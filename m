Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792765596;
	b=GT30DQOLLWHELTtBxM6RUP9FnuMKpNoAHaU+yHsZCkvv0gMc4JTwLrBEzcivKffontwa
	 lfS92t3y4I7r4K6phZPzKBTajp4nkXGcZrCVB+kPXlvp9jbMldv23wfaZ6awUOIlk8qf+
	 68r2wNaFaqhA1R2iYRUmMcWUZUFbPa5oVe8BkKePZADqEpp7tU8zS7+GQL7SIc35QMCnR
	 F+0Oy+51S0JpN9CcK88PWqlhqGish4BgNZVtnSrJsfIhnUsZZ4YyH48PGPFLdzTEgclmH
	 eu8FExGVwXGlgl+Y+X4Fo3cL7ODXZrJBs6iEWwcrYY2PMALlmeY7lY4xZ+xIa9Iy+9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=0RgIg1l+3ifUtXqxbecqEIvcyWwa/dmFWxjX5pMBv2k=;
	b=I9bXMWhx5tTdVsV6xLwCTsjsxSDTMiXKcBam/AaHKfJZmEcfZNushFJEloO2OeI231BF
	 W1h8aPjCwwgN1bbNUsb4wrgf892U+TxSSAsLGudojJB1uK+UdQgsHofjpVSt8nODI2jg7
	 8l5y8ADDgpyEsWDyC3EmwUzYRQMn0tjezoLImJNC+R/l31O4xZnB+L1VL7iOZGNEvZoUi
	 nfb8DCwYQ0yNkgB0YGYyYJplFLpQM6AY+h29zbs+xs4co8GUxdVbXa1e7wn67hFSo0tz5
	 MRNNoieRG1pdQPhHs7Vv5ScWZ/eEd+iyVH4S5X8LuLMh4Tneiy526PLZyD7P4+40Xjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=DuYf6d6E;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B348606A320
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 14:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B348606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=DuYf6d6E
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-537548b811aso1373211cf.3
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792765595; x=1793370395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0RgIg1l+3ifUtXqxbecqEIvcyWwa/dmFWxjX5pMBv2k=;
        b=DuYf6d6Eamd3Mim9JzP6lyLqHMZQ7cyKJdqyD3vzB6Sr2u0uVSkWpIdZeTI1JCnN61
         NIFACP66viSHxdE7SDl5Z0vkYsbly/8y1CfaZRItrer83OcRPXUOgkf7EFlW4VGlKxdh
         Ibu8s0eq8atFnKpxTif1E8wcf/K+m39TnPCWSxdLLek+ly/BYkiswbugga0oEPTHxpsq
         0aLlYBRgbYl8s/ZSMNb9ZITEEZ494ZrhiPsfXxG6KKufF1DcVU0B+j0htKw9QXGscyHG
         1HHHpGtDXP5Ie9+0fnY1zPNtuSAYT2zAG1Js2cHKYqmmzY+Pz52DZZlyK/Tuivj1tXdV
         b3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792765595; x=1793370395;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0RgIg1l+3ifUtXqxbecqEIvcyWwa/dmFWxjX5pMBv2k=;
        b=pTyNnXU/nKLVRs99wasVE94ZqZyVB2ogW5eeJ3ldquSSNBXOGjPt4aRFuDbgbY+tgL
         Ic2Td8loLk8fsOgMq4+OxmRZzPC+y5CXqu9u5JXvEQ6/rbS2Npt18o8j/9ye5ipP3ZqO
         IwzpHGvuyTUc/yC1aN8pHDjV1b1Tu19shbpiuF62+5K/HiloJP3F/ouOAaSQ2XF/9IAd
         FE+/dvutPYFa2+cRPM0lQ0gembe8UYO7V0Ztth42e/GpJk6L5F6KVI9Rwy1uM6cCHvxB
         vjDULxuppgKh9zlhrkqoPMOnyY9fAmKpjvHFr9Ta2q9pLRA1yGtziD/C+DZmJ1F72V0Z
         3bRw==
X-Forwarded-Encrypted: i=1; AKwUvBwqN6fsa+Y4KvEq2b41MkB9m72R5rPriw1ZVFOtvNm/+RvjW1mwXphuXs1SxJc2+iSMS54=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/BaKxQLN8ozmac3xTH2+Yfg55EvFkYwH5cooS15BQd5X/N+jo
	9i2AQ77OixB+cpzcTBC4skrcu5XJ6dFDT3Wq2MwDGdKPWvEJn4Cn0eiF+H314/GFFSw=
X-Gm-Gg: AYBFou2z8Mm2kKcMffjsfMkgzXwu0YL1gix5+3mo3WGp5TnWtDlPjyT1VswyaUvlGSo
	o5/l3t9a7lHgLp+9KkFtAdOiDW3rlIkPaQsG2K16DsdFE9EiqI4fb3nrQ03Ete1zVShIN82WHhT
	HByUaHfdNO5m/rvuNDwU7G384q1fguXGbbPQ5mgkRZC95SEU7htp2VaGP9225BWjpAgFaYx6oMB
	KTe3gA3L2hG7kSs3w0ku27lW+dyp2rTTFHE7Y+D7MwryM8OQspSm57vEcLhDwzmNF3LC9fSTlug
	FBIpyd1ZOHXz/GTomDB94nnnJti20nJ/HnmFyBFfVRQ/jF2kZkFg3UiJiVUXITt0L9vOEKgj0G3
	2gNpQthWXzcM3WQAytPYI8tmB0PnjFwLAgezphq+Eg+Hxf0v+KBoEmwpAM9Nh4hO1Vv0RHTDzsl
	v4HdjP5sj6U7jjIlLF1+AFCQslBrMwiDUba9tG8sNvxtKPWxVfkKNHFUyH5R16gQGXZXdkVrKDu
	01ESxsgf7H0q834iMrSOYNrdyhqdK0kvQwaNQnz/l3KQVYL1rmDz0DaiN+Z072xhBNkXE19eKJ3
	5ss7BTgg6MNGwuc63FIk3/9SVbQDtcOfhzC0mg==
X-Received: by 2002:a05:622a:5b93:b0:535:a5fa:ee02 with SMTP id d75a77b69052e-536c2700643mr30249831cf.66.1792765594917;
        Fri, 23 Oct 2026 07:26:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536c18afef6sm17177241cf.27.2026.10.23.07.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:26:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKGE5-0000000GjLW-1mzI;
	Fri, 23 Oct 2026 11:26:33 -0300
Date: Fri, 23 Oct 2026 11:26:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org,
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com,
	drdeeglaze@gmail.com, James.Bottomley@hansenpartnership.com,
	aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com,
	pgonda@google.com, alistair.francis@wdc.com, ankita@nvidia.com,
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com,
	elena.reshetova@intel.com, dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 12/20] ctlv: Add device and operation dispatch
Message-ID: <20261023142633.GF3977851@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-13-jiri@resnulli.us>
 <20261021022505.6fe1b1bb@jic23-hlaptop>
 <20261022184313.GD3381610@ziepe.ca>
 <attZl_0TNMDLgi4U@FV6GYCPJ69>
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
In-Reply-To: <attZl_0TNMDLgi4U@FV6GYCPJ69>

On Fri, Oct 23, 2026 at 02:58:33PM +0200, Jiri Pirko wrote:
> >> Jason did some nice handling in the fwctl stuff for
> >> device alloc and hand over after device_initialize()
> >> (I've copied it into a few places recently :)
> >> 
> >> I'd like to see something similar here as it made
> >> it easier to follow lifetimes etc.
> >
> >This is really at the wrong layer.. Attestation subsystem is the lead
> >subsystem, it should be allocating the struct device memory and the
> >driver should see the typical
> >
> >  struct attestation_dev *adev;
> >
> >  adev = attestation_alloc()
> >  [..]
> >  attestation_register(adev)
> 
> Er, the driver would call attestation_create() which will be a wrapper
> of ctvl_create. The reason is inheritance chain and each parent being
> passed info to and doing its own init()

We really want it to look like the above so we get proper container_of
stuff.

struct driver_attestion_dev {
   struct attestaion_dev adev;
}

driver_adev = attestaion_alloc(..)

Don't want "create" to allocate the memory, it is upside down. The
fixed memory ctvl needs should be buried in the attestaion_Dev

struct attestation_dev {
   struct device dev;    // sysfs dev inside class attestation
   struct ctlv_XX ctlv;  // ctlv instance
   struct cdev cdev;

   const struct attestation_ops *ops;
}

That's the essential skeleton of what a subsystem should look like in
linux, ctvl shouldn't co-opt it, it should embed like cdev does.

Look at fwctl for reference

Jason
