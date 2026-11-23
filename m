Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448110;
	b=c799Ae3wWpCGjmfRQcDYLb4gZyA7jyl3enYSnWfuvWG0LG+Z6d2ubCjRNTs6i4n6jzWS
	 Bvk77QwI5cZ0N16iRIh8E0qUad+0mM5lJWu3KXN9MhTFTROlkaoT6U4pvGxUqu4jlcorX
	 OuRpEiBD9ma2xJAxUuyReymUN0Uqr1qITuE3kVPfMGPr++kO/CvatNtrU+U8PTiXw7eyq
	 dkKpOsnfs/Y1K8PQXUZIm27sDStALhRxxiKpAApvLFkn2DKcWnaORLVk3THgppof9eXw5
	 LhBGhRl2jubjRgbanxcLkzCf7Xo8K2NBVxokEBdZGydPGA0Ek5dDWbnEdApNo9x/q5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jVozDBZgp+27gMR99l+UaMITrh6vU8pxKuFZh102SrU=;
	b=vGqI2S6gTJhka0+hUaljjuVduUfMoOScAUMzQwvHzW9IR5+q32Y1Lj17aKlIqup7+X2J
	 S0/yBMIvBMQD4D85Ll1MitQrAkNG5ojSuTJupT0RCcPBx2lG0sAXBxVVj/ZMGxqkfHZAI
	 +bQiySR2dhuQs+ngv7cYfWzPsCc7q2RyLd/gZVLECRqqPOp/0X8QgoxBUvvqGBZgO8vX0
	 L7jAqi7KijOAgeBWekaI0CZWfRDC63Ik3M4HI3rYUyZuISc+Wirfq+tnRgmlfmavmHMQy
	 6SLT6WyxzvPH/9KFRwKkcn51uni/2x02VuRSbMHfx0CVXthVil6WNlS72AlTpTQuO7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=E7fzHGXy;
	arc=none smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B865606A331
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 15:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B865606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=E7fzHGXy
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-98301b325c4so821851241.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 07:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795448109; x=1796052909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jVozDBZgp+27gMR99l+UaMITrh6vU8pxKuFZh102SrU=;
        b=E7fzHGXyqQHyaWH5h7Xdq7Fk7oF+GetICIiSFtZybwSIU8tOsJ7Nm9s209ex5I3yka
         eJPASN/N8bgwyXhR7UtesH8MDUTuVQjtajdXRJbOopshCSKsCcEMtaWdmFeY4c4uw8E7
         LN7OGePjrbqQxAnrITu0+L44cy+/QRsKNwlu2B8atxNpyv4+klJs9H/NgkeA60MnXd9f
         m5009TltosQB1uZx/ZqKs8tYNaa4yH4hdc06E7R3V/kiVxsvZMlxfQZDvvTz3yvuiuTN
         0PiaWcMU9ofUMII6MRxjTaFTfpFeeTJLbuFfoRMFUlAISoaimk/wB+D3Pr/Ry8TsPter
         ozaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448109; x=1796052909;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jVozDBZgp+27gMR99l+UaMITrh6vU8pxKuFZh102SrU=;
        b=PibcbuDd3bmZusCCJuiwVw4PhlF7ZdRxjrwu5yjABx8xky9pCm2lPT5sXOfidrG0WR
         HMB9qfYtDmV/A9DJfLPNyJY6qvTcJcI3KQ3Y+WaiCcf4vgYcSwr74YJOuYjcUuDuReVT
         3K4F0yw4XMqlWxpUC0i6fxZr1+IQBXS9nFx8OL8kHE7Oz6/oUDDg6mMZreCziPN7tAPY
         YKOZ445eMg5visbb++H7AX00YbT2t8X+L2+BsQ9+gQphZdaihSTt6NOXVpwXUVJdpu8N
         YJU1S0aWp87PypY+umtlkVCUo1bi34ctpdpaWNArg0DhwmnabRyn16b878pvKR6+OZze
         vLiQ==
