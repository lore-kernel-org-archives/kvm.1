Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65820404BF6
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713443; cv=none; b=WCwea4hZvl6jsFTteRch3EOqoEjUQttGRHRuZBSR+gFgit91P/ftcQZwdbQCsrrwHYvKLm34BQ4fdZv0KVXyvvkXCn4de0Qt6vM4NlEoVBboVCxaBUXCsTsAkDhHYGEO+rddNCdc4CfLBQkCPU5occDMdOk+oU+mjaN+a9SweP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713443; c=relaxed/simple;
	bh=lOwARzZKfPn8sQ+Z5RWIh2PjsWgxiRWHG5/38qBJEHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW/uwzLFQhUvwCc1NpTYyw0lyciEx7TFHl+10UPDi3gNt6Ahvm75lo10wGg7rkf23xcNmiUvblp6EE09ffVIuS1XYnalOFOOkZIDWvmWS9UYfXM5ZcBTTLb75pNXFbHNQYMX+PkNnvbuL/x1G/Xy/FyoN0VKwydREFE6CYYUkO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJHzf7c6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lUaSeldw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJHzf7c6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lUaSeldw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784713441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P6FuAEzBLuYs8iPbKk5rWp3C26BiKFrVufL8wR17fYA=;
	b=VJHzf7c6yekDNRsgQSSBWL4IjKMuoaMJNM7i5dHIC4tec5B/n51cThSGeBLLWVW9r9boIm
	CJMC82+mUXASJtg0B50LzAhjzwwssJAhphqLNwpSm6rRkphlxTP2/2VjDqHTDbfd/U36ED
	Ystvfnsr6o0z8HKltRO5mWOCQ0jBAJk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-_NvSvX4EOgGRwIZHJxymhA-1; Wed, 22 Jul 2026 05:43:59 -0400
X-MC-Unique: _NvSvX4EOgGRwIZHJxymhA-1
X-Mimecast-MFC-AGG-ID: _NvSvX4EOgGRwIZHJxymhA_1784713438
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f81362fb1so1087331f8f.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 02:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784713438; x=1785318238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P6FuAEzBLuYs8iPbKk5rWp3C26BiKFrVufL8wR17fYA=;
        b=lUaSeldwe+nk3/7oJfPwFP1RUotiGuEBl2au7YaJ/wB5fAcRK6i8JlGzMd9TifetEt
         1fDYb5bIKVQkHPe86k2QHbjZoqiTegLaCWFDBygQJspP35SuuW6ZF0nWhzFTSTWXEwk/
         6l+23ZxbAWQSJNpE4NLN+z6AeewRHUMMUUWoHD8l4/+rkKicOzn+Q6toQ3MqapyeMUMI
         GKJZljx/1Q8lJWqQVJ+OVbRtVV8FSyOI9rTOENnBqitSR0EP2HEHk/8AJ4DOca86ImQJ
         Xhe41bFiJcPXm4QkoYdT/fVAyJxedMZ7G2Aa6acKNTlX2t+pcX5Rlo/a1H3xisnSQurH
         /0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784713438; x=1785318238;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P6FuAEzBLuYs8iPbKk5rWp3C26BiKFrVufL8wR17fYA=;
        b=L537osSVgKGANJMCStwHWw22KfTyfInKwTejDJmCwa9+NIQCU247TjBIWQc63rqmzq
         h+aUcBmpH9Rugxa3GdBg4X7scf9ySyAOQfc+npCsdKDeVlZs6aBiY+Tii0tDM6Ld5dDb
         3muBechGSLk2WXEtiAbr88dxQNgq8N/XWmYTaPF4xeAdxPvastuZOF2CLmqvrTkuo6R4
         P0U3rEZXXF4nTb5oAxxiS5uQpNqQsN/EcvGgGF+/oFvl5dJv0tWFx8zBkv/o1w8K6TQT
         xHvYXqM7z1CDd0uMU7YVqrlWFLRAny2040YME9n0ac2Bn/Q1bf2u0Wbqy0vHMrvfdCPS
         uq+w==
X-Forwarded-Encrypted: i=1; AHgh+Rr2a0hOvROaZ5FOrOmLKBvInDvmzD28qo3t3Yx42d2EFJhRsiFtB0Z2Xov5U7Crb+kN38M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdqQZNoBIkyxqyAkyc9J0nK3fiak+7OxoBQa6Q/Nhg86JrnEl
	LZJryxw5DymiAprWaDWG5B5bmhrwVCVivxU7GWNnnsH69zn10GbLj0+51DCVHqmYI1Qh5UI9ElM
	ZVXRzPPUf1Q5dS0ZhhIGSqQbwOYzNysECNHAvzDG80sOBVkpXIjTDQQ==
X-Gm-Gg: AR+sD10YB7DOQJb0cDuCHL76+czXW6c58iQYFQLdZdUw1K406q4nuTzXtVugz5e3xpu
	YUlkdlHFuXC0Pr0hZCUsCVxZuMAkSyistqNH5TVjm4gVhRfifoxHV7X5nBR3YRLnU7+mJ+Enn15
	orMvcQpEtkJOh6k/tBOigPrY1HBsdhpIww/sFqMmd9RcYm/0bUUOXqtfPtp5g2e4jignJh1mIxl
	RXFRoe6Yif9k3wgMUZMGLdZd6V5l1plI4dc5fU8K7qzfhSsJb84lHflTLEAqZlO0/WdMQAL6ekc
	R5MwiauCxjCZrO/zv4UScANvc9x2k1LXEaUsawfY954tYY8dX6GAiEPFnxRoDfPTN+9zPxkBPWI
	vaVAaKtc9McsovgPYEmuUFXe2SKP8LXDZWHreVRH6uJxwJGKGMg==
X-Received: by 2002:a05:600c:d4:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-4954a3dc3admr173160675e9.14.1784713438312;
        Wed, 22 Jul 2026 02:43:58 -0700 (PDT)
X-Received: by 2002:a05:600c:d4:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-4954a3dc3admr173160315e9.14.1784713437719;
        Wed, 22 Jul 2026 02:43:57 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956537c6besm124593995e9.8.2026.07.22.02.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:43:57 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:43:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 5/5] vhost/vsock: add VHOST_RESET_OWNER ioctl
Message-ID: <amCQyzvUwdy9KLzj@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-6-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260720102241.371610-6-andrey.drobyshev@virtuozzo.com>

On Mon, Jul 20, 2026 at 01:22:41PM +0300, Andrey Drobyshev wrote:
>From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>
>This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>the guest with vhost-vsock device.  For this to work, we need to reset
>the device ownership on the source side by calling RESET_OWNER, and then
>claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>AF_VSOCK connection while this happens.
>
>To that end, unlike the release path, RESET_OWNER keeps the guest CID
>hashed: established connections survive, and host sends issued while
>the device is between owners simply stay on send_pkt_queue until the
>next device start drains them.
>
>Since the device stays reachable through the CID hash, the lockless
>send/cancel paths can race with the worker teardown in
>vhost_workers_free().  The previous commit ("vhost: synchronize with
>RCU readers when freeing workers") makes that safe.
>
>Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

