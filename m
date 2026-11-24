Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522399;
	b=orHMaYrqYt5042JREVy3O8bWvKA/CGxSDWV574rOtetoMyxCHPueHE9yKfU7gEXMIltf
	 8fmjgd0Io76d1PJbgX4qJeeIhzEMD2nf5BfOHlLK6krb+nhfRPWV4zppqtn1pWAPhvAEK
	 IQW48rlXuScBVAvJRPT/yalQkNDJ8wvF1yL3wkuB1STQdQE+DLsPJCXOCe/QotKdHUamL
	 HW9bBp9pQ/50v2f338KBmmcQu/PVRtro+0gRu7B/D/MYsYR4QMR/3vnj8BfAASCDnZnmt
	 mhANbf05ihYJVECGg/w58/6yRXpEH3c6eDHlsGZHRE/zJodQkzjLVrcrQ5uh4EuJtyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Np0NcUv7mJCJjaicOw4k1YXtQeAzhuGY2ockZsxXegU=;
	b=vrrCv2oEzVBWm+LLj655l8dBfNOJly+cnf5XrMOboe2saohRkdXKIDI299K7dLavFlgJ
	 RYDTG7wc6hTu4kQFp5R/YYpI8KTjHsHysMS9hujGPQvgwn/kg0coyKH7qTiiVIsfkkfXz
	 tzkLy3x6k2Rdd2VBXraAj2ogmCXe1H7NINPf3rVNfehpmYZCO6Poy3LQUYcbs5jDdB/tW
	 Yv7j5xqlEn+zqcZHrbR3rMTgNBSJdLfLBfe1E7dJyRPjXOiidwwtvp05m1euenSleN9BA
	 tfm3H0dRPE5MCmBeJNGISjiCVlTEum7bDMFuzAK2NIl/9RTekPfATUf673hFixkdSQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b="viTi3/8K";
	arc=none smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D810A606A327
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 12:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D810A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=viTi3/8K
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be4b61fd3dso3736439e87.3
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 04:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1795522396; x=1796127196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Np0NcUv7mJCJjaicOw4k1YXtQeAzhuGY2ockZsxXegU=;
        b=viTi3/8KeIE8uhX56JlXlP6/VB/uifLp1YNde/hFxWBVL09rfHt1AgzNSQ1xTLYKYW
         TxNBy5Mj7sV0GRKJ160Si2rkUSAgJn33iwqUin2swB01y6Ut9G2oo/NtD6GwmuBWsdGK
         pBscQJ//hVMyPypXQMgFo5oJH1vUFdJ5blh4dTSbHXAdAibs/3F+XbUA3jS5gh2JSVOJ
         LN2T2nENIFcXoTm0K25ZjYzgf6wvRTivXcZG6y1mBdXRA/xDPzAu9oc8mACnMdnRVp8I
         5SJUX/xIX1KhwdTHpI3kikeVNii6iesD7pV4JscgeRxDpEqmN+UfwGtYVMRPotk3OsIE
         2nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522396; x=1796127196;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Np0NcUv7mJCJjaicOw4k1YXtQeAzhuGY2ockZsxXegU=;
        b=NKRdv+IzhRELTKYMVBDqiUCQ7GdxJ6wAI+tfuhdOCtP+I5hWojan/dDOlI5vaN4S8b
         ydfkwZN8H6Vun7mKiHR1iW4cb7yfiBQJ4TOxhbTiIP65/aOL74gdv7ORMNyAemITGG9I
         xt35VpYKo2OgxA50kjNTZAk7ra/sNTyCMYatQCeCI/dQPsNZ60HEGlJVeqeTTx1HnkW7
         aAAqtfMNCdWMLppWz30WQZ5QnOAqhTIEal5gPtsiEsdM+KgZPvH7R7+AOWwDOoEr7C1x
         r6CI8GOQODANvGr72zZzl00D5AD1CtiU6Ll8vZ7h0ElgJS69+gYua6L5rV5CUSG8dkRs
         eQIQ==
X-Forwarded-Encrypted: i=1; AL+hErE3jiF2newSSxjqeWAsxMDVii654NcoVM8Vy71QHAWMYsRSTyzt0IcsRWsTKhLJc5wl0uE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+ur6yc1OOeo1tgaD+ZEF/eQyVGUzUJnGp9IKkizmWiwe6CCDb
	oooJk0G+LuyKzROQ0/GNN8cjeT7ds/IOI2z/kpfLkwh96iQRa3iu+/cbzdZhaKi4lDw=
