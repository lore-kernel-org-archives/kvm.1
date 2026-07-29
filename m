Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6618C3B813F
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352840; cv=pass; b=WcbLiQAhV6AHEUfQHh650cSRW+Tx/hUp21QlfZrkBS3j6k4fixBoAJ+4tNtmJ5fuYTUIIMwsIsEYTsCHZPl1PZeGtpQZ7cT04NR2q7w0QksbPlGxIkOtGr/iXVHi+dz2858yudjEnDMJagbX/MygDIHWGlizZHVIcKcIn3Ylp/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352840; c=relaxed/simple;
	bh=v39J0NNGbheOQbg9MTs7WdorPz5bwtfU4Pews8O/IIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mg33E6DjSPgZ8uRFpCj/hXanGGIPbOQQc/QMEH/8++Gp07WDTIOa1T4h8cUMxKAGsTi08i8aWaeDl+tDaU30NTKui2EA7QEQwWLsoylPFxR72ZbdrDZf5ORBlGLyKLlUH6DidBqGONi55rk9Cfx7hYeXOI+rTeTbe0SazSej8Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFOc/fUy; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFOc/fUy"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15d111ca99so153211466b.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 12:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785352830; cv=none;
        d=google.com; s=arc-20260327;
        b=eBIROy83A8sRhgazonWjmjIHJ+qHrgdZflMIZWJi4hTQWeOre0uaju5F+3MO8Ws/k4
         qLcqoZUoFQ1HhUEVa5iE/5cguL/yNuR3SvbEcG82FCcSKaFDPoTyGGRdF/qpvOMJ1nI+
         Q5JIjt0+rlzBBIh5Vo1f5AimE+ObLRxWzucsmn02PjmNlOt2DvVVOB962rtYLYpmBp7j
         m5W8jalIpDrNCntI4yzKEpx7rQFd8RxOlg/Ke0I4qZcVjo5gnFpI2o1cN5VCB4v/znrP
         b29/bvui3WLXDYzpFV4fzWyVzaY5GmdC9ye5J1QdaCvu1+sIpGMxS5m23QIccQf9qVdU
         G+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NDSAww7eofhNwmhBo8NXZ9YQ6g85WKpVrD6PKX308GA=;
        fh=ua/mifH5HSOG83p17T4oSnAd94S4iLZtHHFJWwovXOE=;
        b=RjSHnTadoclM2tXa7YxEOoVYUIqtivVrDHX4gPGvt+ti3PxZJ2yCjPN4roRju1rHQm
         DxDkeAImp4x2uH/N0EN2rFif6q/+O+a1H+tmz9EzdhUdX9zQHubpVQIVe4z/KUfXNylY
         QRD/M4Dg9yRamdVWUJgfSM8/2HuJzSkEAQSesSYLhIEWuyP17woHqC5tztwDahHtpKKf
         yxHvqLM1NjWUciho/bVlAaNaNMLBt2DIx6yjdx9sH0uuRvIVlJS5WThrTWcfsnTUHSir
         i25VxVkWIaw2DRh2OcIC1i0nfvbDCV8H6wsPQnOxJfjn907MeONZ+jeagv5eVPnSfL7W
         QUBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785352830; x=1785957630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NDSAww7eofhNwmhBo8NXZ9YQ6g85WKpVrD6PKX308GA=;
        b=OFOc/fUy8+Ygx08tslxV2T+DSfpMEEd+KgiXe6qCXef4DQwG6ajsHxqMHT1ToZlsq8
         +UyiIUD1mE03fFJlnkmKkL4ykWo/mPJHO/3SAzKKlWY6xx8C2j8pggj1Yw+PEHbwQso5
         Hyad8T3vIe0RE1EU4ss/40Gi+iaVnsGsGUM2mJqLDBPaO1y2rcRaVcmPCOaS3IBv6eLb
         moK30cLkriGGkPT7TeKfhevPQ8oEXLbk4RWGJlts3+W1L9Nq1lgm/UwdmxyWN5tyXfJS
         6vIRhjZ9qr8lM5EM4E4awjQRgmaFOFFQY0VpDcPJd7/rkMhQken5Z1H5IzXvyuyUvbQ2
         4NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352830; x=1785957630;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NDSAww7eofhNwmhBo8NXZ9YQ6g85WKpVrD6PKX308GA=;
        b=i8mnRtUkDsO7LeENz3UCGges+kNV3ZM0j9QKHALX/zPtRwb7KwOvNb47z/g+QI5mrz
         8v89L4CIPOajQOrfGXzWrjbvxswFIhp2z0s0hXKL0tM6KFInoHzA4yplw9Ftpz2Kkl+/
         KN8R0x6fYTOjEX0ZQ4pY8Yz3nx3PRGctstTqbQzbJzRS+RBSyCy2RNLQUU7mu7NOFdYk
         M0HWG5HX4A/UNaACRm/jW2wtLQ+9oUy1LLQCm3RjWaASylOY77MEr0NDvHMSE81cLwG1
         JU4jxsQ1Vojx1WYuw0j1YcSspspv3dPgsNMDU1ceIAqHCZc6wgIg3Ui6Aouc+qL5bAsD
         nJfA==
