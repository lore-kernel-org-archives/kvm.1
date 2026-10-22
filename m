Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694597;
	b=UhYGoxjSgOev6WHGa46N1gV/MLeryMeyNA2I86eougsjp40navu1mcqAsUAbjyCRN4mw
	 PtkCj1vU7bMfcs/+ENOd6Q5vte8eIhEy+VjchcvzNo2IrOGgmsuwWDwsxilWGyhxTyWOt
	 iela9N7luCKcTpunMWs/0UjDLCZ2u77nZoin+I2vQaLyyXRL9rAybokgQChDYLnRsLDDA
	 q0Cn0afDD19/6IgCsZuNjRUVOIHDmyxIoB7a8KubfxkZOR/KfTzZtHAeE6yx6QIq6ffFR
	 0QbtmyQVh42wewhPs2KD/3AutpmYOqH1G+K+kxTDW5gyW15g8XuC3YK7Z8jO/AGYOAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=My1VAgj8tQx3tGuGu6tSDqUUuD+FQDqeoDBJloW0vMo=;
	b=pfvi1giYBK9VmjMVxKhpF/X8OKjIk7e9KEk8vKMfrC33kUSEMKt2+z5ZT2HoD7sdhzAx
	 xf8FZ1yO0uaiDmch/zVliWD/uQ2BfSNRTQRr0e73d3o6+gFf7VPS7rIh+TSShQ7j1SIaW
	 U4nRk+7xsFGBGtWKMJ+0zpjI8Cy554x3rTP7srTSrueFPRrL1/dIQAUMGlh4y8fZcss5z
	 50KbASvsbt9/JD5o+hcsu9ITmGN44BC6Yc5953SEi0zpHoC+NpIhfRgxzM/IeNsILfw9w
	 y8GKREA/0iTQlqbnJy2bqx8/zO9GVPFWWWiJrX/qrCEYEHEH7UqfUKMX0mApBp3rBMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nKJi93LP;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FCE606A31E
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 18:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80FCE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nKJi93LP
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91c11468b5fso2362166d6.0
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792694596; x=1793299396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=My1VAgj8tQx3tGuGu6tSDqUUuD+FQDqeoDBJloW0vMo=;
        b=nKJi93LPc48Esxvohip1vSyHieBUQORNbKUhASwH832yq8/YpN7cupzfybrDxNZpwb
         9Tux6bXq8BPZTnJ0xrIE2ypof5Mq+DgTPuRBxYrlMvJ7pvPttb4ErfUwG25/5mEAyvsX
         3i5SsTcaAThuto3P5oLgORukoVh/lCAgW8PXZT/kpbMhDVHYC+YqWMZDs5Zjv3eKswZN
         T9PVuV+Y/yAla5vrjn+/dQ4k8GDIinY/XCI/+tg5+RonRfWg2hghEjHgY8otLDvEhcBs
         2eFakYN6BWX9BHluQ2GWKp7JHXTFhcYL1XE2jxLpRChT+kYtkIuSe2t5mEbD2G1YBghp
         1nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694596; x=1793299396;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=My1VAgj8tQx3tGuGu6tSDqUUuD+FQDqeoDBJloW0vMo=;
        b=iWTObhATMuDXjt8XtZygVfBh51Qv9S97+gAdfDxnrRnuPOcLPG1wV8EEmq8IQ+37+A
         1aGIgfkpjZV966heQ5GWRzi8HMFKvypyBwM0QVF5sUMjByZ/CEjySwVkyNCllGStuTjQ
         a4a+ZhmK30tfSjrC1aVVkNNwCBJKB9fN/6KFZmsZSQ4EoybIa60QabHymsSmlXUklqvJ
         saLAexTwzXifLm9HKLCIhHyDXvsw1AHmj+4kwxM5lANjDB7ql+mVIB9tw7o6Xx1lKT2b
         TZoGvrv+/TNg85rY1XubjZITTJdmPOfOV4+8upvNddSWIYYXsNip5DYRULRMZlDTULyw
         LUnw==
X-Forwarded-Encrypted: i=1; AKwUvBxTUdTL/l16qkdz6gCDK0jp44+9+2A2S1CFQGb71eQiCjTFFcCIMieuZ7Yw2+3CuLlApPE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLj8XZrviggXWmzYR44HiJ2J906cpUG43QmFICjL++QbRMybGaN
	aHHMlVd/qtDOl0Ly86oJCfQLz3CXb9AiHQ+GoeM7dEqDEIiv72pbbwv/UkSjjGMidEQ=
X-Gm-Gg: AYBFou0vOLIPr1JvFxjh/cmmRiQLuf/RzBo+2H92vMgKyVsCSp/exlFjov0/SyDnjeH
	PURY1WWMICMERW8qdX4AGxpvCuAb+baQQwE5gpMLtun3mla3z7q7sssj1jdn6ql5PBislcBNvjo
	zsm3ZVm2Ut/21B2ZkPhEn1X6s3qzYul9usBvJerXyvLiv+O6BfCzvTzIle/FMMCWEKObWxRKbch
	cJQVwNEiJAxcOw1WqgigAUbZU01mXAozD3W6qKN/aJhyctCeVq6gHxy0APHwgnB8aS1P4QPowo5
	AuwVnGfYs0gxFsNoIBRGMBUXNb0lrLvxWvzoLUoTmVz5HyjzRKdKhKgNThv173aMBWBobEmEnkO
	/CdBvahJAXyNXhNirXZk3XD6m+wj5Cvqssjo1uBcKbbmfQSlCLSrQivVPa2Eg6iLbT6fDQE1gfG
	9GYyF2exDHV10AbplLf2RCVig52yxTQNL3vwFzWE0cjFYxj5x0ndMnPV9ckCaJjnVy+Gfc0iX6q
	PWts5ogBt9900eCGV77n/jv7FNdzoSPa4S+iVwXPHM8Xl7EkWD13dH7e3AB7xtPX+GVXrB8ND2l
	IEZHXqrIKcUFOTV+Hryr7pFgM7BYlp1V8E1HsA==
