Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268307;
	b=GR1wpbohl4civ9Hyox3zpNFe1qvyUYs21EMdaT638aJg9zQ+pa4M8bKQ3DIz6mN2aXP0
	 t1Y2wx1xAl7jYYrEcleriDbcOouTWSfoDhR9NJubItrC9Bpc7gd6eCBAtxI/+2ucMR5zg
	 Dx3s3LNStXt1Z6K3x6S4tJdtSa8S+dFvtVykg6WB8pL4arETlIrGLBEEoaGETYzTFBFaX
	 fWqVer9Ljet9JtdAY69LgNoqLqkN6pYb3xhka72it+LMwN+pTDs1pJJW/Mc2bRRldFt0n
	 RgejHytw4wPcNVKxTxmFJttvEEk6xHOA28S5T2EENuV/Nqa49fSrIlES4vrSbj38n6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HZ9giMsL3tTbnyDf/k62OFthNCmQXGHyiD+KvibTtRA=;
	b=RprUBJnZoNTnCrt3tZgHr0Upv+pE6OpOt+V0Xcozyry2ux0d1cZ+ixSctp6+XC7Wck0x
	 dXus1pDgGIj3C5Bngi9LkPylyomrLXs/o+uuYhlQ5j8b7ZbPTlTC//Z/TN1r+XX6SYEj9
	 xPGfB+VWgx1Pnv9MvOn+kjkM/V1AACOuQEmCJnLe6KdVMvkF4205bKwcz95HVGKVSOOMR
	 AHp5eC20KAveHcJFXEZvgZYU4SM9yHWis/n8t5WTLYlW0ciBiD1BZFzlzPcNzUZKb7uN1
	 NoLT8gBJfeFxr+H7WtQhLHXycb/nkapD9EnX2JtpiVNm0cxj+DIgh+eD6lk0k/5YdAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=H1R2lLqH;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC2B606A31A
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 10:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFC2B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=H1R2lLqH
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c169ae1cb26so84678066b.1
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 03:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793268304; x=1793873104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HZ9giMsL3tTbnyDf/k62OFthNCmQXGHyiD+KvibTtRA=;
        b=H1R2lLqHn2Lr6k+r6OdZgfppHvcjyP6TZWTLyu5FilYMTbK3u3CZpeuCjjZIdi4jnC
         0TwveKR9jA6jVTkHNUrcAW5Tw1tmadniatMZ/qV5n4QHz4UpZeLMCH6YQcpCWNXHiqxm
         sw8RqXVy0A85Vy4bcECMhm6L0/zQylmNx98oc9kMhu0oZgHWGKa9CkqcG5v4I07BYGt8
         CgLVdi11r6LTfqrelvyydvPWPfjIYWzxZUqu9juiWWPud6Vj39Og6UeHebRhF8opkpqo
         QTVfn2BUYNe+MeNX4dHVQkUb1CFSbYgbCR2R0c9GD4Um/2KcLIxENbQuIx0sssnOk+oO
         cWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268304; x=1793873104;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZ9giMsL3tTbnyDf/k62OFthNCmQXGHyiD+KvibTtRA=;
        b=1I1t4skBNI8YVzCMF9VzWlpfASFBpG/ODWvhwLILsT85PNBD6QAlQZyu+0v30blkPK
         0U4QZNVOkyDFY3oxUBDqj7vuuICyhpiKAAh3gJgYus3MPrlQrTRGpFNSMr9Nzt30JiP1
         MRbT1tnuXDMNLtuRneQo/4OB1zn/jUV/zBldxIHJDs4ioYIWGmj4Ciyq5daVScQ+ghMZ
         woIlT2gqMw0m4cr0UvDe+xcYIGf7T1ZlsEOCgp90bXFt4U1sCwj1z5tJu7apv3PCVJcW
         HuQlQy29lRNd4cg4nIWXE99VDf0Bl5J6deCS4ziRTI5R/mowgO4XTgB+W5HGzEuYb2jV
         Mkvw==
