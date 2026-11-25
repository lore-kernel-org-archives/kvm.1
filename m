Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605996;
	b=t47NnJTXyfGOPcRA/Fg3MmwLP/p6nRUyMsfV+J/50hVDDWVRzY5UMTKwO4TsneGt2hjH
	 4cNsdwso6vihTBGjKgNwJaoR7vyjCwmkKkX+czUfODM1B/MghwYclhqimww8BKMl6URku
	 AH04eMx7k2/l15htaaGa1O2XlhAnThvipeK2u0tQq7YKH59cTErBhhMJSEQ1E1XHI0uEe
	 fen8Pqhrjv0w+Mfb31ofKLjZhs4MArdbxKw+rVd3ta+ehdfdCBpz5Bd0CwUZP13xoXLy6
	 /U5y0kkFB/HjXV7y9h+AZJiZDDxQo3ZvVwVpLkp67fn9/V1Sojtdxu1cFDGTosXZOpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=tmWNrfSIBJkiHKH6i1Txnc+Ja5dKtR29QkBEE0TVhIQ=;
	b=mYM9/JPohx/Ye6mh2PrF9aj6eaywg15Iyo9rDiesPNvNhOk75MOzJUqlNMwHJ7CKxNai
	 1yppGQbdkh3IylNsrECB49TOPs+guxN5W26/srHP8reiG+91rjEX7cXmhCmR4eBn6n3Kt
	 00/4f9tDss45zZU4CCFrrcvi92H3JoUb8pcFXnrzT7bOgCkmXPkH8x0saiolvU4Jrophu
	 AiO/VnoolZ1u/U36f08nxue+J7pBAYirr5XeNs2mzr5NqZsDSIrEaY3KBdijOeilzjGtv
	 r3CqDbijrWjzFZXG3BkQLHx+w2rIUxf9pTxHiMvEObT3060GUTFQaKMQNP3fcAR1JIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c6jkQCLx;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2983A60A2618
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2983A60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c6jkQCLx
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so45291135e9.3
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605994; x=1796210794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tmWNrfSIBJkiHKH6i1Txnc+Ja5dKtR29QkBEE0TVhIQ=;
        b=c6jkQCLxr0G1DeVFTd0QGsv/QqlrodoUyxRvzt5IwLlIKqZQrkpmjBp3wg+ue0dyCv
         FJPhFFo2WRQrI4tTs6r6vO4nTzT6KVMPOVK0FJP1WfEwEyjf0RuCAYTB20GftiCBEpbB
         xXIIWDcRAPLwesPK8MyrTnGBMX4zZKCVoqGNh7m6WO18c7rtOimziUJf+wVIcDo4y+gx
         ddR4VaY8KOVrgPMUjarEbBgq8jhGv4s6xdkxQNEHGLS2/Bef8nt0cOqcWNYFSvlbAKoE
         Q+tIX81IHhjFxDNA3uiLM+QRgLBOiw6qYoswW6Y2fiS9MfE3mQHFcz/+QrxFA/GlDcR4
         jQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605994; x=1796210794;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tmWNrfSIBJkiHKH6i1Txnc+Ja5dKtR29QkBEE0TVhIQ=;
        b=muET8KtHcxhruBEuK/cBykJc794IRkRi/9pI66lCrjLa+JZd2oTCm0LkHasDLyhpXT
         IG5dhHuCRddk/9uporVQOkvowFoL/elT0vQHj0VaDIyL83dqudsLAilYMGgMnYN7HpuO
         nn6RW6NYHszNboyjcrNStjkaHiPvrhBySkVxNEr6zrMTRJQ0K42u78A87feo4oQDP8p7
         GqdckCMGh4Cg5xM7L3hbe+uR1+lFq+yEy8R9Gq5zalCER8Fu9wiyUzoPsy4+1sFnXYJh
         biTC29G7MRdOE/2IcRCsMMyYZvusXJIW9FFO6tRc2HwvFYv0Wbs9yC6dF9JONWG1YAL5
         kWbw==
X-Forwarded-Encrypted: i=1; AL+hErGZtkp6vjX/+ucdtl7jpGuEbWetP4mWlSenE3/bYhFu2iQ51o+wycrMEPsVVXWaoB0p91Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9L2IJtrywUWaebUxiK/qiBestj1UKLAkxVjrWdffPX/JO4R25V
	4h9Y6kOsb1OaQO91K7+EBiirsHZV/XPhb5BYVPRR9F7xw2LOSgThgWon
X-Gm-Gg: AZFdTZd4ItmSe8RGit4Wwx0jboiLZsveV5CCJy+2m5PZNUmIaSZmrFg2gs3OkgVOq+k
	iK2fZpsc6P6gbXfVBV7fl3ScC50TWYsE1wHQ8omBxot8EpUGsgBU7PXg+35xYwaEvl+YqZbEPae
	BApH1sSpSy88+bnvmi3zYjVkkzUr2/pq9FE7vS1ktwvOZZSwhkateU9oIvezyAU75f44C31Uy+v
	yQF7Sk0NYOy7jh9UG/oU1Wz+GWYHwTWAg8arYimfwR+Zf/+wiPUnvpHqTOoDD8h1scgaPthhSrl
	LATkBeXELsz4eYwYglYF8gSAFM9ub5BDyNYH+NocdJCIhZ7E8tCAydYX79alXxiv7y8ABevks8u
	9qci70sQ1a/eDDAZ9KOk/Xv714RticeTH+DJ/EIiNtjAi5+4BBAtUIBw9QjraaCUgHL2phwZ4co
	UldCy7Jx5D2JmNL11VAnS75nn7wC3+oFnkSJRhnND+Lt6qTnXH+wZ5hiMZ9p2qEJ+zSh2Pbqys5
	m7ogLoG9qYVkKqyBgCLX6O4uV4z2G1ZGG5IwPw+vQFXkpLXDGzw1aYSbJdIGHZl3DBydcYJZ2Y+
	dfsLny6WaEucePkminFbZ535PZ6zYR+fUm9j
X-Received: by 2002:a05:600c:83c3:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4bb8880ad68mr345482245e9.5.1795605994518;
        Wed, 25 Nov 2026 03:26:34 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989eesm33880637f8f.50.2026.11.25.03.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:26:34 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <713c164c-1cf0-4daf-891a-90cedef5190a@xen.org>
Date: Wed, 25 Nov 2026 11:26:32 +0000
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
Subject: Re: [PATCH v1 14/21] hw/9pfs/xen-9p-backend: Use validated snapshot
 for request iovecs
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
 <20261124232247.23169-15-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-15-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> xen_9pfs_out_sg() re-read the consumer index from the shared ring page
> when building the request iovecs, so with an index the validation in
> xen_9pfs_receive() never saw, the iovecs can reach past the end of the
> ring mapping. Reconstruct the index from the out_cons/out_size snapshot
> taken at validation time, and split the iovecs purely against the ring
> size.
> 
> Fixes: CVE-2026-123072
> Fixes: 40a2389207fb ("xen/9pfs: implement in/out_iov_from_pdu and vmarshal/vunmarshal")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4523
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/9pfs/xen-9p-backend.c | 43 ++++++++++++++++++----------------------
>   1 file changed, 19 insertions(+), 24 deletions(-)
>
Reviewed-by: Paul Durrant <paul@xen.org>
