Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60EC3CC334
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716027; cv=none; b=LA9PNgDSj4N05bMyIl/Uy43+CrawVkhHJPxkI38ikQVygjSq0JgKZtBiaTWMOZF/TkJQVgmmXAfoEtH4GXToovV01GQ+7W06+MqoZNTKUj0GrJ+CoAM6OWQlROBwdWHyNba8i8lvlPZp36Cwga/11P7q+ellNGGCchj2iL65ee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716027; c=relaxed/simple;
	bh=u3h1XlBKUyOhQQdIqN2gHXCZ2V+PLN9tqAwOY/m6VKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwoIgxB1UyU5StdqeII/A7qi27h3M/Y0cy7u3PaVUKdqMbGvYQB/YNBq4sZXlndholUoms3odVztLXvJq/WIDXv6/mMiMDGN7lQf0b0dUDrg3Is+lgt+fX0c/CZzr9/kzmiJoT954LlL7L0xouCYBVb+8232mAg3nB6sZ8v0a7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PzC7Qm42; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PzC7Qm42"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c15849aa2cso9972782eec.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 16:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778716026; x=1779320826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1dTtyx56dmdptWW7fL0zJHHpg7+OJhF3h84I6EXdjo=;
        b=PzC7Qm42TAx9EsF15bvAfQ1jrtB6cORW3zj0n153EhVr4tZ+agwu8c0kAI6C/ahg1q
         J84zg6RvcR8mOrkvssUUO4TB7oWpFziCOONi/naNruk3HZhGkwz1jxkxZOtYdMSdYtmh
         fdlh/AfNg2L9mugtgZ2ur50Kwnkb1sQQmcoNekpB5vVSQ0rL/EN7yLtxMDHjlZhrzcxx
         zWsjcBpI8yq3reaFUg13wwMpW8vOOJ672TOjZ6xKnv8dTIVOrbgQ6vaEyn6TZSZI00Pq
         Z62/84YAqxZ8hACTU/W0Ackp0TUbz/4xMVph/Obiw8C0SXHmiefyT3k0wHDM+4Zkunf5
         6AGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778716026; x=1779320826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1dTtyx56dmdptWW7fL0zJHHpg7+OJhF3h84I6EXdjo=;
        b=JBs5c55LapPgiq/eeK/l69CZ8DX620a4nqIOFBxKUSIxHXc5yjd9hUf7jnWUuDbRUV
         oiW+nfuNspBn/SYzVye6/orG+NDRW4AcvXZiwARkUUdP0Qbhub/2hoEVM4cYX33GIlY0
         cgEA9t2nSQKCqx8ga+yEzCq9Jzb/yNTuX9A+xDmrqQsH2mNKBsPYOKfTRmAMoqaISWad
         rtVQ/+uzo8AvkoAac25gw1QJJHu0HynGb0PEBsvlU9OZE9RK2mLRFtjzX+1XMEhaJROq
         o8IJsKGjwkvixiFO0/VNT4wHUGEyMTmd5lhlv9ZPXUSe+RS0dS9ExUcqXSKFp6wenk1c
         owug==
X-Forwarded-Encrypted: i=1; AFNElJ/YYDOjcKuQAntWnr5Et7WAF40Hu1AhlSFQaDAXJvgARvBXg7574VSAHtpsv5/33YFEncA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcj9b8QrEDlVpeZd/Ho6s49q8/wlbr6klwEOquEwsysROxipH
	bOsqhjRU1CMjCWvbxJeXf55J3P8F66g3y65KzUvLIsKqjlZ39K4w9oqEgv/iMkM9Ww==
X-Gm-Gg: Acq92OGKNmLVRMXXZt2WC+8gPIA0jNO22VievnEaNB4CgM2Q5PCPowSUGFymfohbWbZ
	oneu90VgDVaSb5ucSOApbAEqpeGbuWWUNQzw1OVstoS7MiF+/gAvfZqrVduB67bMylF4gOwS7Ka
	tW1lGZIKBXDZP26ExTG1gApJSYoBoUDGXIpSfYb0Jf7fL78Dy75jCfH77TIxQUs56Ng6fIR/JtS
	CjMoDr5nYbljC1It7CfuaEVdAg7SCdACPGzT0fNDBKltA3xx5OwtvJ3uLw9J0jJ4boyoH2arvP/
	2VmpYzKox874eOL9w5gFCwJ4WUvnI2EGfAGTkN38omRK3xVHlXePQwHTF4BcleY+82zaBIRy/oX
	dX+5YjJAIPZalhr1O5G+N0KjXpNTLYM/xuAme1q6mrySrjsyaRpZ73h0DdCDsh4yyW6/HzaginW
	2vSePEkNmLAd/u3r7l+nSExva2Bt5ChFowjpL8bbliV4RSUM4azT9ehi6nOI4O1cYK76NPxVsqS
	BalxbGSKW0=
X-Received: by 2002:a05:7300:d706:b0:2ed:935:aa33 with SMTP id 5a478bee46e88-30116e95062mr3518837eec.5.1778716025274;
        Wed, 13 May 2026 16:47:05 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978b1a79sm934080eec.28.2026.05.13.16.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:47:04 -0700 (PDT)
Date: Wed, 13 May 2026 23:47:01 +0000
From: David Matlack <dmatlack@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>,
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/8] vfio: selftest: Add SR-IOV UAPI test
Message-ID: <agUNdYHm1xYFPKiL@google.com>
References: <20260505212838.1698034-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505212838.1698034-1-rananta@google.com>

On 2026-05-05 09:28 PM, Raghavendra Rao Ananta wrote:

> Raghavendra Rao Ananta (8):
>   vfio: selftests: Add -Wall and -Werror to the Makefile
>   vfio: selftests: Introduce snprintf_assert()
>   vfio: selftests: Introduce a sysfs lib
>   vfio: selftests: Extend container/iommufd setup for passing vf_token
>   vfio: selftests: Expose more vfio_pci_device functions
>   vfio: selftests: Add helper to set/override a vf_token
>   vfio: selftests: Add helpers to alloc/free vfio_pci_device
>   vfio: selftests: Add tests to validate SR-IOV UAPI

Looks great!

Reviewed-by: David Matlack <dmatlack@google.com>
Tested-by: David Matlack <dmatlack@google.com>
