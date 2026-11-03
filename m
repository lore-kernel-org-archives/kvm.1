Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695148;
	b=BcZthHZU1kjVRK7+5iRWvGhFmWY4IZFmJCC/oz0b4bRYJw3hn6AMTQlkelsA3DPHce92
	 kAONU3ZHRRBficbRVtcHx2RMqDxkDF5pbjtoPCk67tsutEeTLfcGcNYix/r03EgvNawzP
	 /HNyiy1GaXP3M/XVizBsJNHya1S9MrftfSlCXYPBSO2ribqk3J6AFa3WrN64ZScPCitkg
	 C1ZL2EkjD9C7ub1aUx9Ng5KORxKr2cMvemx4DsAyUFZb4hROYgVlrucgdb1gplFXxeC8o
	 ToXCLQrgK76cTni27m8X+saihqe5AYBb087ty6LhkBahUTw54YfaGRy+IAOqDRJ31Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=MRTks+7ld7RMCsMZY4NHpGohDqoSKPsEVE5vKTy4ZGs=;
	b=VnvXp4tFPlav1dUrXDrRVtSjbXFlY5InH+FcZJ3Ux1elMxnozYBN+WGzWU2Ot12xFOJb
	 CVj4SgXczYRWVXMwenwdhgaDBsP574mPZX8GZiHYuJ5oLVP6gbK/4LCu8TjeO/mj27FMb
	 oRa38zzuu2ggJAS9Gm/yFgWIssmXQpLwz/LGQwEeXbdTgHuvkv66DmYqaIvKvPa8ztzJ7
	 3wLFhx3HBFaGAe9cB47a7+wY76Ft/2Iany/VSQU/dBaM6pNtCLr+aOnwz+GDTceMNlJge
	 X2tuLWUEzUpyqve892pIMwFnz7Vd78FNKXso43g5MMacfMXTm3ow6p5xWCqGY8svDOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67927606C68E
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 08:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67927606C68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so5151995e9.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 00:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793695135; x=1794299935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MRTks+7ld7RMCsMZY4NHpGohDqoSKPsEVE5vKTy4ZGs=;
        b=FzhtqlhWaJl8/mR5HSEsoDwcWP7F6hzS6SADauqAQGdfoDE1MyfnX/pMvL8xxXfm6y
         GIu5T3pkFU7JZwkuiHng+TEYbg3mYN0Dnc4ZcreC9vKEFh1iTWYxTUNtP6YOIxkyb++g
         pfSfRH1bj01FENErN9h5Es4nug0+yQGK7BzSD7NSZIICk93SgEaHo5iWQO573bppmgy4
         JGinVjtRi4ZFntVmtNpKEMwWBwNfJl4ufBshlTDs6VNMyRBFna8wYzNCOqkdAsH+unnU
         WbEmFhkkGduaAnA+odcSRJ4a5quFKvu+hFPS9DojkfnVsZgGsJEFJVYYS19OH/GsH9++
         ySCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695135; x=1794299935;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MRTks+7ld7RMCsMZY4NHpGohDqoSKPsEVE5vKTy4ZGs=;
        b=In+jTRVxywqpmG1A6WVaweVWI2YO7XzxOfvJMb+iTwNWhZVkVQnR/ewiU6EVJrnkd8
         ISls9TyAlw9+/mObK+QlvxWSeGITEVl7U2yszz7QYlMQZlSJVA3Jx8XPvOmtF0plzNTu
         irfxGkUKrQe3qLPc6bRkHPCkkt8N5SyZjKMQIYEgQ0J+tZw5MlA/Fcd0UmRo5T2/WI+l
         jwI0OTnPs2gXiKgpLPn/eqP9SbnM2547XuKnInibEa6prbz3hqHevOfTDapCNZzYFgM6
         oIh3EDS6uoPGsVzkftM9FelyMdgqYWOlX7tpBa2JC1JO+IkDNkcFliijdYm2uV2Jsuve
         CfVg==
X-Forwarded-Encrypted: i=1; AKwUvBzfhmDQD77UWu/l1w3FLbIAAdxSHSOnd0rdLrKjOJ0ss3+vQmRwYZTbKLRdK08QX2yw9rs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+n0xSaLVkZvsNkJ18MiwFQIzRQr9t6MNTiFy/+os+jcyrgADhF
	8/LiJA/7PY+SgqfG6gl6aYj4p27zHAzBBrXsnbXWu9NcyzwUZ4GTLNxkKINB4i8GCfI=
