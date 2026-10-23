Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760320;
	b=3Lp8BR+l6tDCEkBmbnuYrpSBVRFr30CdAm1oo61nTgIFtoS35tea0UJrwIBe2wUzPvde
	 zn4q44AxqWPHR9dmxekoM9hRLY1iLs+k3SWFekN3GBifTcUmo/AQ5fF6RclmLd6dVPjqi
	 n4awITC4RWB4a+ja4SlP3zUOidTk6B2fX9dPkBWpORgsEYkCqInbOekdBLGBhHEs1zX1q
	 jDUj5rxLD3Thf0KFE8OSmHkenv7o+qRnd/tGsFL4tlTVy9Skl6epUtgbqMQdeP7PVBs86
	 6KHBPCsmFNmHZp1T5koyNGS5MbMO8OPs7YphyJoTlnseS3cBKMQLru6sZdflS1nn74A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JG9x0NIXD32q8WVFYmOnLtFpuKdZNQP6WxoLonwFFAw=;
	b=a0Vtby3v/4YMzT89hEKKe7Q9UnSLvPXocEVq73de6pIFrSp8TRO9SkXBZtdvYBRWtWbo
	 ozSuhV0tz+lwyPnHxmOpvbkbxidLsJuYXG4ZSPKd8fAJRSpiU+eaEFb6SsPWwmuEmYpKY
	 3ksStqipZWRKh27JBlp3bIiXSVdTBvJ0so/WuU9SuViJm6XXy0nNQRPT8lhEjFyqKrRmR
	 YLaeq7JTAgsxy5awwEMO3z4rdr2lCci7lv91ZheUaK+myIYdlQix8UGGoj2gVCco774q+
	 iQHsIjSQI6veUCpJDhcg5SAVUgJAQlI+Up/mkg9bwF+M87DZKBK7oP6I5rg+Bm2hiVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=CifPPNfY;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013F606A31A
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 12:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0013F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=CifPPNfY
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so7746055e9.2
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 05:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1792760317; x=1793365117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JG9x0NIXD32q8WVFYmOnLtFpuKdZNQP6WxoLonwFFAw=;
        b=CifPPNfYtcVHaaC8q7fD+mJLpWcf2lwFcAnphQYlgJ18Vg/dA+iTn7mr4wRjCEMiaI
         mgduAr34636erZ1R/64KnaYi5fADZn9qcEng8y+95LgfxS3aPQ54AutC8VUbwRckHWxD
         i27ixlz4zvhlZN9Kdx6UORIqOGB0jw7o0taaJ2LjE/6/Sf8lhRr51gt1kzYAWLSgy7cb
         Dvl1JmY2CZ8b0K5PFt+8MeL1NMdfxkWpR3z03E8hhroCOcmscpF93a9rOK08MMniIyPr
         nZnqs4BjJpMUJRWOtoXbn3AbFTcS1LlCvlbkbQcqgrF6qtgRcB3G7Uus2dhpV7mXNQlN
         tQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792760317; x=1793365117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JG9x0NIXD32q8WVFYmOnLtFpuKdZNQP6WxoLonwFFAw=;
        b=1uyZObyvGIxWTztkyNkiqTelIRS4by00zTuSPKt/y5UT+b6626UMqR3xJh9hDbIdHo
         PpvKyjyxFmwuRpBQFkSvPd8XAM/W3hPTafstyt9uUhuJkJNjvWcLFxZS9xS/mXz7WeJI
         M+ZXXxmxg7RGYZuvnu58rfTbOvgdPPAaRrAxhoFsD07yCiTrD8NAMU8tgMKFK9QwSciF
         RCkwvY2VJTSMHallC6EoeeQwQ5LOPVSeYs/r8EhI5lme+4ZSV+G2ttn9RSrAaqMQjut+
         gzeEjgBQh9owly8RMJ52ruQSXeYA+t0o8KtBK8JUHq06V13Ez398mtvlbKCC6GWCRJgK
         MQxg==
