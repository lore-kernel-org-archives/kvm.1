Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B5E33556D
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174586; cv=pass; b=I7Pe3HFyDe9Y7oT/sOuKqqop6dIC+LphVyReqe+GyPD8PHmAcrI+eJv8QgMPA0bOX1eAizdcZD0kfHaXfgeErB97AxznapfdatEoJAf6WLwfoHAABxUkVtp69RX6LlahVHas9nT+c+V+GBNsAbx6A3msSC5pn41+OMi2DIK84Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174586; c=relaxed/simple;
	bh=eNEEQlIjrSAO0DH2OmgK6lfFH24wmDnCRfFdxuXXBJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPTcdxVUJry6lgry59oPegNbrb12fWVkYo9MA00XGwZp15brO1FTUqjng1rPGSKQzT1spmg0afPgEpO9HvMFBNQttcUmcgLnGDXKJe2KO49vYdhLHEjan0SaCjtJ+sQVBCEUrkY9gd+qPF40uJrK0XqmKy0/8hpgi15fC/CS6KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Amfas3of; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rJUtAZsX; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Amfas3of";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rJUtAZsX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788174583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGVDSMHx5ugj+9ChPGD41hmHDHU/4Z3alFYnki4dZYo=;
	b=Amfas3ofEpPqw32CUCQSXCj4UUhRiWuFML2V5w5gd7YbXLQJJ0SlVl6nXhCdhP0qdNy+mE
	k08AC2uCNc035xNT2YTfjyvGqpRiaCdnYJWngDG8imYETXzX2vramJSba8lvr0DVSDeAUT
	snXzN7QqEjIxvo1b+aREQTGZcg806gw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-ZA69fQd6N3GSmOL8MpgSlA-1; Mon, 31 Aug 2026 07:09:42 -0400
X-MC-Unique: ZA69fQd6N3GSmOL8MpgSlA-1
X-Mimecast-MFC-AGG-ID: ZA69fQd6N3GSmOL8MpgSlA_1788174582
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-836c8fc09cfso52204897b3.1
        for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 04:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788174582; cv=none;
        d=google.com; s=arc-20260327;
        b=pLb56KdcwsZ4Tgqiekb6eCar8SIahc9TRjd2flvoWD4X5xUAYwOJm6AzXz5D1izEVU
         rl3VdTvPA0AMfwrs9DsAlfpqWW4yXFI43X1VZ6v3lu6dvKpJCrbk7JL39827VzT2E9OH
         MkfPsOrp3YiJfiYhYFSis8hc+Qpt7BAjRQIHKnkl9gXTv/QFiJ0mDuvG1eMtbdwhvey0
         xWQ6mdhmnK5/r/anGFSgjMYMtSIZv9K/VXNotCzTcR/kEsqj3HgqFlS2wF/AKRnwW8P/
         +5U5fPPlIpMmnXerW+mpIpEKV717R3PyADnjMU/PZ6xd2RzMZXO1kwPLPkHyNewJmnAh
         k+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gGVDSMHx5ugj+9ChPGD41hmHDHU/4Z3alFYnki4dZYo=;
        fh=OCe38dekcbZ9jpL8sRR8Q/2KBBd4NwZTv6Zanf+n2+M=;
        b=jaXmzUe4Uy7cYWHLMPvmzZow6JtVoYFKzAMcwUhNUhUcZ2sDkRT/Gzgj2/Lyah941y
         2ZjCEoXEb6SLZo9cqSXw7sBWoh929M/O8ZG2qClTelcEZgg+WqlBgv1yJkoIaiYVSQwR
         aMrDVHbQJhYThpeKeysYctAxqyXSNG+jwnhOGAEF94njC0HAYTez8i52YY91kgFtaA8P
         wsVIW/IpwJ2keAh6Gn3+VHWXWDDuPzwkmrXHFw/sw+VwcRjeZ8mEc8N3K1RSVn82YLq9
         hrdaEp8uQ8+sEXAVRbuhu9P/U5Pob2X+QNGCcePO0I2KNA6qgzwxQZ/hZxmGW8OzvySC
         qB+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788174582; x=1788779382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gGVDSMHx5ugj+9ChPGD41hmHDHU/4Z3alFYnki4dZYo=;
        b=rJUtAZsXdtGTgU1G5jIWVW6DLV4vW+VKK0Q7Z7MBVGbXnabO5lLFHSOFdXItHfmSzt
         3fTiXEymJ4I+WYGLTIBx/dvA9Jqw5YBHahhcbf4n3gDDlbpF6PwYWNyS9vUoZlk9Ye+Y
         fP708RmOULS++4rsSsyDNVZL+6fqWMNAcLwijnPr5HivmuzMfnJaC1qIru9yD3hXajeH
         08Pp6/aCrJiknhGldgoev/Ss9Y6XomHk5+T6b/hSOGvaNhDTrSAdLecSSwb1MhjYk6Ei
         1hqM6kqTxxIgc7t25tT4PQVN5QIRUnR+C35DGm7ClqhCZEVI5Xlfm5nGGFqJUqLJKgwx
         fH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788174582; x=1788779382;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gGVDSMHx5ugj+9ChPGD41hmHDHU/4Z3alFYnki4dZYo=;
        b=NbgaipIDgwHn2UsGbk1x8tnCkiodpwWCSnRrMR8KUQ0pDLPcQdkbYJYZBfaFCMQEc3
         IB4go4LzLRmhLC18/TGWFJ+hdvCFb9+tkm1A8OX6TEsIhq/7DMiiYeeTV+1nNmjtTfxo
         URbqrpV3o9mN9655wIWjCmLGbgZXi5cq+4dhElDcLL0hlJQF4909LJD4R/vq3Kh74j8S
         vcZVT7tfp1qq0U7obZhZMVA2dPKO7llaNwtw1r9uz4EEG0zeT/moNXoGUh8WiIbt9vR0
         7eq8JiLqK2CeLvJioJA8sdG95CqXzOGXgpI56SBWr79gRWI8g1Cdc0SfFgiH+ukI3ihv
         QSyw==
