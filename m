Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882155;
	b=xIoDfZZs895WsOLPhqWWOgKLQr4wg4RkX28bHBRQgKzVDkTDELOzYMaiFMYrxbcNh+tD
	 bvOmzqxXRDgADjHEDp2Mw8tRobUl9WXFmcV2kmPJdXb3nf3XeBcmg+3zfTFlWBzfQgPUt
	 onoPEZDom7PdIwoVf/RjatF71RklgKMMJLwG2+e0i+bJbQgI37ii891dp7z2EVEk3rLQX
	 C6A38Qwa6b7i0hyl6m2YG7rRuMHhxBLNgH9EapDByCE88rEo3QDzx+oU56DDdDmLaeNFh
	 r9D6FBoe373bpXZm8UA3O+q0BDuomjuEeKr7TJrj7exP1+gJXoptH9hmdQXTbKmRtbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=viyDdmvwD4U6PS8lafjWT8pU3blZXU6a4uhU+bJMb8s=;
	b=qpt1Fvqxq2hFBI3Bp6JS55uj/lvchQcJrTFB5xWuzVZWKLoEOvAobURnMeQod7c2v3qB
	 ffGkUGo+TikTEISkOkdYv88lLdKGK2HL/APAxQb4nO4dldlwhf7LZIbykyhoTDjt4GBI3
	 xx5lENLc91TuXgodGm5Ax6aqjQGl2SoEqSJ8R+PZzr1dM20dbicLHwkpEQ6cpoOunakUx
	 Yu5NX/3NcZwGsyyP69aFbMq2e8OYI4bQCVbabxhI16XUtDAVWxhmsId5ZZV7ageXGoBB6
	 Ub89ukvSQKDUAiiDjW5dGxc+qE9ymfEKXOAjeJJX3iImTEYQIKJfeZNiPrCtZ8vB5hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=khwmS6IO;
	arc=none smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F7606D802
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 12:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 391F7606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=khwmS6IO
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be4fea434bso574094e87.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 04:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793882152; x=1794486952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=viyDdmvwD4U6PS8lafjWT8pU3blZXU6a4uhU+bJMb8s=;
        b=khwmS6IOV7BeOJk5vVOoYILP+8pKH+tWxdl1OMSJ1HVjmXymvCR1SMmwyMCayrilGQ
         IkaDwmalX3igSVne7d0QxuHYEmsMWB9o58OQuOIW8Lle7U+0s7hL2mD97+iQyAkH9BYp
         tN0eybs7YdFMJn8p9exyLKqur9hS/ju8pGGG1eatouTCJQDvUc4Q/VH0vvROLQUdD9Hg
         Oe4z503BqA7YRx3a+Z25EfVok0cDuqAC6EFoA6Ye5xzHvUGaWr2t1fs6uWtO7uYHAb6T
         WA5OTuxtVTyYZtf/7Ecvzco9bmsdxZowRUk88/RyY48V+FNfbBM7tq/8E/TH2g2jROpE
         RgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793882152; x=1794486952;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=viyDdmvwD4U6PS8lafjWT8pU3blZXU6a4uhU+bJMb8s=;
        b=OxM5/Jckr+8mXU9uDyEf4Gr6T/zLMubsRKA6DmyEP7LNxfjY5vwCiqybQe9n+v2Ssq
         UliuKwp4dFA097Av+MXoISUnXpjoIw8iu3XhTRjvrwU6HbDFPRQ6lvMaW+12Airqt0ji
         bVzOT61BGF0ZpB6lbnt6EXd4375VSsmWmiid4s49vETeq9MUZB/4dUFnqDG05ofzIMJn
         ebCH/vHldSpwNdXDAhvS0LDMA5Kg2Uq137B6jNVNU/Ksgep0PWZ5ua5QSCQ6JfKptLk9
         EVFLB8hwGYOKt8JZPrZ18uN0WPqTXCj3V4bT44gZIEv/oVKqnHDNGnLgvsQvK9o1Cejn
         Tc6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzoKgTqRXkzRgUi6PTOm70TXMG0TtzbffEmM4FdXV3Tn4PhkdGitEYXB8LiGdOIW2ACwL0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HFzWXQZ85TEqZ0yyD58KNoD1Plpjwr/jNBssiCeURqQ5yLF1C
	E7ZA/SgOo/CBOdEwTItK6npgLCfNID9Jtw6FXAaxdIbQqdA0yPn6iy/HTGrTNg6pdGw=
