Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E69F3F7A98
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481720; cv=none; b=e2832i9V0oY8XUX3/HwlveBH/4Fx9LGdk+l9fa1m6+JXk/Pmx9hQ2Y2a/m6Hyjsu55If1/L6ZkMRDVUFEjLw6sf210cE5Is82wCYOPF8mLfIArV4NBSI5KFhdissfkX9BIzWRTHEYPGxuv0p9RiYX3/k9pEXibjtM20FbYctbaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481720; c=relaxed/simple;
	bh=h6wI67WE4wGINnOp1v4qFtLNzEeCT9OncC/LXQiBsJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bej9EaroZ9arieE0eISLPan5fIA3+GN5gOjKByqpfxnQt/7gHMgHL7gGenE3v34I/+AxDCBbiq36Bvr2B0/JURNpDttxCnthnA8Uzj9UJ9zyQNn/eRDe/gVhTLCHGCzy/It+4CPCrw05/HOl2FqJQun+y4RqyywPcU/7DKnlWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8WMcu1G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNp0OsRj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8WMcu1G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNp0OsRj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782481718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+x55wPutcqcllhjFEZvXEglHQBic+9gv93y+ngfVIU=;
	b=Z8WMcu1G00ziXPxDt5oL2HnBrHNr56fg6wwVCHe3fNtnX53iw120nHUmFx63C8no6+kbcu
	d0lpW6HOzGNyoVgo3t416P+D5PvbkIBO6NorSXpLeCNU2vATb3A6prZ+1BLg7OMGx0CFuq
	JzGb7HRsAOnXdTKgADGtk3FyLWiILdI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-pK7dOgY5PoeM79Lgu7DCBw-1; Fri, 26 Jun 2026 09:48:37 -0400
X-MC-Unique: pK7dOgY5PoeM79Lgu7DCBw-1
X-Mimecast-MFC-AGG-ID: pK7dOgY5PoeM79Lgu7DCBw_1782481716
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-469218e618dso469952f8f.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782481716; x=1783086516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+x55wPutcqcllhjFEZvXEglHQBic+9gv93y+ngfVIU=;
        b=DNp0OsRj3dogNcEviKvO2X5Zt+4Q5Jib1FpAtArSbEJycG7k3zNDdJts+Firx1yphb
         lJZfnjYprRWBCTT70Epmm+zEefLSVKy4jRsmAR0d6nfZaFfNDbiHfvT5+AXR/EvBod0C
         VLYjen95C7Zf5o/t4zhGJnObwUQ1B2HlEON4VpCSvFoSHvj319Gi5PLTlWCteCpKhpeu
         psH12XqOXkbnN9dEBJ8WFt6kNQzjLViG3UrLT0QRdlGsiHRvYhIDH7yNJWKXvxf1vWvM
         Sh7qfnrOWuXWbyYcj6GceK/09Wia8Zu4ZWXY40SBAqAC7/Vgyy13tbrptl57Pw4BO74C
         T3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481716; x=1783086516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F+x55wPutcqcllhjFEZvXEglHQBic+9gv93y+ngfVIU=;
        b=GBdwHVDP5pJanDYe2rqAelkT3YHgJjJKD5KE0qlxz5/dbcyrXa42C4WuqJExTYZxxs
         9dG+oyOjQpafKnY//7/JqACKEAhTqc8x8XV2nymZtkMZ6MkelWJ18eCDPcZG9qEZ3+4g
         JD9VZRGMqY6KPCIFxBwcBqAteERt0WQTBz7XRmfnlEsCmeozNNGMM9OpaSGVCZ2x48SK
         bPb2nT0AAlOqNHSKvFr3OHZEeucH48ty6epg63Acsl2AhS1YbTlScbFMJSwE3cyRmAli
         mA7g9KJuUlLn3q7tFaoRTqge8ntZOAOoL5X+zSb8yn9wX+ow0ew+Brxoy6Bz3jsZbgf9
         MrWA==
X-Forwarded-Encrypted: i=1; AFNElJ8dhdrKDuIkkqPW1XecF3+00l4xuRZ1TWgVEyQIylkarY6UcHtoCOE/FWQv/HwRLAZrfOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ughwrrEfb1GbSlRQ0F2n3hLJGMhMQgLMw3NQyWRyek6hd1Hf
	MOX9AqQgBOJ3/CCbPgyAXoXyNL08Ytb5CQA67WOTjQ0aCG7AVO5OfkK0fShJeDtYSbF7O5ZnGMZ
	Zc2up4QCw6oT/aGtTGQrrtvEaSChOnbrGp+ickKWjIs8ZgbYsfHb4dPUoY/gArg==
