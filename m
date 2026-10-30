Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372720;
	b=zBPZwo1Ol0oOyLydakL8ysQzHP6STk00AP6dPlBayu1QGkX/Y1AdEyiO0pMN+2sCACai
	 DAN4uSa418UwqzBvzxqk/2o6rZLDVsdSasRfUNwkW0iyr1ytIiM04b0KmWDw7xV/Lk6fY
	 TG+Rkp3ZvzK1jw76uJxJUp3BfUD/hCoSeEQv0572B7DvVs2yMwd6eTizFbAGrq7pJ33YT
	 gEW+tobKsR8z1YeHUqwzhmQ+eOcewkHJ9Ff32mO0AH6KX4qzMzb3sKBlU20AHn9v5kQgr
	 6Q+Nd0lAqEDuQgqrWV7OzXvjECfJPLvJgTrE0M3KDJJtZplMtzwUf/Akm+W/S5yP+xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8skhpE8x/+Won6i3+XD12raNMCS4xOoCCKoDLeKTESk=;
	b=arbqO9EKQgKtGdG7Hmh17pZK7+Fvd3WFn7PxvMQ9tw7tvXxv5/bVzdbX5fNeZv9WbEv7
	 t1JZwo9oENAGseVTGpISU7FQkLBj22hQ0SvdLQrD7rL79Y8JNS5l8b42F0901gghL+EE3
	 4BeyGwxewGhjq7o/lcu9kJfIFJxBd+W30VYnF+h2dkpVDeDTWSYeNubgvKrWZT00LzC4M
	 nbWOh3l5IPDaTp2Qmx2wpKrLFQ/3BRQiaivy9SWlu+umHwb5KxrlNuVjFT4MUvEKP0dCg
	 JQoPRiZG2jN/Uq+lzerAOfYssBEnoyDCrRLM1JeQFu+6n+PoiNRHlbbXorZf8ayjx0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=czkACChM;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E448E606A31E
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 15:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E448E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=czkACChM
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e3b22e971so418275f8f.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793372717; x=1793977517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8skhpE8x/+Won6i3+XD12raNMCS4xOoCCKoDLeKTESk=;
        b=czkACChM1Vp//qoKfk5C/DvEMQvaO2yxTtnTnNrUz1iZrGkpmjYA7sRpCOkiK85OR5
         DKyVNu3yHScYnpTV8mEyNjy0GM6AiGkEY+yqMV2kwhj4nogM5hBtnMNrDyDvhJfUP91Y
         2qLHj18b3y+ItwylHnK3AxAJpQcnWODG8q5TOy1izMOxysmu/gE3PBKDvsyiMMeYHPdN
         L37BWcbW4GBGw63knHhhcjI2CyLf8W45aZwoP+DUdcfn7pfklTtyoTc13Ps5EzD68ze2
         PhwKJwRPpHLlcw1quPe3gfGrKyhVNOtKuxcCOGPE+MqRlL4wQREaJw+p9SN5GR4rJNeH
         4qQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793372717; x=1793977517;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8skhpE8x/+Won6i3+XD12raNMCS4xOoCCKoDLeKTESk=;
        b=viFGQiuXxn5wqlIYQou7+KQXdFq3fY3mV5cd++5NEgNPBsNvA9UmOiH03bY6DE3kgD
         Uvv/bTABKUP/C5uCMhilMNYJrBFIOQ+TRaFG/aojWyI8I3mbgJfFUN2Bdem/c61nhSKI
         XgSjTqEgLWwhnHXzW9Anw0rLgkCB+rClqSE+WEqE7UufOygIMq9CxtWCG/fA+2Q+TMKx
         qHnBXQRteDxOh5vrPihPkBxxmUrQY3XBU0qwj8xh9yry2wb4juWLewvQR1uaLhMS7wYv
         wAeZBxyHpN9Oo2SIJxmRM66lrSLvsBA0SVK1oEkSP4brXfRNs8orFIpYhIOQDuoaiHYL
         rxAw==
X-Forwarded-Encrypted: i=1; AKwUvBz9kHQAcNze4+wfOAbNusDBbptmNkSmB30dQu1rmVpoW8eCUjcduhpjsIYnQcLoRvMHYAw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUDm8qH5Rany+xqnYyHpI+JZHcVPWYXUwYWUs6ZHuU4zbrqslS
	xhXe2NtFfGO4Fgxh4DutR7gjw4IbPEO9+7vExcp9UbyKADE070yb4gsQFZFpoi7Pji07QtPo3uj
	bVL6jbQHyUQ==
