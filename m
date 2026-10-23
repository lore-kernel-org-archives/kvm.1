Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770135;
	b=lxyLSx9ugoP2gyWpAhuOkWKIs+5fDqEC/uxu5dt1xlatIjC9k+h1QURgAhgYnyV+iRHL
	 0HCYDkvYWHTVOj7djmmv84dd9Vq47xfSDOKSHba0EvdEcSfBVBicsqf5/gT44Wrr0S8eo
	 jX8at8hUElgH2BIjA4Fst+bQywKXB2u+9zMLMEXqHwCyx1/ZShTIZ+1hBBLHmE0eSFcEw
	 ZHQJKoHkLD8T///P81geAWfvLk5x7upKONmDrrWvRzQj1vYHn2Fu/7JiEZM9gsrafj3JG
	 4mme+0cqUCG1k8Bh+N8qrdl0KWAbyB3TKFqZWn0oLbHlYlOMA/BRlyNYHlzHEkPwc1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rug7Neq15IHiij489G0zvk8NhY0SVtgpPgzc6r/gkrk=;
	b=HmZoyWdyV2rLfky5Ajwy0uAL20YuoqlVA2SMMqjvOwGB5bhUrh2xPF/iDgMZlFZkVTmW
	 sC5UKqYJF/1GhTj9PO4exNf04TZVu3vj/mNE0/LhVrqpaAKkAHiTF/5DYGoQ+eUb4ucKY
	 35G0DS/Vj3fdwUFn0tEcQN0zQTjiFhfyd5lMcXdV+yx920Sw5pQMN5jsDgIhuz4ItojXV
	 iValzxtGI4F8jV8yMJEVa8btq7N1sLwa5bbARj3LtDfQv0aTUYkvrUse7oTWqeVmteA4G
	 RqVr53NdEnNeby87EF45GOUGBs2J58jaagaw95Px5KuQlzH9iJ9guIJGidgXQY3qb7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=c27WBFJ2;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC33606A325
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 15:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CC33606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=c27WBFJ2
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e635220b4so88129185a.1
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792770134; x=1793374934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rug7Neq15IHiij489G0zvk8NhY0SVtgpPgzc6r/gkrk=;
        b=c27WBFJ20LlEkXwtFWR0pToqFQOALwL+bcaaVuyVwXUk924Vl3bY2TE+HzwUkjjWpt
         QaaeAPi6z5Ti+PWEFO4B/P+zy2aL4YiNfo4wU22IWJR8UJl5UsOSPZsuUwdq+P5P5bI9
         72boUzrYkytCjS3Ko/P0xykJ3PbDwA2rQfd47sTgSJkaHkjkNaWVyqh7Xfj2zU9voNek
         oHWce6+kRLUM7XPX8O2BXEN48XjkeD/eVwT16b3bS4zufHv2bthZ5aNwPUaW3+/wB8mR
         3LSVs3lqw0vf+xIhH8LUjQVpYyx9cBXBWmBXwJ0sj/UDAKDRx/Nl2/3V8k+ZJ60Qkgg3
         R0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792770134; x=1793374934;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rug7Neq15IHiij489G0zvk8NhY0SVtgpPgzc6r/gkrk=;
        b=2SOk7FNZGkRxcIK2vmdIq50k2HG2h4SsmvW2/VZYu7BOGZZ961Vr4dVTRYyPXsupLF
         SMa1s1gOiYSFlsLi5Y/MTqVvPqJzQm9Ius7BxuV9FMNDkm4fa+dVEqlIK1AOYLghFqGQ
         ZYiSC35stQC2F1anJclVkdhriFZnWXfBFmzG+im93DEJ9DOq69GEWm46ah6+Z5zRoVn3
         y10FBGMk9faeCNymXCx/RDJmvgJz2snc5nyUyW1cb5LPBjjxLqv7kMkhOUk9uT2EQMma
         Te/GC4tUwYoDCcTSwQK0K2kqaTZ3QYqsSti94yPDtJL/DMMlqHO6DvKcRLzy0JjOMuJj
         JfdQ==
X-Forwarded-Encrypted: i=1; AKwUvBya5NCGL7h52s7PFVpQhMy9ME+XXiq37qHGOe4/QNJOmC1Ng5q23g4zn4Ny7ZOFf/RC4NY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKN7ycRk7wIYHEYzgac+iHtSWhsHqeWZ14Zezk2R3nplJu/jXfZ
	Qh0qVge/uZh/a1MtNRfgxxJjPAVB5cHoTGjCwYri+I7X+ow0hN70kMcDcO5evv8Inps=
