Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A152F1FE4
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252700; cv=none; b=FqZKujmLkk+gO91/dUFWlcFSLseWbg7NdL+qiWy7PAgc4OWvpgjn71bzK9wGXWeffaSeNNPaT4+NuLOJSOGB45zXt15M6MPJM4wYya2tFNR0ZNWDE7YLdjz8VVptPhbsFsUSfr+UM1aQNCV5dni0WZEI/ifrrjrlo5UzPG7x4hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252700; c=relaxed/simple;
	bh=QLX1J418M4jWHF/CD6zKmlQZG8fsqg6qyHarNz+l24E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc9F+TNof/ZBfBXdIRxCWUtMpgw9V1RlVrB5OeBg7QJ2daPU9XR6iUu2TXivsd8lxpzPgYm0w6N7Pd0NjGQg3AbyopnIlrL2oS7njyN7OJcw7RAIwEp1a72ihji/Ldk6qPwXLdroUKUl+RMXMrkSfFFx3n5SedKFqhDc2xtpddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2nf7olA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqqrRiIa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2nf7olA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqqrRiIa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776252697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGpVm/oGR94wogmAdWmA8vqPEnCDIzFyVWrXuXhdJ4U=;
	b=f2nf7olAztvNmNsEpMWPTH46rdxshFlVR/Y+o5kEmDhoyLX72y4zAboS9xTnrvmmIskzXs
	oM32zm2lX/AIIlK8BWqOhyw8dile2uMX12GmC5mmZ/beBYxct4U8wybF2cPRcPur/42LuV
	Xc9PEypVSLKw5lxPyLsdMqhNFPHr+nI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-jM8adtNFP6ur5uetSWyn7A-1; Wed, 15 Apr 2026 07:31:36 -0400
X-MC-Unique: jM8adtNFP6ur5uetSWyn7A-1
X-Mimecast-MFC-AGG-ID: jM8adtNFP6ur5uetSWyn7A_1776252695
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43e52dc8a04so1437451f8f.3
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 04:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776252695; x=1776857495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGpVm/oGR94wogmAdWmA8vqPEnCDIzFyVWrXuXhdJ4U=;
        b=SqqrRiIacLIukQom1KZIcaycjKkh7czuM0KNoRgdqGyPlnHjHey0xkFNWmXOmv+oyo
         A3HliPYbKwFzgEe13rCbRJ20acG1J5uXPGcbE0TyQrFU2qKSE6QqG5Pq4TwLq4Yomge7
         Uuweg396a31kLXW9otPZgMY8+QKfusn1tVNV7zfld229r+ZUZ6adp0RpROUn6RuG/q90
         5FI02Jh1aq8qqGWA6zZjT7SBf3mJXTWunZj9D66vexZPunNcMlQngSuk0UCX+9qOJGry
         MeQbVNCwRD+5sA5NKbwskeLreRF2KINYiYRcTY60rG1IWqT5KuSnJiQ6H91qxhd2qAGJ
         GeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252695; x=1776857495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGpVm/oGR94wogmAdWmA8vqPEnCDIzFyVWrXuXhdJ4U=;
        b=RB4eVAJrZr0l2uu9UZkoN6gqZZ07+vdL6AErKyWm/EHwBbXh+EvqnCDawVyv/K52Sh
         VsAfksq0U2HlvTshktYlYgXDTZ0q3myTXr6kXMo+DYfvZCn2LpEtdCAacl2kMm4nk3v1
         M9VTwNPePW2e+c8+CWfD/0odu9xhZg8oqR7rGvNNt46fWXCkXwp245/qRihee2GoMKu8
         Gf4b4RbA8DCtOyFJM5zeRQUoAlSs2ztpdTSi0Y6x+oXgTzNXeVenzj+cXOG420z/EXaO
         ad89nGK2Yid+cuE72YgiTgzBMWkjE/fyvLpxbBVx0jpiSC1Xm1zgNa4WTImJEnfgQtaX
         rL4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8wTFr98XZ4Rxm9kQaTiDyUUYXE98L5uz8n3FrUfAge3QLnuIJBEw7rZo6mxXF7HHnQGwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwsktwWcoJDy8CA6GUpq2VFA/DDpnW1adk6R37SePtxDt7ppZC
	dkJUEhUkJkt+mD7OzWOAv8nUmkWrqEsLZWy8QcYgZbglOGLzeC3OqRmvw5yehPZZti/5S+rigV+
	Y158bZo2Uit/5M1K85cq8yz2gyt2jGG1rWeCliwhZLfkp08ToXtcg4A==
