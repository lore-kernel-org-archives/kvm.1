Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC634B8DFB
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580233; cv=none; b=oLqa28MDp2UVzKUJzUmcs/rnPgC5gGWXKLv5KFwYIa6cq+yUSllwFt8Ft3sAq7Z3yt8donQzKPvO+TA0C8ht88ppHgc1HB3F54SDs2Gwb0+g6ZGfmtC353JUhc63P+1QngZtN9nXL9mTyRO83mjDO03el7lq6qzC5VS8LkCCQtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580233; c=relaxed/simple;
	bh=Xwy+EHHbHLCBc2qgYzK4qONDiarEocrGw7v3cd+QUR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqAghICUmcoDyubesj3XpYg3P4dzFCMIOiX0+Tz2Xs/l7RKcOad2cL84NbpVHb2oxP5dvABACSNC08CIrL53SLHcmeLTQMgUf1MzgRelN48FdN6P5dcm3lO4yjD6RoG8b566vFbx/X9ln6kuuaw8SHIBuM1wTbs8kZaC2YSyRJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDeg4TT6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2+jM7UD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDeg4TT6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2+jM7UD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778580231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa2P4JPNOFyNf5isDuaZw+nHOeelyWmJLKnc0gO81Is=;
	b=LDeg4TT6EzidCVuuPlrXGmVqrbzzLOaWY6vfaVrS+e2YLc/fEeWdRCZ4yOcDl9Ce4McWCN
	V2WvY5rh26bxhZ5yq68hGXWzw7wKVmWr+yZB10tAZvxgsMw7a9onEXpZ2qXMNoB47gKiF5
	4wWGcv2ZGDaqRLR3zvjvvkoPESIKWf0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-udlSdIz_PeGdlDn7INszpw-1; Tue, 12 May 2026 06:03:48 -0400
X-MC-Unique: udlSdIz_PeGdlDn7INszpw-1
X-Mimecast-MFC-AGG-ID: udlSdIz_PeGdlDn7INszpw_1778580228
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8eb04352972so1006356185a.2
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778580228; x=1779185028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa2P4JPNOFyNf5isDuaZw+nHOeelyWmJLKnc0gO81Is=;
        b=M2+jM7UDPO1yRQYtWCvHeFftYeZiCSHgeYGlMPTTnEhc6X5wh+tlojXnvbrzcIVwC9
         vl2KUdPVC3Ja3/5wRW+fdtQkLPnnmgiGyehiqFXHVCecPQvnFdRdcfbUQPL9NPiPpKPD
         Yd5IhsauBQXM4K+PEJvG24WFoZLtSUTApzMXAI+yr3zb92SswGc9RRP/Uh8BA7MgOm9F
         +nYsf2XDFGYloKfS8nWmk0XwadWGz7d+DYk9sORd1HS99XsjGjj9mtksfO0JISRFIDJP
         zdDtNqyUEZyj8wbIqXkfVYoUcAclpz/RUp2JhTkGvIkCod0pg8zhWuFhlvXm6+eKHp1Y
         47kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778580228; x=1779185028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa2P4JPNOFyNf5isDuaZw+nHOeelyWmJLKnc0gO81Is=;
        b=CNoPbOi37Ta0ICEkwWmleVALINBeDZhdFuROfw13uABIgqi6WrmgyT3HjZk9epss5q
         J6LwV2oFHTDNDH8KWPtwyJE0NsZ4a4pnxy8qVqfQk5zT72OlY1XCLM6YWQSZBmncAOio
         AT8jAh8uLZE895XetJuPIru/0sv+dn6R4uxD1Wl+IrM5xdxitG69ScnSfSuXAM2zubwK
         DuF7oYm3MQxNhoayr1NEmnEGwsGXv4uABgnyIuJjFiq+iL68YC+nSuggg4tSHsPS7/BJ
         mS/Nwb/dcQefBnuGaMj5bTtxUm5MTpwpHltL1DehuE6TQ90XuEm33vX2xu2E2SGeF7Ai
         iuLA==