X-Forwarded-Encrypted: i=1; AKwUvBxmzf9lvCBGkWiJsZOWZmi358FkwKypSdSB/Jd8QzRfn1nOLUP12UmMYYRZLswN3A6QC9M=@vger.kernel.org
X-Gm-Message-State: AFuF++kYkPaRlAAUdp/6Q6799SLvISJUIQRYpCBo+WOxGv+/X7RZ9sof
	Xt1Ym7h7zQckbtgClcDmguUbtvcv+Z2snCrLCfCwngZFlkbNzuNL/NphFJ1gPq541FNqgWL2d9u
	GBcqiE3E+rWDyQg88coTA+ZjxpCnPP0YqfbBZgdCI4YKbabnoeHLkNZmTbmS1wkYi6pH4zxNnOb
	+jzFd1Aq4oDZZUe9QEH+SXMxDDSuE1Ba9TRYtktmU=
X-Gm-Gg: AYBFou31HqqTQB3bbT24QuQvf0R+hjoOjO6jv4mzcxWKuhWM/JpGMJad5aFEAd4BijF
	r3dnenDMsEbk29hWTA1EDWiW4uD88nh0eGa1ihv3d4vEe0bUYLLm82NSFd1pOAWTgfbqfwSX32j
	xqrwxt2gJdP4aTq7mYW54T5m5t/LyL0Q2YrWrT9WbibMs9h6oxkTIyQwDPQOrzr840kp9JJNnbZ
	elq0dfoNE1Vexo7SQ+/efhbUsKTUOk9nhnbvVYSFLV7o1Em9t3IVzq8LDM=
X-Received: by 2002:a05:690c:c4f1:b0:81e:7d90:5673 with SMTP id 00721157ae682-85d6b84749cmr86908327b3.26.1788174581594;
        Mon, 31 Aug 2026 04:09:41 -0700 (PDT)
X-Received: by 2002:a05:690c:c4f1:b0:81e:7d90:5673 with SMTP id
 00721157ae682-85d6b84749cmr86908167b3.26.1788174580953; Mon, 31 Aug 2026
 04:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827055850.26951-1-physicalmtea@gmail.com>
