Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587896;
	b=bLSRNh6T1o0QjeGzYuKcPivaHAHvJFFsgJK+qLVFCMKa+vcOWnF7a8GUD+Ds8wIgmlAn
	 h0pMyLzHkVdU6a72bcgjTwAF/rHlTJnEW5nfJe6e4YWEc0qwE1/ofuxpXf+DTMCmnj3Kl
	 ppS0MJROYcAFCKVQw/S+/EAliur1RJvyhZKiSutSM2uFKdMCv4CXEHWezM5zFTbt0GEyw
	 vXRAr3HPhtYmF9vIW365IbB5pbll54zjIrwJBK0WYNl/zDoCF6oLInYhcyekPSCxu0lKg
	 8rRz0om0vD/KYiuz4stOGrdLWUnb4rMeP7YHk6tXq197C3GVl2raJPXcZ1+yQg1J9Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XBJOZdPNJaWBnEXbMM9r6oKBxoRWtijN3lb4QnOPdPU=;
	b=W374XyyieUU+xJxJWxLQ9B2hJtp4a62vxwqtaMIEhksfCbH2dr6ZVo2lB9Luan/IFzNB
	 6O5WODpmZrclWtdZNCM9+0mFvKRlLgfvK64Tlbuu6WwKDjYGQ67ZEHuCpt8zEK6jaLG+k
	 G8FplzZKWziD15yTESVMvixs0GWsAR4CAFxYxjpw2uqF8lOiZbun4ppfpN8rr14r6DnyK
	 fwiZVNrL96TxhXBGYsLQ7temQfLEnRFlqJa7FwPxX7LhC/Ep/oW+iCMGOT0vVU2fTiVk3
	 K0GHmClqLSFF2IVvJyMVl8wI5m04DpYW+ULKxvsTzFyPMFv8+sEw/lGADiJ5LobbEPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=CFLBbsMY;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62693606A31B
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 13:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62693606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=CFLBbsMY
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1e3098ee2so8095965e9.3
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1792587893; x=1793192693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XBJOZdPNJaWBnEXbMM9r6oKBxoRWtijN3lb4QnOPdPU=;
        b=CFLBbsMYwkrufn9yAq0dSA5Z2c8I2rI4qRFb2c71CsfhYTuPu1XRsLh69ZdtqYM98x
         9C7RY1x4yjmLKjlv5JMunmxpuiHgr10OI/zCMoNcmyFwjHLmzfgUNQ8rWUEAJRoNAgPd
         zx6f1rQ+q6QLX+7BmMwMlP6A/8+Oc5Yrau5gTZOanD+1ts5Aa7lgDfF10KVx3gHSb730
         rAnUJJ7t2T2AqgXlhscveNcqek8YMjE2eKzx6NEQ7hcihBA0/X7uvPVcD7TOMvGRg+CI
         VJqsYeSAGOgzr7gowdk3glF2ev0bFVuPoPFN+QB9wwVANRdfS5JCQbZWv6FroeDwvu9l
         NhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587893; x=1793192693;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XBJOZdPNJaWBnEXbMM9r6oKBxoRWtijN3lb4QnOPdPU=;
        b=TMMwG/5EGKKSmbiy7uZDzV7kRBDKkh+qCYqQYWgAsufwiy2OJGOG/bTmDI/f1dAije
         h/fuAJ/ENCyHZLZqjdrOVZNWLfrN6Wf/IS395tmv5k4fdlxTrWNi4Nm/jX8HHPmEvMvj
         GkLnjvhABkbuat1LbJjD8wPfQ6BozzcNoskiObzR11LRa/RSPXRkdMSwuqitwe70vNZL
         pUaXjpIfCnkYUF/VwOugD+PeIE78wOyuGMZm7AE/FNo3OgNiwLRgxORoxYs34OTFGDCi
         KillIJpzkqqGTIuySs2aKFgYpEJN6ypaTmi0hXEXqhABLjhDq7PctYZtsRGbPdgmY4AV
         K0Sg==
X-Forwarded-Encrypted: i=1; AKwUvByUmKUd9gsCnLL8RayHbwAKUdU2rcAsmYnmP9JbUdCCDI5gVsv0izqjyZYZGEZMZjFznHw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJx1HckNkx4u9DgEVLqsQCKK/7fGMvrgEkQ4mMm96uQaOhO01aF
	0npbo035Qf/3tJYeCRXz3qH9g46b40hlQulfIcr0BLCx4GyIGLoYsBXNHsqa3S/59tE=
X-Gm-Gg: AYBFou1IL4XktDIeGb56X2h+UPXhPVpxMdJyMSLSlY2lEc7nq/Dw5pAdvSWFyK/ijWK
	1ICpM+DTn6Cp5BzpQ2gJYJx3cm9d1A6qbd7hq6S9N0raOlufmZFTAtxbnxaH9HUSa/p6nhMLPng
	dpI9o9cRRD4vGW6EbB4a0nCeOeruqskOn2b1J7X9rsP8vsEfqII+XhOvTSdxT5kdObyf5IJiWYV
	dI8KF+OJf9k1NJiC2OK+CA7x2ECAaylkx0fzG0E5qXnM0328SBgaESn0CtrFHMS4dj8rApps9kf
	DiYwx/VI0OO2DsJcwn+qj+tl3/M9Ma0XWRCrgJ8a1f/DAHO8TRo+Dj9ixUkidv8qOwf/0NvvCyy
	uwaH614wk5twcPYuVWUyIssMTj0c7iHLGXHdv4NlovaYqwKbBVbn52qQnG8caYt+K7yujwYnZVN
	NP358mvrWMoBkqEfx3M4eV0bkFl5XtmdLzccEbZKQ/MbcKcasG0zG1a5vAkomJCA60hyZ/VsUpl
	IFqNy5pXd+lqcpcjr4w8caMyEjim/rSsjovLP9zT/py4uhePyKDDaFOfC9Z7psr3QF9wNekkfwQ
	Y/KAdMPuf8Lb
X-Received: by 2002:a05:600c:3512:b0:4a1:e00b:a0ea with SMTP id 5b1f17b1804b1-4a1fd8a3fd3mr39461765e9.1.1792587893167;
        Wed, 21 Oct 2026 06:04:53 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835c77sm5101952f8f.36.2026.10.21.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:04:52 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:04:49 +0200
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
Subject: Re: [PATCH RFC 15/20] attestation: Prepare provider and instance core
Message-ID: <ati4arl9sf1Rgnob@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-16-jiri@resnulli.us>
 <179245258506.58760.1633805100070716498.b4-review@b4>
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
In-Reply-To: <179245258506.58760.1633805100070716498.b4-review@b4>

Tue, Oct 20, 2026 at 01:29:45AM +0200, jgg@nvidia.com wrote:
>> [ ... 99 lines skipped ... ]
>> +++ b/drivers/attestation/Kconfig
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +menuconfig ATTESTATION
>> +	tristate "Attestation"
>> +	depends on CTLV
>
>ld.lld-21: error: undefined symbol: hash_digest_size
>>>> referenced by ctlv.c
>>>>               drivers/attestation/core/ctlv.o:(ctlv_attestation_mr_read_query) in archive vmlinux.a
>>>> referenced by ctlv.c
>
>Needs a:
>
>+       select CRYPTO_HASH_INFO

Ack

>
>-- 
>Jason
