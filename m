Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364D372EE2
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561828; cv=none; b=ZBiAbDHQROBDy1LvtILpNjKCBgbpkH+GI8S/huhmycX8f8eEgjJblNWVV6QNHM+OVTCMh7bOqkptzQF42bjj5MmL/YN/WqPWmvp1623qNcsxoYFQLjvUKYmPwcihJwR4lwXfFr6nGZoyVnNjl3wsfk8cmfvJXXUsI4eXHGP256M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561828; c=relaxed/simple;
	bh=Fmhcgo0917MgP6Yewu3ZjCmJzTY2NacAiSJbTsPkO7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehvHN0bRtGs8FMBO7ZeQFusOf9mwW3/un8ZE991PlhlNuF3KWJqZg6mNQ0FNZg+p6dhQzwsDfSQFAWNMkkg9N86uEArGfedqIbpGGOCssvBEQLhPJ2+KiU2Kkm4Lh4eCPc2k+Lh0FGpsUGNGN6tYTpPH2+eOrVID2Bre4I9gYx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahltFIST; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gEL8QAVM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahltFIST";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEL8QAVM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789561824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rqm8tyx2h9IoJaqWWUmjhp0Aa68nUfNy8FsMl7kX/nI=;
	b=ahltFISTih303hehGdIZ5fYOm2+52DPbA/5IIqsvvTqfGT5RKz8TRZeyTGVuhG+tCdql4x
	/5H5Cq1PC6c9ZfwKcDw7VVkIaK5EhvwkStyRJJQDX5+8jHMb1hXBUMOiUSTVZrJxpx7Nt4
	LFWSKQR63K+WLKvmOV4jEU5qCuz5iwg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-2PJHH1ttMJCCZ1ks3ZggPA-1; Wed, 16 Sep 2026 08:30:23 -0400
X-MC-Unique: 2PJHH1ttMJCCZ1ks3ZggPA-1
X-Mimecast-MFC-AGG-ID: 2PJHH1ttMJCCZ1ks3ZggPA_1789561822
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48589603501so3265369f8f.3
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 05:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789561822; x=1790166622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rqm8tyx2h9IoJaqWWUmjhp0Aa68nUfNy8FsMl7kX/nI=;
        b=gEL8QAVM+uTzeFyDj8Fo0B1Bnboxr3hiqPOHoxCqsnGp8AOJ4cncQb8H7QNbsz4hMf
         TxKnkv7WqKBN00wwF7cyTkMo+Bhdp1Ejr9MXEZCQ95kJ/L1cMj2D27VBNdi2+KNS5Wt5
         HYsiw4PjlFkW/JTEtd1jIKirB+VOFjIijfZjKCrBI94A4eGZCttCladspb8tQyxFg+XZ
         7TK/KwOx9VvlfuSiCEyaslKeGzLzi8O3ohO6Vw9jyWRL3yeFQQfnVVu3iIjqCVga4DoV
         fpENBwQgt1GsiuRHPg1euRt7bZc3gmu3FpO9MT0YX42J5D+j1y5BK7y/Lb9C+wFhj0Ah
         abdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561822; x=1790166622;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rqm8tyx2h9IoJaqWWUmjhp0Aa68nUfNy8FsMl7kX/nI=;
        b=wiqzvOuqcMvS2w3YOQsTb4RIUBF6N0c7xOD1HxblUz1MRZ4tDsjMxK9xtWG//Z7vn5
         N6yGcc4u1P4DfP4lodAZT4P3cU++mB/jey8KOGRPIX1joIFqO5ynjwdo15U/KjjLKDki
         CegNKcYpTkRH50dyRkL0L1Bgx53alHWiOt+5kjxw9L8uoFd3PEFIkS5duyyMUn6OU5q6
         c+lCo5rZvAhma8Hx7EQLBLtfmHnv2oY/CvR8ACbb2u0uor1FoOETbuAerfKCEDBwTVOY
         ZfHAwxh7h29IBlNda5/ugWoNI5coOsRyaACXZrwQXl+cplmsTG5sc1cIqfHP53tYOtWn
         u0AA==
