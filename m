Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078997;
	b=z1Iw5BYlFN+qZmndBWLW0pWKpZLGkBRLK6Bn7FwXFGUvBJ39N5j2n+oxxZbBj7LyJj1p
	 F8M6bbxH54xnaWf9f/QB1t387hoVbq2Wmji/RJadvCh/J5zMiyf2mfVyVDVmEbtDLO/yU
	 l3nhxLgl52JZwFci7/AZHSSmaKblF8c9ADtx94uGHhKDZ2BF1m7s2zqgVZfEwiUTqihdP
	 D7vzBPmrwnYCahq/l78RZLZFUjNGsaPO0HOKe8MrV9NUVQymupPhedD9eKGaLF0p+XkEn
	 XU3ay0Otynml9fOx1eUb3/WkJEH0Y6eK9Pod9lY5FWGGOZ1JZqlNmeVn+MXwOktp9bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078997;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ev1ALMDJ9rqPsDXSnREH7pDpCBz175oayjjOjbBvQOI=;
	b=Hv0w0xRk6oSczcfBc6D0Gd7n0Z08cjwSsU6U9bldS+YpCYUC8GrTOJgalcGHYDdr6++Q
	 FjHZa4gXnhQL7HkG3WElDkE7loIXt0RK+/CLALyjZXxDlpCHMri1FABDdRQqwvb5bE3U7
	 9Rw8CTkH9Pu49CuAq7/yxi6FcV/IlQ/wz9r8MPe1zz8OxBtdbYeMC48hhbdk6tJDNQs93
	 Mwkk9YVuhdOINayZ9xx+H4UUjTcDyrjC/a6pUNBaU2Somj+1TpVXF+gyYnE61q/KDQIFy
	 UeXrezfSaF26h7AWgF3g7f/8ZCasRdcNuwrrOxqQoYTQ9UJJiNs8G4MjcwnsTqTfQ0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XzJyUlZd;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NDy7OuQA;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FE2606A33E
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 09:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76FE2606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XzJyUlZd;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NDy7OuQA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795078995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ev1ALMDJ9rqPsDXSnREH7pDpCBz175oayjjOjbBvQOI=;
	b=XzJyUlZdvOEvO2tepLebN83cQqiQIRozPgN13M9xjpZuJij95PA+RjISxIAMujcc88nDt8
	I9TQor4SFo8rI3L8adDZtBtO+tiVbHo846/ZWh3ikXD8LewNvHdJPd9dL2QBlazCbIHAgg
	HYq3bYbdciaTRZki8sAJ07oBuxUGmaw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-nhq1fcX0MH-_ADhOda18Jg-1; Thu, 19 Nov 2026 04:03:14 -0500
X-MC-Unique: nhq1fcX0MH-_ADhOda18Jg-1
X-Mimecast-MFC-AGG-ID: nhq1fcX0MH-_ADhOda18Jg_1795078993
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49febef74e3so4235425e9.0
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 01:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795078993; x=1795683793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ev1ALMDJ9rqPsDXSnREH7pDpCBz175oayjjOjbBvQOI=;
        b=NDy7OuQAYN725puRZGYMqK1SPlFc6PbWY2Mk8+q0b5T27jWFi01d0o8UYL9sETK1uM
         ebNwCyzECEWNUhrJzteVE2FPpw1j+l5wHE5jXO4CQoK59II9NbxR47jNBUoBcSoGGQDE
         GA9R4IQ4DRbjUJvVVcjlxXVG+LUvQhYrcPi9tLHe1iUTObvyysDaD24mNLBAnYv73fzQ
         quZZxXQ8g2oEE/pJgEzVgNyA4iuUgofNiS2fZx3P6IjzpM9a2ZyGmlq2CfQytwjRsRn2
         7Mze0crl74fZvW/X1qiBatVWkaq8M2AfrZPvxrNi5FuCWbHw+wtDNk2u1MvK6H1XdFH8
         TGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795078993; x=1795683793;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ev1ALMDJ9rqPsDXSnREH7pDpCBz175oayjjOjbBvQOI=;
        b=DnSoUIJK7oP2MK8/XkpWtn+Pr1OfVsiAPoyE4B6VBz4fH52FAD9IfXKukNyKhbs0jx
         AKEdaxtilfkV0MKgQ7iCBmonB1AT9OqF9vHX16wGG2Ut8U/nok+gO+rMPuHE8NhmTVdg
         2bF4c1vvpHodn+miZ+vmkDJINKdjGH0JxILEQt5xW3qh8OMmY1rHPsQv7p3H6l6OnvJU
         cQ9DIsxXYVtlPT9NerM7r1z7M5B2Oe//civJiIlWQ35sZ11rJqZZfBFIJc4Xd71F4lgq
         Vwo/K3a4d5ml74VWr0BnlFS36MiqOSzsrXizYqYdcGDA1gA3aR/Nf6tFu2JkAiRMPkyx
         mH1w==
