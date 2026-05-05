Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019F48C8B1
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999050; cv=none; b=R088z083M0bnH0COwef6rn8VFpfLgxq/s5F5pv3g+DC/PNYVUdo5lj2uC7ShNpKEVNYTJYJSqNjotjFH/YPGEoNZyYbq5V89Vs/PQPptKXRC6nf1FsV14gSMMYz126k2k6Fles9psMNjC0Tb8jSIB/W4vgSTVzMKwbZjMRBjWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999050; c=relaxed/simple;
	bh=2vNM4P2xnGuAG3lTftkwlu0d8ky0Pc81tFLomdyLZA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHg22ovZu2qnaI1TYFWDiZJtEr15nrxw9nceRZ/rKC4cIeUMb/Lx+vBCFuL17xo4HCcvlpTds5/tFR9m4QZrib/w7nLjxJkQ8p+8oLK5alUNZW/o8dmHajsk2A9e7IlWml6nAsWlaEDZqasKgsVoqRysBoSX7MUYiXXPt7cd9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnwjTQNv; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnwjTQNv"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79827d28fc4so48782847b3.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777999047; x=1778603847; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PMfEZkH6rxvYX9869GT2iOu8sbvJpC6I3W7itO6JEjI=;
        b=UnwjTQNvq/r4beqLgkxxKUEWpEqcq3/5/5P9HzTdLDbUdvdM6TqcZ9a2FCgt9EP8Vh
         tpSAmdxVfuciSI0T5myAKGxtHcVxrocZoG6cz/cyVRGzj2d2uiFbDAEOoOs6kYShvjyY
         BBlbVoHGzjfLyg5uNMdeBNpMeiwkDXgPInA3t5PeHP7c17rOVOnwbgYSvvoHTm5WtkRD
         CDqemvSe6xheG+0qw8+mevVQnDuccrHfuA1xizPVrAiYqF0s2aAXc14NkhWeczP+R274
         Gt15ZKWwDWZ5BBng/gsbIhG2cPkT/5MxKJqyc67BkHJ/h8bAyrHvBFUhPs97cYo7E0dl
         3I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999047; x=1778603847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMfEZkH6rxvYX9869GT2iOu8sbvJpC6I3W7itO6JEjI=;
        b=fe/viJg7vCDr0LeY+RfKnxkCQXVyzowRHZgLL/hGc0q0iw3eKz8medM3uNYJLKxqrZ
         SsPSIfuO36wkD/6VHAfDIg1N7k806rOtuSd5XeEhzATEu5ZyljQMPhbQP5SfmUuszsxT
         knOu3VXId2U4BqgDB6cCEMoxhNsYzxpvVv/c/GHfiZoHKYojm23Pzcru0EpKwjfJRKYd
         mr1dbjCJEJJzVuBIPR4FE9twFb6PJDhTqrTkw7NxRG3elqIGjkkBjce9pZItdeSjDIgQ
         HtS6G8FLaGFPmDZvCRInqHY8E+bk2q40YfoDV4Wz8YuCtVXeG7GIsI8XL4qmqaX0DJN3
         S7sg==
X-Forwarded-Encrypted: i=1; AFNElJ9/9KlFN3XSDSpHSpJos8GA6zDWsCjrRCawq3DYeNR4n+Z9L7B4x9qlUxPTFhe29ynaRGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSSL7+Pg+rk05KFFLsA5fRtWnjKMHf/vmVGsIW4dic9AqV+vt8
	Jafor4tNHJx+KAv8Lyh1S/3GMN5//8UWv5PGC/NZVHWJmup2lHcYzRIC
