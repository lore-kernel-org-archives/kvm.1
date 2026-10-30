Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353215;
	b=XjxmZJXUk7zCaXeBEaCyC5NeV1XFwZ3EsYu2O6TzFqiwkSiUfKZtM/Kv5d6w6v7CQkFw
	 bP4uBHnqB78GTTJQz6YQrx8lbnlCTpSdrSlMCgYUm72iBzwnijqVasFS31SiVCY4T9CkG
	 ekZ9CEH1wj7i2CMt4ef5emsS/UigUi+Ql/fCuWkCYE1yjXil5jofp0LM5LlcID8yWwcee
	 PmJQHiDeonXJMVFtIbLVTcBwF6VGoycadHvL96N0f4u1WsiMYE7FtqYWENu9RlOwKFJwQ
	 fafId8IecanC/tP5HxG/cZWdxD/C5PhNpmJ+VJHcsrklNUPGJp3aReH+88deU2PxX+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=La278T1NrCS4XO98Q/cTkbnnx/6adToIXrUcsW5BqDY=;
	b=0yDMpgSzuI/jGGaw7jAtHa6yo6xGhyJ85yrJ2MTnRsjOEcnAh1xVSt3U3YzoWVojg6KZ
	 MAdgfHsHTPRXKMSsAf3fsOWb6rjKoC1H6vW+V8YVnvL97dN6/HZ7OT3ezUoRIYpIZaK8g
	 XIOFBMUuFej3TdRsuCa3ca40RN9VaWJJ+aTWwxzB/C2AQJlqhEr+mjtrFXevgAk/x0gpu
	 lKPxPRFKdNEn+oJxwK2d+5/Hchfvh/Dd+Vx0xpnSwSNxxIuV3yMVB5bghDx+0ukdemxHr
	 TDaYiNwnKptKcTE5leY1YQzyDWzzf1ytryxOQE2IB7GTVxcpYqWHCKSUmEPqzOFwXaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	arc=none smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F1606A327
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 09:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B13F1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ba328513b9so528703e87.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793353213; x=1793958013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=La278T1NrCS4XO98Q/cTkbnnx/6adToIXrUcsW5BqDY=;
        b=Kv4m9vJR6R9/MCQPr8oImYroO5YLgSVS0DYGIvONwSH5eZkPBnkxNVp6UbPLFqhzJa
         mHwnam4KotFiiw2rxYegY1kWtGQiTINkwVf+f0Y+u2QzIsLuF3DneFaKE20yzTnkJvUL
         70+rwPeuEdD8KBv3DlclPXB2VFwYGOM9bVM++la8LT/SMXM8wnof4b6Sr9VGEuhyM5qi
         DH8zSsN+nlr7X7dPGz8SzGu1UlqoriuFXy1G9JxtzUCbp+ogvr7v5xumXPOz5NJ/Vd0Y
         /RvkMRt3ErRcgH7pb13vlNxMeCRHTiaIzHOaKj6JlTsxLzPyaWS/IEGF7NiBV8mjUXk9
         vdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353213; x=1793958013;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=La278T1NrCS4XO98Q/cTkbnnx/6adToIXrUcsW5BqDY=;
        b=FFVnNZj85f/LvmGcxxl9M9BCc2Jo3Tvy7YrIFodsBO3P5jg36o9N4WBhIW3LwUD/dd
         JdYdpXDL7+IgfxE37tie/XgepqYvmdgR/7Dy8uKsOIomSXqcChrsstTtzuR3r5MMrwEj
         Mo1xwxSrZRabgTNMr2XNHKUTkOqc2Sc1Vwu2SL48HjTe/C7m8Pis3aF1HooQql3dxZzW
         XEQFxC8nj+fHdpabBCBRF2x2mctQfXNWmDfNlvMoVYsGYPdgqX4m8FqRS3OIBme13GDG
         e/h2uwROepoCQR3SyzSEFlSU1YIwfUHfd37w9e9qnjMCyoD2q8H2Xp/A0sH7902J5S72
         oNZA==
X-Forwarded-Encrypted: i=1; AKwUvBy8Ze2pPmqf77XOB2+ZlOEmJutixT9OHZXTFvFZPCZm+p7bo9LjDm66F2y65UZFFIxR7Zw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJg9Op0bOW058hMVOSd4UlSHId+3PK8X9e7yqxtNsKuyY0Y+1eF
	MWAUojG5xizpyjesdAjpFyh/Hfv4GJOKYL2jRozsBtPZMwXfy2el8aO/cT7PpSucSoY=
