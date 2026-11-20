Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795176271;
	b=lVaYBCVDqI3esSe3YOFdZmejenhUR5YzFELZ7DzvbxJz49K+vO2MZVfakSda2dwGACO3
	 gLe0dNWlsOcuopY2jRdH50uPcuPpLwYzKUnwQYSPBrdovsl3nW0WS+ReO1VG17/mcp65A
	 pWZVoPJ7EnpCgjq7ghB/HkpiSAi+8sDf9v4c4oWEA2AlWd+pk7BIelwIuMkGiz6xlsZjt
	 lmAuKqP6UeHWqft8333WfJFjUING08ewipK6h3Ama8JhCoW7hDWr0h0IB2rcFcwqyj+Gk
	 HK6vRLao6W6vt3pJK5fBzEoEkBZczgVrj0fiNJc/IPzG+SkHOcn8Vf2s0z/h78yjkIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176271;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=XQu0hGy1KA1uO4Dt43vnkVWs8fGf8xNR3xdR0Qb+GQo=;
	b=Dmo7F62djJNrCoJFRCwxW1ZDKAtG45LZMPaavNYbrcGjWAmwWcCEvmGR44HFEH70RQDf
	 5SiiqfP3YGSGHtat6i35P+76rXKlGxDlhfCFOaEOIrrEPrQNXbn7ZxsR4j/XZoNA6NizP
	 AntlEPFErlOq6PZ3h3il1sKrB4u222z3PUUF2B4d+m3k5+EhRNUOJCJeEqjipr/9wwcLK
	 lrWqWbu5unebfK5pZZRIzmJ6r71/15Bh5K2jTYC8+PTzhWTVAqyCT7mUG7X5t74CeyAgp
	 Cdnjd7gkKVnNFmBaEd+XKcS4gz2Ytn9VJRzxSnsdAfiuOzZa90xAxFXVBgxTPXExiJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M3uQpmZf;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nxZbC5YZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7B606A326
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 12:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66A7B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M3uQpmZf;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nxZbC5YZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795176269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQu0hGy1KA1uO4Dt43vnkVWs8fGf8xNR3xdR0Qb+GQo=;
	b=M3uQpmZfqbVJjPN6Ut5ffQ1KdCKMRl+8gJz1myYwkFG1aq0X3VKJEUVBQLP3doPi+DUNx9
	2PX39Dt772bPI5TJ3ToksloECLyXG7+xp/tyBJmpkxe4MCgCA9C87PzUJ9F7cyp5D37Xl4
	2D5/e7fhqHGtwbEwFgIDC3pPnrYT0gk=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-RUP0wC2EPR6-G4-8oaepqA-1; Fri, 20 Nov 2026 12:04:27 +0000
