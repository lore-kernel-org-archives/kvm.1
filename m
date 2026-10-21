Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792589026;
	b=Ul1XDA7kImsSwpK7my7lfrCeaD/pG1axl/AQH8fH+VwZwh9cFFcpxvpfy2j/YixBq8yS
	 jUjdaZwE0TrEV7x0AZ0HUj0RD9Y2YeRYGaEakaf+uPPajn6jFan604Qw+Qrdhoe5EFVLH
	 nlBgnDILvFr8Dv1EmLk2M0DqFc4bTFXD64tt9eOgjDxxUWG/wew/2l8bcgkw0OsBMZGP1
	 DXS0aAxAJewGw4cY549g+pX7rrnvbduAL8QxwOQA9e1CqHFyDebMjQk8gM31ueXhpGAZw
	 G2C9BcqvODwCI7af7v9CJJ2Rs8YgndVFUAfL42Nm1yMGbnlwiC1o0zoqiM6FSRSkkJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ENEgiLYyZC1rCnAzeRub371bt2VgRo0VClTgBaXb9SQ=;
	b=V4I+TP+HmCNcJzctPqXSw06nnKMYbkmfX3J+uez4bTuM2dVfUrh/d66CuUoHw+ob1hCT
	 QC7R3HPkWodqTPoFRI5Nd4zqB7k12QhAimdw1Sk+GClWh4WE0VSlG6CrNVjuQKHKdCk7V
	 ayPcZmcieVvcxQzPxgY9dglIOtRMmn1zRolCKhlG3bZTx9B3HEU8APZ3ZylmqyKUSHsOs
	 ABifCB1w1HvlvYXighyq4groy+0cR/IjK90MtVHJ8RLBxExPzFZLMga/F2WSxa0wlg4sK
	 5/kvCVvm2XPIxovnbri7/9NvwhBO6ph+CLF9bQbINPEaOrl4wu4Lz9WWKY9Lx0ftE1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=yADG1ECr;
	arc=none smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F62606A31A
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 13:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97F62606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=yADG1ECr
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5ba357a1929so736986e87.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1792589023; x=1793193823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ENEgiLYyZC1rCnAzeRub371bt2VgRo0VClTgBaXb9SQ=;
        b=yADG1ECr+QObb1QB83+iidmbJj/fobUApZuVsn1YngJx0ZfuONZA+pu4Ic4qUtnpBh
         GkC63lm5wjgFfb5gMxmSAQ1T2MEC4rYKyNJBBZCRDvoNFfdc/1dnbPoawHNFeIMG3cQ1
         dwQhoE+vIJAk+03yuCz00MdNPuLCfWEByg6Xqf6mtFZQHE4dGhAcSwxre3Khenao61eM
         S/YfPRVj5VyHZarKAEdvN1f5q0N5RbEvEKVfa6CCJfAqWlGEaFei/xSUvauLvApvz3jM
         2mJS5acP+BCEntRYDraaf909OwUFD6CronNRivnX9dfLAoUcbHGmy9cQS/fpdfcJEuVV
         IBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792589023; x=1793193823;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENEgiLYyZC1rCnAzeRub371bt2VgRo0VClTgBaXb9SQ=;
        b=M6nPJbseO64DYHFNXDjH4hBeto/nrjkGSZngGJpe6N9dgcYO/gZqvNIbgvVNencvCz
         srPJVpiCK5TCiVueTqb+EVOUtBN53mUCQ2ZtLhgs2M8xTohe0tipXKQtg9aIZYc5kMcT
         ikj/vmaXOkUlPS5gOVUzuI1pMa5FDsvap+V1mG4TtfoiOdFIho4m0+JfiqoeGpL8Orp/
         jPhOfcalMBId0jkS2R4Z2dAvzNJgEaCJ6Mo9EGbie2dg/7l7GWDBu9FIMjw49SBp5mTu
         IRl4oUnY1Ww64tmyCJDHKZbx/RcyHkCTk4qPG7LtJmkyYl+NcGG7adtVIL8WeqEqAZnn
         KVZg==
