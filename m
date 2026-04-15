Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DF73E0C6E
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267669; cv=none; b=OMu4iOJyKUM+CHZNxQl1OyMsUeIwbLp5d30U6qQ5tGOb4WTC7hElq32GKkQQhCIOtZ8Lfe34waod8kJdBqF6+h2QCPr4GItKqGKamfxjNsIZQFtSyiFYnlU3Hb9f8bu3LTP91dXaZF+F0/eRJkkC/BIvTAWJKuuEoXvPlbfCLN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267669; c=relaxed/simple;
	bh=2SsUYUfpJ6Cn7ENP9SVUB703hjWJHv3onCi+Vq1hxh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qzp6FAKON746oyH20LLUsfToNataty85kQ0zdxttDR96zwE+41q+I9PlYiz9IwrqAQ/RRRT8fcG8UB/eST8xF4zyNkQBnIjNhbBjJOSYPSFIjCiVLRLAjHbkIGXExyxhl5KoMyG2pM1qpsIJ5WHRu4slTw1jibaletaND8iTnbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8Zq7DjO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhP1L7EG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8Zq7DjO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhP1L7EG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776267666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ow5K8hzTuD9W/wj2bq1mSm/2juaMM9qh5FYIv6eXqRM=;
	b=f8Zq7DjOmYTXBequ3/tmRfUCcwbMgHfny8aAjTmbZhXSNS8AEpGFYjEMzPw3e0Ni32ohtM
	eayP9CnLIwIIJh238MyNHv8+0nqqvihXJp/qDsQjZLvsVIm2kS3x6OlkG/mZwBvjMHO9Lb
	7D0FZgT4rrnPzmspTxAE8od9nJksiVE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-tPiGUveBMVG_G1emglE5Kg-1; Wed, 15 Apr 2026 11:41:04 -0400
X-MC-Unique: tPiGUveBMVG_G1emglE5Kg-1
X-Mimecast-MFC-AGG-ID: tPiGUveBMVG_G1emglE5Kg_1776267664
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d4ac6ff9so40117575e9.1
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776267663; x=1776872463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow5K8hzTuD9W/wj2bq1mSm/2juaMM9qh5FYIv6eXqRM=;
        b=KhP1L7EGSGj8v7+RertazyvQR/n+mGipRSK9QxpGjQFFK/qBvI9GeunI1mk0/tTtYg
         LWI0d6OWYUhct8O7r+mRTct6iEsIGYp1Zt8sjjUsEVxcKJzNU5y4COQ/s8Rg6+2oPGc7
         25nxsD7QB3G/cqgUCQzyI6mTuanwQ7lQBtzxKx/3eROx1u8Z0LAlsPhE8lc06A7DzIuq
         418d4Nnlfd01wzlzOFMjnV741yBJuLYnSQ9yrx++ZwSNgiF+TR9+etFJoUaudbM9E7Ks
         qmxZ3NaFJpw5kyss4rfavX1+uRa2rk2kAHr5zYE4VQ6cu9pgdQzuzjw4T2FgyoneU5kJ
         ki5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776267663; x=1776872463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ow5K8hzTuD9W/wj2bq1mSm/2juaMM9qh5FYIv6eXqRM=;
        b=sXMgepZEjvV5hd8+4xQGlx5y39S36CVvL9dUEXfcMjAU0NiEByr+YMZTd3yxhMVtNq
         SQ86iY6JzyqcL/FPdR6oXwVntDrf5lkOUHrozGOswYJ/pIZzDuy2vjJEF2M4rNrY352Z
         boyATa6nXV7+45do3cK6BEFkcCzqQgggdwPe0sp4H0S9V2SJmGJMBIRmpZfaKLbLurua
         37b/3wWw3gpVV0b+WUNYCbvzShmAMjqHZ8tkjU50tfIA9NwvJCalnKQytduc0pDdtidr
         zfpOi1aRCNnVCbFjF2/kyCX0uYDz2YlDMJ1capceiKYia5XuTxMVkjql7YgW/8k1Ga4G
         h+Rg==
