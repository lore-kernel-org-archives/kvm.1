Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F83A545A
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779267543; cv=none; b=q6JPQlel5FJSuEtxOTI3a76n2cZJJ844cpnOn/AdQs10H3MQKaCxt5olchE7p1Z4MiRFYExpAjyjpKdjnZAXLbohxzw4Vk2jyJWg64H5klsx1+lSOZsflHRTFToNjzCnimLcsC4BsIGLB53TVvBc0m9PepO347+62qvtcvOb6HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779267543; c=relaxed/simple;
	bh=oD/4dZvQUqDde5grn/d7+zbDYtX4sT/TrdK5N5Sk3so=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EMRgS1tJSz7jfLHJe9I0TOYIq72j9k4GJfWptj7Jn2jL7p4/iZD/OZ9rORBh49JWRde4tZEyChbXcLY7ahp+v4yzwvrQzmAztWjtcLAKUUEa5O5nGFiZcHgiF9wLmsPGUACw12215Ftaie2PVvx45AkGJ2EzstOW/Kc801aBiu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/eNRitk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgK8Ab9K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/eNRitk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgK8Ab9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779267538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H3BtR25+xIb0GM0RsnI3ku4ksDSCeQuBe6aUiNiawD8=;
	b=I/eNRitkyshm5f+1PBILW7+hm+BLCd2Z8MPwGGMHMlDjnugs2KV3au1LxBO3LB/7zpgwc9
	+pNr3jpnU/JvrkXzNduj+CJVFTREKcZtfTYdkKJ3zYPBvhknQ/VCHKBi/OxOym0T0nBJul
	TAazKkMbGtlzUgLRatdHuFsJpU8NdeA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-QGoDDI3sOR-asvRgJIQb-w-1; Wed, 20 May 2026 04:58:57 -0400
X-MC-Unique: QGoDDI3sOR-asvRgJIQb-w-1
X-Mimecast-MFC-AGG-ID: QGoDDI3sOR-asvRgJIQb-w_1779267536
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fd61d252cso35394875e9.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 01:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779267536; x=1779872336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H3BtR25+xIb0GM0RsnI3ku4ksDSCeQuBe6aUiNiawD8=;
        b=hgK8Ab9KYiQNyj/0ArweJwh7/OASZcHmFQjOgBudN5GGftlR2FZtkpNUXD+7waGWbM
         4isMDAD1S61FJU9C1n0A9pf5kPE7pZl11jLdd+Yzd0Opdp1P0CgQQf/GrPwLIRBZdWs7
         V+TjG1ZhkDt3ePB8piWZHLEtbmjUDaHDz9/VTp0Y/uqEkgxzbj0xE2kl9Wst/IGFKxs7
         25gm19QN0oHj9eK5sYcOdUil68rV9m0QG/rmzTs8adA0l+lF/MbEKJdVtC433cgVwXMb
         b2LPim8mtFBIhZcpIxSwRKAgFhX0XgW3O7f6vP3CVr5+ZJTfBRayjGwGYSnCiPscBVPd
         4sKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779267536; x=1779872336;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3BtR25+xIb0GM0RsnI3ku4ksDSCeQuBe6aUiNiawD8=;
        b=VyRDt/bArzm6L3TpMipTt7DUz8mMnWpeHfnwCfgNiCH5/AXovr3ULkikQmubvZwh49
         G7wso8ELAmjwF3pRXiMCufm/mNeSyRVL88XjGuBAy2uMElXkftxjE7NBIsJRiqq6VV3h
         ytB50OMkwqqGXSwucG9aMTBg/mCdAKSlnGGZla+e/qkG0FzmVb6NDktrddoTAFRKJCAF
         RBWeNlKaPsmDhiDV58AdLMp4hUG6X1LR95fY5t0JAvOkm0peau/+4y5LT3dfLV1tqghC
         LyZhQ6wDfuptlcoXso+7/mvqqqBT8AYnJFp9aFGFAoxxbvYaQ9LSf+6VyaXUFhoh4X2c
         +1eQ==