X-Forwarded-Encrypted: i=1; AFNElJ9Vm9WP4nHsILu4BDT9J8cETBJnNaZV7KZvPDoKgTQuhlQ+RDIVb9VDhUWkO0Dt0RniWSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqXG/aJ5mkj121F1Qcl0SYKuZOTk0F24v/V6fn9V3nX0AcRCf
	uQQdusddUfuIYn6f1ciEBoavDPO9G2cuyCBZGYKXf0GCOt7oitcE249lwOfnShY7iyUCoMigy76
	IIEQvmHNFziu1ZLZwDMmiyDNugR+oWNSLWf5Evby4XFKpF1k/xnhbAQ==
X-Gm-Gg: Acq92OEJPjB4Ej6cVRmOu5ijSzkLLiu89jeuVBd7wnepgTm948iH7hNGTnDirFEDu66
	4LDjzRxL9Y3MsOelJzuDw6BtisjN+0e5ypaX6kki/xdSsFccmHsDMByoGCP7S3B6t/pg5K5mA73
	vrrxNPlzSwaqkowyiLpKlecgndjPIF80FehvNf7mfHeXlYJpmQ98dXEmHhyW9zKeVaGxcyigHPD
	Dv7f6sYM8K6GvYyWfyUfSkxMCGHW363QfdKU+g/6dxpNQ6ezgBu8bS63w6QVnfVpQifIIB8NL+L
	sSgQBcAxhk4BUajid4quuXgP0OMh1YufC7hXqpCr9fo3UcafZazm1hm2ulZwC1WESQomJ0fiYKb
	eOvEUEIxBti20NgbiWUkL68AcIz4flhuqwsYj+mhSVwMAyH46esWe9qvA4+AfgZI3p8bwo33clu
	MhUy8V/LgM
X-Received: by 2002:a05:620a:710b:b0:8cd:a3ab:352d with SMTP id af79cd13be357-90910c0e948mr1965594585a.61.1778580227656;
        Tue, 12 May 2026 03:03:47 -0700 (PDT)
X-Received: by 2002:a05:620a:710b:b0:8cd:a3ab:352d with SMTP id af79cd13be357-90910c0e948mr1965587785a.61.1778580227008;
        Tue, 12 May 2026 03:03:47 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm3644793085a.36.2026.05.12.03.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:03:46 -0700 (PDT)
Date: Tue, 12 May 2026 12:03:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net v2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <agL0ewq9R-Br9mUh@sgarzare-redhat>
References: <20260512080737.36787-1-sgarzare@redhat.com>
 <20260512044008-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260512044008-mutt-send-email-mst@kernel.org>

On Tue, May 12, 2026 at 04:54:34AM -0400, Michael S. Tsirkin wrote:
>On Tue, May 12, 2026 at 10:07:37AM +0200, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
>> queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
>> buf_alloc when checking whether a new packet fits. This reduces the
>> effective receive buffer below what the user configured via
>> SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
>> silently dropped and applications that rely on the full buffer size
>> to deadlock.
>>
>> Also, the reduced space is not communicated to the remote peer, so
>> its credit calculation accounts more credit than the receiver will
>> actually accept, causing data loss (there is no retransmission).
>>
>> With this approach we currently have failures in
>> tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
>> test 22 always fails in this way:
>>     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
>>
>>     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>>     Resource temporarily unavailable
>>
>> Fix this by using `buf_alloc * 2` as the total budget for payload plus
>> skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
>> is doubled to reserve space for sk_buff metadata. This preserves the
>> full buf_alloc for payload under normal operation, while still bounding
>> the skb queue growth.
>>
>> When the total budget (buf_alloc * 2) is exceeded (e.g. under small-packet
>> flooding where overhead dominates), the connection is reset and local
>> socket error set to ENOBUFS, so both peers are explicitly notified of
>> the failure rather than silently losing data.
>>
>> With this patch, all tests in tools/testing/vsock/vsock_test.c are
>> now passing again.
>>
>> A solution to handle small-packet overhead efficiently also for
>> SEQPACKET (we already do that for STREAM) is planned as follow-up work.
>> This patch is needed in any case to prevent silent data loss, because
>> even if we reduce the overhead, we can't eliminate it entirely.
>>
>> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Thanks for the patch!  I'd like to split this:
>1. buf alloc boost
>2. reset when out of credits

Good point, also the reset maybe should have an other fixes tag (i.e.  
when we introduced that check)

>
>this way we can revert 2 easier later.

I'm not sure if we should revert them at some point, even though we'll 
be able to handle the overhead better, but I agree that we should split 
them.

I'll wait for a few more comments and then send v3 with the split.

Thanks,
Stefano

