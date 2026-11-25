Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605642;
	b=D/sVkr9lF2+vmW/iVttu0M0sgBhgCuKrIf8yaGGaUbfra9MXWtZlM3okuARkIX7urDu3
	 RHJubWqGhxuPx/iWDEw7XYJkdC/TU1Yx1Kb/8mgrY4AWyH+aCroqv/j2J15KbQh496WHI
	 mivJI9ZYjN18AOFbdQVIv2zMxE7kSCCmWDgQhNVXmAya/7/+Z7NKEhWPJoxAZeYxXojL0
	 yRiQD6dPrvkhhHLZuPrPxhia7Tq7Dt4EyOrDnzIou+hr6laxXK7YFFuueE8pGTNIfMGE4
	 W5F5sjC/xuyZ2tHGdgfA+cObzCyU7xaGHde0Pmxbo9oCpuX7eBkfCjxMyg3fiIF2Upw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=F0TEzX8owPDEFylfafKACLODZUkHUsBKXKTlKA6Xs3c=;
	b=bDRrvHjg1Af+pSInqKOjqQDn+U03kCxg982VhZpoHYu6IE1P8x8aXcnh5uq4cTvkBYQd
	 zHJfv1tBkERXYjByrTVLRvYg62KU8dV9WHqSR9xhTAg6gUikgqQHsMM+FXziEP5s0X2yQ
	 4iAu9XTwtkqiSGxjf2b7seQUNNxx25k+urR2MJmSCCZOEjlZ8/OGkhle7137+dsl010wF
	 TBsBA0Hwbny4bgBPrSnA1Eo8sKcJyXxzp0e/Km6M04ELV8Bz0gbhY3jMerCfZOhrpht0o
	 kZ1WR3xXJDM3PTo9WOSzmtFIVBfvUnyI6T/XJIEdwJGyC2OIr4uN1EcUg9M3hbWuHEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8cYagQr;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B36E606A327
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B36E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8cYagQr
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c506a231b88so766864366b.3
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605641; x=1796210441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F0TEzX8owPDEFylfafKACLODZUkHUsBKXKTlKA6Xs3c=;
        b=b8cYagQrDfMr1sCiWyKS5MzjavcnR94ZVEcRbBwy7uaw1imwFhpIIxNfzU7sDTBKr5
         kTrWweIjzlkVQGjx8OeLMpkwrF3r8+BlPbJ/JTchpvYHpMG3sUmE4LOCtM0xexp14/xi
         NINNYuFQdA0yHtgw99drKAyqvmgp+Ctn8tcuuG9ixe5kfja1PReT++kjrYdRCWtJVxdm
         ED+YDv69muOj+E3/NUs87gT/vehriTptJMHt17UEjxALYCmO6zdQKcS3RbqBNSyKFwh6
         PQc7LRVn8HeXxJ5vYnvD+0yusQg39jYOD065kY92veuOfMzg8oHLeKbEuAkV+RVt3aa5
         GTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605641; x=1796210441;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F0TEzX8owPDEFylfafKACLODZUkHUsBKXKTlKA6Xs3c=;
        b=BDXQn9FxD37CXL84D5geL6miYx9jglkNVkVbHPpm8KV6cn5gT+U3fbMGE4JyG9li7z
         6OZGONKquNM5FoBGX4GEBbznW0/17m97mXnSpbZ4lEcBHnGkAY83aGGnXouZiQWczBKg
         gsWWxlyaczbnh4FDe8s9gDWehV3WFTr6IIaePyg1n+78txRqCwZMJGbu9Z1nP6SN7wrm
         +ev1gSoaC5jm8XRiwsRuB6DjjdCloDjB8m7iLoXaw5fUnAzPp0ayj3KyqLLE0aF0Gk4q
         M3UHiSHoR8euzeFFQOaO+6rX7YE+nirT7To2ARUb75yoePKXQutIXjXX+92Q99jgwln2
         oQrg==
X-Forwarded-Encrypted: i=1; AL+hErEXVZbCOxeAQ6eLLcc1b0jBxy00nNqRJKt2W1DGlCZNgz9EHinbBrTsEx0pNKTWh+4T/8M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PCSKDIxlc1AOsWE0rdhLf8sg9pKR0z0YizLst1dgEWnW88QZ/
	wwtlZMqo7qRRtIRv1HO9dPenBuDIXiNJQII27UHf5bgWBmdr/oU+Wn92
X-Gm-Gg: AZFdTZcpM1VycKNLMPm5RfGgMewoedoqeAtHukQWPaRs8kxj+b4T5RM38qy6KkB8K0g
	/VMieWJFbuODyNkin6CJQg3Ps8reAiBjwghk9gTI6qkk92fIA4+AZoviVM/tD1PcRcdfPuPzGNK
	AuexH03STmNToSmfeKMuercCwuabt5YAgeOdpZG6VsfAOFsFo1UELTdL62kql7SKjh9PCfWfpj9
	S6ln99Cw2X7+O0P1dMgTN4xTuT0iWs/EwrF42P5l6o8YvEHEr2eglG298KY8PXpA7fTshqE+J9m
	FXJRq4rZP5TVhQrL3A3WZDZX0CLktTxOF+MGKfsqlKkjVcHJHGI27Ant92opABxOGAqqC7zaWek
	4bpJbrGAknKGLufnW59gpIPPFBI6Yci5JlPUw14iBRaXhXa/RJ5PqV5vp233Oy4tcNHuUZJYgxa
	RPzK6KRMkO4Ar6WeK24xC2ijdF9ALo4oph5Hwdym8rEEfOhIsJT2hPVAh+lRDzBglcLaFyvV1NZ
	t1vQnBabCPj5BqsOPg/iNfWsd+n/Dlxurf7rhqKt6/rEru3wh3URN5whYu8kZglb6+XoDh6E9QJ
	AYp3gKogfPNVGIpkT0XwlX71fl0vIPiAz4U=
X-Received: by 2002:a17:907:fd15:b0:c40:9e84:942a with SMTP id a640c23a62f3a-c513aade153mr1470090466b.48.1795605640666;
        Wed, 25 Nov 2026 03:20:40 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc244asm618232266b.55.2026.11.25.03.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:20:40 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <e8d79c86-324d-427d-90fa-5a662b4815a3@xen.org>
Date: Wed, 25 Nov 2026 11:20:38 +0000
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
Subject: Re: [PATCH v1 11/21] hw/i386/kvm/xen: Don't leak gnttab handle on
 reset
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-12-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-12-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> xen_xenstore_reset() and xen_primary_console_reset() open a new gnttab
> handle without closing the previous one, leaking it and its mappings on
> each guest soft reset. Close the old handle first; closing unmaps any
> remaining refs.
> 
> Fixes: d05864d23b1a ("hw/xen: Map guest XENSTORE_PFN grant in emulated Xenstore")
> Fixes: a72ccc7fc449 ("hw/xen: add support for Xen primary console in emulated mode")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_primary_console.c | 3 +++
>   hw/i386/kvm/xen_xenstore.c        | 3 +++
>   2 files changed, 6 insertions(+)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
