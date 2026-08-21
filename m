Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAAA470E8F
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316341; cv=none; b=PYoTH7pfY+V4wYywV+5BTkVqokH5eVHVOu9lAQtALQRVZxmwItNfA3ZDdmVNp68DYZ4Y+2OaIPVJ3sCsc+KpeAepRRafndSddiKPLEkNo1ruLBxtA9oVWyNma6/KkSl+QmxGr8a8yytE7vaRjVFEmG6j+0oR1dCAHWgiNl8yoI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316341; c=relaxed/simple;
	bh=M9TF/2NTcxfeDuxVvVqxdJ3U3H2unaS0+16ygI5y/qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8QYZ4JWV8yLvUJlMgRZWfNn+vbUGdQXd9KGkWQBYdkCli9+uv9nLHgyTo56jl9eon+1w7NXUOsCpcJTCeNYT+I4ruVbmAFiX6UbV8q/fXXlYpIwxl5zteUiQs3YExwPUtft/tlY1jEJnpBnAvmR6VR6U1bi4XHNGZSRHgdL9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuDwT/F7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuDwT/F7"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so9033435e9.0
        for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 05:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787316338; x=1787921138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ofVVmavq8wtT0bF5YA5bCdNX53D9kSF/gQ+ziezVadc=;
        b=TuDwT/F7MC5fZXMnl64dcf5Ryd9aXKIHjluO8d5Iv6sWxDTCB8OTftL3l76WvYcICL
         GNtrESq9MLNam4z2tlE2f6Dy3oQJLyYk4FX9o4sBfh4kCZ0UmtAcEL96ur94T5IIkvA2
         qpnbyURurfR1s9BG8Ar8Zoq6/YwwE/eAvb0f0YsoUjvUaBd7G9tmXeyGq411cbYULppP
         9KAZ91nLJYWi/dHbmp3UVGEIPUoepjnTKbQhdM1mhY8mubpRYjvuiwgHkrIHzmbqDNcu
         DHIDoZ9KSeUMTdcaojQUMNmsX7kvavhPwc7irY/OFMh4fsoH/tCiiEh32T7QPzVqyJjJ
         D4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787316338; x=1787921138;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ofVVmavq8wtT0bF5YA5bCdNX53D9kSF/gQ+ziezVadc=;
        b=DI/cymz9QgGAQuFIPH952r2+DnHJKaVhbvGg68Son8pQpkEw8hTC8119Y2a/HGWv0S
         l0qbz8j9G4h5wRfeXX7M7fjahbhdpQjxkT0PhvyIqQClawIolz1b28Ij71zHwbth+QrH
         GAM7DcDtSKgrXBI7qxtt+3uzSPIhC8u/uANbIKBzTpUeKKh80zYagST9e21BKgguZP+7
         SKY7ZwKp7NZN/qojfL0xRtx1iXZQ2y14vlIPKpiC+38FIAZ7SHhK385uaSzzlRV8lARO
         hKTrW++1/NdAgtgeysMTrxj9rjqR3dpo49jpCsY6nXlLU0sXDKWp6bqSmjO6A3uAKM9j
         5BMQ==
X-Forwarded-Encrypted: i=1; AHgh+RquEw03sW4Yn7dIGtL4eICHZ3wwz8F7xUtatY9cYU7tL4DxcWsANs5izVkgvW/WLJE8TEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7fzkhkhKqTRU5zSj5SVvDwAxourqJdlciHF8ssXQMJdOh9Ipw
	zxamw3xK7MQkSYyMNDKyzdCkebt9KVDBuFd0xAJhwxsD8jJXxqV2RoMU
X-Gm-Gg: AR+sD13oziVtbllMsIQ6G74EoiywzXZnxaKFjbLx9wty92M7rdbpxHLMeGCN4I8qEaF
	ABUNZpSabnr7cPx7tcDjKKToarNCiIdZaJ0C5KsrtZ6nQLDhwEvjUZCQNqsIR9u3upB0KtB5uyH
	0ymnTZK8jp73mmpUD/sEpikSM6ap7wuExtH3YJEMAXx+tyZh/QbZIZi0Pp8qE63sWNwemdvNMmA
	L0cBaQ5vu/Wti+DowjEH1PLAVUkfAzJWeqTfvc0H23vKkFXVy5x45EXFGAwzePuE18/jcuagqGR
	bubKysUTJ7zjFFmNSSmfahq9U/8n6uOCvDp82rAlPOEOue6WwawXjx+EHRKB8DaS/6pV48Ly0Yk
	XdqXwuT+TKcQco01nIHKFVWCyHnj02DCKZpZQi+K11/ezyhrus/8tFa/pyVZB/yfQ5mLK6fW8Zj
	EN2a8d8y43LriXFtsVE3EG5yzqIFseN5WnGSKuQZ00SMp8Qz00JdM2vAF7rZW7ZBweccnz7bKTj
	eIi3J28wfcKNrk8L0HzVpVasnZoKwZ3l/lKx27D+4n1I/9I90Gh8msOsB0VuDtg
X-Received: by 2002:a05:600c:8b8c:b0:499:484a:98e7 with SMTP id 5b1f17b1804b1-499b845c9d9mr99624285e9.14.1787316337718;
        Fri, 21 Aug 2026 05:45:37 -0700 (PDT)
Received: from ?IPV6:2407:d000:508:2027:f309:cd0f:ed5a:5b9? ([2407:d000:508:2027:f309:cd0f:ed5a:5b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b90f746csm27470255e9.7.2026.08.21.05.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 05:45:37 -0700 (PDT)
Message-ID: <94e1dbf0-de6e-44da-9bc2-772fd6654250@gmail.com>
Date: Fri, 21 Aug 2026 17:45:34 +0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: selftests: Replace ulong with unsigned long
To: David Matlack <dmatlack@google.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20260803170825.925561-4-hisamshar@gmail.com>
 <20260817220457.554823-3-hisamshar@gmail.com> <aoOKMeua-cNeTxXT@google.com>
 <8d069fe1-a5b6-4a86-9604-26aebe2dc243@gmail.com>
 <aoSIBnFfy4osa6wt@google.com>
 <c2f7e904-2646-4b01-864d-d185221c7f56@gmail.com>
 <aoSyYtxBpEaoBwGY@google.com>
 <c9ee5f08-81c3-4c91-9189-002b260ea641@gmail.com>
 <CALzav=fs4bqMM7BXNPXqhtbqGzA+LW5fgx2-1Q5=sTN5+krYhw@mail.gmail.com>
Content-Language: en-US
From: Hisam Mehboob <hisamshar@gmail.com>
In-Reply-To: <CALzav=fs4bqMM7BXNPXqhtbqGzA+LW5fgx2-1Q5=sTN5+krYhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 21:13, David Matlack wrote:
> libuuid is required to build libvfio, which VFIO and KVM selftests
> both depend on.
> 
> How is this problem solved for other libraries, like -lpthread? 

musl does not need a separate pthread library. pthread support is part 
of libc, and libpthread.so is provided as a compatibility stub, so 
-lpthread works without an extra package.

libuuid is an external library from util-linux. On Alpine, installing 
util-linux-dev provides the musl-built libuuid and uuid/uuid.h, and the 
selftests build succeeds. I confirmed this on a fresh Alpine install.

I sent the basename fix as a separate patch:
https://lore.kernel.org/kvm/20260821122110.902382-2-hisamshar@gmail.com/

