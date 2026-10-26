Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022501;
	b=YkZD8+jeDXysZSI5xNu6ll+ZEQCt2n1O4ccYawBMolagYLzdYh/way8OC2xfv9lCiaks
	 4r0PWvWghnKrJ9QUCow7NHDck5gpv6l7zgUPZDySTTDT2lS5+8xVQoHzwARircb3crT2t
	 pNguuBzChdCwbOdQ78bODKAeWHN6eOET/lz/nfb+peWvpw3EjW4eZkcS5FXd9MPUYv+WS
	 UZ9paqu1+zcezAO2qMy8ZSG4XDi2lIoUpQ+TTUrmDkwJSAaqRO8lwpIH2IRtV7Mkq7n+q
	 EDI02R+R5N73r8S4hcFkYp0I6od0+1NPPPIJFEPTGpOgjyPonJQ5t0aHhwvuBxjkLnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=eeiDIzKBgXHTvIB/FzTge64uqO1p8vq38QKemD1zDpA=;
	b=OavLPYQQOzkcOObJrhIfQdlMTHUDDbir9DgQ4ZImEp5v3KJcTwZb8zcp3jDIGaEJY8Ak
	 CMz1Sl1/qNXYfjgoxOL/QVn9J1ha063lTfGKYi+TJuuDZRVrTmc0637RZth5RXK82JtDh
	 qDjeWG1nKA8in8lU9zEdQZrBU/I2RcHC/EwAb7g2jNKWyVxkh8t6ItHF4OgMIY4tKuoxF
	 bXTqB+FzQHQsI+38aQbcKVmIPJomwq/W9mjJeSS5hgyL3apK7nGOBIcGY/25ggm55vm6K
	 b9bEI6n+aA2+p33gfZRZDszPQNB4ukcdC2fCVbGpOiNmGjb/mkmU5o7geR/be0VUceQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15D606A31D
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 13:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD15D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so13421435e9.2
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793022494; x=1793627294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eeiDIzKBgXHTvIB/FzTge64uqO1p8vq38QKemD1zDpA=;
        b=VM8IYrnCNNqs45DDC5LE9lQowRMEKYE5Y/KZ57bV4yet/aoDBGlAsxJOmTRykOk8dn
         FshcS/W8j64dt0Mh5C8VdYgUtcsCto+ScQaOEpF+I1g+GJr3PKhwYJY8a9G++KZq2rIk
         fciASrl2LvGXd8pYXvHkATr9UTdfoqHxMbXc79S2QEtkqqFElfTeqUk4ffn+ZNgaeGe/
         nm24iy1xia1O5G3DOANrqIMherXJogHmuD48d2u+nc2vCUxcd8XNkN3ljWXSZqr8HlaX
         Y9o5gWTDf6GO67jT9mY+jbYN5IM9+ZXATUXh+KiGk5uTlXn1ZnpDB+tpDMpOFgjZMwAW
         Jg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022494; x=1793627294;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eeiDIzKBgXHTvIB/FzTge64uqO1p8vq38QKemD1zDpA=;
        b=NrOVY3zkN2Ta2JrurBtFQjyt7ZUJVOp2j0Uz4Y0mnLdyZeocYlOAi/TbCVgXU45wol
         CiDATOH6vv7CAlxds8JWQLPItuuI0T+oZJju5NNQPvdVDAraO3wm7iouiRDN6qBQf/wJ
         ByxDjfjYEZ8KTjLReKInfF+vuFkkgTATJ1i0oCRnQ1iLyVW2fLnTmoFTKZhuVTj5SkhS
         Zt/m5XHecEAGiPN63CckAQl4W1P11LdzoKUiF93yaMNZUlOaWh0yAqzaQV4ms/jkT+8j
         gq5NMMc3e4ezqx042QNWT+GmbZFJk+pGOusn48xLis1Kgipr0f9bPmag36I2gKp6srMa
         fzPA==
X-Forwarded-Encrypted: i=1; AKwUvBztt9UX/Fj+/gzRuuVDaGSKjhBZiTwJEqy7swjHhjX35E1bObuRnyIZV2cQ8fT6hSCWzo4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxAF0NI1dQ3e5qjZeKGTcqBQd7YhJl9h62HZt9YR2dkplWsxDA
	9pD9V7LY1vRhM6sl2zPh6qUZryoajL6B0oRbU7rNDK8AJ0PXpZ+bFk/Lg3MsmTg0MxY=
