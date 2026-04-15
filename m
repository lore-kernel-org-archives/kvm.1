Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCA3DB650
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265790; cv=none; b=PjEPSvQ8Qcr614qRlt/1VuSk5qp065Dgm47STJ68TIM8AJLlcYfvlPJfuG86ihWZoq23RWJiTzaf6P7I187FiXr+XR0jj319Ck7N5pZgfU1YZzlsuYd1CLqE6X4YejFiI1UrnQkT3EZQvOn0X6AQdjUIhabkVnH2vHC3+hYNdsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265790; c=relaxed/simple;
	bh=LicrGY4V+zsv5KZ7wlpKw3NN40iL41s8FOtyi0yIhNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBWzCvdrozjaNxYaaRoVWMq6SyLPgdk+5gJyYuwYxi5dZ1hJtfn5R5PXJQwgQgnA96isJqns8C4bLQTBRiuGnE7UZEe+VyB2podiYQFsaeACHBTiyGCpL0IxkFTB6jxtBmOzfcZmxBCjgDbVB1OM7KyO/nUypnO3bWNPAKcNQBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyXobKPU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o2A2d6F+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyXobKPU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o2A2d6F+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776265788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKxh1xV1gWd+m52UTAHmFCb6N+6HL0A4jah73SCv02s=;
	b=dyXobKPU3JTxpqO7pJAwggxD2XE52pYdqlpL/Owv/dSgfrUpZpMcKytlchoLq90+KcJ0KX
	Yxtk5Aei5dcueg9SU16tOJwg1YBEpODykIrWMyzaQEK8Zq3fUuak6ztfO9Ic4YUmjPiuGC
	iAoVgZjvv6D0kualSkVjqlM2qg9NKME=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-AzDC7D0SMdW13eXClAQj0w-1; Wed, 15 Apr 2026 11:09:47 -0400
X-MC-Unique: AzDC7D0SMdW13eXClAQj0w-1
X-Mimecast-MFC-AGG-ID: AzDC7D0SMdW13eXClAQj0w_1776265786
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d1fec59c9so3664542f8f.0
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776265786; x=1776870586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKxh1xV1gWd+m52UTAHmFCb6N+6HL0A4jah73SCv02s=;
        b=o2A2d6F+75vl5Ap9D8rf4PS4GkwQlkp8oaYJoChMnv8akyPduPm/7tFmSEBy3UgzUu
         n8YO5kpxdw9wuAAPV1UlrzOAm5s5vCcBt6QUaF4eGqVhmlu6L6to1SIXOL6BjK3U/s29
         RpuK2p4t7gEnLzB3vzZUuDd4iAK/YSm4/WDGvKkvY+tt4s7Gt10ICHp0vv7magaGi5HW
         Cb3bI48NL1+4MLNFxAOu09XejI4vkftZnaUfrxqUngI/Do4Qz9SGAtoZ9Er9yKOoorvN
         ecOXYNMICPoyLy3m5n+GTpV4c59sRT2uYtifpCSWIQHhviK9LKMD3qmmX/aXukRYEVtA
         YwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265786; x=1776870586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BKxh1xV1gWd+m52UTAHmFCb6N+6HL0A4jah73SCv02s=;
        b=N2si+sXeXVCG0W0zJt1tO/SP+EwgpBI7ktcF9Xa9Kha6fJ6AdaF2gcvEr5KH8hx/wg
         gLkuc2Fa7nEClEm9iBjwtjZSoScHWonMBhOFZaXy8AIVYtaympfJODFKxyPGtRrMtDtW
         MST8syAZK1xx8FaorEtyZ2Cz6YniGw1cMF4JUDgJspZ/xq0eKrw4Yu8JinN+LmEj408+
         iqByPWL7lEzbFTxlP7PZ7b2NKcG3FP9J8EtRBHSwilHzzHpEoIA8xLmfnXgFy2Km0gFR
         qYmDbYCSdAyjveGfy2cRQ1DXJ+LyrfTSwE/Io/KuR+oPLJTL3TLPEtqilA8JdofpvHE/
         VUMg==
X-Gm-Message-State: AOJu0Yzv9eDLmN/sb91XWElfyO6Muq+mJJ0uGnrQnIGdZ6kiZRlQmP/t
	cBboUOXVi0aiwQo5kr/QwzMxHmmswvXMUF3w+SjbzQkHAavHBID/4xw8jAHPX8jOkim8D5VWqo7
	Fbx/Ef9F14vdKHLIXRL/JpI/oMUJQ+fKFyOHWwvscWGuIFdJgFVJv8g==
X-Gm-Gg: AeBDiev6nykeiMsn8hpbveANPhPTrQV0wJyoviJc5uKx9E1/X75Y28mdwdcW6Lk7eWd
	/ZfLJAGZN+L6q3OShiHd8V9bJOX2TH3HlFeGl/6YfL8GwSYy6o5dAdLaXzGUfSq6kBFtATcSIeL
	qEYvpzL9p9u/hHzSYVMKqSVyD35otpEOK9koFLeNn37veR+5IUPvXhoKpK26m/ax6ih41AmwRGH
	O/xgnJnIc0EPOYtnyv+inFDHgv6TdwvFq8gLK9+vSP5+ZdoIqz9RU6/4UxgT44ez8hqxHkxvGAg
	7/5FsPQwEl+cIskZsE2XOLYUv9yriKa8qnl8wn2bqPK7lPZ2ZDdQZQeUV3yVd7JUPRGgKuuhI8o
	q1L7dJGIl07tGuVZ4I1hxjm/gnIkRLhEsbLXP+WDEdu0T3B4hx9lXAxQcc9Bf
X-Received: by 2002:a05:6000:2a84:b0:43d:7a5e:8162 with SMTP id ffacd0b85a97d-43d7a5e8360mr12790584f8f.15.1776265785700;
        Wed, 15 Apr 2026 08:09:45 -0700 (PDT)
X-Received: by 2002:a05:6000:2a84:b0:43d:7a5e:8162 with SMTP id ffacd0b85a97d-43d7a5e8360mr12790549f8f.15.1776265785199;
        Wed, 15 Apr 2026 08:09:45 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35bf1esm5907557f8f.16.2026.04.15.08.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:09:43 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 15 Apr 2026 17:09:30 +0200
Subject: [PATCH net v4 3/3] vsock/test: add MSG_PEEK after partial recv
 test
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-fix_peek-v4-3-8207e872759e@redhat.com>
References: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
In-Reply-To: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
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
peek the whole buffer content. The test re-uses
`test_stream_msg_peek_client()` to also cover this scenario.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index bdb0754965df..76be0e4a7f0e 100644
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
+	/* Peek with a buffer larger than the remaining data */
+	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK, sizeof(buf_peek) - 1);
+
+	/* Consume the remaining data */
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

