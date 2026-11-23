Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435126;
	b=hHN1f03DvwNOBcwt9kb8gqie7ZuPSdBk1dfEiuBQNUI/lSuzwsQ0IU73MpluuVFO1HsS
	 78zjfSLlmJ4QPCd7z6fygQluB2zukjvkafX+ohZY8BQXavXJ1z/s0MYnXP+jh6f1zrJT4
	 C4KOKT0QTp7+1tDMyVu5nvQ5ssBSWDcO+SMEPAKEcFNOBVEc/UavP59uIHSr84lbGxU60
	 T+VzaGPuYNypYAyOv+Sm1Qxazoix8esz/I9T4XTAqnj/GpGjEBNMULXjH/+QHdrJ+Yvk8
	 gJsaAuDE9A8ycKS9MJ/+VFtVeEqsB8B9a01yGr8wlLuRBEgEPRE05IrQYoc79GHcnzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435126;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CQFmq1pcPFYCkE6jKPYZE7YR7p9AbOoikjbaytK0pAI=;
	b=qZgTVGJ8u/N423cnaK8Vb78B9tppwKaAKMkKLtWKC3GMtK95yvTMJgII2GPKW9BDJZLK
	 lDx00m27iPIq/jm+/zsM92w2rfeHMxo9/M1grxsRiq7WINOZTLApTp9AsCnzb6dO2iG8B
	 6NAd2SJE/a/T9UsDpAOGJF0g1lgp8KWaUQk1GwlrXfNNDLDv1Kv5YRxWysoaDF+SOX5oo
	 htMfcEF74Ykc6sHluf4UD+EAaInF/whK3yuJhWPASFKtRu+FpInj02ugh/9lq+weDaZte
	 K7A5/cxTGiW5yn3Tbze2lYawtzHlk4ZsCsUP0TLiPiM+Awq8f8Y5hWujRb7FzaQfDOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WVyIUyKV;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=q8TvksT7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683DC606A31F
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 11:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 683DC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WVyIUyKV;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=q8TvksT7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795435124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQFmq1pcPFYCkE6jKPYZE7YR7p9AbOoikjbaytK0pAI=;
	b=WVyIUyKVj5fBF4k4rbvny0i3aN2XVanH0LIcFu5Id8t6l30DKQhkKuArKZigQmuy5IZHfM
	jW+s/VgxGFFyxLoOpXnrvbwY60271EyUNPZJop+MmDc98Eo0TRhuDPPwAc9F1WOGNNCtvV
	Nm/fHesEa6wqnLMMQvaC1UXKtazcDFE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-g7qbRI9nMlWSFexdFs5idw-1; Mon, 23 Nov 2026 11:58:42 +0000
X-MC-Unique: g7qbRI9nMlWSFexdFs5idw-1
X-Mimecast-MFC-AGG-ID: g7qbRI9nMlWSFexdFs5idw_1795435121
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4ab855a8c21so2647255f8f.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 03:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795435121; x=1796039921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CQFmq1pcPFYCkE6jKPYZE7YR7p9AbOoikjbaytK0pAI=;
        b=q8TvksT7v+CwaSNg6yS0Ed+NoDfkvAKLjmmEv1N6E+Ohw/DzECgpHU/dhfU0sdnuEB
         GH7KNmXRPUHXc5e68qXSP8cqyHF3XOj5wjU7pbkLvgCw0e+kcwkoEkYxpH2Zug+m/sHu
         dVOOVUoSeobuB+fj1j3Fl8viG4yqaJoaB7OCwD547OI7b0jQj5BK5TwuOauxVLFsuj12
         o+p+x8xr3y5Qv175Vg4ag4CkJvDPS19ioV48IY7bGhucRGecgMcWDrGTtIyaJdLeI/I3
         s9HULmRI2IyWBl13ki4YeM2X1DP1Gg0vgBJjNONDTetVN+f52hj8vycFuKePFzj1uAK7
         NP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435121; x=1796039921;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQFmq1pcPFYCkE6jKPYZE7YR7p9AbOoikjbaytK0pAI=;
        b=h/HoDzNYxpJkiedR015rO1ECnGJ8xIwfk6ERC0JONYb0uVccfCiRyLWygtex0t+eYM
         5gRwiBF65B+4sdcEe1StGm+R/o3sXAX8yOpOAbbOA1SkInOcQcIRARIBadZPsdj5VOg2
         +w631XUWSck17nS3NLIaQExr0uCAyHOWkTlgUGKA6HJQFAwjDewNjLVsknPjOveMVAUw
         GCvF9Hybd1JgYD0/pT4Rgf9WY1VYPDIY0fXz/XooEbnOhoV1MJmZbxFYReohy0WQp7t1
         P0NJUWAmQReGU3/Tz2mPZCOAFn9tqzqNqXlH/r9ONWCSbQspHaBMR5O95R0Sj1qWD7vF
         W97A==
