Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410383B38BB
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642631; cv=none; b=HrnAQi3MMb2eld2LVwQBC9Jq3bN8m7h5BnO59Q0dUiYan8hL+3YOq4HxJAmaj7g/GPWOM4oNYFILGf7Zcv473dQnwz3kVXUn2NlfAG24wjkWYzF2kjKybYt9PpUVth3k31tw2H+RYii3ZbU/FsR0zfSQ/UfJ1mGSGqSHICgjTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642631; c=relaxed/simple;
	bh=o4+1SC+5gK72xbVuKMA8stLflF08ngrXS2p6EHL26qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTY+QTldhXTh05mc+lbLl5H3cLgPQkVi+pYH0ZTB8TARyPRQrQiYdJ04pEw39Jds8xVa/o3Sx3MWN54n8SkN3OhGBvTEZfTuVRfNpiDpI5CQhWeq3UuGuzsfC9lMLLHtdFb2geVnfBA94jtiEI3yppbTYfQv9GwchhDx3nCkywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDfDZ6VE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dW37Um0y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDfDZ6VE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dW37Um0y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775642622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GvW8ppuKlGxLvKsyNaJZSa2eFAuH1JA79Zx9MBFdNuc=;
	b=gDfDZ6VEH4OgGWkxTxJwPZ2wMYOH0Zi5oTHPONIFST2YbBD5Q8ZtRiLLpyI0GHYNsR1QUb
	5/Iy+fGWlHEg7cAoyjaeGn13rRQXbyW0gvJ6E2LDUAKimgUAXm/8Fsze/SF+lyWC8kDEnp
	A+ugLuY4rZEa7xBaYLzR3AI2pFNiew0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-YSwSYg3_OMaAA4xSWYpS2Q-1; Wed, 08 Apr 2026 06:03:41 -0400
X-MC-Unique: YSwSYg3_OMaAA4xSWYpS2Q-1
X-Mimecast-MFC-AGG-ID: YSwSYg3_OMaAA4xSWYpS2Q_1775642620
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488b966e9dbso16000405e9.3
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775642620; x=1776247420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GvW8ppuKlGxLvKsyNaJZSa2eFAuH1JA79Zx9MBFdNuc=;
        b=dW37Um0yJUwUNhEWHFvWOPzxRIKwRzMfQpEfBAq6y6MxUk9oq2bjDjM132CtYH5OfC
         gDrphBEEtfCVA3wVX62QsAj47st6CF876JooMhBisLtCYKb9A8aEG22BHQH5Et3XmTrm
         5magswqJI0GV3z5gbtTSgAe1J9KlQm4tEEDENi1q32lKSeisnghGD3q+UD6SNxiKuVX9
         uOuNehhXKWXPs23jEop/hjgaBmfYGJO35FFOuCNQV/g5mg89L3PJS7hdi8Nm6ciNFIYV
         PKxysaVtIiANmpHcG74MrJfGFB0LW0nMTOTQV3FiHZIR0X8d+x6lYUvjhU2TEVMRzAIW
         V/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775642620; x=1776247420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvW8ppuKlGxLvKsyNaJZSa2eFAuH1JA79Zx9MBFdNuc=;
        b=ThdWzlwjxXSnYS5fmOuoHRGD5B1MU54WXYcTqqXciL6lzM2oZzrg2V9CIvhwCcr0Nu
         eSUbK3w6ZiGix7nLO16dM0bS9F5LVhoDSFs1MDnAEjo5pHdJXmDa26xcL4ypwhMF00sO
         jNcdEbOpJop7EN8+XtILlPLVO68YDRq7pTeI31ZFp5Rwe8sD06qcVNKNfjGvVC7IRUlM
         3l8VJlVs3o6ezMXFNQ21OAjfPLX6WpjOdEt4HglTW+K1Ok9lGBpViedrFcpWAk0aEnkI
         XTKDgpYfEHBnfpdHg7+FhKx4zeAjrD21sJo/brEbtGXMwcFEZPN/BqYwsACCtiVyPL8o
         hR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVU60FVAQYs+8BTn9QSVY2zmcexbcVlU596krEOKTNx1gVSL6cGgg0jBwfhz1whvc5//Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxFgDoNrv4JZRo60NmLnh91QHZQuSSr/f2G8vKz03g+vTjKBFO
	T1QMqDljbHhobCfcXAQdZWvNoNpCMRxxNb5p5nX5OfenWi7Y+zOd1RrDxd943qGt5dbez3hEglw
	V3E9T9IVQFb3rGwEpjywXEbpdFG++7v6292bjmb7NorJ468d8jPJddg==