X-Forwarded-Encrypted: i=1; AKwUvBzNoRC/l1ypKHNUc7w/zYnjHzzkCTd9K0zw6EhwBRsCKMGCxmWarwBltQdpyYQTgCImges=@vger.kernel.org
X-Gm-Message-State: AFq9FYLO16Jahgzlf6W0VUyQaLDMGNkpHG1al9B8pGzdkLuwpfFStGsr
	Q+6PVI4s4CpWWWjgboyySPsgGbLRMCjFsIJH6z05grXzTHI8SNLg6fRP+x2qLbMnOAc=
X-Gm-Gg: AYBFou3nlOm1ox9MBzB0aXEhrhq6q4INC6pPPK85NwXkc981tGxkcUoGGJ8YL/6V+CX
	PXkp/d6MzQz8yay/Z1Eye+L/7KscRUIZ6jBL4MgCh1pTxdm6OduNC2tUmCQTSV5Nsxxj6xDfAGB
	8lzwtQbeF4PZW1xvTur5rwfc1r/p/IlEjcPZLFR8cMV7iVZv4bX70ElECNLS30nbnkRMmjZOMdo
	tTvapvMA7Cw+9+2972xazLHkENJDc3/Y+ExhKEfslPLu7BlnDnBJzwsyrwIBOVgASHdVI9Z7NZ6
	W/oHYtakKjH8xJ1g8/mRr6KS2c+Hr5xfkDi6FHNT0wjj2+j5a+LP3Q2dabGESlHstDJjCAA9qTI
	/svtvQ1HSVthhtlP2W/Rd1vou5y6dWMunKL6M+3hLqHGUhKVQqeVuwm7ijXh/F0pLZn5tykEz2e
	qRWT2WjA8Ra1dLY/tDXTSAy87mCidAQRZtoaBtCCRWfAvFaVtufxOnzqsQjimkNb/LiNCHu3WRT
	7xlLfAor7pcTisNhg97UgWrfPmMLfwSys6pVy0jMvtUueZ5qCRO2s5pOOJLsAW9Kbg=
X-Received: by 2002:a05:6512:3c8e:b0:5be:55b6:7a92 with SMTP id 2adb3069b0e04-5bfa1c2d635mr792386e87.30.1792589022381;
        Wed, 21 Oct 2026 06:23:42 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac4a4f5f04sm2718501fa.32.2026.10.21.06.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:23:41 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:23:38 +0200
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
Message-ID: <ati8DWgQb23dV4Dv@FV6GYCPJ69>
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
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Define the YAML schema and append-only family registry. Add ctlvgen to
>> validate specifications and emit kernel and UAPI outputs.
>> 
>> Assisted-by: Cursor: GPT-5.6 Sol
>> Assisted-by: Cursor: Claude Opus 5.5
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
>Obviously you asked for broad structural review and this isn't that. I'm terrible
>at reading code for just the big picture but feel free to ignore the small stuff
>in this reply.
>
>My python being even worse than my yaml I'll only say that
>part looked plausible to me!
>
>> diff --git a/Documentation/ctlv/ctlv-schema.yaml b/Documentation/ctlv/ctlv-schema.yaml
>> new file mode 100644
>> index 000000000000..38fd56e6627c
>> --- /dev/null
>> +++ b/Documentation/ctlv/ctlv-schema.yaml
>> @@ -0,0 +1,359 @@
>> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://kernel.org/schemas/ctlv/ctlv-schema.yaml#
>> +$schema: https://json-schema.org/draft-07/schema
>> +
>> +# The syntax gate for a CTLV family specification: permitted keys, their shapes
>> +# and the closed sets of keywords. Anything needing more than one declaration at
>> +# a time is checked by tools/ctlv/ctlvgen/lib/semantics.py.
>> +
>> +$defs:
>> +  name:
>> +    description: Kebab-case identifier. A dot is reserved for selectors.
>> +    type: string
>> +    pattern: ^[a-z0-9]+(-[a-z0-9]+)*$
>> +
>> +  family-name:
>> +    description: Name carried by family discovery.
>> +    allOf:
>> +      - $ref: '#/$defs/name'
>> +      - maxLength: 63
>> +
>> +  selector:
>> +    description: |
>
>Really trivial but nice to drop | where it doesn't make sense to
>force line break preservation like here. 

