Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606329;
	b=jVOg9LNdvlVSXnOPEmjPgjYuZ0RfCv2uvO4Yveo4nFKqCmkfwGB/TVErQqwVp7MqTEUl
	 LWftnhQQnvqMMZ0c9rAYlpAiJY/yMTjGTGhKCop8eQBixcW6vNIN2SBRG+q5CIo75Cgv3
	 RJquBB6k7W5BLxaask4LyYvNVirxmYpDbaAcOf3sRtadBAqQ7M0huWVmFyv+qexxLnnW7
	 bj7MjxNcEClp0JKd5OoKFbmlA9dsl6blPUpqtKWoJ3fai48+RWG3QtvsrSnTtYIdzMp09
	 mn0PjoCurV6I9zvzNMJgrDQ1iIf2hl8icbpj0+2ttXAe8gUV6ykmvYZofekYeuMfmxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XNwgaAJrA/u9YSk7hAtdQI/k6k5HNaRRAtIFaDIjJqU=;
	b=eOFR0uARJ8JBiWvHhMQEWF/wHHGYFSKdbCRgdhl/1J/YsuZB+SpIDX54nX7PTIbgAUbU
	 NWfzOONRR1UziuIRnumJiOsdXGyPg9NccVuRZtQA1tLJQtk/IPgXmplVvBbg3XK1QHt3z
	 6wz0RnTr2kTOTFZ8A/cUu2YsgBnuQjyNdDwYGMSkepaty0UTwTNC/0aTznDUuj/U8zh9q
	 W7cqrRzVZ0oCTE+/d1bzrHpqsUGsW+4kKVE0JFo41AaCEa/tUWqIFfRFVZPMaXIBWdm9J
	 LeRasKR+kkzhBme23zOT+CjbYeVAcvBSO+xazrbdF0apuTDLKfJOfKT0LvGXC+qpwhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G+E7B5rG;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A8C606A326
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06A8C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G+E7B5rG
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so48670955e9.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795606327; x=1796211127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XNwgaAJrA/u9YSk7hAtdQI/k6k5HNaRRAtIFaDIjJqU=;
        b=G+E7B5rGjbH2MpV2Y59G2UjyMkJM3wELyqEB82v+ghhEfU7/Qd08Q0Sf6hyXZ63Cfk
         O/Plcf+aviD2PVC04U3ApbDRPSZoAbuiD2jhdo1vF0boZAVXi+Ovsldhhv6DkUL7MAoJ
         mcKhmJlCbmlBlzxVzrBPPgLmPUqx5k0576Ok7i4pk7JhWL4azLlsegysKzX61HNvPdGT
         WXdFSUY09GeCKQaPWP3pyArttT9agafgSRszdYsgeNGRZZ9OvuAAMyRDDEK2mDka6GwT
         avpu0WxDPgv+TNL6Fu8DRYiLHy7tRHmXJJRO9hWuC/nfLpu/I7VdGRuxIbowk0to1Gm2
         bVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606327; x=1796211127;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XNwgaAJrA/u9YSk7hAtdQI/k6k5HNaRRAtIFaDIjJqU=;
        b=qbAc0D1sE85CdpJsNddI6lQsGmhlCGvs1cyqK21hXjAOtmys+7zB0yukdgUGCnGyeV
         pCsGFw1BBa92Nyov/IayRNq7FOEBTVTlQAMCyRUUIhTpunAei87cBdWgNIfZK8y0Pb+b
         ksg1HgwS7WnWIS8vhKhh66KVuaKUE9yVMcstFtahvnH6/DX8edF2J1stgqXN2FLpeUVr
         6rMGtVbYCL0gpb1yfK5Bk2pK9YjI2lxmntMVUk0DZigqOk17KCBYkzuOrUGcmCTQ5K5M
         DXBeeEQt6AexGXhHAab8q7CTfuul2G1Tgm0i4oO02VyzSj4C3ka/uOCjubrsSb2ZnCpq
         is6w==
X-Forwarded-Encrypted: i=1; AL+hErE0k4zyhQkfe//YhDVopxsx+S2NzxIbNkyboZjsknS0GHSQtkSqdj1wg14w6DNcQGaW6lY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vvwNl3bxnlWYS9ASf/dvk3I2T/b6aQ7on1oItJdNwT/QPdyh/
	cE9kgEMk1/LbDV+klY6jBL8iG1VP7dpTZcniMzDSfhCvIbsSTDot5rMJ6OoOPHte
X-Gm-Gg: AZFdTZc7Yn+YNu/ruBDV1g89jFHSXm/D4QA83CM46aoyHuDoz3Ybbi0OhHC1cn5reQ0
	VPT9E+RRn6aAvBcuWou2XESjczd5l2x+aLg1KQgxj8f7NqkP9uJKO8jx59QBw5ZxT9FvMiJ/bBO
	a7e41/A6EOHE88/OazR5GUTGTxVxViOaLjX+0Slp7ef4XxHTa128cVkA6nEbesUr4SLqMhNDyha
	SfIYeS9E0MxOTfPJSsF5P2tiZbT5qZAC7U5ZKr7ZGj1UYmNqucmj4XqZFD+Z9uu51XEhjs3pQ89
	j2W/NvZ0L2i0F1umMkPNP9bZSs2WKofo5buUMZIVfw8Lhe/7L1JpV9Nf/deN8TFZmK6Rzk42TrE
	hTnFdzSd2+Cq2D1Is5jcsrBrGKyxC0EjQiFzwU+L/0drn5XZOLfSIHuSTn1yizelvL2bBFsknn6
	AUPJUUhqRIc+enGiqL9DQGKGbFY7ZH7D5ZL/Qc6DuMsFpa3cgcDvS9/xSqm64psKSHiA3jMHOtk
	7Tbf4iH8FIHn8UcGLfHZLGC0r0Lg9/GA724qNawSBHOH32p8G7fW8k9DCwCfLMW3vrlKM4TXknB
	EjCqGmx+w4kZGgYNB91AYwWP4sufE5suK+PrvyukpyMJcZQ7a8YFhOCP
X-Received: by 2002:a05:600c:848d:b0:4a4:3a2d:15da with SMTP id 5b1f17b1804b1-4bb88812026mr333238515e9.15.1795606327221;
        Wed, 25 Nov 2026 03:32:07 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb905f1489sm314735755e9.0.2026.11.25.03.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:32:06 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <02403720-6eaa-49d2-aa2c-297e9a9aa6c2@xen.org>
Date: Wed, 25 Nov 2026 11:32:05 +0000
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
Subject: Re: [PATCH v1 18/21] hw/net/xen_nic: Bound the TX and RX rings'
 producer index
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
 <20261124232247.23169-19-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-19-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> net_tx_packets() consumed requests until req_cons caught up with the
> raw req_prod from the shared ring. A bogus req_prod made the loop
> process up to 2^32 stale slots while holding the BQL. Check
> RING_REQUEST_PROD_OVERFLOW on both rings, as xen-block already does.
> 
> Fixes: e613b064a88a ("xen: add net backend driver.")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4515
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/net/xen_nic.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