X-Forwarded-Encrypted: i=1; AKwUvBxCFodLezatZUsWGJju+ZoTNT2z9DtaGLGWvyaMgbxyqFWI6BNIspUhWV+IYDlLTct7vcY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1PengGZTUEuZ1j/fH+xTKi0F149RVTRGb9BZIDV9bWJTAGwiY
	qqSwEPzFRge+gPXui3rk7NUVMTXgxQ6wTiouZ05uJytK0RKtFD19mbGdGR8vvMjRiiE=
X-Gm-Gg: AYBFou3VSZqzl9/83+mURU3dUn9FCj2AfiHBWrZjkNV7WWvDP/b3iSzCtNgZZRmkD4h
	Wn6fGAL28p6ZzlhGRRphbs6esuLJdTKJqfy5aNf/MW/N0dM4qj378UB0y6HD8DqWBkMfi+Uf6gR
	BVqoVyQm4gNaQmhczJK+JLsJCyEwP3KK1cEBfiKDadJLG4garJEzr1GwNptEqBMfQmDWWRdhxte
	VAsF7PHT881W8jh4xRJV1Mh8cMium8dU35kzr645DxGxMbc7tdjsHnkn3+665FWJRSDhuoriI0w
	PhANtecjpqdkvbC0APrKYkCGPofORwxZHOxWkSQ/bYaSkOFpb2iks8NcokIOgxpuQAPlLZmfmra
	/Nz2zZm5k5ITt+QR2gfeQfexbLdHHehuWufoOHlB2h6lnQpK1mKkHZe71UN7jVgIPfilajVMtWw
	mLLPGgS0MUiUgUdzg3XUTTIN+lcvfB505E3d/dDwgu0NAD5pKNCj1KJ1ueDHfmcgA8FqSFc6cl0
	kDnodhi53OWZrizEyHpH5faj0oH5tQY36ZQKfoIT5JKkWFlloQpTUH6hSHP+cfkrds=
X-Received: by 2002:a05:600c:3508:b0:4a1:e774:370c with SMTP id 5b1f17b1804b1-4a211edd5c6mr37509065e9.30.1792760317227;
        Fri, 23 Oct 2026 05:58:37 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2153c14c6sm28069895e9.1.2026.10.23.05.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 05:58:36 -0700 (PDT)
Date: Fri, 23 Oct 2026 14:58:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 12/20] ctlv: Add device and operation dispatch
Message-ID: <attZl_0TNMDLgi4U@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-13-jiri@resnulli.us>
 <20261021022505.6fe1b1bb@jic23-hlaptop>
 <20261022184313.GD3381610@ziepe.ca>
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
In-Reply-To: <20261022184313.GD3381610@ziepe.ca>

