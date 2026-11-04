Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814888;
	b=dN89tQoktEGBjG/w0diH1RC+iqBvU9T4vM6DT5fK2lAvoKzdxbBTI2E1NKuVRqg8+xP7
	 pFnFitviNu9xefJOW3TmCMKVx2w2y6OePD7QK6eK/f59lbKuNa6X6bw8GsvMUDAqd4LsX
	 WjKPYQw/SimJWnA8y3hTrg3GwH4Wt+dcbJZrLXEqYYnjzmFs8580U4d8rTiOPy/TXCu3H
	 hKj0TUOMJnUwLZk9QtEl5f9J6rgizkFYImmi4+9+2p3MniQ7fY5hBmuqNWkCqB6oWUyu5
	 s9E4V20y9xjKtvNXRehnAbs1pGR5W+pzlEJjcC2vsQ4O0n/LBBZRhfTgCYAR1PQbFiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=a8PVgr6ypDrmvyZQYT+mIAJLHr75TSjPc21F4dgd8gQ=;
	b=BgLs9Xca+36WQg9jw6RlaVupPgCCPRytCgYQC2C9yKu4Mti0cY3FFlOL+2X3H+fdANmk
	 tYjwA1OjOpSjfe7NB3GWVU8u7/t1wxCWA5tHicYWdCaIs6OKn498JTJX6ucmxk2flTMAD
	 m9fI4To3pOOcrVNOpMzCHZ4Ssv9LXJyfFhdAKhSjf5vo8/gQvucIiZfhtcOIukmjn2sJJ
	 uDfcycqnnaPoIN7oMBCtcnmgPWko7dO2Xtg5fkbwHFZO92IzPYeuMDUhip76rIGIdo6Tl
	 LwrhuV4xmD6YHM8JAwBtJW+WmQ1sKYAhhhgG0ZGw3887+jAXAusLgaIW5sVT5nUXISQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=INpwrSmc;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864C606CFCA
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 17:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6864C606CFCA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=INpwrSmc
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e635220b4so92229885a.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 09:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793814886; x=1794419686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a8PVgr6ypDrmvyZQYT+mIAJLHr75TSjPc21F4dgd8gQ=;
        b=INpwrSmcSZ3/FfNbUp3Zcr+7zlKzli+O6Uz28XKAuaFHCd6G1aFXVW+Kr3yO5Ukz+j
         ffDXRlN6wtFTSSL1fI87DbOCN5vN+Dc416Nx6rDo4BG87l6cEysDdTsz9/v6agED2t+J
         az1Qc3jEPHGJciuqX8c8qHkclvi7nCxDnvEXRAWlfbwS4b/tczJBghfuvNFFt5Sen/Eu
         CngVW0iXdQ5aqtzO5S5pQGC/GojetaWvMaM/79HB0aZi9AGJnQGdsr25FTscWCuemx6V
         59aB6uINYARVi1TbzM33RDdQMxcq9J/VGqC7mlwisFA76vBco1Plqb7SMZBj/4wLB/55
         +vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793814886; x=1794419686;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a8PVgr6ypDrmvyZQYT+mIAJLHr75TSjPc21F4dgd8gQ=;
        b=0lSX3NEn+W2D0MoF8aAg0zKs+18sBaCyPYmcBy9JC2zil3B80wOM3t4xcFxWnHZynZ
         ZUSkqfWSZzs+juZFjiWUlcQMcsZRhgW8wWHHAbWXWkh/Texkg3taNBLhE3db2/2XXeQL
         f6PDmHWiwzz8CwtRB3i3cRw9TwDIp8Z/sDE9wjBT8l/p2pWXcWrrE4dXY9c7H7r/X7py
         tW6RTKmJV9B3NuXu1l5bfAJ8TGjSZrL5DZrCqRs1GJOZS3ADmOHSr0LESN7E8bdIt2X1
         NWAABn8mtpMAk8k0BJln8bb+N+RlQULWC4BJi5QyiNkpGpM4FxrEQv7JhwJBr0ez0PBv
         OfEQ==
X-Forwarded-Encrypted: i=1; AKwUvBysG5o2LdeOOqt/I0FOV4blxNT5UgOZZeJymazFtCiCcpIDkLWfY1M/oqmUtVZo2gMAues=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LwAmINkkr0XrSx9+42Kbuj8IzcR9eDy3IEvuJy+dv6ItAVRp8
	2BDDNQRtdTq2v4bnE1QG0sRCkX6S3TpA5L/5pUbe8ExJoOt2K4n7U33CZdNy05GhciA=
