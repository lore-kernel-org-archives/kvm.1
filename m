Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34AF3ED5B1
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183035; cv=none; b=XapHvuHPMA3gh5WCZqh7r7iPvSwx4zBKJrsRVwKrshs33fZhEXXWkTa05cXrUTy6e/KeYNjf6z9TOFRcNTJsfX1cRorVgXNONaCKyXWj7jIYC9vs4zi6AMmypRW9aAoMQdfL0Pb6DVgm0NbPyIExCEtw2ObInZEXZlWzPQwzE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183035; c=relaxed/simple;
	bh=jtcpbJn9RIdJlr0hVO963zpJX/82bBkk/hi4mZSImLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iwt5n5KaeYr4CWRwUwmKDzi1IcBU9XDm6tl3uTXcwETov6WTKMG/n1rXTQZ7M/FQRlqPt9tjYPbP36Uki2iv8iVie2ZnqLRkQ208P1JwfgGhFNnr5vRJn/lvqNbzBVgIxLP40xJGQ+/D+pmvYDKrGeB7pocBi4qTa88uBehgySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IfJpM3Z6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJJ2T3f2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfJpM3Z6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJJ2T3f2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776183033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4qpSiwLjabUf/q5/q3aDN7iNzObMaLZodRYuDBTSlw=;
	b=IfJpM3Z6c/IGzEMMDyAXfi0zdZY7iL9yZ8eUjMJnnLweWNipFzMCCy+VWWLf/oCci5ftX1
	YeHNxDSoLSy3HlP6LsA1abeHb89NDszDMrhNvubs4LJ0eO39DqGZ/3pjxibbI4vFUqtLkx
	7HN7DiqmNGgFo4WSzaBqKmxhoKELxyw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-L455NYXRMCuVopzk5ULBjA-1; Tue, 14 Apr 2026 12:10:30 -0400
X-MC-Unique: L455NYXRMCuVopzk5ULBjA-1
X-Mimecast-MFC-AGG-ID: L455NYXRMCuVopzk5ULBjA_1776183029
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d7730e9e3so1403208f8f.2
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776183029; x=1776787829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4qpSiwLjabUf/q5/q3aDN7iNzObMaLZodRYuDBTSlw=;
        b=hJJ2T3f2Zam6T20AAqDBmgX8BWH53DXbJXAdHDKMrpfSERy0VwfHy4aRieMjFiDBOb
         VARpsmbc3fiaExISRehlrqqePwAyo5xDCzX2Eh1Yoof2DgxzYxXv2BkHl5hsbG5cGBO1
         U3lc5FanUERYTTk5yfn7fmK+/xBYvaFx02jZ6A1poTVCtIds+I+lK0Vc3PMCxpBYB8kE
         V/Gppu8z/7+wbLVUPSHeVjU0UgFFH6BoR6jLUFXJjn7fYY39cAuzOp7LpAGWyYVRWAS6
         52i3c30YqC/KYrollK3KsqopkbXtIl8XEvA3GwJ98DKIwOg4ZvcZi1SD2goMSu7ZeAeG
         ScHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183029; x=1776787829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T4qpSiwLjabUf/q5/q3aDN7iNzObMaLZodRYuDBTSlw=;
        b=fhAPzCAliC+gNlM1FwHzlLv06MC1qXjPNBzrDBuXK9j0f5vV1hNXk563AuS7oWZEtw
         mASRtDNIbzpLqCtL2MLRxWTbvYBi50DvooLtMUomsf1qZr80hTwdLS2PiUrxP24Qm2zq
         1isVoUB42YGDaqz/Q4xisZVOhb0+oVT8OVeCoBafcQw9oRC01OUKH31BCnC8jLjAOr/P
         AylCuW9F08KGljkJzf0sjOJrysU7AwC2ZDGLG3/fxC3D8V4I9I2R7efg8PxBXYpL4IjA
         1IU4LkwZV1VrsvFQVvptTtcDilqYrOzLWo3H2SqY3+wh/TNSJEyZcrSHSJQoMTvWi+9z
         SGdw==
