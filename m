Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886756;
	b=i8zbJiGdDPM/eIv4xXtOg10zhGrKUSu9fkAe0ah+fipw/p+hg4lUm33LOa35WkO3rbCj
	 Y/z6uvMc30xe2v30LpfXhx0jSk9VCF8iVO27F9mvDaKOtuv5ojCkZWR5ubarSkT9e1ojG
	 PdoYukWjC1FHuQs01J05dhC6s4RrM853EsIH9F3GxnI0PVf0Xr6+JTAspgjivO/BTik12
	 6lco+mHQ0zLWvNTsObF4WzpSTOxUsWzRP/Tl6TU3UROYpq3OvUty2iE26UOTh1GVCgzQm
	 +ULlcuC2HxYc6Z5ud9ZJBKNTsjl7tw1ANoDxBwckW8EzK09HdCERfI3mT2pbX/wrWLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=QwmQA1a2QhYSOPcBSTBe/t1Xyv+zC9XEOaQnTg/X7XI=;
	b=hyPR69OU1qYEKPuoFsPGWjC+8gzaR9orwZoPn/5O0bADOs8kr1qgc28PNNAsI1EKPNOz
	 n9duWi2BtUK5qZ43NsiKimneiOzm7eOX5VxZ1B4Z0zT5Ifbf67DDucUmR5SrenpTQNZwp
	 3khsnMz/SX+BSEY1fUS3RWWF2vBYy1aoZ6YNX/uUlwp/jifVIrg6hgcdnMcHq+sGDATrW
	 3vW69h8bN+fyk4QgYanLHQGgtfKo7twbs6+cjEgPAHnQxQBjB2W9ikvLDH0XvVZ5m4i6F
	 UcpuvGwN7R38SoBNfArxqwI6K4Ipav4ASjGDcwldb8SiFRR66XfvfKHJgQQcMQ1fYDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b="c34gCj/8";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8E606A33F
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 13:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19F8E606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=c34gCj/8
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so13702115e9.2
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 05:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793886753; x=1794491553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QwmQA1a2QhYSOPcBSTBe/t1Xyv+zC9XEOaQnTg/X7XI=;
        b=c34gCj/8CF0gjZPD4S6DE7fp5Zl7gSX0P0hMJk9lFt1y+nBZYrLUQMyOe9yskOljO0
         mWq7a3nzqXz8tp3I6ubwhzBAOsJYhD2zSynoQZHrZRopkQjPUFsi2whqLUzl+ldansUM
         MIoZ/uxtCEAMb9QDpVquB9CLXS7hpypOQBKzqBwygEabCHs8+Q8vFHnySRybX3XMNR5x
         /bmNPcFbYLThOu3b+Gb9jeXLHMvKt3ZgoiXr0DY8zyFrDCAKVO/1n77AROFDNyHGSlRT
         4sQdtVSWMSH4Fk6Bh6Fa2qjPcR18tiYc8STHLzktuM/SW/ODCEM5gMYc36N9pRaZ8t/X
         7c+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793886753; x=1794491553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QwmQA1a2QhYSOPcBSTBe/t1Xyv+zC9XEOaQnTg/X7XI=;
        b=IgzJ10WJ2J7+K7LzfW3DJQKVt6tp4BRWSv9QKoH4AcMziiE0l6tCo17Jvc82sJVKpk
         ezT1lEb0du0juNxNI98iQ+8iGM7+x89Ixa2SK7yK07c9fVz89OMNTfn39r2y2ccAQjpD
         J88yPFkPrDaTqdcqLRAJGyb5fvyOf5N6xBnECDeNc+f8H9esSXDyZSIXkThlv7f0TkHS
         OCy7j6/b3HV8iOvQpS7u+KIAOrbukuUfrO8s7/JT/Vane0krWdF69iADQWNPqR/ozdYJ
         fsyovULqlyJprHMmMfc7+lX+cqyzl3c/iIN++krrbhnxdB6tYtJV2Zs+Mf0okEKP1/7S
         Q7dg==
