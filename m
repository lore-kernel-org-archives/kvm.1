Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694385;
	b=U3cbN3rDDIKPau7mC/S0vSDi7R55YRPfq2Ej2aXS9Nc+bTLtq9529kGhiS5UVLeApAR8
	 QQ0wr0Gn/1IUS+iJDYr6psKP+NrOl83KflFLbSi1/vpiRzBS2Q9CHEjIeE8mN9DG2Fg+u
	 H2spDyXfw7tpCs78gni62XELXsf2G1rETN7eNjl6Z3TzrqOYzS64c5cou/yweuUtVpISE
	 i9cYfiJrmwgxVm53YdqxAuZttZ4QDau/TLN4hS8a7nBm9X5CNQMsXVDu1c+ebe06W2KOY
	 Es4pqK414e3qALSUelkqJ4VuBrIeo5LfIJDSXm0A7p9MHlDMFOcnVU9uC7YA6kWYJHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=6OyEIFFGQJwoM3H+g7NU0Vj1plI2Oe4JZLflWIJCYwE=;
	b=u9IxmnXUZlDw26if3ZM2rZAlZN1ptmdDCsO//3rnnlf8hxctZLLJbC0NDjw0Kx6vSH5Y
	 uUMOgBDip3aMMknbRyywBSnC+egyxW6VmBQTVtnpftN/r4AhToYWQLVaeIJO+ALqOw0G+
	 Lr22s71g0RniR/g1QcUrTh/uLhp7+2vZH0rnElweDXMOgBO3hmjw/UyxH19d6oBb/gtc0
	 avHvFIImfvHJtso7zUNMBfOcQ4sSU6rAd7wGkZs2cfFXhQ7z2h51B4QftYKql5Jy5Jinz
	 M9o/2lqg19I+c+i4Ne1IC203zrLcoTvhcjtX9yE04gId9zx3MbgZQuzHZdz4rcEYYwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=KHuMy0sZ;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E770606A329
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 18:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E770606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=KHuMy0sZ
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91c1f548f87so2605766d6.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 11:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792694383; x=1793299183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6OyEIFFGQJwoM3H+g7NU0Vj1plI2Oe4JZLflWIJCYwE=;
        b=KHuMy0sZD7ZOI2sSxUEZc78TXFyK8CaY79wWRvg5gbf1f2MF53i7eKzHp54VCzTIp5
         xWKZP1zwsNiEWUau24i8KBu2EhZnrlozJiXL7jschM5mD9V6HP6UzOwpwUigeemLbuqG
         2uX5eesUhTVTe3yiJMtEUH2rAwxHhZQPM2Q65xGSSUhjSBNHoWcUiwXd3gQ4qt1G+nml
         zvDmKIjngDDacFbxpApugajGRtJn1poOEZl/c6h3/yA9ZyjYaLLxk7Kl8ePmLtWp7h+K
         PSV/i1A+yg2UH9c0P1A+em+71uwWcsUkBNx+QuE4xflfqek14/yZRT4/z7srKnMPim9G
         MzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694383; x=1793299183;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6OyEIFFGQJwoM3H+g7NU0Vj1plI2Oe4JZLflWIJCYwE=;
        b=Uxvm4K0+q3oP1+bRcMRSnhmfY03yexH+UZTnEvd/tEDfptLUwFDvDRJwG5aV6XcvjG
         sfRNPs84ExSAn7vzLj8txzWIquw7/UZWdxGsAhBzzyk+lLot+C0zXfDjv2/I45FAc/wY
         Sl4+kJnGgzQOLAWWSm6/zbGCPUuEnqSOUw6EqiyEuKkd7Y9fELgUcFj4iGsAJWD04TNJ
         LbF0Zslec/yXmDHrXVieujBWA4X7dKXvSYFoF9DnhTqXA6Y6U3fNTCVDEq7hsY75Z+1p
         txExwoU/6yRE3bNwEnsWtu9SLf5L9OE+XKudY6g1ao+odx3pZjfDF+i7LUwkAtPO/p4q
         /4jA==