Okay

>
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

Okay

>
>> +
>> +  uint:
>> +    type: integer
>> +    minimum: 0
>> +    maximum: 4294967295
>> +
>> +  integer-bound:
>> +    type: integer
>> +    minimum: -9223372036854775808
>> +    maximum: 18446744073709551615
>> +
>> +  max-occurrences:
>> +    description: |
>> +      A finite positive count, or unlimited, which is reachable only from
>> +      query replies.
>> +    oneOf:
>> +      - type: integer
>> +        minimum: 1
>> +        maximum: 4294967295
>> +      - const: unlimited
>> +
>> +  unit:
>> +    description: CTLV-owned unit, matching enum ctlv_unit.
>> +    enum: [ seconds, hertz, bytes, celsius ]
>
>These are used in here?  I'm sure some are but guessing not
>all of them yet.

Nope. I just want these to be part of the initial schema as it is not
omitted by later family implementation by accident. Easy to pick up by
AI assistents I believe.


>
>
>> +  attr:
>> +    description: |
>> +      One attr declaration. Exactly one primary form out of type, enum,
>> +      flags, attrs and blob must be present. optional-attrs and recursive
>> +      may only accompany attrs.
>
>Maybe worth the yaml gynastics needed to enforce this rather than
>just putting it in the description?  An LLM fed me something when
>I sanity checked how bad it would be and it's only somewhat nasty...
>
>Bunch of:
> oneOf:
>      - required: [ type ]
>        not: { anyOf: [ { required: [ enum ] }, { required: [ flags ] }, { required: [ attrs ] }, 	{ required: [ blob ] } ] }
>
>lines, though I thought there was a more compact way to do it.

Okay, will try.


>
>
>> +    type: object
>> +    required: [ name ]
>> +    additionalProperties: false
>> +    properties:
>> +      name:
>> +        $ref: '#/$defs/name'
>> +      type:
>> +        description: |
>> +          Primitive payload. Integers are always 64-bit, and a bool is one
>> +          byte holding zero or one.
>> +        enum: [ uint, sint, bool, string, binary ]
>> +      enum:
>> +        description: Name of an enum definition; implies an unsigned payload.
>> +        $ref: '#/$defs/name'
>> +      flags:
>> +        description: Name of a flags definition; implies an unsigned payload.
>> +        $ref: '#/$defs/name'
>> +      attrs:
>> +        description: Nested payload, given as selectors.
>> +        $ref: '#/$defs/selectors'
>> +      optional-attrs:
>> +        description: Further nested payload whose placements are optional.
>> +        $ref: '#/$defs/selectors'
>> +      recursive:
>> +        description: |
>> +          The nested payload is one attr set that may contain this attr
>> +          again, describing a structure of any depth. Only a query reply can
>> +          hold one, since such a nest has no maximum length.
>> +        const: true
>> +      blob:
>> +        $ref: '#/$defs/blob'
>> +      min:
>> +        description: Inclusive minimum of an integer payload.
>> +        $ref: '#/$defs/integer-bound'
>> +      max:
>> +        description: Inclusive maximum of an integer payload.
>> +        $ref: '#/$defs/integer-bound'
>> +      length:
>> +        description: Exact payload length of a binary attr.
>> +        $ref: '#/$defs/uint'
>> +      min-length:
>> +        description: |
>> +          Minimum payload length, excluding the terminator of a string.
>> +        $ref: '#/$defs/uint'
>> +      max-length:
>> +        description: |
>> +          Maximum payload length, excluding the terminator of a string.
>> +        $ref: '#/$defs/uint'
>> +      unit:
>> +        $ref: '#/$defs/unit'
>> +      scale:
>> +        description: Decimal exponent applied to the payload.
>> +        type: integer
>> +        minimum: -128
>> +        maximum: 127
>> +      max-occurrences:
>> +        $ref: '#/$defs/max-occurrences'
>> +
