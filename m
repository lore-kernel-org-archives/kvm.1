Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887380;
	b=aoXreivkYyy7Myp2Gsy/uEMEpqImLtUGqoauWlknxVEszT5JAaVIvpbCAKbJr/dh3PD1
	 niIE2LanJqxS+WwpQLL96kLsdQkGOBCuiMQFAfOLMy/HHlheorD7Sh0MOt4J/RhEQjqie
	 FPNWlcdERk9dt33ttuzMnglXd6u9Horm2WlsTcP9xWdfY0+ZhHeeNETDAsW4OE1Q5Ppt/
	 UTLKpmUoa6OSLaGFtyY1HjUHkaT1RZLy/5kj/Zru+WlW36HyhGiMywdYZrULtkmcjr9mq
	 KbeJcoSExpFPeL/2hzLN4xFQWjK2FZW7p00pU2j0PeFxasWt29msByzpGbskYBOdkQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=7rw+Vw2Z3L2B8lNDfsIFSmx/pfSm9WeDfRFG4S2Q0cI=;
	b=F56PaN2EjrHTgH9lBdc7sOd6F5aQ525kY8ImgyQYHDjrtKUpCFpsnwdGfSBF9VaNj9nx
	 qkCbZyintuytuqfdtj+eZ9Lv+zwU/+eEq7NQ2VCtdD0mtRmpmDuwy/CvF8+uTs5fU9ZXB
	 Qi/3cEsEajSgYdON6NwxnUAR0jIArDHgkpCaWMrRxNDq5vMeI89LHZwkeV1MSQHuKI92Z
	 Fy+mP5bSYaT7Nt5vcU7L966mTZbb5C8EEo3z5zGGPawbl8l9PiPLR5hoOqj9vwZ14BSUd
	 TA3v++lce6DDTsPZ2MtrUhgW8VXY0CjcPiswsz0gWu1M0YGpx+2fKxxxYOhC9kJFjqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=wcPW2VeS;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9F606A337
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 14:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98B9F606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=wcPW2VeS
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e3b22e971so998996f8f.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 06:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793887377; x=1794492177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7rw+Vw2Z3L2B8lNDfsIFSmx/pfSm9WeDfRFG4S2Q0cI=;
        b=wcPW2VeSRvODbdYagFsU2XIg0aTXdnhx/kXOwWNbpngwDM/gCfcZrWORghX1FKTjDc
         Mv5N2+vmUnjqQm9dS9NB6DBVam/f0NDbeQqt4+86O0cpG537XPDtso4cmVRWMyArr8PI
         jXiPqpbCMNpRwt04pZ64rNnRkpc1jgKy9F7LZJn034x7mHjW9lWeHDZ8wuGAGcsp9tA6
         fdYaq4RLqyMu+odlklcLb3/vkf+rq5ENmZYu7oz4AZdq4mhjZAN+ODbuapfT9A5hM+9n
         IBsHWEC4PC7xOlWAsj92te775B+ABgmDcVqt7oltV+jbn2ZKpApmiWB2SPL7l15TkecI
         7lpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887377; x=1794492177;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7rw+Vw2Z3L2B8lNDfsIFSmx/pfSm9WeDfRFG4S2Q0cI=;
        b=e++PSUKcRCOtLxFIkDXZylmcyFxulpG9fZlpDutOEndra53/PZrrLYuIr92YQe8tNH
         C0Fkm/v3TD9AIJIvxXR9xJrQiyUkOO5e9Ggr64Y+tEFIBtQNwBGMjCDH4HFx45DqlSUS
         QK8D5U/JZtysuYt7JBYoJ5F4eaAvctDyguG2ohNY3WVnNsdWp32WWhTg1IeLoAdYrANA
         qW/LbKiED17iUkkRfUB0W1bnh+eOjlVGqqzH6FPhE+pIf2RCfxRrqolt8CrUTOD6VX2W
         1OpZWbJKO3H2ymC95PpFCzAdEdTprReMXz3jFGz7WqdY6Tol1P1Iwc2x1918+nYV6XVl
         /1Pg==
