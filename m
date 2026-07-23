Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0AD3126A0
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815438; cv=none; b=jFnX5jyGcCLbBFqNbwKvMsMhuwFcjd491FVeDKG13x9NpDg19j0uTElgFjnQyl8AbymuK4e/3tU+tdju4byEgjosSDhWTh4RrqgBnHvFAnpNkNrhu6PhClGvPUTYINp6yftvkHnQZSSNrN3uo/vutLo/OJkMm0M6DQAB1afk+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815438; c=relaxed/simple;
	bh=I8p9bOzJeqZgehGIA+FcFwpbNoVWUs1LHPhtCD3/XTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M27gxtsr9WqCEmSrPDVXZ/5t4Q3ojoX9u+kIlUzgKtzNC7arJ6zUouriMKM6QeVLcIHNb3ZjvEwYQeRZ/Bk+sbpb5WIgDWqT3HWBcGBYdO+ZT1oFdznwkJ9GsSMtYO9jb/V40hxmxEN+fjc3C8V4RjnjHFOlZ9L5cEEF5GjbkvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ali+vb6f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KO/3tv16; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ali+vb6f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KO/3tv16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784815434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRQoiSZqQYWhmB4hOxbp1x8OExK8dTCSnSeELl0NdnA=;
	b=Ali+vb6fo+EjqIRgx/QkSh2GZxRhKerHb8WDQz9rXM8pTeHyYhCBwaWhiWFOQO6iQjtVjh
	3hq0GtTH0SkEVORujh6TLXrt50rl1mhL4rkBOOSxBTw68ewfFu+3Rdkn7LFoaSfeRLKt55
	8kKLBLDc6tFTDMCqxVKHr0qGsGOkuUQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-dCp8QNbqM3KDtx4hMOOXLA-1; Thu, 23 Jul 2026 10:03:52 -0400
X-MC-Unique: dCp8QNbqM3KDtx4hMOOXLA-1
X-Mimecast-MFC-AGG-ID: dCp8QNbqM3KDtx4hMOOXLA_1784815432
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f83a59e5aso690662f8f.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 07:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784815432; x=1785420232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qRQoiSZqQYWhmB4hOxbp1x8OExK8dTCSnSeELl0NdnA=;
        b=KO/3tv16pfFv5pQu1rjWAhgDLfnh13UEIs0/ZPH28PISxmBk0Y4bHuMS2adBzpkXL7
         vJw6N8DzR/yqygZu11FdQ3n+orEGG1IZUyuV9n6voCQI6tE1KG+G2abhatFQB2KlHFeD
         LjUVrunQroba4qukRL0Ujh7xlAnhX/VuF9QzrGXwOLuLhcHSmoP9QW5vB8+S43rjZgHQ
         PzSedtO0x7piZNSbuG0b1tRD+SBUYWzIZvzxXcOSEHyez28UFhJVKU3PQJgucTq6stDj
         jx7R8+wHsaffaejbM2kt9/Sphr+VdTMV3iVRcYP5IIPZXtEllMG3tIG+IZruZrBia+ie
         gsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815432; x=1785420232;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRQoiSZqQYWhmB4hOxbp1x8OExK8dTCSnSeELl0NdnA=;
        b=JewuTYeLBYVCUzj7p2sakwrsqg14mRJ9QwLvDUQ/F8PKHzs3vHOseQG1riYv0cKJF4
         rg8Rr6QrjRGsI/S8txXS67g+0gO2ubPjot02opfzM9zW9f0vlBPI6jhgcgS80C9/kyX1
         +mUW85qYmgsboSZRCr4lAN8RxrEI2Z05x8JrfpvmVGk+5so5Hfn8K3dcx1NQf6SiTtuu
         PEBmyBerfxp8w5kZSMUFF0nKF26gb6dRyVZa9byaE3JIeoQAa5PHw3vIciyUGbBiZOHE
         jY1RlQqJDTkH2A8sFE8rwh5qmE2T1XpHXdwVSjV6AiL43ubcVZnfifu4FgEtL8ejpg2Y
         VGRw==
X-Forwarded-Encrypted: i=1; AHgh+RrD+P2tjct9WP4kTqETI8ouFnieJn32GTEdtRxfSf0WzXKiS2GHVxVGNwHtsONQcHs1LXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5VQL5fkbK8P7OeE268IelirsiZioXUsDh2brXtWwA9fEg16y
	cBqeAXUS6lkY7P24ZvEOO1YFT06DLNXKp94aTEVK5SgsfmD/E+3dYhpUcDH/KA8om0ckVXoCsFD
	TXoKAVnnnpd4vVgSsje2NxTPssU++cWdWJbPZRno1xIk25IucVIfeqoVu5B3L9g==
X-Gm-Gg: AR+sD12Egxjgf9CCyEvEhm69ylpQLcHxlBuR2taLuctZMHFFylDjZEI/pAxebWsjkHe
	JhZwcC/ji6BUruy7MQtLIBOgHEBIIfv2d8CBjTzwkarGjS0XhwVACpE2r3jBZHDoIyep3l2Vvxm
	iwzo4WL7PPEOcbWbJt9thkW7VUGFk7UWiOxBT3dUvgUj6emGTM70ct8ZT/72ImUqXXSI1DVdxMd
	R+jLNQH+1xUUbDS1+Wp3QI8SSmDGws+FGlbct/8QfocYgoQ3S5eiiDHXJR9LFgBbaYLtRrEUZpk
	E/k5Y97ixQDfyifXSkjIdtu5gGB5Rx8de4nv114uK62hzZIHelm8L1/8GD6/UfLmd8Ng3lAUw/z
	xU/YXOtrIzhOe4KwGfwP+OuSHkc3a+pA0qNSuzarf2Yh/Cy72rQ==
X-Received: by 2002:a05:6000:4029:b0:47f:9464:86c2 with SMTP id ffacd0b85a97d-47f94648782mr26177f8f.43.1784815431644;
        Thu, 23 Jul 2026 07:03:51 -0700 (PDT)
X-Received: by 2002:a05:6000:4029:b0:47f:9464:86c2 with SMTP id ffacd0b85a97d-47f94648782mr26074f8f.43.1784815431081;
        Thu, 23 Jul 2026 07:03:51 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm15087177f8f.11.2026.07.23.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:03:50 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:03:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <amIfNOLGeKubXu-2@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>

On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
>vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>vq->worker and queues work on it.  vhost_workers_free() however clears
>the vq->worker pointers and immediately frees the workers, without
>waiting for a grace period.  A caller that fetched the worker right
>before the pointer was cleared can therefore still be queueing work on
>it while it is freed.  And even when the queueing itself wins the race,
>the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>future attempts to queue it are silently skipped.
>
>None of the current callers can actually hit this: net and scsi stop
>their virtqueues before the workers are freed, and vsock unhashes the
>device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>in vhost-vsock keeps the device hashed while its workers are freed, so
>the lockless send/cancel paths become able to race with the teardown.
>
>Fix this by clearing the vq->worker pointers, waiting for a grace
>period, and then flushing the workers so any work the last readers
>queued runs before the workers are freed.
>
>Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vhost.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

