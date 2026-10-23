Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760163;
	b=qI7ytnYWJBpzwSiQEaLz1Y13BzZ+N+YEUwC2x1FUS/cZE3GlMWvh4Fgv4Y6jWuRmUX3l
	 fx6SfKf7YMWDMZxPo7aAc0fVJ/fpB9jCtTOLTvU8aulK/eg0uNA4ib/MpO0Xv4nd50B46
	 do8C5QTk+0UcAQURuzrR5Id+e3g4kuqqkSxXkZtNvPyNw5wKLmX2cS4PyDfES+qLFbfd1
	 f81AUeOerOX6eDzfGBvvwwsoDBI9a82pBfOgB7cSqnCDAKX0XVa0Y6Rd6xF+iLALYf1BL
	 0ElRoAoQ4sPyNbj3MSPcrLtnFqZdB0cl0UIsQenjIRYXpVzQzgF/8/YLvG4lUjO/h0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4u5HTj0vYNkfyVy/ejdHIe5/AhW56e/aHgAn7wANgbM=;
	b=3k9DCCNiibY0La8JoWEi5l06zwt9//kDyotPrVA99nWzmda9DPLiGbcHBmN20xwF1ZnK
	 /qcNSDzzV+tO/6JxozaN8dGvd/LCVtmia6YnladYTH9ssi4J3oaEfxBrwfnN3VON2y2Bo
	 u5nIG7JDCVk5Iu6p7nCkaqEUKC0XbZ9Y4KheAOWfuJZlIh/z8DZDcC4V/EO0eCoyaDI/5
	 RilmpJaiGq4bxkylesI4rUT+uQIbRNvcbzZfnsHsNzn/XsdX1iFkNtXcHJc8bAELeCvWo
	 tPiz+fE9HmfprNNrd2h6mt/SECT6IocmrTFQU5VUOh57W1EdxI6cgjzhz7/9lf00uFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=m68+nKSR;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99525606A31A
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 12:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99525606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=m68+nKSR
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1fe9efc0eso9339205e9.2
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1792760161; x=1793364961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4u5HTj0vYNkfyVy/ejdHIe5/AhW56e/aHgAn7wANgbM=;
        b=m68+nKSR5BhjusJh/Qoc0nFyichGbcMpyaSKaNJGTP3rKdZ4Rjh5t6O40bNzgjsQJ7
         3ehrVsQhBMk8TpcHGvYxIVuxL6Ze31YASaTg7nasj/RW94kOhYVH3HMatmav1PWnD6ro
         hrnxuD+1NWOJaivSj8CsP4FSc6Yqtc3QVKWRjK8boPOVkf0vQXAjVum2TMSwmA0EI2YK
         Bn0wEYZ+diJ8DmIbUBKI+rmeQ5CMY/a+JhcwneYZfX1B0op3gTVSsQCCMm2tBMykQ56d
         x/TFWrZUzyXQegTGLG/MoakhVwcu3bSwlv/on6PDudlwXA/4Au3qwbz6mtfx38vXN42l
         OLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792760161; x=1793364961;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4u5HTj0vYNkfyVy/ejdHIe5/AhW56e/aHgAn7wANgbM=;
        b=zSfdFtbJZ2t8+PTfBfkwn7extR+vzzT8sEchFqmuiTwg6qdUrqf0lbTjQreSRfYe05
         mG7q/SkEiDS/p90lfVVJ3podAUtuhMmA6aNxYbvY7IZRp6DVVIX+lY0cPuQFdYCjTQPu
         Th9ga3KKR+735R8/Vw3o3EZiFTih1hvGRxM/ibGvfErb5/XwtREMvKXnIpIAq2hoaJQ2
         uMgSU8B6xvM1pt7z4t5QSwU5xBCU1SfUsqpUjo/5223iBnkvqdqP/kcllbAQixHAp19i
         fyRY+sagz/XShZGSAduVWlzrisAs67IcVlnbDhc+T9YhFND8Rzvc95hj/cLyukA44LhG
         aM1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzRolEqVKV586Yj5ZTOO+AfPdaxszGv+pP6b1CcZ7FTNEEcHmbB2zonknpxqOyEa3dnEjU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBfaVS1iplMSijabyfnKN4uqLidk2rPy2sKgYcZ1kYslrWzvPf
	+QLGQu1x05Y6XeNFNr8CqaPzAhTTk0xVgt+dO+0+FkC52lMD4yXONqeST9PcLLxDAco=
