Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAD03E0245
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968193; cv=none; b=DzcdnomJcZO8NhTYlW8xcKM4BBrfZ+1907bHteckxtMLP0OD22w6qg1vTfOzX/sM3qInA7RWqQ091lGFbQRyy9oGNF5rMZvEkJzn8GZMqcGF9J1Qmquvn8OZwRCyM79fNyC2EBEPWK7JQC+qXWpqhe3Vdmwusw58svgsZMaqsyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968193; c=relaxed/simple;
	bh=RLA8b8mDlObYOAIilVvwoN3jydgwLgQhT2Lqj+jCBpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhTDB2r2gfo1FucO67+N7+E6R2tIDv1/Myqlk0W23gv8kLew1UzMQUUhVtemiXYSYNIohrQtlZQ7Tjqb7H0mC6j2OV+OPLd6TsLIcBVDO/icqhwqvtRSKQX53mNRPANRfqxgOc99OgwnUaAqIDjdnk8uJUaC8djGTbedn17JEUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWNQOubD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Th/cFoov; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWNQOubD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Th/cFoov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777968190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yQdPdITxq+ffr8+gE6PUvuhNfzMVTIAKI/zKqGdYQsk=;
	b=HWNQOubDR0ungrKOZr4fLfuKvJD2S7eWnvuqSiMrhbw6/NKcW101WCnW5aNBHPl+0vi6iK
	+Ph8e+Dbv4bDRyRt3ZOzz3cTfdp/F2hX242hCo/zst5zvWYRxBiiB466JnrPOn7jOqiCpN
	ToDYrqAprdODCDR20MCTqNaRDrWCat4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-TYb-n_GoNSi4MOJTXopThQ-1; Tue, 05 May 2026 04:03:07 -0400
X-MC-Unique: TYb-n_GoNSi4MOJTXopThQ-1
X-Mimecast-MFC-AGG-ID: TYb-n_GoNSi4MOJTXopThQ_1777968187
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d104d1d8aso10905265e9.3
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 01:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777968186; x=1778572986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yQdPdITxq+ffr8+gE6PUvuhNfzMVTIAKI/zKqGdYQsk=;
        b=Th/cFoovcjFVEbLiiO2KfI07rOxVavYbLLtF5T0eh++JA5lEuKXrFc3R7Nh5yGLvPG
         Rkqh/IoMkjkeQFEaMxkjTsKXaANhlQK1gZ5702cNvOPxn7t4N1jAyU2+48SkjV6rZ1/d
         fGPagJ4wG8s5DuI1VATZZpkkeE/3lC+OI/tVAZXJuIAiboK36hTRig3pd7boq4BhuS4V
         sw2xkjGe/iJR27rT6kvg52wqT9IlBG66N32iWrH9sIx9bD/Zin+wJgFvZ5qhdzUeN+jE
         C5N8oIxCTCzPA9ucZFaw8c7r6e2oYX2XmItUhNa2n0G+i0AEf4aBzVD9m/n93175drAD
         hLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777968186; x=1778572986;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQdPdITxq+ffr8+gE6PUvuhNfzMVTIAKI/zKqGdYQsk=;
        b=qXZSJOYNi2yYHOUWyB3DA6UsAYaGM0Nt5BED1MVBWzULa5rosBqgigNw+oCl4zgGpm
         SSmL/9I29AEwQBiM2U1QOHCEaLaMySzbfVBUhnEEkEIUVVL8uzV8lO2FobNlyhl1F5Zz
         WZDprDvG5i3tUA4Bco4Ak6/vLoq52yyOW1kgdZ8gWYDFFaYdB0MP1DHNExxhZ7TZQ1E4
         ea3/yB5nX+TuDf+dpKA98TeBYgGfjsu8mwUhLyRnqU+ScOdZUVDfo8eQD/PnABH6fq6L
         62kezKdtBJ+8tb8G06N54lQyfIgnxlKCPfZCLAYfBDASC5+z7H0FK5iTGd20B71L/s+M
         B+nQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Bjw29Apqd/sY8KFXlyUmTtaiL/Z4gvYZQ5TrM4XY0+WcC3G4Y6HjJsUW9ZEq/PjjUsyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHRL0PIyFLXIR1vpPKxKQ9a9UhvBfrQPSMb+dxp3F7JC3gGy+z
	AZHUXpDiAQOO63lYc39sx77saRBlA4I1RvnKQ1gvrg5CeMDINYrTttZU1Stl9vs65nhIuUJMi5a
	vycza28oBgr0mjp7S9/k4NH+HO0e8cVAbU1lAtEtk2gwvGHGvjvvf7w==
X-Gm-Gg: AeBDiesd20jRlrRgFpj4Xa/auGzlUE9EHGmFv40hCdmlhCCqdmUdn0i2WTkZeH/ofIW
	2kX4Hw1yUQpBK4WFXhUPPwa3VQZBNgtQ1dUEZIl81qmdAbbRCiNZpHSRZ7NXLGgZ7dvgJYm1btx
	NvbFFptvBkP9eeOPcT+uhV1LtCsi9sj5fCTJHnPBeAzN/AWkg4IH9lRXYx7fNpt1Y5GiJ03IopN
	EG78IytWmC0ANeKPRn4+jbQw/1/RfMP1I3oeabT1WSmzmADdt12hTvWZ/0GU4/ZUsJbWCUokJLd
	iIX2k2rYD38OWncZabiMfxza5aBHALNQDFlDJvX/IsUWta6jwU2mq58AsseRnCmHpJZYi3xmaex
	WaGGCwXenW2aZqfrC69aoX8H1ONyrAg==
X-Received: by 2002:a05:600c:8b6c:b0:48a:581c:ead with SMTP id 5b1f17b1804b1-48d187d9516mr32185245e9.10.1777968185054;
        Tue, 05 May 2026 01:03:05 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6c:b0:48a:581c:ead with SMTP id 5b1f17b1804b1-48d187d9516mr32182155e9.10.1777968183125;
        Tue, 05 May 2026 01:03:03 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d184e09eesm11009625e9.29.2026.05.05.01.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 01:03:02 -0700 (PDT)
Message-ID: <9bd9b2c7-2082-4ec6-b415-734a5994769d@redhat.com>
Date: Tue, 5 May 2026 10:02:59 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kvm: Include linux/types.h in asm/kvm_para.h
To: "WEI-HONG, YE" <1234567weewee457@gmail.com>, seanjc@google.com,
 pbonzini@redhat.com
Cc: vkuznets@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, hank20010209@gmail.com
References: <20260505065849.81691-1-1234567weewee457@gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260505065849.81691-1-1234567weewee457@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/05/2026 08.58, WEI-HONG, YE wrote:
> arch/x86/include/asm/kvm_para.h uses u32 in function declarations, but
> does not include linux/types.h itself. One user, mtrr.c, carried an
> explicit workaround for this dependency.
> 
> Include linux/types.h from asm/kvm_para.h and remove the workaround from
> mtrr.c.
> 
> Build-tested with x86_64 defconfig.
> 
> Signed-off-by: WEI-HONG, YE <1234567weewee457@gmail.com>
> ---
>   arch/x86/include/asm/kvm_para.h | 2 ++
>   arch/x86/kernel/cpu/mtrr/mtrr.c | 2 --
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

