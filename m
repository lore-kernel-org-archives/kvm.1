Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3494C3264EA
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776254098; cv=none; b=R2WikbZucMOiwwMMsM5N9daYK0138sJeMh2VXF/IzmAFInkwBj6y3UKwUdXInxCHruXjAxGZq0XgrdfamGDj8L1AEKQoIAtvf00OdyfP2JVneEAyuMfHvGnJtff63WwpdlTGXKcE1WsXd6PnKsstjvk/kvMFikYjJakA5SsFaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776254098; c=relaxed/simple;
	bh=IhundK6gvmdpIbwTKJkzDNzcKDA2uur/VnVrMcwemEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLy/ww0xkGZybdtUaacxFMI2tzDy+qnKao07XaXW/u2hS97Et0xU1ZaDnCU5KSQzIfZdVh4CQVq4NTxDlXi9UlGB7zlsZCCAxBGCtA4YCnl7llCANjAQOokAhp1WJuceTxKl4Hd++025LG6aMSC1Kfs4xe7sQFjp1A8l/KnNEhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNJeWyvg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=POQMktme; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNJeWyvg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="POQMktme"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776254095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unpQFuqYzr7/sma4T2UOR9+jmvcvHr7lpkU7c0Dl/SQ=;
	b=TNJeWyvgXt47PAoVCZ26U/ITKYba1KnuvK4JL98UQiI5UPgUM0EHGK+SLn9z0Tyi59B2FX
	yR03GMnGv8PQAm7vz0QUsOiE/8qWuxY1Szgb5BjHFK6fNzDclkKXOxjnOd4ndmLg6Aq1m9
	StCUXHPkc2huYELElYdQsjtcr82eEVE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-AFIoyP_LNkq_6_A4B_qvZw-1; Wed, 15 Apr 2026 07:54:54 -0400
X-MC-Unique: AFIoyP_LNkq_6_A4B_qvZw-1
X-Mimecast-MFC-AGG-ID: AFIoyP_LNkq_6_A4B_qvZw_1776254093
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488bd1ee9e7so40704315e9.1
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 04:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776254093; x=1776858893; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=unpQFuqYzr7/sma4T2UOR9+jmvcvHr7lpkU7c0Dl/SQ=;
        b=POQMktmeR77UJQ5tzSfoHErVyKUoI0Mk/GBD6UxFQsCwZE1d6tNYfkzpQDVcumcwWA
         ZqrhPr4mh9lruF9OO6LCzD3iH9Kb12ASWS+i66wPZbAmjulW1T/J8A7KCCTv1WnspXci
         hGhH5NIxbOQLEmCm9FFdkwJPGOHz2z7LAE/ttDJWI8zA0FCo45i6NqocTBQQHimtfUY3
         a/7q0SbOvTGrXGJWgvWAGuIk5+8UhwUCJ6XSJKu2AbrJQy7pUBVglx6fQI0H4IMvONbv
         iGcfIXSKhRurFm4LY44ssk20XdVqmEQUWPhIlBGdVYPcLWxBxWuecowZ/hut2Rv6TS4Q
         08xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776254093; x=1776858893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unpQFuqYzr7/sma4T2UOR9+jmvcvHr7lpkU7c0Dl/SQ=;
        b=iUzU7B7G3CNsrJFb1UPXBHjz5Yi33l11RBSj+eWvisET1TQjMGHVGdj0i3yAGQfY//
         7YCiEw80lQ34YbQSFhPKGiDYQnCroHQUEh70OnZZOCOVUw+xoWWqtnAsZAtkRiRt5XPu
         dYPK6cOx88GqFom+bO2BSB6aaS32HqOe2BEuTTvWUnEwc1g+JaCZVEZjeB9oyt0bHPRz
         3NEumB/aVXT7SivtjqjAvFujf3H/Vni2vNMDe/Z13C6sGEgasTqFN/2iwDpa+KlCoEop
         BHZD5mxwc3t9GgSKFNW/CEQpuuSMcHZTMW+gH8o6//YrfgKOABdJopI5C6K1R2oNJC3b
         6DIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZOwZgR3FUm+xoZpqf5OokQJ4sKWhyToL53LhRNLTq0AXKTznbfZEGa8tCleq6ILxBp2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjc91Eb4rFnfuTeswN1QBaAw7J3I06Uo/vksfaeBbYZB3DLnKd
	wP18hErwYd1LBuEiWKDj2N63j6wTHbw3VjnZv6/4iL6WpYGvQ0iCDBM2w2/WQPRW5rqEkQ6Vmwk
	wd1NOtlRo+QYtjIRyabwLGkbo6ISycH3ColJpuT+nxtrYRCEvw89Qhg==
X-Gm-Gg: AeBDieuvuw9v1H08SvsKjZZ2kZnum3229obCzzkaY1M/X4gSfCjlwanpNJpKk5dy2Yu
	ddsWD5i/pebeYPfKUJpWzF1U0X9ch+jh5+2nSSryyVsVQRCSmdRR3lJ9wY0NiOpsZi5zeJ2xNDa
	I/bOhEcRqufKhTMNzVSNDJaGHIw5SfsOCXsSEUqmqIb+QQKu7gz/REY8BVNO5qHfwrTEp951dny
	yWEYwlYVEwHpg/bwvKGYF3XQz2XHWwrmtk8jF3AE5EMH3Mr8j84yvH8rilnQRo96dgTnOKJqDKD
	HInFJzNQ7t2etfGv7E9tH6sj95IlqaqXigORDg613VP9KnW6TweZ+vL15RnO7nv4/6Pp9sj42wO
	ltpfmRseJos9UrPtkkXJPLnVxkQpNonxcYEmloBraXRYYzUI8iUrDkPS5JkwPAt8Vutumkz92zS
	ZCQ/zTrQ==
