Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302737;
	b=M53B+rXO+QLJM6rx4kxNJGfEHfxl6Z9sTU8mIrtk6nZsa6TajY7tNMzj4Wb64P+okDVb
	 R4QC+80f3fajwHZSPr/a940A84BM9VugMOUcuawcXmMRa/pj6TqW+WI+clC0iARrfQEqN
	 jeuezQl+i3H3I3rZdAt6nOCUR2e/G7ryYQgM2gi6/YXe5DlBJoS6YG7JwbslbkzOHBi+b
	 j6lgv2B4J/m6kgJq/YOrzyTytVK8lyiVa70cuxOrL2iddXitfs5etE1QAO7dj9TY2RCh5
	 mHA6hye7KUtcqZgNcdpvTZOAXBqOjmN6tAuxv0TjlqFGN9pMObsK8WNM7m/stMpE6sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=L2bOsI/tPPOv5HbBwJUDpCwYmaK0u+9V6K9ALx35wl4=;
	b=r70rL4Rv3qUevLK2ggEtrGD+o1ATI3sRrAYMS+DKKqxln6aWsSn1I1QP5MIw12bigQr6
	 faQiI/zxVV4ac1VODwgZkxVHFlqhVhvmiBRxa0azDGp/xRRLOxg4ee5LmWXMwsJPV81AY
	 M4WpGxm+1mkz+rfHx7FK6wac7Yj/ZqdjtTbSvCMrS4NP6XmBw5NXYq8yUTrdCVcROYz0f
	 VmCRH0UVgw6knaF4WZl7ODf0RoGZ8/na+3wbxUuHYch2rnWSDRGyCdRfwVnEcNyBnuxxs
	 ItMQU0PIHmp2VXSima+pU9mTS83KUO2+vyq7BdnuZCCZY806Zw2GvXgVjogd0zjogMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=FNBa56KT;
	arc=none smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC70606A31D
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 19:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CC70606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=FNBa56KT
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a9841363b5so291471fa.2
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793302734; x=1793907534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L2bOsI/tPPOv5HbBwJUDpCwYmaK0u+9V6K9ALx35wl4=;
        b=FNBa56KT/9Dp2z4RqTJX4SmEdUz5QF0XsrQGqBzBDcfvePMHkyjRSZHgA2dL4abyfy
         Z5mCosjvFkTxPpDmCgqoP7G7lT2FVFFUQ0YpXNjOUhaorkhdgy63Iaj0z/fMjsNDNf/C
         B7N559oM1aQ463TkFMl4hlBO/WHCqunTmnc/UsMFfppEpnpGG5WUa9uxWJFZXCt4Mw4m
         rz9/qKuz3+niyjl8T1wW4UCRCMZX5MVtZiU3CO2A9BHdOcdEtVxmOzi+D8+vZa+Jmmo5
         /rJGHoehxWckvC7h0zyK1y6pn3xGNLKqI4ReeBj7jtQ2yBzeEYj7vSzrelBOMx5CX0az
         WXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793302734; x=1793907534;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2bOsI/tPPOv5HbBwJUDpCwYmaK0u+9V6K9ALx35wl4=;
        b=OtmE2pffm5ZqTrxUKZKqQD3ZDb3Or2oa9xPxYQSvx62gwMZJqKajXRcSXJT1x4195y
         EqoHAsZUkzpVb2Al5RwwLOgLY0H1cvth6w1TezxZ00VxcWh5FaNC+MdVvczcoiGPOuR1
         63mI+X9K6roRKU0m6JXmMT2gK2LguV7swuvBVt2gKehoeP9ioh8JMr5BlnvEbhsXlTb8
         f/n48b1QCszTLfmOD3NMATQUrYjQt68YrQQUgM/VMuEiR89Pez4hkQvEt7MLE2G3H+Vd
         UhhKe2+yxsuaPBMdO8E9fRVi0qKqo7+XGBeicjwN0J90+IQd5NVEQEwnqXb7g32m/ReU
         gsuQ==
X-Forwarded-Encrypted: i=1; AKwUvBywPf5qX8aaKRnbFXupAJI9NwE7/zXYrEvLUp/c2OfRbQAnGUm5+7X8lS5G2mLaXiFgR9I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjnOH7/VgfRyppyD3mxMsID5mgRDkJ7Ztvy9LHrmQhtgq7MrYQ
	QA4hUC2X5uzfP84m+baCQGmAMxt3L12M8CJgGM5cZeGQSyPSSkpv3gTRqArGozeJ0Jk=