X-Gm-Gg: AfdE7clLMJFuBecKYL5xj2v9ymCVZK2b8tcc663msSPiWdRJwnvS3C1FsICHL91OIiD
	amizG95gJmBXDj93waRB07bdIiVrQB+dOr97HKFqPK8nTadRa2+UWxo2Eue+1WDa4k19ikIHm7l
	18SP4p4WcqCFsizOT1K5/+4qj8jJ64l+HAVbEsI59hrcAhzsRemoCKRXxNGMl7qTl3qo59glGfN
	eSpszz3LLbx+Bjn1p9TbSemppux5gD/rJZiEZ1yj+zQ46aGdqQiOYMA11R/SAN5I3ZmaqrIm7Xu
	EcwSZ2/1F4N284QEQyj61T0VOZ1TKwlfeC2tPzOr3JhSSud5VsulFtVpluUMbrz/FNt3DWVJJYY
	Lvdh6eFTFJMmArWqaAI2jfcTMbpYSHRuDPSs4qurwMRQG2Ps=
X-Received: by 2002:a05:600c:1383:b0:492:46c3:c7dc with SMTP id 5b1f17b1804b1-4926fc3a838mr14856375e9.14.1782481715877;
        Fri, 26 Jun 2026 06:48:35 -0700 (PDT)
X-Received: by 2002:a05:600c:1383:b0:492:46c3:c7dc with SMTP id 5b1f17b1804b1-4926fc3a838mr14855905e9.14.1782481715451;
        Fri, 26 Jun 2026 06:48:35 -0700 (PDT)
Received: from stex1 (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46dcbac0c9dsm15336242f8f.19.2026.06.26.06.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:34 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net 2/2] vsock/test: add test for small packets under pressure
Date: Fri, 26 Jun 2026 15:48:23 +0200
Message-ID: <20260626134823.206676-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626134823.206676-1-sgarzare@redhat.com>
References: <20260626134823.206676-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

Add a test that sends 2 MB of data using randomly sized small packets
(129-512 bytes) over a SOCK_STREAM connection. Packets above
GOOD_COPY_LEN (128) bypass the in-place coalescing in recv_enqueue(),
forcing each one into its own skb.

Without receive queue collapsing, the per-skb overhead eventually
exceeds buf_alloc and the connection is reset. The test verifies
that all data arrives and that content integrity is preserved.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 87 ++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 76be0e4a7f0e..b4ff9f946565 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -2347,6 +2347,88 @@ static void test_stream_tx_credit_bounds_server(const struct test_opts *opts)
 	close(fd);
 }
 
+/* Test that many small packets don't cause a connection reset under pressure
+ * and that data integrity is preserved.  Packet sizes vary randomly between
+ * 129 and 512 bytes, above GOOD_COPY_LEN (128) to bypass in-place coalescing
+ * in recv_enqueue, forcing each one into its own skb.  Without receive queue
+ * collapsing, the per-skb overhead eventually exceeds buf_alloc and the
+ * connection is reset.
+ */
+#define COLLAPSE_PKT_MIN 129
+#define COLLAPSE_PKT_MAX 512
+#define COLLAPSE_TOTAL (2 * 1024 * 1024)
+
+static void test_stream_collapse_client(const struct test_opts *opts)
+{
+	unsigned char *data;
+	unsigned long hash;
+	size_t offset = 0;
+	int i, fd;
+
+	data = malloc(COLLAPSE_TOTAL);
+	if (!data) {
+		perror("malloc");
+		exit(EXIT_FAILURE);
+	}
+
+	for (i = 0; i < COLLAPSE_TOTAL; i++)
+		data[i] = rand() & 0xff;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	while (offset < COLLAPSE_TOTAL) {
+		size_t pkt_size = COLLAPSE_PKT_MIN +
+			rand() % (COLLAPSE_PKT_MAX - COLLAPSE_PKT_MIN + 1);
+
+		pkt_size = min(pkt_size, COLLAPSE_TOTAL - offset);
+
+		send_buf(fd, data + offset, pkt_size, 0, pkt_size);
+		offset += pkt_size;
+	}
+
+	hash = hash_djb2(data, COLLAPSE_TOTAL);
+	control_writeulong(hash);
+
+	free(data);
+	close(fd);
+}
+
+static void test_stream_collapse_server(const struct test_opts *opts)
+{
+	unsigned long hash, remote_hash;
+	unsigned char *data;
+	int fd;
+
+	data = malloc(COLLAPSE_TOTAL);
+	if (!data) {
+		perror("malloc");
+		exit(EXIT_FAILURE);
+	}
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	recv_buf(fd, data, COLLAPSE_TOTAL, 0, COLLAPSE_TOTAL);
+
+	hash = hash_djb2(data, COLLAPSE_TOTAL);
+	remote_hash = control_readulong();
+	if (hash != remote_hash) {
+		fprintf(stderr, "hash mismatch: local %lu remote %lu\n",
+			hash, remote_hash);
+		exit(EXIT_FAILURE);
+	}
+
+	free(data);
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -2546,6 +2628,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_msg_peek_client,
 		.run_server = test_stream_peek_after_recv_server,
 	},
+	{
+		.name = "SOCK_STREAM small packets backpressure",
+		.run_client = test_stream_collapse_client,
+		.run_server = test_stream_collapse_server,
+	},
 	{},
 };
 
-- 
2.54.0

