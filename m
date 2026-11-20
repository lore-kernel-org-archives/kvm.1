Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187353;
	b=G5fti9cyDTW2kVCHBCV44tujYyN07np/qSgZtgXdHXDQW1D1305/1833a8VCJpu/qHS0
	 ZSVUKpsSfWszskghg+TQMZUo1/js+pqHZ+kyJS1cnnWVfbKTcf2gdhkYghqcMPXz21mi3
	 aOUk3X3OGUyYIuUZ4bgKskYVMIL+BNZTQQnRwg4JRkzG6CERhWrIZlrGBJJ7mZBgwxO0f
	 K9sgkYsu1GR9r603ojZeoJju1eLT7LoWwMSoB3MMvjTfRntym7mfXoHYCBVLY/u5TcSgP
	 y9RAkjp3JbHcT/4yDGCp6hQ9c31JtIRew3uWc2Wf31vZ3NN9tKbIDF9GaZLVomxA++g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187353;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=zlAi7h+Lm6UL8iaIteRD0TIFzFaaCRNPZHXtUJIrj1g=;
	b=Hg66PlwPyBGjFf7SdHPX9HCoiWph6fbxOqoleK/Qa/XpzEg35gRxCyMM3TpzJ/gRxff/
	 AB1cYDv7F50OfN/6D6pNA4CpGBkQNngF2KtMAYPT6HKZ+IMbJ8zBZyrWWPMhUHW6WKZyp
	 CVz3OrBP3F5co5Qaymw0ZyvW1hWRV/LPaBt7rNtoMNA3hqfviyiZLgdYR4nW/vKyG7ZCu
	 OS5iDr9RBbxxzr+YVJazcDBrsuA+LYUNEnR8Z8BaIpgNi9O1JwDuvY2AXN0FZTdVASd9w
	 XN1MQk7408uLIhp7s3el3bqNWwHQRXdCbPJBdlZN70C+yVc4CFuwF56m/CFFsW9GoRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FLib91bf;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cECoEMjH;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8CF606A326
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 15:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA8CF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FLib91bf;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cECoEMjH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795187351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zlAi7h+Lm6UL8iaIteRD0TIFzFaaCRNPZHXtUJIrj1g=;
	b=FLib91bfiyJJlngcTSzL3qj8uLiTp16tGjSbJDzXMaT2NyNiVhJFnt2h2SUfe+bF4pFAde
	6M1Ft/WNWQXMqzZFBrHVwHGCfjXhm/XHMY7sW34Ro3ICnClz2W/pgGKMmFtCOVPSsHd4gJ
	bIbV/0+eIm/u55+dxQaHQVT7pZqlt4k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-ju0PdiHfOSGbjdjlD9qkkw-1; Fri, 20 Nov 2026 15:09:09 +0000
X-MC-Unique: ju0PdiHfOSGbjdjlD9qkkw-1
X-Mimecast-MFC-AGG-ID: ju0PdiHfOSGbjdjlD9qkkw_1795187349
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a17741243eso5625875e9.0
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 07:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795187348; x=1795792148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zlAi7h+Lm6UL8iaIteRD0TIFzFaaCRNPZHXtUJIrj1g=;
        b=cECoEMjH1tgsLe/yDFM5r42IpF3TJqWnq0pkwgI3ms2BQ97JIPra4hw3HHe1SaHYGY
         Kq0yibY3wkaRkDR2ny17tHHwG5PsR/cgX4t+fC78EqsNsiqI1yNfu7dZMp5tWsK+k4ME
         biRXBdBHjKIONBiV/Ghy9Cd4vZw8gSicYarmPbR0RUaiZ8lIcP6cOComfvqK9zN0C2Ck
         BeQVd8wXpd4jHtjZIvghBSFDoE139PbeaiSYkeRGHuPDt+OF1rlGz/KU2Nd0kxFvG1S6
         Uvv0+vCdEMNMI36dKSzm1C9d45reqT48fxwHaOYyF50wcoWrazzaZNn9xpeOzzIn5FwR
         aAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795187348; x=1795792148;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zlAi7h+Lm6UL8iaIteRD0TIFzFaaCRNPZHXtUJIrj1g=;
        b=lX798SGbRB+0Mryav82cq6CpWJtJHLgo9qgOuna+N2h64iaM2kq1flKIZi4mnHSDBb
         JFCDWWQMrGn93YRhLaBRY0b/JzJCrKxAaa/Qy/tTm3nUFqahEieJCQpqj+b/xSzVJRoS
         ofDAWAgP5yrH9bVG3Ln/WhyOIEtX5NDccVEK+p2ZH+jAeY0npb+gdXLq/l5GxV+pKpzm
         DIRqJm7tfPvABGwbhgFP7BYrYgWWGOntHxTwHifISFCrAIeGNyexSltb/gSMPcb0iRif
         BHUy557d2GPXlnxU8yuThvs9OsEvt7peXUKbHkv3XKE/bqYg/lqXJX67CxmYmr7CNDjo
         V7vg==