X-Forwarded-Encrypted: i=1; AL+hErHbsGqU/VQpqrwnTlxihOPeAi1iMtZtuunH3Iy5B/If5SBw9BTs96VQA/4CfPhfAcUvpfA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9n3NO5QwG69X9Ex+BiASSfrstZGvp+f2JQ2FWFPWZY6FSHIiDc
	F3AZ7E3I9P7yjpgfLDsRLqug5Tn9coWkPk3cIlcYj82oTVTUPzgxJkp+2aEFMIkAxaI=
X-Gm-Gg: AZFdTZch04+peB41WJWUbxyHSmp4U3H+UF56gjwZGo8zDmZrppmV21fDhHzrBdv//9p
	GDr9OHyH6Gc9J0e092r7W9Wgc/5lTnfedA1bLZs3eBovWaPJ00VmMVebYGEXc0m5aDUDJ5b2I2v
	/6DMm/H7q3TC2+GuA91iGXu1lKm9RC7w44UnBq/XG2io163/xrActXYoHC/2FknTEpP4WZOAxPb
	AwKwa9LmMkEuvIlkSKzBqzMpKfBQopHjR8SmkH2MsYVYF26yJAPdl6HGETWT0cXbpZrvuevIiww
	Y1jZA+Ke9X49DFT4vsPVFWf2yZBJ8jQLx6xTR8KWhVtdXzKRkxAiCvfRrb9bAjW0ddWSnM2U44k
	7Ys+R6X11AVxae8P8YDOV6erBu37bOFRlqWTfEGf2ix4bI2nws8gA+qyjPfF5c/vYr61VHvaQwd
	a6D0QvjnqCnLpxMHKWQRTDllUuk1oUqQwqFOL23K4K13usifH6Ae15OCM94mlDuLL05NAuKv9R8
	c2ad6Gpw3HNqark+jSaX6UZEmBazSU3DcJ9qVd6e/gA3ozosFzPhb3Qvv7QXIfAipWa3zlX+jil
	preNtWU2OeCfMkGUH/S9+F2y27ELJDYX7E01BHftxJI360Ppdk9mBe0rijW+fNY8WcN9jbdwyAv
	jwfw=
X-Received: by 2002:a05:6102:5811:b0:7d2:76af:fcce with SMTP id ada2fe7eead31-7d7393c88e2mr5087905137.9.1795448108741;
        Mon, 23 Nov 2026 07:35:08 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb0315f4sm823500485a.3.2026.11.23.07.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:35:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVW4R-00000000swq-2uP1;
	Mon, 23 Nov 2026 11:35:07 -0400
Date: Mon, 23 Nov 2026 11:35:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 05/10] PCI/TSM: Add association locking helpers for
 evidence acceptance
Message-ID: <20261123153507.GH179082@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-6-aneesh.kumar@kernel.org>
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
In-Reply-To: <20261123083337.2731019-6-aneesh.kumar@kernel.org>

On Mon, Nov 23, 2026 at 02:03:32PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Later attestation patches let userspace finish device setup through
> evidence-accept after host sysfs connect or guest sysfs lock returns.
> Those commands use a saved struct pci_tsm and must prevent disconnect or
> guest unlock from changing pci_dev::tsm or freeing the saved structure
> while setup is in progress.
> 
> Add pci_tsm_trylock_association() to acquire pci_tsm_rwsem for write and
> check that pci_dev::tsm still points to the saved structure. For a TSM
> implementing devsec_ops, first take device::mutex to prevent driver
> attachment during MMIO validation and device acceptance. This matches
> the device-mutex-before-rwsem order used by PCI DMA preparation.

This doesn't seem the API I'd expect here.

When we trigger SPDM session start AKA lock through the CTLV it needs
to capture some kind of 'session cookie' for this locked that ties
back to whatever the TSM is using to prevent a hostile host from
locking/unlocking while we are working.

That cookie should be held in the attestation driver and when we get
to acceptance it should be presented to confirm that nothing has been
tampered with.

It is a further reason why we can't have lock under sysfs control.

It should be attestation that provides a general purpose lock that
serializes all attestation operations including lock/unlock so we
don't need a TSM lock like this.

The driver should rely on that lock and use its internal mechanism to
process the cookie.

Jason
