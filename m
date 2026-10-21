Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576134;
	b=SMTCwk7nmIKY9/XPJckF+FDh3lRrZa2rMctwfRDV4VDF6io86FLjPDURtYnm+HzeTW27
	 dchCyTPg8ok3ZrpMn6eakiJAzREs+dD/ou0otJ44PvnMIK0eXUAO2krkEcizxs0d7kMUK
	 X8IA5xfXKeN06ryds8QJgIUGCNCPmNRwJz1DUNx8IuHpvt4YoG9kN/i6/Wk454zyH8ubh
	 Fl1qJUz9s8y0abXn9FOHMx97yTO3tPQ/VhdmaxOgxhRLsrm5L1xIDm0E5Ger4oPqxF3Ls
	 eUR3Wn9bBnqODOFO+aE0fsCGWz0OHg/UOBbDPa3RGq6uo3QsVp2hxwqtmWnmKPMXlHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576134;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3oOP1y+9aN6aMBiBqwXHlYcfXTBVxTTDMi2tTB6X1Pw=;
	b=5P5QsOsAXa0Tce7VouBVM0PoKyvo+aubOHqHzL5hYQc+s2jTCqvZb+hk0JNOVqtYAgX2
	 l91Wn2JEJ09+zFJxZDCm/F+Mji38lmNvi3Z6QXUo/4gigecSByIAeVRbA7LWwzV9cCsRL
	 GqOxSv/lZcGoks602lRQ/G5hi7rxLd5Bc6IQFuuKIBZRFaH8zTr2iLVBhBSf7P95tbmA/
	 Bn6mGYPyiY+7mWx46EqqwrrpyRE5HCNj7phUyeLem4OAcCZmU0tVkO10cuR7+QNv+e7qk
	 epwNwtcJf5wcQEzEFAP24SUjpWdIe8s3C1Yi8N4ZJpli+kKnU29Dc1x/NrkL1bkV31w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CKfPePiN;
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fOIDGL33;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5FB606A326
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 09:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B5FB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CKfPePiN;
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fOIDGL33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792576128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oOP1y+9aN6aMBiBqwXHlYcfXTBVxTTDMi2tTB6X1Pw=;
	b=CKfPePiN54d9bwHT91W90DCdQsfj7A9Xja4vFPRdhdBUM7V5pIH9DvL9rai1/Ng7gYUPxp
	P0Y4vYkaF5MDW8HuIuGGBUETy/Uxov099kwkBUMAsxsXh5IJLiee3xYY7ewOVadsdLkaXU
	0yRG7truGs5pDFLMUHBHzS9r1Je+PEg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-DFGML_TUMruaaDiftNl_LA-1; Wed, 21 Oct 2026 09:48:41 +0000
X-MC-Unique: DFGML_TUMruaaDiftNl_LA-1
X-Mimecast-MFC-AGG-ID: DFGML_TUMruaaDiftNl_LA_1792576120
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso4824355e9.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 02:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792576120; x=1793180920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3oOP1y+9aN6aMBiBqwXHlYcfXTBVxTTDMi2tTB6X1Pw=;
        b=fOIDGL33NTrxPKx+BfsSsDVnXGS4e8t1HJJGUsc3zBeYFcQ3ytvC0qEBRWjlfcyZrr
         ZCckOHMhq0gDAviC7f++/hBeFg2lT7fA0dttpTW7BGm1HhGK9eEMaPmE7TDHycXFjXHk
         h7isdhUMxs7yCNSiurFJE3JaxJ7pN3pn9BsYs9SHANIIphkdRwNpO4FR9itNunWMSxhy
         771t03Cx22KDx1i08QAh+IExKyggLErVRHkGmOFSmSqteiSE5s2VW/g06SXItYaSgVJN
         K4stLeA5BBNcDnmNyRisJHaTIbAhf60v4At2UHbhm/fT0XdPXzWoegysEI2GbNcnjv+Q
         j4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792576120; x=1793180920;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3oOP1y+9aN6aMBiBqwXHlYcfXTBVxTTDMi2tTB6X1Pw=;
        b=HLOk8yIlh6twH0B/DpmUQ+OD2Rkmh+Z3TMGFo9xaFNvNwdEdSBOSTn89dOS1kz6L8J
         pQT4TGNwLSO0rgG8l3nyjDZVXGJrOs00yU9qrd4yU9hndcSSqqi2htmFlr8s0+pxfJG4
         cQhMt3lSLRU9TeWhskZ6EYXl64FevM6GPvIiNm/myxyAVORdQdI3A5fGUNTo9vu9y56f
         iD6S1FTrI+J7TpLMNMSbtz2Kfk546FhynPDrFdhrgk0UuLEKf674lVcjUIxf0/DwT0qS
         hQtdRGLteyQqKpC3SNtDUhL779ZDRsrwCxit0tbHXH+5EV+cRS/6c1BOKDdhUNumUz5y
         y6MQ==
