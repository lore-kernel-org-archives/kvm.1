Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130163ED109
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183037; cv=none; b=FCfQVPrx7CK3w0WgjtyB6edOb3CpdAw66lN0+clMBpLCpaV8WwgJ8SSVo9V8r06kpkRsr3LfZrZpSc2FErVXIxYAwZM2dW7llf9rj8r+IRWxJCgvBuAoHxUPQZKeIJHj3wFl0Kmn9rf3gifUPWe+56E1TYfEuIea2d0RGm/+GaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183037; c=relaxed/simple;
	bh=1yv4GGA0ycfjwtZCUCLrwar6tO3xyrHnQ4nzsY0/Lv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wzq7iBqoOEesfq4mZAe+k2SEjBoJcMrEGq4G9Ajfi1uP1DioCLvSoRNleX7wjshbsRNzrSaiqK6dDKoJ9hP7pZOLmhf0kwnayO4Ge2v2ZnE6cBIOc+/zJYrmPshEsUI8hzrI++0yugmyXApuz7Wvuycd+9DMHjaMqX67324p2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XrjPfHFl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Az9Z+Yj5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrjPfHFl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Az9Z+Yj5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776183035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8VspJYK7a4i3bSoWqkVfUZf2SDjKFNStSqOdJah6ic=;
	b=XrjPfHFlU5LCNAHz4WwSAHd+0UlS0RotDk6YdVdzsaB2rn/zMYRMbIKZt17/ria3khCQ9m
	NvHZCJFIUheAIYtHbPWDEUfBpT2j7n2FXoNBxYSX97HQVvqZzBZSO+gc85rHRr8xfUpER6
	iUkT+Z5rA86QuJNnq8l3CQyflRZdyJI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-giXk2w1fPxuxZ4R4NbSGrA-1; Tue, 14 Apr 2026 12:10:33 -0400
X-MC-Unique: giXk2w1fPxuxZ4R4NbSGrA-1
X-Mimecast-MFC-AGG-ID: giXk2w1fPxuxZ4R4NbSGrA_1776183029
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d744128b9so2043626f8f.0
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776183029; x=1776787829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8VspJYK7a4i3bSoWqkVfUZf2SDjKFNStSqOdJah6ic=;
        b=Az9Z+Yj5dTaAIKKfsvqbVi7utIE6oHz6SbnbI4v+6DCnEnArPneVsn4y9+afwmzg0C
         XhlVz+a6mYQt6qTgP5EVDAv6ISuknOOILGRR96134SJJ95kbqmGvM3Ok4eVjjOTgYcC3
         16edwkJA28vxqMg5GvY08ZESUyZ28eOa+U1Avvpr5N+ppe8pvOir8pR0donyAaT/8t9a
         E6SG3YxIrdHxlUCCRCHKFHFX9hsYhFMDGacv5HbgR4fB+uJN3fsm3iQs8Bc7+OozBEuU
         ORQ5IUX8Wxhg9DwMRnenpbOGJin98GzxOd06vKDnaESMHflejwCWu2JJQD1ZQS3X/yLJ
         uvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183029; x=1776787829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O8VspJYK7a4i3bSoWqkVfUZf2SDjKFNStSqOdJah6ic=;
        b=eHGa8ekpeCnoWNalSBXiLF4jtDRQkblbbT3/IvAVk6c8R4sfvCRUmXQaSy0eM1cpGf
         Ff8PWUpX2nmDEOk9SLShyYwZzNrcTfET82OlZUr3+pDMOCEe5gu3S9FVnB2Jv///TcKQ
         hlGg6OTevsreYUcDknWxFvkyWIetRQ1vbcop4zq9ua2qlbAK2aFFVsy41ORBHiO1uuL6
         iUwCBknq6o9kIE6kCLIMLAr4iejoewf+mnEwrXvIzTsfR7ZEVxahRYy85TII2SRhRvor
         Jf8AjMgWZnBb22H8IiwFix7VXg0Z9/0X4AqLlS2Nf4WALTRJUK39BYu8uRVmFx2JAyRm
         15LQ==
X-Gm-Message-State: AOJu0YyQI/GgCKw3tPcvjAs7jGRFvrRzzOnQx3ffRQ+swKP1VlH50vsv
	qutSAvzaspAnOD4pZgOIwteOKdg/1O+GBfV2HtDG/u8g01aIiV1KYE/73TPa1K3kgMHdzBh79aN
	QiWXFbWnq07Mqn6ed6RipIXrL/se18AiDb82sSYBEVLJT4JKA9aE2eQ==
X-Gm-Gg: AeBDies5PAEjUccxpEqwU84XXQGoD/TDsm+kHP6UTOu6M24z1ZJ3ocIiJY54DVIgNlu
	zjCwHjl9ijHdfS4gFcP5UKffKO4OFQTRl1ROyZSSvwRgwsktNc/B68WZlxblPSluPNAvW9ghmRa
	8BSxNIwxcQeBXI8F+DZ7cqTDNueouTvtSUKAyXRcDJ04AOdqBMtNpzHJGqpJX4DCUfapd5c53Gz
	EIsE7oazPpa4WVTdupsxetbQpuJvJAdvZA+TrAFOE4OQWK3a0Th8zo3dclFa6MVCDx8Yv1rd3fn
	LS2rmoQPJk31Xe005QAiM36vXQEJ0pvwuEoJ2oLW7SxWP+PMeNAVQ+RlcTInxSCBDUwTvtS9zFB
	1s0P8cicDO21TbSj6alWoSXzLWcQ1maF3OQZQT5ip5qNK4T2ue7Ij4Q+q3CC5
X-Received: by 2002:a05:6000:230d:b0:439:bcc2:bf0a with SMTP id ffacd0b85a97d-43d642b8d4cmr26748896f8f.23.1776183028092;
        Tue, 14 Apr 2026 09:10:28 -0700 (PDT)
X-Received: by 2002:a05:6000:230d:b0:439:bcc2:bf0a with SMTP id ffacd0b85a97d-43d642b8d4cmr26748793f8f.23.1776183027431;
        Tue, 14 Apr 2026 09:10:27 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec090sm43035268f8f.12.2026.04.14.09.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:10:26 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 14 Apr 2026 18:10:22 +0200
Subject: [PATCH net v3 2/3] vsock/test: fix MSG_PEEK handling in recv_buf()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix_peek-v3-2-e7daead49f83@redhat.com>
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
reusing `recv_buf`, like some other tests already do.

This also fixes callers that pass MSG_PEEK to recv_buf().

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/util.c       | 15 +++++++++++++++
 tools/testing/vsock/vsock_test.c | 13 +------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 1fe1338c79cd..2c9ee3210090 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -381,7 +381,13 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
 	}
 }
 
+#define RECV_PEEK_RETRY_USEC 10
+
 /* Receive bytes in a buffer and check the return value.
+ *
+ * MSG_PEEK note: MSG_PEEK doesn't consume bytes from the buffer, so partial
+ * reads cannot be summed. Instead, the function retries until recv() returns
+ * exactly expected_ret bytes in a single call.
  *
  * expected_ret:
  *  <0 Negative errno (for testing errors)
@@ -403,6 +409,15 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
 		if (ret <= 0)
 			break;
 
+		if (flags & MSG_PEEK) {
+			if (ret == expected_ret) {
+				nread = ret;
+				break;
+			}
+			timeout_usleep(RECV_PEEK_RETRY_USEC);
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