X-Gm-Gg: AeBDieuUZpB6ufsn7y40YrkyvcDNUvgxJ+w6dVgiOqNky7JeHieSugQ07JJQPVT9E6x
	9U24JIzBXAqY1mrjAzwqiLTneXDFrebAW6i8SsFxIjjShbG6JnRtwnA6XZNruRddn2UWCmgHgUb
	nnlpdXlLq/Q/cd9pUR5ylAbHjpWa/+oP1wYcc0BpuH2JaqkAxX04CuzG48/H51oXUlWzSM2RY3W
	p/jOlNfQIUIsLEC6+wcJ4tLOAnQFU6H0T00fRE7sWWLdFOThxfor75zELiKG8WE4cibe0u0RvAU
	rPJEjYmahKhWYe/6TuBRnalr0DDR4PtuV95i7GJp3KL/uRB7JopxVA5opwPqagCATrd4UV2MbVf
	bFb2GTbsQk7wVnOqlHDMnnulY80aJ5j0blXTQ+83l9sMf5EvLnbW8IHwuMH/gv9iEmctI4t51Zr
	ZpK4ihqg==
X-Received: by 2002:a05:600c:c108:b0:488:c282:e78c with SMTP id 5b1f17b1804b1-488d684bd3amr202998285e9.19.1776252695205;
        Wed, 15 Apr 2026 04:31:35 -0700 (PDT)
X-Received: by 2002:a05:600c:c108:b0:488:c282:e78c with SMTP id 5b1f17b1804b1-488d684bd3amr202997745e9.19.1776252694669;
        Wed, 15 Apr 2026 04:31:34 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d6e9sm4680580f8f.1.2026.04.15.04.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:31:34 -0700 (PDT)
Date: Wed, 15 Apr 2026 13:31:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] vsock/test: fix MSG_PEEK handling in
 recv_buf()
Message-ID: <ad9uYrUjgCkW1D_k@sgarzare-redhat>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
 <20260414-fix_peek-v3-2-e7daead49f83@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260414-fix_peek-v3-2-e7daead49f83@redhat.com>

On Tue, Apr 14, 2026 at 06:10:22PM +0200, Luigi Leonardi wrote:
>`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
>`recv` until all requested bytes are available or an error occurs.
>
>The problem is how it calculates the amount of bytes read: MSG_PEEK
>doesn't consume any bytes, will re-read the same bytes from the buffer
>head, so, summing the return value every time is wrong.
>
>Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if the
>requested amount is more than the bytes available, the loop will never
>terminate, because `recv` will never return EOF. For this reason we need
>to compare the amount of read bytes with the number of bytes expected.
>
>Add a check, and if the MSG_PEEK flag is present, update the counter of
>read bytes differently, and break if we read the expected amount.

nit: "..., update the counter for bytes read only after all expected
bytes have been read and break out of the loop; otherwise, try again
after a short delay to avoid consuming too many CPU cycles."

>
>This allows us to simplify the `test_stream_credit_update_test`, by
>reusing `recv_buf`, like some other tests already do.
>
>This also fixes callers that pass MSG_PEEK to recv_buf().

nit: this is implicit from the first part of the description.

>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/util.c       | 15 +++++++++++++++
> tools/testing/vsock/vsock_test.c | 13 +------------
> 2 files changed, 16 insertions(+), 12 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 1fe1338c79cd..2c9ee3210090 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -381,7 +381,13 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
> 	}
> }
>
>+#define RECV_PEEK_RETRY_USEC 10

10 usec IMO are a bit low, it could be the same order of the syscalls 
involved in the loop, I'd go to some milliseconds like we do for 
SEND_SLEEP_USEC.

>+
> /* Receive bytes in a buffer and check the return value.
>+ *
>+ * MSG_PEEK note: MSG_PEEK doesn't consume bytes from the buffer, so partial
>+ * reads cannot be summed. Instead, the function retries until recv() returns
>+ * exactly expected_ret bytes in a single call.

I'd replace with something like this:

    * When MSG_PEEK is set, recv() is retried until it returns exactly
    * expected_ret bytes. The function returns on error, EOF, or timeout
    * as usual.

Thanks,
Stefano

>  *
>  * expected_ret:
>  *  <0 Negative errno (for testing errors)
>@@ -403,6 +409,15 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
> 		if (ret <= 0)
> 			break;
>
>+		if (flags & MSG_PEEK) {
>+			if (ret == expected_ret) {
>+				nread = ret;
>+				break;
>+			}
>+			timeout_usleep(RECV_PEEK_RETRY_USEC);
>+			continue;
>+		}
>+
> 		nread += ret;
> 	} while (nread < len);
> 	timeout_end();
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 5bd20ccd9335..bdb0754965df 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1500,18 +1500,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
> 	}
>
> 	/* Wait until there will be 128KB of data in rx queue. */
>-	while (1) {
>-		ssize_t res;
>-
>-		res = recv(fd, buf, buf_size, MSG_PEEK);
>-		if (res == buf_size)
>-			break;
>-
>-		if (res <= 0) {
>-			fprintf(stderr, "unexpected 'recv()' return: %zi\n", res);
>-			exit(EXIT_FAILURE);
>-		}
>-	}
>+	recv_buf(fd, buf, buf_size, MSG_PEEK, buf_size);
>
> 	/* There is 128KB of data in the socket's rx queue, dequeue first
> 	 * 64KB, credit update is sent if 'low_rx_bytes_test' == true.
>
>-- 
>2.53.0
>