X-Gm-Gg: AYBFou11R9V4wfHl0wnPX1SwyxMeXDbAKI34FI0k3HHWqGI8ejTEp3OxOy0asjAnAxV
	YbCoOl7Syo1BOYhzO60NS+ylwrtj0CESSQnPJI33GI260ogcXJncDMjISYY9dCrruxbWSHopQ4n
	hmu/A+Hp9WgvFoohPs3EEFcBRFYsAxcfcWclWmXnW73qQj3TXiAMjoSt9KQLbqqiVeKD0KHOCmp
	PxBAsEicEJml6ZmYSSoPJ88/rmxJvsNDeVASvC93LfYHl/DQ0SJx0LTKInMu60cGPqthIbfdo3s
	DjpeXuOYSY9KDmF6Hd3iX3rBwOOONyDjkewLryjCBiOkUlA4WzVutgZ1zbgxCaGRIXZw50HwbrD
	8FuQLq8iphOin8bVsSn5/2o5H3ONOLhq+al1LG6z/V5YkELOka+JIKp59YtxwPYssv+IHapUdDw
	btnY22G/Dn2KuHeu1ZRx/fxbTsfz7gfAXcPNqZRwMnfX+b67HMNXYEESs3Ya5m48fJENcRhTEY6
	oEGHamp87ERr8k3x+zABgryAFFcxo8ytkrdOtIUpnfJOuDmb0L55nH6sXzqJ8uQsPpu2/iWIk7/
	f6UXWzEuA/UkotxNZ63pxlLAh/LNDeumNDQCnA==
X-Received: by 2002:a05:620a:1a11:b0:93e:5ef8:c794 with SMTP id af79cd13be357-93f6f9648bbmr497429285a.38.1792770134059;
        Fri, 23 Oct 2026 08:42:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047b362a5sm45129985a.33.2026.10.23.08.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:42:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKHPI-0000000Gn79-3Zzp;
	Fri, 23 Oct 2026 12:42:12 -0300
Date: Fri, 23 Oct 2026 12:42:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org,
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com,
	drdeeglaze@gmail.com, James.Bottomley@hansenpartnership.com,
	aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com,
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com,
	ankita@nvidia.com, suzuki.poulose@arm.com, kas@kernel.org,
	rick.p.edgecombe@intel.com, elena.reshetova@intel.com,
	dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 00/20] attestation: Add a common subsystem and TDX
 support
Message-ID: <20261023154212.GJ3977851@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <yq5a7bjajaco.fsf@kernel.org>
 <atooh7uO2RauUTfY@FV6GYCPJ69>
 <yq5av76sj10a.fsf@kernel.org>
 <20261023142038.GE3977851@ziepe.ca>
 <yq5ase1wiggs.fsf@kernel.org>
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
In-Reply-To: <yq5ase1wiggs.fsf@kernel.org>

On Fri, Oct 23, 2026 at 08:58:35PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Fri, Oct 23, 2026 at 01:34:53PM +0530, Aneesh Kumar K.V wrote:
> >
> >> CCA currently takes the device identity index during pdev_create. I am
> >> investigating how to retrieve the certificate chains for all slots. For
> >> now, I have implemented the sequence below.
> >
> > Yeah, I think the consensus at LPC was this may be a gap in CCA.
> 
> I checked with Alexey, and if I understand him correctly, TIO also needs
> to establish eight separate connections to retrieve the certificate
> chains.

Lovely!

> For now, I am trying Jiri's suggestion: use Rust SPDM to fetch the
> certificate chain and return it via evidence-get. evidence-accept then
> does pdev-create with the specified slot number and compares the
> evidence data returned by the RMM with the value cached by Rust SPDM. If
> they match, it uses the cached value for set_pub_key. This seems to be
> working. (FVP only supports slot 0, hence only one blob-instance)

That's a pretty good idea, and works for every arch! Maybe that is
the best long term direction.

IDK about all this "Caching" stuff, I'm not sure I love the name
"Cache" to refer to the security important reference certificate
bundles. It should have a stronger name to reflect how critical it is
in the entire security design of SPDM. You select the certificates
once and everything following must match that or something bad has
happened. It is effectively a key part of the channel binding.

But yes, RMM is sort of backwards here, the slot number should come
with information about the certificates, but I think this is fine to
have RMM fetch them again and then we just confirm everything matches
the kernel's target. If we don't do a get prior to connecting then the
kernel would just adopt the RMM's result as the target certificate
chain for the slot?

It certainly seems like it should be all sketched out and the uAPI
confirmed. Given the state of things I don't see an issue with a slot
0 only initial configuration (ie EOPNOTSUPP the certificate gets) so
long as the long term resolution is clear.

Which is an interesting question for Jiri on CTLV, one of the things
we have in RDMA is runtime schema pruning. Based on runtime device
capabilities parts of the schema can be disabled. Can we get there
with CTLV too? Then introspection could return if the underlying
implementation supports some of this stuff..

Jason