X-Forwarded-Encrypted: i=1; AL+hErHoh1U+PhZAZFZaPrYNyb7LNZaYaC2u5IXv0/i9WGmwhfC0OQSeAM+Jf/0Ru+VSo4KB+aA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Vmo9RCnauz2acGGpzRH0RrjgC/ZmHmUMpRUjxH9CltJv7tHin
	KaXvcE2gisGx1yRmHKjNl7pLKZBnLyLkntEfC1QHpAqgRCuwarGG0FQSMyvj0+YZ3F33rMDWDXj
	rj6m6L8qSxxsxAVPf8qgiMYSS8I/qsyDJKR4klP4njxJoz/3wzGJDoQ==
X-Gm-Gg: AZFdTZe5q66+2B5jzk4B7T/llO+fe4wYEWa/VYU7ymx48AhlZqLgUQg4CBVhtdoRwtM
	OERRGbFSaIzzmejxzATl/M+ynAYkGzAa0Er5R/UWZPTeA7PPrtb/CxV5x8Kkq17KQ/Q98Vxl463
	KJAtEgC8Rs9CdsYQfMN6EttlJYQlSeOQq2RGd+3Xvp5rKEESnHLgeuwkhIzGNKejERD2CKoG8m9
	vEXs31hFbZ4OREqhLCCYQ4iLCDGBpA+TovTDkjk/4UR1uDamns3zCSprO/aYCWByCwdjfpc5EdE
	IICeRIMz3aLBJ3fUZJ/vkYoM/ZA5gqzTFMtfQm3qmQGXeOcDBMS934T1NSD5Yjc3DhMx29dli7f
	NltZPCxCPXpuTM7dxgFEKcUB44tiuaUb/xOgkAeVdFMhGLe53mhvitKSWpGr/FmmTGZ21s0a8Nd
	wHdpyyfNGECmLYhbV+AE7RaPvqFe9KSRYUihjYGlAONP2H
X-Received: by 2002:a5d:5f85:0:b0:4a7:1613:7206 with SMTP id ffacd0b85a97d-4abb57f7b6fmr21998993f8f.47.1795435121058;
        Mon, 23 Nov 2026 03:58:41 -0800 (PST)
X-Received: by 2002:a5d:5f85:0:b0:4a7:1613:7206 with SMTP id ffacd0b85a97d-4abb57f7b6fmr21998958f8f.47.1795435120674;
        Mon, 23 Nov 2026 03:58:40 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b2c9sm22672307f8f.31.2026.11.23.03.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 03:58:40 -0800 (PST)
Message-ID: <12a2b44d-3d24-4b77-9dd5-24361d5fe910@redhat.com>
Date: Mon, 23 Nov 2026 12:58:38 +0100
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
Subject: Re: [PATCH net] vsock: only deliver taps to namespaces that can reach
 the device
To: Stefano Garzarella <sgarzare@redhat.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
 <awQJo8WE5Gn4nYHp@sgarzare-redhat>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <awQJo8WE5Gn4nYHp@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/26 10:43, Stefano Garzarella wrote:
> On Mon, Nov 16, 2026 at 03:46:49PM -0800, Bobby Eshleman wrote:
>> vsock_deliver_tap() clones every packet to every vsockmon device on the
>> system. Creating one needs only CAP_NET_ADMIN in the owning user
>> namespace, so an unprivileged user can capture the traffic of local mode
>> namespaces.
>>
>> Pass the packet's netns to vsock_deliver_tap() and only deliver to
>> devices that pass vsock_net_check_mode(), the same rule socket lookups
>> use. vhost passes the vhost_vsock netns, loopback the sending socket's
>> netns, and virtio-vsock NULL (global mode).
> 
> For local namespaces I think we are fine, but what about global?
> 
> Is it okay that a namespace with global can capture all the packets of other global namespaces?
> 
> Asking because at this point the CAP_NET_ADMIN is useless, since an user on a global namespace, without CAP_NET_ADMIN, can just create a namespace to have CAP_NET_ADMIN and access all the traffic. Should we fix also that?
My take is that the above question is quite orthogonal to the current patch
and may impact old applications relying on the legacy behavior.

/P

