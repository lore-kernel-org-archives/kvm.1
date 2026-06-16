Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371EF3749F4
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615419; cv=none; b=VsbWkuVy61CswpGfLGQ3J0VCQOlaNRYwlkOBrBVrl9EyYfcS6q16XHBP+CvFfAF3Is5i6DVGxleFke3xanXVgztqhK7zl55mUbzEMSDJE+TsRWVmTNb97ZenCEDssH5tUMGvIzxJudFgXC7naYy33R077WLlDBNmp9GJC6rPfeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615419; c=relaxed/simple;
	bh=j8djdhTpE9KyreEqk3wMsIFtENli4AKg3GaItI1dKoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWgKLuUXbEQP1gxJF3adMCL+F9YWuwULctRMt4F+H2KxmCgz5EVgx/uuGTVSeH14LMDihNTmuMJLpT9nB5T4FPVmnw6z4o7BEofHHeJoQAiLTNK34JuSjD6M1UASaKXPyIqUrEJWV4X1wAJOxswWlP/TQEwMuIW19yge645Bvl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6P2MBjx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9KRzvnp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6P2MBjx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9KRzvnp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781615417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=81JkjnjNjtM/PGFVX6BX0wxD8D777cX7VAjC2y6ng/8=;
	b=g6P2MBjxJgiBerbF6ygNpPkSn9b74qHJC0plFVZPXoUklZiDV+nlQqK++X1tSWC75ysiXe
	kuxLzX8idFePzNr+1Iptp7A9exlE/tD6XVajkzLWejyz6FkC8HgDwFQwgd/E8DaMC1CnPN
	4TwBoygYj2y49uKFOoEh9Aiaat+ByGU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-B2bhRui4N4SyopLuk3WD8w-1; Tue, 16 Jun 2026 09:10:16 -0400
X-MC-Unique: B2bhRui4N4SyopLuk3WD8w-1
X-Mimecast-MFC-AGG-ID: B2bhRui4N4SyopLuk3WD8w_1781615415
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef616db45so3550471f8f.2
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781615415; x=1782220215; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=81JkjnjNjtM/PGFVX6BX0wxD8D777cX7VAjC2y6ng/8=;
        b=H9KRzvnpnp7Jim2ilOnW6p6T5AAN+lHJkcqMZFkO8X2eVdXlAgu/Xpf39TdyL7DaBl
         Eso+/+mW70hdni8ebvmlvTYMvgGt8CIDbr2BCtUGAqN3K57qCcUfM9JYomueoqMutaiq
         zxTIW2SX5hOpOuCOsd+fILhRAzC3kcpYnzHXpDRlq94ELGqn4KAW+UUqrbJKVFNp83qz
         iCznd4EKC6JySlNTUbdjhtOcUV+q5Mm5XbcrC4a3pkLPIh8yxjsZDppCbAvT0doHqZHh
         C17MRmtVqVgubjvnxecTIK7+jWDlB8wfUQvRb4a+HLSIIj7WytZnVfwPWjARXQKdgrPK
         ZhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781615415; x=1782220215;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81JkjnjNjtM/PGFVX6BX0wxD8D777cX7VAjC2y6ng/8=;
        b=GBGp12lZPCGRyjNnfPSl5VUveBU91WoeUsU/igLcC9kkQ15EhvD8bSlW0hoCWcd2aI
         zAoS9gzPCz1Qn3QiXodfV+avRTHEYpaAyrU1a+QCBM815OYCyTEMPLfYpbzvxu/ertJl
         +v3fqFf71d2nKCJpwJoUU5ptCX2mBM5TRxCF4pedqQc2dXjgvPNIi6ER1CcvmJQ4KBDR
         MMTeHZ91a7ijnOKsjHklUZ3ybD3uCeQnU2bWTXgfF1htPEzK93FkPGxnH/6BLPwPy9Um
         YkA+HSeqPHz4oyOwH8utKjWgpgVSsGXVcwyrnNp7IrAVB624zsQEYdnc5l/V7xHd+Cop
         zx2g==