X-Gm-Gg: AYBFou15b0PnOmjJRBIZHjCb6/qG2qhuCfGF7QJ6HzWSViBa3m5ZaREyouA5JFW/OUx
	ogGN6su8x+OK5ozFn0tvNQ5b4LwGlUZukABDAB86dSuxFSiUV8KFi1pTpvZRFQwDp98LyRsa5LE
	tQEVFeuDls4KGnGAs3xBt43n0WdQ6SfPYUrSLMH9fQji13gt9bD9O0xdkEJhEehZ4L6g6AQSkSa
	BFQqmICcDCULLgYUK2RL/K2OHUSkbJngLU+9PPu5/CtBqjXgfYx3Wnz27fCE85b43zjtW3DCJFs
	c7Mg6wKA2z8HJ6+w7hzdRZAF7J7LVR5vgHP3ZEx8eu0+dI/wMyZeEWKTR6F+ifx/Wbi4PF8T6Dl
	/j5BouxHC90NvwUgKeNphGn8oh5uT0ROE+emwtf+SHxrJyUcsFlZt63LWThae7+IYbsRygBbHkE
	Mt1FDsX3KAhdqVaTXNx5OUdo5szmpYDTHIRRcdmIZEFVBVq+tj7PF9/9gQOhIH/gDrK1jMMcJGy
	zHRoVg0KrZ+n9P2VRozYtLV6uPnuF77hDyOiBvzCjXH1vmaEsXjYqDs8nn++/AikwG0k6CsOiWB
	sxtil/9CDjUOcp2E49eV8yD2ad1Cf8xfn1XUwQ==
X-Received: by 2002:a05:6512:668b:20b0:5bf:da1f:c390 with SMTP id 2adb3069b0e04-5bfda1fc9c2mr262942e87.36.1793353212517;
        Fri, 30 Oct 2026 02:40:12 -0700 (PDT)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfdc08ea60sm221364e87.33.2026.10.30.02.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:40:10 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:40:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, rodrigo.vivi@intel.com, 
	cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 11/20] ctlv: Prepare runtime introspection
Message-ID: <auRl4VzVljAQ1Suy@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-12-jiri@resnulli.us>
 <179302367452.58760.11808905856343064399.b4-review@b4>
 <at9nsxtGOl3N5PJR@FV6GYCPJ69>
 <20261026161220.GA1671235@nvidia.com>
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
In-Reply-To: <20261026161220.GA1671235@nvidia.com>

Mon, Oct 26, 2026 at 05:12:20PM +0100, jgg@nvidia.com wrote:
>On Mon, Oct 26, 2026 at 03:52:30PM +0100, Jiri Pirko wrote:
>> >device-get:
>> >  request: {}
>> >  reply:
>> >    caps:
>> >      evidence?:
>> >        min-challenge-length: uint
>> >        max-challenge-length: uint
>> >        max-total-output-length: uint
>> >        objects[]:
>> >          blob-class: evidence-blob-class
>> >          format: string
>> >          representation: evidence-representation
>> >          max-length: uint
>> >      mr?:
>> >        mr-flags: mr-device-caps
>> >    info:
>> >      $extend: device-info
>> >
>> >So.. how about could we drop the sets, use a direct description of the
>> >layout and do something else for the ID numbering? Maybe the numbering
>> >can be solved directly by only listing the names in:
>> 
>> I didn't want to have a lot of duplications. Netlink show us that the
>> same attr, or attr group (or nest) is often used in multiple ops. It is
>> not good to repeat them each time (multiple obvious reasons), so I came
>> with the sets and groups. But I will think about how to make this
>> possible to be formatted in more readable way.
>
>If a "record" is re-used in multiple places, then sure, put it in one
>spot, not disagreeing with that.
>
>That can still work out with a clearer top down flow, more like C:
>
>records:
>   evidence-object:
>          blob-class: evidence-blob-class
>          format: string
>          representation: evidence-representation
>          max-length: uint
>
>ops:
>  device-get:
>    reply:
>      caps:
>       evidence?:
>	 objects[]: record evidence-object
>
>Jason

Okay, I like it.

