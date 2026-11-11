Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410545;
	b=m7NcFugS3+nNj7K4BnRGhz+zkiz279mMWO2OxRX+d5F8t/4Ei1riJINgSpswpYODkMFL
	 DUEleMgUM9+GIroR1ht5Fn91Hz796Y5erXQ05T9rX278glOwKGXeQyiG5XifghRCi5KDE
	 OZKuhNcYroNHZ+ALj5ReN/5Y49EVaBiuXZDl1xvXehPBRaoCO7BlIyqWMP124m0H2NWCb
	 44+UuF4FNwCrrRv1KJTGaHhcXKS7XUaoSfSWfbFAW0R4XHVLoaIR0F8WikAobo1jQ6PCj
	 b6DkjRHqWUYeMNq/q0Y3izqPWxiAXflNnbTYbTKvqC9f5JDf9CA+nIvP6TGSDw/PW3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=xblfOuxc6NV0SU6sUlIxq0fhdsM0ZQjNDfLP52raYCw=;
	b=jXz6L9ngRdhIdno4SX+NS1p4A5DoWxdaARkY6PzLNJlEAAmM3pgeR8YsXqxRdZeXz/GP
	 L9Z/yNYLniN2I6OAKKcgZEsCcwkt9OCbPDy6+bMAMs5BLOhN4Q+MbjMjKPOJ6STXdJ4We
	 PupYZu3v/d9HP0iRWyqbuUeSawSrshQJdVsJG01nDaylMrpCY9e+orJeaLyhcneouIg1I
	 66Fr/JW9/TGM1f3LzPALV7uFFkeLWKKcemTejmJUX6FCwpSKxdyoH9TvKBdHQUFc49TPM
	 pvovzgKwt0LnnwYi2d7aro4P06x4fS+OdDih8bQbwirBI1pp6/o41cj9PA/o6T5WHKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UNj1qHjA;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1F606A326
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 15:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B1F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UNj1qHjA
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ed2c307e62so48724365ad.0
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 07:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794410545; x=1795015345; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xblfOuxc6NV0SU6sUlIxq0fhdsM0ZQjNDfLP52raYCw=;
        b=UNj1qHjA/jLU8w15Itm647g7vy/z7XeUwk6NxyKC0R5f4jcZy4VAr8uNHeRT8po6Y3
         5yd2TUO4YM4oj3kU97Ec4SS1lyBRVT2YPwzrs93BK0BH6562YlaqSRjEPNLqGTpeOarG
         o2b1xoEH7uHDvyIOWLrn4ijFd8r9aOC2CrFqBZqIf9b5W/53S/5NQJXi6MLRzebeiPnN
         l8SknJbs+pM9FJn/aStD/vXyA+nbMUvv151X61RSq4haniWbS2Q7Iw7xQoiaudlzjffU
         DfqSD7mFaE3lno9pVHFYF7rVN84xpz6rNJJV1EfZGfgXtlltld7RWHEGdiVGne0kvRRx
         JRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410545; x=1795015345;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xblfOuxc6NV0SU6sUlIxq0fhdsM0ZQjNDfLP52raYCw=;
        b=euU0GKOyURgfCVmhCtKBRYfUxbf/KO7voTtYBK5I2bHZotpo9ArSPB7hRm4JP5uSIS
         d/asW8Gx46gP4bho0WCB8QhlQSV5kfLOJlK+v5edvOd+VYO4KeAUX+laImnfbxgCItpr
         wWegHXozFjDFqq9PTwABPxTWsYPYqSfX4tbYnjT/P/JLXqFx/i7wLiHNXPoFLHrJiREX
         ftil5UbzUa7sB3bEqnrWINgcUDb9f+PXtleybK65fAdGpzyyJRCQYx/+MWVnc+ijLjYZ
         P5tXnDk9RvSFhrwwIqj1QapAFP3f/4Ytl5JlUhqxH5bmv45zrA5KeDKWEI511pjFgDrH
         0qww==
X-Forwarded-Encrypted: i=1; AL+hErH51WVK1Wk6U3lBb/Zy39fFQMLEDOAWPUyrTLh4uvT+7YchntylsJXw63T1f7H9RlkyNfM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vnoZPr9rnS0zmyqMfSW3iVI6MJNlKo+CyeqSIzh3mOZLRMbjE
	/d+Q5hZdpnaBZyZRuaNCmnpnBJzQuplLW6EK5DLwNttGdkol5XHKWPW6fFl9LxZQWKpg77YUoQf
	RxCqM5w==
X-Received: from plfp5.prod.google.com ([2002:a17:902:e745:b0:2ed:b76a:1234])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea10:b0:2e4:aa09:fa9f
 with SMTP id d9443c01a7336-2edd7a73b47mr30823495ad.57.1794410544389; Wed, 11
 Nov 2026 07:22:24 -0800 (PST)
Date: Wed, 11 Nov 2026 07:22:23 -0800
In-Reply-To: <81872925-d1e7-4f34-a3c3-fea26adc6735@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105-tdx-selftests-v16-18-2024e8fa517a@google.com>
 <20261106164732.3939387-1-seanjc@google.com> <81872925-d1e7-4f34-a3c3-fea26adc6735@intel.com>
Message-ID: <avSILzc_aB4PVapm@seanjc-mac.roam.internal>
Subject: Re: [PATCH v16.1] KVM: selftests: Add support for TDX ucalls, via TDVMCALL_REPORT_FATAL_ERROR
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sagi Shahar <sagis@google.com>, Lisa Wang <wyihan@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 11, 2026, Xiaoyao Li wrote:
> On 11/7/2026 12:47 AM, Sean Christopherson wrote:

...

> > +#define UCALL_PIO_PORT		((u16)0x1000)
> > +#define UCALL_TDX_MAGIC		0xabacadabaULL
> It's 0xa baca dabaULL. I think it should be a typo.

It's not a typo, just a bad (or awesome, depending on your viewpoint) "dad" joke.
The value is a 64-bit value, i.e. there's no truncation.

/* If a toddler were to say "abracadabra". */
#define KVM_EXCEPTION_MAGIC 0xabacadabaULL
