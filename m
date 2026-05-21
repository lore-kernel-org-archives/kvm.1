Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE9E369D42
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365958; cv=none; b=ntiAy5AMsSlVGB7d5AmyGkSaJRb3a0DXZFbt+f5+E5bM1C6TxdO/On6/DZX5YpJvnYyoGW/AtmZmtUSXUvXjjvFs8s257EROzgnQ7aCQAvXJesaFsbGpFAG+HhMqA+QHsR+VuHCF5qRuYVNrtSGcdY5H/NZrkv6YEG4BJU6jzdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365958; c=relaxed/simple;
	bh=Lu05FwWZldKemILr3ths7JubuMo8O5Xsgh9O0nruBZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2X2vKvnSQo955K42tYEYyPO3ujnzWBCZrOT2LcVVqWyX5dGwhXebORek1ye7vvDI7q82pjOi9W7yC7rFMuB6eywMXnBjbjgo0DMbWMQHDyJnxujxozzIdm+WaZNuu91hFpzRcmUx3Ui1YLUxgbZAsS9gvfgLu8/ZB2uQaugd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=eo3uqufb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="eo3uqufb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4903cbfad68so2875265e9.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1779365955; x=1779970755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fzi9p88PsuQvbHSP8NSbPLdp4GfD8nb3eE5BwvKa6HY=;
        b=eo3uqufb4ijCP3SNaFlC/Qyp2dOsDf48xCibnUUJkdPHE3K64ipbPjwCDzipdDI7Oy
         fmy87euCt1D8tK1RJbnjot2ocWbrODZfB/KDcDdihIv4+NXnhwUWriWZBM2Xt4XTtDnz
         L2yc0wr+wN78yE4PwHwo8yHnMNzjEHzJCHXZZha155HWxnKwEeRYrOnPaqRWE+zeiqoA
         F/PjlNkHEfDzbKmfCO/+GzBiZvZTVB9yeRNZa4z2YTBfkeYgWMRTmD7r+vD6LTR9S7Jm
         AxQvcGHWrldQObxt5fJQ7rpUWWs81Pqlkg/pl66cFCRtS1qRtFjFdxRzd32Vu9HFUpZq
         qLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779365955; x=1779970755;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fzi9p88PsuQvbHSP8NSbPLdp4GfD8nb3eE5BwvKa6HY=;
        b=b8lfKKSh2zTUlefceziUhYeCQklQ+UNWk0QExkEb8azwPvS2IujDtH0QT2KyDcKPM2
         K9H6+FWD5gNasXRPWQ8z0t4z/MVydCH9R8C43wa712Um02KSuWZ8V470IidnG2CG5kB2
         3d25UFCpSQBtJZNBJ2d4/IRO+HhcF2ndORAj1c/KapLS/qmgrMehk4xd+it/z6+eFm9i
         L1mJ0Bkdp9TD053OUowUZ5U/PjpBS3xXurXvaZHxCVoZ7oluemD6lgSKUwbFF+cPd5EC
         OFypOLf+ca+cdHwbqPeqPIMARny83MRX4IDZhlFNYYd+18tf4V4oWznawFhoEiWbvPzY
         /ZMA==
X-Gm-Message-State: AOJu0YyyYTpl5FPcLVL70xWw+AK6QavJPNZLo0XcdH6SoZLk57KzQpq6
	gJtm4jV6r/BKSxQBx+v0Zu5YpPzpmDjyDApWxTrV/T3PMLOf6E/VWYZdIC9xZEkGkiQ=
X-Gm-Gg: Acq92OHXkkt1YKzFKMQsEE/5FN5hlQZryZ/Vmn7F3KysrkXTfa4pupfaWAxbCzfmopx
	qSUcVnvb5ZT3BQs5TXcpYED1FJMPd/Jnc4VzBwlz+5OtB/W5N/lPcC4buXh5cb8m79sz2C2E+dk
	Tm7ZNy/HwG4bjS9TSj6vq9ixn5V6aQhABorSzpNM9zZTm+fBthJ3KWU2tFVUqbrGsZ8rtB+3Bnt
	6yrOyfq3bRlaRE+2GhIiZ6ps7ZTPEK6ukJkcPf5os5fzPRQ9ZzMgD9kkNPsOqTwwGzS5SxBMiTy
	abZb6juXXoQJZGXG/X7hZucN0saxqBeECMEZKr4sHVfJG01ZLnzigtarQCHlUtVA1prpm5nBwOp
	+feB9loY19eJondDM7WNT6PbiSvihq3+KRJjE8F2LqeKSFZ2TVnhStMHXUxEeWeeqUgEzntFLDd
	5q83hwabQAsDgOkRNgFGHnLGoL6IVbeHjhdTCL8pi+RlsVKsepb/qc0GEtma/hhqfS94FWChmUk
	hpYGV1HBB7Fdld9Jj6xHjXIzZilf8uMN8rdjKidwrCLQIg3T5z95bV0vf7MrxgDhkI=
X-Received: by 2002:a05:600c:5298:b0:490:3d48:6cb9 with SMTP id 5b1f17b1804b1-4903d486e41mr10413575e9.3.1779365955103;
        Thu, 21 May 2026 05:19:15 -0700 (PDT)
Received: from ?IPV6:2003:fa:af26:200:51a:ef03:a698:a1fc? (p200300faaf260200051aef03a698a1fc.dip0.t-ipconnect.de. [2003:fa:af26:200:51a:ef03:a698:a1fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035c595e6sm25865435e9.1.2026.05.21.05.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 05:19:14 -0700 (PDT)
Message-ID: <09aad595-c4ef-4cc1-8aaf-e2300fe5a619@grsecurity.net>
Date: Thu, 21 May 2026 14:19:13 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 00/20] x86: Better backtraces for leaf
 functions
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Andrew Jones <andrew.jones@linux.dev>
References: <20260514210500.1626871-1-seanjc@google.com>
 <d2f3be07-b930-402d-bac5-63a21877f6e2@redhat.com>
 <092d0688-0c8d-4b82-bb62-abeb26845df3@grsecurity.net>
 <CABgObfayKKDr9birEVn=QMj3Lxi5wo9GnxsSDcZByxEC+HA+Ng@mail.gmail.com>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <CABgObfayKKDr9birEVn=QMj3Lxi5wo9GnxsSDcZByxEC+HA+Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21.05.26 12:48, Paolo Bonzini wrote:
> On Thu, May 21, 2026 at 12:35 PM Mathias Krause <minipli@grsecurity.net> wrote:
>>> I'm applying patches 1-18, adding the last two give
>>
>> Looks like Sean already integrated them into
>> https://github.com/kvm-x86/kvm-unit-tests, including the fixups that
>> came up during review.
> 
> Oopsie. I've merged manually everything from there up to commit
> 0ddb0873cf4f1bd584c0981836778b795bab94f0.
> 
> Let's post what's left as a new submission to the mailing list.

In this case, Sean, can you please fold in the fixup for bbe76fbda4e1
("x86: Prevent realmode test code instrumentation with nop-mcount") I
posted at [1]?

The cc-option test for -mfentry is probably too conservative but there
were versions of gcc between 8 and 9 that did support -mnop-mcount but
not -mfentry and the latter was, apparently, not needed until recently.

[1]
https://lore.kernel.org/kvm/092d0688-0c8d-4b82-bb62-abeb26845df3@grsecurity.net/

Thanks,
Mathias
