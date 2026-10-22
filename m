Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659950;
	b=heWmzVX8HjDRP/UbWyxVYCLsMNfEfTLXJB/oWz4IoD7FGCEXbvsscTtJWRBfyQF5j+FN
	 1FCP/B4OpMazkaaRidlrghwYnTNYheI8etSGetNKFqWADkqt0HkqZUp/hPKPqEDp+6b1x
	 l8GkE1j2whVz2uIuJ44PxMN/6jKpK1LuRU6/m+8MSRXm/L5OB6G45k4D0NcjHG2g5cI6F
	 XaIi7MEko5myld1hJRzFXR2x/+a+hWPDmp5iHG5aAa0lq3I8HOfgA9s1uqnWjp/Bh7Vxq
	 bxyuZoEfI8EHgrKKWU4oWBQKcT07vyeowHogRNUZtyYnVqCSUqWyVSoVTtgAeUHd+4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=VCtPLF1g5YCJnqvDxXjL/9SGDpcHIvBwNuJeTWJPyWo=;
	b=in+rUScM0nPenxe/VrbL4O7oYxRKavEY/Xm0nl5UFF2FAqiHTSZl2RsOMB0nj86QwBkp
	 K/7cWbNPULAyvZTK+GUZN7lphdQhiymZWhMI1Pb1+qkFVRFtVFwLzv5Hr+zLiRfgM5wnS
	 wcKIgnNJVk6TlxtqoK9NtHQL/dQ4vjOX7uZ3ol667OjgIrcZL1gR0zpwFdhtafsbhSrc+
	 XCwRk04SisPwc5QmLTZ5KgN0O6ZpZb55+78IJFx72M6hB76R69JBZw5c3LIR87bFEt15P
	 jimtIJmxQUgKdxcmeYWZYPhhSc9U4p5eJVNbnn8JQ9BMuWIy+iBaW5V+iO6pYeez6MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=CG4pwxKj;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9167F606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 09:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9167F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=CG4pwxKj
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so1347201f8f.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1792659947; x=1793264747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VCtPLF1g5YCJnqvDxXjL/9SGDpcHIvBwNuJeTWJPyWo=;
        b=CG4pwxKjkPq41V9lUY1xPtyLM7VGkWfj0wIo2355s6BuBYcgsuRPWfhiVq6CnU5EUK
         U6ISRUDw6LP3pxCtWf53VXIfVLLFARjt5/A5RTFt+Wj5BQOl97jTWy5uCVl0uJZWZjdx
         5QJOnQ67tU8DZeBGkIBPmyGxUBNX8t40T1FxTQcWlxN/XSMqIzeI5/KwqhLXE/nZYg/2
         l652BLCNN5Kg7dZMEBleKvf3x4lpyF2+1ohF3/UOY/Bo5ex0KS/FI4UCDM6fFbSf2m7g
         Jwj6H3TFMAkXXh6cmYl2j5nTS3Z5Ixi/a1aX0e55EA1spziMAnLVlnozBP/BV3o2LlvG
         bjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659947; x=1793264747;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VCtPLF1g5YCJnqvDxXjL/9SGDpcHIvBwNuJeTWJPyWo=;
        b=hiwGpq0nKfXvWRnifiZ3mwzElhwTnM9xccUQRbZ6ghl/GICcpV0Jjgf8XpQJRoGWqp
         RBbv98ZFZ0HpSc8aEnUcjlpymVo/nydi5idUhwhvYXAcx5hxOuLa3GMtnG9+qYuRKypu
         Ts7qeBR/BHU7VC5cbJhEdTe5wZUaY0LWvT5ABaMaIAdsB+LejtCXlyiGOaeGtMg0SRXP
         eZigFu/Qjb6adIxhZRVEILjx3byv2Ilwp1p+IAlT2Nmye2/JBJVqyPXctAqVI/LtFG35
         IvEh7IpbAADRW/SG9g8ZQNCn0X8hDKlG7d8Yhpr1Bkq7iyaIvaw0/5EBuT3amGWE1TVs
         PrEA==
X-Forwarded-Encrypted: i=1; AKwUvBwakfvqDKh3ya9SPfYgYtumh5GEOIsVlgNJAXe7/j8k9jclU3tbqnstHm3w8sgORb5vKmw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFYL0aS4RToIp6Ub763kYKmn/AfZ5hw1r4US5fEFMjCYS+S07G
	0G5QeJ8I1YIbFXjV1KFcjX2SZyPgeJ7HAkVYMyh9fC1EHanOy3NWm02zk85e7Yzeb4k=
