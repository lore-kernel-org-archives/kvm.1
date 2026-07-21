Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF0038238F
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632764; cv=none; b=EN9ZVAl1P9OhA0LQe2K1uFsSDQ+BueDFfPp1jljUlpdCoXsbmYM8Xwk8GdDbQQ9XlqIPd0BoBAkSNlj106kpNCAqraT1JTZcjo7Ljj5qzgkb1HMn9TEAP+AAuZitRHyXft84xnecFE7L8lgHplo1h2uPj0C5h4cesWOEZJ5BAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632764; c=relaxed/simple;
	bh=xJAhNcViqgxaoHWIEmJNFrtF1OLjmyQnDUZ3IbhOx9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKmHdQxoAI1K6M4zuRE2JDvoCV6SLBrpJBOQ1dn1wRkWl0RJxhstPtYvKmTBLOj3KsnmCFhjQ63W1vHe+RHTJsmAFLXRBGMXuW82kFIdTssmXwGCcn4PODsj4KeMK7tym4X4W+fZBAHjnC+j1S3dwZ5kN6dii6eLPTkLYZW+lGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTgCD0ue; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWeZ3whz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTgCD0ue";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWeZ3whz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784632761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckJwF9bZHsl72YuWwH3NmbK3C+jjMomDQypn2jeRFnE=;
	b=gTgCD0ueU3Ghwx/GAhT/1I+maRCKMZ66oH4O7YzoFbFK4wkkzKyphalKLbX843wGhv1/UE
	VOG2LCJUid7qkaVYjFauo2EujNe4medjysFCd/4ELP8IX+y3UxaO9V5Vgeah4AMMjkG2Sg
	mLijkpBuVuaxdZOwD9w+oJlBfc4uKdQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-oLHokkq1PJW2MPk6wByVCg-1; Tue, 21 Jul 2026 07:19:20 -0400
X-MC-Unique: oLHokkq1PJW2MPk6wByVCg-1
X-Mimecast-MFC-AGG-ID: oLHokkq1PJW2MPk6wByVCg_1784632759
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f6db77430so2115236f8f.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 04:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784632759; x=1785237559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckJwF9bZHsl72YuWwH3NmbK3C+jjMomDQypn2jeRFnE=;
        b=OWeZ3whzxU4G3rLmTNLnFvWiYl5lbG53I/h2VL0uxB7Bnl8azlyH05y4vyeeKx1gY2
         3A4tdu7mJvCdo/t3xEDNJEsD0koflTvQKDygO9Pg5+2IYTDPsRHlOG/zNcshH+m3bkf2
         tx2K7YoyEraHq1Bv+AS672JAI/+PZ8GbsmrlSQ/ICPkIbE6zuyBFrGKC6Qxb5v3dKBRL
         UO4qDFCA+UlBXnCcuZmw6/n+xLr4VFSCJEV/V5KIkBfdKCEaIUo0SZ18u0NAwqGwC/GC
         c57VnRAt3yFxE0j4Ikcd3CcvrkJj2shIUJWem2qAXgacOFRH5P07JtI1FfaBZxZ7n7S9
         Ox8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784632759; x=1785237559;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ckJwF9bZHsl72YuWwH3NmbK3C+jjMomDQypn2jeRFnE=;
        b=Wg+TWTmfzQvaRE3lPMfzXWiFWevtwxMMnDadDsGgIjtWEoxhRgNzv5p9tgxYKrNXU4
         Ayfh2wxWx7Mcyo1ZpRYkZeuFPtCrmnoDL+fVPPJoFOs7YDAEgADmPIU/gA1mb2FrXjv4
         zoN8P5a1M9D6KixIxencdquWmTa5+UR+2jMBxdEWkv863AzT8rtSJAuGy9E5UV823g0P
         nW5xyReO6BD1xCIJdFvc2BabQEkIX3lyx48TCkkNU4nHMgMcxuq5zSYhbOO3uxk9RpX8
         qPujLpIJGcemhk9dgydCBDd8atksk5nTbCBbpKQBasgp7IPm7Xh6KdaOKzlAH4Sn+aYM
         J8kw==