X-Gm-Gg: AZFdTZfNLGlD2bGvRwkLHR/4QvhBVxzfdDdKf/21IIbTzy4g9FHcC3Ulr/KfLnZmqJp
	yBylr8hVTAqXec9IsWLxfbCyfra/OfFPnXU3cV8KOifh7j/djVfnWI0sRSqaYZ05t0T3MulFV0t
	QsJ+TqPbAjepWTEvCqe8TR7s9Vd7BQa+g2/saFWNiTeYOacemxRieDFmnWaoYeFOOx/UYFfqj0X
	paq/8g90g92ZOSaEc4iolQTJOWz5EwkXswdMokQU+qjPIz7eD0R7TqeEuyEoJ/o11qhT7J0PlZS
	1O+rdIv4RZR5GOWGg7vzM04NgRLPaVU7RtjAdoZZ4xubGXPVdsNLGkfeUaXs4h+ZJdHJZgOVnh/
	/KUaVfeZQe54du0GDjwn++14mAswpYbNhT6Ke/R+lD36s5WhEkGvqILqDZ2adIks7isskCzBVKb
	eZLK2gU9EhgYqO+ujR8Wq5HFGnULZ1g/q//5xxtt6wl5M7wXv+4Ft5dwAWbcPUcqhmeOPNNhp/l
	oy4qOFhn2nw3saL1dxndZH/pCjPpGhKlQ5SFPaDcE+d1vCsRXdTt+WcNYBvAksceIufBa1mW8A8
	ddz3jSa3X3uynY2ocfmdBp/SA5X1djQVKlOgmw==
X-Received: by 2002:a05:6512:23a9:b0:5c1:6065:40d with SMTP id 2adb3069b0e04-5c1bc867b6dmr3406850e87.38.1795522395833;
        Tue, 24 Nov 2026 04:13:15 -0800 (PST)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd01c018sm3681005e87.44.2026.11.24.04.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:13:15 -0800 (PST)
Date: Tue, 24 Nov 2026 13:13:11 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, rodrigo.vivi@intel.com, 
	cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com, zohar@linux.ibm.com, 
	aneesh.kumar@kernel.org, dave.jiang@intel.com, nik.borisov@suse.com, 
	sergii.dmytruk@3mdeb.com
Subject: Re: [PATCH RFC v2 9/9] attestation: Add the TDX family implementation
Message-ID: <awV_P5443pO4yJa5@FV6GYCPJ69>
References: <20261113160838.2512652-1-jiri@resnulli.us>
 <20261113160838.2512652-10-jiri@resnulli.us>
 <awQCrnD5CtEhKRWz@e129823.arm.com>
 <awQz1P6iXYrL8lv0@kernel.org>
 <20261123151128.GD179082@ziepe.ca>
 <awRYr7yB8IWj7S3G@kernel.org>
 <awRan8ZELzpTwduV@kernel.org>
 <20261123154042.GI179082@ziepe.ca>
 <awRe-A_KeE_kXyPq@kernel.org>
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
In-Reply-To: <awRe-A_KeE_kXyPq@kernel.org>

Mon, Nov 23, 2026 at 04:42:48PM +0100, jarkko@kernel.org wrote:
>On Mon, Nov 23, 2026 at 11:40:42AM -0400, Jason Gunthorpe wrote:
>> On Mon, Nov 23, 2026 at 05:24:15PM +0200, Jarkko Sakkinen wrote:
>> > > > > As per the function, perhaps tpm2_calc_event_log_size() should be
>> > > > > relocated to lib and have non-TPM name like firmware_event_log_size()
>> > > > > or something.
>> > > > 
>> > > > Probably under drivers/attestation since that is where all the TCG
>> > > > formatted logs should end up. It should be 'tcg_event_log_size()' or
>> > > > something. Maybe a tiny module for it like we would have done in lib/
>> > > 
>> > > +1 for the name, as it is obviously more accurate prefix.
>> > 
>> > Location, I don't know. I was thinking something like "lib/tcg.c" with
>> > routines that are plain calculations based on TCG/TPM data.
>> 
>> I think we should not have new users outside attestation subsystem,
>> but the legacy onces will still exist obviously..
>> 
>> IDK either, but this is my guess..
>
>No strong opinions on this; just unpurging my thoughts.

Okay, will put have this in a helper lib.


>
>> 
>> > And perhaps for tpm_buf (both stack/heap allocatable), if Trenchboot
>> > ever moves forward.
>> 
>> DRTM users will route through attestation subsystem to do their
>> extends so the tpm_buf user would be the TPM driver inside
>> attestation. We definitely need this for ROT agility.
>> 
>> We should be able to build the attestation TPM driver without any
>> trenchboot stuff to motivate it.
>
>OK, this was my guess but did not know it by fact.
>
>> 
>> Jason
>
>
>Br, Jarkko
