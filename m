Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A83A0B20
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553249; cv=none; b=Jkt0X9XWqDpkR2qp94AyUZWGt6PA8coY3ioAPgXvKCf5M31T9108pVw++KO2OauC3PH2re8qSUe5OddsG1tVNHTNsxqSuZe4s0/VvtSqase3EplqKOpAie+dfeoh3/oCG1ZhPPWAg8Sivou0HkvhD6Ngn2nGolvCdNxKYfXo+/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553249; c=relaxed/simple;
	bh=TPyeaXldjZ/vNi3cTj7MlzLbGl/Ixp9Pbj/uTFr2sk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AXq3ex3FBQDJ6XKZw1Eym2Nyj32bXVSSMbH0cIZQzdeGWwSg28w5EHyNwASMuwDGmmX5PpaG8LHn2qihs1cxjrHEma3HjJKzDx+z4XbcEakX2Z6kCqOivykXRN/VPzytXhjIVpdvG+9p/rbzXXE3Ny/2zPQZh9Rpua3MqZPINhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkbVsg/B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7rymZQj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkbVsg/B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7rymZQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775553246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MvBSgtjWIPj7YtiYQ1QdgeAu7KbULO0Duu0OFbmnZU=;
	b=KkbVsg/BGk866pUFTw9KdxzP4cD33xxofsxI9lrn/ZVUajcXinvur++vXHX/juRUjYVK0+
	qgklgVujHGH7+HbkWq43bxDoSNMiwoHXY14gLZGJHxyVz8JNAz/D8E5bAb4N2gU0/LMzif
	fOez/lc2kGYV9QY8JjS4k8ldLZDID0o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-p0VyO-FqOPOF9AsQ2xsT_Q-1; Tue, 07 Apr 2026 05:14:05 -0400
X-MC-Unique: p0VyO-FqOPOF9AsQ2xsT_Q-1
X-Mimecast-MFC-AGG-ID: p0VyO-FqOPOF9AsQ2xsT_Q_1775553244
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cfbe041b2so4029196f8f.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 02:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775553244; x=1776158044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MvBSgtjWIPj7YtiYQ1QdgeAu7KbULO0Duu0OFbmnZU=;
        b=X7rymZQjmzMh+azmi4F5vc6e4635bgO7zxenf3Ts58RlzGBol7OgBILGGoGrjqWLlV
         m903/w/68zYOC4RU8j0lfYgqPUnGCIybxmdsKZY1bl4qLK3chXEAqdk2/X477IZnS+Og
         ExaLcvO8n5dzBabvo/YAZO5lj3/KFjnmwvHd7qTEfu/cr16WjQSbSz3F+W6z8iE8znVE
         64MCoKWscpO5W7836p7DMMLMu0IttuCKCkJXAfm6zbhB2WJF2AsQezJf+KigvvfOqKY5
         HE2Gj3yjMByuEn9O6Q0Bd0kP5yruq1NW5FSHtOhx4McPfcupv9akLzXQyG0HGYJKf92C
         ROVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553244; x=1776158044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5MvBSgtjWIPj7YtiYQ1QdgeAu7KbULO0Duu0OFbmnZU=;
        b=USEvLpxOUMVUaao1WFwVeB6id8dZatL4i7v54aA0Mzfua4t84nrLKBGCloUwTc3toX
         8D4cThLdOGFupgtBzwYIrgaS+51FHhpbKHrHIa93dzSo3k92APU9BZ3CcKKxNj1kco0H
         Zw5idjHV0QO617p6tabu17/5fCa3mN1GupABraeigjno0mr8Xr4eHs//r2jM3q7qgcky
         hr0diWO+v+Oc4pv42Oy4hrVfqJWhHGLnVCMMKi1TWvqFs68x2kD45u10StMSF2KYiMx/
         3HUKBo8l2jdMPD8abzePGKSkjGWUN2jJyGQnnaJowxVmUJrfAzNszbys1YSyIq74nIfD
         oqqw==