X-Gm-Gg: AYBFou2M8W/6IbzXwt95FhICZlUW2PpC9XYxU3I1kfcQiHKBJpclEe39CzOYikiIa+R
	JGo0Lu2YzK3FnH3raLaPZi4wR7VQkmFk5BDWtA91dbOpORu8R+JumIYwrn6OfrEx1DU9zIrfCFK
	TRjHhJ+w22ZzqHOuavEpyMeQTjcVAqFFqgdwDqU45A2BUzEUAapvWLKB3VJAbXsV0lJvA5EE8pY
	y3GnBbhc9vxgXmtB6WOvq7VyCx2x6ONv11Qj8Oe/re8uEsv+IQIn74vVOX9oYmbkMe9SSXM5c+E
	/GlYTEpbLgPVRMXsNQyJm+DeZnczRCcD1H0en0SEtgd9RHCPCZvS3kudB0+3VwcXfbYM6pMiLQt
	M9GrxFl6yUHpAYcxUHJxYcuKddY+ERyrT36Qh7YMtLC5TdFTJYA6NsX23IJTkcAPYmmI/nhdXQE
	UPIaKgid01DNkJbJ3pGi++DCcotESDk+5qQ5fdVkhwYvh/thaYst+UJvOuKyR3eteBuE9h3Nyqt
	rGmFVTaBUii+BS66vd3VbUIKl2qzXPwPxxkef968Ts7x73YioLwJnD/mRARzAN/mugvYDgx8BtQ
	87NDHQChtZ/5+SStfUKrnG4pa5I3ftoompQOZI4EnWLlARICGZgG02w2qYM=
X-Received: by 2002:a05:6512:3f03:b0:5be:414b:a84b with SMTP id 2adb3069b0e04-5bfcadda82dmr2380923e87.51.1793302734163;
        Thu, 29 Oct 2026 12:38:54 -0700 (PDT)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfd7ef0c2esm69050e87.50.2026.10.29.12.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:38:53 -0700 (PDT)
Date: Thu, 29 Oct 2026 20:38:49 +0100
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
Subject: Re: [PATCH RFC 14/20] attestation: Add the base family specification
 and generated files
Message-ID: <auOgwlGeW-vRGVb0@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-15-jiri@resnulli.us>
 <179302367452.58760.3782556786585774917.b4-review@b4>
 <auMX4kbsflE9kK3Q@FV6GYCPJ69>
 <20261029184324.GE3734323@nvidia.com>
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
In-Reply-To: <20261029184324.GE3734323@nvidia.com>

Thu, Oct 29, 2026 at 07:43:24PM +0100, jgg@nvidia.com wrote:
>On Thu, Oct 29, 2026 at 11:04:58AM +0100, Jiri Pirko wrote:
>> Mon, Oct 26, 2026 at 03:07:54PM +0100, jgg@nvidia.com wrote:
>> 
>> [..]
>> 
>> >
>> >=======
>> >
>> >device-get:
>> >  request: {}
>> >  reply:
>> >    caps:
>> >      evidence?:
>> >        min-challenge-length: uint
>> >        max-challenge-length: uint
>> >
>> >Did anyone implement a variable length challenge? That seems a bit
>> >strange. There is also a very important crypto warning here that the
>> 
>> Yes. TPM2_Quote accepts variable-length qualifyingData, represented by
>> TPM2B_DATA with an explicit length. This varies per request on the same
>> TPM:
>> 
>> [1] TPM Library Part 2, section 10.3.3, page 136: TPM2B_DATA.
>> https://medias.cdn.trustedcomputinggroup.org/production/Trusted_Platform_Module_2_0_Library_Part_2_Structures_Version_185_pub_c0a962a931.pdf#page=136
>> 
>> [2] Part 3, section 18.4.2, page 158: TPM2_Quote qualifyingData.
>> https://medias.cdn.trustedcomputinggroup.org/production/Trusted_Platform_Module_2_0_Library_Part_3_Commands_Version_185_pub_87a5c10230.pdf#page=158
>> 
>> The PSA Attestation API, section 4.4, also requires one implementation to
>> support 32-, 48-, and 64-byte challenges:
>> https://arm-software.github.io/psa-api/attestation/1.0/api/api.html
>> 
>> FIRME DEN0149 1.0 ALP2, section 8.12, Table 8.23, page 100, likewise
>> defines an explicit Platform challenge size parameter in x4[31:0].
>> FIRME itself does not mandate the specific 32/48/64-byte set:
>> https://documentation-service.arm.com/static/699c3b70b60ef220b14ec14d?token=#page=100
>
>I feel like userspace needs to know the difference between 'any size
>between 0 and 100 and 'exactly one of 32, 64, 128' ?

True.
