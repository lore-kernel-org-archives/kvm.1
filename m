Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599930;
	b=IeIw26Y0ey+QXDYvhIGJqI6uQcfQOXvaK+n+m2a5UGt495ANkqfb3E54jMRPRnaC0gOs
	 q/F4kJ4slP5I+8KaKrB01AEgJ3OTgjb+olmTcMBANLHmttSz37mwH9ruejU3XGdHMxQwi
	 yskIV6sUGgpAM1GGfkaUCDhlCrk+OnbTRswGw3Y1sdxzEl42kzOXQUN7DqQIoEuKGjeeF
	 /AqtWs2iZEyexWT2U2QBUuI4GcyMzeJfq3rWQZki7mmptWRwzXeWx0YztOZsluwB4Pssh
	 hPz2iUfv3wv5kFtc06bxSshJC8txyUPgGYkmqFUBUKKk83IngC7QMYiZlbaqRgiQR9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=wTPDb7LIMtyEiz+mqYTBrrnJbHRN01tnFVsBBXNS8TY=;
	b=n7YrRC0Uh5kSHNDwPIA7w74vY7Whx1spc1VQtnqmdy5OgP8K8gTictIXIMrZkdXQIVsq
	 NnMEN5F/J7NyJEtfiRSzXn/JaeA5MID1Q5eyzP9WcMhR9472N1gc7sJPqJ03L1ObDD/XH
	 SK1Q3GqshTvO/L4fYHpTFHlOqw6ejkipSDC2gaA0IEPyLDdXqd4PFVBLyKhKkCdhvC+CF
	 vV5AjO6WRG/p3isvYI6xHX0Xjb1FaRNejw9zC+7S/G78oXMQ3WiGINnm5ntymRmJuUgx0
	 LUJKb0WKFMzRDARg6unbNNoFA91p5UcUmt0WLd+kRfeTXdH7MNCRKHk1TpiPoDvCRLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=nLldAXVT;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BCA606A31D
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54BCA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=nLldAXVT
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c423b145922so118031266b.3
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1792599927; x=1793204727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wTPDb7LIMtyEiz+mqYTBrrnJbHRN01tnFVsBBXNS8TY=;
        b=nLldAXVTDBPyUo5rQiH6wJRPeyGlMCQokaHib9EKVjff54+owMFh/Qp6vjiMk7Qk9j
         Qw+uzHSbcliTiERA0MKT3aFKpoekS12Hvsh9Eu61qJtAeSbh076VpqH6PzpIANmxvzvR
         IIwu8ZpXtSEz2iLmnRTJ3wC8qnPTWFM9COcSV9n46v+qVVAMc8C5NPsKz4iZiJl1gqxV
         d/kjXe0ZI1uEOwAcqMf+EadGjSx7dDpqLNGDKteo8my9cQRM/F9j+a6JqhC+sRPFku1G
         AyWSyMLmA3aLlvzRGRLhsZOdo/O5HostYUr1lniO+arQMkLuMwMSMkVgsTPBAI9MfX2y
         6stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792599927; x=1793204727;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wTPDb7LIMtyEiz+mqYTBrrnJbHRN01tnFVsBBXNS8TY=;
        b=OjA5ozYTup1CkG6j1jKzXjQEkLVydrZ3LtK7dvIKexoYTwK9g29bDqGB6dNyBSztdW
         SbkGkzwKYlyVBcsSqHk3hV6LSx/h1dZenilcq9Wxia+qJZaJMOW9bAWapFS6QKaYWA5+
         NeAxcszDf71YGxo0XhVZOspJLAErgqjxRxXyI1Lfg/zkkfWgYrHFaUoFMV6TljdEQXlX
         rC1Wyb8TmL5l2LokARPVBaTsAIeCCYo0uJZ1cDTOalzPGE+OpAUQcXKVRfboH5L3TN7z
         IJn5QxRo2cdEj4Dqf7jDkOjE0ihBVY7DTYUI1zEeNWAA2qVJ+5doJpeDb1UAkrFjEokh
         vPeg==