X-Forwarded-Encrypted: i=1; AL+hErEIJmG4Nf+8Dkm6/FB/Ahfbs8WfNG5UZtAUrM6AlYitNK3r28vpS3tra6+MSqRqGFhsrHY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uni1L35WLvo52VWgZksxzG173FI9b5Pgb5DiKUpfknJzjQJu2
	dGlnscOgynHmF4MxnEGkRSIxxTSt+1u5u/rfwIH9E2f1E4nPahC2eh+KCVnfgo8IGtwGvOhSXT4
	JWHtlknQCeQDabOmszR4g9J6WE8e5ihYpKomCB20OImmCQ0uQ/BnWGg==
X-Gm-Gg: AYBFou2/EPYIB/fufZglJe1oY5xMPCZ+7GRIH710VxR3v7/ma5YB5yIKpC5bPxHu6sH
	q8DAfg/XRMm8ZNih8NAr3P/dUsN7jA/zPiKUjB4TcvovQ5j9ie4r4jPt4n5mOMt/4ircEABCVvl
	RHBwAY0bIcp87aP1WaHpP0Gvsx3jinP//Jv1sA0W52NTtQUXVLC++tpvo854FT9BmpBz1juJIuU
	vuaPH+Rc1mtOLMY2mH16oJAeMdjnLR5ewQzfzN5BGHTWQcEumwcSINhX1reofiabKBP9AStiv6K
	qHaC8hS98RHj0oQwY/kjLgcno71QbI41oHxA67TimBSjtGHoUJ3CdMAs/rM0norD36X5kU3Xkcj
	JWELfWQR2Ip7ywoeSFuEr/J4ge0Ijjlb0f8zsPaXRqKJscKScH8hnqbzx+ruAASqeQGhuixQ8R2
	Ytwo06Am5wsqk9zRdKJtdSLodalwW9QnNa9Cfz1Yg0xxbN
X-Received: by 2002:a05:600c:b90:b0:4bb:6a78:7c42 with SMTP id 5b1f17b1804b1-4bb860f622cmr10713965e9.1.1795078992818;
        Thu, 19 Nov 2026 01:03:12 -0800 (PST)
X-Received: by 2002:a05:600c:b90:b0:4bb:6a78:7c42 with SMTP id 5b1f17b1804b1-4bb860f622cmr10713525e9.1.1795078992313;
        Thu, 19 Nov 2026 01:03:12 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm29541955e9.0.2026.11.19.01.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 01:03:11 -0800 (PST)
Message-ID: <a3049b70-fae9-488c-9de7-0c1613e6c480@redhat.com>
Date: Thu, 19 Nov 2026 10:03:10 +0100
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
To: Bobby Eshleman <bobbyeshleman@meta.com>, netdev-bot+sinfo@kernel.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
 <179487315810.3291.12142099363352099423@kernel.org>
 <avur4Uwbv27bGG67@devvm29614.prn0.facebook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <avur4Uwbv27bGG67@devvm29614.prn0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/26 02:20, Bobby Eshleman wrote:
> On Mon, Nov 16, 2026 at 11:52:38PM +0000, netdev-bot+sinfo@kernel.org wrote:
>> Hi!
>>
>> This is an automated message. This series looks like a fix, but its
>> commit messages seem to be missing some information:
>>
>>   - How the issue was discovered, e.g. hit in production, hit during
>>     development, syzbot report, manual code inspection, LLM or static
>>     analysis tool scan.
>>
>>   - Whether the issue was actually triggered, or is only theoretical
>>     (e.g. found by LLM and not proven at runtime). If it was triggered
>>     please include the symptoms, like the stack trace or kernel messages.
>>
>> Please do not repost the series just to address the above. Instead,
>> reply to this email with the missing information, so that reviewers
>> can take it into account.
>>
>> *IMPORTANT*: If you do repost (for other reasons) - please include
>> the relevant info in the cover letter or commit messages.
>> -- 
>> The evaluation is done by an LLM so it may be wrong, if you think
>> that is the case please reply and explain.
> 
> This is a known issue and has come up in review of the guest netns
> series (so via code inspection).
My reading of the above is this feels like more an improvement than a
regression fix. As such I'll move this to net-next. Please scream out
loudly very soon if you disagree.

/P

