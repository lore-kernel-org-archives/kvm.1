Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E521FF2A
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776253243; cv=none; b=RrleW00nyRpxH91JfGm/s2CNXHlUpI8dZzRbVDG4kcAxxZdWjkb3j8CAW8nITuBARmjBQAXHd6qfU3tQ/ishFFdN3SBI/SFdVfoKC6zTJtFchUlvkVNtU1Yf2jtGUhFRWSYPdml9MrPo3R6mpW0lmEYxDM2vYdPHh3N8OVpSL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776253243; c=relaxed/simple;
	bh=PembD3LExuC+fspVh61O0I7G8DlT5QWiK4JovfG/VAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CigSuWDz4HOf9cWWnHuxlvXgKI72rDmZfUqyXUl0gBFCrci56gRTX9FB6efc0XtLesuKJ+7Rv1UIG9sXKEeD+oRgEeMJdo3naAO82BEdkJ9B0wIJht8/hGGxEjwdgGzOdkotZfYaqJAdcE0d3oqT4nq61ZZUn/CmXeT/RgmSwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0j1Rx2z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FM4bjPBd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0j1Rx2z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FM4bjPBd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776253241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJVw6SswfwNiSg/u5NKKpPiwjKwfGIHglemFq4Sz4Hw=;
	b=U0j1Rx2zwz4YEelTJsyt6c7qVktzKBNJGZAUgJoNfMrtSaTowUwQ0jxe00XTEoykjgDgK3
	RFOM1+PFGOVVVK69IASgtKcNxO9jTDwj64/1oT9TlkIg4a2ADcgr05DjWcL8e1Qh82cdMC
	kHyZhasrw/BMzeVR2XWH0wpchFyII3w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-E7hiev4kOVqUyEsoNoFXFQ-1; Wed, 15 Apr 2026 07:40:40 -0400
X-MC-Unique: E7hiev4kOVqUyEsoNoFXFQ-1
X-Mimecast-MFC-AGG-ID: E7hiev4kOVqUyEsoNoFXFQ_1776253239
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d9e1e61aso35644065e9.0
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776253239; x=1776858039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJVw6SswfwNiSg/u5NKKpPiwjKwfGIHglemFq4Sz4Hw=;
        b=FM4bjPBdY7annbvYYJMaV8bk/REHZuOuMXFbFhd0jtgARmYo8KZXJLHk8V3yldqeqf
         fXk4CFI4VVwsPF7oJVsjU4SkSa8d01iORTdftPXn+1AXjoPfTON0oIcDjVhuWO+dTLBT
         YyYh5eIQJtfuVtTVKaQai6aX7mju4K59zfXj/ihLZ2ttwJ6+YnZQx2SK2yJMvrifRRtV
         OzQ3EUcUul454gFp3p+peFs9BW5K21gO8rcPNWJdrlHTs6k8B9M1Y3q7QJwzI8/iRYjb
         TbgptynIDXVa+b7SJs941GjnlvvZuDJ40poT0JwMLXqLhoZ/OhGt7u416fwFyrcGZk/p
         DsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776253239; x=1776858039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJVw6SswfwNiSg/u5NKKpPiwjKwfGIHglemFq4Sz4Hw=;
        b=lqOwcEjPgDjAL1tvxI6sztEm0Zeib+EDTDb6qhlfP7zqfzg4E0RcN9RCQzak2fKPOq
         OHtOOsuiWJmg33aFHuc41v2j1PC92ru6WV8WbeWc7cEq8NcrrpUpGbdgSapVtgkXOndC
         erQsnAsclY7P2NX++zTOVwle8ohzX1NN73z2S1tA1DOzZTpe512e1gsQPM8mBDU3IdiX
         fQBCH8peFfag9udcySN1leouIlI6V5v/gY8pfTy88j0vV6pWZuS5XUYOyuZQen/QO4PA
         9Y7ok2LzTP0VDB6U5WV9mevPyAUFUOGfrRME/VEtB9Ve7J+NaM7zzarsxBgvOWYgL282
         a3SA==
X-Forwarded-Encrypted: i=1; AFNElJ91xeZzD2jZz7YrqkIbxMpHGtbCeP/3o0CU8/+pcrXA8FggLORJvuiEJ8HKqbSX3K7AqPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBKFoGBjGqC5sBqk8wS1KJ7qBaNO35yYAqTP15BI4iqLQ73lwK
	AYSBEXqcVSPM2l2jsLCjG62Bag4UaW5RL4XZ9zu2MmPl5Fxigm4XVb3r/mN6M90quN+na/8S65l
	wYB1ATGmZAKmJvkCxyVvEyJYxWRrC+yz+99e//QhYApH4KL/qfF4zYg==