X-Gm-Gg: AYBFou1XcffWxMTDeyzxHr++l93aKflpCvwyJlAfb8eLqRsGo8sL+8MzJw4fPNrFexc
	IFHCQn1wz3W2TZghm6aZ4yTUfXPB8Pz6DZLM7RMD6oYY++okauDvzzMTqEZ/7hI2n90gA0Iyi7h
	5GMQPdUwTUIsphzdwg8eNwad56gg/SHpdJvFGdL5Nh6Z1XA/qjNLirfV2mJcWm97o04XpPvOhFo
	P//u3RfBj9ufTLn0nmtf7Tab8yT9z/QNV6nBSPswfunZbdahF2XXXdMD5T0Wk6sqtE3jy6mu0Qy
	8LTSxrJ6OimIDJQ3vEjTigDQltQNvucqQmq5+QNXboOJb1JYT1AFifzdzHFL/G89SVWfxs2zXlg
	HNp2cb8P0CL6Pa+hfE27wyHlzG+YE/q/ntxnFp5XZGfzdOLpjZ+q0p+9pT9Z8KbT8lrWYXCp5pz
	iBAGrxO6LvnNu2jOo0FtVuITxF5WilGUEkcwbZJ1my4rNipsX0MmCDAjygrQS2h/QWSYhs8g78p
	3QAXgGpK8lp+vx4NxZOaSiKy1Fr6i1pipkdBZ8Q+fw4MAHXSx8nXk5zp99Zt2odbg==
X-Received: by 2002:a05:600c:354b:b0:4a1:97c6:d2e8 with SMTP id 5b1f17b1804b1-4a211ef95e3mr38623785e9.32.1792760160732;
        Fri, 23 Oct 2026 05:56:00 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a29cd9d232sm3594475e9.4.2026.10.23.05.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 05:56:00 -0700 (PDT)
Date: Fri, 23 Oct 2026 14:55:56 +0200
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
Subject: Re: [PATCH RFC 05/20] ctlv: Prepare message input handling
Message-ID: <attZPPNPIgF-DH4r@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-6-jiri@resnulli.us>
 <20261021014324.58376589@jic23-hlaptop>
 <20261022183942.GC3381610@ziepe.ca>
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
In-Reply-To: <20261022183942.GC3381610@ziepe.ca>

Thu, Oct 22, 2026 at 08:39:42PM +0200, jgg@ziepe.ca wrote:
>On Wed, Oct 21, 2026 at 01:43:24AM +0100, Jonathan Cameron wrote:
>
>> > +bool ctlv_message_input_rebind(struct ctlv_cursor *nest, const struct ctlv_schema_tree *tree,
>> > +			       u32 node)
>> > +{
>> > +	const struct ctlv_message_input_scope *bound_scope;
>> > +	const struct ctlv_message_input_nest *indexed;
>> > +	u32 i;
>> > +
>> > +	if (WARN_ON_ONCE(!nest->attr || !nest->msg || !nest->msg->index))
>> > +		return false;
>> > +	if (!ctlv_message_nest_index_ok(nest))
>> > +		return false;
>> > +	bound_scope = &nest->msg->index->scopes[nest->index_nest_scope];
>> > +	indexed = &nest->msg->index->nests[bound_scope->nest];
>> > +	for (i = 0; i < indexed->scopes_count; i++) {
>> 
>> 	for (u32 i = 0; ...
>
>Is that allowed now?

Yeah it is! You live in the past, same as I do obviously :)