X-Forwarded-Encrypted: i=1; AKwUvBznuga2huQu9FR7JlZhOEx9FNiUTkZpxcX1C2alZe68FqMLBHdAQ+6IVeEleto8PNR4aAY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8g1PNlHcwYozMm8j/C+ArFTusP4WBzgPBsP02axuvxinU34pBq
	xkWW6awK76AlDV8tp0jPbY30/Cn5fo1xRdrvItgMAOC06Br3Ka/1ycic4IIk7d6T4Mk=
X-Gm-Gg: AYBFou2Gmal2bolEV1AMgDixMtvXFvxb4wpiYowqsqXOjQm4zBRpWqtlJ69aa1ax+wf
	G0QRGwSAofkz4VschT79mhuXNxSbN5oyT5ZTdUdTLc4MOEp07v4j1y0WnawWegTWiY024qSixvA
	1kGoX4UmVFSZ2BGrOrxY5ScspIlQ6NsckzaDT0DYeZ+v25mVGw0PXDgg/u+A4bPOPYj675xvQzf
	meUjoLybdJjVzpohfx4pmESMAfVGa495hgVA75ul4C/I4uGlQKoA5kM/jRIqfi5aWn1U4+DbUq5
	VGenZqnJ5AkQz63z60psUURXhjKejbKFz2x7YJlCR1Jhwi4PetIecaweoA6O9hTsonu9a92y64s
	Jw9aKRZrGUAvdiWqqyI0gFYxmQ6GsnYX7vjtJTtQ6LQaFLwvyj2KQCV3gT+VU6BwPrsaOIvfUx0
	XH5g+nPbnduQWItb+PMQ5suOInvEXvs3nM7zVMdoOi1isxuoFajs6MfGKiZ99cwjsIJaLleUC5i
	3VXCAEHL9/cS0h6/XopapJfCfW2qiY8mO0qlxPSNMP6ngoycsX8qxgROzT42CSL7e6s6j1JeAQ7
	KoBHQpCNoWDVO1lgra4EnbIV/mLVut8rTQXisoU=
X-Received: by 2002:a05:600c:83c5:b0:4a1:88de:9e8b with SMTP id 5b1f17b1804b1-4ac17191074mr383781755e9.5.1793886753121;
        Thu, 05 Nov 2026 05:52:33 -0800 (PST)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4104d600fsm127121635e9.0.2026.11.05.05.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:52:32 -0800 (PST)
Date: Thu, 5 Nov 2026 14:52:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	jgg@ziepe.ca, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 14/20] attestation: Add the base family specification
 and generated files
Message-ID: <auyG1AnzpjLdOtpR@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-15-jiri@resnulli.us>
 <179302367452.58760.3782556786585774917.b4-review@b4>
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
In-Reply-To: <179302367452.58760.3782556786585774917.b4-review@b4>

Mon, Oct 26, 2026 at 03:07:54PM +0100, jgg@nvidia.com wrote:

[..]

>mr-get:
>  request:
>    id: uint
>  reply:
>    name: string
>    supported-hash-algorithms[]: uint
>
>No definition what these numbers are. They should be TCG2 defined hash
>algorithm constants I guess. Why not have an enum here for them?
>
>    caps: mr-caps
>    register-index?: uint
>
>So we get a string and a small integer for every MR? Like PCR10 and 10
>for TPM?
>
>=======
>
>mr-dump:
>  request: {}
>  reply:
>    items[]:
>      id: uint
>      name: string
>      supported-hash-algorithms[]: uint
>      caps: mr-caps
>      register-index?: uint
>
>
>This returns all of the MRs at once?
>
>=======
>
>mr-read:
>  request:
>    id: uint
>  reply:
>    generation: uint
>    values[]:
>      hash-algo: uint
>      data: binary
>
>Get, dump and read? I don't get it

This is another netlink-influenced terminology. "get" fetches one object
info, "dump" fetches all objects info. "read" reads a single MR.

I'll remove get and just have dump accepting id as a "filter".

