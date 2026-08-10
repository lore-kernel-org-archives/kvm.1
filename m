Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8A42CAFD
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786398428; cv=none; b=EWlNJ4jssELpIWyMNY2yprTF1KUcN4aNZqx1leBBft9dVE2vIyPiDBiCaYiPOtsDoRZeoqbAXP9CU11uhWUj23fcJJWLoYKKT2SgTg19OWBlUe2l+1OwFPRxxGxjkyPV4bjU5gb24TuZsgrlMLKreBKmDnSIZV+AhtKr5iM2eqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786398428; c=relaxed/simple;
	bh=gLj89t1XtGHeoqqhdxlQE5veKwLUg9rzru7S0F8D1UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYVjVTdZ9kI8aDr/ZH5n5laY30Gb3LdkMrRTZsGr1sJZECrmDsIf0bUvF/uIb2rrl9WLFhAQX3KMY/LIyDQaQEE5Xzg6uJSEWlXNIPoInS5uH+z84oc/yDFikMFU63LP0fYSVt/fd0dBOTjtzSR6j+MqtTQvukiCY5C9ttfl3Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5g8fZCx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5g8fZCx"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cede6375caso40125ad.0
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 14:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786398426; x=1787003226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qrPHJG3p8YfDYZ+uVx/4qIrGxMhgcPPKzeLgvNEMm4M=;
        b=j5g8fZCxB+A45oujTmVO502pCMcEluM+Yy+hlyBteMz1veLwbN3pqadrtBK6hT5oqX
         d2yUTrhNRkI2qZ1yPaRCYtoRAImuwYaRLyYXeR8ATb1g0hfU4ugaSrQF8yXQ0HAWb5NL
         ihjJUmQN2Kg2cRpyX3ICU6mJR1FejqZHySCnklE702OG9rLEJNufFyKz9tyKjte1oYPH
         LrgqLhxWCJGn7hEKQfEPv+RK7cDVgWV3N+NUUKccW4BiOW2sJe1U7L8aHT2+H4uT1kEK
         8/zbzA2onKcT2HGBRjSF7HIbX4LzLnwKASfV+a0Y9OhcsF3B5L2cBj0ZQvHv8sjo+M0k
         0iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786398426; x=1787003226;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qrPHJG3p8YfDYZ+uVx/4qIrGxMhgcPPKzeLgvNEMm4M=;
        b=MiQS54E5ZaCHwrYK+IEwKyVkJDiMETq7QfdIDxaqJ9jAr4EqXhf9jxMX1oac7ipcNl
         w/1NCpun0o4zuGSQKF8qWmnXRNVrJaCSJxtIyfmDwlT425r5jQbC9OFf4x5CCl4PAGcO
         62RJQHXuGweL93PeyXHgYKingcN0kNpyfIQ2hT1aDnLx7YjiXivJAtXbxYeV/AHsP40t
         6aqecEX50c2dvfu4u0IDP+962CDbJ+ea5MZ6eoxlUrEy1pYFhtYoLRe+U6cus6N9hRHX
         gZKJW7QcytFHL8dVJyK88agh/xAewu/x5vtD7Y+BUeA0b5uCfHvZcJYllHnzczRLJi16
         Xajw==
X-Forwarded-Encrypted: i=1; AHgh+RqXq+Lkp+trFu+77z5NaJ+qLHMJ3NXa1iDCwNYXOgYqs00eFnks6cjXe0tJ3rvmQ+L5bOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylXv/mQqYzvYm3u+OHG4qjBd93UtlyBao+Zr3YTc7h4753mqmo
	pXXTOAyGo0gI6b853HPo11y4N8rtisXC7uP01HezMjZ8M7f9I7a/weSEM/g8CmdUQ0hfQXjem5N
	O7Wpq1Q==