X-MC-Unique: RUP0wC2EPR6-G4-8oaepqA-1
X-Mimecast-MFC-AGG-ID: RUP0wC2EPR6-G4-8oaepqA_1795176267
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67532014b2fso1431406d50.2
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 04:04:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795176267; cv=none;
        d=google.com; s=arc-20260327;
        b=CVoA6NBcKMrQZ7nOvHntP4c4lO4BTVnpjn70nqm3CvaPyXpgyrxFyPluJNELHxwDsT
         GTOmsozflunwAJD7jpjZEuQGOBU83U3CjGbEAXg5U9DWaToTrQNUu2DhBBeXvJgLWXto
         Z/jninUpoc3P4WBEWjJO8pwY6m69ORJcvgWz5frbyzZI+rDV9wxMqMbqjF9+OFlrNfTk
         bRVy7DREQ/EOy+hQtKUjyPTXNB9xJaI5R6I5HB68rvX3rNR1M+MdrGgiybVTYR2zKfaW
         yUXaSdo1WcRdr2/BA9UoKUerX+f77yUm4LOF4O+WZ6xU9FcUBC5MlVQdSIsMBsh9+fhO
         dzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XQu0hGy1KA1uO4Dt43vnkVWs8fGf8xNR3xdR0Qb+GQo=;
        fh=6WLd4xwgWDQHTh1qTx7UxLAs+mCt9phoU2I6E+vdbPI=;
        b=ndYWzcuF3UOhcZ4BULP0urS+tB6ytsGV9KPrcDru/wrN5cxshTt4QyuuSdMMgBhcIH
         rzkVio+dNlR2T6/dWVvWPNGb6Exgb8aVxkXISF5a/ASHYquz+FY8+DBfD6+MNqxjPi5R
         moZCjZomHxqW/kYElisH5xQC+Gb2vstFJH9LP7672mpaZLJTKkSGGQvFVnC7mZV9HviS
         sAatz1/iz20nuP7HfrXg+XPFtAEGwk/DIcV341pDxgjultC4rtvhWVBoXN7EK3TEQL6O
         AEZFQy9RGDTlgndYdoyJtWC72gMcUwsX/TqTN7xIYREODlOc9yrGyssciu0Ut72XXXPZ
         9/kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795176267; x=1795781067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XQu0hGy1KA1uO4Dt43vnkVWs8fGf8xNR3xdR0Qb+GQo=;
        b=nxZbC5YZPCZegBCOvX5RXZwjKOHM2FpbX/qijsdCCMZcrhShfupgktsMIEG4L0klfF
         serIHzmSktODQUIH3r8fukMrSL0LHU0b6zXUR/MVjlMKgEwkfeOqkVS70vfM6FNK88nx
         ejBvkJTRPPtgHvGqo0giJuLDixu/zqKbUDE0eJ7TuYK5q5qo8e0laqgvCAMJF2s0bO20
         Ji1X4aWOm38bQSTrJuEX04mAr2p1CgU/oUw/5sIh45K1Qo0obp6PSHXwcxOr2WoqKpUD
         Y+YyYNi0sVkd2YB1fs4rMRlknFOP46imWMpVB98pmMl6J+oxotUsSMUgzYgVAC2F4HXR
         kxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795176267; x=1795781067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQu0hGy1KA1uO4Dt43vnkVWs8fGf8xNR3xdR0Qb+GQo=;
        b=1iAjf9iuGBpBEvAvOTh2BDZvsl+pPOklYNwdlVh1N6rV1SS9nYl5suGsZ0JHh+ycha
         y9Pzk/oetGB+ni6wprXhsd8I41OGU9s6fBYtHU6AaTHKmNdnpS4QZC/ycfPQEH2VVaN6
         J7ZES3Sso6L7NGO2+tpcewm8/n2d1lnez2O5cK0gx66TUz3nAZ+i48ALwg/OVao4HFRX
         tAv21p3aj0pcD1hYdzsjw5aLqWjcicoKRbvdaHmZ5f1UPVLmuGg1+n55WsSvxeTVnQLP
         29MaxxjIW1CGJT14tGLiw9tlHeJXCEhxVrb33S9eEA0vHC6zKQ1wi2YvuyR99MLdeu1M
         4zgw==
X-Forwarded-Encrypted: i=1; AL+hErE4LHwI4wluaj6CGFL7RC5jxwO6wNJQI/rihWcRT2shV14AtNksg5+MWHWjx64hPF+7HCo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kCGdnejLffEutGQs6EZE9y/s3fO+C9n17WkIy3HwkHgBVbehe
	HcI6AWM0Dj/NWAHTAKdeXuaGq4lWvbHWA8l4MBJKFR4YTNRsAKlxVNNY2N4t4pMjQDU28qJDmR9
	//xciQmZWpld/y5PCpkfuxjkxNW9PoNXYkgirvMbFKKp0MCKaa9Z+BedtZe/MEZjh8Wl7eAlH7b
	JXycXjC0w0UQlpzFE84VayMlwVa7oc
X-Gm-Gg: AZFdTZfqrrfezz67Vp4xzQ9EItA4dSrh8cT5La3Cj5f0zdXnBbJzaybx5QO/xwptuR3
	6oJOqehREqyTdbJjSCO+0/Ld3vA/2z+P+NIBUdY7eYXQnhmbmge8IheOpPS2kaUTcpJZaRoH/CK
	JRtJ5KeYUzLpHSlQeffmFDxffMmMvhCDSdeV/QlalKz55LcDKvZbLrdKwCcNBiubW7OGMVhCVz/
	ZeRPMIoZyq94oEj+mIwPa590xHdKPRWTCRqZkX/47E3ar1zkU/ScNK7lwA=
X-Received: by 2002:a05:690e:4090:b0:67c:69f:b1db with SMTP id 956f58d0204a3-67df43cf48fmr1438613d50.18.1795176266604;
        Fri, 20 Nov 2026 04:04:26 -0800 (PST)
