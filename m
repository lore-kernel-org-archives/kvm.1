Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E62FD675
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136524; cv=none; b=dX3As3nMJlrOW9VwXMolK1nQdHR427/HRRCs5rS8b8jkjJ0U8rxcVmWRbUqoKBEHBWGjUUfSk31yExbu3HsXM2AusAdPBcj/nUPi/iC9WvvdXQmwwS3O7REVjyPQ7ddVJb0/iw5Lm3ik6eIkNFvvlJd4GNgp/5M6YUk4LpfW1BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136524; c=relaxed/simple;
	bh=gGY/VwPUMO0SWDMiHLhnA/IVkYO3C7UOkCh7m+DwrXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGKs51gqNDNt+56bx/GCHWgOopnb7B0MXgbXDRK+iGp0Ki3b45wfOcUvV4UdVlc6QfDr1Oz0Fdk/5ZkHtor71bkVPi48nEt0a6xghE8sten/ZlzJsXQwp/Y8aIdu0B4Q6SSv2abhqMLOGZSfQSPbA0tdZmg/PfcIa6IMOtW4wd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZrYqBjC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qGoNj/5B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZrYqBjC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qGoNj/5B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775136521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/+o6grdtsiw9OGyUnvd5JR5iZVJ9ugAbNz7gRFL3qM=;
	b=JZrYqBjCkEpXkJ29BmbRJkNlT0B1d41CeARE85mK+LCCumUou66laXSPdyWdZGNWXRmxJa
	z7twZ1FOL6HeJTzIUHvW8r+Y+CAqvlqrOrXfMdfM+aengdalMC0/7J0R0tOFh6XN33XgoO
	gNs9feuCCRA7pB6jAtykv5dV2O5Yx+4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-CH8A3DPLPMSqS_cjs3ow9g-1; Thu, 02 Apr 2026 09:28:39 -0400
X-MC-Unique: CH8A3DPLPMSqS_cjs3ow9g-1
X-Mimecast-MFC-AGG-ID: CH8A3DPLPMSqS_cjs3ow9g_1775136518
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-487219e0800so5971985e9.2
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775136518; x=1775741318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/+o6grdtsiw9OGyUnvd5JR5iZVJ9ugAbNz7gRFL3qM=;
        b=qGoNj/5BoZQ/TZsnU6J6WgpmzC/LkxUNcLo2ra+Ee909d2xOeE0md5kSKgbwcDJe2q
         2C0aAIV+IqqQ4xwKvhOEUUeW4KRP0VxYIjHEPHLap5pCsgqU5orG232wF5cyh9zSyro9
         A34stdUq+QTW1QxrWA8LQUNXC//UJUlocWBBB/ZxPyFMmch7PNqlZc18rnfVUkWF8zET
         7SnKZu4wGzrQ+scPi9nM+d7qDtMV5i9hOq/Gj8XROW0xqlJzkvWgKE4De++NRNHYyNfH
         4lBBT2H1GGNom6zGfWZly+aewNjBrkUhgd1aTPjHFtDBJgH5yBM/lBydp5q0qCHLQNHo
         Hgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775136518; x=1775741318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/+o6grdtsiw9OGyUnvd5JR5iZVJ9ugAbNz7gRFL3qM=;
        b=AdnCGCdTCzE++tOWSwpdm8foKK2c5xXe8PZq2zOf2xXb6SahT7vZkcp6Po+sL7eZGs
         VOtQfG282Ko1VC2rg3cX4xdhy9Tk2r5Ag0jqQ+DijG6HEz+HORXz8h34A3rS2sN5u/FN
         VAt3RqC55F7ketJOCziymr5yF5GNCAe4gAQvTmg1S+6HlP2rRSAD4YHgZNTuiZKreQKl
         oB7vzWkYdyZQjr7flBCNPAmpzSbMyWNUQy69Im/yudvn16rT/a7nHlRYPDJ+DH2ElFM2
         GdFwKA5sL4VcGQZmcEdjT92TyE/Wt7tM5YLS7LUeSD2IC6zrsL7eqqIgs/IuXdgTWVDO
         v/jA==
X-Forwarded-Encrypted: i=1; AJvYcCUy3ZQfuUpYYJc628FLfZM4WiJKXr+ahOxkwbBPP/0BAhaXuwtZeqkJWFrGqubnW4urCQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc0NIQoMUzDYPVrASiEQ6xWCvy6NFZlUnHCE/DOrSqMCYpZFQE
	tJ9U5TejHAlot9IKlt+4vvmuBcYcZ0Rofgc3OD8Va0CxcExmbDNG38xzSfr7bi1BpTRDnmZDenr
	qlxQNhYpYWu6hGTDcvGXZZVLFGoW8bneR1qKuL8uf7qNgAfyt1vjMtg==
