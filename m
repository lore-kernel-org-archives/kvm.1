Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451987;
	b=S705ws6Sy4fQhmZoizpVl0aApwf+Ro0/W3D2p8pig3SEqEzG7+hVwBkAQSzavXO8/R/M
	 86Sl2aqKzq+T39PIVHU5eM0UAax1NnVjMoz/8adnTtAVCmMZxSPzyqUXvC1jKKySf9ei9
	 55YP6mv8OYd0Flq5Lanf3y9RR2bIIiqzg4jjcauXNr2fO2KJeF5Qsdj1taqDaUKCvn4cs
	 8LoQeFzYy4AwKH2oziFsNXGrvqJHlOs/SyT61uj9pBIHJPuO+KF8zPanwKgmWC4TECTwP
	 xRq7IQDH/RtA9GV+oJNHtCpd0SfFuWy5hNxBlpn0poxqm0VLCJcysr+5kq8xfn1xOow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=drjpTP74JsK51H7vM836NsoylzVlZy0Ll0P6+YE0Z3w=;
	b=PPOsfm4Wbw4IoUwNbIIMXjFtzS/WEoYlfyD9paxWVZpYwDFZsYmJ5fcz0XDsOyd8S0N/
	 /2LtTN3TSB049tgBwJUetm+Y8ksa9nHjinHC+txcHBz+cQPx1z3+tr4N4o374OfThbwpl
	 3BLvpYXUSFdr7qGDKv+TTMa548Qjvx9mTasNlEozCVxPUQoySASaD25EU+mUBMVEnq9+y
	 QesIPN94hhilj4ddPn6oEh39bLIA6oQ2sRpG8dfBBZG0LWbZe0UHAmvq/sqkMaoSxq7Qy
	 kDSS8JCEugOjlVRcYN/Cmceg5PVz4Kph+JkDHpM9gQN7WnkkmJ4+68PKm9a5A9L8SEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Pk287flK;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44188606A31A
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 16:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44188606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Pk287flK
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-94999a08973so342197285a.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 08:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795451986; x=1796056786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=drjpTP74JsK51H7vM836NsoylzVlZy0Ll0P6+YE0Z3w=;
        b=Pk287flKeUpMzT30Tk4PiXFTtmgYx4jHqmEYgOL9o36wUcu4F2TvvxlyEjdXGbCJVM
         UQmJDcUxqlb2Gld0laIitE5lyA4808cjZFXhmtshggC6EytBIrtYp5Uw8HrMOiG36RTD
         rrSNxT561EtPhrsoP1GGArJsn5MOLvRQXqihGmpl3uyaUdG/ZbT+azp0IBn+M9pCf4VB
         A9DsO9hfbFQeNMHdXgTmdw5x96McAhjOi9pB3Tinn/oypFhZy3271XnkSfec0f/Sp5Ri
         QArZ09V+zNkjNXGBnhJloywnAWgz4asG0l/cbGJDxAB0RUx4Dn5AUF6GqoAD/GP3h9Ff
         9gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795451986; x=1796056786;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drjpTP74JsK51H7vM836NsoylzVlZy0Ll0P6+YE0Z3w=;
        b=jbYeXqRV/lZFXl1sWOG71crCxz114NrZN0KqdAnuwTZRR0RjBRmu5bMZXGWmWvtHNy
         wWs27x7lpaH0/fuXsqYun4NyftMb4Uww4rz3V/bwCjsZzFS7hIKY4tGlBTEpMFk9aygs
         iFXK8R3mzr+F6dJEIZuMA/3dlO0jmQbUB52uCi6UCfxXKBajzVwWiD8tabd2BrZ5eGKq
         fypFn9/Ikx0nkV/PqBgS+GU6PrKnSqY7nPZemHKZG5V/7dI63fZQsHt6U3Hh+XPetZBU
         r8VeaBODtF2lAMV47BFWkevQRZrU/nFNYp/tIZFlkleZc8XkLCgh+0DTc/REfD0xSJqc
         /EzA==
X-Forwarded-Encrypted: i=1; AL+hErGGGOYI7GuC0EGseMU7SVuusZRmFtf48Ig0uC70iJ6nb+CVmweLhdvkxtkl/ipdUd4pOns=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GWf+MO4nLSwPmP4VzGaIv66wuCUVSGLxsw2FJguDFYKMWzh4f
	PIoxSh4198oexgpL7lbgpm85fBTmCA7WtJr7OfDIyHVxMCCVGsnHK4kdHcN4k8imJMk=