X-Gm-Gg: AeBDiesMo+o1N1eyxVxORL6OAAueYWPH583pMqAnazCkNHrsR9o4dtwEqrsY7KeBGD2
	+HIlWAz4skHMYHGyrEc0OP/qd5+ea3UWB9pUzl2VawPp6Vv7PRELvyw69hWGLpRoo4a/adLVbzZ
	jVDrPfi4TCdqvauT+C4EDIh3ienN7s3hW6RzmrUAUnhxK7mMvlJ7mquJfhMBrwTcaAOouLcFUS4
	zwurgX7fihWBH24PIVMMp3cd299PUUBWOGsuyA0/Y1VX5QW0KuYzOsZNEq2r/xdEo86VGg3ikJq
	8eiYtCEMH0N9Gr1J8AFB403pjg9Rrp6TlggyLydGcT0DYkwyPzQVAZBbSzMPHKrH1PDFL9bOAjQ
	QP+UfJ/RGkv9wCMGZ9XjPML+jTAQRCBXr73+Rk2pIzBdOW/t9tHI6bT8z+Jr6Dcab+UVL8g46DQ
	==
X-Received: by 2002:a05:600c:8b03:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488997d3188mr291773255e9.23.1775642620055;
        Wed, 08 Apr 2026 03:03:40 -0700 (PDT)
X-Received: by 2002:a05:600c:8b03:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488997d3188mr291772635e9.23.1775642619553;
        Wed, 08 Apr 2026 03:03:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b0c53a27sm229454385e9.7.2026.04.08.03.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 03:03:38 -0700 (PDT)
Date: Wed, 8 Apr 2026 12:03:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] vsock/test: handle MSG_PEEK in `recv_buf`
Message-ID: <adYkNiNL18aOv74T@sgarzare-redhat>
References: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
 <20260407-fix_peek-v2-2-2e2581dc8b7c@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260407-fix_peek-v2-2-2e2581dc8b7c@redhat.com>

On Tue, Apr 07, 2026 at 11:13:56AM +0200, Luigi Leonardi wrote:
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
>
>This allows us to simplify the `test_stream_credit_update_test`, by
>reusing `recv_buf`.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/util.c       |  8 ++++++++
> tools/testing/vsock/vsock_test.c | 13 +------------
> 2 files changed, 9 insertions(+), 12 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 9430ef5b8bc3..f12425ca99ed 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -399,6 +399,14 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
> 		if (ret == 0 || (ret < 0 && errno != EINTR))
> 			break;
>

We should add a comment here or even better in the documentation on top 
of the function to explain better this behaviour for future reference.

>+		if (flags & MSG_PEEK) {
>+			if (ret == expected_ret) {
>+				nread = ret;
>+				break;
>+			}

Not that I expect this to happen often, but I wonder if it would be 
better to add a `timeout_usleep()` here to avoid using up too many CPU 
cycles.

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

Not sure about this change in this patch, but since they are just tests 
it could be fine.

mmm, on a second thought, we already used recv_buf() with MSG_PEEK in 
several other tests, so yep, better to add this change, but I'd make 
more clear in the commit title/description that this is at the end a fix 
for other tests using MSG_PEEK with recv_buf(), I mean something like 
this:

     vsock/test: fix MSG_PEEK handling in recv_buf()

And also pointing out that other tests already used MSG_PEEK with 
recv_buf(), but it can be broken in some cases.

Thanks,
Stefano