X-Gm-Gg: AYBFou1c12uJb2BJnP90+x6Ry9S6jFm/0vK0jetylN8bal2K9U1qD0nmJCub/G9gcrM
	qC/E2wn+5/OIEqjEBRGNxhPhrpr8t04DlTyx/K8xfIY2sqUI7uaj8add2dOrOcjoC5+j3oFmKru
	UsD4JK+xfsYFUI0s+9Fs6bD+APyut1xT867mcZurlBuJDhcZwLMfLdxei3gL0V3BwGtE6kSO8tY
	AXoSVWFivjLtfiBxcccxvFPWv4C15JXk8EMmowtxSCgnGfDV56KLytKDRoWwnH5rU/QpH114lT5
	00bWXTLjNrXVkHRidONVcvBVEMMyhGwsejKI1Un/2RajWnyc3rxCccPwixvNSDzYVf1L8zKkbME
	jFpPPY+RLsBk6tlV98GRv3SyEzZ34mjZ7lBdGhgxfyOPPtY71C2Qt7rDgPpUqiCdaM1j46V8bNS
	Jxn6FT1C9YgFSfE4YGa6tlPF12MO9yN37NGpNJ2du4uwZSu+n78Q79w5KkQ8AdrknaguYQ28VJA
	D9NjsDj+izy1J+cDo5DFqcJ/DiY5pvYHpLFoxGjkiFKo0naRbD/0v0FS/oUITJQHg+kqlZ5GDqs
	WV5X8KhMjDomRy2YnXzOry1umrtGIoVYGGG0R2scAkw8kT5N3YpzLSYKv3M=
X-Received: by 2002:a05:600c:8116:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4ac17e10724mr285917965e9.16.1793695135152;
        Tue, 03 Nov 2026 00:38:55 -0800 (PST)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm432002285e9.1.2026.11.03.00.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:38:54 -0800 (PST)
Date: Tue, 3 Nov 2026 09:38:50 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, rodrigo.vivi@intel.com, 
	cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 00/20] attestation: Add a common subsystem and TDX
 support
Message-ID: <aumdeBFHvrN5_NgX@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <yq5a7bjajaco.fsf@kernel.org>
 <atooh7uO2RauUTfY@FV6GYCPJ69>
 <yq5av76sj10a.fsf@kernel.org>
 <20261023142038.GE3977851@ziepe.ca>
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
In-Reply-To: <20261023142038.GE3977851@ziepe.ca>

Fri, Oct 23, 2026 at 04:20:38PM +0200, jgg@ziepe.ca wrote:
>On Fri, Oct 23, 2026 at 01:34:53PM +0530, Aneesh Kumar K.V wrote:

[..]

>> 
>> ./ctlvctl/ctlvctl --spec-dir=./specs/ exec ctlv0 device-get                                                               
>> # device-get, 1 fragment, generation 0                                                                                      
>>   device.generation 0            
>>   device.caps                                                                                                               
>>     cap.evidence                                                                                                            
>>       cap.min-challenge-length 0                                                                                            
>>       cap.max-challenge-length 0                                                                                            
>>       cap.max-total-output-length 369098752                                                                                 
>>       cap.evidence-flags evidence-accept
>>       cap.object                                                                                                            
>>         cap.blob-class cert-chain                                                                                           
>>         cap.blob-instance 0                                                                                                 
>>         cap.format spdm-cert-chain
>>         cap.representation raw                                                                                              
>>         cap.representation tcb-digest                                                                                       
>>         cap.hash-algo 4                                                                                                     
>>         cap.hash-algo 5          
>>         cap.hash-algo 6                                                                                                     
>>         cap.max-length 16777216                                                                                             
>>   device.info                                                                                                               
>>     pci.name 0000:02:00.0                       
>> 
>> I think we can use evidence-refresh to select the blob-instance for the
>> desired slot once the CCA specification supports that.
>
>Jiri these ctlv outputs are really neat, it would be nice to include
>some of them in the commit messages so people can get a sense of how
>this looks without running it?

Okay.

[..]
