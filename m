Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CE3C10AA
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027924; cv=pass; b=acczE84dOrPTw3/uyDKzIs68cT7BOu6gWehMTWEQc5qWdFHFR9G/+NE+bbTjTHDzVrrBl0mOzg96Rsjmzi/tcrUOFv0rFfco5E2ecCKjr9TSjqUCJTzKjMS6dLSoJCMIk4NDQlVrNhdxXuVjOmYaT2uxCoNGSP4Fu4Cb6n+HU8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027924; c=relaxed/simple;
	bh=ybsezbay7k70lPOQonDhXOaQ/fkYTSjG31ey35ltwqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IW7Fl7MnVRSHW+/G7dNpjPZhsyJ+6ygFGtyHjSazEP8n3rWtwLjmG/T1PtD9pXdbj8rP8qLNab7xRPlBk16NeCnSENe+t15JHjmBrx2VdSjfX8mKeT62GlmLVcyj3eCwgn6EsITOzXKqc+l7rcE6w1CCtWMSFa/1uLduzCz4q5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uq8BjBRM; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uq8BjBRM"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51765331535so2619601cf.1
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 10:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781027923; cv=none;
        d=google.com; s=arc-20240605;
        b=Ss5hIwK3FIACGhIYQNoCAMRYhNrdiZQ1OwsUNw7/G7oLWceFNtKPVvrEOXhFsyZdCH
         yzCsPO6JmKFSLARb579aSjPpO4LVYBS4xXQlspwtJ1PeddVvmkPhixs1Ql1/nEnhEunl
         deW9QKqEZZ4iZjmFIcTGcEy4X0zXHodgHk+MCtzd/J2yHlpyloCqGxWAcEfeJs1GHCtT
         6XePdtKB0MszlT6tZRzgpdb5GNokG34KWAbPF78mThNSASm65UgMq2PS2eMd67/1dm4D
         sz3zUGKxCvhFo0Dk9Owua8Z9yIZcEPcPH1VL77L9s0dLn3FhvpVQ3s4wY3N2yB8pg/jz
         C8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nwn+8bVabCNfsWsGPnwkQLJpfQuXsi9OyDflFuRUOro=;
        fh=mOY1cfKQetqN5fbzT3CB9GUcQtlkvZfV1PvhhaaW47w=;
        b=Lxk7TUUwEK2yDF4fAtT89CVch9AZXVp1RhxhftcyovctbaNwxT0F6Sb1zSCg+Q6aFu
         VeSuLwTVx5U1mUpMrRNPFVMrtmWpk36Wu1Ijr+eUeTFcmSCij+XsZddPshYWzazFAOs7
         rE4J51fA4VP2jXmldv+T+aYwU8thpQoeHHflLiHghWQoFGySmpgKr1wvISvCOAjNFl7K
         Ar5C3xwOPPmYY+EmYP9DeMozYuAoCHohWG3iKN2S2w5PrWdp8vkTeCvh/PojWZ4nt4u1
         Byg2Q36KqURQGq0S7fKp5xN4za0y1Opr5xsTjxjGtZuV5my9kCTKkPsMx1rcKwBCYULx
         bnaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781027923; x=1781632723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwn+8bVabCNfsWsGPnwkQLJpfQuXsi9OyDflFuRUOro=;
        b=uq8BjBRMK6RN4WOdIhKOT4vdaKifcO+F4oT5ZGYeNV9c0nDzbftCYWicIDWO7inBX/
         hk1EaQOr4tMyD9unFepPE9LfBXy0fdNXJv9VKSnGkYtmEfux1lpnKRx6UmQqkQcqubdC
         mlXFmiXyo+rCS5TXbzZ5DlU6RqLKkwRod0K2YU5rh+mTyxVACOFPYQMQ0X+kRsvjs8lS
         NF9VI2vE5jhZ8iHtTgOIe+8QHttVeuYXf4ba98UDuUMxT/aVgFfUxti1/U565oicj7fI
         71OZTFp3QQf/HW1fQmbmi98627koeQ73sXssKUsCVq/oYTM85TaRrscCbkXCBO65qzCg
         CH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781027923; x=1781632723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nwn+8bVabCNfsWsGPnwkQLJpfQuXsi9OyDflFuRUOro=;
        b=OQWHlgbKKjl54V8DJeYLLKs1PjRixojAyIBsAUZ734IPbBisfPVjOChbTEbtBeYbRL
         8fHbOhYNjLAJul0lOvY6tyADYgAVEYkunvJ67s5rj9Fn0S4oJPxsjpW7JrIw1ATjUm7V
         Ps6hQmwB0EpsoL2b5b9YEbSM/DtDT38rTqludjHHt7BCrL3l5tQZkY8WSPuZr5zsTYX4
         KaskkSsJdgjyPusSQj/UR+eNQazIuEHkClx7dXWU9OI9T+iv1ZEUAdTOothitgUTPfiH
         3uTi4lUVDwUvr9Tbq2CWGX7rre50aXTQgiDO+3xlYL0GoePvtx9hIvGrnufkmdpMs6dF
         by6A==
