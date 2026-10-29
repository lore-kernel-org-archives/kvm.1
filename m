Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268474;
	b=Y3H3WxPvo6sMwcQtz0qt1ngLRtXeZFYsZwDAUi7pNUkXB+/4v1D88kHhXyIf/JFB55/U
	 rtiF6JypVKjtANThM+xOMZfSHbkOvJ96PYeY55VtAPLONxGieSm+2EV5zeF0WIHU5hKpz
	 GVVWnZIABSc4jT186G/n1vxKWiEI+8xvsRmRmx0BXp7qsmGf98cECn4m7dX7iZiH44fIY
	 1LcHC4zLSF3DBkMaD7287rdiVZbudkh9IWUYG43/gzDXRL2yTSa3UTnA2sUsxWHMRkxvS
	 0vBvkJl92BuyY7V332IbP/trh1uP5hjFVVzjH6e5hHWvb+KSsehQ7r2H9AYIgTLO+tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=wgroa5qxrEZgRV1TzlPeAteJauIXp9n4MbPCfUIQ4C8=;
	b=PMUTJO8RrZdvFZ1tWt1CQC7auM0dqBa1pvWibEcs5yngH8UaJC84xIUDwxsYLrh3NpTL
	 SBhf0Pa5SSobAaB03skt3YcFhLXdY0ao3ZouU6m7YNe9qSDvPZkldeekeZTwc7kyO4DEh
	 qFtO/K029f147dmzEGpDrJ0FJb4pT5BKRSN665pCim+COh1E17ZqnN2FuUM/88wMwBW+P
	 uP+BsH2rZGtYbXrWhlaPKBbCGsv3GJ+yarbAFxGGC5vA7tPS2Mo6Nq1PpT7XXtUvjAVax
	 K3rVXcNXE+nh1DN6Z7ih5IB9VcfQg6ds5CL+EDbqgne0AmDGiH/c7CzTRGj3NeYPdvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b="MCGV9df/";
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF3606A31E
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 10:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFBF3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=MCGV9df/
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4326803b54so136718766b.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 03:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793268472; x=1793873272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wgroa5qxrEZgRV1TzlPeAteJauIXp9n4MbPCfUIQ4C8=;
        b=MCGV9df/7k4ajBlFLNzpnpiyVP554R79li/56qz4JFgvKSV4eMPHTSDzDtiO+v0OXG
         amQcqEYKMIKb06gnn3dwytNvTkYChDHgYHuD1GcIs6YsflunLHI2CEtw25RALpdQtNDn
         5Se6m2V7pofQQZhstlbmMVyRNnXfrt8FDQidCK2DCySntXp3eXIjMIwGd3GBhkoA+M+R
         o/hwUoFTvZnV2wRrJeYXyGpoR6GETTnHQqYkHF1me+YT7LsyP8KIuGgUQ5bQ0SaQ8CmY
         I+L4iyO5i6YI0hE+HABSCmQHgKTuOcQH2FfxU2YTP2MUN3qxImSYhWmC5V41uQuPOFab
         nvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268472; x=1793873272;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wgroa5qxrEZgRV1TzlPeAteJauIXp9n4MbPCfUIQ4C8=;
        b=d3XDoHSnb8C0jFFPQqm9Qpcd5lsB7jyBdzaL7H+VRGAoc6Y8dcqvCAe1UlfalsJJq0
         h/3acU6UbGkqr+oc12YVe/aYXsYkFI7JwEtvjy5+jhiGK7CQyRf1eGk2OWZPmColu6dq
         V4BY41w/giM1hr+yf+cejK6RWpf/D7csl+GPgJcQZjkiHtIDIVTcgXnlwAIOpozg2mLd
         B2akvTL0VLqSSBMlQz+TyqHql/92cMxiN6ENKlMVFKVFWc2oGDxFg18DuuEBQplsXoMM
         lcQS4mF4LNuPMFuZHoUdTbyiCfkBnn0ZN7UOxjl0wktg/BViXcVgPBE9AgHSRQoXpkzc
         ao+A==
