Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E2A331A4C
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617740; cv=none; b=EbJHIK+GAXWY7qzSHdGliWnrxKONBvxUP4lSHjbj9fAa9y/ggyD2eUzQsmhphN6aeZHcV3eX+2uuw10sykaud1SunWaIKgUGaYs88VzlMj3o3uDyHTOhLQYeAdzmNyEZ/8Xuihebg/eXcvhGb5u80aPXEAPnlgMn54wIEpNkxpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617740; c=relaxed/simple;
	bh=5CR0/gNeuOc2zkbAwEj3QpPxqk48E1/i/BCv28UFb7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o86jcUf1BtQ3j/YKWmfWSLoXFH9HgQ2a6/4BvwPXxxqCvjrtNhPB5jH3as5BnKzUK8jql9KIIOYGvV+tMba80mr4gfpXAmaSGwvnRhC+T7YJpLlCH8zDS1BvNlUFPj3KBEqN5U8c/CoqAHLqEEuSKtgq3CSHETApfk4ElI2t6+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ray/TiNe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bKM3dCZW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ray/TiNe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKM3dCZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781617738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPZnF8IEm/lwUVIdQCh7bqnFf280e66Awhk1O9lMvHM=;
	b=Ray/TiNeXu0QitpH3JdZ7496Xu3iqxlX5dSijw8L7PeWSfyl/QYBUpZJcShLaWduAps/te
	zARtOLF3y/RcgFIi3v35gOsPn1+7nsh00oWIIggsoYuSRLsfPyD1ERIAHho6Du2UVebMZz
	+YOeYRu1R7q/UElC8Mi/YvUeKzbElQ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-HX-OLVJcOMuevAiFTwHFIg-1; Tue, 16 Jun 2026 09:48:55 -0400
X-MC-Unique: HX-OLVJcOMuevAiFTwHFIg-1
X-Mimecast-MFC-AGG-ID: HX-OLVJcOMuevAiFTwHFIg_1781617734
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b5d2e394so30178415e9.3
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 06:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781617734; x=1782222534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hPZnF8IEm/lwUVIdQCh7bqnFf280e66Awhk1O9lMvHM=;
        b=bKM3dCZW5Ul9xW0SN/q3t97OLCk/qxY49gGAm/hGCx+UMSY9V+Bmave47lOB+kfFcS
         Nj9a51geEC6o+UkLd9EPcffiqgdcIaQUkHCXkcWTfeO7FKkZBpOeFSe5EoQyoyBcTi/Q
         ZzOY+F95A5JBcxMM8p8H6PGVK2pfHgqK+VmpKEWg3V6AxGMinbaU2PiIhLzuXgtnLjfW
         EWCmp3XbMD8Vtz2ydGS6axrmw7v0olLKExcrlYB2Wk+ea86sPAhKnl0vwcKf92iBDc2o
         nlGzfHUVuWL/nv9BGf5O81SowjZv6XFzi/F/mb/KC2gmLyvx/PzrfsbyHWSWueVuiSP2
         PerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617734; x=1782222534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPZnF8IEm/lwUVIdQCh7bqnFf280e66Awhk1O9lMvHM=;
        b=CzFd3FY3rf4tW9CgUoUBqlrnE7g4enPqxvgjxOzretUUNYGkuUd8+hLO2MfQJrXYNW
         P8FEwfuumaVgMwzkYPlwmC8cHii8TWRjdGByg53iteK/K44BPm610M2nnBp3d+e6ph+4
         qELzcIwEdEBUx8L5UPW7lVhWoq7j8yMMLmZtSfUW2KKzP3Avawqs3aXuW6/1dtaK/LKq
         Q4O/krOKYAwUbZSw9soDDYl8VtF5Us2q+mjqMZo6FCq11ZMTlc/NdDk02j1Gfg/Wj465
         Trd4WY6vziFihpaPsqhUyUbdymmIk3tUheid5sZQ4/nU8mHt9+SKftcMb8zmHkuBnLsT
         /wAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+gGFeQ0RnLzmdedHyfkrZoXiD9idgYrU3LlcoaIT5lsBm5rtFqNzLdKPBpa0n9gg9c0Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGTaA38mUMHqKfwZjhafjNbn1OkIISr3LRdIGfQFsaOdmJLJB
	ugikeX91JO8KL+EEcIl/4Dr7YRWqYR0lrPESnyrZAgq/OkCPyCvRVdNyYy3fDjC0CLAdGhouMCu
	C+/grmMACM2faoWY3qgRBJMkGYAuXDDbx44vbIjweAXCdIOa9cy0thQ==