X-Forwarded-Encrypted: i=1; AHgh+Rrxz8G2JIq6ckruYoT4TnUSqpYDXEm+wa7bPjcImm0La2Sg54pO3rrHtbOmAI2tAIX07G0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynj2nMgCQmUWDxZgN2nIArcsi43a+3hCvaSeV92bFP+pGbIHZ7
	Cl7JQ/iCQr5Ii6e9Z34vYTvsU5ZjTw/mJ2pdOXmKBiZFtOazfWYjB1RnuFz31citosHubWBKK+A
	gxDx+Vr2jNfPUnagu759Xe5V2mXQIepc=
X-Gm-Gg: AR+sD11ODOSAcQAyMnZtCZjUaCHyI4gXsmPNUWn7+ikwQHT629+D3qLhO3gGG8FqB5L
	HMZ++kPyv94jHofyG8pxMVZPy/SAohGJOPZXB1+DDmDu7YoSuVZaU2mmLvo+BaMyPCRzusKxIBW
	u1Uw/MQb8JVkRh1BPZBxuGnV4WMFBeiStqa3SHrfpqYm4z/qHA80AFbGI96ktlvlZ3zmcQa++GN
	Qe6RELulhdGUE+8e0nSQpuUcOhQLqPRde1DMqoi67vZ+Gh1KzZsARrJ+QhCuY83w8aS/lJoYkKn
	OFu3hsoxpS9jNFPDWRSyvLcwGGp5rB5uakUyYF4OB4SkGZa2y/JAzYrwQNqqPN6Wc6HkbLm+WnI
	=
X-Received: by 2002:a17:906:6a0c:b0:c1f:922d:34c3 with SMTP id
 a640c23a62f3a-c1f922d3b72mr205963066b.14.1785352829519; Wed, 29 Jul 2026
 12:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727035804.1860862-1-bestswngs@gmail.com> <amjkQ2F+NEK9SPAj@devvm29614.prn0.facebook.com>
 <amoR0pnMO2OQ2E6z@sgarzare-redhat> <CANgPUi2LFBiBG1c7+s_AyzrtDdncXDXQQuphNqmC0uktvBY1dg@mail.gmail.com>
In-Reply-To: <CANgPUi2LFBiBG1c7+s_AyzrtDdncXDXQQuphNqmC0uktvBY1dg@mail.gmail.com>
From: Weiming Shi <thebestswings@gmail.com>
Date: Thu, 30 Jul 2026 03:19:52 +0800
X-Gm-Features: AUfX_myMxXtcqQ9SsdbccjfyUGE7H8t5bNEP8VjBISktONh9Fw_cte5ZVhUeiaQ
Message-ID: <CANgPUi3oUVf12GzPAWTX_3G6rEAssf6UwZi6dm7wW_YPjaMzmg@mail.gmail.com>
Subject: Re: [PATCH] vsock/virtio: prevent workers from using deleted virtqueues
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Weiming Shi <thebestswings@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8830=E6=
=97=A5=E5=91=A8=E5=9B=9B 03:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=88=
29=E6=97=A5=E5=91=A8=E4=B8=89 22:47=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Jul 28, 2026 at 10:17:55AM -0700, Bobby Eshleman wrote:
> > >On Sun, Jul 26, 2026 at 08:58:01PM -0700, Weiming Shi wrote:
> > >> The RX, TX and event workers read their virtqueue pointers before ta=
king
> > >> the mutex that protects the queue and its run flag. A work item dela=
yed
> > >> across freeze and restore can therefore retain a pointer deleted by
> > >> virtio_vsock_vqs_del(), observe the run flag for the replacement que=
ues,
> > >> and use the freed pointer.
> > >>
> > >> RX has an additional path: when rx_run is clear, the common exit sti=
ll
> > >> refills the RX queue. A queued worker can consequently call
> > >> virtqueue_add_sgs() immediately after freeze deletes the virtqueues.
> > >>
> > >> BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
> > >> Read of size 4 by task kworker/2:1
> > >> Workqueue: virtio_vsock virtio_transport_rx_work
> > >> Call Trace:
> > >>  virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
> > >>  virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
> > >>  virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
> > >>  process_one_work (kernel/workqueue.c:3314)
> > >>  worker_thread (kernel/workqueue.c:3478)
> > >>  kthread (kernel/kthread.c:436)
> > >>  ret_from_fork (arch/x86/kernel/process.c:158)
> > >>  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> > >> ...
> > >> Freed by task 141:
> > >>  kfree (mm/slub.c:6566)
> > >>  vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
> > >>  vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
> > >>  virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
> > >>  virtio_device_freeze (drivers/virtio/virtio.c:658)
> > >>  virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
> > >>  pci_pm_freeze (drivers/pci/pci-driver.c:1098)
> > >>  device_suspend (drivers/base/power/main.c:1968)
> > >> Kernel panic - not syncing: KASAN: panic_on_warn set ...
> > >>
> > >> Read each worker's virtqueue under its mutex after confirming that t=
he
> > >> queue is running, and only refill RX while RX is running.
> > >>
> > >> Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove(=
)")
> > >> Cc: stable@vger.kernel.org
> > >> Reported-by: Xiang Mei <xmei5@asu.edu>
> > >> Assisted-by: OpenAI-Codex:gpt-5
> > >> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > >> ---
> > >>  net/vmw_vsock/virtio_transport.c | 14 ++++++++------
> > >>  1 file changed, 8 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio=
_transport.c
> > >> index 57f2d6ec3ffc..79cf19f58943 100644
> > >> --- a/net/vmw_vsock/virtio_transport.c
> > >> +++ b/net/vmw_vsock/virtio_transport.c
> > >> @@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct wo=
rk_struct *work)
> > >>      struct virtqueue *vq;
> > >>      bool added =3D false;
> > >>
> > >> -    vq =3D vsock->vqs[VSOCK_VQ_TX];
> > >>      mutex_lock(&vsock->tx_lock);
> > >>
> > >>      if (!vsock->tx_run)
> > >>              goto out;
> > >>
> > >> +    vq =3D vsock->vqs[VSOCK_VQ_TX];
> > >> +
> > >>      do {
> > >>              struct sk_buff *skb;
> > >>              unsigned int len;
> > >> @@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct=
 work_struct *work)