X-Forwarded-Encrypted: i=1; AKwUvByF74Wjk1GxLCy/Yx3UZe7c7cMrtEqZxj08xA686n9rFl/XP6oNbH+iVgTdwmZd73xu+Bs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/s62akV8D3OHK4AgUoEUicSxYy1Hl4brgECdwBVFonf4B/1Ztk
	/cTD5+QZw7z11l0fNxk+eqvtCVCwScsbd2AI5sQ6JEGKQhokqpgSdznF+OS95Llo4hzdZhpue69
	EaVRBM8E=
X-Gm-Gg: AYBFou3sFpt1tErqwjjOK6pJxp3n/AFen9czgWfqx6kDffXRJIx/iCrEIWalmfc2OHD
	bEkvlVV4QjoxDDz4oGYswVIKVePDP4K8/zcoUb5fPw5b8OMlc92kMyq4kc2x3DeYEsjV2ifgNx1
	uxfmfU0hBqFCTCMPiUQeRFUFw/Mey0hnlAVHc0AHMF7jxnuAPF/4t6eT/dGU79IFObyzJyw9HGe
	siKnLLa/+YffFi3Tr55ZzeOB06zuxTHb5MXQFe/xDZ8Efq8VeKR/rl0+wERQfmRlBj4yZW0s5Yf
	6A4040bSzWxJPOI+wSgjE2G/9vamPapWrZnjgvyk5NwQ79EhpbOrX2lkMMoxobN/+AJx/qZDujd
	LHws/l5sx0J6OolOrl9oF7swAbxa4+urhs4KLKiQUO6/AnpxNH25iiZ9RGfB9RVgTg2Paz9jpqp
	MkUr26qUnx9EALXPD/14BQW2aZZk0/iIwCKN5we3ABXftZ/A53TU9nUCnIXpOI9m6gcLLvph6YR
	dC9BbKeBmxpmqiVU/kLNq2p3zca3WfcTySxXU2RuMfVjCkO7iRwis24ZS0XN1shqc+rQP/ZuO+R
	oIt/ky98yxD2WD1ishoD5Fuskp9iqYU4UL1ABAM=
X-Received: by 2002:a05:6000:310f:b0:48d:f95e:6e8 with SMTP id ffacd0b85a97d-48e6e2c3586mr39104058f8f.1.1793887376849;
        Thu, 05 Nov 2026 06:02:56 -0800 (PST)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8e29sm10937240f8f.19.2026.11.05.06.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:02:56 -0800 (PST)
Date: Thu, 5 Nov 2026 15:02:52 +0100
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
Message-ID: <auyKhc02JmfXNiMe@FV6GYCPJ69>
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

>
>evidence-get:
>  request:
>    challenge: binary
>
>Binary, blob, raw? Lots of words for the same idea here..

binary is inline field, blob is va/memfd/dmabuf using field. I want to
keep these to "types" of TLV separate.


>
>    objects[]:
>      blob-class: evidence-blob-class
>      format: string
>      representation: evidence-representation
>      data: output-blob
>  reply:
>    object-lengths[]: uint
>    mr-generation?: uint
>
>=======
>
>mr-get:
>  request:
>    id: uint
>  reply:
>    name: string
>    supported-hash-algorithms[]: uint
>
>No definition what these numbers are. They should be TCG2 defined hash
>algorithm constants I guess. Why not have an enum here for them?

it's enum hash_algo - I will make it more explicit including existing
c enums into yaml.


>
>    caps: mr-caps
>    register-index?: uint
>
>So we get a string and a small integer for every MR? Like PCR10 and 10
>for TPM?

Yes. The name is the platform's and the index is the hardware's number,
where it has one. TDX has mrtd without an index and rtmr0-rtmr3 with
0-3. A TPM would have pcr10 and 10.


[..]


>
>=======
>
>mr-extend:
>  request:
>    id: uint
>    values[]:
>      hash-algo: uint
>      data: binary
>  reply:
>    generation: uint
>
>Is this extend 'you give me an exactly sized data that is a hash' or
>'you give me data and I hash it' ?
>
>TPM/etc do both, there are good reasons to have both, and the latter
>is more flexible in supporting crypto agility..

The former. I have a patch in a queue that adds the latter: mr-extend
takes either a digest per bank or the data, as an input blob, which the
kernel hashes with the algorithm of each bank, and the reply returns
the digests the banks were extended by.

