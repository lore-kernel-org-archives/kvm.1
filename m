Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E32B3B637E;
	Tue, 26 May 2026 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779783074; cv=none; b=QaeEfXoCEcr1qC9T1quIqe8nMQxnU5FxDtX6YhIi6D8bD2KTGA57wf8yIrLFl+TTJhVk62EhkUSK80OJ+/5ml1fIexks/uWVfa/aMZOg4lVc6kqeEip8dDq1xT27oK49He1Ema5+zMT6qf3XhXEP0vtDxBOYfsa7ZVEJfOXSY58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779783074; c=relaxed/simple;
	bh=boKZYP1wQthbsrfFdGDPZ0BmEPFmYpiL0JoBB6o4sNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q71kX+MuLq/NS84PxwHrTqfUCK/T3DA/x8qw+PMqX9RvD4t8LFNY2N/s55JRXzyKdvu8FJIZodHaZqAuRsGlflrAXxBK+kDqxLiFcphzZaqSghdj1UoXcv5f+YmAbl9j/IhPSXw09t5XGahgUr9bACSLVpLAvzo2eF3vNFND3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqrIMNq9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqrIMNq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1423B1F000E9;
	Tue, 26 May 2026 08:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779783073;
	bh=C0fyZ+lCgP2C/Zw159lCZ1rwik135C6Ord0Wk7x0k6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IqrIMNq9LAEsE+JYrsYK3ws/CfDvEDoMwl3jxl3dIfjc0/yiamJO/UBBlVoLV0uO8
	 aGiJbJlbFnrBri1LPf/zWvY263sHbRdpTUZT08ju8MlFpjqADv7b9K01CEgZHPnxHW
	 88m0IoS2NtHbV4InghHtwd308R0N1gZDKunGZ/l+wdujIyuZoGbShZ46/HgeqRWzHZ
	 Btf/txSKt6FyjqdKntgRzV7rM2352xMhJ/G/qmGKoPQ0pF2VMshSZjIJyh0/hrIn88
	 cq7l2uUwAVDQhFlIE3XecA8QiBhhAOKUP58yxn8Q7aothEwPD9wYz+WNPMyP28IV6X
	 maIzFq2mLfTvg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v5 1/5] vfio: cache KVM VM file references instead of
 raw struct kvm pointers
In-Reply-To: <20260525164753.E54191F000E9@smtp.kernel.org>
References: <20260525154816.1029642-2-aneesh.kumar@kernel.org>
 <20260525164753.E54191F000E9@smtp.kernel.org>
Date: Tue, 26 May 2026 13:41:08 +0530
Message-ID: <yq5ay0h6si8z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Concurrent BIND_IOMMUFD ioctls on multiple cdev file descriptors for the same device unconditionally overwrite device->kvm_file, leading to reference leaks and Use-After-Free.
> --
>
> commit 9a5907f1fb1069cc250703cfb404e5a7be33bf23
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> vfio: cache KVM VM file references instead of raw struct kvm pointers
>
> This commit switches VFIO to track the VM's struct file instead of raw
> struct kvm pointers to manage the KVM VM lifetime. This change allows
> VFIO and iommufd to use normal file references for VM lifetime rather
> than relying on KVM's internal refcounting.
>
>> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
>> index 54abf312cf049..ca75ab8eb7bd7 100644
>> --- a/drivers/vfio/device_cdev.c
>> +++ b/drivers/vfio/device_cdev.c
>
> [ ... ]
>
>> @@ -133,10 +133,10 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
>>  	}
>>  
>>  	/*
>> -	 * Before the device open, get the KVM pointer currently
>> -	 * associated with the device file (if there is) and obtain
>> -	 * a reference.  This reference is held until device closed.
>> -	 * Save the pointer in the device for use by drivers.
>> +	 * Before the device open, get the VM struct file currently
>> +	 * associated with the device file (if there is one) and obtain a
>> +	 * reference. This reference is held until the device is closed.
>> +	 * Save the file in the device for use by drivers.
>>  	 */
>>  	vfio_df_get_kvm_safe(df);
>>  
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does this unconditionally
> overwrite device->kvm_file if concurrent BIND_IOMMUFD ioctls are called on
> multiple cdev file descriptors for the same device?
>
> If a user opens a VFIO device cdev twice, getting two distinct file
> descriptors (df1 and df2) for the same device, and successfully binds df1
> to IOMMUFD:
>
> - device->kvm_file is set (with an extra refcount)
> - device->open_count increments to 1
>
> When the user attempts to bind df2, the check for df->access_granted only
> checks df2, so execution proceeds.
>
> Calling vfio_df_get_kvm_safe(df2) will overwrite device->kvm_file with
> df2's KVM file. Could the previous file reference from df1 be leaked because
> no fput() is called?
>
> If vfio_df_open(df2) then returns an error (because device->open_count is 1),
> the error path jumps to out_put_kvm and calls vfio_device_put_kvm(device).
> This drops the new reference and clears device->kvm_file to NULL.
>
> This leaves df1 bound and functional, but its KVM association is destroyed.
> When df1 is eventually closed, hardware drivers like vfio_pci_zdev that check
> vfio_device_get_kvm() will see a NULL pointer and skip their KVM
> unregistration hooks. Can this leave KVM hooked to a closed device,
> potentially leading to a use-after-free when KVM accesses it?
>

I guess we can fix this by

modified   drivers/vfio/device_cdev.c
@@ -115,8 +115,8 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
 		return ret;
 
 	mutex_lock(&device->dev_set->lock);
-	/* one device cannot be bound twice */
-	if (df->access_granted) {
+	/* The cdev path only supports one bound/open device fd. */
+	if (df->access_granted || device->open_count) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}


