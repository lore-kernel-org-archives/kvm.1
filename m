Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095400;
	b=Kuu3yXhxVKENG+Rs9aEIvxT0/W7l7m/UqvaU2YE/1TZHOIPIwhn3Kh/IYTPB5CdZaah8
	 4HrDJw10RgfFgAob+z9Fx8hISMaq3gxdrakl6x/ItVIJdYQ/tyRVRKXNGVR4ej95SDZpV
	 NuWzqmRV8caEhj8DVbd1s1O14MhikT78CnPhYlwIvvHd7trm2fwKyxC9W5UGH2wSFMOtR
	 pewU/5NM+8J2NCLS6RzVaRmGt+GTGAAGmHwB1IchOyHXbjbx7zGTCIsxG8mXRWdEO/B7f
	 fP9hH/2b1lh38jUwCrZ1PdqNbKx+Tm7mVw4W5fwtkPPxuRoXgQIvJ5KZcFr3b7jxz3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=B/ZpDq3DjZV/62zmns9uwG24EjevmhON4QmJ/2QUaFc=;
	b=bNWT5zVAccDHE5XcaZBW2qa7lAOHMJ5I4ri2IJCJZym4aKYxPU4w1l0155BVs/PrrDwq
	 8mAlYMgQ0+4ZG2RdpvhnDpJTHM+BSFf1KK2YVPJtyEysZJ3woKcQSGmQJcdK0qBp4JMQw
	 YvuELuLjHQxsDLzQO+xzHU7wTlIvp1rK5jn7wCwpuZqkEVHBKDYsp3h7cCnzRMEXGgdRp
	 BT8f8EzDHDcwZOKP7hmsg7GonCatU8hsIcgu418fGBbS4eFX/fqMXA6EE3gT4j3Q+Qk7w
	 LQDHIJfGS6XtMnY4fAv33wBYQ279oZor1Oss8bJ/DO6RKbPXlYlkBMY8zqrHco14N2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=EKwpsigz;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719EE606A31B
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 10:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 719EE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=EKwpsigz
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c418e215671so504449166b.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793095393; x=1793700193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B/ZpDq3DjZV/62zmns9uwG24EjevmhON4QmJ/2QUaFc=;
        b=EKwpsigzwDmZPRkvIpX1b4c0/rz7uhtPntV0JfCYEz0s3pcwkOGnsL5Nzc3IENmwos
         3sbhs5QgQhWDLpAOwIEmEB+wgVol0pjCngvClscZPLVgXpK6vwt6ozQLK9jHaqZpS7Wx
         UAwHaOAiTlSXV7JOhQYBkg+WaE7NJjWYx0Q2jkUKe51KAl6u7hwDCeM2xNigR7jQ+Esl
         2TD+6FVjssyPooQGV77/khcqAuzCs5MkcZsRcYmk+07Rxjllua9OU3dnOSkEIb4tDpCN
         GKiS0GgWXoNCU/s9g+GrCc6/QeqrtOgD8LLSneSwbAfEJ6r0lK+DJ5aWEsAXcsoc+VP0
         o0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793095393; x=1793700193;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B/ZpDq3DjZV/62zmns9uwG24EjevmhON4QmJ/2QUaFc=;
        b=LyUaRWUllxJSrJalJkXPXvavHoxekfTYJPHH0iyGee9K6vQ+6Y8s8huGFmziKYNvYI
         nN7Fty1EKMG31KayDg0ppdFi5lvhqUKacQq2Wgx/u5/Bx/NXE2IF1zW5/X+f1Wte+2Zt
         Tns+75j7/NjC0R8l852O2xYCznHjv1xMz1i4NWQZp52Sb/mD55fO79is69nRAArLqmj/
         BDhbJdXBtbuXU+N8HMnzj3p5hc9KReJFpnVkrSH/zDJOchsAKpnN+RSUR8yowtO4LFWV
         /xcPcYCiy8vsFbzQcHoNAx/6OPoj4f/UVvJWrR2r/3Zgjd/SYyD9gT8zj4GSHr9bbnD2
         b7Pg==
X-Forwarded-Encrypted: i=1; AKwUvBwL5JHUzbfPZfspvRbwqrG/koCiMjP3QOU8ccEYwcCGrJlCe/okxMw8ovslPBNJi9+i/54=@vger.kernel.org
X-Gm-Message-State: AFq9FYJH2gmwMl3xCuHkloYuWbkR3v51ViTplEmMJcf/XiABlTC/+CWx
	RBdsz80z534lgxKfZA4LWU7Pf77isSQ4f6BX62xM/WTUasySDOpzh7rzmmjM4BnOzdk=
X-Gm-Gg: AYBFou07uCSqFI1N9j8qT7VwyTi9hSAoqvtvyTFOwrDFCUzL2b4v0JnAanAr9KfqGme
	Mz14HK13nOUWjuQK1KRFuDu1bdgz/AWgXw2ZxHjd86TGYHAtF9aB7gaTbxAhGjlNDstKRs0N3Yn
	iNopf4NfIc1s384m+9rp/zKNX1QoeWniLa1nq9UkxlB92HhOSDeRkoKGa4B50Xgdg2/xQWaMk41
	tq3Oh2B52YcoG1GfNp/GUMIL6dew47hpVCCXyCpxHGAPI4PLsSYP6SUxSIqOlDFRfYTp2mIQijF
	8PfI4Y7uxjcfn+wjQl/rIirXyD8nf5hWp46yGR598UvKiZkag5Ytyec58MYvd+u0tapWiyGKp+f
	icLI4WEe2kZ+8Ds0AS/vLGMDf4yvaKKfqjfKQ2+sBJJEWtdX8jTSUgKBNdIYVuq0Ikp+KYtt9KX
	KwrIsyRMLg8TTUvvf9HvAuvQzHe68U0xxIYGjO1hZ3y5s10cIqJPV2JEoWYgJMWmPvF3OKgctnn
	jAEI7CS9d1+OW8UUXsrVzVuALgOOhhKqa5HqvI0hPgnsE8RGMCqsJnxqBx+bOf1
X-Received: by 2002:a17:907:728f:b0:c3e:d18c:1d7d with SMTP id a640c23a62f3a-c46bddc42dcmr1033526666b.22.1793095392233;
        Tue, 27 Oct 2026 03:03:12 -0700 (PDT)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd790afasm420098366b.68.2026.10.27.03.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:03:11 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:03:07 +0100
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
Subject: Re: [PATCH RFC 18/20] tdx-guest: Expose the native attestation
 service API
Message-ID: <auB21VZhFg3sDcXz@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-19-jiri@resnulli.us>
 <179302367453.58760.3338436189030317197.b4-review@b4>
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
In-Reply-To: <179302367453.58760.3338436189030317197.b4-review@b4>

Mon, Oct 26, 2026 at 03:07:54PM +0100, jgg@nvidia.com wrote:
>> Share TDREPORT, Quote and measurement-register operations with one
>> in-kernel client while preserving the existing misc, TSM report and TSM
>> MR interfaces. Tie clients to service initialization and removal.
>
>The tdx stuff should just be an attestation driver, we don't need to
>make these kinds of linkages..

Okay.