> > >>              container_of(work, struct virtio_vsock, event_work);
> > >>      struct virtqueue *vq;
> > >>
> > >> -    vq =3D vsock->vqs[VSOCK_VQ_EVENT];
> > >> -
> > >>      mutex_lock(&vsock->event_lock);
> > >>
> > >>      if (!vsock->event_run)
> > >>              goto out;
> > >>
> > >> +    vq =3D vsock->vqs[VSOCK_VQ_EVENT];
> > >> +
> > >>      do {
> > >>              struct virtio_vsock_event *event;
> > >>              unsigned int len;
> > >> @@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct wo=
rk_struct *work)
> > >>              container_of(work, struct virtio_vsock, rx_work);
> > >>      struct virtqueue *vq;
> > >>
> > >> -    vq =3D vsock->vqs[VSOCK_VQ_RX];
> > >> -
> > >>      mutex_lock(&vsock->rx_lock);
> > >>
> > >>      if (!vsock->rx_run)
> > >>              goto out;
> > >>
> > >> +    vq =3D vsock->vqs[VSOCK_VQ_RX];
> > >> +
> > >>      do {
> > >>              virtqueue_disable_cb(vq);
> > >>              for (;;) {
> > >> @@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work=
_struct *work)
> > >>      } while (!virtqueue_enable_cb(vq));
> > >>
> > >>  out:
> > >> -    if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> > >> +    if (vsock->rx_run &&
> > >> +        vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> > >>              virtio_vsock_rx_fill(vsock);
> > >>      mutex_unlock(&vsock->rx_lock);
> > >>  }
> > >> --
> > >> 2.55.0
> > >
> > >Not a strong opinion from me, but since this last hunk is the one that
> > >fixes the bug and the other hunks are moreso hardening, maybe break
> > >these out into two patches?
> >
> > I think also the other hunks fix an issue, but I agree on the split
> > since IMO we are fixing 2 different commits. Commit b917507e5ad9
> > ("vsock/virtio: stop workers during the .remove()") was before
> > freeze/resume added by commit bd50c5dc182b ("vsock/virtio: add support
> > for device suspend/resume"). Only after that one we can have the false
> > -> true transition of *_run variables.
> >
> > So IMO hunks 1-3 should have Fixes: bd50c5dc182b ... and hunk 4 should
> > have Fixes: b917507e5ad9 ...
> >
> > That said, it's not a strong opinion here too, but if you prefer a
> > single patch, please add both Fixes.
> >
> > Thanks,
> > Stefano
> >
> > >
> > >Besides, that all looks good to me.
> > >
> > >Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > >
> >
>
> Thanks for your review. v2 sent.
>
> Best,
> Weiming Shi

Sorry for the noise; I resent the series as v3 with proper threading
and no code changes.

https://lore.kernel.org/all/cover.1785352330.git.bestswngs@gmail.com/