X-Forwarded-Encrypted: i=1; AFNElJ/2j/mPc5XXFuOAUc57ya3+V8GXhX4aXEVIlBGp6j/4OnPPkefEiQa7ho7dCnRRvA6V/po=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTv7nwGOVVzsm3Y9WiEgkzzv4lNh9e32lmKMm0izeiWENqMrcH
	E4ghjBHBiSi8Rhi89DLACkwqfRZrMzUqiWjuFRRTHKDW2h/h0lRelE1eVMVVwEGAEhwaasCXxQl
	+z9qszF7JFlPGChfzpIzB811hxi6EDHI51NLn0XjFRYwMikVwp6iSjA==
X-Gm-Gg: Acq92OFZLuRe0mAVWe70YJj/33oe0N0zoO6PuehFXe80WH2sdQouvXGaqY9anplJpgO
	bSEPkt+D69WSBGvV6Y8mLgRv98ejvyQlak0849X6k1LtW5est76IHjOx4rUveI/R72D1aCwwbFO
	0xr+Vu6AjE+MPo9PCSK+siQECofkJdG2H/VJ3wWv5K33u7ZjpowdtaTrt3DX2SWjRRtoQEn5O/t
	duipXL1Q66Jy9wzY9fQSV1dortxPI1Om0e5X8uU7Q6LJM6FtCpnWDaQ13S8nNwDfUrPJc5D+PTe
	CSMAuSgvAVnK79gmmHhuZjEPpa67bo0U0crzCa98x7QF0WLPbJDuKeZzsxBROl/2L7eKghoY/4i
	j24CUhUdFxxxGFgY0e4bxJn0K+q6oKGBC0Dj3dw/9AzXL/a4uIfNTDz/ShSmUQ21XI9yJU/w=
X-Received: by 2002:a5d:5d87:0:b0:45e:da9b:97d6 with SMTP id ffacd0b85a97d-46074a8a2a8mr23974062f8f.27.1781615414625;
        Tue, 16 Jun 2026 06:10:14 -0700 (PDT)
X-Received: by 2002:a5d:5d87:0:b0:45e:da9b:97d6 with SMTP id ffacd0b85a97d-46074a8a2a8mr23973939f8f.27.1781615413909;
        Tue, 16 Jun 2026 06:10:13 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2cf5d9sm39082850f8f.32.2026.06.16.06.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:10:13 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:09:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	oxffffaa@gmail.com, rulkc@linuxtesting.org
Subject: Re: [PATCH v2] vsock/virtio: rework MSG_ZEROCOPY flag handling
Message-ID: <ajFFOJSdqpNWgohB@sgarzare-redhat>
References: <20260614174756.170631-1-avkrasnov@rulkc.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260614174756.170631-1-avkrasnov@rulkc.org>

On Sun, Jun 14, 2026 at 08:47:56PM +0300, Arseniy Krasnov wrote:
>Logically it was based on TCP implementation, so make further support
>easier, rewrite it in the TCP way.

Hi Arseniy, and thank you so much for the patch!

I’d like to ask you to expand on the message a bit, especially to 
explain why we’re making this change.

In particular, I’d like to better understand whether this is just a 
cosmetic change or if we’re fixing any issues (and if so, which ones), 
so we can determine whether this patch should be backported to the 
stable branches.

>
>Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
>---
> Changelog v1->v2:
> * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>   already added.

Ah, okay is net-next material, please use the net-next tag (ie. [PATCH 
net-next v2]).

>
> net/vmw_vsock/virtio_transport_common.c | 48 ++++++++++++-------------
> 1 file changed, 23 insertions(+), 25 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 09475007165b..787524b8cb44 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -328,38 +328,36 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
> 		return pkt_len;
>
>-	if (info->msg) {
>-		/* If zerocopy is not enabled by 'setsockopt()', we behave as
>-		 * there is no MSG_ZEROCOPY flag set.
>+	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
>+		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
>+		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
>+		 * handling from 'tcp_sendmsg_locked()'.
> 		 */
>-		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
>-			info->msg->msg_flags &= ~MSG_ZEROCOPY;
>+		if (info->msg->msg_ubuf) {
>+			uarg = info->msg->msg_ubuf;
>+			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>+		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
>+			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
>+						    NULL, false);
>+			if (!uarg) {
>+				virtio_transport_put_credit(vvs, pkt_len);
>+				return -ENOMEM;
>+			}
>
>-		if (info->msg->msg_flags & MSG_ZEROCOPY)
> 			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>

nit: we can remove this extra blank line.

For the rest I can't see anything wrong, but a bit more context in the 
commit would help me in the review.

Thanks,
Stefano