X-Forwarded-Encrypted: i=1; AKwUvBwUgwbP4BbteRwbdRVyRc+o5nRdGawoFMpS/2m+5d8LaP75vzIrB3aS3ZDD+iUZ+npVgHI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhLygHB4fXQLaKjPfxZC8GOWZkosHB6Pe8pNVt45DwL3b6tU2h
	IKRuugKBz/KNMThlcpmHldxSlq6yvmWoYiUv0++GAZTdr77DLV5/QBf1DlPUovlHGbo=
X-Gm-Gg: AYBFou0koXLgpO8fJPU+SaGLznbNzPfOkchwZq92+7pZKULEiT+6WthUC7GGvbRdI+Z
	ORl6X5j46VkbqvNwvJUulW44NF7IUlOoC0VipzJVX/ve1UOaqmnfU2bg0Tn0LKmWCTW4JG4DENU
	ULp6msObTd3fHQrPyc6E/l6oIdfAwfMRjlMu2NQ603gBZ8tLPlTk0jumbsZFZX9n9YQ4d0Y/a+T
	tQhp5SaPXf/nVFE7RNDfe1WQ2ht10tnAqLAZ1lb30aYO9YHMwzPwp41eRKZG8J6+iTN8muVOGno
	JNsm3wRBB1KTo/GUttzA6PXJS5h+yGekgGfare3+gbHsw7vw+UbkWC673BS9B8PDEp71OgCSB6x
	9hh70hUNHI5PCz4qlDdnjec+t/jRnDHk8MAB0QT1Q8v07ef1pdBi4t3KM6dz0EnIDE/eevLtS+K
	ObRkL8INelcfw+zA9n2XkPElwO9/Q2bI2EPXh9ZelWy6vgHnWF1m/hALgnFZ+14cI24NCr18rpb
	PcwSBDnk+k1OT4Ed2Y96RPc+PDCictmza6gSbSYAoyZSHa2qq4K2o/6djU4DOWj6CrEXxAauNQI
	HTWsuXVpbzKYQYZu5Vz2sycyjeaNG+D1LQFoLw==
X-Received: by 2002:a17:906:ee82:b0:c25:4d9e:bb28 with SMTP id a640c23a62f3a-c49d10fc56bmr194240166b.3.1793268303706;
        Thu, 29 Oct 2026 03:05:03 -0700 (PDT)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd7abf6asm705408566b.81.2026.10.29.03.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:05:03 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:04:58 +0100
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
Message-ID: <auMX4kbsflE9kK3Q@FV6GYCPJ69>
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
>=======
>
>device-get:
>  request: {}
>  reply:
>    caps:
>      evidence?:
>        min-challenge-length: uint
>        max-challenge-length: uint
>
>Did anyone implement a variable length challenge? That seems a bit
>strange. There is also a very important crypto warning here that the

Yes. TPM2_Quote accepts variable-length qualifyingData, represented by
TPM2B_DATA with an explicit length. This varies per request on the same
TPM:

[1] TPM Library Part 2, section 10.3.3, page 136: TPM2B_DATA.
https://medias.cdn.trustedcomputinggroup.org/production/Trusted_Platform_Module_2_0_Library_Part_2_Structures_Version_185_pub_c0a962a931.pdf#page=136

[2] Part 3, section 18.4.2, page 158: TPM2_Quote qualifyingData.
https://medias.cdn.trustedcomputinggroup.org/production/Trusted_Platform_Module_2_0_Library_Part_3_Commands_Version_185_pub_87a5c10230.pdf#page=158

The PSA Attestation API, section 4.4, also requires one implementation to
support 32-, 48-, and 64-byte challenges:
https://arm-software.github.io/psa-api/attestation/1.0/api/api.html

FIRME DEN0149 1.0 ALP2, section 8.12, Table 8.23, page 100, likewise
defines an explicit Platform challenge size parameter in x4[31:0].
FIRME itself does not mandate the specific 32/48/64-byte set:
https://documentation-service.arm.com/static/699c3b70b60ef220b14ec14d?token=#page=100


>userspace use of the challenge must not create a "signing oracle". Ie
>do not pass naked network data into the challenge..

Agreed that we should document safe challenge construction.


[..]