X-Forwarded-Encrypted: i=1; AFNElJ8K/s8LhIyZ5Zrz8Dj5SQNVuDeWSO2TEr6AsEeWvaAFovtfwAi9ag8ObEUN3Zs7DVT7tU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdn/iRDlOTNqL11yYRK2So8cKQzbezgbKHxvFSIhqZUKVG+uLJ
	VHMurMPGqVqA7ye2BF6lS8QzohuH0NKfBZmo817PuZlHioGaxL8UEGdAH1JuzmIEzUCVeMxA/AI
	HocyS/w9WtRQeq00fYJ164kx5FltDyKO/giSjoAdjlug4CvZTLkJcVMYhGdSmag==
X-Gm-Gg: Acq92OFee9YigDdJFickTHSkfqmMIlCD/YlixTm4wjKyC/do9mA6V+cgphHVD/ngDyI
	wcHSGP73/yX0qyVxk7SK0d/hysL7pN8TqIc2yuYBzcOYwdt5pATAnb8ACGeFCZm0YMYfVpiTEcg
	8YutsxssuUkOLmbY2bca3zBw98LOJlrbKTw+SKypo2PNZyiZUlJZlKlw1fp1AYX+PFMCHc/o9gs
	bLZ0gZZVMP7DMEnFuGxE3t9ns4r4l2dKNNe3Amm07h7WNLRXjiCvFp7lAFQpMDLnZmvgHcEqnJR
	8JFb1To3rpjA9gOk4kjTvFc035yRN8jZvlhME+KUbxuEPN4e6U4KheR6zfVPKZ5BCtyHOO6acZy
	lgo6UNe7ZIB0DbXMAkhPmv3MduhUORg==
X-Received: by 2002:a05:600c:15d5:b0:490:778:4fe7 with SMTP id 5b1f17b1804b1-49007785069mr132763575e9.23.1779267535808;
        Wed, 20 May 2026 01:58:55 -0700 (PDT)
X-Received: by 2002:a05:600c:15d5:b0:490:778:4fe7 with SMTP id 5b1f17b1804b1-49007785069mr132763395e9.23.1779267535360;
        Wed, 20 May 2026 01:58:55 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5cab7c5sm410930245e9.12.2026.05.20.01.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 01:58:54 -0700 (PDT)
Message-ID: <6e3288fc-150f-4319-adae-bbf0c02ed18e@redhat.com>
Date: Wed, 20 May 2026 10:58:53 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-unit-tests] build: add -Wno-override-init
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20260520083732.360181-1-pbonzini@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260520083732.360181-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/05/2026 10.37, Paolo Bonzini wrote:
> The -Woverride-init flag (also known as -Winitializer-overrides in clang,
> but it supports both spellings) warns about code that may be intentional
> or not.  While the unintentional ones tend to be real bugs, overall the
> idea of overriding function pointers is more useful than the warning.
> 
> Cc: f4c5838c ("svm: add basic GMET tests", 2026-05-12)

That should be "Fixes:" instead of "Cc:"

> Reviewed-by: Thomas Huth <thuth@redhat.com>

And that "Reported-by" instead of "Reviewed-by".

Anyway, with these nits fixed:
Tested-by: Thomas Huth <thuth@redhat.com>

  Thanks!

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   Makefile | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 403fd495..42ef5826 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -76,6 +76,7 @@ wclobbered := $(call cc-option, -Wclobbered, "")
>   wunused_but_set_parameter := $(call cc-option, -Wunused-but-set-parameter, "")
>   wmissing_parameter_type := $(call cc-option, -Wmissing-parameter-type, "")
>   wold_style_declaration := $(call cc-option, -Wold-style-declaration, "")
> +wno_override_init := $(call cc-option, -Wno-override-init, "")
>   
>   COMMON_CFLAGS += $(fomit_frame_pointer)
>   COMMON_CFLAGS += $(fno_stack_protector)
> @@ -89,6 +90,7 @@ COMMON_CFLAGS += $(fno_pic)
>   endif
>   COMMON_CFLAGS += $(wclobbered)
>   COMMON_CFLAGS += $(wunused_but_set_parameter)
> +COMMON_CFLAGS += $(wno_override_init)
>   
>   CFLAGS += $(COMMON_CFLAGS)
>   CFLAGS += $(wmissing_parameter_type)

