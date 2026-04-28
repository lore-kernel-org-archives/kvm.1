Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718F3D3304
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364692; cv=pass; b=Fq+W4d9cAx7dTDXCpRF195uXwNm+49bmrrNM+ySLOZJYT5n86unn5rhr7SAO/vU2pYfGltOzpZy5VQ/1nyADlL950MjEYlhYffLTxUk5nleaOg72rNAK7q1FgxDzfesqohVmtURqkKU9iJArYNRe/Li/GFWSOeBK3tbUaqsAY80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364692; c=relaxed/simple;
	bh=rflQkKHjNVxCVgZtglvz+DJcNmjV4gDXBMOsyusJUg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+6z2U/nRO8umyXU929ZjuKV6pv5LHwg4X4Pww6SuIaxrYZ3nfiDMR3NyNt4Q9M7vStY9oTpWUbVbDLVKRqbKsRDDIsVWyMrpeHREBKjZwwfWUucPujeT0377FsfkMxgs+auDpUvVDGO642Fvf7m+ql5GFKM6SenlFktFEzGwDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKlDK6/J; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKlDK6/J"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7991db3dc98so121699197b3.0
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 01:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777364689; cv=none;
        d=google.com; s=arc-20240605;
        b=gSWen9ZJSi0YIpAel/Va0bHnTcaC0t4LVjOWW/7vVJrEOFBdebpudgagvyW3094db+
         spSQjcS4pyuYseS9z0T1GXYVqSATD4a0RUIKzIHGsZy7OwIwDVeAuLQvx3NB1G39Eeon
         yEUauwxeJjE87UkkLj50aufvnnVBRyd28um6FFcOpLUkEpv0zcpqOgZyj+v/k0XTBy5b
         kuNyPYR6VIKkedZO65mpTS6ISt6SBhlfd2mWUmZznnVy1VBTb56oRtoPJrfy78hq6GXx
         HR1yVUD9Uiiefsq9Ze+TLeYGiLsq95CEUYX49Q0S+3hWVMwTWyIeDCj2Z/9YBDJKnWwz
         FbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5nbTPPIa6lE5He4gxsryrRCR65xYKtTO0ggHOsJlUxQ=;
        fh=LWUNqf/CUR8xT2vk61z8Fn4yLP7BchD60909ndnpXp0=;
        b=EnT5czQsvVFEJ+DrhXpmZXGYwiRrPeINW3CfT/fTrpDY5JuUvZLol12hfIcFoSInWx
         ecuTqP9DKZ85bpJnxQXk6aRTiOU/N3ZUQhyR+pqxzQ2Py1i4qVUiRim1/675P0ZChY3w
         X16gN+ryCV7rjKkM6kzMC8BZUo91/DPYzc+Fsa3Myyk51bvWv2O1XVSfAPoRnpfhLN+k
         g4zISXGmeKOpGTOYSIv1P+QARs246x4iXTuRWvFb6ehxn0dJ6omdZDCj17uauNT8M3LR
         KjmC62J51+97cDA1NLlzg/xHr/s6wLG/DSfjEs6K6fPteNv66kLUEve1zwb5FDcr4kmP
         NBhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777364689; x=1777969489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nbTPPIa6lE5He4gxsryrRCR65xYKtTO0ggHOsJlUxQ=;
        b=FKlDK6/Jv8kfNtGY1NX3h4cuGQWkh2bPTW7s66iUkenkESCJzpbNLojgUNBzDYprm9
         9kki5WolLEy4iP4IZ4NnwQihx9jf4egowH5WAba33+Y/OWmQgkweU1z7f6S5djyqJTrH
         HvAZlGXU3uq+ugZQomxwBSaQts3a+yRqX8z5CJTekmBpgkiim9ViESCEWAPkwXk7xdsC
         qkYoejn0VNDhBvEDV6mjENXKuKOrxO4gv0q0AFPoYme3nFCC+B/vaErA10V4qyvfc4Zu
         lvwCBXlasfqxv6fdHxJjDabhVhOFY2nnXcQmUnpn9mLRZm+znxQSAjedltgsdXTMtu8t
         UhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364689; x=1777969489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5nbTPPIa6lE5He4gxsryrRCR65xYKtTO0ggHOsJlUxQ=;
        b=Q4dSckQKosNxLsOr7ITGU7FqyQ0u2aDB8L4bN4lOROq9tiS679dEAPNg3dzQLvd8q+
         Dk8MA6AnXB84J2AQ7TOVtdcdBoq7oB4vR2lKENQj3C2pFzqy4Tx2nBS9QN4m/qmAjbWo
         hPP18glsVtQv9aMqyhu+JMRAe4/VvmKfSQ6afSi9UtdxTLLJa5xkSA6PTFQOlT4Q2rkN
         HiLnU5RGU2BAlq0avexa+bFppBmXV5ftvj+yd9YqmtaVKrTbFFofeB1XiDrmL6v6q/dx
         k9OswaYquebx40PjD99Nxr4v61GQpcsvtNgyOxckKGlpUdqRfkCrK3KZUk6gVJAsDDjf
         CjtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1QLnuoOflB7FpM3Hex4YA7K7WP37fS8H9h3blgsF8aBZbw9fR6oca6OJXgasH30SnQE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPwpzGMMV7959mJ3wZCW+yqPcJ/q7qZKyMl14I52qYOeQTs385
	NyrdgEPpptkW85ZEadx4DrVc848SZwfV+F32ZgfSmh3hQOTA5q8YQiiyyMBT37UsMrsFEX2wLCW
	v7ocI5gQb9HN3OGHx610P+qzoCtml6PM=