X-Forwarded-Encrypted: i=1; AKwUvBwpq8/r/q0L2O0famPZK/sKFciIFhVm2CtfltrQWxL+dgKGDyzohdZ6qR4CyJurFaKIBXo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHLhHzotv5B7V+3UI4lgBsotZwI8IbhS87sdLNbo4lloNHF/qK
	DRpmdJxgBuOHNj5Wh20mXdPn4xf2y2RAxerkafbhuQ0BbFKYcQaXrYf+vzVw6GSKzg0=
X-Gm-Gg: AYBFou2dcruzhujeHNzGpouAZovg83nRGjHydFGVCpH1GQWwGJQg0aWAQ+YxWHO8x4S
	gcU/Kx8leJWnoHm4USUmJGYB0pwxU7iTJL2W6+Gvqjv0kB6X/35jyiE4Z9XfR9h3NH+bGe3XiyO
	O2cUlrAuL07dQp/6MPqycyk3DCvgUKjIG3mp2POtJd5/AX21vDWWSQemfT6p5GDuns6huxL6HF0
	WyqekZLq3mFMmU9JEO5Vvmrmje01dKExzLxzUxIvaeM+ZOQluNxDTXksEOariQJDQwnDlzIu03v
	J406hhhdLmzenVmJisgapXY4lb5Yo7hK7WPaZ8ic766pgJm+TxHyHlc2otezx6Z2ay6r7wNztMg
	NCQqqZdW8lY2rrBJQkajoIKsAubhNKcBGR51q0IYMK71o+ARltC+WTgldhABlLFg/p1/dUAI26q
	6lVBe4dDT3g4EUCrwghPJ2ubCAjd1HOHrRSS2HtEA0TfHSrJdAJDEhLS8MweDD+a788njMtFThm
	4AmTJf8uiE0gGvE6s6HFDkRIwbGr7vSZ7ejkf45kDQfjUN6BX0mEqXzRDcmEkPMXHiw9fL815FU
	gKLRZdL3V4A6iWeqtXoikQY6coo0+QJJ6XZqtw==
X-Received: by 2002:a17:907:9405:b0:c49:8d28:73ad with SMTP id a640c23a62f3a-c49be020e3dmr404569566b.49.1793268472113;
        Thu, 29 Oct 2026 03:07:52 -0700 (PDT)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd520838sm715397566b.31.2026.10.29.03.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:07:51 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:07:47 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	jgg@ziepe.ca, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 00/20] attestation: Add a common subsystem and TDX
 support
Message-ID: <auMahpRIeL-Dkytk@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <592d643f-e97d-4de8-9a87-e47d57dc8457@intel.com>
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
In-Reply-To: <592d643f-e97d-4de8-9a87-e47d57dc8457@intel.com>

Tue, Oct 27, 2026 at 07:43:04PM +0100, dave.jiang@intel.com wrote:
>
>
>On 10/15/26 7:50 AM, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 

[..]


>3. Jason asked on 14/20 whether anyone needs a variable-length challenge. I
>   don't think devices need a range. A plain read sends an empty challenge, and
>   an SPDM GET_MEASUREMENTS nonce is "NL = 32 or 0". Your TDX provider always
>   takes 64 (attestation_tdx_evidence_caps).

https://lore.kernel.org/all/auMX4kbsflE9kK3Q@FV6GYCPJ69/

>
>   A device needs exactly two lengths: 0 for a plain read and 32 for a refresh.
>   struct attestation_evidence_caps only holds a single min/max range. It's
>   checked on every request in attestation_evidence_request_decode(), and any
>   range that allows both 0 and 32 also allows everything in between.
>
>   To work around that, my provider declares 0-64 and PCI/TSM rejects any length

Perhaps just omit the challenge attr in that case would be the best way?


>   other than the backend's nonce size, 32 for both backends I ran. Could the
>   caps give one exact challenge length instead of a range, plus a flag that
>   also allows an empty challenge? A device provider would set 32 with the flag,
>   and your TDX provider 64 without it.
>

[..]