X-Received: by 2002:a05:690e:4090:b0:67c:69f:b1db with SMTP id
 956f58d0204a3-67df43cf48fmr1438589d50.18.1795176265935; Fri, 20 Nov 2026
 04:04:25 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1B3A1B72438119BC+20261120033824.681219-1-raoxu@uniontech.com>
In-Reply-To: <1B3A1B72438119BC+20261120033824.681219-1-raoxu@uniontech.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 20 Nov 2026 13:03:49 +0100
X-Gm-Features: AclHuK-i5EtKvbqYrIjTizPF6lX03AG63KfWC612II-z105w9vnQhBI_r_r_XiY
Message-ID: <CAJaqyWfpkenRAYdkeG2+XEWRhJbmV4ARZ+eMm=EibcA6i0z-5g@mail.gmail.com>
Subject: Re: [PATCH net v2] vhost/net: Fix receive queue test in busy poll
To: raoxu <raoxu@uniontech.com>
Cc: mst@redhat.com, jasowangio@gmail.com, davem@davemloft.net, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 4:39=E2=80=AFAM raoxu <raoxu@uniontech.com> wrote:
>
> From: Xu Rao <raoxu@uniontech.com>
>
> sock_has_rx_data() returns a positive value when receive data is
> available. For sockets without a peek_len() callback, however, its
> fallback returns skb_queue_empty(), which has the opposite meaning.
>
> An AF_PACKET SOCK_RAW socket is accepted by get_raw_socket() as a
> vhost-net backend, and its socket operations do not provide peek_len().
> With busy polling enabled for this backend, an empty receive queue is
> treated as ready and a nonempty queue as not ready. This can make
> vhost_net_busy_poll() stop polling prematurely or fail to stop for
> queued receive data, and invert its receive-side scheduling decision.
> TUN and TAP backends provide peek_len() and are unaffected.
>
> Negate skb_queue_empty() so the fallback matches the callback and the
> readiness checks in vhost_net_busy_poll().
>
> The issue was found during AI-assisted code review. The helper's
> incorrect result was confirmed on x86_64 running 6.6.0-amd64-desktop
> using a temporary diagnostic module containing the original and fixed
> helpers. An AF_PACKET SOCK_RAW socket, without PACKET_RX_RING, was
> bound to loopback in a private network namespace. Across three cycles
> of sending and receiving a 60-byte frame, the original helper returned
> 1 for an empty queue and 0 for a queued frame. The fixed helper returned
> 0 and 1 respectively, matching socket readability in all nine checks.
> This tests helper copies on real sockets, not the running vhost-net
> busy-poll path; the vhost-net module was not replaced.
>
> The patched drivers/vhost/net.o was also build-tested on the net tree
> with x86_64 GCC 12.3 and W=3D1 under allmodconfig and allyesconfig.
> No end-to-end vhost tests or kernel selftests were run.
>
> Fixes: 1576d9860599 ("tun: switch to use skb array for tx")
> Cc: stable@vger.kernel.org

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
> Changes in v2:
>   - Target net and add the introducing commit's Fixes tag.
>   - Explain the raw packet socket backend and busy-poll decisions.
>   - State the AI-assisted discovery method and document the diagnostic
>     module test, its results and its helper-level coverage.
>   - Document the targeted build tests.
>   - Keep the code change unchanged from v1.
>
> v1: https://lore.kernel.org/virtualization/20261110051642.249640-1-raoxu@=
uniontech.com/
>
> AI assistance: OpenCode was used to inspect the history, prepare and run
> the diagnostic module test, run build checks, and revise this message.
> The code change is unchanged from v1. The discovery method was confirmed
> by the author.
>
>  drivers/vhost/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 4570a4ffbab2..10ed2d55ff07 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -538,7 +538,7 @@ static int sock_has_rx_data(struct socket *sock)
>         if (sock->ops->peek_len)
>                 return sock->ops->peek_len(sock);
>
> -       return skb_queue_empty(&sock->sk->sk_receive_queue);
> +       return !skb_queue_empty(&sock->sk->sk_receive_queue);
>  }
>
>  static void vhost_net_busy_poll_try_queue(struct vhost_net *net,
>
> base-commit: 435cbdaf9b03687498dc16fe4af8d16a977e21d0
> --
> 2.50.1
>

