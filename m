Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631223932C9
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258687; cv=none; b=NqWZPkX3qrT7o1Z0irHrJnQ3GTerNfAywl0GiZcM3BU+RANMz27P3rUCfjBwLK2/eG5OmJaOXsAVgj2fg0DfwgrTCcTy1DFlD7Tf+wgc8yi4GODzzeigT4g08PUuwfEtbYXeMc1wfz5mVaOsWxUjHshAa0nhsMXN+an/mOTM8Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258687; c=relaxed/simple;
	bh=HOy4QBTiHtu5pZJktO361ZlyF5xmQN/JVgQvXBzyBow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JROUkijni8ZsZITsv1sDonx+l+jfKmNnoHSMf6RucmwpwAdSen0HA01Sdi/aMo6S2CmCRhL1p5FFzK4fzA7TTiRRyqhEbpovgBYW4iYPO9qfRBAGm67ZA+Mtu8K9+Pqo+eWTXQ5KfWV6E4nHSE0GsWQVp+1rOB0bmsakfVT8vow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bpsfhyl0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JiVkzgEh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bpsfhyl0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiVkzgEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776258684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WL2SJseQynMpG1hsJR3ThfhQkhlDiJgfMk9Ad5tgV64=;
	b=Bpsfhyl00H10Nbvl2+Kr7CxH3ppFNPH3pUvQ/4QmCM8Zu1ILs+UBZbH5S0A82+l9HtJIsX
	4pX1VRNdDo00WOt81uCgx3sz3sLR0Z3Zw2Jw4ZCKbXpGIW+x2QMcd/QbNR83fX4q9b9R6a
	4W7reLxn0M6G/96AOQAPmbvDOZrxZzQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-5Zb7BPgfN0WkTxf4mL05OA-1; Wed, 15 Apr 2026 09:11:22 -0400
X-MC-Unique: 5Zb7BPgfN0WkTxf4mL05OA-1
X-Mimecast-MFC-AGG-ID: 5Zb7BPgfN0WkTxf4mL05OA_1776258680
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488e1757205so23453035e9.0
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 06:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776258680; x=1776863480; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WL2SJseQynMpG1hsJR3ThfhQkhlDiJgfMk9Ad5tgV64=;
        b=JiVkzgEhI6X8b57/5qjR5GSOPXmt8b1+OGR2WfB17Qk52YvSoFegvw+RkAj99YZ5f+
         l8FBlgRsuUrYvZk9I+lQ5+YE8Hy4mgFHsO+lKgN4g5s9Q2z+yilDdhiOIiLQ5nV3+FAl
         SPhRy9sCbwtQcNcbmS2l0Nn7tZHQC/oDc6byC1b1CrJke9TaXVPxZRVh+/HzPfg5YAiN
         lK+Av3csqa3+J1oCkNmUAbusKQd2cKbigVazmCQwS0eX02vioVtGeIP/8bOaUoYZ2IHY
         XXIPeDIFvTpXjn40t0+k3iQfAqVdYwhNls4h4/4ZuhUBJPWpXFzVs07TlutBhy3ElfZS
         WmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776258680; x=1776863480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WL2SJseQynMpG1hsJR3ThfhQkhlDiJgfMk9Ad5tgV64=;
        b=m8a2rM/cl6Wmnh/O+RL5NfJkFN0G3WTUH1y9Fxx1ZxS26V1CsRxdXONaQt6IWU6DdH
         iGY3QaeBPdQLeleZ821mjq1zZfGmq+ninusorYgGRtmmnH/VE4sVlXCBDWD6JK4RXDEZ
         zdRl4iQYh/PMoEEi3PLCmrGdB39xkPaIkhGE64PZ/PKw3QKiyHhzJeFiFg/qF2wK7W89
         F1FWwopMbIEVYWw7Q5HM8v4V720cUbRve2iCeFmAoaviyp6BSIfy+dp0pOmATyy9AbnB
         vMCE2pZhMlZ+yYhUf7cUxcFw2y8nVMg0sjqo4qUEWqbAq6oAv8rtOiiy9HER4LbJ+dbQ
         IXFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CJ6mCSP6PxpTitOpeFPIL9AkWR0+vzdJc268b5y/Zz0bLiQkrM9BbUFsUl8UugSWyVCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywupawpcz6Vr8Rsx3RQcP4epA6wCmzwjSA2amKidl2xuiDFDN3d
	Bda8sj/04wJ/2iZWHxK8Y5e4fkd0iDkpz1cRs1ZDtEe9Mp6EOXZVo/WDwwMuFPH/SLc5OGS2G+w
	10e2C6kkUwBz1a4LSs6if4XJSHh20vy+e99XaKh2qK4mMuC5jwC5Tkw==