X-Gm-Gg: ATEYQzx9D+YxcTLpblwQcKaztNEgoT3Z8nTz4hCTANbbpEfLplJhjTcPnW4GuDKrkqh
	xG9Alm4eko6AadgckYRNSinlP8rezkHGRl4nTeq2fzvYxwFLnjFRI17CWaSVKw1j2Istn6yXBjH
	2+AWGktdV33IbKwX2uC9VWwalm/qVTrqNcqkIvYwiLT/hNgVjHsnGs8aOGIAjZibxJnE2uvpVuA
	Onj5tyhm7K4n5yp3ibgU/t7zW2ZhXF+0ldFq5cYZx+V2eFMlysrIvcvPwIQlLqTb5pFxj3NlaxC
	9y5hcZNFtFCG5BlNPLOplhrs2cIXRDzKduvkfNz7yUI+YbuLgHXZ+JLGx5qe1gpEsMG2U1DK4Zv
	/8nsg+FFaZfT7tmDOiljEXLtuxveZo39xd4rzV8k6ETiaNQ+QYOSQtWTz9nfea/lnXT18H0muss
	cO
X-Received: by 2002:a05:600c:848d:b0:485:3c66:e230 with SMTP id 5b1f17b1804b1-488835b78f1mr140993835e9.29.1775136518011;
        Thu, 02 Apr 2026 06:28:38 -0700 (PDT)
X-Received: by 2002:a05:600c:848d:b0:485:3c66:e230 with SMTP id 5b1f17b1804b1-488835b78f1mr140992975e9.29.1775136517515;
        Thu, 02 Apr 2026 06:28:37 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887a630922sm244763235e9.0.2026.04.02.06.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:28:36 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:28:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: add MSG_PEEK after partial recv test
Message-ID: <ac5qWSEBM--HuKQK@sgarzare-redhat>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
 <20260402-fix_peek-v1-2-ad274fcef77b@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260402-fix_peek-v1-2-ad274fcef77b@redhat.com>

On Thu, Apr 02, 2026 at 10:18:02AM +0200, Luigi Leonardi wrote:
>Add a test that verifies MSG_PEEK works correctly after a partial
>recv().
>
>This is to test a bug that was present in the `virtio_transport_stream_do_peek()`

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#11: This is to test a bug that was present in the 
`virtio_transport_stream_do_peek()`

>when computing the number of bytes to copy: After a partial read, the
>peek function didn't take into consideration the number of bytes that
>were already read. So peeking the whole buffer would cause a out-of-bounds read,
>that resulted in a -EFAULT.
>
>This test does exactly this: do a partial recv on a buffer, then try to
>peek the whole buffer content.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/vsock_test.c | 64 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 64 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 5bd20ccd9335caafe68e8b7a5d02a4deb3d2deec..308f9f8f30d22bec5aaa282356e400d8438fe321 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -346,6 +346,65 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> 	return test_msg_peek_server(opts, false);
> }
>
>+#define PEEK_AFTER_RECV_LEN 100

Why 100 ?
Better to use a power of 2 IMO like we do in all other cases IIRC.

>+
>+static void test_stream_peek_after_recv_client(const struct test_opts *opts)
>+{
>+	unsigned char buf[PEEK_AFTER_RECV_LEN];
>+	int fd;
>+	int i;

nit: int fd, i;

>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (i = 0; i < sizeof(buf); i++)
>+		buf[i] = (unsigned char)i;

Why setting the payload in this way ? Can we just do a memset() ?

>+
>+	control_expectln("SRVREADY");

Why we need this barrier ?

>+
>+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+
>+	close(fd);
>+}
>+
>+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
>+{
>+	unsigned char buf[PEEK_AFTER_RECV_LEN];
>+	int half = PEEK_AFTER_RECV_LEN / 2;
>+	ssize_t ret;
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SRVREADY");
>+
>+	/* Partial recv to advance offset within the skb */
>+	recv_buf(fd, buf, half, 0, half);

Why reading half of the size ?

IMO is better to read just 1 byte, since it is almost certain that an 
skb does not have a 1-byte payload.

>+
>+	/* Try to peek more than what remains: should return only 'half'

How we are sure that the sender sent all the bytes ?

>+	 * bytes. Note: we can't use recv_buf() because it loops until
>+	 * all requested bytes are returned.

Why this is a problem ? (an useful comment should explain the reason)

>+	 */
>+	ret = recv(fd, buf, sizeof(buf), MSG_PEEK);
>+	if (ret < 0) {

Should we handle EINTR like we do in recv_buf() ?
But I still don't understand why we can't use it directly.

Thanks,
Stefano

>+		perror("recv");
>+		exit(EXIT_FAILURE);
>+	} else if (ret != half) {
>+		fprintf(stderr, "MSG_PEEK after partial recv returned %d (expected %d)\n",
>+			ret, half);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
> #define SOCK_BUF_SIZE_SMALL (64 * 1024)
> #define MAX_MSG_PAGES 4
>@@ -2520,6 +2579,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_tx_credit_bounds_client,
> 		.run_server = test_stream_tx_credit_bounds_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
>+		.run_client = test_stream_peek_after_recv_client,
>+		.run_server = test_stream_peek_after_recv_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.53.0
>