X-Received: by 2002:ad4:4ee5:0:b0:91b:8b44:d4c7 with SMTP id 6a1803df08f44-91c12ee2dc3mr106716916d6.26.1792694596058;
        Thu, 22 Oct 2026 11:43:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c37060bb5sm4070256d6.24.2026.10.22.11.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:43:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xJxkv-0000000FjQ8-3dAv;
	Thu, 22 Oct 2026 15:43:13 -0300
Date: Thu, 22 Oct 2026 15:43:13 -0300
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
Subject: Re: [PATCH RFC 12/20] ctlv: Add device and operation dispatch
Message-ID: <20261022184313.GD3381610@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-13-jiri@resnulli.us>
 <20261021022505.6fe1b1bb@jic23-hlaptop>
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
In-Reply-To: <20261021022505.6fe1b1bb@jic23-hlaptop>

On Wed, Oct 21, 2026 at 02:25:05AM +0100, Jonathan Cameron wrote:
> > +struct ctlv_device *ctlv_create(struct device *parent_dev, const struct ctlv_family *family,
> > +				const void *init_info)
> > +{
> > +	struct ctlv_device *ctlvdev;
> > +	int devnum, ret;
> > +
> > +	if (!parent_dev || !family)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	ctlvdev = kzalloc_obj(*ctlvdev, GFP_KERNEL);
> > +	if (!ctlvdev)
> > +		return ERR_PTR(-ENOMEM);
> > +	ctlvdev->family = family;
> > +	init_rwsem(&ctlvdev->registration_lock);
> > +	spin_lock_init(&ctlvdev->transition_lock);
> > +	ctlv_event_device_init(ctlvdev);
> > +
> > +	/* Before anything reads the schema through this device. */
> > +	ret = ctlv_op_resolution_init(ctlvdev, family);
> > +	if (ret)
> > +		goto err_free;
> > +	/* What this family's events need of every queue opened on it. */
> > +	ret = ctlv_event_sizes(ctlvdev);
> > +	if (ret)
> > +		goto err_free;
> > +	/* Before a minor is spent on a device that could not be announced. */
> > +	ret = ctlv_device_uevent_check(family);
> > +	if (ret)
> > +		goto err_free;
> > +	if (ctlvdev->dynamic_ops_count) {
> > +		ctlvdev->disabled = bitmap_zalloc(ctlvdev->dynamic_ops_count, GFP_KERNEL);
> > +		if (!ctlvdev->disabled) {
> > +			ret = -ENOMEM;
> > +			goto err_free;
> > +		}
> > +	}
> > +	devnum = ida_alloc_max(&ctlv_device_ids, CTLV_MAX_DEVICES - 1, GFP_KERNEL);
> > +	if (devnum < 0) {
> > +		ret = devnum;
> > +		goto err_free;
> > +	}
> > +
> > +	ctlvdev->dev.devt = ctlv_device_number + devnum;
> > +	ctlvdev->dev.class = &ctlv_device_class;
> > +	ctlvdev->dev.parent = parent_dev;
> > +	device_initialize(&ctlvdev->dev);
> > +	/*
> > +	 * The core owns the file operations, so an open holds the core module
> > +	 * and not the family's, which may unload while readers remain.
> > +	 */
> > +	cdev_init(&ctlvdev->cdev, &ctlv_file_operations);
> > +	ctlvdev->cdev.owner = THIS_MODULE;
> > +
> > +	ret = dev_set_name(&ctlvdev->dev, "ctlv%d", devnum);
> > +	if (ret)
> > +		goto err_put;
> > +	ret = ctlv_family_claim_add(family->schema);
> > +	if (ret)
> > +		goto err_put;
> > +	ret = ctlv_family_privs_pre_init(ctlvdev, init_info);
> > +	if (ret)
> > +		goto err_put;
> > +	ret = ctlv_family_privs_init(ctlvdev);
> > +	if (ret)
> > +		goto err_put;
> > +	ctlv_op_publish_all(ctlvdev);
> > +	ctlv_event_contexts_start(ctlvdev);
> > +	ret = ctlv_family_privs_post_init(ctlvdev);
> > +	if (ret)
> > +		goto err_fini;
> > +	scoped_guard(rwsem_write, &ctlvdev->registration_lock) {
> > +		ret = ctlv_device_add(ctlvdev);
> > +		if (!ret)
> > +			ctlvdev->registered = true;
> > +	}
> > +	if (ret)
> > +		goto err_fini;
> > +	return ctlvdev;
> > +
> > +err_fini:
> > +	ctlv_device_fini(ctlvdev);
> > +err_put:
> > +	put_device(&ctlvdev->dev);
> > +	return ERR_PTR(ret);
> 
> Jason did some nice handling in the fwctl stuff for
> device alloc and hand over after device_initialize()
> (I've copied it into a few places recently :)
> 
> I'd like to see something similar here as it made
> it easier to follow lifetimes etc.

This is really at the wrong layer.. Attestation subsystem is the lead
subsystem, it should be allocating the struct device memory and the
driver should see the typical

  struct attestation_dev *adev;

  adev = attestation_alloc()
  [..]
  attestation_register(adev)

Sequence in its probe function

We need the subsystem refcounted memory to exist if we are ever going
to create a kapi and common functions

Jason