X-Gm-Gg: AYBFou0GwYvjuGbkSyszA6rfLAXGc4m+ty60ZFpihHS/WX18kyVU5PW6+eqDWsh40WX
	rMOpzCLJFZbhREQbAt8auCmUReV1a/9elSPr7KRpwZmVz5hZSQe1P+J7sLcSWl+7uY6S7DWLiYj
	nsSjNI+Dp8jP/AoyXFa2B91R0jZ27r+lYcCu8Zst40uBG+pdxRRRmEEkH2+o59GL9nnxJgEcLo/
	ubMg6oCeeDsAmqD5Bibuv08PVdXTg9AM479jQ4DiE18FMZQDUlnA0zN2EObdFLD95z7McBeRe2M
	14lB2+0q2aPyCJJxlL+8iujvexYO4nFH+EsfcpjXHHcXJd9GucCsJCjo7eOmF/ilPTFqPKnNSX8
	euKTXOiCOBa7/qxL8gWYYadJtU313ZKR0AiE4cTX6+FFnAzNpl6vNRGGlJRj2QJ7idkxTD8OFlo
	enIzTEiMuaMBbxi3x3hART6miX3ah+NF8JWwmp2+tLYmCvGDoxLiF9iCj3gIx2jEZ7qDPt4Hb/6
	mTsQ7fz3+EDRlpaK1wssNBG/lT8CFeusa11fLEVaFcC3cMs7XWvTk5zMW0mOb2kzMu8B1qt61ra
	tuVe+GCkCI0/edoFWCEahQQcDTtODTfALnYd0Ug=
X-Received: by 2002:a05:6512:2342:b0:5bf:d738:a5a9 with SMTP id 2adb3069b0e04-5bffa1653b7mr666170e87.22.1793882152273;
        Thu, 05 Nov 2026 04:35:52 -0800 (PST)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bff38ab878sm806136e87.21.2026.11.05.04.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:35:50 -0800 (PST)
Date: Thu, 5 Nov 2026 13:35:46 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, rodrigo.vivi@intel.com, 
	cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 14/20] attestation: Add the base family specification
 and generated files
Message-ID: <aux4F5Fj1VjSwUb-@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-15-jiri@resnulli.us>
 <179302367452.58760.3782556786585774917.b4-review@b4>
 <auSxxPM5z8BzgNm3@FV6GYCPJ69>
 <20261104175436.GZ3889730@ziepe.ca>
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
In-Reply-To: <20261104175436.GZ3889730@ziepe.ca>

Wed, Nov 04, 2026 at 06:54:36PM +0100, jgg@ziepe.ca wrote:
>On Fri, Oct 30, 2026 at 04:05:13PM +0100, Jiri Pirko wrote:
>> Mon, Oct 26, 2026 at 03:07:54PM +0100, jgg@nvidia.com wrote:
>> 
>> [..]
>> 
>> >> +
>> >> +/* attrs of group cap */
>> >> +#define _CTLV_ATTESTATION_ATTR_CAP(_attr) \
>> >> +	_CTLV_ATTESTATION_ATTR(CTLV_ATTESTATION_GROUP_CAP, _CTLV_ATTESTATION_ATTR_CAP_##_attr)
>> >> +
>> >> +enum _ctlv_attestation_attr_cap {
>> >> +	_CTLV_ATTESTATION_ATTR_CAP_EVIDENCE = 1,
>> >> +	_CTLV_ATTESTATION_ATTR_CAP_MR,
>> >> +	_CTLV_ATTESTATION_ATTR_CAP_MIN_CHALLENGE_LENGTH,
>> >> +	_CTLV_ATTESTATION_ATTR_CAP_MAX_CHALLENGE_LENGTH,
>> >> +	_CTLV_ATTESTATION_ATTR_CAP_MAX_TOTAL_OUTPUT_LENGTH,
>> >> +	_CTLV_ATTESTATION_ATTR_CAP_MR_FLAGS,
>> >> +	_CTLV_ATTESTATION_ATTR_CAP_OBJECT,
>> >> +	_CTLV_ATTESTATION_ATTR_CAP_BLOB_CLASS,
>> >> +	_CTLV_ATTESTATION_ATTR_CAP_FORMAT,
>> >> +	_CTLV_ATTESTATION_ATTR_CAP_REPRESENTATION,
>> >> +	_CTLV_ATTESTATION_ATTR_CAP_MAX_LENGTH,
>> >> +};
>> >> +
>> >> +#define CTLV_ATTESTATION_ATTR_CAP_EVIDENCE _CTLV_ATTESTATION_ATTR_CAP(EVIDENCE)
>> >
>> >I feel like there are too many layers here for a code generator..
>> >
>> >enum ctvl_attestation_attributes {
>> >   CTLV_ATTESTATION_ATTR_CAP_EVIDENCE = CTLV_ATTR(CTLV_FAMILY_ATTESTATION, 2, 1),
>> >}
>> >
>> >Do the intermediate constants add anything?
>> 
>> True. I originally had it like you suggest, I changed to enums to avoid
>> the explicit numbers. But you are right, does not add anything.
>> Changed back.
>
>I was also thinking that having the explicit numbers makes it more
>robust if someone does backport. We should try to have everything
>explicitly numbered in these generated files to prevent subtle errors
>like that.

Okay.
