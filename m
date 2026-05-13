Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC053F661F
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669667; cv=none; b=VCC3IwFv4aRr1H7RTa224jXwuIMaojPGi3tohnzZ5lumExKaBTJukwyzLtJwy5Gg5v5+f6Lw4f02Bs10YHhglhnT3PxVS5OvvCnVz7/ETDuzz5VEuMScdug+TdJo+Ugn0JvHdd/KKl02abF+YEn7Vr6w3an70WXkvdkbQGaP90c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669667; c=relaxed/simple;
	bh=7yTfwJVH7KQt1qPTBB2JpVv7SoanftpfAUK/i+v825o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IegSi0l5x/qsaYSLuOXjUZi30yA0Nw6xaBEgBcmfyI6HF/wRIzB3Ym5Fh6cMJcMW+A7kxo5EJawxwNPsXz5NuycAt6pA+AvNVrVMKkHvJ90/4qtCN4sAiBNQzg1S0mt3wUOIt0pBbiKtgZN81ED3TD3PTwvQBqNiGg8D/0N9kYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQst75dz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CO/B9P8K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQst75dz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO/B9P8K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778669663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j46NWqxlvtt9B8j2CsxWNzaR6FQyGRn7VT2uSJN4uKw=;
	b=QQst75dzs1Xpr3SXNzKbfnnX+Pt4uZkNDIAIu9vLu3h4nkUBMMinifitViN+XnK8DSQXfN
	izei8/lIhfm4Zmu2pO0LneJ0E8x+vRvJHcQ3SSC+FnWQBD7bW12pb/TYlTZuIb6bL9Itot
	TkzXC8v6FONxXp93AJLvYoSw2muoNH0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-dMMx8a7AM6a9RZduluL4Qw-1; Wed, 13 May 2026 06:54:22 -0400
X-MC-Unique: dMMx8a7AM6a9RZduluL4Qw-1
X-Mimecast-MFC-AGG-ID: dMMx8a7AM6a9RZduluL4Qw_1778669661
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d789cebcfso5387579f8f.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 03:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778669661; x=1779274461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j46NWqxlvtt9B8j2CsxWNzaR6FQyGRn7VT2uSJN4uKw=;
        b=CO/B9P8Kq9c0l9p86/CKNKCUxvMtSYhpyMKVNIS5ddb6rgidg1Te2NIhb0/V4TlnWo
         BtpDH625dKw1w1MIRHIQqnYEH1erPX2tplHI+4KIUIB6W7vA76NPW7d39PMibMrv1U2G
         Le3JBS9eeucbEJ549kQL4RMQPE8QOVYwZXoXVN26Ix37Rl5V4nt9x0MBnSfmkUFnVUoq
         ZSR0v+OUHZFULJaFeUv0BLTJol0z622anQeJzRLyDjyh0a/BpWnggQq19mEtOZhHBrDp
         mBaUxpH9dv39s8ceqTemU67b5h6pdCRrxv5J+1DxlyRzUMSHPY10qsjNj4qAs7/jWI1Q
         NzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669661; x=1779274461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j46NWqxlvtt9B8j2CsxWNzaR6FQyGRn7VT2uSJN4uKw=;
        b=oh9zt0hySbIJ51wO4PV6DqJ0juPySNoZjucSv8jovO+PNFNHjNpiN7NKmUyDlWztpB
         3E14OP9CLE76U09Lyo0FJutf63R0c9szQKcMKuLtlwAr6wNKegcwLOYi7E+b1SR1NXrN
         E+u0L4HZkz7B82BlRB/Z+apvpvKT183yUa3+BBB9+JYoI4JE7bWHZrEhIXf62pIiq9K3
         LuJbWqlVvToQO1VvROBEkfpPNbpKh79JAbXCms/o+e06Wj6jlyW/ygS6cdXaHuygnBt9
         equ5aIPpFmCgLmHy3cEndGQqOjQT3QreoKDEmsiYl3AqbqDl++APCWfzo3KsJMGhlDbO
         /0WA==
X-Forwarded-Encrypted: i=1; AFNElJ85g29etdK/2gyEjvM4Th5TdT/RyHaWi0aU0VIL/Lb5WQKwmaIdKF3CdlBLn7n0gKGZKCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLZ7i4l7lEmFHEk3mt1BbT5oymiB9LTPqXfW2ypSpeF+52u9H
	IMWO4+jMTGX8/owEs6DuE+fGfePUaMlbR8M5ngL+/k8dI/Lqe3+d4b2e52F7hXqB+yA2fLoHZ7a
	c3oxlNdhPXZuisBuPD3omQfC5/QfJyfqEb+YbWU2NaL9WqOXbrWMFgw==
X-Gm-Gg: Acq92OF1HXmGPMcMkp0Ga0eAB+4SmsmHb3D1xa+h8ZWkA0I1KIf2j3JXSyru1HQuv4P
	dvIQRVK0dKJwH6Y/DsuJO7i7MGX8Rn4iELKwxk8S8uubheWxFjdSm/BtOY7qQ1LKVZyy9XK6yeo
	DTuD7l4hxZ/lftpcNDzfXCVAcDxFuf4EJ/eSGUSvf+ALkP8ozZHBH9/0wNI20o+o0U59qdhfbsS
	C2U7uziLLUqtcONP0gp4vuR2IXyrxMScsc5mMwesLUH7JzB4K+/Nt7bsR+Fa7GCk0KgFmbp5NTO
	3FhC/K10drOgquq9WVb2oC8iYhUygC471t7veTNHZ2YzitqEibUqtubZbCXcCHytzvjf0Lmqy3M
	kbntdF69u0jKa6RjT3xawUGpL4QWF5jprguVb2QWV4arqouFmXomi4yWKIZiH
X-Received: by 2002:a05:6000:1a52:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-45d4c308261mr10959f8f.5.1778669660838;
        Wed, 13 May 2026 03:54:20 -0700 (PDT)
X-Received: by 2002:a05:6000:1a52:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-45d4c308261mr10918f8f.5.1778669660370;
        Wed, 13 May 2026 03:54:20 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549130549bsm41002672f8f.18.2026.05.13.03.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:54:19 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net v3 0/2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Wed, 13 May 2026 12:54:15 +0200
Message-ID: <20260513105417.56761-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code is exactly the same as in v2, but split into two patches as
Michael suggested in v2:
- Patch 1 resets the connection when we can no longer queue packets,
  this prevents silent data loss, and both peers are notified.
- Patch 2 increases the total budget to `buf_alloc * 2` for payload
  plus skb overhead similar to how SO_RCVBUF is doubled to reserve
  space for sk_buff metadata. This preserves the full buf_alloc for
  payload under normal operation, while still bounding the skb queue
  growth.

v3:
- Split in 2 patches [MST]

v2: https://lore.kernel.org/netdev/20260512080737.36787-1-sgarzare@redhat.com/
- Close the connection when we can no longer queue new packets instead
  of losing data.
- No longer announce the reduced buf_alloc to avoid violating the
  spec. [MST]

v1: https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/

Stefano Garzarella (2):
  vsock/virtio: reset connection on receiving queue overflow
  vsock/virtio: fix skb overhead accounting to preserve full buf_alloc

 net/vmw_vsock/virtio_transport_common.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
2.54.0