X-Forwarded-Encrypted: i=1; AKwUvBwvSp7MgGXT4cw8mJMpMQ6TicGjNMrNo6VqozlE0K8I5cy4CLIZ/w9i54TyLdmuBm2ykqk=@vger.kernel.org
X-Gm-Message-State: AFuF++lv2fBQQ0S80/aFYSes0ub/4S7CKq5FwRqUOoc+nszAUPhiSfow
	NoTr58vPPaAUw5SK6aphXODdLuGdC0P3AC6VXr0kTrLC7Dj/zDCfZkhXuNebvwBQ+Q5Sa2Aw0Mm
	cXC5j/f1w3myHHsY/a2GNGmgPwJ2lmV9mjRvCh3B57cJK5up+CUw95w==
X-Gm-Gg: AYBFou2m2Shj54nA57B1OXwjyNDHHQX0jW/6V6FYHuYt+hKIUltf4zi5Rxk9BKBpOf2
	Gd7H0YNhA85rl5IDugUQOLHNZKGh/K73sxOpo3tSOSTq81M7qp4+/giRnoI4RDxoCxFFLZ6lMY0
	1VnorodNUqr+jNwN6T4Qav7blHF6CgzJZBzziVMqn/ZbNHlfChl5ViP48xj0w0XuCDgR2zneWQW
	uk54DxlIIdd/dy9OqvjiUhX1oYFvy4/2VRpZx/C75whAb1IhnwnENvB6fIb6uFxZ7UEdgm3E3vS
	M7NDb+MFuDKiuZala5z5IOuSHypCawibu9ancZEtFffj8C18WxI/zYqK5NEE6EYdguVFxt4Vumq
	9JZ5iiY5uS9wvkcx18/CnZyWSddPec8oe46Zuw7d2JEDulg==
X-Received: by 2002:a05:6000:2003:b0:487:41c:175e with SMTP id ffacd0b85a97d-4870d03fdabmr2882245f8f.22.1789561822269;
        Wed, 16 Sep 2026 05:30:22 -0700 (PDT)
X-Received: by 2002:a05:6000:2003:b0:487:41c:175e with SMTP id ffacd0b85a97d-4870d03fdabmr2882180f8f.22.1789561821702;
        Wed, 16 Sep 2026 05:30:21 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf413dcsm6941143f8f.31.2026.09.16.05.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:30:21 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:30:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/5] vsock/virtio: Streamline socket reset on
 transport/PM event
Message-ID: <aqp3Po7OcubJboM_@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-2-a1d9abb472f7@rbox.co>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-2-a1d9abb472f7@rbox.co>

On Tue, Sep 15, 2026 at 03:15:13PM +0200, Michal Luczaj wrote:
>Follow vhost's vhost_vsock_reset_orphans() and VMCI's
>vmci_transport_handle_detach(): set SHUTDOWN_MASK, which will come handy
>later in the series.

IMO it would be better to include the reason here as well. Every commit 
should explain why doing a change.

>
>Note that commit c38f57da428b ("vhost/vsock: fix reset orphans race with
>close timeout") fixed a race between pending close timer, i.e.
>virtio_transport_close_timeout(), and a transport/PM reset. But here we
>never set SOCK_DONE, hence no race.
>
>Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 4f9aa9c4c3aa..4d6991321699 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -413,11 +413,14 @@ static void virtio_vsock_event_fill(struct virtio_vsock *vsock)
>
> static void virtio_vsock_reset_sock(struct sock *sk)
> {
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+
> 	/* vmci_transport.c doesn't take sk_lock here either.  At least we're
> 	 * under vsock_table_lock so the sock cannot disappear while we're
> 	 * executing.
> 	 */
>
>+	vsk->peer_shutdown = SHUTDOWN_MASK;

In all other places we use WRITE_ONCE/READ_ONCE on vsk->peer_shutdown, 
should we do the same here?

Thanks,
Stefano

> 	sk->sk_state = TCP_CLOSE;
> 	sk->sk_err = ECONNRESET;
> 	sk_error_report(sk);
>
>-- 2.55.0
>