X-Gm-Gg: AeBDiesUttR2kVZ6XUce1uzuQjcGDGATGnlMVgVWnb7jaQvAWx23ir+0V03l3IiVfRT
	T3TSjz6XqMAZqNchQ6bbrpZwyUw4V6ju56lpe4JTD7N13y6JlmB+2Cv1Jesxg5yskeqJ5YgRMYt
	kHO3QZHD5f/g3Z4LFg4LkUNQu8vA6k6gYZuJHGUIy6FTOgqkJEi5UyNw+D8jVJ1y0Yifn1GOug0
	3fpCmm49PkF6P5Y9GlDxYVBAMU84SysJSffKcVQtnVjQw3AO1JeNrwpi2HgvLXmAUZKqM5f6dob
	62rS79IcM00G1cPQnY47oIyBSdC8PuC6+Xyr/Ub7zrtfO7fBDnrkpmnTziNOl4rl4vuAvdpki6w
	1MZOLoug=
X-Received: by 2002:a05:690c:2607:b0:7b6:422d:7623 with SMTP id
 00721157ae682-7bcf5212a91mr20867887b3.16.1777364688595; Tue, 28 Apr 2026
 01:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424150310.57228-1-kartikey406@gmail.com> <ae9ilWoZI_-EMdWQ@sgarzare-redhat>
