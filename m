Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4068D3B27FF
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643496; cv=none; b=jNkx5Bzj8Bu0ii2tY9I29+JrGzw5SnBZtZyi3gX15Z1rSFKBQs1MKv5+K2HeNzN3BYSSpTca1TVYnLcA7wIpGFZpQweLhC9mzx9Ze2y0KXo1FkQe8uirAo582gql5t0uz8XTkca8KqiO5qSc2jUIdjhvkJ5AMp7YAJaqTuH+Ocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643496; c=relaxed/simple;
	bh=6xSUwHLjkibUmQWK2HeD5Idw7sBp7VhBE/kVSPW3QPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esFtqjs/gwko1oV0dslyUd3Ygk9M/Vnf8f6jiIFzfzKIenRZtfl8al7I71DVvYxRKMHjyIOzjJUyVAaIonGBHxY7U9tECBryff+yTkppHVNLo9sqwmUJ3Qhu7iBiZEaMq4kdnPw+0Qxo3ZS76nl+TFaXk6F/qkYV8Yy93CgIy/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPw6BsiC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rXAAA3bs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPw6BsiC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rXAAA3bs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775643489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfb2nFt+DWPOPwjJLlcYgP+BepPoSw8wC9wFBQagHJw=;
	b=HPw6BsiCL3JuCDoNCEKyxxqaZUNF6TEOKP0b4TbfVAE3ciHgma2AfRtQSXxCE56UwlyVB3
	g7m8nFndJ2B4izprEmLBM+QSA3BK02EKCfaSj8WjeXBnGhBtq4inzWsiUTp/Zv1xx6mtRN
	8Qy9UeUWa1i4p+aY2xDELqIeQjRP2Mc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-HPiSWiB0PW2KP2H2tzwkGg-1; Wed, 08 Apr 2026 06:18:08 -0400
X-MC-Unique: HPiSWiB0PW2KP2H2tzwkGg-1
X-Mimecast-MFC-AGG-ID: HPiSWiB0PW2KP2H2tzwkGg_1775643487
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488ac1434f0so20388435e9.2
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775643487; x=1776248287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfb2nFt+DWPOPwjJLlcYgP+BepPoSw8wC9wFBQagHJw=;
        b=rXAAA3bsiaRt3mvZCAWgOOBUKm+GB8C3WGb+FIQ/AG9adI50ax4uxohvRk/ymY28rW
         8uxXjISrwJqJS/gGcgtvwbwQJ1P5mG/nFNc9dcUsUSYNlzMjRVeZtuosR4auS1KgjZiL
         9mvZVDyAZ0OHqqElGF5qUo3W++2XU3au95NjPIC4yUW164q8hr5YyJZlPfU4VYI/XMJp
         bu0fjNJWEQtUdwCaWkvJJKfD2OstpTfj4ZNe0jphzk0kcDmkLPuDQJChQBDKXiGS14Fb
         7URjXpV7oBIbZM2vTI2+mUe0mxhvTc1010viXRuB9Qrp4Z3uJSRIgp20eN0PyCVhzCn+
         Le+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775643487; x=1776248287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfb2nFt+DWPOPwjJLlcYgP+BepPoSw8wC9wFBQagHJw=;
        b=NPzGHodex2gfv9CcWm08qNEDx7FwL7+cGihDXUaTUnc7jaF6EdSSi6pliBL4vcIQc4
         KJ9MEAg430FSgH04fka9DP9pQMr/7F7WlW0C+J4cC5bFwpOdGDh6izbZ1xTvtWKKs2mP
         2iWjTWHdK2we2kla6dpl3VnLrTYNbBuXUjSY13ZICOojlrqrW5zyH/8CIf4qlZ9SST6i
         iijFD3yeXNsxVH6UtMEdtlgM8PK/CjCqnOyIb41M1ydtw8F0MygSHFpgi+/MK31i45xv
         GiuMgxP/YkMBMYVebEGUQY1MCfizIvO1eFiwBjs1x4Xy10kbdSyG2KixPR0IxpNeCvc9
         0yZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlb/s2VmYxPIHLFzkn7UVOS6OupHbBhV1dqWOHC8v+4yb3+WX47NOuLgsBaGNl6E0oqaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzczGXzaVV0AvfBNQ89fMu/a51zCodNYeaIs537qTemMHVgHfBc
	fHIsUOWDJmgUYJ8w2GHtxjQEB/Z40PjjATJJHgOJP7kVaei2XKbrPsqLUeLgSQbPAiJi8jl8qsB
	NWru0xafU1f0LFfWJPDcLc06B2FP31Fiwul7bOpEAGX2zzP7XGs2DdA==