X-Gm-Gg: AeBDieuVrFlB4nPnsyQkZxAEVh9MZuiUC7D84nk/nmpIZoiSgJYdm/rXxdLpVt2QwmM
	APl8odrYK0RJHbPEp/dTYUb5T+QqOEjOKClEdDgh272/eLD4ohNPVHb1ggGyAxYsUiBf69Cus50
	EVJe810CJ5iKNXsWTMm3SS1r3J6R0/EzeNua9P4j704yt4y9xMeWkysepka7wJfUaPKvb5IEYoR
	iC/sYScEt7fiNDlNqThWjVTo8xvViSYXYPMhP3u6LxUlzPjew5SxEul0QakXYLQGvQLwf+0hklp
	og8ft0T8n+tdDIXAfRG7JAE1pSxJBHS4/6yWXFTYTqep2y0W8kc8s6q/MFUFVADYznyclRBBrfE
	TRwGWgZv/S6iS9RXUCPkFtMTvAeSYiEYl7Y82eMNgbEUJo9G+ckt2xvJgS8tAyorw2gLEvyzTPc
	mTOBWa7Q==
X-Received: by 2002:a05:600c:8218:b0:488:a14d:3d81 with SMTP id 5b1f17b1804b1-488d67c7034mr353013555e9.2.1776253238748;
        Wed, 15 Apr 2026 04:40:38 -0700 (PDT)
X-Received: by 2002:a05:600c:8218:b0:488:a14d:3d81 with SMTP id 5b1f17b1804b1-488d67c7034mr353012825e9.2.1776253238219;
        Wed, 15 Apr 2026 04:40:38 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5eb4sm4762846f8f.20.2026.04.15.04.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:40:37 -0700 (PDT)
Date: Wed, 15 Apr 2026 13:40:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 3/3] vsock/test: add MSG_PEEK after partial recv
 test
Message-ID: <ad93HtBWQqz980Ym@sgarzare-redhat>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
 <20260414-fix_peek-v3-3-e7daead49f83@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260414-fix_peek-v3-3-e7daead49f83@redhat.com>

On Tue, Apr 14, 2026 at 06:10:23PM +0200, Luigi Leonardi wrote:
>Add a test that verifies MSG_PEEK works correctly after a partial
>recv().
>
>This is to test a bug that was present in the
>`virtio_transport_stream_do_peek()` when computing the number of bytes to
>copy: After a partial read, the peek function didn't take into
>consideration the number of bytes that were already read. So peeking the
>whole buffer would cause an out-of-bounds read, that resulted in a -EFAULT.
>
>This test does exactly this: do a partial recv on a buffer, then try to
>peek the whole buffer content.

nit: I think it's better to mention also that we are re-using
test_stream_msg_peek_client() also for this test.

>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/vsock_test.c | 37 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 37 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index bdb0754965df..ab387a13f0ae 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -346,6 +346,38 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> 	return test_msg_peek_server(opts, false);
> }
>
>+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
>+{
>+	unsigned char buf_normal[MSG_PEEK_BUF_LEN];
>+	unsigned char buf_peek[MSG_PEEK_BUF_LEN];
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
>+	recv_buf(fd, buf_normal, 1, 0, 1);
>+
>+	/* Ask more bytes than available */

nit:	/* Peek with a buffer larger than the remaining data */

>+	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK, sizeof(buf_peek) - 1);
>+
>+	/* Recv rest of the data */

nit:	/* Consume the remaining data */

>+	recv_buf(fd, buf_normal, sizeof(buf_normal) - 1, 0, sizeof(buf_normal) - 1);
>+
>+	/* Compare full peek and normal read. */
>+	if (memcmp(buf_peek, buf_normal, sizeof(buf_peek) - 1)) {
>+		fprintf(stderr, "Full peek data mismatch\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
> #define SOCK_BUF_SIZE_SMALL (64 * 1024)
> #define MAX_MSG_PAGES 4
>@@ -2509,6 +2541,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_tx_credit_bounds_client,
> 		.run_server = test_stream_tx_credit_bounds_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
>+		.run_client = test_stream_msg_peek_client,
>+		.run_server = test_stream_peek_after_recv_server,

I left just minor comments, the test LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

