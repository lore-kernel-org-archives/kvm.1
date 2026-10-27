Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096476;
	b=T7hHk11lMwx/ba+sogZdYeoWGoOBdT3oAnxFCExThVjPZeIY1sGywuZXtLmlciqlNTOU
	 QVbpSGT0dBvOxbsbkjB28Dq790NUXs3mLQDOkwlV6q6FA6x9T9g2AoXL6mM7vqYkk789X
	 vcGGxC/WsrOTn2TsXNgQjT06tiabvuF9gLtWMUl/nvZXNQZnKvS0a8+bBPXd6v7EZTKnR
	 BYESp7TpnH1qAm2OuEtaWrmMbmD2RaoHXrOqa7nGg9nLf6yUVdnWuZ24pYyoOtoQK+9Ru
	 mVhSEkgm0VHnyPH4B7zVB59t3lt2zyT3rrWsjTo7D7OKDLLoHEfIdesMBeWF4yPNcmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=UcwPjZxaDPQUX38SRpQk0U6z694ngHdtvb+qpNBNolI=;
	b=FmNOyD7RJOcTaolRsuS9UKMcYdniN88yAer5UH5bCQVXLymZyK7JlthL01PZUgQa4YEN
	 r0y9s7QU22iw7YkkXAADib6lVuWEZ6A6CY4L1ehQIsrSOfrNpujh2XYkMwKQtkGO/8PNb
	 SMe3/aSYVUdrT/bPukJX4qp+ce2k10riHPtJlMrV39kblGNw1MPSnjB66ny0AS87r5a17
	 drXP3qVzRUNCNx1trZZXbyU3w4u1WDiQ6+RyX/VpQl9WXkKiHu/ry3aBqJvKItb6GjSae
	 QwFaGUvnyCAkrxI8gVwd0hhQIyhvjWycyarJoy3kH6KZVMbsXjrjt3FQNj8r4xt/R3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=U+w+DA7T;
	arc=none smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2039606A31E
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 10:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2039606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=U+w+DA7T
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bfa7c09c9eso2999965e87.2
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793096469; x=1793701269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UcwPjZxaDPQUX38SRpQk0U6z694ngHdtvb+qpNBNolI=;
        b=U+w+DA7TBbOTsHJ6Enxe39JVFHvrncv5jY+jSoyIQ2z35qjZXvHp3LNnblKOrPL29A
         y7RE8O/DkYqgtM6po8VciEwy++8yrr0fF30EYhF2VKGclIBsioakCbCgAaR3HRFnnwZB
         fNYBW+FeTixill9nrDRoI+IpNCTqA55IxLFeHUBlMQlaa8qrSxKDiIACxU0UkJDj8UMh
         lR0on/o9rFsPmneK/FCtabwWiYP65MsxMx5JUTisdHYPgy2j9M05xRVHhql1vdZyRtw4
         WoBKFMRyWdL7bNEs8rMdYK3MSTXgnm/TWIMlL9+E1AX8il/kxYBgNEFH0Q32f/iPJK2Q
         TN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793096469; x=1793701269;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UcwPjZxaDPQUX38SRpQk0U6z694ngHdtvb+qpNBNolI=;
        b=zgHnVtPnlGks3atxdTxeUuUYwLUE5WqahA6auphXahF1Ut5B0DZiMSLpoj7QChyeC5
         TjI9VyAHNI7vtIDDXbQjKmlMbukPmgbtmSWgemlx0vkhntWMoVOtQCC+Jl4x5ERigh6p
         /41McBop2SF6vowAHC9IhfwixWYVMxIcVcoUpaPh+S9JIluXGsXkZEbCeRsUcZ7gHFVD
         BERuFwaJH+/X1UTPyDbjc8DHYafwN2RLtd2PEF3GXkT7Ue/mYTZeOsmT7QozV7NzlBaU
         HpAmXFvMz/Tj1aGz0G0pCFVIoHTGmI7dCvp4YyBSzCoOl5IUZh+sM/PaNHToVolwTyyz
         IwBw==
X-Forwarded-Encrypted: i=1; AKwUvBzBvDpKvA/0MqkoJhpfC4PmDPGgoEEcF4yq0rDz6L3rr4E2x2a0BHsESNPvsSt3nzC/sEQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9jcy4Sk6XKHQVFCy/jKZdej6LppAP8vNIBObXHIf/ewtpV8QS
	+I3Dh6jDHOSNqPk8V2d1PjoD6u6Cd4SCIVoF8xffBZhytRCl0hB6FnX+hRiAgBAwFMk=
