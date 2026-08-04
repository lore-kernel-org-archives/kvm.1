Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2B429033
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828136; cv=none; b=E/mu1yVl8hICQg2na39SO+cBmn8qxYdcWxoq2vS3fYr6bwtXaCyIwbNCyzxxw/Gpb+T8L++n9TwiUNJg5PYxnTZAJEvc+dOrPqhVBSOAvucANMHjFw+6kQCejr4BkRArCBoSXEUF5jQWUdAPqmSFsSFfZgjmJLj42q7dpbDpTVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828136; c=relaxed/simple;
	bh=UUYnb43zrsIRjQyh4cfSLY2E5YTZmiqA5Rf9inckewU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=utnhZ67JtmawBn1zMf2nfarqncKr1TRJnvpvNSO7CpPRA46g8BrEw+5dtTGjI5sGraQyImIUNCDB2M0UtR3Srbi+ZJpADqX516Z5PyOhP4MkMrLaF5rvnAC5s0h33W8KYBtEaBrX9G/4Kfm2YEqnXLenjgFD5deIuhR9pXtwTdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5Ra8m2q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5Ra8m2q"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf50c6f235so47984555ad.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 00:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785828134; x=1786432934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L3hkg6nazx4psD5by6/6KEzR0mdVEatjkbankMbYLBE=;
        b=L5Ra8m2qke7srq9Fx+9qLyyH2dPyGCDNy6uywfBpgv3mpPKme4vt3aUlGUaTa6svMf
         iWVq9cbrYW9OCVaxQ8dcXvjFRxI66NqbEbY/PXf+z/rV+EXHfWLBUeJI/xJq1bsBqrEv
         un34gRcyDeA0bgyj5eRSfwt2TDWGEpr3bSmd7wtrROWKhnITPDMY+7McENe9uBpXDWLN
         BzYxv7duqMi8MYmUaWHfgsvXQAb30tE4qOoYEeRvTD3VgKUJE8BJLQTHhVVvShnIqfl2
         M2bS6G3j9906incemvJ21tqBhjs6fjqmboXLk5wDRXXcwstWWKuIqkujK9tN8LAFcGXj
         ygAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785828134; x=1786432934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L3hkg6nazx4psD5by6/6KEzR0mdVEatjkbankMbYLBE=;
        b=Ch42S5DmKtq+OVpKHAokc/gbSKHUjagKl/38+pewnUfWAWmn/nxLMyaArL8C6DcvqV
         CvexaTlsLHSzr1tBOIcpGpOabiccQhZL/jN6OYq2kWwu/dxZt/JurxMuXbHny3wrxpF3
         Z0bjdAgbJmTYnGjHo5V9DQ7Jy8aeDoo2kdyJ0rv0P9WhilS938RG/dz1Oed9Qgrx5FgL
         ARkBe9Dx2u5kGw74mEnloh6D8QORMmQyWZBFpP+okrxuShpsAnD2qqJMKKIuNqjgO+RU
         3lZ2VdkDmVGqJIWq9wAJMmxu8PXw3AzQzwkCc2ZtZGJKSzimt22/zFXqLffX4fHiswb2
         m6Tw==
X-Forwarded-Encrypted: i=1; AHgh+RpOaYyce9kxr/viZlMZ1pI4KcC97RMfVm0xdcD8fIy4ihC6rb01mcnKuCiu6Hwhx9H3Fu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2KgnHdF6RItxrpkU78Iso0RvkKeINdBgu+9OuDF8loFzgAAsC
	biLQFRXEIIwGYxNHYHvhcTWjopOPxvlTTJao0t5z2Nm/flbpnOaXNf7X