X-Gm-Gg: AeBDiev5GR9tNdf8mSiZWPZU1VJAR3YDMh8b3Y3k6l0mg8N3djVM3CorYyJpT0zu+AK
	RzJBbx8SvwOd9I9t4JNd5vB7mraWpa+bGX7iwVRoxX7jN05gdOQfiQfGA26VvFEJvt8CjAtMMuF
	c0dvYguWdpAvhPvBqJ5ye6fudGAfBkvkb6SHSaE+hryX7QDEtKNu6XAvIZI+BXShz5WNrZ06Gll
	q4SXCiLN6e+/cAG+oc0Nu6A/WcDAXJZ9/e1+CfvYz8thTH4cds9JiqIu2/N6Q0k73Lc7GxfOLCo
	qILdz43TTeGwt6ioJsK2Y8IPfPId7UUnclSlqDXQLGpKnSkotOtEnsqEmiTjbVOJ+4wI4CV36Me
	i4uT382Wu1mR+zPVYo5gEgcGmzMk=
X-Received: by 2002:a05:600c:6994:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-488d67bbcbamr306254105e9.3.1776258680472;
        Wed, 15 Apr 2026 06:11:20 -0700 (PDT)
X-Received: by 2002:a05:600c:6994:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-488d67bbcbamr306253665e9.3.1776258679964;
        Wed, 15 Apr 2026 06:11:19 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0ebd0e1sm20362525e9.28.2026.04.15.06.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:11:19 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:11:16 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] vsock/test: fix MSG_PEEK handling in
 recv_buf()
Message-ID: <ad-OSiCXGAXKgxrx@leonardi-redhat>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
 <20260414-fix_peek-v3-2-e7daead49f83@redhat.com>
 <ad9uYrUjgCkW1D_k@sgarzare-redhat>
 <ad96TgXHW_jKitls@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad96TgXHW_jKitls@sgarzare-redhat>

On Wed, Apr 15, 2026 at 01:54:43PM +0200, Stefano Garzarella wrote:
>On Wed, Apr 15, 2026 at 01:31:11PM +0200, Stefano Garzarella wrote:
>>On Tue, Apr 14, 2026 at 06:10:22PM +0200, Luigi Leonardi wrote:
>>>`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
>>>`recv` until all requested bytes are available or an error occurs.
>>>
>>>The problem is how it calculates the amount of bytes read: MSG_PEEK
>>>doesn't consume any bytes, will re-read the same bytes from the buffer
>>>head, so, summing the return value every time is wrong.
>>>
>>>Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if the
>>>requested amount is more than the bytes available, the loop will never
>>>terminate, because `recv` will never return EOF. For this reason we need
>>>to compare the amount of read bytes with the number of bytes expected.
>>>
>>>Add a check, and if the MSG_PEEK flag is present, update the counter of
>>>read bytes differently, and break if we read the expected amount.
>>
>>nit: "..., update the counter for bytes read only after all expected
>>bytes have been read and break out of the loop; otherwise, try again
>>after a short delay to avoid consuming too many CPU cycles."
>>
>>>
>>>This allows us to simplify the `test_stream_credit_update_test`, by
>>>reusing `recv_buf`, like some other tests already do.
>>>
>>>This also fixes callers that pass MSG_PEEK to recv_buf().
>>
>>nit: this is implicit from the first part of the description.
>>
>>>
>>>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>---
>>>tools/testing/vsock/util.c       | 15 +++++++++++++++
>>>tools/testing/vsock/vsock_test.c | 13 +------------
>>>2 files changed, 16 insertions(+), 12 deletions(-)
>>>
>>>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>>>index 1fe1338c79cd..2c9ee3210090 100644
>>>--- a/tools/testing/vsock/util.c
>>>+++ b/tools/testing/vsock/util.c
>>>@@ -381,7 +381,13 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
>>>	}
>>>}
>>>
>>>+#define RECV_PEEK_RETRY_USEC 10
>>
>>10 usec IMO are a bit low, it could be the same order of the 
>>syscalls involved in the loop, I'd go to some milliseconds like we 
>>do for SEND_SLEEP_USEC.
>>
>>>+
>>>/* Receive bytes in a buffer and check the return value.
>>>+ *
>>>+ * MSG_PEEK note: MSG_PEEK doesn't consume bytes from the buffer, so partial
>>>+ * reads cannot be summed. Instead, the function retries until recv() returns
>>>+ * exactly expected_ret bytes in a single call.
>>
>>I'd replace with something like this:
>>
>>  * When MSG_PEEK is set, recv() is retried until it returns exactly
>>  * expected_ret bytes. The function returns on error, EOF, or timeout
>>  * as usual.
>>
>>Thanks,
>>Stefano
>>
>>>*
>>>* expected_ret:
>>>*  <0 Negative errno (for testing errors)
>>>@@ -403,6 +409,15 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
>>>		if (ret <= 0)
>>>			break;
>>>
>>>+		if (flags & MSG_PEEK) {
>>>+			if (ret == expected_ret) {
>
>On second thought, I think it would be more appropriate to check for
>`ret >= expected_ret` here, because all subsequent recv() will
>definitely return more bytes, so there’s no point in continuing the
>loop... and anyway, we’ll check the result later, so just that change
>should be fine.
>
>And of course I'd update the comment on top in this way:
>
>   * When MSG_PEEK is set, recv() is retried until it returns at least
>   * expected_ret bytes. The function returns on error, EOF, or timeout
>   * as usual.
>
>Thanks,
>Stefano
>

Good idea, will do.

Thanks!
Luigi