X-Forwarded-Encrypted: i=1; AFNElJ/g1fob1IXN4Js77BpJ3KbjiFklujJxqOCU+r9fT5Um4emuISTSMhv2uSA/DpCc7lIk6z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVE+kN+bDAm0xsLsJg94Km6w291u6BUZj1NLL3R7xK3Wz//4/2
	TtKcCJ4Jth+Fcp6nTk04mM+16o5yVguTV6Hwpo+u6ZISJ3fm8oRIP3OoGv6Yr4deYs+OqRGN+4O
	Gr0j7zVjGZx62EOWeDNMIDLN2AXQ6A6ocL7yv6QhPEzWFnp/nEiHifQ==
X-Gm-Gg: AeBDietudcqw0z9LIMtKwuDZpLqOB73OQdulAq7DPEUQxAOv9sX8fbmwpFyhJJwxl/Y
	zUHDnoXizvPCyryb6z0dJhH9/W3jCztufQs4RJdsPRoA+SaLfxyPHXD8ArSQTpJHfCRBE+Flgiz
	Nxgl88p0dFc6xU99kyZFdQwerJ2JoF4R+78TK/sYsyF79SBnX2eX9PVSpXZbqiCrAJIvv74AdOO
	JW/hZ/s8nFy0M5O8c80/p2xwEderF5/8GxByNCr0g1kK/5HuVAhLAWIGT7SrwNBf0OQ8p7o9GLE
	S9r6lt2d+jBvUQbj6z0j4CJTxt4fCDblxRoh0NBGPW4KB/9PU24ZWIEBFmX+3XHL6aN1mSzlt23
	MxVS9eV4IX8CgmVDEHuYbXBGhari/4wtS1hrMkNleEA/adEIvNVOKYOVTXnfr6kJhtc65ftdq1i
	GfIXvl7g==
X-Received: by 2002:a05:600c:a106:b0:486:fbe1:2499 with SMTP id 5b1f17b1804b1-488d685fcf7mr215995585e9.22.1776267663569;
        Wed, 15 Apr 2026 08:41:03 -0700 (PDT)
X-Received: by 2002:a05:600c:a106:b0:486:fbe1:2499 with SMTP id 5b1f17b1804b1-488d685fcf7mr215995085e9.22.1776267662938;
        Wed, 15 Apr 2026 08:41:02 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5eb4sm6314894f8f.20.2026.04.15.08.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:41:02 -0700 (PDT)
Date: Wed, 15 Apr 2026 17:40:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/3] vsock/test: fix MSG_PEEK handling in
 recv_buf()
Message-ID: <ad-xdCce7fPbBeyP@sgarzare-redhat>
References: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
 <20260415-fix_peek-v4-2-8207e872759e@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260415-fix_peek-v4-2-8207e872759e@redhat.com>

On Wed, Apr 15, 2026 at 05:09:29PM +0200, Luigi Leonardi wrote:
>`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
>`recv` until all requested bytes are available or an error occurs.
>
>The problem is how it calculates the number of bytes read: MSG_PEEK
>doesn't consume any bytes and will re-read the same bytes from the buffer
>head, so summing the return value every time is wrong.
>
>Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if more
>bytes are requested than are available, the loop will never terminate,
>because `recv` will never return EOF. For this reason, we need to compare
>the number of bytes read with the number of bytes expected.
>
>Add a check: if the MSG_PEEK flag is present, update the byte counter and
>break out of the loop only after at least the expected number of bytes
>have been received; otherwise, retry after a short delay to avoid
>consuming too many CPU cycles.
>
>This allows us to simplify the `test_stream_credit_update_test` by
>reusing `recv_buf`, like some other tests already do.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/util.c       | 15 +++++++++++++++
> tools/testing/vsock/vsock_test.c | 13 +------------
> 2 files changed, 16 insertions(+), 12 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