X-Gm-Gg: AYBFou2saAEkHwr8TFYCR/lBQ51ezp0M930DEkhy39+vLfklNi66raCSvUdZ9aSZMn4
	h7UWhi02495HlLWZYYS71/fOshESFv+hQ5XL70Vt535To6+OK+XL+8V7bO+nfpjiv8qXHQMAbPn
	reBqMLF7dAjF0seKwmYWubwSGuWK9Rhn+RnzivJ+HznBNpbm3OYXjv6nVMURXVNBjwIeB5b90ZF
	VqgdmYhhpMBVrGcuqsfKCazdPg1YprVTGU7OlXBcgGMHvKXppIOZ9A+Kc9ocV50Jo9rAzFjCi6t
	n+7wSFwbC173ftO1QLzvYe2JQfEzD2QHGvMGauy9LSPnFb1D01wn48TnQyFI+SHegVmKXsWn76Y
	uDMoD82uC1pvkm5iM8P3t3bVxPxPrkGqkHvgz610+5NGUKPL8Liuo7Wpoj27dBSzXGYzBQfrPUd
	2g5M0DIaVd4Nq9srxmuAP3KlMc+qjNsmR+/iFpvuoi+PWt7faolEEZ1bR7TmEeisNvJQSwKIoCl
	4O6Shl4RKIp/Afy5HsJVABRUMJ1gJMDhkvQm8Bu8Wn7vNehwjFZcYLNCP2Q80jJ
X-Received: by 2002:a05:600c:3b1d:b0:4a1:d41b:5060 with SMTP id 5b1f17b1804b1-4a1fdb1358bmr98096365e9.22.1792659946257;
        Thu, 22 Oct 2026 02:05:46 -0700 (PDT)
