Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025930;
	b=TLci8R7nJvmkCe0E5d1FEvwazox2lhYAN0dGaRXLO+dx/yYulItUcEMwINPy3YPh/dmD
	 l0yqiKCjPllexMH3iuG8iTG54benEPcBbhuIZxLtJq0dm1F0a3+YNe56RIYga659/WUzq
	 C5LgOgYBn5QIWWwgbczejB141XjpMEuN1uPL6+UquGkouJ7OWRekRc3OA24nzk4QSNAav
	 yXjON1WezJFGi6vtVIrsCnRLnY72kgk7J3eS9iIjxLR582q7dglk0xFIr2mbsZryMFaoP
	 CmnGzH2We2mCcd7ukWJK4irjr/MJ4jhq2WYIEgPEHFNlncM7jmp/oBX0smsTgneYNkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BTyJwIZ3wmc9oIYfv63SnUqHORvshzUvmQqM3M2r5gM=;
	b=HR81GcwfG/HzfsIK/yIXuRSFpnoAw+RxmPwu27DyHZZYGMp4TQjmj097XiRO/pOCFvAJ
	 ZnG7pQgrH2qGLbJoEZmxW/+9pWPctw7/Swz+Da66iSzmMwb3OdvotosCQpC61DOrvEOL2
	 ZQQPxpjWnbzcdswQKtrlqL7T2PpAbnqZpYT1NYzFnzuSe93YlQhwgOoHrffrfy8SVImwj
	 va2/TsdnVkNz4D4f6kG4bkQ58+ai1E/NoW3SP7t0dKyh76lo/P6u8rxaBfTGgOICP4T9N
	 Id+uqw603Lga/d2RtVkWQPA28npZjC1jCw2YKRdDJiL2gQEZvJzueJxvybY9mtzWFjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=NaHhzKNA;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA6D606A31F
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 14:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCA6D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=NaHhzKNA
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c43373ae89aso462967866b.3
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 07:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793025927; x=1793630727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BTyJwIZ3wmc9oIYfv63SnUqHORvshzUvmQqM3M2r5gM=;
        b=NaHhzKNABkMC6wPd56SklKTLcrQYlfIh5spEFmqO7cf478BMxIsRJr4GJdsQzMnSsI
         rdTHhnF71aRCmn/ZbWzRcAHNKccrrw4wdLKTXgtF7lVYmL/I0tNSmfXZGnPPcKVl+2Yl
         x/dU7kIekZQCU2z+mtWPUnGySnvBvr6joKf+sfeGKvdFtmYt9dSLMTJesO7CKx2gOyWj
         F7XkhsdJkfue1Pp3MdFYVpe8zPO/ElN6+Hl27s2XKWj4Ttuwb4puQdX4nJm5KZchfBO/
         R8eFcLnpn2qGsfM3RVIy2yrHCfMIG6pg+Q6Fi66PGXs+F6CEx+JXB0tkqciFCTf+D4JX
         SK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025927; x=1793630727;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BTyJwIZ3wmc9oIYfv63SnUqHORvshzUvmQqM3M2r5gM=;
        b=M1fa1aWM3eQctnY7Q2v8tX2KzAtyvjdUuPcQFfBddOCrkL+ty8LYAH15OBN+VMBSA2
         qxxNX6dQWiLxhivT59JQcfc79gP5ijS5hEgQo7cAhzs3GmatxgBdUGaeNmDZysHy9Gf9
         nUqQK6hQ747kK1b35KsArfnguCbZspFir76XyqveFCYIN9uUz4C/P4tF8ou1H6L+AY4K
         zOfPcOe8MH1j8e2Q3Wvp9GSFtJUT2LTp4906rrtS55EL5jnd1Lu0rpvXaw78LGcheAdx
         1j2FuFPYgmiEqxOGWZjLgdHP/hD9XvAiteztDXtQWUAXNkxWpHZiShFkDll+dYsMl0P1
         kZdA==
