Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E43EC2EB
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258662; cv=none; b=YcBTmx1i7qeqQD0ekjoHuPadcMgomScTL7696wdDlKifubP7lptp1hsKnum0aENNQA976/IgjrcpK5CbVb7XK/SJQ8aVCtYVkHHdvoODz5BDzAVkx/j7GZAzlQiZwTBKk6THqk8owGIhq5dKFU0Yaho9m7Zhjw1UL5+f06NtbwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258662; c=relaxed/simple;
	bh=6HxONNuo9hUowvo/qEANYYQGQ+cuOD5myJfGdZBXDF8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ofOuwo0R7eqXu3bOXUEx8Ssf2Qfz2iQxeo5yrBf8xrQEyyPpSguWaEgvGK39h6wjL8yUtgN+xyFM15nlZouIyK1qiEeGFR2YT5+zvZDfyk9qrQXdZPTV2tk2pvBdb39eEEciZzdlDohCR5XOlSCZDtNB6HtwkQyt33QEHLYc5rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAAiezCT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=osQtdmCB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAAiezCT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="osQtdmCB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778258660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N/FCT893ObSbmlIhFuQ0JD4F9cxfAK4253dqNQw9BmM=;
	b=fAAiezCTEGGLEouZN8zkqyG0LRUVvNBM2AynbxEfWgrTqoalA+uDdgM1KdZxiRTsshuSK1
	WUeTTvrMZvTgOY4gdgM6KApiN+wpPux7CX/2tPgkcEPfGKzeA78nbItUMOUVG41+XP6N9t
	+xV2VfyO3FxTCp1fm0UbnE5MeW7D6ME=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-K_cmF5ORMwy1M5OTDxYsUw-1; Fri, 08 May 2026 12:44:16 -0400
X-MC-Unique: K_cmF5ORMwy1M5OTDxYsUw-1
X-Mimecast-MFC-AGG-ID: K_cmF5ORMwy1M5OTDxYsUw_1778258655
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48e5df296aeso13762115e9.1
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778258655; x=1778863455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/FCT893ObSbmlIhFuQ0JD4F9cxfAK4253dqNQw9BmM=;
        b=osQtdmCBMDYAfIA3rwBMAOz9gxQtZKrdFlkaZtEmcR5YJLwQXAFSRApkvPXlzT/cGK
         innGIRapbb5poDII3yiI+7c6bCK2exnr4uH4zdNZmvYM37DBjThnCssLJmI7/dETwmgO
         SIVwlPxwwGICM8qIspu9FEU2nP8cGmXL1fguTOk6BEX4gwTuKDcTiJti2c/y5wPMDYWJ
         93Yk2ShamdAyoIewwbYDxvMoZX5/DKflakzMTu22qhaYsmqZfxWtpUcSqGk3loisAVyC
         xQu2LXRfoYikFev3uUVTehEB3yZ6iZBiIZBeeeZJYU98k+ySP/kAQAhb/qia1N+tw6Os
         1lxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778258655; x=1778863455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/FCT893ObSbmlIhFuQ0JD4F9cxfAK4253dqNQw9BmM=;
        b=M8IE41S1bNwBqdIR58BEfRs+Ezy5s5LAo7AhbqjArhsTYunqgsgHIylYm0FjwmibWH
         OlPcFFKawBB6kOAHrIdiwBqzpEwEFuBhc+Y/LxVfmPBXzYNx9JLeilSXEQMHgKon5XML
         SNVDWCO4r/Jq3iGm44givlQW5JY7q6Y3hhYRw0hcO2A7/AiTnOxm+RK86kVSJZBR3wpl
         n3yk2rsZHLRefwGVgGZtv9xu1eZQwfr4P2mWGGheZIg+gQFgZIgZS8Eqs+/kfzN2kL+B
         xlA76NYOtsAiAr657sNsgqtksR7Hbp4TOYr/gfkuv6ArQ+UqnrcR2XVbpqqXk19UyiLc
         ZOTA==
X-Forwarded-Encrypted: i=1; AFNElJ9BEeMInNEFUr+5jY2wu2eo94j9uo6s6W7TQ//zH8bDCaPrXGR0T5b3eMRDHdfe0JV+RF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3hYXNvH1IyXKT54g2RXAS/EOPLme7+rHuryg3NZ8rgxoGaGK
	aj8e0y7o9cUlmg4c6C0XchD/rlSFpuy1bGj84wlNjIpS2VzS1erIsNeDPy25VArZ0Ald7AFuvc7
	1lKqDcKGyCPeoxS2b7+7LJyW5d/bwM82WBawpVOIWM5CXD9YGNVPg5w==
X-Gm-Gg: AeBDiesrcjq5+3kBO5nii7RKi6FPimXjlzupiBP4vYSFiXzL5yLD7ZMM6mr8EZVYdUl
	oBzKpbiN32buHYlXFukG7wbfwztE+xmFULUQcbKQr4CbWQ/fW5VTtKwnmm9VTmb2X4uDu62pQvc
	xPIjt1gdO0Hk6iFSy4K61sUEuw19naqRLpw0DCuIGPhNImfAMl1JP7BJ08bJ2dyaQbEoL+BODlt
	7PXxZ3gtXrd0PFSaw4xr6VDSitlYSJ3Tv6unnVax89qU4Fn3cYLENH+iuUl4/Fk2vkn4nDHWVo2
	s9qAlWdjrOEuOdSCRiTSk+oLlW95ZlE43GXLswqZDz/AKGslQEyB8ktJ6ec7QgrX8UWPH7drGp/
	ENvKylM7WCMNP4yBCXnrzzPgKC2doRPEXZnJyVpbxd1Cv2Q6rqlkVW1IxMPITaO66sw==
X-Received: by 2002:a05:600c:c0d8:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48e5e000c1cmr89000825e9.12.1778258654654;
        Fri, 08 May 2026 09:44:14 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d8:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48e5e000c1cmr89000315e9.12.1778258654041;
        Fri, 08 May 2026 09:44:14 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd3b31bsm6561025e9.10.2026.05.08.09.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:44:13 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Yiqi Sun <sunyiqixm@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net 0/2] vsock/virtio: fix vsockmon tap skb construction
Date: Fri,  8 May 2026 18:44:09 +0200
Message-ID: <20260508164411.261440-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reviewing the patch posted by Yiqi Sun [1] to fix an issue in
virtio_transport_build_skb(), I discovered another issue related to
the offset and length of the payload to be copied in the new skb.
This was introduced when we did the skb conversion, and fixed by
patch 1.

Patch 2 fixes the issue found by Yiqi Sun in a different way: using
iov_iter_kvec() to properly initialize all the iov_iter fields and
removing the linear vs non-linear split like we alredy do in
vhost-vsock.

It could have been a single patch, but since there were two affected
commits, I decided to keep the fixes separate.

[1] https://lore.kernel.org/netdev/20260430071110.380509-1-sunyiqixm@gmail.com/

Stefano Garzarella (2):
  vsock/virtio: fix length and offset in tap skb for split packets
  vsock/virtio: fix empty payload in tap skb for non-linear buffers

 net/vmw_vsock/virtio_transport_common.c | 47 +++++++++----------------
 1 file changed, 16 insertions(+), 31 deletions(-)

-- 
2.54.0