In-Reply-To: <ae9ilWoZI_-EMdWQ@sgarzare-redhat>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 28 Apr 2026 13:54:36 +0530
X-Gm-Features: AVHnY4LkfkfcAbNkAqMYMqsD9ddBBMlOtODTH4wKfniL5RjT_dtXJ2UJOta3HQA
Message-ID: <CADhLXY6APdmMQLSxN9b66pV5mp5sDwJRR7_BJAh13BaK-qoa=w@mail.gmail.com>
Subject: Re: [PATCH] vsock/virtio: fix memory leak in virtio_transport_recv_listen()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, stefanha@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 7:15=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Fri, Apr 24, 2026 at 08:33:10PM +0530, Deepanshu Kartikey wrote:
> >Two bugs exist in virtio_transport_recv_listen():
>
> Two bugs, two fixes, two patches usually.
>
> >
> >1. On the transport assignment error path, sk_acceptq_added() is called
> >   but sk_acceptq_removed() is never called when vsock_assign_transport(=
)
> >   fails or assigns a different transport than expected. This causes the
> >   parent listener's accept backlog counter to be permanently inflated,
> >   eventually causing sk_acceptq_is_full() to reject legitimate incoming
> >   connections.
>
> Wait, I can't see this issue. sk_acceptq_added() is called after the
> vsock_assign_transport(), so why we should call sk_acceptq_removed()
> in the error path of vsock_assign_transport()?
>
> Maybe I'm missing something.
>
> >
> >2. There is a race between __vsock_release() and vsock_enqueue_accept().
> >   __vsock_release() sets sk->sk_shutdown to SHUTDOWN_MASK and flushes
> >   the accept queue under the parent socket lock. However,
> >   virtio_transport_recv_listen() checks sk_shutdown and subsequently
> >   calls vsock_enqueue_accept() without holding the parent socket lock.
>
> Are you sure about this?
>
> virtio_transport_recv_listen() is called only by
> virtio_transport_recv_pkt() after calling lock_sock(sk), so I'm really
> confused.
>
> >   This means a child socket can be enqueued after __vsock_release() has
> >   already flushed the queue, causing the child socket and its associate=
d
> >   resources to leak
> >   permanently. The existing comment in the code hints at this race but
> >   the fix was never implemented.
>
> Are you referring to:
>         /* __vsock_release() might have already flushed accept_queue.
>          * Subsequent enqueues would lead to a memory leak.
>          */
>         if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK) {
>                 virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>                 return -ESHUTDOWN;
>         }
>
> In this case I think we are saying that we are doing this check exactly
> to avoid that issue.
>
> >
> >Fix both issues: add sk_acceptq_removed() on the transport error path,
>
> Again, better to fix the 2 issues with 2 patches (same series is fine).
>
> >and re-check sk->sk_shutdown under the parent socket lock before calling
> >vsock_enqueue_accept() to close the race window. The child socket lock
> >is released before acquiring the parent socket lock to maintain correct
> >lock ordering (parent before child).
> >
>
> We are missing the Fixes tag, and I think we can target the `net` tree
> with this patch (i.e. [PATCH net]), see:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>
> >Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
> >Closes: https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0f8708082678
> >Tested-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
> >Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> >---
> > net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
> > 1 file changed, 11 insertions(+), 2 deletions(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vir=
tio_transport_common.c
> >index 416d533f493d..fad5fa4a4296 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -1578,6 +1578,7 @@ virtio_transport_recv_listen(struct sock *sk, stru=
ct sk_buff *skb,
> >        */
> >       if (ret || vchild->transport !=3D &t->transport) {
> >               release_sock(child);
> >+              sk_acceptq_removed(sk);
>
> Ditto, are we sure about this?
>
> >               virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> >               sock_put(child);
> >               return ret;
> >@@ -1588,11 +1589,19 @@ virtio_transport_recv_listen(struct sock *sk, st=
ruct sk_buff *skb,
> >               child->sk_write_space(child);
> >
> >       vsock_insert_connected(vchild);
> >+      release_sock(child);
> >+      lock_sock(sk);
>
> IMO this is a deadlock with the lock_sock(sk) called by the caller.
>
> Also a comment would be helpful here to explain why we're doing this.
>
> >+      if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK) {
> >+              release_sock(sk);
> >+              sk_acceptq_removed(sk);
> >+              virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> >+              sock_put(child);
> >+              return -ESHUTDOWN;
>
> Since this is very similar to the error path of
> vsock_assign_transport(), I think it would be better to start by
> defining a common error path for the function and use labels to exit, so
> we can avoid duplicating the code multiple times.
>
> >+      }
> >       vsock_enqueue_accept(sk, child);
> >+      release_sock(sk);
> >       virtio_transport_send_response(vchild, skb);
> >
> >-      release_sock(child);
> >-
>
> TBH I'm really worried about this patch since both fixes are completely
> wrong IMO.
>
> Thanks,
> Stefano
>
> >       sk->sk_data_ready(sk);
> >       return 0;
> > }
> >--
> >2.43.0
> >
>


Hi Stefano,

Thank you for the detailed review!

You are correct on both points. I apologize for the confusion =E2=80=94 I w=
as
looking at an older version of the code where sk_acceptq_added() was
called BEFORE vsock_assign_transport(), which made the
sk_acceptq_removed() fix appear necessary. In the current kernel,
sk_acceptq_added() is already moved to after vsock_assign_transport(),
so that issue no longer exists.

Regarding the lock_sock(sk) fix =E2=80=94 you are also correct that
virtio_transport_recv_pkt() already holds lock_sock(sk) before calling
virtio_transport_recv_listen(), so our second fix would indeed cause a
deadlock. I missed that completely.

I am still investigating the root cause of the memory leak reported by
syzbot. The backtrace points to the vsock loopback path
(vsock_loopback_work), so I am looking there next. I will send a v2
once I have a correct analysis and fix.

Sorry again for the noise.

Thanks,
Deeranshu Kartikey