X-Gm-Gg: AZFdTZejAorzw8qfGUjqh0CqAY7mDLgqBVoR0KeNl5xd8jNerb/J0dsdJeOO2DKqKGX
	/YWyeQjWtVRTI5n9Stkr4qJRSKNGwxyJjr47ayHhz2A3MB6gJjx6eQLBxl5xWvB2LNB9wHYw7WP
	ysR6gIcJ9Jbh2VnNqkynsvlC9kfMp7uswNj48TDufM9NpTgIgJdX61r6UHa1VAO7VM4gydnEwiS
	eVqDR6WlL4+UamDH4ruSdvE95vAX5y9ho7dcm4zL6DbnJglhWIBcZ7g/lOwrAMJK4PT0czWsNfa
	yIOBgh/OZA/W85Ahkm2sRINumLmpgYpaZb0mVpw5MXC+J8/Cg/flEAwEoigoOr4DRr7pKe+nloD
	bhS5ywZEE4nZk8jwmJhmOsaXrnuwT5+7mL377P0pJfB3Z23EpGujB+os8R/5KQM3KkIf/sGZ3Aj
	dmZPdFNooRM3sCj0RMi6d2FpwI5CVROU/JHi5+ylD2mqRs0CVRXcDJ2M7XUKRy8zvnFkPCXFc7W
	9y7z8Q1SNsbxb337jmLkeFdvp0hkGDI9TzQ9a3fVv0YuoFNIYNI1sf+z3q6SW1wgZLWkPpLpXdH
	typ6f/wC4plyT6qShbPxFw+DncXSWI1Lii2zYjFY2J2SAEQGQZ0b+hJN1Qo2jJ4l3qle0NMlXW3
	33/y87krXjlMPSz9wugPtP0yA
X-Received: by 2002:a05:620a:4403:b0:947:7f9b:f839 with SMTP id af79cd13be357-949ba9bf10emr2106812185a.47.1795451986121;
        Mon, 23 Nov 2026 08:39:46 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb424fa6sm828689585a.40.2026.11.23.08.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:39:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVX4y-00000000vk5-44Yr;
	Mon, 23 Nov 2026 12:39:44 -0400
Date: Mon, 23 Nov 2026 12:39:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 00/10] PCI/TSM: Support guest TSM drivers
Message-ID: <20261123163944.GK179082@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <2026112325-emit-squeezing-5d96@gregkh>
 <20261123090623.GK14811@unreal>
 <yq5a7bi3riha.fsf@kernel.org>
 <20261123115803.GN14811@unreal>
 <yq5awlq3pto0.fsf@kernel.org>
 <20261123135638.GO14811@unreal>
 <20261123152533.GE179082@ziepe.ca>
 <yq5aik1n4iz3.fsf@kernel.org>
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
In-Reply-To: <yq5aik1n4iz3.fsf@kernel.org>

On Mon, Nov 23, 2026 at 09:51:04PM +0530, Aneesh Kumar K.V wrote:
> index 429e39f647cf9..01d7877d0b571 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -604,6 +604,8 @@ struct device_physical_location {
>   *		ancestor device.
>   * @DEV_FLAG_OFFLINE_DISABLED: If set, the device is permanently online.
>   * @DEV_FLAG_OFFLINE: Set after successful invocation of bus type's .offline().
> + * @DEV_FLAG_DMA_CC_PRIVATE: The device is able to access private (encrypted)
> + *		memory, no shared memory bouncing is required from the DMA API.
>   * @DEV_FLAG_COUNT: Number of defined struct_device_flags.
>   */
>  enum struct_device_flags {
> @@ -617,6 +619,7 @@ enum struct_device_flags {
>  	DEV_FLAG_OF_NODE_REUSED = 7,
>  	DEV_FLAG_OFFLINE_DISABLED = 8,
>  	DEV_FLAG_OFFLINE = 9,
> +	DEV_FLAG_DMA_CC_PRIVATE = 10,
>  
>  	DEV_FLAG_COUNT
>  };
> 
> ...
> 
> +void dma_set_cc_private(struct device *dev, bool private)
> +{
> +	dev_assign_dma_cc_private(dev, private);
> +}
> 
> This could easily replace device_cc_accept()/device_cc_accepted() used
> in this series. I can switch to it if that's the direction we want to
> take.

I would prefer to settle this with Nicolin's series that is part of
the point of it since it brings a real user and a justification..

So if you can confirm there than it does enough of what PCI needs that
the PCI additional is incremental then great.

Jason
