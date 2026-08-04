Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E340331ECD
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 04:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785817150; cv=none; b=rN5FeLBt8V+IPHU2KtWYaaW0fwark+dY4cUVz2BE4e+FbOLT9gEXjJRlU9sIpt0jsurWcyoIqtovBKxPC8F4jNkd3EyDtUNF56AYLvG9XPafJXAZ8/iZg+LEAOz6NYMjvLDi1zRW0Op+Ue42Gyy6EFFOCEpiuuVUlWSfVdpCAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785817150; c=relaxed/simple;
	bh=Ehv6ZpiwwQTVEJVQYx8VsZm6ew9x8gEVlTBOFfynDtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qhf1aSB8Ic6Dr/mr51tUKW15IiKaoVEoHBRbkSxGtD/fJmcb3YmocMJE3tXus6iWRmb9GC3pnz4n1OfZtQiLIDevhokKVSRe0RktmFK+iG+Uj7gaLzLKTij4Dtv5EV2+/cOyv42iPYCp/PdrVne6I387MQmB+XE6AqC5i6jdWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyCoSyJ7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyCoSyJ7"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so46327085ad.1
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 21:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785817149; x=1786421949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=osDb3QU8E2plb1DNFxL1j8vSW/KoqghbaQXI4jZIOlw=;
        b=NyCoSyJ7A1cS8LcT42kMexYSmBGKJKViYvMxH9F558j+d+BxT0pVb3LxhNZVCXM8Cf
         0Wxi59ZxkULRNpFCoiP7xU38szatzlnWKgUrtKuWD55xO9ZNIiZhlbqtBsFGIB5Gv/Zy
         IP59rwtYasQfhNaGnjavyLwnVLKKYM0TzwkxPWMMXuhiAZ7C+pVYm03kKM/h8MmGQ2Rb
         bhx783aH0CioC8cjrqjug8xauzO6nXfYAA16hDgtIFVaBZEZ/XkM3Ds9+yQinjxadz7T
         zsSOKiB9r6Az+XMr4qPaZUzkKDnyZACgL7uj5MRFfIlrkuUvSURKEht68z9uydoL8ua8
         sTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785817149; x=1786421949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=osDb3QU8E2plb1DNFxL1j8vSW/KoqghbaQXI4jZIOlw=;
        b=mMHSoXWgBSbJVhEIW4fSzS066MOdx1wFA5k7iQ/m7qHTCdPCyb8gayIOnWtRJeGCTE
         D31Zon6A0s7Lk/65clFIiPqNtiiVQ7Cr8uUOWehHi19OmFTY+ptbAw34fxOiNFHoOAP5
         vLPKc6La6lPK4uXWr7yAuFT0mVfXSDah33TNarJoM5SbKBwld39r3Ff4nb3dk6S0/fIH
         52OpspYihm4GMtNWdA/Be+f3I5cD3C/ElJyH5PXKkDBXQIAu5IXoAbXczL8LCjAgHIUJ
         dnYRzcB+lpaErR4olPf4akj8CmbSPTY8QQrdFiwxQYEzzw+piyh8WG6NjSdrw3ATxbJp
         1T1A==
X-Forwarded-Encrypted: i=1; AHgh+RojcQgdVYYTqyOSVuJcSQyGHK1b5oMDvnnGZC0PJmAi3ChFnOMb1plZfksGpnadh+jpSeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcsucw6ze32+JDFqDysyKk/pa90epzUpcEWLCwxeo93tQ6TP3X
	3xH8bV9Zr17/AOLF1W3EVDiQkVG3YM7TwPi/iw3gFTaLpWAj01mbHtsB3M1YbGT17m8=
X-Gm-Gg: AR+sD10GYEM7YnQs5iVTDOTUi0aTGNV00GzxadHmJrKWLxU6aPBi7WKscCdzEheOMQ5
	WPUxR9kiU3+ewjOID48pwIRpby8EAuSyL8Os1tVnhWMFPOsZiZrOGFzeD5gd3TlWUwIOfzr0dqP
	ZtdaiIynm0DVyfcLOCqy+5NVLyINlYl32pk/D7pW8kk1MzeXYsknf1mPHJ9HNjAV00PHc3ELr7K
	N0KcsXQ/K9fDZIU+k8kjigR4KGA/44A2yZlwRtcXog9yjfZQPgXfZE+OZHkqdPve5Dx3FlkG7fv
	y4KfS273EuTgUdnzDBx5K1lzjlqgqsohyIlJ+ggyC5Z6Rmnhob5EEjpPrhk5wF1qG0uWZwTFasH
	PBBenolX3yNhPJtotehJZfs0qsLVCEe8XYwGlt9E0t1aHLM/BAavqTHdyZGLRpIKJT4amLH3i0m
	gFNZ0PiN/e7OiCOlURpR4NfOcWHcA3pAhQXDy+94TsfWCJaSSwuL/ZANDlTxWB+1s=
X-Received: by 2002:a17:902:d2c9:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2d0521bb7cbmr117871245ad.14.1785817148639;
        Mon, 03 Aug 2026 21:19:08 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0ea84asm46012645ad.43.2026.08.03.21.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 21:19:08 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Tue,  4 Aug 2026 12:18:50 +0800
Message-Id: <20260804041850.5922-1-physicalmtea@gmail.com>
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
> 	iotlb = vsock->dev.iotlb;
> 	vsock->dev.iotlb = NULL;
>
> 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
> 		mutex_lock(&vsock->vqs[i].mutex);
> 		vq = &vsock->vqs[i];
> 		vq->iotlb = NULL;
> 		memset(vq->meta_iotlb, 0, sizeof(vq->meta_iotlb));
> 		vq->acked_features = features;
> 		mutex_unlock(&vsock->vqs[i].mutex);
> 	}
>
> and if no why not?

Thanks for the review.

My understanding is as follows. The proposed sequence protects the
lifetime of the old IOTLB, but it does not keep the translation state
consistent during the transition.

dev->iotlb is shared by all VQs, while vq->iotlb, meta_iotlb, and
acked_features are per-VQ state. A kick handler only holds its own VQ
mutex. If dev->iotlb is cleared first, a handler that already holds a VQ
mutex can continue using the old vq->iotlb and metadata cache, while
translate_desc() sees dev->iotlb == NULL and falls back to dev->umem. The
same handler could therefore observe both the IOVA/IOTLB and GPA/umem
views.

Locking each VQ in turn before freeing the old IOTLB prevents a lifetime
issue, but it does not remove this mixed-state window. Taking all VQ
mutexes before changing dev->iotlb lets active handlers finish and
prevents new handlers from running until the shared and per-VQ state has
been updated consistently.

If VHOST_SET_FEATURES is guaranteed to run only while all VQs are stopped
or otherwise quiesced, then the shorter sequence should be sufficient.
Since the ioctl itself does not enforce that, I thought this transition
also needed to be safe while a VQ may still be active.

Please correct me if I have misunderstood anything. Thank you very much.
