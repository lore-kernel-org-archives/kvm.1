Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854B230148C
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616943; cv=none; b=M0AMhhOX9UthRkdnclMheK6nRHiJ3CCtgkWsQNkt6X4Z4IkB1lsJS48adUv/u4Ha57sHkGi/SImYA84ilDwFW6m36x2UG1IrB2Bsdu7/19FCkghWh/Ij8TnKmjPGrMJsyyZVbWhjDZC3g+IJHz0aix6QMsWCFtdLq6QHVPbK2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616943; c=relaxed/simple;
	bh=floBdjdCkfcczlUBmvJASMGyf5DyrXJjY+5qz4ctWNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iut1hkVQk7zWV20Zmt8uudB0TTFovKwweawSloyJQvLxi9EjPRLhRSvw4Kxrx6UCZSjdSrF1Zg8CMOJ32MhafM9zMC9EEOhg92MdaIMrzM1Ypzt4GjuAJtAecl7qwBkU2csyX32JCAyM90ZssBIx4Yxgr28ga2oO6g02xejtnNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bgHUzsLn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUfREJWM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgHUzsLn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUfREJWM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781616941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMvcIb0SSmVD5ZpReBVCmF4OYpfrO6nfm5qCtnbjlbs=;
	b=bgHUzsLnJKauACwP/qQmLKUHkHe0SBMW2qObTWcZYepq9HcPGGO00Tuhb/xuST5jzYYMwX
	DRVX7OuA5Y1VNPs87xSVAdDQOf5yTH2k1CqjZDCPYer302MYkk6QDSTAgzNHZGGRCkCFTh
	ZSshq60IMK854CEwn3lCPEnz2wmz0eo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-vKAQuOvsOCW6MMmD8jXKUw-1; Tue, 16 Jun 2026 09:35:40 -0400
X-MC-Unique: vKAQuOvsOCW6MMmD8jXKUw-1
X-Mimecast-MFC-AGG-ID: vKAQuOvsOCW6MMmD8jXKUw_1781616939
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490ace40f13so19806575e9.3
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781616939; x=1782221739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMvcIb0SSmVD5ZpReBVCmF4OYpfrO6nfm5qCtnbjlbs=;
        b=ZUfREJWMTRBR+l9QwYwt523KzP1Ce/Xm7LU6xVo66PB/zEXnZfqcBWnuBhTcAgSGnB
         HlrxdCWDSK8Px0MsRp9dJ+Kdi5bIFZks7P5xtHJ7T2AxgO/LTXTs6wd9aMBCTxWlm0ch
         wf5qpamywY4zJLvdVCUh1ULSjeGcxnBIpoRYlwafLK83n5uTl3x+G5fCemsu/0KSqht6
         HY5mD3IjwECSYZTUE79KHCxb8ONqukNS2Motq5TWdTKQ/WRhhkndPVtelXs8x5avGX+a
         ppT5aqeCQ1Jjk/+1AiktNmluvXgKh+L7rDhWpXk+gXLgh6FGskEEG8iSSEmFnm6CDF15
         z4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616939; x=1782221739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMvcIb0SSmVD5ZpReBVCmF4OYpfrO6nfm5qCtnbjlbs=;
        b=qd8NvXl0xM9qp/TdSV8Yx7oYMjIV4+bjKRakK9sNph06yPsJ0D+KjaQWlq7rWCjlKj
         tDZLykwHOPfvDaqnQ90Stev+JOnwHLwX26PatLpP/6kdA97o1gyzYYJ+NA/q5+APd8RD
         Af1KrDQP1RM6Fu0Dbcflj8dNOB2k8TrPK8pMfvIXD2/8OSEKgn2DtmZNiqhc35pNN6NY
         0RrtBkXmHjgpfhO58KLYG7OximP3xgVinQ+sBu7BmlcFlfzA9LZm1BEAg8C3UyhI5jkM
         nu3YLTj3KuxAPJeOJzNqjljBubHTavWkxV3f6KboKHZftzNIGtUrTb7MKlhu2PfHmnYh
         bmWw==
X-Forwarded-Encrypted: i=1; AFNElJ8/IN8wybNp22CfPQK3ZtlCDDhwrG1EjcwIYs42qHtEGjFk3c4QrBY7Kjq68opK/JeyLHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxotRAvY6Cbgju8vBAEV/o+fQNUiYdzTY347E8b4rdms0cn0hSA
	421uRzHvwnAm9re37r5oA3vKQytwwz1vnNhNFTIo1Y7vsxwFIm/7JtIU5TUHQVumFJmNS73GFZ7
	dU3q+UBeSKNO2DKS36mw/M8RycANwIEYWtF5vWJNUYYYJYBZzkLwAkA==
