Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090085;
	b=ekhiHZT6t9Tmr5dZxqjh4qEloif1JAAXo1TwpW3Tnl7kVYEBgajzYxR0rGX566FSVWpr
	 r5tSuHfADcc6FvmCqdYjJXI9GKjiO+F+7h+HMJ6uRjln89qSAIkKfaji7IgY70Pod6ZtE
	 wo8edr0LPKsxpO9YgvR2oinUR85nbNxYUlSyfocbO62bcGSEbNkVo9nNZmJsc3TcIVEwv
	 IU4ThUgmPkg/Iu4yu2VUUAEs+HlivLG9T3Izqb2dKi+po8cJo9C4li76UfiRvQ5hGcqmG
	 yDX0BsW60NqjTkIEWKK42LmQyywbDh8/0k4nF9VccBuiCFL1U4dHpuclt9babk4JzUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JBm8ffaCoPQH1JzTyc8e2It/Betu/HEG2/vRVRWiTUw=;
	b=Kn21fl1oB7bqg6j2fEbflRQiWfpEDSJRAQ5VUMcRCuTQGqGZH1120Y2n7NwUlb6IEFSL
	 IKmrJ/2JcVmquSuDDiTBRai34fR026Cs+jcsG0B2qByodI4eOOq5KqPk5gKVK7ZYWwTfo
	 XlQGbXZWm9CEZPNvUmOIiDi7jCwsd2rPRqxwju2vvv9nqnVYl1F23BwXaZfypoIha8Sak
	 GYHTamgiHaTeUfy7eVlgTqqKbKWMKo5xOYo7Y42Q8OrGaSxci5RKtYlP+KnYeIw+t2yah
	 2+E1o9D9sMYbcU+6UKgdfOb+Yq9vB3+vkRiUgWpd+aHmcP/BrLTwfzcNDNrCe6tVizA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=o3vw+R6W;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49333606A31F
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 08:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49333606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=o3vw+R6W
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so26082225e9.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793090082; x=1793694882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JBm8ffaCoPQH1JzTyc8e2It/Betu/HEG2/vRVRWiTUw=;
        b=o3vw+R6WJM/xY5JqumC6/LUb4K4obMv0LWE2BkRABhu2x+bsyUqCR820A7ZCHwkfnC
         Sn/+pQ3m+CYjUbeS9jCMjyJImOaj+z8d/dCOu4EFG3Y1ZhqfTxLIi/tMTL2aAS0KAZjH
         peSCp75+tsY1riFXx52/4tof5ojkSxcnPvRzAH7xQ0h3ImgmU9w0joDiMP/Pi1uMSjFx
         bljGGs0wwgGfu9RqNIdZk/gyQ20assvRY1Gzxql5mzVbAXwP0jDEfcY68G9+Uy9858pf
         CbKr3I6NEEEgEcALs+KrHMjLGmUbg8SPUS8dRewMi3C/7X8PLL31gMcyyHhQAVMuvFwa
         KxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793090082; x=1793694882;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JBm8ffaCoPQH1JzTyc8e2It/Betu/HEG2/vRVRWiTUw=;
        b=E4g0OkpzO99GjYJI/GB9gFZC6o79XAr4TN3uOyHz0YBQ0zmgPBqy0dyBiUXF1jsEJf
         dXm7WMQlbUK9pl1NJ4loLRpahuDcJ+LvO+h+WQPJq+wfN3+yN86fz12kSaK8Uun0kC6u
         g4fIlqigALk3kETcdhmQFv46N/b4RE1jchVUHe3jUDBzoyMxqFTfxPiSCgpR58IhCYq0
         o6inlTbweE35vcdMs/56M1szijV9fNk5FBDGL738PTGwcjnX3oCCstr0MXJy7iUp4zGs
         ePNrNWwRbfLm/xWhDtoMu7rU9Lz2iHQVrkMki6356R/K3/3F1NIXMBAkp/9dTRKaT7ga
         bTfg==
