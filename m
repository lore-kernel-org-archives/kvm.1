Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3B1AAE17
	for <kvm@vger.kernel.org>; Sun, 19 Apr 2026 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776633046; cv=none; b=QEBcNujnaihtXsfZTO7z6XCFaFCXSy929WPK2nqgz8wWlA6JMUV+H4t2TV9IaWiSDhA1RjSwzDP37dRu/YyVpwR7+rGy8wnVTB98zvKO1Tz4bdOzEWxVd5HBheKTSVMHgWaqjR5J0blVKzElmAnfvCtmLvRTQvMYzPEgvYfKNgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776633046; c=relaxed/simple;
	bh=X7ZWJUkQepSfNRj4iKcM4JxdLMuKW3iqbOrtJEp9Tgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6JOdaiD+fOV6fEo69BMDfFvy5NExZR2uX+2N9zqHByJVM2JxzVLeotO5deSFDyHD+Pfc6D+MBGrwy4a3Z59tbAM9tqZrUxuVVC4uXqu0Znl9b2J1RKWNw4io6LC3dK08284R0+fB74+BYfiGLGhmQGcE8KBsUYqabZqPSEZzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dIfUKwfV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dIfUKwfV"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0046078so22625985e9.1
        for <kvm@vger.kernel.org>; Sun, 19 Apr 2026 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776633043; x=1777237843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qsg8rUeDLQZVLVVnW8TfPXsM/XMptyJ8w4S6dfSGN0c=;
        b=dIfUKwfV6g6gUxohz7TIJZqRzYGeE9HzG0VxXlj6j1+6vgyjbFnTxDIyOgfg78J0Pa
         UImzEUPFB9wv1p+NLtIl4zlniY5mPSpELF7KSt4qPivZy0VnabY4tRr3M0gvbWIF6vnq
         kO/iBLZQotSuNhAThMlNnumzWZV5VbLLFd0aqejEBzFz8CJghfLAtRIhrUElKNmOBeFx
         QL4Qz6I8dP2y819LssrpoyUNU+1+Yn/BPPm2EmBUWd/TveohySNqM5jHmiScCktcngDt
         9OKv+zKmnttZpMKdZqxS15Q21vC+EswcFGmv3zqJ+xvwVV+MpGVjaPJCe6iZ+Z+r6lz0
         xV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776633043; x=1777237843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsg8rUeDLQZVLVVnW8TfPXsM/XMptyJ8w4S6dfSGN0c=;
        b=Xr5wgudUz9qsYkbeRECpS0Q3j6irDMmrx6SwJyqxYmNdCaNxUoMZUuhPkRsvp0SJru
         /N1i5mkmGVxjubO3lTQL63gEEemUyczbcM4948MfzzpeSJkop0peBNnrPuP8eBnMFwZz
         C3sCOwW15aOXXgGAeK97G2yAVMkG8d9T3L40xZVCH6cP3yPNxkkzOrIMlMkmhr3QiI3v
         PtBV9cOBub/DiylC2rsmvc2egMZk5ryjovnV4DO9k26yUGjTU4w8bDri92QTglQIXV1m
         0uVkwTn+51GB9JhZQ0Rtbmkam9nhZ/HKPCw3iCegwHTnakXRA4r1MqBoENboa12P2Fgf
         dOzg==
X-Forwarded-Encrypted: i=1; AFNElJ9lJXkvjvxwNgJOR+jDPlvQX5NwKbsn8QbWKQjbnTM2lEjtlPbeexbvgKqLKAu6iVypaFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze16bXvt8l0N6vZQpgx/32peYQNlOnJoHYnM6mZW6CAkGQJbBU
	f+SxDTpY6z/yY65lTHmwk15WwH2U130eKXfISFjSnyHONxLM4SViMNwS/8aPHJdsvk4=
X-Gm-Gg: AeBDievN8pb11/v+kY1+1RyD5BR2iDvXFRR8F8IzgJZARgWSj2DHlgjmUdnvH4xWNoT
	EGTi81PMk2h4bv2A75Om6jWrtS8cwPXvM2FuRY+IVbQZVocmJTxeAPsZuw7WIsydUbw8tKYg7PP
	eMptqPl0TIf8GDKX8FPYewOg6O/H9EIwKISN+tGe2Dbs1eJRwOV55fHB1wyuirH9ZAnu5X2PvrC
	UAF9hk21DMZlTv7kCgAFENpUmS+OQfQaUdyMe1FSCKjJhgeWzgSdNCG4L8Yf3DQ5R7d+KDxXe2Q
	o3dK5u/DufvwGs9baWDG2BRhAmJAbdjFO9aUvWM/OIfcOezkrUnYuxS5jhmQTSKld4sSwV1rNNH
	Axs2f4+F2awRiTfB4Xtsitfv9D+G1IPNr0O5u1TMPmRMJ0U81F7+f/LzuGodMZUA6/QQi0e4itc
	FCoaRXOhkrGmm4zw2UhGnK7gKe7EwG7KfIZfQiffPRng6BFGdqV+xvkeN0DokoJlLNTcUkO6vDY
	rrs
X-Received: by 2002:a05:600c:a30b:b0:485:17a7:b9c7 with SMTP id 5b1f17b1804b1-488fb750a2bmr102595625e9.10.1776633043197;
        Sun, 19 Apr 2026 14:10:43 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1682sm24603336f8f.1.2026.04.19.14.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 14:10:41 -0700 (PDT)
Message-ID: <e3916acc-98c6-4ace-b990-94084597563f@linaro.org>
Date: Sun, 19 Apr 2026 23:10:40 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0? 0/6] qom: Restrict compat properties API to
 system emulation
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org
References: <20260325151728.45378-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260325151728.45378-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/3/26 16:17, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (6):

>    hw/core: Move compat_props_add() to 'hw/core/boards.h'
>    qom: Declare GlobalProperty structure in 'qom/compat-properties.h'
>    qom: Declare compat properties API in 'qom/compat-properties.h'
>    qom: Restrict compat properties API to system emulation

Patches 1-5 queued, thanks.