X-Forwarded-Encrypted: i=1; AKwUvBwr8f8pNIF+TKwOkewjZFp6pcboD1ZXSRrUOoOhiO9StPZBorO39RwSUmDVNM9+PR1Y3pY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLG3ZiHQJI4AjyDcw6sVs+K+4nGTr0yQ5WVun8eVCreyKwGqJM2
	PeQJcIhFARm8nzxroeuZKiPBgwNXEhQ0lcAZTaFv9/V7yYo8lFBrzNB/PjKWm3R043XoP6ly2tt
	/1mMNSJDDS+hmHvNMlnoLG3y+hAqHPpNnNiaoAp1m4OrkbL2Lkup4MA==
X-Gm-Gg: AYBFou17SXTo899EiJ/KiRCN/xJUG2fbclRvlPeQnZ4drZcyj3yVfcY5AP4VEldCR6+
	Q/QbTfTV6JLDVnxdnRxlzOHcuLD38SR+L8VHBXxf5Ha8AbYnBo/85S9d87zmhES/cwEyh06DoRW
	7ww927wprS7JZHBBzRagVkJZ66ZsZvsHP22DJXf2aELfRjnzIc/8C5rNyEZfTQxeeQLtJfDZuGA
	9MqaAraRTVK0bKKZycjMIW1V4NGDakFJNJzicfNEyCDYZsJiWUVevsWxFuGamzmlrrC0scv9iBr
	Q+G06kHr5z+feA4d6wKQCzQVooBZlfQxssCn9NrfrF9bQwrHq4kJIAaVR2KymHJ3KQrfVhLo3LW
	Qe3OIuQ==
X-Received: by 2002:a05:600c:6085:b0:4a1:d0e4:2bc7 with SMTP id 5b1f17b1804b1-4a1fdafd610mr29312665e9.15.1792576120217;
        Wed, 21 Oct 2026 02:48:40 -0700 (PDT)
X-Received: by 2002:a05:600c:6085:b0:4a1:d0e4:2bc7 with SMTP id 5b1f17b1804b1-4a1fdafd610mr29311875e9.15.1792576119740;
        Wed, 21 Oct 2026 02:48:39 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.178.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc1b227dsm52096435e9.6.2026.10.21.02.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:48:37 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:48:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next v4 0/7] vsock: assign the guest vsock device to
 a network namespace
Message-ID: <atiKKS3piuBLEiSd@sgarzare-redhat>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>

On Tue, Oct 20, 2026 at 06:15:03PM -0700, Bobby Eshleman wrote:
>vsock network namespaces let a host put each VM in a namespace of its
>own. A guest has no equivalent yet. It has a single G2H device that
>cannot be assigned to a network namespace.
>
>This series lets a guest move that device into a network namespace. A
>new generic netlink family, "vsock", supports the command
>VSOCK_CMD_DEV_NETNS_SET which assigns the device to the namespace the
>request was sent from. The namespace's existing ns_mode then decides who
>may use it: a "global" namespace shares the device with every other
>global namespace, and a "local" namespace keeps the host connection to
>itself. The device starts out in the initial namespace, so until the
>command is issued nothing has moved and no mode has changed. There is no
>explicit unassign as assigning the device back to the initial namespace
>is equivalent.
>
>The command requires CAP_NET_ADMIN in the initial user namespace, so
>that an unprivileged user namespace cannot claim the device.
>
>Connections that can no longer reach the device after a move are reset,
>so that a namespace which has lost access cannot keep using a socket it
>opened while it still had access. The assignment holds a reference on
>the namespace, so deleting that namespace does not move the device; only
>another assignment does.
>
>Transports opt in through a new netns_assign_allow flag. Only
>virtio-vsock sets it here, because it is the only guest transport
>that I am able to test against.
>
>Based off of Stefano's original series:
>https://lore.kernel.org/all/20200116172428.311437-1-sgarzare@redhat.com/
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- All Sashiko fixes (see individual patch change lists)
>- Link to v3: https://lore.kernel.org/r/20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com
>

Sorry, yesterday I started to review v3, but didn't post comments :-(
I'll send on this series.

Thanks,
Stefano