X-Received: by 2002:a05:600c:64cd:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488d67df592mr301858525e9.2.1776254092782;
        Wed, 15 Apr 2026 04:54:52 -0700 (PDT)
X-Received: by 2002:a05:600c:64cd:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488d67df592mr301858195e9.2.1776254092308;
        Wed, 15 Apr 2026 04:54:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee038752sm128635425e9.9.2026.04.15.04.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:54:51 -0700 (PDT)
Date: Wed, 15 Apr 2026 13:54:43 +0200
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
Message-ID: <ad96TgXHW_jKitls@sgarzare-redhat>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
 <20260414-fix_peek-v3-2-e7daead49f83@redhat.com>
 <ad9uYrUjgCkW1D_k@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad9uYrUjgCkW1D_k@sgarzare-redhat>

On Wed, Apr 15, 2026 at 01:31:11PM +0200, Stefano Garzarella wrote:
>On Tue, Apr 14, 2026 at 06:10:22PM +0200, Luigi Leonardi wrote:
>>`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
>>`recv` until all requested bytes are available or an error occurs.
>>
>>The problem is how it calculates the amount of bytes read: MSG_PEEK
>>doesn't consume any bytes, will re-read the same bytes from the buffer
>>head, so, summing the return value every time is wrong.
>>
>>Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if the
>>requested amount is more than the bytes available, the loop will never
>>terminate, because `recv` will never return EOF. For this reason we need
>>to compare the amount of read bytes with the number of bytes expected.
>>
>>Add a check, and if the MSG_PEEK flag is present, update the counter of
>>read bytes differently, and break if we read the expected amount.
>
>nit: "..., update the counter for bytes read only after all expected
>bytes have been read and break out of the loop; otherwise, try again
>after a short delay to avoid consuming too many CPU cycles."
>
>>
>>This allows us to simplify the `test_stream_credit_update_test`, by
>>reusing `recv_buf`, like some other tests already do.
>>
>>This also fixes callers that pass MSG_PEEK to recv_buf().
>
>nit: this is implicit from the first part of the description.
>
>>
>>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>---
>>tools/testing/vsock/util.c       | 15 +++++++++++++++
>>tools/testing/vsock/vsock_test.c | 13 +------------
>>2 files changed, 16 insertions(+), 12 deletions(-)
>>
>>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>>index 1fe1338c79cd..2c9ee3210090 100644
>>--- a/tools/testing/vsock/util.c
>>+++ b/tools/testing/vsock/util.c
>>@@ -381,7 +381,13 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
>>	}
>>}
>>
>>+#define RECV_PEEK_RETRY_USEC 10
>
>10 usec IMO are a bit low, it could be the same order of the syscalls 
>involved in the loop, I'd go to some milliseconds like we do for 
>SEND_SLEEP_USEC.
>
>>+
>>/* Receive bytes in a buffer and check the return value.
>>+ *
>>+ * MSG_PEEK note: MSG_PEEK doesn't consume bytes from the buffer, so partial
>>+ * reads cannot be summed. Instead, the function retries until recv() returns
>>+ * exactly expected_ret bytes in a single call.
>
>I'd replace with something like this:
>
>   * When MSG_PEEK is set, recv() is retried until it returns exactly
>   * expected_ret bytes. The function returns on error, EOF, or timeout
>   * as usual.
>
>Thanks,
>Stefano
>
>> *
>> * expected_ret:
>> *  <0 Negative errno (for testing errors)
>>@@ -403,6 +409,15 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
>>		if (ret <= 0)
>>			break;
>>
>>+		if (flags & MSG_PEEK) {
>>+			if (ret == expected_ret) {

On second thought, I think it would be more appropriate to check for
`ret >= expected_ret` here, because all subsequent recv() will
definitely return more bytes, so there’s no point in continuing the
loop... and anyway, we’ll check the result later, so just that change
should be fine.

And of course I'd update the comment on top in this way:

    * When MSG_PEEK is set, recv() is retried until it returns at least
    * expected_ret bytes. The function returns on error, EOF, or timeout
    * as usual.

Thanks,
Stefano

>>+				nread = ret;
>>+				break;
>>+			}
>>+			timeout_usleep(RECV_PEEK_RETRY_USEC);
>>+			continue;
>>+		}
>>+
>>		nread += ret;
>>	} while (nread < len);
>>	timeout_end();
>>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>index 5bd20ccd9335..bdb0754965df 100644
>>--- a/tools/testing/vsock/vsock_test.c
>>+++ b/tools/testing/vsock/vsock_test.c
>>@@ -1500,18 +1500,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
>>	}
>>
>>	/* Wait until there will be 128KB of data in rx queue. */
>>-	while (1) {
>>-		ssize_t res;
>>-
>>-		res = recv(fd, buf, buf_size, MSG_PEEK);
>>-		if (res == buf_size)
>>-			break;
>>-
>>-		if (res <= 0) {
>>-			fprintf(stderr, "unexpected 'recv()' return: %zi\n", res);
>>-			exit(EXIT_FAILURE);
>>-		}
>>-	}
>>+	recv_buf(fd, buf, buf_size, MSG_PEEK, buf_size);
>>
>>	/* There is 128KB of data in the socket's rx queue, dequeue first
>>	 * 64KB, credit update is sent if 'low_rx_bytes_test' == true.
>>
>>-- 
>>2.53.0
>>