X-Forwarded-Encrypted: i=1; AKwUvBzivW+61r2NsmzM7urxCFwKQT3s+RnCGY1727D/kUIjyTztCbYHW8dy1bgWBhVIIapdK9I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLm+CXg0Dea81uX8nieqMAcVz0s6G12PJTOvpHK+I2CVDCqEqYd
	Xklk5ZUbhYrbPBeTexNxksWwPrSGB1qnOnS3ZwjHEI9OJYxJDeZHhDENVxaNAqmvczk=
X-Gm-Gg: AYBFou03rAgjL1KOTWimRL/9rVvQYUmRfcUVylXsASLNtosWD8yPNuka6hxK333KCWx
	F1C5jxkXvoGMnMnafhs1mIK8G9Ji4L69CY6JmtfBJL+pyrAmRwe0Hp3lYelSyZsPoKBemLX3+sX
	6wQFVL8k01p3NYDU5YR6dF2ZDlKFX+gWYUK6GDs+RMMCnnL5UMwKiO1im7uYlytXawpy/3PE9SE
	uokiR/zCeFasJ99ZzM9TU9S/c9w6Icl0AYmKLJuEHKdFHZNljgi8+2MZCGabN41LKRd9dsh6YN5
	sVxjNGpQiTXrYrRWfNs569kl+x22CK77Os6+ZnWUgeqp9AElsDCgAJHyFPEvKMPXuaw3UE2l/UD
	V+iFxNqYTKxLXELq03qtGzAhKouDPHPlT46n/nXqiPBrPLA6j714lIWZnisfPROt7BUTPBzPkr1
	3sawlTS/rYPZJWXrJRJ0iFDdyI807aThIzK4eFHGNGzKUecoiG8PhYdeatMonC9vYT/6C+m3D4s
	XiAehPMefsSoisde3OtGxEgoWkQ75gHTacXPXOHU62kwMARClBMKi5y2Z0W5UBtmGe4wEPl4SOF
	i0Zvku43r4SYC+iWUYqdvbLdPBgpHKufWCSqrA==
X-Received: by 2002:a05:620a:40c3:b0:937:d6e8:59b0 with SMTP id af79cd13be357-93f6f79bca2mr59757485a.10.1792694383306;
        Thu, 22 Oct 2026 11:39:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f6fb82a5fsm19367685a.8.2026.10.22.11.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:39:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xJxhW-0000000FjFr-0C75;
	Thu, 22 Oct 2026 15:39:42 -0300
Date: Thu, 22 Oct 2026 15:39:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-coco@lists.linux.dev,
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
Subject: Re: [PATCH RFC 05/20] ctlv: Prepare message input handling
Message-ID: <20261022183942.GC3381610@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-6-jiri@resnulli.us>
 <20261021014324.58376589@jic23-hlaptop>
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
In-Reply-To: <20261021014324.58376589@jic23-hlaptop>

On Wed, Oct 21, 2026 at 01:43:24AM +0100, Jonathan Cameron wrote:

> > +bool ctlv_message_input_rebind(struct ctlv_cursor *nest, const struct ctlv_schema_tree *tree,
> > +			       u32 node)
> > +{
> > +	const struct ctlv_message_input_scope *bound_scope;
> > +	const struct ctlv_message_input_nest *indexed;
> > +	u32 i;
> > +
> > +	if (WARN_ON_ONCE(!nest->attr || !nest->msg || !nest->msg->index))
> > +		return false;
> > +	if (!ctlv_message_nest_index_ok(nest))
> > +		return false;
> > +	bound_scope = &nest->msg->index->scopes[nest->index_nest_scope];
> > +	indexed = &nest->msg->index->nests[bound_scope->nest];
> > +	for (i = 0; i < indexed->scopes_count; i++) {
> 
> 	for (u32 i = 0; ...

Is that allowed now?

Jason
