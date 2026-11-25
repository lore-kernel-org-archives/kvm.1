Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605738;
	b=X7MKKvkZi/ZtBtL7Gv5fN3eAt/AIfLjJAzhfPy4pWyu6K38C+h1h4raRXN3kF5yu9CkA
	 3NKauEi7I+plemvcWGBENOktVTjm6M9PJnq1vJg6/cS7ysktAayGKIJb2itub39qXB7+Z
	 nGvhFpugZ5dPwoYZM+Gx5yU5J2P+w/kmtY/OU7dt8Ik9fN6H0te4FVJH3xUYJGf8vClCM
	 Wc1ol8p0mUtYOlS69jqvWwXOpOA/kygDjuwiz5qhtCPs63o0HD2G/Bh8SdSXKWCaVuC0B
	 vpV47rzVFRgofG9m/K4degVhlKs+xt50rapwWPOTSKX11fBFfkg9a9R/gu3VD/XlHsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+VqXgEXAo0W7Ov7bj5oTGwHXJdLibEdQSEpyUHuL+7Q=;
	b=qfaMsk3BxZavr/qXfsYTxblQqzBZ2RVtW9hwdFyfEQiECpUi/Mg4qrfMH8pP3sKlv7S1
	 L8IbG20U08H90S4cckgK6WZND4duELJVqKPEhlQhvWCWCR7Fgh/igkxgX6MyXzm5Q/ImX
	 4KkzJ/BYOP/NEbWrpdhXKTR6P0YP1e7cOXjP7kuzUY042gGedZwvlfV0EGYLg8PgnWbUq
	 HVXNSHdG4Luc2AIFrXHRXI4GWF2iIHcqVCcHTPRNUmYBDYEras9Bas1D+9//+zQAJdClv
	 v5aVesGOEcmwl6BRH9i7D2O6qd8zD/u9GaTGqeNAHHHM/tY4jlJqcch72pxHqtShR5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CQ58e2yN;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63955606A68B
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63955606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CQ58e2yN
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so57771755e9.3
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605737; x=1796210537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+VqXgEXAo0W7Ov7bj5oTGwHXJdLibEdQSEpyUHuL+7Q=;
        b=CQ58e2yNh78BEq5L8IV+JiZ6lRkrUQ7n52on5qeHknjvclUM8kHDXs151UyE+e4q8n
         zGvhQgbLdGy4fgToD+pA0qXlzMf3djtPX+4hY+Za0zBKVFA5Ktbe/ynFBsaAWOUbRtBP
         375eWOykYpdshVfcRRXYaYuagXozRWq2ZUeX0auPw8YhiPBRbZ69gx144SWRusxKnjXx
         1mDtSsfosTbyBlj40es7DjbfXkzRbdSmIYXiy/Gx0S4tY5QGKa5W2gncYuK1ZfjGJ6kx
         uBT2uz+BrJOOI7L4OEGFS1tgsVuGRsqFPDSuv7eYaxW6hYYhnGS294vZCxRQdweqTGxD
         y9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605737; x=1796210537;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+VqXgEXAo0W7Ov7bj5oTGwHXJdLibEdQSEpyUHuL+7Q=;
        b=VwjNgcioBx7VeTcdCqD5sag7PVn70jXPZZmsXD0QjmJYmJadSsBUvItUhZgU79Uitr
         iFtGp5lk51LKxzWCisH56H23htc6Eyvk7bhr2givPM+0BHBcKpiaqpNPgVCq8r7sFrxT
         2ADg1OkWogxhg9XwV670ZSJpuYlLiFoEEa92CjWHA2PsMeYSqsaQm5CkTDvA3WXbCT4r
         lDivsdvoE1HE7LNMx+nEorglrX5wM1W1qLn5l2aVZHz+qa6xZXwS/xhCWaKea9WN7gqN
         ppuQtUBdGQuLYqaaGd/KjpNTtITu8RLuDtB4JCGelFhmoKm723Tml5Aq5ZUQRiEOEy+l
         NmXA==
X-Gm-Message-State: APuU4Z8fTDxOSa4UVVGzSjIKVYQByuXfoKIklQ/wzybYVbcI7+tUG465
	aDDHt2W6DATUvYG2LWQ6x5jIE4msMCR9TO6ZioTsNT1KekhcZWH8RM6R4X8j173B
X-Gm-Gg: AZFdTZe1RT4Y8Yhhe571fB62blkWAyMiARTmCVdDNVSpD9Ne5twQHrnBVov4tVdgJ42
	fCzTxLffyJke7a7N+DYJ+c0Lx+1umfrQGT7TwK2g16Lt5pbncZXc7NpKUHUiGEhm7u/dgztJw/p
	0+S93oGxulQp5JZRWfk/omL1P3hVac2j/EwIYc0t0GKVAE8zEkAu2pvOHAaDVZLhVAiU9GOKOlM
	tUAfEcJjOcTgrEg4jRWWqWQkdJ/A/xGFqr1LG1DqB93EaHgTkgHBbhuupSnwpugQmz2AVI2uXyb
	huGZ1fC2NqUhOE16zOd9JjnPg93geF+OM7r1vGU63qCW7t3YGEoBEIgCWN3DIXk0FnaoX+9qYNc
	+XbdLHbRLba5R4MHAWxv7TvR+5uH5efthXsVI7ETOG7ThwXSm6eVgLGrPZF/GaJ7wsL8sjKn2U0
	YvFfvFDewgrMsrTVnz9rseiRMOTc7Z5PY6HgEIlfMNZzntLHjRKlfVogjG7FuMyjC0KuqKy0ioW
	rLVBFUokvJC7J9eC/h3BRnrRNNC6X71pUB5Q1/3GGuI67QfHHYuHHmvHG/SL45YQC38QQMU7qgO
	pZFPfYVT99uXT5Qni5o7cp/1mEFUynYswhU=
X-Received: by 2002:a05:600c:6219:b0:4bb:60b1:4409 with SMTP id 5b1f17b1804b1-4bb88816525mr338919345e9.19.1795605736781;
        Wed, 25 Nov 2026 03:22:16 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865b1sm512927855e9.5.2026.11.25.03.22.15
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:22:16 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <4a230c1d-69b4-4035-8bbf-fddfa40d6e67@xen.org>
Date: Wed, 25 Nov 2026 11:22:14 +0000
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
Subject: Re: [PATCH v1 12/21] hw/i386/kvm/xen_xenstore: Apply offset before
 truncation in xs_append_strings()
To: kvm@vger.kernel.org
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-13-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-13-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Truncating a string to the remaining payload space before applying the
> requested starting offset corrupts the offset accounting, so
> XS_DIRECTORY_PART returned wrong data for non-zero offsets. Skip to the
> offset first, then check what fits.
> 
> Fixes: 0254c4d19df3 ("hw/xen: Add xenstore wire implementation and implementation stubs")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_xenstore.c | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
