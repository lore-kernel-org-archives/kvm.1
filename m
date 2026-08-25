Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C9144AB70
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663099; cv=none; b=MGMhSbtbITLYtquVGEdZx0xHA2ZMzYqkXxuWa9lw9SeRbTfs3NUb9yFm39fCEcKseYfIfFK6IPfpi/QNlw41ptQ+wQCO15Fw5aLkU/FGZ+HwVUOlctZmxhvMIDnKoHQRTuwMW/G5e8jPy1mnE3U23lqhHNKMSy4gsY4HUHQW4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663099; c=relaxed/simple;
	bh=S7aRfssWDQ2nLsCC53U4z8DSCtzysrcHj28aPhwBZ4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcERQBGRpqzbslxy0TDELOhCsO71x8easQOZ9pB9V1cJcCWKZNFzoX/SFhdHabHjwT14zMfgFpT2M7BthEiR8NprpJEqkJ6TnVVdFiAq4viKR4fZAM7L/imjHb+85EJUIH/wn8LEHat8KUG+XCe4hxblMcUNK08qaBtwlAxV3qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGp+ZJsH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGp+ZJsH"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso668280466b.1
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787663094; x=1788267894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PQylkDyhUMfAxwzHJuOU6RYKfPVocoG2MM8Zczy9TIY=;
        b=DGp+ZJsHpOzEwmDDv9uPdMPFecT4Ce+lOqvmEIAuv3ee9xYwWPJSnXDZB5E7J4k2Te
         y7/3qvMCPNnR8iVLWIB0MT9Z9qgL3VOAR5gr1WyXFhLlTL4nH7Na0bpds6wdX8QgstrR
         HNNfi986llysKm3M4vHdn/uL0zUY/rsZTGTtbptp1zTL9KdZ18xRqY+iDxCPhZl6VQUp
         FgXlHHFlgsVGd/GTZU3s656V8gu5rrvCTEGiiWvLZT5iJciOLFVVRgxzfcz7mQ/Lt7AD
         zL0s6njA33BARbtcW6nR7mupo/jJonZGGl5ECrNnx6sp3V3orF4wWMSuenwpRrf31619
         WvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663094; x=1788267894;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PQylkDyhUMfAxwzHJuOU6RYKfPVocoG2MM8Zczy9TIY=;
        b=iSi9A549go+f7ylQNILLQWMTJb49TWGLhpL/pgNybvwzCocZSk3n9S7E/vxAPMIRo/
         P3FLYJTmyyFRUJ4n3ysDxKIz5vQcw3bXxKyqmoDf+N5BsN25yp2AYZZO/3rNnSr+W70k
         cYDwLL/vyO6vg6AHsi3tmpApuRKblHKBovk9l8Wt2tusXrCKHmNPH4T5EMvqUUhP+aQX
         PO+y+HAmf3EF0wJypBbNn+m+4C1W74y4kGnKo3isoCPPQXwFIIYqMzUBsXmQxAp62Zuu
         ruvM0RvJE81akEnsJjBdWupYQwZd9OcLlieaNaaALYTbhLXnDh5KuMLno2XcwlinWvdj
         exWw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/kAX/fmmNPCUmJ0lCQHKKTqvdaLjKBHoAfeN90hO2cIan9j42dLKJXQPMzoaLte2IOGU=@vger.kernel.org
X-Gm-Message-State: AFuF++kSK7D4JsK35bmkd89LEvNgjLISX9Y3kPi0qnE/JTDZWXzM7wfF
	ysFykKex/y7I8Nea2aHzc3qABU4BM7ZdSwQOye2CpfotP5pLGvBoAsKJ
X-Gm-Gg: AR+sD12a9ehZxJ79YA8ZOx+Sph7YBZy16KAjRRucNuITOTceZuNw9r1llj9nTlvdfpq
	2JmV2KzvD800TiDDszZlwGJVUUIyBLwv2SNBLqwIWNKhskUMhZ6YHKCmf46S3F261gC2bfFFcQ/
	UQ7W4roEzXvked59Qu2dRnAdKEja+N1Tl1aKvki2Hlgo/4ioLAqpKejHp4ivxuhYAQxyC6mbhFl
	IlJRhwymznIVi9cV3HS8tDRLHufVqaQKauchfBpFidYwly+9jHbfcGzUxfgEqj2U4rhBZm8i1uk
	FFO8fMS5DLteqPqGGw/18PE4vr1Fv8IF+DroTlnn1Ne9o32sIEmrvyiBcCOXfbY93JhRrpGC+CR
	7Vu2vJUJ1zXbvCqi+0syQXRDX/EdAc1Az7CSwPWPZ4QwRZyxhVzbhXGg1uRvBGKTR1zB8if0pET
	t/BVZDhC03KBXAMHPXQ3+yxTTxbh/Y2P9lRgnad97sTKxXIIlHkLFtK8sieESFSjs/54AFg30X2
	Kg2
X-Received: by 2002:a17:906:fd8d:b0:c25:58e:83ff with SMTP id a640c23a62f3a-c25058e8844mr45353566b.10.1787663093845;
        Tue, 25 Aug 2026 06:04:53 -0700 (PDT)
Received: from [10.45.28.110] ([15.248.2.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b4f1sm1822703566b.3.2026.08.25.06.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 06:04:53 -0700 (PDT)
Message-ID: <f81f8437-57da-4545-9046-28562df3c385@gmail.com>
Date: Tue, 25 Aug 2026 14:04:52 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] KVM: arm64: Add pre_fault_memory implementation
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: maz@kernel.org, oupton@kernel.org, pbonzini@redhat.com,
 joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
 shuah@kernel.org, corbet@lwn.net, vladimir.murzin@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 isaku.yamahata@intel.com, Jack Thomson <jackabt@amazon.com>
References: <20260612162354.73378-1-jackabt.amazon@gmail.com>
 <20260612162354.73378-3-jackabt.amazon@gmail.com> <alEXtW7w-rqlNG09@raptor>
 <0365d77d-616b-47f7-a5f2-3388bad692a1@gmail.com> <ao2KmmUd1lVFUUkp@raptor>
Content-Language: en-US
From: "Thomson, Jack" <jackabt.amazon@gmail.com>
In-Reply-To: <ao2KmmUd1lVFUUkp@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex,

On 25/08/2026 1:29 pm, Alexandru Elisei wrote:

[...]
> 
> I think there's a word missing there, I meant to say that it would be useful to
> explain *why* the x86 implementation does not mark new PTEs as accessed, while
> arm64 marks them as accessed, and arm64 also does that for existing PTEs.
> 

Ah got you, I'll update the docs in v6 to explain that. Thanks!

> I was wondering if you have any plans about posting an updated series.


Yeah I have v6 almost ready, I've addressed the comments. While testing
it found an issue on pKVM which would case a hyp panic if we prefaulted
before it's first run, the EL2 context load blows up. So I've also go a
fix for that bundled in.

I'm just tidying a few bits up and hopefully have it out within the next
couple of days.

-- 
Thanks,
Jack
