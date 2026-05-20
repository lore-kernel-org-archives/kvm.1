Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E036A360
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268594; cv=none; b=X35EHcUlmyQ21hz01xsmzvobdPwWjA+9VLrSDz8eJaSiM3YjL12AvhHgxikTTYtRlUDvn0zR42lybZdCr0GeBKESvVsrLh7ScM3r/P+YOd5XQ5OzIw3UKlPTy7UIRfGnNAqdC63AEFgqcUt4KiMhFepZPauLZB5x7lair552wV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268594; c=relaxed/simple;
	bh=zsMOFPh8hY7eMwMlDKZoi/q5+vNho10ULeXZEWfAroo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=iUpMbRp92Gcap2szRZU7UT4DTwrlzhBZSV2OFfQpz27efSFUo1N7MZVyvSOFoA2xZFoPAD9hgugOkjey8Gf4gjGLk2NS5c1ZYTD4h4gDUR7kxNDSxZRMoS7AZ2Ogs6EP+qASlj9jjE0SyShkKUiVn59Na5HIgz37jr1gglnpY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZxyPDhj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MV2HG+aS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZxyPDhj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MV2HG+aS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779268592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TGo+KKyvouOmQHS+67LSR5UoBm7NeFlXrveQzUhbiuE=;
	b=FZxyPDhjHYB9VnUqtE9Pz/Sv4ipMSaaxkWvzV2cJXWy1+PtUTA8iiTFX0c75IZMD6m8GFY
	Oz/axJ1sdeUJejGsCxk1CQp+6PqAYByaDgy8N0fXuD91C6Snol0jsOgfNIerVlyuLLLtI6
	cqur+cjiS3iDK6ioa+LCsdXn/Nv7NrQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-K5GxztGjMiGerCtP9-Dt3Q-1; Wed, 20 May 2026 05:16:31 -0400
X-MC-Unique: K5GxztGjMiGerCtP9-Dt3Q-1
X-Mimecast-MFC-AGG-ID: K5GxztGjMiGerCtP9-Dt3Q_1779268590
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43fe791a398so3680013f8f.0
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779268590; x=1779873390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGo+KKyvouOmQHS+67LSR5UoBm7NeFlXrveQzUhbiuE=;
        b=MV2HG+aSt08tyrMMNC8KVlRlx0omjXiaWdnQjvpdIwPZLcXnks/5DPlvq1IxTIS20b
         08K3Byeu3EaNbt3vAxUbKwfQJhbuW+qW6yRi+HuF0mqLkZo+8sIPWvd72ehSqYJCDu3c
         9Y5+VzE9746VnTiY4bmn/hGmDfHtjr6C8c5pNR/RU2q4mpVLwKln2yeHBVOJuOl7rHPU
         q4mxcSUCFVZ0MTsXjDtVTXuc0uHaO1VrsSNLy0t4L4LGQacGkepL0k2LTSx6dA4Pw44/
         9XnxF9a55DNvtLlnc8WMBryPzTlBuJRncy+j0dzPhBXCYdDIMVpjgAP3XhJbjNA/uas/
         tJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268590; x=1779873390;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGo+KKyvouOmQHS+67LSR5UoBm7NeFlXrveQzUhbiuE=;
        b=s8Qvbx/UouOjgpvkfZaRSlOleEm398B9UfCCDoRJ41X5srpouSV+VDSh+imaL5UwaG
         uTgfc0afL2Rd6j/otYDiElmGQRq7itYQMJBOgQGUYtdFwy/5jrxOTkUNTWl4HqMIbYjG
         dVbLY47KYiiC3sJkK4Ac8t3RlnFcX27XnT38gXXZjG1YanV37VlSmaw7NMRPdqAe073E
         Xtp03sKn6CeKPGWFUOoLrT61ijaDJ5z26LpwHaVOtfVeZr25AOi4rzn7x8jmiSMvcwxu
         AKVKRCxWaeUumYyPaC5OgY9X1rz95x0EOXnuNZJWfuSOGfab6OXCCwKPwh6MA8fBB7Go
         9Jzg==
X-Forwarded-Encrypted: i=1; AFNElJ9PJUsH5EGaTPDLbqHg+RnCuJDVnSIWL+okD35u3JPK8zIpNwpQv1QTYouScwcRQLGG2oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqqIwDFPaU4/5RVonqtsYDsP/JtLHhl98SvflJ0hrgNBkhuSCp
	yE/mbguI5z5Z/Z2UAFvj8+H8BTzcTEIB/ks9pFCQzhKyY5HPKXa8OUGLnnqZCyTY0Dg5Orx/p/o
	GyBvpTrhJp0MuZc81aqSAc23asAraFDgrdIOioWP/N/cS/ivYE691N0Is9/hSUQ==
X-Gm-Gg: Acq92OHdlvIexYhb2XCC5bZSlOEaW81ozmfFMzkCEPZBSheUuwmUIfVNWLLGexFqmxT
	DmxWl7zyhLk1Yb87B0P0GhzluUnDt+UslQdNRfkd3HXsAP9Hc2WahOtrZh44S3iAf1AID9l8hQ2
	1qLBRkL3YLWcdJj8wpJ8PpwqLkOJDLugRzmKITMGSR1oFYT2+WhQd4J+N/GnCknqIWGZQG68SSz
	0WOLTPpuGUZEfP4jUYflD5rAIxLqwIQie80gPeDdP6yXmAjtCHiNByjcAcaS1vFjtKyAQxIprR8
	hRJR+RvLjAwewjuzdiZkX+d+tCNJGg0xnRGPR6NiqVwOPFO+UZ3eMumt3EFNKgT7tfI6fVOE16R
	6Hfax2H2JMi/vuI5mCeI=
X-Received: by 2002:a05:600c:4fc9:b0:48f:d612:3c40 with SMTP id 5b1f17b1804b1-48fe60e47bfmr325649555e9.7.1779268589849;
        Wed, 20 May 2026 02:16:29 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc9:b0:48f:d612:3c40 with SMTP id 5b1f17b1804b1-48fe60e47bfmr325649155e9.7.1779268589445;
        Wed, 20 May 2026 02:16:29 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab2896bsm130207735e9.4.2026.05.20.02.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 02:16:29 -0700 (PDT)
Message-ID: <e54079d2-b28d-4287-a2a9-955fbed0c518@redhat.com>
Date: Wed, 20 May 2026 11:16:28 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-unit-tests] build: add -Wno-override-init
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20260520083732.360181-1-pbonzini@redhat.com>
 <6e3288fc-150f-4319-adae-bbf0c02ed18e@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <6e3288fc-150f-4319-adae-bbf0c02ed18e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/05/2026 10.58, Thomas Huth wrote:
> On 20/05/2026 10.37, Paolo Bonzini wrote:
>> The -Woverride-init flag (also known as -Winitializer-overrides in clang,
>> but it supports both spellings) warns about code that may be intentional
>> or not.  While the unintentional ones tend to be real bugs, overall the
>> idea of overriding function pointers is more useful than the warning.
>>
>> Cc: f4c5838c ("svm: add basic GMET tests", 2026-05-12)
> 
> That should be "Fixes:" instead of "Cc:"
> 
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> And that "Reported-by" instead of "Reviewed-by".
> 
> Anyway, with these nits fixed:
> Tested-by: Thomas Huth <thuth@redhat.com>
> 
>   Thanks!

I've pushed it to the repo, and together with the other fixes, the CI is 
finally green again:

  https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/pipelines/2539893859

  Thomas