X-Gm-Gg: AR+sD130CiOmm4qCnrk1xmNCu0mAyXW5YoNl+T3xb5BrCZKlosEignhcUJdSKECuLX6
	ue7ycnSI3MIxh7z1c8UyeIVM7w7j0aruXA5u79FnwNrTUhckYYJwBJFkQ+3mYKFlUgF8wG2/Qva
	qK7LKGBU+KCT4c+SIIjm+P0/M6zigErodoVwb3YVWCVaZmjZ4AzuGX35FgmDOyzMLCJM9DOLq28
	NKkuNnF7NA7TnFBw98FWbjosQARkw7hdBxhGLZ7jcTVbBGgsbGAjyBNqMJYnlqgE0AnIXi9grKN
	wmCn1Q7zc2tSuKmOMB2C1EzX4bIm48YkBwtYtnt3CHaTDkI2Kehrj3HAvkxzrpIMNcRvMwLGoJe
	9QffdfRWhXBVtlXD0qNdy/N6FkIQUvHR62oEF0LHRK+vPejdXc046dvXoo0+6JrdeQXidYIasok
	dzjKr0cSgdskpqwOKcScNJif25oEA6ERoAutHAUvkfUYC/cI0sh+tMVjLikRPOq8Y=
X-Received: by 2002:a17:903:2407:b0:2cc:9a86:9c42 with SMTP id d9443c01a7336-2d0524ac403mr140766925ad.45.1785828133758;
        Tue, 04 Aug 2026 00:22:13 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9f9371asm1669495ad.13.2026.08.04.00.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 00:22:13 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Tue,  4 Aug 2026 15:21:59 +0800
Message-Id: <20260804072159.7506-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803231405-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
 <20260731103414.1746316-2-physicalmtea@gmail.com>
 <20260803231405-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 03, 2026 at 11:18:50PM -0400, Michael S. Tsirkin wrote:
> Why lock down all vqs like this?  Would this work just as well instead?
>
>       iotlb = vsock->dev.iotlb;
>       vsock->dev.iotlb = NULL;
>
>       for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>               mutex_lock(&vsock->vqs[i].mutex);
>               vq = &vsock->vqs[i];
>               vq->iotlb = NULL;
>               memset(vq->meta_iotlb, 0, sizeof(vq->meta_iotlb));
>               vq->acked_features = features;
>               mutex_unlock(&vsock->vqs[i].mutex);
>       }
>
> and if no why not?

Let me add a little more detail to my earlier reasoning. Locking the VQs
one at a time does reduce lock hold time and avoids blocking one queue
while waiting for another. However, the additional blocking from taking
all VQ mutexes is confined to the `VHOST_SET_FEATURES` transition and
does not add any steady-state data-path overhead. vsock has only two VQs,
and once the locks have been acquired, the critical section only updates
a few pointers, metadata caches, and feature fields.

`dev->iotlb` is shared by all VQs, while `vq->iotlb`, `meta_iotlb`, and
`acked_features` are per-VQ state protected by that VQ's mutex. A kick
handler only holds its own VQ mutex. The following interleaving therefore
seems possible:

```text
worker: holds vq->mutex with the old vq->iotlb
ioctl:  sets dev->iotlb = NULL
ioctl:  waits for vq->mutex
worker: continues processing with the old per-VQ state
```

During this window, the state can be:

```text
vq->iotlb          = old_iotlb
vq->meta_iotlb     = old mappings
vq->acked_features = ACCESS_PLATFORM enabled
dev->iotlb         = NULL
```

`vq_meta_prefetch()` may still use the old `vq->iotlb` and metadata
cache, while `translate_desc()` sees `dev->iotlb == NULL` and falls back
to `dev->umem`. The same handler could therefore access the vring through
the old IOTLB and then interpret a descriptor address as a GPA when
translating the payload.

If that IOVA has no corresponding GPA mapping, `translate_desc()`
returns `-EFAULT` and aborts the current queue-processing pass. If it
happens to fall within a valid GPA mapping, the translation may produce
an iovec for a different HVA.

Clearing `dev->iotlb` is also different from replacing one mapping table
with another under the same address model, since it changes the address
interpretation from IOVA to GPA.

As I mentioned in my earlier reply, I do not see any check in the
vhost-vsock `VHOST_SET_FEATURES` ioctl path that guarantees all VQs are
stopped or otherwise quiesced, so I thought the transition also needed
to be safe while a VQ may still be active.

Please let me know if I am missing such a guarantee elsewhere. Thanks.