X-Gm-Gg: AR+sD123oDy9ufOxrDgtRQQ+huU98Wf6wj7292wqm0z5Wcp+/cfOhffTLWdYZwnLM12
	Q/T+RPFCeBdlZMzoPthISVnsa6uKaIDgzhCfCWqdoj5v0A/obH9poK2EeGqjzS/UnSz1bz3nSqJ
	AMxJZwq9pw2P3opkscCFTjQmix5fPsCLXR671v/PHAP3oeJ4UKYP3DtWjeFXd47CwZ2sg+Dj2Mq
	UCocdOnLBug8NkYpHQTls1/kX/c3R5GyJRXzx+s1yzYnd0pRNuQYq51n/R6K/bhhn86XO+WuF5C
	+2paaWQxbhG7QZ9YAodpCZwYRJ+gemHsSjy83tm9Yx4yu4KobYz5dv1AN+ossn3AaLsSOHO8/fg
	m9ik/P6a4JI2pVNK6OMDSMPT6N3rSe4XwHDjLcQBmyr3X9SuOS5wdd7VM/03ANx3AEDogQiwscB
	RXp4XQpukqbCEwqGXkTKE+P/VZ+sQhHOSAiMH0YFsBTfBOlNsadzR5fDgrqblnrcPuZHUQq1kmb
	Cyw9GJF7ie7lRTi3e31dh4NPNQLAenxMc/L0FhA7POrL2/fbwDq/qUY/6M=
X-Received: by 2002:a17:903:b0f:b0:2c7:f0cc:dafa with SMTP id d9443c01a7336-2d312020793mr873965ad.5.1786398425735;
        Mon, 10 Aug 2026 14:47:05 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d51bf886sm1043442a91.7.2026.08.10.14.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 14:47:05 -0700 (PDT)
Date: Mon, 10 Aug 2026 21:47:01 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, Leon Romanovsky <leon@kernel.org>, 
	"dmatlack@google.com" <dmatlack@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] vfio/pci: Disable sriov on PF device close
Message-ID: <anpD2sBgwyfQAjqm@google.com>
References: <20260805003355.728299-1-skhawaja@google.com>
 <20260805003355.728299-2-skhawaja@google.com>
 <CO1PR11MB483582006360CC4F32F97F838CD32@CO1PR11MB4835.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CO1PR11MB483582006360CC4F32F97F838CD32@CO1PR11MB4835.namprd11.prod.outlook.com>

On Wed, Aug 05, 2026 at 09:34:32AM +0000, Tian, Kevin wrote:
>> From: Samiullah Khawaja <skhawaja@google.com>
>> Sent: Wednesday, August 5, 2026 8:34 AM
>>
>> When userspace closes a VFIO device file descriptor, the vfio driver
>> performs a hardware reset on the PCIe device to ensure it is returned to
>> a clean state. However, if the closed device is an SR-IOV Physical
>> Function (PF), it may have instantiated Virtual Functions (VFs) that are
>> actively bound to host kernel drivers (or other vfio instances).
>>
>> When the PF is hardware-reset via VFIO, it implicitly disrupts SR-IOV
>> operations at the device level. Because this reset happens without notifying
>> the core PCI driver model, the kernel drivers bound to the VFs remain loaded
>> and operate under the assumption that the VF hardware is still functional.
>>
>> This creates a state mismatch between the kernel's view of the hardware
>> and the actual device state. Subsequent attempts by the host OS or bound
>> drivers to interact with the VFs will fail, leading to unexpected
>> errors.
>>
>> Disable SR-IOV on the device prior to issuing the PF reset so that the
>> VFs can teardown and remove at the software level also.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/vfio/pci/vfio_pci_core.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index a113c55845e1..b36c77eb3c40 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -826,6 +826,13 @@ void vfio_pci_core_close_device(struct vfio_device
>> *core_vdev)
>>  #if IS_ENABLED(CONFIG_EEH)
>>  	eeh_dev_release(vdev->pdev);
>>  #endif
>> +
>> +	if (pci_num_vf(vdev->pdev)) {
>> +		device_lock(&vdev->pdev->dev);
>> +		vfio_pci_core_sriov_configure(vdev, 0);
>> +		device_unlock(&vdev->pdev->dev);
>> +	}
>> +
>
>Sashiko reported several locking issues with this change:
>
>https://sashiko.dev/#/patchset/20260805003355.728299-2-skhawaja%40google.com
>
>Actually it is a discouraged usage allowing kernel drivers bound to VFs
>which belongs to a PF owned by vfio userspace.

Thanks for the feedback Kevin.

I sent this as an RFC specifically to discuss the right approach for
resolving this issue before fixing the locking issues that sashiko
raised. I will get back to this once the discussion to fix this the
right way concludes in the other thread.

Thanks,
Sami

