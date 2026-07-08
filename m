Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF740586A
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506568; cv=none; b=cvs1I+y93F40ZjhrmBMHKbyleMlnbC+BVyYDHkCnTZq2TJkuHAOJ1ANENPb4mMtai9XG5G1fmi+0URmB0Yw8CzeDpqAlByMRulYYf+NYEhYp77YCq//aqlwZ0VJrCL1nGbZmW1qWYmhPboRkYqTUN/3V6QXRzQTioQzrnAxTdo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506568; c=relaxed/simple;
	bh=qNZiJSTEfc7fTVZbT1Hdz+TpSbOWakYcGAe5W8RAZ0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcF6vhQZXgniIhPSBG87+dZT8VQT+gqc6IPkvB2o/hXZhS24g2ovErxge0lNNmZNnnBPMT4JeFs7lUafZ2IInBq3FLzcTwdKj7h6Z2WbVPW2QMwl9H/ygSkVaB/4AeRFqsxzvxg9E3w5kmXgsRo2FErlF2vjlozKU379KF4sf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5XVKuon; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJ+eCHMK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5XVKuon";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJ+eCHMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783506559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s31Zp5IE8kvOUi9c30CVIvqfz2iKzORtScqC5v+Omgg=;
	b=D5XVKuonDL2mZPFyjLp/yC4T75ahSBdolgoBT78LYj7sUgdQ95GZS1OvUDC/UNMM/4BaQU
	l11XeUyyWxdtrFFAVqswwXYVZJkMsTfO55wHkRSu7+CnsWuP/FBuU+OfMbEndn+0w/LGVi
	mAnNDOkLzpJlt8Z/Cz9JycIfOpoQFDA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-NfMP6kaEOduXgdlLsXkkLg-1; Wed, 08 Jul 2026 06:29:18 -0400
X-MC-Unique: NfMP6kaEOduXgdlLsXkkLg-1
X-Mimecast-MFC-AGG-ID: NfMP6kaEOduXgdlLsXkkLg_1783506557
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-475e540a0ffso343780f8f.3
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 03:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783506557; x=1784111357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s31Zp5IE8kvOUi9c30CVIvqfz2iKzORtScqC5v+Omgg=;
        b=ZJ+eCHMK3R7j+L+r/kYfzRJdAwh3wE9G80wMTBjO0LrNgrErx1NBt0A+00cDJcr7HU
         XE8Sc/pfwxfbji9rroVv1ISaHmlGKMHZy6O//shgkDc6gkcz+QgvFqS3TX4H/vXQ31qO
         7ccy38zOdqJgdkFaqpOFlRGWBitfU8iER9FpysmarUj4AszOvkVqd2VT/dvDlMYvWPw6
         nCR+dbpxiKJVf1cRQOGEOx0VdeNh3Cq5vvtUU2NSfORPm7m3DT/MnXXY82Qw3FZ3ZZUa
         Fw5rJSNejtpbN2zTU71W122vJik+SLkZrzVEBjAGULGiNrMXBrLrMN9vrX3nOVQUlf6E
         Y2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506557; x=1784111357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s31Zp5IE8kvOUi9c30CVIvqfz2iKzORtScqC5v+Omgg=;
        b=VFm17tagKw19pPntGtTRZL7xXwlRzBnnws0zYBtFaZdo9GpmnlZeDH/VqaiYXE/VYP
         QO1Lk9kJ2IMtCtGx5F240QwYpCS7MKJhnj3Bs9z+k0G/xxbgtxEENSA5DDkqqdE2r8cf
         VOMuuCSxbrs6TjKsRD6q9Hz6v1TKCmOsS1rOaJK7X3C5DhG9VYUrHqlpiRmiXc+gzOG9
         3c639tzzJ99HdJQhsBaltugJnBJ9uIfB+uitKYjU0dQoKAjRhvDZX9k4OBH/MC0zV5wR
         AF9hqAQ+7fTkFeBW6Zl9n8wm4NwBLIAUvSZicPa7BL1UMHGWsmEkL9zskRaCCohrtfmA
         9IGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqI1lpqaA8uggS4ldH8Mw1kXW/L9UFPHgSJnySFdM9vNVwwQ4QamFBCLHQD+yusKGiGp54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/jvhz81njhQAeMHYex8bWooF5bMtZbdNRfBJObTUZ9cS3jh0l
	aBxrOyvDd3KhCc8LZYI1naQp8dQ9VJTeTsPJOsJm3ziVC5HpAWXsPgVziAYEc2xgC1dx+ykWQae
	8LG+mt+c6grOy5wOYiFtZA9RDzDco7K7vCQBAFzRQ0ZD+tMBreK/IFw==
X-Gm-Gg: AfdE7cl2esYJI7AVr5a2Cb4EfYfSz19uEu+pOcwoi1n9fervUTm4+FWSHuZinfq2Ums
	/2JDrDdweiJbDFCcYXPRAA91NJwBCDl3mgOkRp4g3n7uzWzexR1rNfEt6vjAkUsO+cpcG7FSmUY
	OSwkyfJ3K+tJT6cjBZ7xW3/cftD9oVYH5fvSiGLleOuhe6HNfEbW8jG8MA/v8ZDSZFDAF1YNfuj
	AIJ3cqINolY1oYW1wYjtW/cZaQW38aKQYue1nBdJbzWdpG+syaVR0HpTJel5brlSsekA5DaosPM
	Tlmit9U85MB4IoQNbi/cQXGIehCfWfLd644vADSEO/lbWJ9av5pk7zbOppjNfRCxvFlnzdifgxb
	903Wk6Vi4FVgAGIF5S5hu5ZMiyqtlDd4gDJq3j6TIlwgtnCo=
X-Received: by 2002:a05:6000:24ca:b0:462:e086:35f with SMTP id ffacd0b85a97d-47df0725e5cmr2146634f8f.21.1783506556911;
        Wed, 08 Jul 2026 03:29:16 -0700 (PDT)
X-Received: by 2002:a05:6000:24ca:b0:462:e086:35f with SMTP id ffacd0b85a97d-47df0725e5cmr2146583f8f.21.1783506556408;
        Wed, 08 Jul 2026 03:29:16 -0700 (PDT)
Received: from stex1 (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm40461480f8f.33.2026.07.08.03.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:29:15 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jason Wang <jasowangio@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH net v2 2/2] vsock/test: add test for small packets under pressure
Date: Wed,  8 Jul 2026 12:29:04 +0200
Message-ID: <20260708102904.50732-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708102904.50732-1-sgarzare@redhat.com>
References: <20260708102904.50732-1-sgarzare@redhat.com>
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
2.55.0

