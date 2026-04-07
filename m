Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB97B39B49C
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553251; cv=none; b=TPkXZtWEue54mtYO7RNexuKKUCD/N/VTdmwdja7Izj9c6JUTbzq1uEs67r1TzUtiFTmJBgZoyPy/mlrfqaI/zotmJCh/QrdO5rcAUd1Kgnp/Pna7AlMYo7WgvQcn8NWjsvNYIpZONu4RCa7IkhMOepbc+v9cGE31bqoLexhSHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553251; c=relaxed/simple;
	bh=ip2wtGgcP4DvQiglidvGP+GnoassWfKVZlJvs+MlGRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCCUEB7/z7Sw9ThefHcKp0lJHKj9VrT6VlXF2YdjRMHRLWl4gI91ICl+39C0CEe47PXFhXI5Gj4XbjzjBS7PHkkLFDW8DJZZxOs2DLIrxPIdTseMLHL83XDSCfUcjoYrrvTqdoQMHCoMLocwpD08nqu0m6mjdhkz9NfBq7IwbRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLPtMeTu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fY9eb6h4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLPtMeTu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fY9eb6h4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775553247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5pofFwwc6ykPOXmyxDteFf7vraGRelyLMlwG/8lag20=;
	b=LLPtMeTuXMYge2Ih2sWYokgktWb0V+8YYjR7yKlEBPSCNIY3F+BsDXyNgu5zL6LMYrSusO
	QmwVZ7MpE4Cr1jXy1gGv+aaI459ogErnu1u+4LfIGbBPBdVxYBur835s0J7j4PxDGEiY2U
	+2IPZbdvkOj6SNWseBafjHFJ6vzr6II=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-_0Suu2D6PMe_4mFlyN6Gvw-1; Tue, 07 Apr 2026 05:14:06 -0400
X-MC-Unique: _0Suu2D6PMe_4mFlyN6Gvw-1
X-Mimecast-MFC-AGG-ID: _0Suu2D6PMe_4mFlyN6Gvw_1775553245
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d0de4bfb7so6497015f8f.3
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775553245; x=1776158045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pofFwwc6ykPOXmyxDteFf7vraGRelyLMlwG/8lag20=;
        b=fY9eb6h4x/t00R4VcEiVmNVRumeGOI0SoU4s9EV4GpkrcPUVzgfmnZyvvf/xarfwPY
         Re3s/68iclRT9X7q+EygTPq0taKK3LJUDGtUCI98kSZJbRkJZyENQ87/PhQs/log/ZMZ
         x9XPE1PN2bVfPj557zNQfdWUnzaAnEzBjqb/B7ddEofhGA3604TL2yFc84x81bcqmukd
         G10wtsZPUsS5JV5qKKIqGhF+mtpmJvJs1see7enSLTkt1qouqx+8HFMAf+Axg+osAO9K
         QnBQz/k7uGVxPvfbzO8UVsO+0AwbItgm2b7qxMIhFYzT8qGoKRBohNXntqsuv0pHBrr9
         oWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553245; x=1776158045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5pofFwwc6ykPOXmyxDteFf7vraGRelyLMlwG/8lag20=;
        b=QyF2DqKFQwoUDzlIjy6uw/T0lvZ58AGvaI/vJtBtOwGoNi7gtV0o/PPBpEtRQ/uXW1
         kvaID+UbdU4HAKfqhfd3WTFqlG5UlVi0xUcHD9TBtbg1TkYgQ/Buxv0D10wf7iHTDij8
         PIuUq9mRPnjvugzbC2uZWxtKp9SIlSb1kj5rSLspiUlhIGaINA+I/03F/k+rqslu+2h7
         prMG9ktzBh/gCiaZY500RbP3U1wh9UTVzpz8CxXyP0So96Ryi4kLwwEpdaa43p+wiqvn
         Y/ptd+Zsjm8CESU2pjyFoAAWjtjCO/6Yd4FmptTQJVnKB3WWoUT5Pw8Qnr55ksWSfoFp
         sIiA==