X-Gm-Gg: AYBFou3kLQI1W/u6/yV0VVQxwIFNqSwmWT0gPkOjub731o+BXk+1rd4nheRqBiLxHMC
	ZImvZNreHEhJ4D5cxXNUQXJDWpI5/BEUtHbcxqjiJkgsSwakuvsm8ImMx9mB0wn49fvcej4pNMu
	igRFtDcCEmSjPX2WK5g4t58hRS/xVyWWK7HiUfaoMH65eFTOMdIQM4/rcVbABiqOUI8HNf1mngA
	lRgioASHCKb9fXvBNCVzuluY8X3GId+Eyg3CKfBCDSpefcA4a5pShGT78jkxjSYrklMOI4OHlc/
	OE96kmo0FGCdthVahQbMCoEl0TFoRxYfCL4waDzVZXqm/hFEmAR7wZIyYwC00AV8GXvFUWlKV9m
	0OwXlTBcFDZJWUTDtG86SFe4DNvbsS5kPZ4XfQ81by5GeQAT/mmHAXymgPNAflvdq5aJiF9idn/
	ciyiJHpzWKB88bbkv1i9aGU9VkHdOq5Ap+OJHUBIkp6oczXLOkJFGNJhL4p7NXSMy3sHIn4/qq6
	RVX3t34Z3df1eJ6BheO1tPXqt25gPRLWY9r/UVsx8GJYZy8m2/5OAOMctL/zhSgQ9cpOaUGvvEw
	bUPXuAJ1ndVmFFE2L3Tk6XRNcPuXcPT3SjGEsD6z
X-Received: by 2002:a5d:4ec6:0:b0:48c:7143:610c with SMTP id ffacd0b85a97d-48e6e3091c8mr5024505f8f.36.1793372717264;
        Fri, 30 Oct 2026 08:05:17 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b77f06sm3716923f8f.21.2026.10.30.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:05:16 -0700 (PDT)
Date: Fri, 30 Oct 2026 16:05:13 +0100
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
Subject: Re: [PATCH RFC 14/20] attestation: Add the base family specification
 and generated files
Message-ID: <auSxxPM5z8BzgNm3@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-15-jiri@resnulli.us>
 <179302367452.58760.3782556786585774917.b4-review@b4>
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
In-Reply-To: <179302367452.58760.3782556786585774917.b4-review@b4>

Mon, Oct 26, 2026 at 03:07:54PM +0100, jgg@nvidia.com wrote:

[..]

>> +
>> +/* attrs of group cap */
>> +#define _CTLV_ATTESTATION_ATTR_CAP(_attr) \
>> +	_CTLV_ATTESTATION_ATTR(CTLV_ATTESTATION_GROUP_CAP, _CTLV_ATTESTATION_ATTR_CAP_##_attr)
>> +
>> +enum _ctlv_attestation_attr_cap {
>> +	_CTLV_ATTESTATION_ATTR_CAP_EVIDENCE = 1,
>> +	_CTLV_ATTESTATION_ATTR_CAP_MR,
>> +	_CTLV_ATTESTATION_ATTR_CAP_MIN_CHALLENGE_LENGTH,
>> +	_CTLV_ATTESTATION_ATTR_CAP_MAX_CHALLENGE_LENGTH,
>> +	_CTLV_ATTESTATION_ATTR_CAP_MAX_TOTAL_OUTPUT_LENGTH,
>> +	_CTLV_ATTESTATION_ATTR_CAP_MR_FLAGS,
>> +	_CTLV_ATTESTATION_ATTR_CAP_OBJECT,
>> +	_CTLV_ATTESTATION_ATTR_CAP_BLOB_CLASS,
>> +	_CTLV_ATTESTATION_ATTR_CAP_FORMAT,
>> +	_CTLV_ATTESTATION_ATTR_CAP_REPRESENTATION,
>> +	_CTLV_ATTESTATION_ATTR_CAP_MAX_LENGTH,
>> +};
>> +
>> +#define CTLV_ATTESTATION_ATTR_CAP_EVIDENCE _CTLV_ATTESTATION_ATTR_CAP(EVIDENCE)
>
>I feel like there are too many layers here for a code generator..
>
>enum ctvl_attestation_attributes {
>   CTLV_ATTESTATION_ATTR_CAP_EVIDENCE = CTLV_ATTR(CTLV_FAMILY_ATTESTATION, 2, 1),
>}
>
>Do the intermediate constants add anything?

True. I originally had it like you suggest, I changed to enums to avoid
the explicit numbers. But you are right, does not add anything.
Changed back.