X-Gm-Gg: AeBDiesQ3ncftraPKvSGhgdHqJBRAYq37+Ca8m3+/GMCWjlIOEr1btWQ0pVBRfClMN1
	pAkuoHk1oMqoMDTTOM58hxMbCNvZTPFPI/C/gM8UMYZDmo0Vw65Q52XZ4FMqp1ubzn4HrR04tJO
	3m3CKkMWpGgmVXt0nAayJUrWQeB4ALxWBadCSyvcScMdx6A3uW38OvN6Gze7MT6avnBW0eCeHRi
	B7tDOBPXbjNLG1hQLv3METgIkI9cFwAsock3CQoUROK8THEo7zh8q6FpjWC2rsLMlZKHVvXU2NP
	rpVkcdUDOO8hlVsly6uwswRzgzjMZT4/zhCVSd6ZbdzR4rM6XWfIoDqn7Bu3ag0g+q7Vw4UQoN3
	uV1XqnPRY5FBz26igM2TtVQh9+ug3lEav9m2J3JSCr0wiZtV4AxeQmKhAGrhpQ6cmC71lyGxn5v
	7S/KZTEtJ2bJUu/7Knl6wSIBOfRdyMb0krRh+PrPsBcjwb1Ch3a3sbAuU=
X-Received: by 2002:a05:690c:a018:b0:7b3:6c50:2e8f with SMTP id 00721157ae682-7bd77109d77mr140515237b3.41.1777999047308;
        Tue, 05 May 2026 09:37:27 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66525651sm66719897b3.3.2026.05.05.09.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:37:26 -0700 (PDT)
Date: Tue, 5 May 2026 09:37:22 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afocwkfBHJ5u10rx@devvm29614.prn0.facebook.com>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afoF_cHfl6ygcupM@sgarzare-redhat>

On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
> On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> > On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > 
> > > On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
> > > >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
> > > >
> > > >virtio_transport_recv_enqueue() skips coalescing for packets
> > > >with VIRTIO_VSOCK_SEQ_EOM.
> > > >
> > > >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
> > > >a very large number of packets can be queued
> > > >because vvs->rx_bytes stays at 0.
> > > >
> > > >Fix this by estimating the skb metadata size:
> > > >
> > > >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
> > > >
> > > >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
> > > >Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > > >Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > >Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > >Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > >Cc: Jason Wang <jasowang@redhat.com>
> > > >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > >Cc: "Eugenio Pérez" <eperezma@redhat.com>
> > > >Cc: kvm@vger.kernel.org
> > > >Cc: virtualization@lists.linux.dev
> > > >---
> > > > net/vmw_vsock/virtio_transport_common.c | 4 +++-
> > > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
> > > >--- a/net/vmw_vsock/virtio_transport_common.c
> > > >+++ b/net/vmw_vsock/virtio_transport_common.c
> > > >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > > > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> > > >                                       u32 len)
> > > > {
> > > >-      if (vvs->buf_used + len > vvs->buf_alloc)
> > > >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > > >+
> > > >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> > > >               return false;
> > > 
> > > I'm not sure about this fix, I mean that maybe this is incomplete.
> > > In virtio-vsock, there is a credit mechanism between the two peers:
> > > https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
> > > 
> > > This takes only the payload into account, so it’s true that this problem
> > > exists; however, perhaps we should also inform the other peer of a lower
> > > credit balance, otherwise the other peer will believe it has much more
> > > credit than it actually does, send a large payload, and then the packet
> > > will be discarded and the data lost (there are no retransmissions,
> > > etc.).
> > 
> > I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
> > state to account credit")
> > and find a better fix then?
> 
> IIRC the same issue was there before the commit fixed by that one (commit
> 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
> not sure about reverting it TBH.
> 
> CCing Arseniy and Bobby.
> 
> > 
> > There is always a discrepancy between skb->len and skb->truesize.
> > You will not be able to announce a 1MB window, and accept one milliion
> > skb of 1-byte each.
> > 
> > This kind of contract is broken.
> > 
> 
> Yep, I agree, but before we start discarding data (and losing it), IMHO we
> should at least inform the other peer that we're out of space.
> 
> @Stefan, @Michael, do you think we can do something in the spec to avoid
> this issue and in some way take into account also the metadata in the
> credit. I mean to avoid the 1-byte packets flooding.
> 
> Thanks,
> Stefano
> 
> 

Indeed the old pre-fix skb code would have the same issue.

I can't think of any way around this without extending the spec.

Best,
Bobby
