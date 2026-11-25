Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604999;
	b=PaELNXvJxpnTDikla2ZGKMcdBllJODdfSoddTa68rOMO13gp/lqI+rdJRRbUnF3YsIMu
	 0SPUJQqZIHVUNc81r1WPnrTcVVQD4mZLPpuqk0+dhXo0CCuyCWeJ4T5V+E0bqJoaxsN8h
	 L2YXJtw3fntYfXVgXLo6qxk7fkcWhrBRg+PfujeVMuYab9M+mP8A+XpBoIDj0Zo7sMA6b
	 NBsKq2X2KxBeenZa/QdMolBMfVJ2TSCfNgoZTEFhmS5c4xHyX0T8rbBln7tuAJ+XPcD9Y
	 Z/tQzDpVxpDjU72P1HBUmh886DMTX5qm0mCe2A0LOhcQ0ZftVPYpdajYeYQzyBWgIwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kfPJCXNF97QeG6OnA8OUfo8WFxokwzAlfPX1tH79C4g=;
	b=ljzLIR3vT/SiK8qNvUXYZnJPyrCu0FK1MOPa59x1E1A5kTX3xu4gKogfPHlkKbBdUJBu
	 1kOV/DlDRbNzpVjsntlp6MH8BXIy2fwP47eLP8WHjuo2i5DeVNeUcGhu1s2My44CAnthv
	 NUwBfJq+gx8McG1/cS53OPFbe7qwQE3F9W3XirxRIdtAM/e7qPyCzx1YEq3cczTEbPeFj
	 VTjZab0Kt4T4wf33bVg06VAEjaFMMhHzcKDqUTN1azfoJunKq03J6pyj0B2I2phOrIVCm
	 Qiik4TtHzC347Oa6P9I9G7rBI6kfesESHBeSiRx+qv/ZIXB9tkNvjj/zh/Jgh4WIc+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T1+HLAwo;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607A606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6607A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T1+HLAwo
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so8886927a12.2
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795604998; x=1796209798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kfPJCXNF97QeG6OnA8OUfo8WFxokwzAlfPX1tH79C4g=;
        b=T1+HLAwok9oU+3zXB2tHkfNK+MpNFqYQwpYZ9DUko59qaXnPudTfFC0yqsYjixbYz9
         GOgrS+VVABiizPlZ9ogOrL3alw5d9bQ3zWELoJQla3vIiz96bVcS+ijj1pJlhRZsWFay
         2UPbZ0m6K5Aev667Yd57lXSc+oD7gxqsm9NKAKpFRcFmnfmFd22NxmZBKfGQ0rK/nDID
         ONZqUETLvomHpAN7so5yq1XHC8NnpkF5e1VG7HZsE5kFCGCNd1cmh50GW9bUHHIbDyUU
         ICBIl2Wwu6s2cOBGe8ruencei8gCFaaDMneQWomxqk62mMFakxSQNR7ieamiwPwPmN9/
         S+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604998; x=1796209798;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kfPJCXNF97QeG6OnA8OUfo8WFxokwzAlfPX1tH79C4g=;
        b=HjPvOqPJfnEysim9aqlT1zhYdsUlblaklzbINf4VrqvQDGcdQDERicy/bB6tnhiC6E
         T4A5DaZ+LG7emLBBQJ43MzxLbGqjxnVDdxmUOG8tZDW9nJtz6JxPnEtlfS0CpyONOKer
         JWgnwk5cxcjYCkrR2JokB7YvxOf0BYR4C7Vfy53hrDK0x9F4EMb6HJVPtvfhffotduiQ
         WUeuiwqruli/LrQkYN5iL5UipiSYNr+Kp9kobDdSLWlvkpC8SzN2d0Q+Zl7FniNlK8o7
         5VNuNZHAgCiz1U/AA411WlhkHAJhL+wi74uHmeRrZa8b/IHu5EbVMBT1xusYqNHDJpxJ
         s0CA==
X-Forwarded-Encrypted: i=1; AL+hErGoCGH7Sp09ccivgpvgod2ON4jbEPLTUpLM6HFvHO5G34+YX7Thea6V2/o+qHNroF67KnY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yn7Jl7HCjN0WJWimtIOgCF7Km9U11x4zo9qODWCdIY2o0BuUZ
	HmlyLzk/mJT+iF6ftPhf8r6qza4AQ9AygHPyM2QFNwCJEoKnMLD6ARKC
X-Gm-Gg: AZFdTZd1JkXFLjnGQCh0y8N1lRXpxpF7KzJh/Py5uED9TcozVEhiyiRpRdNnz4ZOT2c
	kMMONs0wQZ31b1gu6YDRMaECVXhlLdMjjL9CnbsIeJPBuRlC7QKYxMPuEmCSEajQIZZ8C8YMBx/
	p+s+369tqpUxztOzhzmkVIu1Uz1JbanGE9nReroRfHGXKHeSO6F8sz4O63P7msnx/6qPt83G5iP
	aZ2i8dcfP8MsLnQUCVghwdy8lKviKTDHSRy7PQ5jnR7p84t8dmT5MRNdz8YzOdBpCiUF1j7lb93
	nfYaU1/10fMPaj4dMOFJoZcC3SiZVOsZq4M+QFFdyn75WOxt/2zVNGRaplV/0RgcaxXKw5kHFfx
	dVWz2C0Rq1pd5OpSSMebWMlLqiTTcwYbgNA3PG1WpcLCeiU/Nth46pK2UpepTBHSkaZvzBxWs4j
	J3qPryJj1XWPSwvC97J6stzIP9hQtwexgMf8WYkgztYMFYctpXXiSXuOm59bagthS7k4nWyGy5l
	b3XgItmZmPMbLTj3aHhapjlC65NGeA8XZaKZ930rjWj5cMLR8xo1IDG+le+Qp1UA5WS3/sAqcXJ
	Uuz42g2746hoRGlehzo8BAr1ZHJp31G2uP8=
X-Received: by 2002:a05:6402:2743:b0:6b4:be3f:51b3 with SMTP id 4fb4d7f45d1cf-6ba37d17d1dmr13152584a12.12.1795604997575;
        Wed, 25 Nov 2026 03:09:57 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e8ad0sm8023171a12.18.2026.11.25.03.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:09:56 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <70dd9b2f-3c91-4363-a61b-2569e60960e9@xen.org>
Date: Wed, 25 Nov 2026 11:09:54 +0000
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
Subject: Re: [PATCH v1 06/21] hw/xen: Validate grant copy segments against the
 page size
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
 <20261124232247.23169-7-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-7-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Reject a grant copy segment whose offset and length reach beyond the
> granted page, matching Xen's GNTST_bad_copy_arg behaviour, in both the
> emulated gnttab backend and the libxengnttab fallback. The only current
> caller, xen-block, already bounds its segments to a single page.
> 
> Fixes: b08d88e30f06 ("hw/xen: Add emulated implementation of grant table operations")
> Fixes: c412ba47b2ec ("hw/xen: Add gnttab operations to allow redirection to internal emulation")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_gnttab.c | 10 ++++++++++
>   hw/xen/xen-operations.c  | 11 +++++++++++
>   2 files changed, 21 insertions(+)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
