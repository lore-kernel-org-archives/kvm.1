Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114563;
	b=5tBk5ozPTkhU8o0TDJzqhOhR6OqgozvshXVCtpaGKXQPbsBn9W4wzVxrYNpuZeQdXSvy
	 QKkFLgGCsV4QNBsDm/1ftt8qGO9CY0mzZUvosgukrp4YPcCBIKgYvShiX6cRtFEy1A+ZF
	 L1c25NAXDtQt+GuWp4ELBQhKUFlLVuAuZc+6uqTip3zKYTwxTagc0ya4HKSbth636Ir4j
	 0ZUHEJYhkIwlmZRfDAUqqFzYUiIqWLScfu85RKu1UvH0kS/D+b3tDhw+H1lpCOvWUnLze
	 SVfUlXu1a9tuscN2qaUcWYvoYeBuAVvQ6KUxGpM+TL/DPf8/s08oalKaAwdfOWkyZyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GYB1dTOmJBuh3HO8sbLhiXZWRlkdiO237Pd86QmoAGk=;
	b=kBfO/nOVQS4acH73/O+Lwuy8f8Ld9vSrvwaxIgz1gNuY/42D8rIXO/eg+BcELj+eKqEa
	 f9dHnCeBs1GZW0xFrQeP8xCxJU7qQ4+QT6UEjBQNeBUedo6/yzJSTrkv7+tiQ2XR10Z3Y
	 pku12TCiq//AXu/M4DA91cymJKtfdXYq8IbK8ZKZ9f67ia4p+3UvsFW4hctcsAcHuosnI
	 tVGWwhZNAzFYXHG4O7oEI01vPyVqvY02UjsGK85tL1wvwIamLjy0Rg3kCp4VaW7pqmZuB
	 FF48OeowdeEN0TS/i3YdUQ7cCXamiXvX+8cFgRgzlKbc1tcZ15assOLylwp9vkTzUeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=o3cEIyAS;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D40606A32A
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 18:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87D40606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=o3cEIyAS
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8c4cc85a315so120776b3a.0
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 10:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795114562; x=1795719362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GYB1dTOmJBuh3HO8sbLhiXZWRlkdiO237Pd86QmoAGk=;
        b=o3cEIyASu65iRaLeiCiDKL0C7/xAKHNBV5mBtTPIZd5OEELbH9ocgKxEvyGTylQg6M
         to5c20j1nEyqO+JtAVTbz6g9j6cwUs7ZVByVkX3Ogk0ZcgvQGDwIXwAnYs0Fntflf629
         J6ENjTEMi1DExUJr5kx467ZDKQN8juG+MGrorJa3SXTfSXgHeYBfc8m+IfUTufzifDoh
         5XJKkYfH1z6HWV/IQpO+EtGly+FWCWuAMLEmK5m0K+/QLHAHngOqRGppzl6lsJrf22vw
         SPr4xqsL9Xe98DtBu1dcM99PFlA/qer/63cQUskkhDZMIPI2fWplgcyho+0MDuj2ABCn
         CJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114562; x=1795719362;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GYB1dTOmJBuh3HO8sbLhiXZWRlkdiO237Pd86QmoAGk=;
        b=iz2qylqFrRga/bEE241jq5f+ySwFhtTCYvT4atg3u93wtJo4zMD60fMs/4L+N8qA1N
         XttHOnm1GrfLcQqEbfQQIAaPM1LUHTndlsWRBP4rVtX2WsT5khtdMQy1XrXH+HzgewTl
         +kfALSUEPq9f33nFbyrJIUfDuKkwjLVNxBt51ccSMwZCOQeIZW4zanbFSIA1oggmYJAW
         n/hJnFRrbbROniulnJx3YA1E/XW0lSqnHx0nO4rCto91gS2ISwM28u82z67jylZncbE2
         d2mDkGw2P9lTqY/hqnYRKQqRGMDaFE7ile1IGyidYisY3xk0SD3liO80EmqwlXjRD22Y
         d9HQ==
X-Forwarded-Encrypted: i=1; AL+hErF2f0M1Uv3t71Ww2hg2/N7lJ9KzKpbpoLrsefOHuNv4CLUnlxDt/k91FrLVa5XF7FjgL68=@vger.kernel.org
X-Gm-Message-State: APuU4Z8K6/Vzc3n1bVQMrwNdDHl0aQhJnF5HVuNm63tw2R1kwvKCNlXQ
	MEQyBh3nAdN9f40924llKWI5WxZP+jxGQBnNHcg8ZUH4jwcpdHiCD65O0YaSwZVNnoo=
X-Gm-Gg: AYBFou02xFq7u3U/SCKoHE135z+VEa7ANWQrBXNPjuyA59k+xwVs5aCCDJtYtLH+z2f
	7DWuRYm3jpbLBc1XMdvdtcSbsSS19mTrxz7BjdSJ5BoVoxAq80HJSUFISI7JrQSplDGV+i+5Wcr
	3DAPT0son41wWrCpaPzUj56YJ4TWZzRIs7loche3f7gG8FOe5DIuZ8gWFTQcjreTb0G2nfstFtT
	Yt6ozwHbXyW90Z/lW6OzKGej57pBYrtzG3PhAI6PlG+88/zo+e60He804yyE0rjBHk9lcNZ6swd
	aHHQpp3VojgA6UqFwf4oy51ErrewsPz6XKkipNbnrNT6MLiMDekstYt4qeV1406nDxQDymhGrW0
	Tol5MiXUBxz85qExJpb/gY4ThY9NXx1wdPsLfY1euspBKTfwWCZDl9dYNKUBnbCiqMSu4vDaI1E
	d+PCSO3JbS66uMhSM7kY7XQHkuFFe7pdc2t4OZL9m9Zm0OdnmWcJfs2wOVVUkTg3KswcDuhGN8/
	pbjoGNwqw23xHh4cARwthmzUAW+scBQ5uIUbPKzFIJECcSujBkvIqboDAtgbZ+pzrARkIrNcEzp
	3AdtDIaORcZkZKhCg4hpJ/Kwooc5933y8dzH9gpzvvmcoS51dvixXJwA9tyaZ/8iLvZLJTo=
X-Received: by 2002:a05:6a00:f86:b0:89e:9084:b02c with SMTP id d2e1a72fcca58-8c87d02544fmr515635b3a.48.1795114561683;
        Thu, 19 Nov 2026 10:56:01 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c15asm325734b3a.20.2026.11.19.10.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 10:56:01 -0800 (PST)
Message-ID: <b2516ddb-9e26-43ca-b06b-197b6e6feb7e@linaro.org>
Date: Thu, 19 Nov 2026 10:55:59 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/cpu: mark CPU properties as const
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>
References: <20261119180859.1044425-1-jsnow@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261119180859.1044425-1-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 10:08, John Snow wrote:
> Currently, these large property tables are loaded in the read-write
> `.data` segment; by marking them as const they can be loaded as part
> of `.rodata` instead, where these tables can be shared between multiple
> instances of QEMU as RssFile memory instead of RssAnon memory.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   target/i386/cpu-internal.h |  2 +-
>   target/i386/cpu-system.c   |  2 +-
>   target/i386/cpu.c          | 30 +++++++++++++++---------------
>   target/i386/kvm/tdx.c      |  2 +-
>   4 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

