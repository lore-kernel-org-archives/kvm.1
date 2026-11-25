Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605878;
	b=LTCdwumlggPsXfAVv8bqu+9r1jPNSAuA1k6AWuzSwP3nK3FZFwUjg3jer3yf2Tm1PIoN
	 zM72ZClw8O/Sd12OasX/gxLOOsr5wuWyUzHuxnwb+557NQdv9SlVq1ET5poUKdhP2WHRk
	 XlE011p/au67ZCnfv3aTJPR7uUGkhs1fxn5iks7cVJkbpIoKGWIpRCL8sS7LgIxGYrkXe
	 olJvAPnrzxQ8n8Ir5JDwuqjsKcIFr/5FIoJ0KDeFXfK2IgXqna27I5QCmYuLHymb7MYqE
	 AlpGTFWfym5ao2gaFjKpa7duiimASI76r0ynMMEMsKiYdpYuqwTKu6njlBs9NMUXg4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Gzc2evg1RQu08SoZpm7hU+pHzGBQ6fSq/GTpySlh5ek=;
	b=qEEw4ebjci/uRYpdUjs0Bty8y0EVq80zk+0HQ+Pg7zE7APmjh1K9MBkZV4/hoctPPMvH
	 nmQTx/SAeyzcVn9EGTTGXoCoLCDMdeEc5ijM1PNMFGryTY5UhasIHIGdVoJyew0naikpF
	 okE6gRbB6r4wR6fFP/hpZzpKmDJ1kJlc9LWEIxp1PfBm3qhcgrPbwzCrI9IQUWEfn0Q1v
	 R887jjWN8lA7bNdGBvsRVPDncmIIJS9Il+cOj4gCEnZr/XFNwDPtgMK6YJMDBAdImhljH
	 yjYd661xWacbsLLGrSjqD+DBABp26DSXJQojf15GqVEcDeEFaEWGrVayoyWzzuMzObA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q0BzsJGD;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30264606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30264606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q0BzsJGD
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so934862366b.3
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605876; x=1796210676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gzc2evg1RQu08SoZpm7hU+pHzGBQ6fSq/GTpySlh5ek=;
        b=Q0BzsJGDvtzQpCxZUw7yU7CB8ZErzLivCDQ/J2kU1M3XlLzyTvYI8SabtGMhPso1ZU
         md0+ATuqdvUppXwlCU3IIw1tvDQvAIGvM3xoZUra1dNFLGTEW3RujAqFaHqQVNWVkcuG
         InydjmhgFlMkaA323a0G1Rlv2loky5vQOz6BFU3hfGlJ99j/qJ3J1ROYJlv+bVcZm5fN
         q2RM2H6HvNqp8Ih12XSX+ilH742KZI8U/FvATJzOTJwR07Gc0P5hWGkNi4HMBn29aH0v
         BSuInLVFbT03I7Baz3qLcRf2unfmrlvvUISReg+QPP9/2bcVkM1WZZBnl9W3vqUKJi/X
         GWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605876; x=1796210676;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Gzc2evg1RQu08SoZpm7hU+pHzGBQ6fSq/GTpySlh5ek=;
        b=mvbeOrS6SKkcKyYs1F9hpU7DCkN+TDHkso5U6DHMMlAbI7SIJUDhrXRD8JbN3e4c4M
         +w9ZQYeU9UPCKoYQRZg/1fVhrTyftw16lczUu9px/hHHA4KpcivlxRRShsmAOeNWQL7y
         sQHtsou/tjhXSGNhmliRIKdmEC6Bl0GEIW5s0rnxjYDH1fUGM9h2lZ63+kKm9c+M+9MO
         7rC6/j33UMYNnhSJgvRMVBrYCoA0m7QKr0rkZOuzco8fuSWGj99GDH5tQHx/fpUf3iHd
         +doUC1ViHA4B+kvnxpPCb8gCbuZWMUcvlB0bYpiHIW6QVu2nNJnHIjsMa6zeR3XuaZIh
         52Hw==
X-Forwarded-Encrypted: i=1; AL+hErELoV20ZRi7ibAEsVb0nwn365fyEVYcumqVzfOk7R8wmeByvpAfldDclJOHv4GR2DiEMKM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YX4xuqYwNvbBaBiP3miWondIFoGBqNE6q9u20yRkj3fJvqYan
	0FUJEONG+JrYDb2JOGFXUHN6c2zG+gWFOR1FBnB0VIpm+1j8HmvSnrSU
X-Gm-Gg: AZFdTZdE8hb3DQsUFQYrGr1gLABvMr23rp1O9OLJpl+8HcRVh/sERixxNZqhyfOqwt6
	4yLkWU2OTnni7zZSho49DvBC++i94YLKq+kvR3dyVxDPAkFMgixJexJyAHlYveijsOC8bk79vr/
	JDR0/WGzpke4+FjciZ1PsFobJrqzvnX2sOzszmlM7pSW6AvRMbxjTdfa1ajWF9RYBxezp+702yv
	Cq9Xhg55GRIFIjWRsY0tAeZPKNaAmZgsmqH9+fclsjyGC/aSuKcXj74LjrTU3Gk4qmM4NV2W3rA
	KsVtry6QHbEtRxTRa6w9pqU/Fb5goy1/YN0jgTFCb3mPbH69ar47/W//qG5ArV/qmFeTg58IKuo
	cQh5JcqsUArCg0V/eWelPvYn1CT85HJWkRKZpDkptwwksG+qcR/LE1xwdgzZQg+R7yInuFgVuPl
	dWaRgxlktS/JNRRlmOWg1InTUi7VQsDMZkGV6zUNEGJbMvefdpzzC0yzBlmbx37aLHhRi/2ql0g
	pCUqyRmZxnZ7MJdG6MnvU7HZUcNS3yeA9MH0ErnAE9DgQxUiqS8MstqEzqJwOrGgCOe4rPnuhAR
	E2Kq3mxv3TBSqNTFSyIFhavlCcsLmpOOmpM=
X-Received: by 2002:a17:906:115a:b0:c3e:ee86:d2c with SMTP id a640c23a62f3a-c513a866684mr1271536266b.27.1795605876461;
        Wed, 25 Nov 2026 03:24:36 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afed51asm608298566b.76.2026.11.25.03.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:24:36 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <883b59a1-8ec4-4047-a3c7-d7980730f6f1@xen.org>
Date: Wed, 25 Nov 2026 11:24:34 +0000
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
Subject: Re: [PATCH v1 13/21] hw/char/xen_console: Fix buffer trim when size
 exceeds twice the limit
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
 <20261124232247.23169-14-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-14-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> In buffer_append() we handle a full buffer by discarding bytes from the
> *middle*, preserving the oldest and the newest data. When the overflow
> exceeded the max capacity (a limit set by the guest), the memmove()
> destination was miscalculated and ended up before the start of the
> buffer. In that case there is no older data worth preserving anyway;
> just keep the newest max_capacity bytes.
> 
> Fixes: CVE-2026-123071
> Fixes: e57dd20bb706 ("xen: add console backend driver.")
> Reported-by: Giovanni Vignone <https://gitlab.com/gio24>
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4191
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/char/xen_console.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