X-Gm-Gg: Acq92OGXXRUgLqWvQYgo7278i+xpexF9lFsZBqwPLBNIoMs0gWLMIiD4S10okNinxrR
	gxwAJjL5lJhgWL0RN2n7APkI/7mbMRwF2dztxZ+4w8PTi50yvcIkH2AFinEZL+miD9GHs5C8Dhx
	fm1byTLc4ZlBnwl3aSW35QPTPOhYzCt499YdFW9jzmBTWGwUMZbtXM/QYdWQJ51Ki7HkIaPXNbt
	kb5vTOZZt4RBqnLQWWBkUkSACSUXpuFNgA6nly4hzMwEb9AcXx2AE3zXSefwifJhNo5BndLwJGJ
	cRkzR0wAtD+lopyGaXiS720HWQb19IXuL62nxo1HQY4CDqBim1K3DwCNRZgzIHgWOb4mokAk6Au
	qUDqwi498Bjw0mtqTgfk13bIjDUhCayd8iM+IVbfK5lIq70PCRuAHFzKYBdquMUyVrVXxtsE=
X-Received: by 2002:a05:600c:c0c3:10b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-4921fcb3ffemr168841245e9.0.1781616938920;
        Tue, 16 Jun 2026 06:35:38 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c3:10b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-4921fcb3ffemr168840785e9.0.1781616938426;
        Tue, 16 Jun 2026 06:35:38 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa890d8sm89760905e9.10.2026.06.16.06.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:35:37 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:35:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 0/4] vhost/vsock: add support for VHOST_RESET_OWNER and
 CPR migration
Message-ID: <ajFLvKcT-A0wvLYW@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>

Hi Andrey,
thanks for the series!

On Fri, Jun 12, 2026 at 07:57:14PM +0300, Andrey Drobyshev wrote:
>Host<-->guest connections via AF_VSOCK sockets aren't supposed to
>outlive VM migration, since VM is moving to another host.  However
>there's a special case, which is QEMU live-update, or CPR
>(checkpoint-restore) migration.  In this case, VM remains on the same
>host, and we'd like such connections to persist.

In the spec we have VIRTIO_VSOCK_EVENT_TRANSPORT_RESET which is usually 
sent by the device after a migration.

IIUC the specs don't say this has to be done all the time, so we don't 
need to change anything in the specs, right?

We just need to avoid sending it (which I think is what we're doing 
here... I still need to look at the patches).

>
>For this to work, we need to be able to transfer device ownership from
>source QEMU to dest QEMU.  Namely, source needs to reset ownership by
>issuing VHOST_RESET_OWNER ioctl, and then target has to claim it by
>calling VHOST_SET_OWNER.
>
>Since VHOST_RESET_OWNER isn't yet implemented for vhost-vsock, let's add
>such implementation (patches 1-2).  Also fix regression introduced by
>the earlier commit [1] (patch 3), and fix the deadlock bug (commit 4).

If it's a regression, should we fix it separately?

Or is it related to this series?

>
>There's a complementary series for QEMU [0] adding support of vhost-vsock
>devices during CPR migration.
>
>NOTE: this series needs to be applied on top of Michael's vhost/linux-next
>tree as it contains relevant commit [1], not yet present in master branch.
>
>I've tested this (patched QEMU + patched kernel) approximately as follows:
>
>  * Run listener in the guest:
>  socat -u VSOCK-LISTEN:9999 - >/tmp/recv.bin
>
>  * Run data transfer from host to guest:
>  socat -u FILE:/root/bigfile.bin VSOCK-CONNECT:CID:9999
>
>  * Perform CPR migration during transfer (either cpr-exec or cpr-transfer)
>  * Check that file hash sum matches
>
>[0] https://lore.kernel.org/qemu-devel/20260612165110.431376-1-andrey.drobyshev@virtuozzo.com
>[1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?id=bb26ed5f3a8b
>
>Andrey Drobyshev (1):
>  vhost/vsock: re-scan TX virtqueue on device start
>
>Denis V. Lunev (1):
>  vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
>
>Pavel Tikhomirov (2):
>  vhost/vsock: split out vhost_vsock_drop_backends helper
>  vhost/vsock: add VHOST_RESET_OWNER ioctl
>
> drivers/vhost/vsock.c | 80 +++++++++++++++++++++++++++++++++++++------
> 1 file changed, 69 insertions(+), 11 deletions(-)
>
>-- 
>2.47.1
>