In-Reply-To: <20260827055850.26951-1-physicalmtea@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 31 Aug 2026 13:09:04 +0200
X-Gm-Features: AcwNN1VgorMGLHjUu2yMfvgBMefLlEZdtOPgiCl06CVBpYpTFVo6Jeh18PCESXs
Message-ID: <CAJaqyWfjjSe19z4TrPbJfBBQZJXuAzqE4H8bik6UAiSgogzfmQ@mail.gmail.com>
Subject: Re: [PATCH] vhost/vsock: batch RX used-ring updates
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 7:59=E2=80=AFAM Jia Jia <physicalmtea@gmail.com> wr=
ote:
>
> vhost_transport_do_send_pkt() calls vhost_add_used() for every Guest RX
> buffer even though it delays the Guest signal until the worker finishes.
> Each call publishes one used entry and updates the used index separately.
>
> Collect the completed buffer heads in the arrays already allocated for th=
e
> virtqueue and publish them with vhost_add_used_n().  Bound the batch by t=
he
> ring size, array capacity, and worker packet budget.  Flush before
> re-enabling notifications or leaving the worker.
>
> Each used entry describes one completed RX buffer and keeps its actual us=
ed
> length, so set nheads to 1 for every entry.  This patch does not change
> negotiated features or compress multiple buffers into one used entry.
>
> This patch is limited to the current skb-based vhost-vsock RX path.
>
> Performance:
>
> Tested with a QEMU/KVM guest on a host with 4 online CPUs, using 2 vCPUs
> pinned to host CPUs 2 and 3, QEMU 10.2.1, q35, 1536 MiB, and Linux
> 7.2.0-rc3-next-20260713-next-debug-kasan.  The vhost-vsock source is base=
d
> on linux-next master at 49362394dad7df66c274c867a271394c10ca2bb8.
>
> Current vhost-vsock does not implement VIRTIO_F_IN_ORDER or
> VIRTIO_F_RING_PACKED, so both configurations used packed=3Doff and
> in_order=3Doff:
>
>   baseline:                 RX batching=3Doff
>   vhost-vsock RX batching:  RX batching=3Don
>
> The test used vsock_perf.  The Guest receiver was started with:
>
>   vsock_perf --port PORT --buf-size 64M --vsk-size 64M --rcvlowat 1
>
> The Host sender was started with:
>
>   vsock_perf --sender 3 --port PORT --bytes BYTES \
>       --buf-size SEND_BUF --vsk-size 64M
>
> Each workload transferred BYTES=3D1 GiB.  The SEND_BUF values were 256 B
> (SEND_BUF=3D256), 512 B (SEND_BUF=3D512), 4 KiB (SEND_BUF=3D4K), and 64 K=
iB
> (SEND_BUF=3D64K).
> Each state used a fresh Guest.  Each workload uses 20 paired runs, with 1=
0
> runs in each order.  The reported values are
> Guest RX throughput in Gbits/s.  The baseline and batching columns are th=
e
> geometric means over the 20 runs; change is batching / baseline - 1,
> computed from the unrounded values:
>
>   workload   baseline RX    batching RX   change   faster
>   256 B      0.0795724      0.0831509      +4.497%  20/20
>   512 B      0.1194885      0.1210297      +1.290%  14/20
>   4 KiB      0.7208273      0.7242053      +0.469%  11/20
>   64 KiB     2.1712797      2.1951941      +1.101%  13/20
>
> For reference, the table below gives the 95% normal-approximation interva=
ls
> obtained from the 20 paired log(batching / baseline) values:
>
>   workload   paired 95% interval
>   256 B      +3.985% to +5.011%
>   512 B      +0.206% to +2.385%
>   4 KiB      -1.442% to +2.416%
>   64 KiB     -1.474% to +3.745%
>
> All transfers passed byte-count checks, and no kernel errors were observe=
d
> in the logs.  The 256-byte workload improved in every pair.  The 512 B
> workload was faster in 14 of 20 pairs, with a small gain.  The 4 KiB and
> 64 KiB workloads showed no material throughput change; the difference
> between their results may be due to scheduling and execution variation.
>
> Link: https://lore.kernel.org/r/20181214082146-mutt-send-email-mst@kernel=
.org
> Link: https://lore.kernel.org/r/20220901055434.824-4-qtxuning1999@sjtu.ed=
u.cn
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  drivers/vhost/vsock.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 9aaab6bb8..d8050cca2 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -103,12 +103,37 @@ static bool vhost_transport_has_remote_cid(struct v=
sock_sock *vsk, u32 cid)
>         return found;
>  }
>
> +static bool vhost_vsock_flush_used(struct vhost_virtqueue *vq,
> +                                  unsigned int *used_count)
> +{
> +       if (!*used_count)
> +               return false;
> +
> +       vhost_add_used_n(vq, vq->heads, vq->nheads, *used_count);
> +       *used_count =3D 0;
> +       return true;
> +}
> +

