Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61DE434E39
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792351491; cv=none; b=YcxQ5TFYM35mdqBWljRm4gsNVYtk6x1JMDZfaT0lR2+gKqOqh3L9MzSk/M79eL+cB+i6bIxLy3156t3+W1FJeZQQ9CrXJkSLmceJV0gx8fNQFHIJJ6I9g72Dp9ttV77blZ1iXtDMQifdaDYehlRxWMuFyr2TsxCRy74UCcoDlIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792351491; c=relaxed/simple;
	bh=YuTSyzPwXKhPhZHoKxzOloJV3Vz1FrQSyVr0HWn8gug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhw3ruAm829h/lH61QPEupqnG6UumE/RJOXJCGnVD0swY5IiMZYhQzBz7A/r1SHRjj5lBVcBltXaMNqkTaKZJ4yrN6pC7F7KoGjrndusqEcG55Q5ATQdjmtN7nRnfvUqEchR7DAwoT+omRZ8/g6LzPVEgC34XvPffF+VpKIYlIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjHlBlGJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qp7GhmKQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjHlBlGJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qp7GhmKQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792351488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZevltrwKAvYM+Logu2umHQbFiDiJJvS6eiPwGpSCUY=;
	b=bjHlBlGJ6Insd1axqjskG2D/fPEqF33Ka+8iwxPH5UolAo3h1rgnydFRWLhshpcNqEuHa+
	A8GUzWYnM976fgXeQ/QKIPOvavrg6WCSise+y058FlGFpMEwsUFaP1+SEIouAwqS2IH4Zv
	ploz9olgpsZv6HMg2IWWu1WiOlr6kOU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-NjbjZJvOOqKsdaETz7hgMQ-1; Sun, 18 Oct 2026 19:24:46 +0000
X-MC-Unique: NjbjZJvOOqKsdaETz7hgMQ-1
X-Mimecast-MFC-AGG-ID: NjbjZJvOOqKsdaETz7hgMQ_1792351485
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c415561aaso911429f8f.1
        for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792351485; x=1792956285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kZevltrwKAvYM+Logu2umHQbFiDiJJvS6eiPwGpSCUY=;
        b=Qp7GhmKQEl0Qc301NULVc9LZpgMa3ADRPPESl15Bne+xmXFE3MFylBGfnRG460PoRj
         VhgPDsFzFIQSkm/X55sngrs2e4Kl8ZbPkopIKmEZLg5F/woq+Eg5n9P4V/3Jn1KI9Vpx
         CYffU2441vBQreS8sUX5YDCa+MPbgDzoKFDhz3WSdw4Q6UyytqiQNwVUXWG8O4ltDHAN
         9rKoty0odW1fmS52sf3pexJTGBtJUJQF9GYbqyANkkyVXyzH8z2wa6ycMep4lJFt0e/F
         8ipTzmhkflyPLMF3K6xTA6ttskbRojhgpdUjVZ/G16TjJ2OTu6PkhCX4e28GF8KqHFfC
         o5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792351485; x=1792956285;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZevltrwKAvYM+Logu2umHQbFiDiJJvS6eiPwGpSCUY=;
        b=awrcac0E3CIl5VXFL7zRO5BJGqvzib0NJgZJl55RGdswquUQpqkhvIIWMcau2d6Eif
         /PAxTnEaXRohllbZI7RXKnbedrI1Kj9a8DhZT19CBEo11I2MWqKYh3UVzeSXlcs/gFoU
         FdHWEIoHBPKqeMySdOjJggxJCZFSi6ybva46ALm97jDx8UsoXKOuiW/VamdBv9kgfFvE
         z9cPT72LZaPWl28t692KWWvTHZhMsu0Y0n7aSl/93TN7ZGf86yk8VROb0kjt99/Uw4Dy
         uf3sZsh6pvANyWaF1xCXgta+pA0Q25gAmujC0TTIT2/x2iqYwLX7dYgPH6Mwt6/07bfG
         kK5w==
X-Forwarded-Encrypted: i=1; AKwUvBzVLEevd4RlEmdr/puQnF1OaqqwrKPs3JqA/n5nlyhuiNpYpOQzUFsOSntvnoWQGfdyliQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPYsCJtw3oGtuJpVDieaPY6qs/BtAhqLSiavY03F860/Fzkfia
	lo4X8ItBArvgeDmIbyKMyIK7CKDMjSyRpOKAcSMyBNF6SgvnhcAeSOGbIhDVA2zoMGEEU1Enwgo
	fOFqy8uTxwZXPYVfRJpipz9s8eYqc6t93QBSqgGSq7ygc90i22KYnvA==
X-Gm-Gg: AYBFou02DNR1teu0mPNfddDmI4+XlTOxDEWM3dMtVKvLO0t7Ru+kMu3jd5XAsEaLI9Y
	gItR0RnK8WMm2tN++7bzqqBqtKpny2rjdFrDgaHSvlzUDMSYe0Q8iMJo/zSVfLaLWpqPw/0VLvb
	g40jBWLGBRIylbjjwhTuphUODK/Cj8YAI9Wgbnj/UQUsHgAZ6CRqD5Vp5rmkFhqiJRlHEO+nbt6
	j/pofiQHVkeFxn/AdxRCaHZ1pI+CekGNhi9rq5K3n2uGmquZ0CgjSsSqq4M4CP6Tm6IHJj0+PSC
	RwnwfLy/DpuFDNABc8u1SQ4vDY1lS0I030cMJq4AgL3hE6DQIpuHve6999lAVm38DONr6g==
X-Received: by 2002:a05:600c:859a:b0:4a1:d8c5:b23f with SMTP id 5b1f17b1804b1-4a1d8c5bb82mr91473585e9.24.1792351485147;
        Sun, 18 Oct 2026 12:24:45 -0700 (PDT)
X-Received: by 2002:a05:600c:859a:b0:4a1:d8c5:b23f with SMTP id 5b1f17b1804b1-4a1d8c5bb82mr91473295e9.24.1792351484626;
        Sun, 18 Oct 2026 12:24:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d30d778bsm207005645e9.9.2026.10.18.12.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 12:24:43 -0700 (PDT)
Date: Sun, 18 Oct 2026 15:24:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: jasowangio@gmail.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	eperezma@redhat.com, linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018152358-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>

On Thu, Oct 15, 2026 at 03:23:45PM +0800, Haoran Wang wrote:
> I'd like to report an issue in drivers/vhost/vringh.c:1216 (function
> getu16_iotlb), found via static analysis of Linux 7.0.11 and verified
> against the 7.2.10 source tree. I have reproduced the leak on an
> unmodified 7.2.10 kernel.


This should fix it I think? Can you confirm pls?

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vringh.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 9066f9f12ba1..4b097170bd36 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1213,7 +1213,11 @@ static inline int getu16_iotlb(const struct vringh *vrh,
 		return ret;
 
 	if (vrh->use_va) {
-		ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
+
+		if (!access_ok(uaddr, sizeof(*p)))
+			return -EFAULT;
+		ret = __get_user(tmp, uaddr);
 		if (ret)
 			return ret;
 	} else {
@@ -1251,7 +1255,11 @@ static inline int putu16_iotlb(const struct vringh *vrh,
 	tmp = cpu_to_vringh16(vrh, val);
 
 	if (vrh->use_va) {
-		ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
+
+		if (!access_ok(uaddr, sizeof(*p)))
+			return -EFAULT;
+		ret = __put_user(tmp, uaddr);
 		if (ret)
 			return ret;
 	} else {

