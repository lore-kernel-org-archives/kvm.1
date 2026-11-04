Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821585;
	b=ZT0vYNJkgKzuqQwT6+LQzLf3Aa1xVqGsgk1VBhvwIOhTUu3HRhNSUINg2i4DNNijyIW5
	 irWySfeRGmeMi1JyHtxmQwDJ4eAabXI+TQGglJE5nxJG4dxPWpARMncxv9PdIdHosqMpP
	 tsi/OTMmS6+4wfXEKuFGELxgfGPnCHUTrGBRAGc6OL4eK1CH/rZhXZ+Q6iud2tDiroHGu
	 N4xHHEVrk933pK8xrRMigbCPA8gk+3GIK4gIRQ1lcJbrGwUSbPxGyI9D1aFnplV8bekRo
	 LI9vHTB/o/pNVHVdtYE2vvyy2yW0IE7CEARszLGzMPuk3x9brP4PnpIhdoZrKon8x9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/iOiQOUFj+ZNXsxkV0W7K4UHGpRKtOzL2hr1OPDdR9w=;
	b=tIxuR2dbuAz2qfovL+VjTpftCO7Kv25RXxL363wK80kS0wcBhInprFb5LBQjXy64OsjK
	 HqNox45Cx0KPPelCEJG+CMF/wXhSh6eiQUjXdfl9UOcn10/0yznfbiW3g3+f2NpBYbOcJ
	 /nGTKj/e6ZX81g4MCIc8kvW8ajpe9no2yv1EAS5+yKvESf1d28vO8HSuRtopVs6IcqeMC
	 34ZwP5gxSfuw0jO5yiPm9C9ifbISFjzlANWbsLT9H/ZoxOeKDHYnVGB8M59NnzVDKSScE
	 +3gN5kQIYsAsuZL3yYALrdvSFe1mGq7kVTnFuHlJ0SW6w+EJk4GKTcGrdBVjFuKPxzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=WRBm+GQF;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83B608CABE
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 19:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A83B608CABE
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=WRBm+GQF
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53bb57f1310so10783561cf.2
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 11:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793821584; x=1794426384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/iOiQOUFj+ZNXsxkV0W7K4UHGpRKtOzL2hr1OPDdR9w=;
        b=WRBm+GQFrwS5Zas3ZL99mrACnUfCSQ6IoeXlzzeD5KKnBqHHgtxYl2c9wviBwKfOJD
         qtN+ZFY9uOU0mlzNZCuwr0exw/fYbp1g7ho5/pM/xUO2KAdWMlMV2RV+eo8CzwSP0PK1
         MgVCvd6blq74OYN7OPzEIJ01+NGUqyNVGsk9oJ9gJnGaU9hlo5GRil1NKdsf3xy0EYAo
         KWR5bpoPTgSvX2xINyPwl/GgNSWpYL76GMZPxcwzp8e6CZ+A0tOfzm6uN9XILruejEOn
         jmRIHZ7FemA5lobw30d7bQdTmz2Zgu/15vEm4Imf92NuvMQXWpZlg1Y/yMPrwX5t4FVQ
         NW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821584; x=1794426384;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/iOiQOUFj+ZNXsxkV0W7K4UHGpRKtOzL2hr1OPDdR9w=;
        b=bp5P97r9zfeblycy6gD4+Y3eYMkKuL53b1eD8smL3Dy4x9B3NkLU2K9EGRvxNqZDTY
         bE6HVrQtG1qaniZkut0YJXvU0GAyFUnkqKqsSWKgz+u7FQBG+YENYNlAlOwvehrK4urc
         Ke0P6cJ1o1uJp+ShThTcTG9e4fPAiaKVt0r6tjyvI46Oy+wgBGKMWQAnWZcO1BeFBh5R
         /X+ghpkJ+Vmb7tEX8eoNRtSUKyFtAPcnRAW7/pBU75IjQuP+09wvB2tAMHQ5H8162SQr
         HO/Pn64ZqBOAhwViaHwd0L5GvcwWwlJ2qUTR5toEdRmxD5O0qQB9rpYHyPO5s1h1BB5K
         X3tg==
X-Forwarded-Encrypted: i=1; AKwUvBwcXV9AJrDhUQF0Om2noMVV0xA3gaknlzHjjHwyI8rSOVhaEgahf1DJWJVS/jWKyvlgYIk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+grY4E0EpVFA0iCypVf0Rz0z1Rs8TQQtM3MpWNqhKvlhMKbAUG
	qpUn5V6LMAh3UgfEgD4sip6e3xwJ5Xpz4quzuDde3CgtI00XqJCki903zxCgBJF1g88=