Thu, Oct 22, 2026 at 08:43:13PM +0200, jgg@ziepe.ca wrote:
>On Wed, Oct 21, 2026 at 02:25:05AM +0100, Jonathan Cameron wrote:
>> > +struct ctlv_device *ctlv_create(struct device *parent_dev, const struct ctlv_family *family,
>> > +				const void *init_info)
>> > +{
>> > +	struct ctlv_device *ctlvdev;
>> > +	int devnum, ret;
>> > +
>> > +	if (!parent_dev || !family)
>> > +		return ERR_PTR(-EINVAL);
>> > +
>> > +	ctlvdev = kzalloc_obj(*ctlvdev, GFP_KERNEL);
>> > +	if (!ctlvdev)
>> > +		return ERR_PTR(-ENOMEM);
>> > +	ctlvdev->family = family;
>> > +	init_rwsem(&ctlvdev->registration_lock);
>> > +	spin_lock_init(&ctlvdev->transition_lock);
>> > +	ctlv_event_device_init(ctlvdev);
>> > +
>> > +	/* Before anything reads the schema through this device. */
>> > +	ret = ctlv_op_resolution_init(ctlvdev, family);
>> > +	if (ret)
>> > +		goto err_free;
>> > +	/* What this family's events need of every queue opened on it. */
>> > +	ret = ctlv_event_sizes(ctlvdev);
>> > +	if (ret)
>> > +		goto err_free;
>> > +	/* Before a minor is spent on a device that could not be announced. */
>> > +	ret = ctlv_device_uevent_check(family);
>> > +	if (ret)
>> > +		goto err_free;
>> > +	if (ctlvdev->dynamic_ops_count) {
>> > +		ctlvdev->disabled = bitmap_zalloc(ctlvdev->dynamic_ops_count, GFP_KERNEL);
>> > +		if (!ctlvdev->disabled) {
>> > +			ret = -ENOMEM;
>> > +			goto err_free;
>> > +		}
>> > +	}
>> > +	devnum = ida_alloc_max(&ctlv_device_ids, CTLV_MAX_DEVICES - 1, GFP_KERNEL);
>> > +	if (devnum < 0) {
>> > +		ret = devnum;
>> > +		goto err_free;
>> > +	}
>> > +
>> > +	ctlvdev->dev.devt = ctlv_device_number + devnum;
>> > +	ctlvdev->dev.class = &ctlv_device_class;
>> > +	ctlvdev->dev.parent = parent_dev;
>> > +	device_initialize(&ctlvdev->dev);
>> > +	/*
>> > +	 * The core owns the file operations, so an open holds the core module
>> > +	 * and not the family's, which may unload while readers remain.
>> > +	 */
>> > +	cdev_init(&ctlvdev->cdev, &ctlv_file_operations);
>> > +	ctlvdev->cdev.owner = THIS_MODULE;
>> > +
>> > +	ret = dev_set_name(&ctlvdev->dev, "ctlv%d", devnum);
>> > +	if (ret)
>> > +		goto err_put;
>> > +	ret = ctlv_family_claim_add(family->schema);
>> > +	if (ret)
>> > +		goto err_put;
>> > +	ret = ctlv_family_privs_pre_init(ctlvdev, init_info);
>> > +	if (ret)
>> > +		goto err_put;
>> > +	ret = ctlv_family_privs_init(ctlvdev);
>> > +	if (ret)
>> > +		goto err_put;
>> > +	ctlv_op_publish_all(ctlvdev);
>> > +	ctlv_event_contexts_start(ctlvdev);
>> > +	ret = ctlv_family_privs_post_init(ctlvdev);
>> > +	if (ret)
>> > +		goto err_fini;
>> > +	scoped_guard(rwsem_write, &ctlvdev->registration_lock) {
>> > +		ret = ctlv_device_add(ctlvdev);
>> > +		if (!ret)
>> > +			ctlvdev->registered = true;
>> > +	}
>> > +	if (ret)
>> > +		goto err_fini;
>> > +	return ctlvdev;
>> > +
>> > +err_fini:
>> > +	ctlv_device_fini(ctlvdev);
>> > +err_put:
>> > +	put_device(&ctlvdev->dev);
>> > +	return ERR_PTR(ret);
>> 
>> Jason did some nice handling in the fwctl stuff for
>> device alloc and hand over after device_initialize()
>> (I've copied it into a few places recently :)
>> 
>> I'd like to see something similar here as it made
>> it easier to follow lifetimes etc.
>
>This is really at the wrong layer.. Attestation subsystem is the lead
>subsystem, it should be allocating the struct device memory and the
>driver should see the typical
>
>  struct attestation_dev *adev;
>
>  adev = attestation_alloc()
>  [..]
>  attestation_register(adev)

Er, the driver would call attestation_create() which will be a wrapper
of ctvl_create. The reason is inheritance chain and each parent being
passed info to and doing its own init()


>
>Sequence in its probe function
>
>We need the subsystem refcounted memory to exist if we are ever going
>to create a kapi and common functions
>
>Jason