X-Forwarded-Encrypted: i=1; AHgh+RoYQE8Ulb1fZmewt5b8Slqh9dD2Fk6SPKaIVSrNUBAyWWzkg6ArW/QR3WJxsBPdvuCTINM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqCWBMJhHth3We3yIUQdU0s7y1x7eaNGU/NS8/rO+O9FPuLao+
	tXUpXtZ40VPSZQRbX6ZH/dhTwnRj4OEniSctvmgiqLCvM2aSOmjUmNJRTqAyEYD+Bp1++jU3Ag/
	p77Pz4tOnSt4lvS0ckDJl9n8mtaoTJkgc2aQOMGOxVS6Ev8id7pFOvA==
X-Gm-Gg: AR+sD10kzhKnRkhDvjnhvcD6QGL0QHRVdplS8aSctfLc2Lyh7haEfmevSDnVcUbZqQ/
	sjmPb16ai2zWC9B9x1Vuq9I3z1Fq/sJ/TRX74zRuqoH8cef+DrSQ0nKrA8nTyX7apLrNVwhjSVZ
	qQfid9oIxw2RG1iqbcF1b1LH6oa9OFlbJZ6omCXy375oRF11n78Qa28kW0h6K1mDUEaqQJdV5mD
	fgkv6Tr8PZbmZObe66MsdVCkN+eECI+y0EPubERK74Ogsp56NDo1klNno1CEWgGvU5+pmMfEqKb
	LpNdL33KL3/flkKESzalDmy3yJitRJnu9Pc0d0UddWtpa41OHJ3NU7a6uSrSOXZlyleX1T0EZYt
	cZFlGaxyD2WaOPPcghIxA//6ku/6apQ1vyShODRyYdPySxtGDltsMhozuWP6x+fgyZh4LYD9jD6
	+yqg==
X-Received: by 2002:a05:6000:25c6:b0:47f:7786:b00d with SMTP id ffacd0b85a97d-47f7786b077mr10477181f8f.24.1784632758927;
        Tue, 21 Jul 2026 04:19:18 -0700 (PDT)
X-Received: by 2002:a05:6000:25c6:b0:47f:7786:b00d with SMTP id ffacd0b85a97d-47f7786b077mr10477122f8f.24.1784632758406;
        Tue, 21 Jul 2026 04:19:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eeece9sm37465633f8f.37.2026.07.21.04.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 04:19:17 -0700 (PDT)
Message-ID: <03f49d98-c6e1-4dd2-bf25-f42e424fd59c@redhat.com>
Date: Tue, 21 Jul 2026 13:19:15 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vhost-net: fix TX stall when vhost owns virtio-net
 header
To: "Michael S. Tsirkin" <mst@redhat.com>, enrico.zanda@arm.com
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, kuba@kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, nd@arm.com
References: <20260708152242.2268848-1-enrico.zanda@arm.com>
 <20260708124901-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260708124901-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/26 6:50 PM, Michael S. Tsirkin wrote:
> On Wed, Jul 08, 2026 at 04:22:42PM +0100, enrico.zanda@arm.com wrote:
>> From: Enrico Zanda <enrico.zanda@arm.com>
>>
>> When vhost owns the virtio-net header, i.e. when
>> VHOST_NET_F_VIRTIO_NET_HDR is negotiated, sock_hlen is 0,
>> meaning that no header will be forwarded to the TAP device.
>>
>> In the current vhost_net_build_xdp() implementation,
>> when sock_hlen == 0, the gso pointer can point at the start of the
>> Ethernet frame instead of a virtio-net header.
>> This results in a wrong interpretation of the destination MAC address
>> bytes as struct virtio_net_hdr fields.
>>
>> This can, for some MAC addresses, trigger -EINVAL and return early
>> before the TX descriptor is completed, which can stall vhost-net TX.
>>
>> Before 97b2409f28e0, the gso pointer was set to the zeroed padding area,
>> using it as a synthetic virtio-net header. Restore that behavior.
>>
>> Fixes: 97b2409f28e0 ("vhost-net: reduce one userspace copy when building XDP buff")
>> Signed-off-by: Enrico Zanda <enrico.zanda@arm.com>
> 
> 
> The fix looks good:
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Sashiko thinks there's something something security here, but I think
> it is misguided. It's just guest hurting itself. driver breaks the
> device it gets to keep both pieces.
Out of sheer curiosity: which sashiko instance? AFAICS both gemini and
nipa are clean:

https://sashiko.dev/#/patchset/20260708152242.2268848-1-enrico.zanda%40arm.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260708152242.2268848-1-enrico.zanda%40arm.com

/P