X-Gm-Gg: Acq92OGuXNCSi5H5saclAfDRCzdl4iOa1Df7NaXvqlbbFIgdTX9bitYOKCsxCaihPxu
	krN2aC3Mq84SJ95/3raxKy2wouSdzWDWDzeUe3a8l9e6HZqSEHrBipfj+vh7zWAy6uJQ6Huhan+
	e18Rjrz7xaYPt7vlEMLI3ltiDlU3wyZDqKT0UXj/qMg/lk4y6jPk2BX8kBYzKrrEO7RgpdT3b3v
	TF7jDHX8xrNoobozAC41t+axoIJVphJg9zEP3jK71007T3SKLXpYR/lfloffss49Kdt6ZjD0zii
	hIBppkgwnBBsiYZSngk46rSmVu+JQ/0epJ7bV5+U/91MIwV8T0B5Dh9D8wvmxpRZb28bHHBQWBk
	+fZv7BwhaGwM959qgLbnBRaLt3Jgp/9G2rKmcHoPXDyNhwwcDKZ5+7Vyia0T5VPKmdDv8IrM=
X-Received: by 2002:a05:600c:4e01:b0:490:bd1d:472a with SMTP id 5b1f17b1804b1-4922ff992ffmr58825615e9.15.1781617734135;
        Tue, 16 Jun 2026 06:48:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4e01:b0:490:bd1d:472a with SMTP id 5b1f17b1804b1-4922ff992ffmr58824915e9.15.1781617733491;
        Tue, 16 Jun 2026 06:48:53 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a58becsm60905695e9.7.2026.06.16.06.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:48:52 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:48:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 2/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
Message-ID: <ajFRRmA9req1muX6@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-3-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612165718.433546-3-andrey.drobyshev@virtuozzo.com>

On Fri, Jun 12, 2026 at 07:57:16PM +0300, Andrey Drobyshev wrote:
>From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>
>This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>the guest with vhost-vsock device.  For this to work, we need to reset
>the device ownership on the source side by calling RESET_OWNER, and then
>claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>AF_VSOCK connection while this happens.
>
>Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 28 ++++++++++++++++++++++++++++
> 1 file changed, 28 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b12221ce6faf..e629886e5cf8 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -894,6 +894,32 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 	return -EFAULT;
> }
>
>+static int vhost_vsock_reset_owner(struct vhost_vsock *vsock)
>+{
>+	struct vhost_iotlb *umem;
>+	long err;
>+
>+	mutex_lock(&vsock->dev.mutex);
>+	err = vhost_dev_check_owner(&vsock->dev);
>+	if (err)
>+		goto done;
>+	umem = vhost_dev_reset_owner_prepare();
>+	if (!umem) {
>+		err = -ENOMEM;
>+		goto done;
>+	}
>+	/* Follows vhost_vsock_dev_release closely except for guest_cid drop */
>+	vsock_for_each_connected_socket(&vhost_transport.transport,
>+					vhost_vsock_reset_orphans);

In vhost_vsock_reset_orphans() we have:

	rcu_read_lock();

	/* If the peer is still valid, no need to reset connection */
	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk))) {
		rcu_read_unlock();
		return;
	}

IIUC we are not removing the guest cid from the hash table, so this 
check will be always true, and nothing is done.

So, is this call really useful?

>+	vhost_vsock_drop_backends(vsock);
>+	vhost_vsock_flush(vsock);
>+	vhost_dev_stop(&vsock->dev);
>+	vhost_dev_reset_owner(&vsock->dev, umem);
>+done:
>+	mutex_unlock(&vsock->dev.mutex);
>+	return err;
>+}
>+
> static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
> 				  unsigned long arg)
> {
>@@ -937,6 +963,8 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
> 			return -EOPNOTSUPP;
> 		vhost_set_backend_features(&vsock->dev, features);
> 		return 0;
>+	case VHOST_RESET_OWNER:
>+		return vhost_vsock_reset_owner(vsock);
> 	default:
> 		mutex_lock(&vsock->dev.mutex);
> 		r = vhost_dev_ioctl(&vsock->dev, ioctl, argp);
>-- 
>2.47.1
>

