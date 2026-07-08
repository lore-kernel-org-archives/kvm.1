Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D43D6CAA
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506565; cv=none; b=noQNnxUhdVZiUr1/uwsCyvdgva1deM9rkqsOFT+qeUiG7VGV9FJCu3aLiWOH7EjkJ0YRQ0s2LJPnv8DA07L1l9L6JGYHFDwi7/sgocf84pN2KV2OIIgaIJw20sPtamQryO7md22W43CznroT2ZUb4buh2EZmSUMVBjZJjQiJoM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506565; c=relaxed/simple;
	bh=5P3Ch4NcxEeqmveBzaLX+zkEGpQ11ii8Z8OoJFfzhLA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dCCFpUWgsu0xJ+kDGWyfErvrSfatN0HdehxBInKtosmA1J5IcFrMwfoWIvKmraUGlEwwy71EvlnEcJNLkocDHEM9bxRmw+weEXhvL0cxpKKM0ipEPXPTPU2uixE5K1YWZye+q9dnfAcQkXJZHg4R8/hcET9mBA1BBhlxPRDwYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Brgnmhvb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SEjAzWqw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Brgnmhvb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEjAzWqw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783506550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VKbeenKshINiNwrwcYYrN7tTsXlZGXZFYsepVeLpk40=;
	b=Brgnmhvb/sheH5PKXxStzbRIcZefcVi0qbhZOeMflyLOWXU7EvbXKhLLlQdYKo9WM6lUhi
	B6fAG8O09TrnhgZnhtc7B9ZzXbtuLjgNG3ZNzsKSWoUnQ78wPLH6jEQpV4+zsM+LJq6lJ5
	OLon/VWA2Cf22bHXZ5hPHwuODTPb06g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-vw4sTM4VMc6sdlpYqkwrfw-1; Wed, 08 Jul 2026 06:29:08 -0400
X-MC-Unique: vw4sTM4VMc6sdlpYqkwrfw-1
X-Mimecast-MFC-AGG-ID: vw4sTM4VMc6sdlpYqkwrfw_1783506548
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493c47a09b5so3453725e9.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 03:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783506547; x=1784111347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VKbeenKshINiNwrwcYYrN7tTsXlZGXZFYsepVeLpk40=;
        b=SEjAzWqwOK8G5rxOGN2R5pLijuYMcr/c+SEWjJ28pwAlI47Etd+lnCT2SxFZAPwgCX
         OOpatT43NToL3n7h3emdpEjjvLmniC+HuoNWIpzoU1SoZHdNLzmetYEM11pgmLcD0BGp
         pvsaIdBsJAUnHARNUqg1BOHttU2BP9lyXUBETGK3ISHXAfBEqHGl+LbmjdStPrnLnA+0
         vwiHVzi67TkhtRjdOd4AAg2Am0p8oYLvwTwUWD383X91fBn9/9sDQH8GzWPJ7jKacBXx
         /OQosDD7WSWYH+1/+gX/qwUHRh3VN8hdWOnG1n2Fem2RdPTZHZQuWvZ30SaQYFtKcuJZ
         I2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506547; x=1784111347;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VKbeenKshINiNwrwcYYrN7tTsXlZGXZFYsepVeLpk40=;
        b=grws4INBh0lmGz84QHE/gr244ABYLXWILkiH+Ztuif9kxCWzD14B7GW32fy/+Zlc1+
         DH7tKBMhMPAH2pfUEA7gpPB6rKvmfGNdOstj926DwFhO/f9oK+Qt0NeX6UmbS8a8p/eO
         Pcx5YWx0RXyTpF/t090ldGUBu/HkbX469d2TjwSwGYjkzCY5ScQEgz275mA3RWp7jdaJ
         jBpCFhUzr9ycqDiKiXp4jYrzibVs8sqPnh4yK27u/9y6oxDipXHuindV8qHkYuCg6mjQ
         +zXxB2k4itl8xAq7iL8TmhXnG5KqX/4EwF3xCu6sbvQ9Xrc7zNDtNC6hvuBIvBTnTXLX
         ofTA==