Received: from localhost ([128.77.52.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203b28f70sm62056445e9.4.2026.10.22.02.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:05:45 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:05:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	jgg@ziepe.ca, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 12/20] ctlv: Add device and operation dispatch
Message-ID: <atnRsQHieSNzE51D@FV6GYCPJ69>
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

Wed, Oct 21, 2026 at 03:25:05AM +0200, jic23@kernel.org wrote:
>On Thu, 15 Oct 2026 16:50:45 +0200
>Jiri Pirko <jiri@resnulli.us> wrote:
>
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Register CTLV devices, resolve family chains and dispatch operations
>> through validated messages. Wire CONFIG_CTLV and the generated root family
>> after all module objects are present.
>> 
>> Assisted-by: Cursor: GPT-5.6 Sol
>> Assisted-by: Cursor: Claude Opus 5.5
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  drivers/Kconfig             |    2 +
>>  drivers/Makefile            |    1 +
>>  drivers/ctlv/Makefile       |    4 +-
>>  drivers/ctlv/core.c         | 1517 +++++++++++++++++++++++++++++++++++
>Normally I'd push back hard on too big to read, but it is an rfc
>and other patches in the series are much large.
>
>I'm out of time for today and not sure when I'll get back to this,
>so just a few quick comments inline on the bit I did look at.
>
>>  drivers/ctlv/device.h       |   17 +
>>  include/linux/ctlv.h        |   55 ++
>>  include/linux/ctlv_family.h |   22 +
>>  7 files changed, 1616 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/ctlv/core.c
>
>> diff --git a/drivers/ctlv/core.c b/drivers/ctlv/core.c
>> new file mode 100644
>> index 000000000000..aeab29fe2fdd
>> --- /dev/null
>> +++ b/drivers/ctlv/core.c
>
>...
>
>> +static int ctlv_file_open(struct inode *inode, struct file *filp)
>> +{
>> +	struct ctlv_device *ctlvdev = container_of(inode->i_cdev, struct ctlv_device, cdev);
>> +	struct ctlv_file *cfile;
>> +	int ret;
>> +
>> +	/*
>> +	 * A failed create can withdraw the cdev while an open is waiting for
>> +	 * the lifecycle lock, so admission itself first pins core storage.
>> +	 */
>> +	get_device(&ctlvdev->dev);
>> +	ctlv_file_open_pinned(ctlvdev);
>> +	scoped_guard(rwsem_read, &ctlvdev->registration_lock) {
>> +		if (!ctlv_file_open_allowed(ctlvdev)) {
>> +			ret = -ENODEV;
>> +			break;
>Personally I still dislike the hidden for loop in scoped_guard()
>and using break with that enough I'd do a 
>	do {
>		guard(rwsem_read)(&ctlvdev->registration_lock);
>
>	
>	} while (0);
>
>Just so it is obvious what those breaks are from.

Agreed, easier to read. Will fix.


>
>Maybe I just need to get this one into my code review head...
>> +		}
>> +		if (!(filp->f_mode & FMODE_READ)) {
>> +			ret = -EACCES;
>> +			break;
>> +		}
>> +
>> +		cfile = kzalloc_obj(*cfile, GFP_KERNEL_ACCOUNT);
>> +		if (!cfile) {
>> +			ret = -ENOMEM;
>> +			break;
>> +		}
>> +		cfile->ctlvdev = ctlvdev;
>> +		/*
>> +		 * Commits this description to the device. An open that failed
>> +		 * after this would have to take it back.
>> +		 */
>> +		ret = ctlv_event_file_init(cfile);
>> +		if (ret) {
>> +			kfree(cfile);
>> +			break;
>> +		}
>> +		/* This description keeps the reference taken on entry. */
>> +		filp->private_data = cfile;
>> +		return 0;
>> +	}
>> +
>> +	put_device(&ctlvdev->dev);
>> +	return ret;
>> +}
>
>> +struct ctlv_device *ctlv_create(struct device *parent_dev, const struct ctlv_family *family,
>> +				const void *init_info)
>> +{
>> +	struct ctlv_device *ctlvdev;
>> +	int devnum, ret;
>> +
>> +	if (!parent_dev || !family)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	ctlvdev = kzalloc_obj(*ctlvdev, GFP_KERNEL);
>> +	if (!ctlvdev)
>> +		return ERR_PTR(-ENOMEM);
>> +	ctlvdev->family = family;
>> +	init_rwsem(&ctlvdev->registration_lock);
>> +	spin_lock_init(&ctlvdev->transition_lock);
>> +	ctlv_event_device_init(ctlvdev);
>> +
>> +	/* Before anything reads the schema through this device. */
>> +	ret = ctlv_op_resolution_init(ctlvdev, family);
>> +	if (ret)
>> +		goto err_free;
>> +	/* What this family's events need of every queue opened on it. */
>> +	ret = ctlv_event_sizes(ctlvdev);
>> +	if (ret)
>> +		goto err_free;
>> +	/* Before a minor is spent on a device that could not be announced. */
>> +	ret = ctlv_device_uevent_check(family);
>> +	if (ret)
>> +		goto err_free;
>> +	if (ctlvdev->dynamic_ops_count) {
>> +		ctlvdev->disabled = bitmap_zalloc(ctlvdev->dynamic_ops_count, GFP_KERNEL);
>> +		if (!ctlvdev->disabled) {
>> +			ret = -ENOMEM;
>> +			goto err_free;
>> +		}
>> +	}
>> +	devnum = ida_alloc_max(&ctlv_device_ids, CTLV_MAX_DEVICES - 1, GFP_KERNEL);
>> +	if (devnum < 0) {
>> +		ret = devnum;
>> +		goto err_free;
>> +	}
>> +
>> +	ctlvdev->dev.devt = ctlv_device_number + devnum;
>> +	ctlvdev->dev.class = &ctlv_device_class;
>> +	ctlvdev->dev.parent = parent_dev;
>> +	device_initialize(&ctlvdev->dev);
>> +	/*
>> +	 * The core owns the file operations, so an open holds the core module
>> +	 * and not the family's, which may unload while readers remain.
>> +	 */
>> +	cdev_init(&ctlvdev->cdev, &ctlv_file_operations);
>> +	ctlvdev->cdev.owner = THIS_MODULE;
>> +
>> +	ret = dev_set_name(&ctlvdev->dev, "ctlv%d", devnum);
>> +	if (ret)
>> +		goto err_put;
>> +	ret = ctlv_family_claim_add(family->schema);
>> +	if (ret)
>> +		goto err_put;
>> +	ret = ctlv_family_privs_pre_init(ctlvdev, init_info);
>> +	if (ret)
>> +		goto err_put;
>> +	ret = ctlv_family_privs_init(ctlvdev);
>> +	if (ret)
>> +		goto err_put;
>> +	ctlv_op_publish_all(ctlvdev);
>> +	ctlv_event_contexts_start(ctlvdev);
>> +	ret = ctlv_family_privs_post_init(ctlvdev);
>> +	if (ret)
>> +		goto err_fini;
>> +	scoped_guard(rwsem_write, &ctlvdev->registration_lock) {
>> +		ret = ctlv_device_add(ctlvdev);
>> +		if (!ret)
>> +			ctlvdev->registered = true;
>> +	}
>> +	if (ret)
>> +		goto err_fini;
>> +	return ctlvdev;
>> +
>> +err_fini:
>> +	ctlv_device_fini(ctlvdev);
>> +err_put:
>> +	put_device(&ctlvdev->dev);
>> +	return ERR_PTR(ret);
>
>Jason did some nice handling in the fwctl stuff for
>device alloc and hand over after device_initialize()
>(I've copied it into a few places recently :)
>
>I'd like to see something similar here as it made
>it easier to follow lifetimes etc.

Will do.


>
>> +err_free:
>> +	bitmap_free(ctlvdev->disabled);
>> +	ctlv_family_privs_free(ctlvdev);
>> +	kfree(ctlvdev->ops);
>> +	kfree(ctlvdev);
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(ctlv_create, "CTLV");
>

Thanks!