X-Forwarded-Encrypted: i=1; AKwUvBxcMNx3rYpsQwFMAUaWWjPUibmmFJKQyIGVtOE7icszKy9S+lZBtoKxDp6t8adGQNvK7KM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGWgEmyvBCw12vL/QufWkQdOYWqf9zdM2cxjrI+SpuPAfZl227
	mlKqx0RJjBEYnvT9s+Q0VTLDULL/nyKaI9J/87TedzFgtJLqUZHxOA+CzDUj+PdZeQ0=
X-Gm-Gg: AYBFou2wijsJ9i/XkMgJc9GNDAxDuMcfPCzAMceNswU+uBT6YgNT7JK68hiR0fT1R+p
	bmDQWRTWTQhELYa/sLRNOv//WlZ8hK+6MnhWFCT+AucjzsGB351u3HFtELRWUTZeVjip30+z9xj
	UpQUrCFdAudP4Mg0SQ9TJtrcLZR9UTIUA0Gn02UDYjFl/tlAhXdbbhT0SIV3fgdeGHMKwNtm6sq
	Myz3t/uR3SayerlZoSQT5k7EiXVx8vGjjnkmyso/RREKl5J/VWOOOP9DqRJ22kZBR4yBgt3pry6
	aLwFGFgZNu0IFwERtYIYGzUi2bu3dh7fHCUmh4DbuyKAVW7glisKIMgCPsPiVukZVDO2De9+vmI
	+PTVL67NEg4uT+4kzj3uss+yA1x5PLdm+LJ3cuyOhgsupiVkEF0Dfp39UwvyGcqt5+LZ6UZDvi1
	SpV0Azyd6GGMzPUXH+yGdufPzF5jXyTqA46JjKMV74KQoFqGtvmiW49fJFg3J28Mdh8Q3NJsWh/
	4vXjjaqiWVHGDdafvVn7nTTtOUcCl9ZjSEsJ0OXOtAGsCV9U0rIP5ofxngaqEVg
X-Received: by 2002:a05:600c:19d4:b0:4a2:18d4:f9e0 with SMTP id 5b1f17b1804b1-4a35acbbcaamr167523235e9.25.1793090082317;
        Tue, 27 Oct 2026 01:34:42 -0700 (PDT)
Received: from localhost ([128.77.52.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a55e99fsm261457975e9.4.2026.10.27.01.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:34:41 -0700 (PDT)
Date: Tue, 27 Oct 2026 09:34:38 +0100
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
Subject: Re: [PATCH RFC 01/20] ctlv: Add the schema language and generator
Message-ID: <auBhwll-zJAaLXRf@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-2-jiri@resnulli.us>
 <20261020233132.793b7e97@jic23-hlaptop>
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
In-Reply-To: <20261020233132.793b7e97@jic23-hlaptop>

Wed, Oct 21, 2026 at 12:31:32AM +0200, jic23@kernel.org wrote:
>On Thu, 15 Oct 2026 16:50:34 +0200
>Jiri Pirko <jiri@resnulli.us> wrote:
>

[..]

>> +      A named attr set, a whole attr group, or one exact attr as
>> +      "group.attr". There are no tuple selectors and no cross-family
>> +      qualification.
>> +    type: string
>> +    pattern: ^[a-z0-9]+(-[a-z0-9]+)*(\.[a-z0-9]+(-[a-z0-9]+)*)?$
>> +
>> +  selectors:
>> +    oneOf:
>> +      - $ref: '#/$defs/selector'
>> +      - type: array
>> +        minItems: 1
>> +        items:
>> +          $ref: '#/$defs/selector'
>
>My yaml is terrible (and all learnt form reviewing DT bindings which are
>undoubtedly perfect :) but random LLM agrees with me that you can simplify
>this as it's a local definition.  I think doing so makes life a little
>easier for reader by indicating it is thing defined a few lines up.
>
>            $ref: 'selector'
>
>I don't care that much though.

Tried it: $ref is resolved as a URI against the schema's $id, so
'selector' doesn't resolve. '#/$defs/selector' is the shortest form that
works without an extra $id line in every definition, and it is what DT
bindings use, so I'm keeping it.


[..]