X-Forwarded-Encrypted: i=1; AL+hErEsf9aYL3KtYVLpXqmhWv7uf3EPQSkfIoID4L7tRHmXniTUSbyYcsu4k1Ek9sd+/NXDR/E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2GwkY+SnxGRPp/25WsPWSIZu5NXd5Eekm7MTRJ2ElceDCKQHc
	lnUFY+QC6uOkMM9UYUfqx6QEoOtgRWwiEdP6KLAeOcNDBjY7AvmwMG3FT/IHkrZO5+xQ3fhP8BF
	0l6NKCKEsBSnF1TIIqzVyf9A09QiZ5PaiR1vO4fC5cHwG3+URtBtWcxq8zEXVbw==
X-Gm-Gg: AYBFou197U68oRsghXV60KhFMXjJQ6S8DoHbT20a/h2iH4kg+d/QvK3GDiZ0Gze67TN
	waCmS+dzITvH5Thxm0F8yy0zy/DnTL6RhG+/r2yuSAcWI3yrPF491CY/zxh28rf4J/m8kamHRhX
	fj8DaVXiZXPa1C7GzkVrr/OTIxsufxbDUBgcXvGnQ3Sm74Puu6gHQlpC12DlcuAHt1PYY9788Zv
	ISjI1bFckv+0irLt6pBM8/obPpfpnFIkECEFz0uz1aCvrJmitpIzGXxZ3DQzx5KZcXynWOT+Urm
	FvEtV+XPhELpNHVPvmov6DUTA1iaePg8WuZ8HoCWTbRzAGnhjNXNVEPGXdKTdrFycv/xrybSWr+
	ThJrtUWk1OnUxWIPalXnsk/lA2NGMfcbjJjmHpVxbgkNS
X-Received: by 2002:a05:600c:530f:b0:4bb:68b9:f615 with SMTP id 5b1f17b1804b1-4bb88810b22mr73734015e9.17.1795187348592;
        Fri, 20 Nov 2026 07:09:08 -0800 (PST)
X-Received: by 2002:a05:600c:530f:b0:4bb:68b9:f615 with SMTP id 5b1f17b1804b1-4bb88810b22mr73733505e9.17.1795187348230;
        Fri, 20 Nov 2026 07:09:08 -0800 (PST)
Received: from [192.168.0.9] ([47.65.243.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm128131515e9.13.2026.11.20.07.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 07:09:07 -0800 (PST)
Message-ID: <b51c856c-2c74-49f9-a55b-ad82e5640429@redhat.com>
Date: Fri, 20 Nov 2026 16:09:06 +0100
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
Subject: Re: [kvm-unit-tests PATCH] kbuild: Regenerate asm-offsets when
 headers change
To: Andrew Jones <andrew.jones@linux.dev>, kvm@vger.kernel.org
Cc: pbonzini@redhat.com
References: <20261120143826.1428887-1-andrew.jones@linux.dev>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261120143826.1428887-1-andrew.jones@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 20.11.26 um 15:38 schrieb Andrew Jones:
> The asm-offsets rule template expands $(CC) $(CFLAGS) at eval time,
> before the top-level Makefile adds $(autodepend-flags), so no
> dependency file is generated and header changes leave stale offsets.
> Escape them so they're expanded when the recipe runs.
> 
> Fixes: b9423a4fc5a9 ("kbuild: Allow multiple asm-offsets file to be generated")
> Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
> ---
>   scripts/asm-offsets.mak | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/asm-offsets.mak b/scripts/asm-offsets.mak
> index a5fdbf5d6d6d..1e38897d081b 100644
> --- a/scripts/asm-offsets.mak
> +++ b/scripts/asm-offsets.mak
> @@ -35,7 +35,7 @@ endef
>   
>   define gen_asm_offsets_rules
>   $(1).s: $(1).c
> -	$(CC) $(CFLAGS) -fverbose-asm -S -o $$@ $$<
> +	$$(CC) $$(CFLAGS) -fverbose-asm -S -o $$@ $$<
>   
>   $(1).h: $(1).s
>   	$$(call make_asm_offsets,$(1))

Acked-by: Thomas Huth <thuth@redhat.com>