X-Gm-Gg: AYBFou14yjvW+B58VygdZX8TV64h7MU2jlcKz/BdosO7LgxxyTXKO5+KDClYnv24Dsr
	T49X7mS1203mIL2lATNRwQte1byR0n2DJ/U2SbzMMS6brhsCHh1w6RU5y1gCOCFNisLUgR3LlsB
	juiZou3kKo9tx6kJxHrkZHz6lgi/qWdIADCNZ8pHnX9yvCuH/ZF8ERloGBKG+2VS1BsLrI+/qnw
	n30CkXA0rDMibNgE+rzOqPipfKOCEKFgn1eWTlyAU/bDLCVs08x+GDApALsiEeevn1ZwpNJZf9J
	+M5p2Ph8YPm8eyDX+rC+WgTpGxjMkqyOj0XYK8J5gBKq+0gIpmYU23FJVIYGorey3o6lr8bDdIF
	eURyB1UZleFusOsWBv3WToaFm7yl1F/JBjqzCZBaeLhJ0acKVRmX8c7nrI/nQQASvpQgvaSmD8H
	ia0L2HXNyXtAuBudX0e/RqzZ2plQ5Dfh+oH3e6HiYUfsDG5wxN/yTNBRaNgHKmW0Xw40MEwo8DR
	+WW5/bp7525jV2Q+jq/ifVRPEl3sJdvENye9bXO499NkC9Nth4JAp2ApOgbtzMX
X-Received: by 2002:a05:600c:3d8d:b0:4a1:f377:5c75 with SMTP id 5b1f17b1804b1-4a35acc2edbmr104469535e9.33.1793022493724;
        Mon, 26 Oct 2026 06:48:13 -0700 (PDT)
Received: from localhost ([208.127.45.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a5ea0df763sm107133535e9.3.2026.10.26.06.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:48:13 -0700 (PDT)
Date: Mon, 26 Oct 2026 14:48:09 +0100
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
Message-ID: <at9ZEDZl89V0jaJB@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-13-jiri@resnulli.us>
 <20261021022505.6fe1b1bb@jic23-hlaptop>
 <20261022184313.GD3381610@ziepe.ca>
 <attZl_0TNMDLgi4U@FV6GYCPJ69>
 <20261023142633.GF3977851@ziepe.ca>
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
In-Reply-To: <20261023142633.GF3977851@ziepe.ca>

Fri, Oct 23, 2026 at 04:26:33PM +0200, jgg@ziepe.ca wrote:
>On Fri, Oct 23, 2026 at 02:58:33PM +0200, Jiri Pirko wrote:
>> >> Jason did some nice handling in the fwctl stuff for
>> >> device alloc and hand over after device_initialize()
>> >> (I've copied it into a few places recently :)
>> >> 
>> >> I'd like to see something similar here as it made
>> >> it easier to follow lifetimes etc.
>> >
>> >This is really at the wrong layer.. Attestation subsystem is the lead
>> >subsystem, it should be allocating the struct device memory and the
>> >driver should see the typical
>> >
>> >  struct attestation_dev *adev;
>> >
>> >  adev = attestation_alloc()
>> >  [..]
>> >  attestation_register(adev)
>> 
>> Er, the driver would call attestation_create() which will be a wrapper
>> of ctvl_create. The reason is inheritance chain and each parent being
>> passed info to and doing its own init()
>
>We really want it to look like the above so we get proper container_of
>stuff.
>
>struct driver_attestion_dev {
>   struct attestaion_dev adev;
>}
>
>driver_adev = attestaion_alloc(..)
>
>Don't want "create" to allocate the memory, it is upside down. The
>fixed memory ctvl needs should be buried in the attestaion_Dev
>
>struct attestation_dev {
>   struct device dev;    // sysfs dev inside class attestation
>   struct ctlv_XX ctlv;  // ctlv instance
>   struct cdev cdev;
>
>   const struct attestation_ops *ops;
>}
>
>That's the essential skeleton of what a subsystem should look like in
>linux, ctvl shouldn't co-opt it, it should embed like cdev does.
>
>Look at fwctl for reference

Yeah, I understand the typical flow. I just wanted to benefit from the
fact the ctlv has the inheritance chain to reuse it for init/fini flows
alongside the private structures allocations. It saves a lot of
boilerplate code and hides it inside CTLV. I admit, it makes things a
bit obfuscated for end user (driver/subsystem). I'm working on
conversion to what you suggest.