X-Forwarded-Encrypted: i=1; AKwUvBy+aS+m/U8Y7uY1qlh+MCV8+U2J1zLuzaGYpV62xsAnxjMuYFuv51YL85B3/0evhjbcK54=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2VG82J64SmAAiV9F+5KcIWX/sOYZ8jvCPkLnH/jVbCI2j/eQ6
	8HUt+YmhugPHufk9jKn8+7sJm+Kn/6hy+RU5fvFZ9D+fMW8D0mw6NNV5P+HFnlDxbyU=
X-Gm-Gg: AYBFou2oeI6NgxHTItiOgEHIT8gpefSvxKqxm0pmSpC4mW5Gz8JrOWrUFz0wiWpF0Rf
	gMQrWY6tCp+BfoVOVjvuOxQhY7Gpk10QZEz8Xi+2YP8Vq7Q2TkkjyOyg4R0Jq/veSd6n6ptbHmN
	kM8h+xMeQ8T5+qBAzO9ils9zts9UQDmsc/AWNhghSE4SKZPM0nxlIzZK2MOStuSD2MPcN/68fbO
	yw1HlrCZpkCDZxwecsPdVUeBdAv0l9pmDJOfY7jXaMFLEvke5R+Z2RHbYPOWWdcYD5LYnpGYo0j
	reWuoT5tFf5zoJgivYy39v/m9DgP2BfejzTKP3ZIhXKlg+HxXQc26NuWDWRSRFnGGaPczKoZfU+
	+xflsxaWxTYzg84bqR3wBD4X/UNTflbg3Imzmu9B7ekeepu65w+jx4xJcckUwozh/nPRM1TJQsT
	ya4Dg8TknDx+pSh67mkiFgdbFPTx2shuWi7y1MxSj7S6vhtJGirYprXH1u7g1DRwc3NR2NhrAu6
	80T5b3PVXn36Oc4UHI+Tg6UWkSeqx3hp2Iplu8pJ3oTTMxbFRoENZOV9OwVaIBlXR1+
X-Received: by 2002:a17:906:dc91:b0:c27:420b:7c79 with SMTP id a640c23a62f3a-c4679a40b62mr221295166b.48.1792599927374;
        Wed, 21 Oct 2026 09:25:27 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a6182e8sm17768966b.81.2026.10.21.09.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:25:26 -0700 (PDT)
Date: Wed, 21 Oct 2026 18:25:23 +0200
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
Subject: Re: [PATCH RFC 03/20] ctlv: Add the root family specification and
 generated files
Message-ID: <atjnZ9oVYZN1VnwG@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-4-jiri@resnulli.us>
 <20261021003056.354a40ad@jic23-hlaptop>
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
In-Reply-To: <20261021003056.354a40ad@jic23-hlaptop>

Wed, Oct 21, 2026 at 01:30:56AM +0200, jic23@kernel.org wrote:
>
>> diff --git a/Documentation/ctlv/abi/ctlv.yaml b/Documentation/ctlv/abi/ctlv.yaml
>> new file mode 100644
>> index 000000000000..fa11bce98f46
>> --- /dev/null
>> +++ b/Documentation/ctlv/abi/ctlv.yaml
>> @@ -0,0 +1,186 @@
>> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>> +%YAML 1.2
>> +---
>> +# Checked-in ABI snapshot of the ctlv family, written by
>> +# "make -C tools/ctlv abi-update".
>> +#
>> +# The checker compares this family's declarations and inherited stub fills
>> +# against this file. Updating it is how a UAPI change gets reviewed; an update
>
>Slightly confusing text: 'it' is unclear, checker or this file?

The file. Will reword.


>
>> +# that removes or renumbers anything, narrows a bound, or makes a placement
>> +# required is an ABI break, whatever this file says afterwards.
>
>