I think that the used_count should be updated by the caller based on
the boolean returned by this function.

> +static void vhost_vsock_add_used(struct vhost_virtqueue *vq,
> +                                unsigned int *used_count,
> +                                unsigned int head, unsigned int len)
> +{
> +       struct vring_used_elem *used =3D &vq->heads[*used_count];
> +
> +       used->id =3D cpu_to_vhost32(vq, head);
> +       used->len =3D cpu_to_vhost32(vq, len);
> +       vq->nheads[*used_count] =3D 1;
> +       (*used_count)++;
> +}

Same here, why pass it as an argument? The caller knows way better.

Other than that, the patch looks good to me,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> +
>  static void
>  vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>                             struct vhost_virtqueue *vq)
>  {
>         struct vhost_virtqueue *tx_vq =3D &vsock->vqs[VSOCK_VQ_TX];
>         int pkts =3D 0, total_len =3D 0;
> +       unsigned int used_count =3D 0;
> +       unsigned int used_limit;
>         bool added =3D false;
>         bool restart_tx =3D false;
>
> @@ -120,6 +145,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsoc=
k,
>         if (!vq_meta_prefetch(vq))
>                 goto out;
>
> +       used_limit =3D min_t(unsigned int, vq->num,
> +                          min_t(unsigned int, vq->dev->iov_limit,
> +                                vq->dev->weight));
> +       if (unlikely(!used_limit))
> +               goto out;
> +
>         /* Avoid further vmexits, we're already processing the virtqueue =
*/
>         vhost_disable_notify(&vsock->dev, vq);
>
> @@ -134,9 +165,13 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsoc=
k,
>                 u32 offset;
>                 int head;
>
> +               if (used_count =3D=3D used_limit)
> +                       added |=3D vhost_vsock_flush_used(vq, &used_count=
);
> +
>                 skb =3D virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
>
>                 if (!skb) {
> +                       added |=3D vhost_vsock_flush_used(vq, &used_count=
);
>                         vhost_enable_notify(&vsock->dev, vq);
>                         break;
>                 }
> @@ -153,6 +188,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock=
,
>                         /* We cannot finish yet if more buffers snuck in =
while
>                          * re-enabling notify.
>                          */
> +                       added |=3D vhost_vsock_flush_used(vq, &used_count=
);
>                         if (unlikely(vhost_enable_notify(&vsock->dev, vq)=
)) {
>                                 vhost_disable_notify(&vsock->dev, vq);
>                                 continue;
> @@ -230,8 +266,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock=
,
>                  */
>                 virtio_transport_deliver_tap_pkt(skb);
>
> -               vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
> -               added =3D true;
> +               vhost_vsock_add_used(vq, &used_count, head,
> +                                    sizeof(*hdr) + payload_len);
>
>                 VIRTIO_VSOCK_SKB_CB(skb)->offset +=3D payload_len;
>                 total_len +=3D payload_len;
> @@ -264,6 +300,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock=
,
>                         virtio_transport_consume_skb_sent(skb, true);
>                 }
>         } while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
> +       added |=3D vhost_vsock_flush_used(vq, &used_count);
>         if (added)
>                 vhost_signal(&vsock->dev, vq);
>
> --
> 2.53.0
>