X-Gm-Message-State: AOJu0Yy1ZHNJKsa/2TtMsk/ORdZnDNLRm1tQCa5OhkT2cgIKhFp/GLHv
	n+bwS1PuRILDappqOT8QKKDjg+MytqopYVbSITQIhwfO+X2AdMK4VsinHZcy+shvIj/DK7NcHg2
	MYm+35X8vqT8lHErx6S7efOhCpKrrG68A730Hbvha0sS0Gjkq4RU42Q==
X-Gm-Gg: AeBDietucAe/KkB7Lya6HoXrU7UP22sulCcg+/Y2WZ5grfE5pAViCt35R7yvssg1NXN
	9Jzat8PoSRfvuz/zXeZsnMH+tPUwvbWQFje5Sw12Ke9QhQxl6Ydsb1peUNth8i80WX1EmpEhI68
	hRt8QkNIAPEUBA0IZBXjmIqo54WM09pTzg2ZQTUBdhSMfGy8L6kHnnKbH0CCyJJeEpGSdfYm5yU
	Td1BMjXFylWi0Sw4LjvAmEHdMIcRbP/gPlFAk48k8PHOvMKEav2a5BHRrangpYKNjxzVyb23bPT
	bI7TtgzXrCqp6mRKh5jz1q5CLB8NzcKn+zKv1UoYsrjoD6Z+XkcTaCzQXhYqlIo6ORVRBmS18ag
	OjXlbYc6H/3Tglx7GGy9MnCN48OEkf4RG8o2D28q4oCxKkYLzmdfE/k3s66Cm
X-Received: by 2002:a05:600c:620d:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-4889945faa5mr212240075e9.1.1775553244225;
        Tue, 07 Apr 2026 02:14:04 -0700 (PDT)
X-Received: by 2002:a05:600c:620d:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-4889945faa5mr212239435e9.1.1775553243640;
        Tue, 07 Apr 2026 02:14:03 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm342892015e9.8.2026.04.07.02.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:14:03 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 07 Apr 2026 11:13:56 +0200
Subject: [PATCH net v2 2/3] vsock/test: handle MSG_PEEK in `recv_buf`
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-fix_peek-v2-2-2e2581dc8b7c@redhat.com>
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

`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
`recv` until all requested bytes are available or an error occurs.

The problem is how it calculates the amount of bytes read: MSG_PEEK
doesn't consume any bytes, will re-read the same bytes from the buffer
head, so, summing the return value every time is wrong.

Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if the
requested amount is more than the bytes available, the loop will never
terminate, because `recv` will never return EOF. For this reason we need
to compare the amount of read bytes with the number of bytes expected.

Add a check, and if the MSG_PEEK flag is present, update the counter of
read bytes differently, and break if we read the expected amount.

This allows us to simplify the `test_stream_credit_update_test`, by
reusing `recv_buf`.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/util.c       |  8 ++++++++
 tools/testing/vsock/vsock_test.c | 13 +------------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 9430ef5b8bc3..f12425ca99ed 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -399,6 +399,14 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
 		if (ret == 0 || (ret < 0 && errno != EINTR))
 			break;
 
+		if (flags & MSG_PEEK) {
+			if (ret == expected_ret) {
+				nread = ret;
+				break;
+			}
+			continue;
+		}
+
 		nread += ret;
 	} while (nread < len);
 	timeout_end();
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 5bd20ccd9335..bdb0754965df 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1500,18 +1500,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 	}
 
 	/* Wait until there will be 128KB of data in rx queue. */
-	while (1) {
-		ssize_t res;
-
-		res = recv(fd, buf, buf_size, MSG_PEEK);
-		if (res == buf_size)
-			break;
-
-		if (res <= 0) {
-			fprintf(stderr, "unexpected 'recv()' return: %zi\n", res);
-			exit(EXIT_FAILURE);
-		}
-	}
+	recv_buf(fd, buf, buf_size, MSG_PEEK, buf_size);
 
 	/* There is 128KB of data in the socket's rx queue, dequeue first
 	 * 64KB, credit update is sent if 'low_rx_bytes_test' == true.

-- 
2.53.0