X-Forwarded-Encrypted: i=1; AKwUvBwFbfdi5uk0Vmfy+ZwBVzcMD6Kb9qygZqc/2Bk5X9S1ExYOcV1so5FR4/2QlEjHcCpUMHE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKC362fxD/7/FLMFovP+KafRc8CyD3iDTqzNX/CXXPzXZ2uqi+o
	0RPsnAAGI9NacVVAwXLshuzXRHJ2+kUdmT1XclQ7XMBr82NiW+4WDEZC12gSIZX+tBc=
X-Gm-Gg: AYBFou0kSJkjhS1lCrEhx+0kfaFizEIyR+H8HB41mp/k88waDZR7TuHDqt6e+/A2GxG
	E08ueBufmEEGLoT5WddcvorVh5Ht/Gkh7Sumx2xTRx0CmqWsNrh1ktKzXhuT5JPXuWyCONSeYtT
	nDKD2i1EaRpAF2U8F1dO0na8sFNor+tvZ2EBmWM2ApC3Fi0bEeRm9Y/PczpLOLCpDjsaBaXwQUf
	EzV7HIeTjapgO1gCT5I13MAB30ca89WJSAO5+VvGnoBDZcC4kBG5oxtRi8zU6oUTAM57jH7G2Vv
	9NtA7Cwnn/BPKCu4uO+RlAheHOuexwFjNw4jve045QbyA6GsIkr1cvlUfgE9h1qG7bVY7lKfCRn
	38RaTOYwun/ClpZwEjsYj6fLurVrjUv2Vo7BNFZfHSgCRPOYldfhes1QI9bBvmrKeFVbWz/iMh9
	isAEJiIWHuP5FtxIIFbd/JLaNveCdrgNYgdwQmZ3GDaEjV0l5ulDSq3VmchI3adLiti2IG5PkPG
	hv2IOJqAZIiDczuQi0SX42CpTjp7PQ4U8aCSZo2zuJx2Pr1+PG+eeehH2w6FSaS
X-Received: by 2002:a17:906:c111:b0:c29:f5d5:5a97 with SMTP id a640c23a62f3a-c46bde8850amr767885666b.33.1793025926980;
        Mon, 26 Oct 2026 07:45:26 -0700 (PDT)
Received: from localhost ([208.127.45.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd7981a7sm325130766b.72.2026.10.26.07.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:45:26 -0700 (PDT)
Date: Mon, 26 Oct 2026 15:45:22 +0100
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
Subject: Re: [PATCH RFC 10/20] ctlv: Prepare event queue support
Message-ID: <at9ncuDFz_vI-0W1@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-11-jiri@resnulli.us>
 <179302367451.58760.3073439917920385955.b4-review@b4>
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
In-Reply-To: <179302367451.58760.3073439917920385955.b4-review@b4>

Mon, Oct 26, 2026 at 03:07:54PM +0100, jgg@nvidia.com wrote:
>> Add per-open subscriptions, bounded event queues and event creation for
>> CTLV families. Add the generated root family kernel bindings now that their
>> message and event helpers are available.
>> 
>> The event and generated root objects can be compile-checked here.
>> CONFIG_CTLV remains unwired until device dispatch completes the module.
>> 
>> Assisted-by: Cursor: GPT-5.6 Sol
>> Assisted-by: Cursor: Claude Opus 5.5
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  drivers/ctlv/Makefile       |   2 +-
>>  drivers/ctlv/device.h       |  38 ++
>>  drivers/ctlv/event.c        | 713 ++++++++++++++++++++++++++++++++++++
>>  drivers/ctlv/event.h        |  69 ++++
>>  drivers/ctlv/internal.h     |   7 +
>>  include/linux/ctlv.h        |  27 ++
>>  include/linux/ctlv_family.h |  11 +
>>  7 files changed, 866 insertions(+), 1 deletion(-)
>
>If we are deferring the mr log, then events can be defered too? That
>would save another 1kloc to look at right now.

Okay.