X-Forwarded-Encrypted: i=1; AFNElJ+4Y8VaNFl0VTiY+iXw7khGEGJ56lIdeVNxTnRxbSdT87KgZ3m6SQSEjeUzpOodH3O1m7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbu9z98pIZwgL+hC6GEgU4tAYoksuyZjXa0byND3IqfR+EI7Qa
	gxLwqaSYe4i9wRRqFuUMKhPl3ErRWEdKG0aMug/Hx1YvDVyVsyh00xaCwUS9cBIEzSCUB+8mZr3
	ApzaxbatzPOxj5ZaMrpL3ATyO8bdee8T/AaNDx30i
X-Gm-Gg: Acq92OFx1rKdpbXJcnnC67pZBpwNQCmjkQl4CULWeauZoMvGBAUpCrIunGCG8LbVhbx
	m4YYpRA6pecB2d8r4k2+eHsuHv2DiYUheJuVag6cnSQLQepmw7aAW6+wz7cbnZgQKwAwpdJlX3i
	E7ayyBpugxSEwX1PvsIlJ/o9ifIpe/rlWcOTTa0cjRgGk2Ub8w1HdGPDJd530CWXRXv/ScuJv+O
	eueVVN/4c2+LtSGqZphdBNIphND9h3TRnCnEtMtDACJYU+A0QDUuV8l7oikL+NzZBpBmH0PPldW
	h+MnPEpHdQ5n1Y4s7BARSd0xOoel3zMMsXZ6G8Be0So/yUrZGXhgdt1iOn00TMs=
X-Received: by 2002:a05:622a:6843:20b0:516:4f62:85ed with SMTP id
 d75a77b69052e-5179b114418mr33538681cf.18.1781027922090; Tue, 09 Jun 2026
 10:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609004809.1285028-1-tavip@google.com> <aifL0f_QO1kocccU@sgarzare-redhat>
In-Reply-To: <aifL0f_QO1kocccU@sgarzare-redhat>
From: Octavian Purdila <tavip@google.com>
Date: Tue, 9 Jun 2026 10:58:30 -0700
X-Gm-Features: AVVi8CdWuQeEp3U6i-IMth0fBQwGbxFj2zuxQPoE0fGsqs-1g0UsFmC0xhO_DaE
Message-ID: <CAGWr4cSY9V7JyvJWyO_YRR-9KJtp=OzAkDjjODJ9tM7orebZ5w@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: restore msg_iter on transmission failure
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, 
	syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 1:48=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Tue, Jun 09, 2026 at 12:48:05AM +0000, Octavian Purdila wrote:
> >When transmission fails in virtio_transport_send_pkt_info, the msg_iter
> >might have been partially advanced. If we don't restore it, the next
> >attempt to send data will use an incorrect iterator state, leading to
> >desync and warnings like "send_pkt() returns 0, but X expected".
>
> Thanks for the fix! I have some comments.

Thank you for the quick review!

> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vir=
tio_transport_common.c
> >index b10666937c490..588623a3e2bbc 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -367,6 +367,10 @@ static int virtio_transport_send_pkt_info(struct vs=
ock_sock *vsk,
> >       do {
> >               struct sk_buff *skb;
> >               size_t skb_len;
> >+              struct iov_iter saved_iter;
>
> trivial: reverse xmas tree:
> https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ord=
ering-reverse-xmas-tree-rcs
>

I'll fix it in v2, sorry for missing this.

> >+
> >+              if (info->msg)
> >+                      saved_iter =3D info->msg->msg_iter;
>
> What about using iov_iter_save_state()/iov_iter_restore() ?
>
> IIUC we may need to export iov_iter_restore(), so not a strong opinion,
> but it looks better to use those API IMHO.
>

I agree,  I'll add the export as a separate patch in v2 and move to
using these APIs.

> >
> >               skb_len =3D min(max_skb_len, rest_len);
> >
> >@@ -375,6 +379,8 @@ static int virtio_transport_send_pkt_info(struct vso=
ck_sock *vsk,
> >                                                src_cid, src_port,
> >                                                dst_cid, dst_port);
>
> What about adding a comment on top of virtio_transport_alloc_skb() call
> (or when we save the state) to explain that in specific cases it can
> advance the msg_iter ?
>

Good point, I will add a comment explaining this in v2.

> >               if (!skb) {
> >+                      if (info->msg)
> >+                              info->msg->msg_iter =3D saved_iter;
> >                       ret =3D -ENOMEM;
> >                       break;
> >               }
> >@@ -382,8 +388,11 @@ static int virtio_transport_send_pkt_info(struct vs=
ock_sock *vsk,
> >               virtio_transport_inc_tx_pkt(vvs, skb);
> >
> >               ret =3D t_ops->send_pkt(skb, info->net);
> >-              if (ret < 0)
> >+              if (ret < 0) {
> >+                      if (info->msg)
> >+                              info->msg->msg_iter =3D saved_iter;
>
> Also, what about having a single restore point after the loop?
>
> I mean something like this (untested):
>

Yes, that looks much better. I tested it locally and it works fine. Thanks!

I'll follow-up with v2 in a day or two.
