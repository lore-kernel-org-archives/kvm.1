Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355313C3F58
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740688; cv=none; b=kYm2n0Tbz6X4b/PuM6TCx4WfI/PSdn93XWGE9WpzxP58nwBYPEFXGaN5Bd9Tl1Nt9ode8l1wmiLx1Xq5u4HeWTfnEkIeizbrrJTItvQGD9MfIZdS/S80h7w5wLlrINISrWtFtG8Cl1RQmiays1dmqB2/5KZeumFPIjLlt+QzeR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740688; c=relaxed/simple;
	bh=FirHhg80SM2Cy3E16gU/PTYMf8PSKE8oZZXWjAxfTyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFUZeTEWN1lvQ7Hfv0/I6y2fMig5BcGyw3KR+g+HfoZw7VDeVtvlc1eyh2wt5sCkt7x7BOeY7ivZ9uHJXIvU6g/T1WwDvgHbM00lkcY0iCXTjvnxzsvyEcud2Hf/FY1imavXZsKj7c5sLOPjUvG/zcPEXknRi3wAd6NsOtiDHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SjetjRAx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SjetjRAx"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c250f28f1cdso116628666b.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 03:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787740684; x=1788345484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2ulPxX+xAmNAkYxhHD7oUU3uVjuocDi4uCbS4PhtOo0=;
        b=SjetjRAx/ENu2gROXqEVOH1JN0Z3YMIlv98SpkwuYV6wCrhIBe2pcG3ocBfHldXVMK
         WcvW8zQF7uA29zXUqPlx8a/6H06zSN2JXPp3JkgmAu74qubMAz3oH/7UI8rWKY1RQShD
         Fe3z4lY7bkKxEOeGwWjJByk337Cquw5mjpnFXBKXSf8R4uo8d7VOJf7pWKA1Kg8/l4Yc
         D3fqKdJFRu161jhWn6L7kzGDsesL6zxQ2QDzw2cJehHt9wC6nxZISh0MwCIOYrDw2M2Q
         IFmErq06UvooVOriXUS2v6Hph/2zPj/sQR2VxT2oii3iHinAt5qCTCzY5FGSO6xZebPU
         kv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787740684; x=1788345484;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2ulPxX+xAmNAkYxhHD7oUU3uVjuocDi4uCbS4PhtOo0=;
        b=ESbAHQ11IYkgzLd0KgBrfy4q74C+Y41im/DvDLG8qTTqlOhlEy2ndxZ1DydKtOc9S6
         RHe9E9AE8PUGtwyqTSfBAmzPHunlwGDQL4z8cTXMJzsbneNXgeDUoYkpga+ARdTUqlwS
         tC6ipnfjJfltRBcz0WdKxXbcbaOsYvK2nQN3RoEatinZfScNS4StnWlcCzSa8i/t0fTl
         yZjjUUpVQn52C7IMtfw/tu1sX1S+2ZxoqGdelK/wuI9cMyrOezx3jZOD0CBrRfI6X5m+
         Rxj7aT02MakH2+1bqElqg1nvAnLXAFL0sOUqIWP+yyQeyNCSImJG8GKp1vY2mQd7sklM
         5E2Q==
X-Forwarded-Encrypted: i=1; AHgh+RqV7zGN3ge6YgoilkuLw90HPxUW7p44gjU+nXrO7jrbUjQqCBmuAQxbRSeCzFOhXegX2jg=@vger.kernel.org
X-Gm-Message-State: AFuF++mhUvlZb56RWrYJgMTxxg3bjTNydzZ64AP3k7SJWI6j/MsS8adL
	0bATpF6bvTZqIfZsRN9KSK2B+gTfXebuuU5eU5rpV3CRSMb1NNzhDTjKooW1tXuWgpg=
X-Gm-Gg: AR+sD10tU9BbZAIj4oLMn9lyKO2cZmzzVaG3Av/0gCsMykGvwdoM0VvEA7HaBr/67dP
	EQmVUhss3fsBAJ2yYxrjMG4/XvrXIFrVWgiEq/IEJ8i76ynJShL1lj1m1iZGiFS6kOYqM+A4iB3
	/VN3avyxskEgeuABEiYiMuGTCmT+/7GTi5btExZzPkRDW1kUTAw+MidoEfccIVtH2SSOLFuE2Bn
	70d50VVd4gHSMIgEtXNaGABq4rHEjIEYTRQUkLV8IPuO+G1bUOA1NDRIa6UzcEAW9WJeP2nNyu5
	JuMWY7JLIRXgLVzuRjYuZMH2+Dze4b+K+MfvcZgdQRc0oKEzCUgf+1MpTqgRosEkwCxtr4IKgB6
	i5Kc+lIPlZLRyprC1clQNXHzXTSQ9HPIpXezXKpobNLX1hVxKpFcIX6FBdJHRKTbBW8ZStdnLis
	0ok8j/gTU/ljZE9oKFn+RziWSY2NXIvcP6V8RQ4whNOk1s8foXwK5LJgdYrPHAII8=
X-Received: by 2002:a17:906:ef04:b0:c20:af9d:454a with SMTP id a640c23a62f3a-c250c36aa50mr709758766b.16.1787740683782;
        Wed, 26 Aug 2026 03:38:03 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.207.128])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5de8b6412sm3539135a12.2.2026.08.26.03.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 03:38:02 -0700 (PDT)
Message-ID: <55105419-bd0e-458c-ae47-90859fd78da0@suse.com>
Date: Wed, 26 Aug 2026 13:38:00 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] KVM: VMX: Make handle_bus_lock_vmexit() a shared
 helper
To: Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
 <20260819094903.3060020-8-xiaoyao.li@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260819094903.3060020-8-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/19/26 12:49, Xiaoyao Li wrote:
> Move handle_bus_lock_vmexit() from vmx.c to main.c to make it a shared
> helper so that TDX can use it for Bus Lock VM exit handling as well.
> Rename it to add vt_ prefix to reflect that it is a helper for both VMX
> and TDX.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