X-Gm-Gg: AeBDietZMENi6jhb1c1+aD070semqoEYCUTKLebJ/eGtrHDbzj0q90sYrNvuaFqdhLQ
	qt1UidnFdx8WH+vTdzNjNS4I38F0fhP6o2c+uhkWE7yrgBIR6n7GYNjXhzYSwutSKPUuT6WEqsC
	xaGceuiQ1BD1e1MbsceovqYG9dLI76I+/xUJnN8M1Qf9aNFyF3J4SxGbZpG4QZI4o0+4aCb8Akb
	bPyCQyvJCtlEt5bGtTqXIsV0fEsBn4TteLSpgB2W9iMAMgeFvMFh1g+89teHPe7a3r0QNwoADiD
	9xo7G/FZbFDLWN0Entac26ux1Ppmd+j+vYwvX68e747kEieWqqtpXnuJ41rCPLLFHID/mm4afPw
	OuVqhI66wvAd+eTSI8z1wyVVMqx9do5fm/aKYOJofQnca+LiNI8NbHEbiZTbnDKEfRrEaAsEyUg
	==
X-Received: by 2002:a05:600c:1da1:b0:488:78f2:6b0 with SMTP id 5b1f17b1804b1-488998f488cmr282885345e9.29.1775643487280;
        Wed, 08 Apr 2026 03:18:07 -0700 (PDT)
X-Received: by 2002:a05:600c:1da1:b0:488:78f2:6b0 with SMTP id 5b1f17b1804b1-488998f488cmr282884915e9.29.1775643486788;
        Wed, 08 Apr 2026 03:18:06 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c76d9ed4sm34393955e9.2.2026.04.08.03.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 03:18:06 -0700 (PDT)
Date: Wed, 8 Apr 2026 12:18:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] vsock/test: add MSG_PEEK after partial recv
 test
Message-ID: <adYoNtv8-fQLts1V@sgarzare-redhat>
References: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
 <20260407-fix_peek-v2-3-2e2581dc8b7c@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260407-fix_peek-v2-3-2e2581dc8b7c@redhat.com>

On Tue, Apr 07, 2026 at 11:13:57AM +0200, Luigi Leonardi wrote:
>Add a test that verifies MSG_PEEK works correctly after a partial
>recv().
>
>This is to test a bug that was present in the
>`virtio_transport_stream_do_peek()` when computing the number of bytes to
>copy: After a partial read, the peek function didn't take into
>consideration the number of bytes that were already read. So peeking the
>whole buffer would cause a out-of-bounds read, that resulted in a -EFAULT.
>
>This test does exactly this: do a partial recv on a buffer, then try to
>peek the whole buffer content.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/vsock_test.c | 43 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 43 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index bdb0754965df..d38a90a86f34 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -346,6 +346,44 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> 	return test_msg_peek_server(opts, false);
> }
>
>+static void test_stream_peek_after_recv_client(const struct test_opts *opts)
>+{
>+	unsigned char buf[MSG_PEEK_BUF_LEN];

What about:

	unsigned char buf[MSG_PEEK_BUF_LEN] = { 0 };

so we can remove the memset() call?

>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	memset(buf, 0, sizeof(buf));
>+
>+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+
>+	close(fd);
>+}
>+
>+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
>+{
>+	unsigned char buf[MSG_PEEK_BUF_LEN];
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Partial recv to advance offset within the skb */
>+	recv_buf(fd, buf, 1, 0, 1);
>+
>+	/* Ask more bytes than available */
>+	recv_buf(fd, buf, sizeof(buf), MSG_PEEK, sizeof(buf) - 1);

What about checking also what we read like we do in 
test_msg_peek_server() ?

Not a strong opinion, but if we go in that direction, maybe we can just 
reuse test_stream_msg_peek_client() also for this test case.

Thanks,
Stefano

>+
>+	close(fd);
>+}
>+
> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
> #define SOCK_BUF_SIZE_SMALL (64 * 1024)
> #define MAX_MSG_PAGES 4
>@@ -2509,6 +2547,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_tx_credit_bounds_client,
> 		.run_server = test_stream_tx_credit_bounds_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
>+		.run_client = test_stream_peek_after_recv_client,
>+		.run_server = test_stream_peek_after_recv_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.53.0
>