X-Gm-Gg: AYBFou3aoeXC6YxPCJh6H45PTdtXV3C8dungvn8nrt1SpGOklvlAY0+TGrARIouZxoI
	sRm7Fed0MaGrEsQmvGB036Kh24y5kJ2LjDtSxx5zkKF17fREsqbcuQLmJd8ACXgrmZj4iuRRvwl
	bIhRHGTs4xUPoPeWUOJqFS3Q2+Feqx/Y7/8o4Q1u0glSF5V0zHnToSCmFhdpROELTIUBqXe7u/B
	HPMe0yxmJYtdCntNIwgHjWuv948M84p2+fxiIAY9lDBvHTqYrK+ZLt/6aqzc4WezdIp95/bNvHq
	vi1QLeBXTQr8dF9OxEYRphP7CT6XZ19jnLVD+eUBorvFolPX0ITYeMuRAdlPBCdL/3jWfnpSMhk
	M/OsOd7MAeunmnqwMjeWZP3QBruRra75xEo2zhjEq0dvGYN4Bno0xO6VPqhXhJsc0sKt1JT177n
	An9n6vw+nwQkyChH1lpcW6ijCQUffwbimh9vHqHUfWkRaSZ1wxts23PBMzU08ZnDUdarmoTA3om
	W57HUK0WTaV2EcTzHUooVHrUOoq1TGvre0CXuvGz9jr4qJgrVJmY94WPXeHFp14+drVx3BADCES
	W7En2aXdlf4vIYsGaNJXkLovTdAekLZQansSDoUj7Dsjc6Gvqj2ROOnESJ/KQ+BHFGC8W56PnOW
	+BO4Se1o+Myf/Es4tUmcEVgOO1HDMhCU=
X-Received: by 2002:a05:622a:98b:b0:535:be07:f31c with SMTP id d75a77b69052e-542b83f684dmr276665021cf.74.1793821583898;
        Wed, 04 Nov 2026 11:46:23 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b100aba28sm32315511cf.9.2026.11.04.11.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:46:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOgwA-0000000HIFZ-2f1S;
	Wed, 04 Nov 2026 15:46:22 -0400
Date: Wed, 4 Nov 2026 15:46:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org,
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com,
	drdeeglaze@gmail.com, James.Bottomley@hansenpartnership.com,
	aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com,
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com,
	ankita@nvidia.com, suzuki.poulose@arm.com, kas@kernel.org,
	rick.p.edgecombe@intel.com, elena.reshetova@intel.com,
	dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 17/20] attestation: Add CTLV operation handling
Message-ID: <20261104194622.GC3889730@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-18-jiri@resnulli.us>
 <auuDcABX27EeTApl@e129823.arm.com>
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
In-Reply-To: <auuDcABX27EeTApl@e129823.arm.com>

On Wed, Nov 04, 2026 at 07:11:44PM +0000, Yeoreum Yun wrote:
> [..snip..]
> 
> > +static int attestation_evidence_request_decode(struct attestation *att, struct ctlv_op_ctx *ctx,
> > +					       const struct ctlv_cursor *request,
> > +					       struct attestation_evidence_request *decoded,
> > +					       struct attestation_evidence_object_request **objects)
> > +{
> > +	const struct attestation_evidence_caps *caps = att->provider->evidence_caps;
> > +	u32 challenge_length;
> > +
> > +	decoded->challenge =
> > +		ctlv_attestation_evidence_get_evidence_challenge_get(request, &challenge_length);
> > +	decoded->challenge_length = challenge_length;
> > +	if (challenge_length < caps->min_challenge_length ||
> > +	    challenge_length > caps->max_challenge_length)
> 
> Hmm, I'm not sure whether this check is required for
> ATTESTATION_EVIDENCE_BLOB_EVENT_LOG blob type.
> 
> for example, if the provider provides two evidence:
>   - ATTESTATION_EVIDENCE_BLOB_PRIMARY (might attestation token)
>   - ATTESTATION_EVIDENCE_BLOB_EVENT_LOG
> 
> might challenge is reuiqred for generating the token
> and this would be marked at min/max_challenge_size in evidence_cap.
> 
> However, in case of eventlog, it wouldn't require challenge.
> for example, TPM event log or CCEL event log.

Right

> Do we need some field on attestation_evidence_supported_object whether
> it requires challenge or not and applies this sanity check per the object?
> 
> Otherwise, to get eventlog, it would need to send *dummy* challenge
> always.

I wonder if we should have two interfaces here for signed and unsigned
evidence? It would be clearer for userspace then when it needs to
provide a challenge or not.

Jason