X-Forwarded-Encrypted: i=1; AHgh+Rqe4Rga8Vb4Wo44wVOsoln79ZzBAQYefMcSaCO/nvmZk24Z8RxECI0owV2236dwB81MAj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4/kgKO73BFScA8eC2XRhldKaDTrD7bX/2xTLWlmTHQiG0BlHK
	UWpW+W9gPadyNAyFt40hccmXny3VI/Qbqn4UFTrFVBsanCBv+rgZBf+OdGeINKuaHbutyAgHtL1
	l09+yi5y0JbY+aLKzbm3NL2ouzwoEliLwr9KJZ2BPhxwQBRV56ktQiA==
X-Gm-Gg: AfdE7clUTty6X9b8pY6cs19PORn/r/WuBRY9Ehk+dfN67gAxWRLU0PaeTzz/enHDix3
	n7+sj1Zyxrm1+4uRE4Wqbik17Y6Lgl1MyEwY2MYaeOLSFNiXbvqddwvImGUZgLRnjKWNCPGxUxZ
	7sNy5x/63CGAHv17US1aScIfbw9dp9nNyGyaWzI9piQ941Bhq2VnmNg82FKGEP+uVb3ADIwdzmt
	5B1rRQpm+aPbrNyzMzRNi/DE8nMFYkhhEHSzTUUTDF7KnvqoxWDwqM6vIQ9Ou3McEuNiOf27d0s
	PwL30n6ctsT4dWKEogb4bjxHIpvf+zBhwaTlAuXlMtEsvbkCVjT1QGuhroErnUBzNoYPFtyZNOC
	2xtqfb6kcJtP6xej1GEwJcZyxn7+o+2UKrtlgR4Pa6dmeWnk=
X-Received: by 2002:a05:600c:628e:b0:492:6113:d4fc with SMTP id 5b1f17b1804b1-493e68cfbbcmr20997195e9.17.1783506547614;
        Wed, 08 Jul 2026 03:29:07 -0700 (PDT)
X-Received: by 2002:a05:600c:628e:b0:492:6113:d4fc with SMTP id 5b1f17b1804b1-493e68cfbbcmr20996675e9.17.1783506547139;
        Wed, 08 Jul 2026 03:29:07 -0700 (PDT)
Received: from stex1 (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0ebf593sm135475255e9.0.2026.07.08.03.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:29:06 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jason Wang <jasowangio@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH net v2 0/2] vsock/virtio: collapse receive queue under memory pressure
Date: Wed,  8 Jul 2026 12:29:02 +0200
Message-ID: <20260708102904.50732-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains a patch (the first one) that is part of work I'm
doing to improve the tracking of memory used by AF_VSOCK sockets.
The second patch is a test for our suite that highlights the issue.

Since Brien reported an issue with his environment (based on Linux 6.12.y)
related to the work I’m doing, I extracted this patch and tried to make it
as easy as possible to backport. Brien tested it by backporting it to
6.12.y, which now contains the backport of the 059b7dbd20a6
("vsock/virtio: fix potential unbounded skb queue").

This patch primarily fixes STREAM sockets, but also partially fixes
SEQPACKET (with the exception of EOMs, which are kept in separate skbs to
avoid overcomplicating the code).

The rest of the work, I feel, is more net-next material and still needs
some work to be completed.

Changelog
---------

v2:
- defined MAX_COLLAPSE_LEN macro instead of using a variable [Paolo]
- added a threshold to avoid walking all the queue while collapsing
  [Paolo]
- collapsed the queue before calling virtio_transport_inc_rx_pkt().
  While working on the threshold, I figured out that the check I was
  introducing can also be used to proactively trigger the collapse, so I
  moved the call to virtio_transport_collapse_rx_queue() before acquiring
  the rx_lock to have also a better diff to simplify backports
- improved code readability (removed `out` label, `keep` initialization,
  etc.) [Paolo + other small stuff]
- Brien kindly retested this version as well (thank you so much)

v1: https://lore.kernel.org/netdev/20260626134823.206676-1-sgarzare@redhat.com/

Thanks,
Stefano

Stefano Garzarella (2):
  vsock/virtio: collapse receive queue under memory pressure
  vsock/test: add test for small packets under pressure

 net/vmw_vsock/virtio_transport_common.c | 165 +++++++++++++++++++++++-
 tools/testing/vsock/vsock_test.c        |  87 +++++++++++++
 2 files changed, 251 insertions(+), 1 deletion(-)

-- 
2.55.0