X-Gm-Message-State: AOJu0YzZvRxGiLl30TRhYpM2pccmA6flCckltFm6bAPcSDGbzScGhc4z
	Kn7W04nGkywD/WOBkSWS9Z/caECE9FK6qXi3ZnIw4zMkS1BORmB4921KkB5B8CbzCBQlXvcW8cc
	pa2PBRQX2qUkAZNZTMiQCPUlZZ1gtKfZfUlgE8RxYbs1/cwxJNorHDA==
X-Gm-Gg: AeBDieu2EUqSbLcGUnaTybMncoB29OmMz+1qw2mB4+xxCpIZQEvEpeld73v/Bn/7vz1
	Nv9NwpSlN8zG1UOYChtb4GN1w7TcVRzuj7WFh+N3wjBJQd4K2TuGR27MlMktmJY9jJokXS+aLkw
	/mVgAjyVF51sSaBDBP05AireCVccIvUFm/hIhbRtc9rLRq1c9azI856+IQry0Ja+Y+a7KRiHCYn
	DmuvvBLJpqc4Ic5/8NTO5H45goO75DvDAmrK1Ab3K9/007x5edN+V1L/u7b4qYaO2lG/ePPEqWe
	w4k0Lw5rqy9hjk6wMwHZfSYeQ2qHYFdsSrqT65yEkXhoycD1/PYVOy5cSCxiEeDfXUJHyUDn8QH
	/6pQkEsE+O8arIztQ+JRGTR7R/YVx7Mj7D13zNe5SR1dlORtGCGFgtV504eZX
X-Received: by 2002:a05:6000:1ac5:b0:43c:fa96:d939 with SMTP id ffacd0b85a97d-43d6429c737mr27847304f8f.22.1776183029356;
        Tue, 14 Apr 2026 09:10:29 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac5:b0:43c:fa96:d939 with SMTP id ffacd0b85a97d-43d6429c737mr27847250f8f.22.1776183028882;
        Tue, 14 Apr 2026 09:10:28 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec090sm43035268f8f.12.2026.04.14.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:10:28 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 14 Apr 2026 18:10:23 +0200
Subject: [PATCH net v3 3/3] vsock/test: add MSG_PEEK after partial recv
 test
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix_peek-v3-3-e7daead49f83@redhat.com>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
In-Reply-To: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
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
whole buffer would cause an out-of-bounds read, that resulted in a -EFAULT.

This test does exactly this: do a partial recv on a buffer, then try to
peek the whole buffer content.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index bdb0754965df..ab387a13f0ae 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -346,6 +346,38 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 	return test_msg_peek_server(opts, false);
 }
 
+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
+{
+	unsigned char buf_normal[MSG_PEEK_BUF_LEN];
+	unsigned char buf_peek[MSG_PEEK_BUF_LEN];
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	control_writeln("SRVREADY");
+
+	/* Partial recv to advance offset within the skb */
+	recv_buf(fd, buf_normal, 1, 0, 1);
+
+	/* Ask more bytes than available */
+	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK, sizeof(buf_peek) - 1);
+
+	/* Recv rest of the data */
+	recv_buf(fd, buf_normal, sizeof(buf_normal) - 1, 0, sizeof(buf_normal) - 1);
+
+	/* Compare full peek and normal read. */
+	if (memcmp(buf_peek, buf_normal, sizeof(buf_peek) - 1)) {
+		fprintf(stderr, "Full peek data mismatch\n");
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+}
+
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
 #define SOCK_BUF_SIZE_SMALL (64 * 1024)
 #define MAX_MSG_PAGES 4
@@ -2509,6 +2541,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_tx_credit_bounds_client,
 		.run_server = test_stream_tx_credit_bounds_server,
 	},
+	{
+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
+		.run_client = test_stream_msg_peek_client,
+		.run_server = test_stream_peek_after_recv_server,
+	},
 	{},
 };
 

-- 
2.53.0