X-Gm-Gg: AYBFou2oDuKYGLSHMrwDxqt7mya8Fu2lenuqlkpVz3Lyv/jXl/k+VNeW6blgyx9CQmo
	ND8eC+2ZauzEvQbH9Aa3IhEYL5gWUZGvX7wsBbXGea+QPunMS3PWkXXzv3JxMS6myI7eaGJKqTW
	3J7+0Uc8UVBtMy0O5zFrRvbUsew95exrf7RXMaNm9dD0S68tJu7Z1Zm4OW+4K9hRZDvYOSUiFlg
	3Oq6OSS44GYcq3WztpwFxr2F/MUWmC9WDVOTgYybtHGtir/3ZVjcXHtoZt3pITd0tCQNcp/iGgm
	iv/X/87exZD+dxCGnULEBm4vU0NpkoNTuimnr8UjFur0QaU8yq1pU47bzsOiRk9iyFVV5eaULz2
	9rZRo9pChfBhS5ixhmm78BcmZFgTTkPBbERq3ci/N8S91a7uQVUT+vWjh71aWNCgz4PBhc+hJ4l
	BnbTUgGTjdrit/eXLblMmC27C7TEITwE3fiu9CfHT+MCOdWorWNqKBQeJDl4kfOisrL3dfwOa1h
	bCXOBeBP8K3L6gjizeKk4oNg+WIkXyjQgFHhWm60YATGj3fkztx84tK/OcGgpo43Bs8odwjJF4e
	tVoUstWFlLBYiQc60XD0oItKv77wKgTeb9YuS6/8FiT3tGyMZ9H1oiY5a64ztxIqGH9Ev5vjK5R
	ks8K04OGrzA==
X-Received: by 2002:a05:620a:4155:b0:93e:d364:c9fe with SMTP id af79cd13be357-944216970cemr2702179085a.40.1793814886203;
        Wed, 04 Nov 2026 09:54:46 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d479a7easm257041185a.12.2026.11.04.09.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:54:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOfC1-0000000H1Y6-00br;
	Wed, 04 Nov 2026 13:54:37 -0400
Date: Wed, 4 Nov 2026 13:54:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, david.quigley@intel.com, lukas@wunner.de,
	ksinyuk@kernel.org, rodrigo.vivi@intel.com, cedric.xing@intel.com,
	sameo@meta.com, drdeeglaze@gmail.com,
	James.Bottomley@hansenpartnership.com, aik@amd.com,
	jpiotrowski@nvidia.com, qinkun@google.com, pgonda@google.com,
	jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com,
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com,
	elena.reshetova@intel.com, dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 14/20] attestation: Add the base family specification
 and generated files
Message-ID: <20261104175436.GZ3889730@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-15-jiri@resnulli.us>
 <179302367452.58760.3782556786585774917.b4-review@b4>
 <auSxxPM5z8BzgNm3@FV6GYCPJ69>
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
In-Reply-To: <auSxxPM5z8BzgNm3@FV6GYCPJ69>

On Fri, Oct 30, 2026 at 04:05:13PM +0100, Jiri Pirko wrote:
> Mon, Oct 26, 2026 at 03:07:54PM +0100, jgg@nvidia.com wrote:
> 
> [..]
> 
> >> +
> >> +/* attrs of group cap */
> >> +#define _CTLV_ATTESTATION_ATTR_CAP(_attr) \
> >> +	_CTLV_ATTESTATION_ATTR(CTLV_ATTESTATION_GROUP_CAP, _CTLV_ATTESTATION_ATTR_CAP_##_attr)
> >> +
> >> +enum _ctlv_attestation_attr_cap {
> >> +	_CTLV_ATTESTATION_ATTR_CAP_EVIDENCE = 1,
> >> +	_CTLV_ATTESTATION_ATTR_CAP_MR,
> >> +	_CTLV_ATTESTATION_ATTR_CAP_MIN_CHALLENGE_LENGTH,
> >> +	_CTLV_ATTESTATION_ATTR_CAP_MAX_CHALLENGE_LENGTH,
> >> +	_CTLV_ATTESTATION_ATTR_CAP_MAX_TOTAL_OUTPUT_LENGTH,
> >> +	_CTLV_ATTESTATION_ATTR_CAP_MR_FLAGS,
> >> +	_CTLV_ATTESTATION_ATTR_CAP_OBJECT,
> >> +	_CTLV_ATTESTATION_ATTR_CAP_BLOB_CLASS,
> >> +	_CTLV_ATTESTATION_ATTR_CAP_FORMAT,
> >> +	_CTLV_ATTESTATION_ATTR_CAP_REPRESENTATION,
> >> +	_CTLV_ATTESTATION_ATTR_CAP_MAX_LENGTH,
> >> +};
> >> +
> >> +#define CTLV_ATTESTATION_ATTR_CAP_EVIDENCE _CTLV_ATTESTATION_ATTR_CAP(EVIDENCE)
> >
> >I feel like there are too many layers here for a code generator..
> >
> >enum ctvl_attestation_attributes {
> >   CTLV_ATTESTATION_ATTR_CAP_EVIDENCE = CTLV_ATTR(CTLV_FAMILY_ATTESTATION, 2, 1),
> >}
> >
> >Do the intermediate constants add anything?
> 
> True. I originally had it like you suggest, I changed to enums to avoid
> the explicit numbers. But you are right, does not add anything.
> Changed back.

I was also thinking that having the explicit numbers makes it more
robust if someone does backport. We should try to have everything
explicitly numbered in these generated files to prevent subtle errors
like that.

Jason