X-Gm-Message-State: AOJu0YzbGsposmMQIiwMlPKvokI7vWnNgyJS15NyWsTQhclVzqb1OdUu
	F6B4McBRzuru18zwh+Nf/25iWDzZQqs82vxl+PGcxNeEwmVTGMQZ2LF3pATz4zEHwHZG8rsRTH1
	aKlwzXnEh32XteSA+Jo/26IhHxwxOLOJRbg0DtjM6qps4bILtoQc1Tg==
X-Gm-Gg: AeBDietInwiZ8epUJPLCRQGFJYwFbKzrVrxMXz6aV6KqKMjZmDfRX1iCG6pBoqKu3G5
	+nURuTtj8go6Q9Ikwb1e/52LItqgwEj6aziJerAcHO+TTKdKZqaJdVeZZ4SYtiB4aKyGLbwQRo2
	mPf46SJ87fuKDWb3BD5Ahb2xba30NDw1uUq4B8XYpKMjZ5vKjVG7qHpnTclvc34lAnPBe8TlVei
	g4DRiu3ieqz4hV032BR4DkHxV64Ae5/Frx8OAJUMF0EUuRK1ESw7Du7P2unaAfIGptN9O1Z5PK8
	YOpMm0Zv7itw9Y9mS62pTBTQoYU8LM6qJzql6MZGQgYGXifwSyspIRg67sy1ysL9bIefOKCh+js
	wTGrGhN4zMQqiSTajZWSoggs3QfwT1v3h9Lanki+hDtyZV9iZgWyRW47ueSTK
X-Received: by 2002:a05:600c:1d86:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-4889970d844mr239703635e9.11.1775553245330;
        Tue, 07 Apr 2026 02:14:05 -0700 (PDT)
X-Received: by 2002:a05:600c:1d86:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-4889970d844mr239703185e9.11.1775553244880;
        Tue, 07 Apr 2026 02:14:04 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm342892015e9.8.2026.04.07.02.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:14:04 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 07 Apr 2026 11:13:57 +0200
Subject: [PATCH net v2 3/3] vsock/test: add MSG_PEEK after partial recv
 test
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-fix_peek-v2-3-2e2581dc8b7c@redhat.com>
References: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
In-Reply-To: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3

Add a test that verifies MSG_PEEK works correctly after a partial
recv().

This is to test a bug that was present in the
`virtio_transport_stream_do_peek()` when computing the number of bytes to
copy: After a partial read, the peek function didn't take into
consideration the number of bytes that were already read. So peeking the
whole buffer would cause a out-of-bounds read, that resulted in a -EFAULT.

This test does exactly this: do a partial recv on a buffer, then try to
peek the whole buffer content.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index bdb0754965df..d38a90a86f34 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -346,6 +346,44 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 	return test_msg_peek_server(opts, false);
 }
 
+static void test_stream_peek_after_recv_client(const struct test_opts *opts)
+{
+	unsigned char buf[MSG_PEEK_BUF_LEN];
+	int fd;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(buf, 0, sizeof(buf));
+
+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+
+	close(fd);
+}
+
+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
+{
+	unsigned char buf[MSG_PEEK_BUF_LEN];
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Partial recv to advance offset within the skb */
+	recv_buf(fd, buf, 1, 0, 1);
+
+	/* Ask more bytes than available */
+	recv_buf(fd, buf, sizeof(buf), MSG_PEEK, sizeof(buf) - 1);
+
+	close(fd);
+}
+
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
 #define SOCK_BUF_SIZE_SMALL (64 * 1024)
 #define MAX_MSG_PAGES 4
@@ -2509,6 +2547,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_tx_credit_bounds_client,
 		.run_server = test_stream_tx_credit_bounds_server,
 	},
+	{
+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
+		.run_client = test_stream_peek_after_recv_client,
+		.run_server = test_stream_peek_after_recv_server,
+	},
 	{},
 };
 

-- 
2.53.0