X-Gm-Gg: AYBFou3dQyA3q/ZQqzAld44kwOjfX9cZW5fAjK2pG7Cg9jcFFJdDo3OhAYZjo5AXPFJ
	QEctUBY2UOJ4+ithqF7Kimqv+aQl79fDxjaMaCHc7zNOJ8jENilvrpoDcogkzT7jesi+8PA+yCU
	ylhmLDZlc1X6QjxgzFbuWrigzfxGXVqKG+sYUEZdcM2As+m3c6WDK/ihQOJV3LAFz8ZOW+f96Fe
	9QV+3T2uhzaZ8EmCUpRY9T8k7C+t2XffeY5WaCYhX3Of+Voq/zUCMWrByTdltwqdvDh/ZwN4QpR
	xDxO9VTq9Xag3JkPQQczb5VDdqxqzwRj0qlrd5E077VVSR4E4mdgigTXZDc/unG5vGc13/JF/4K
	gwk7kyFIg+DNn7wtvoQeCVGqdi0gDDqAlwP0VP3M8JJJOk4hw8dgubD0lb95tZmzArP2OAxP5ux
	2uwmN90zko/71sYBtKwfXTyaKgPcXDr/961jwrYMVcwg7Jvkd01TbDyzBH8fJcypH2k2s8be02T
	ZOn1cLY98G8vauJyCrMelUUBex2j0gDz/oGZ8MrIZkdSul2d9Ys/dtzWU6Ef++H
X-Received: by 2002:a05:6512:2211:b0:5be:4d37:3bc0 with SMTP id 2adb3069b0e04-5bfb71fe90cmr3245577e87.62.1793096468475;
        Tue, 27 Oct 2026 03:21:08 -0700 (PDT)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a6aca4sm2051901e87.15.2026.10.27.03.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:21:07 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:21:02 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	jgg@ziepe.ca, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 11/20] ctlv: Prepare runtime introspection
Message-ID: <auB61re2C6eN3BmW@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-12-jiri@resnulli.us>
 <179302367452.58760.11808905856343064399.b4-review@b4>
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
In-Reply-To: <179302367452.58760.11808905856343064399.b4-review@b4>

Mon, Oct 26, 2026 at 03:07:54PM +0100, jgg@nvidia.com wrote:
>> [ ... 53 lines skipped ... ]
>> +/* A cursor packs the record and member where fragmentation resumes. */
>> +#define CTLV_INTROSPECTION_MEMBER_SHIFT 48
>> +#define CTLV_INTROSPECTION_RECORD_MASK GENMASK_ULL(CTLV_INTROSPECTION_MEMBER_SHIFT - 1, 0)
>
>Use genmask for everything:
>
> #define CTLV_INTROSPECTION_MEMBER_MASK GENMASK_U64(63, 48)
> #define CTLV_INTROSPECTION_RECORD_MASK GENMASK_U64(47, 0)
>
>	pos->record = FIELD_GET(CTLV_INTROSPECTION_RECORD_MASK, cursor);
>	pos->member = FIELD_GET(CTLV_INTROSPECTION_MEMBER_MASK, cursor);
>
>	return FIELD_PREP(CTLV_INTROSPECTION_RECORD_MASK, pos->record) |
>	       FIELD_PREP(CTLV_INTROSPECTION_MEMBER_MASK, pos->member);
>

Okay.


>> +
>> +struct ctlv_introspection_dump_position {
>> +	u64 record;
>> +	u32 member;
>
>Maybe a comment describing how record and member are encoded for each
>of the users?

Okay.


>
>> [ ... 13 lines skipped ... ]
>> +/* The immutable root-first chain always has generation zero. */
>
>This comment seems out of place, it should be closer to the 0's it
>refers to a function below

Okay.


>
>> +static bool ctlv_introspection_family_record(struct ctlv_cursor *reply, struct ctlv_cursor *entry,
>> +					     const struct ctlv_family *family,
>> +					     struct ctlv_introspection_dump_position *pos)
>> +{
>> +	const struct ctlv_family_schema *schema = family->schema;
>> +
>> +	if (!ctlv_family_entry_start(reply, entry))
>> +		return false;
>

[..]
