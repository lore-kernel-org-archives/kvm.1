Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067839C015
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553249; cv=none; b=nJFuChQolOe2Vg4qhTQTqwHIBcBaTr98hD37SWHd/fdbx7qkCRYA0DNpIN0tYgwc27lZXvkkDbgRbII21tryy9FPJhXnSMS8ah/WVGn7E1Kg+C5EduU/FhSSReU2sVgASduNw8tOtAEMUnZdrLjwvQiX5DgyWQx+KG8ygvnxpv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553249; c=relaxed/simple;
	bh=WrKcD5DGESE+UFTxVGGlNaua3CHVe5XplrOEYz1KMWg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZgHm03Yuk250X2AoBoKNJjg2F7LTnDdWNfORMT4fjrYJqBHu6BmF2QCcXHX+3RzVQf9nPoemkG3futZKaREtQ4HAYAsfL9zmqaOva2e1HpdbiyoEkeel/c1jckmHk7plgUbG05tgRxKTVaUvyuVvmlAJIQEL+Btb/omLjSe1j2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6MUXma3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYxOQrie; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6MUXma3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYxOQrie"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775553244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CkyC2WPd3q09yVYMuwvcFXlfB6s2u063IAioO/76CZw=;
	b=O6MUXma3dtz0hj0+liQquyyclOunb7m5Bc3fyO4WKXLdK6YcA4Y2GkqZ91I00WlaalTCKV
	g2pRtmKh2MhHK2/M611kvnitGnv/JwB3zDOxY/FaOP4UrrAvWq8ePHWK5HwMdtCyq+1mbJ
	97fiF3LhEUq8lv3vXEI8/Mtm/a1jm/M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-AHumKxLcNwWND_18a1Qtvg-1; Tue, 07 Apr 2026 05:14:03 -0400
X-MC-Unique: AHumKxLcNwWND_18a1Qtvg-1
X-Mimecast-MFC-AGG-ID: AHumKxLcNwWND_18a1Qtvg_1775553242
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48884e969f8so24829695e9.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 02:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775553242; x=1776158042; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CkyC2WPd3q09yVYMuwvcFXlfB6s2u063IAioO/76CZw=;
        b=RYxOQrieZg7yiRz++0cwRPPavRy498vitmpcpW5U7sjHmeKeOuCpGp0q6ZncJK7FWg
         IIX/QtRzSEzoSIhbbDR3je1xfD1afDvrsqC6AZEKiwyHg8d9/AjfEe5trNfRsn/24Z6+
         jw7gJiIHmS2PGNWFCG8A9Mi1Ugz7s70XxGwi8CJKzuOqwxi4opjJYEwt6XyCOzpNgqqU
         0pcivo8BegBdvlVWSiPB+yOeoJPwZw4sw89N6hzN0Klec0C7my0UWCYoGR1sX2y83top
         U0C7dObm4pnL18IYYZ8rJNegq8PZ6P2Jr9hFGWyQUbzfJL7V5U5SMfOvK9nNUd2988ur
         O7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553242; x=1776158042;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkyC2WPd3q09yVYMuwvcFXlfB6s2u063IAioO/76CZw=;
        b=Ikf7sc3rOSb8M0qUxO97CMA1yH0P5Gd35MV7Dpy1OIQoh7fPwJTEpuAFDV7TTRxEM4
         znY/dVBjQ9MJ+ZcPZ+kptywZKJ14x4FjD8D1ZyHrzRpqv3cmDDX1NzGxutNVDc2QNK0d
         quT2aGAwp42yVbzWmjZvsTTgpWrGk3btY6qqaT2WNKnNfKA7MV0zq+4sKKw/nO4BQpbx
         5yHI8AFEnjxLW+OVRS2aGmNBSvUDIVKtmxJIQoEihNfkb08G8opc0g+zkMVg2+sye45U
         ArxQtxNABpy2txml3TljzcfBQxeD6BxgZbW08yqwvdTLZ7v4vFS7iD4bMzGt9ewBRU5y
         313Q==
X-Gm-Message-State: AOJu0Ywi99bK9cTCcmtvTDhgynSod0qXTxez/kZYBSQwXkVRZjzz5czr
	UbTVCpMV3kmA7Ti3jI+C0ojetuEFv/VMhkmvVkj5hu6Q9DnM91dpexqftutKTCgTLfS1zxIyCDk
	B6wjCyzJGBW+6VwcWCCJ1CgWvCdvZNx2CfTpW5eFDfePougFSFmNoXg==
X-Gm-Gg: AeBDiesBriZGuy11Fwcbbh53s6mvjk83Dv4gSwvGxIaGSNffshiKVqBSz6V8A/3lMtl
	Yu5KwYN8QAKIKoPwOgCLNLPWe5ZVsMUa45aKTShiOIw9x5EtnOKDdIubwaQXTO6nxRwRi5aiaTX
	9phQ/7YltWlZliarecuvCH/jMWRcGr3p+Ye3B1v5WYuFWvJ7QmTsxiwrlYFpTh9vQEY+H6hS+Ln
	Hy0CAtKg6xxMKL+jaLVwIZbS4OYii5/dyi7QnCHg/ATCOfro0UnXhtguieBNGdm2voH5l+iA7UD
	zkeBIkaiSAi6Zig2apbD+qf72Qrs15QNXxwzQV6LgDKljgWNafTDE3xxoC6ewdzFUZo4buUZ8WY
	LQ8oavg1HXmd9sEvXzLcg+EjZCkzEUUKSZxmmrK+jlkChlqNSk7jjJNYlG6PL
X-Received: by 2002:a05:600c:3544:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48899735bb2mr218429025e9.13.1775553241653;
        Tue, 07 Apr 2026 02:14:01 -0700 (PDT)
X-Received: by 2002:a05:600c:3544:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48899735bb2mr218428565e9.13.1775553241110;
        Tue, 07 Apr 2026 02:14:01 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm342892015e9.8.2026.04.07.02.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:14:00 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net v2 0/3] vsock/virtio: fix MSG_PEEK calculation on bytes
 to copy
Date: Tue, 07 Apr 2026 11:13:54 +0200
Message-Id: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WMywrDIBQFfyXcdS0+gqZd5T9KKEm8VinVoCItI
 f9ekUKXc+YwOySMDhNcux0iFpdc8BX4qYPVzv6BxOnKwCmXtKeMGPe+b4hPIgehlkH08oIC6n2
 LWF1L3cBjhqmO1qUc4qflC2vqV+L/UmGEkllz1ZsVjVLLGFHbOZ/X8ILpOI4vE0qtOKYAAAA=
X-Change-ID: 20260401-fix_peek-6837b83469e3
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3

`virtio_transport_stream_do_peek`, when calculating the number of bytes to
copy, didn't consider the `offset`, caused by partial reads that happened
before.
This might cause out-of-bounds read that lead to an EFAULT.
More details in the commits.

Commit 1 introduces the fix
Commit 2 introduces some preliminary work for adding a test
Commit 3 introduces a test that checks for this bug to avoid future
regressions.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v2:
- Addressed reviewers comment
    - Test now uses the recv_buf utils.
    - Removed unnecessary barrier
    - Checkpatch warnings.
- Added new commit that allows to use recv_buf with MSG_PEEK
- Picked up RoBs
- Link to v1: https://lore.kernel.org/r/20260402-fix_peek-v1-0-ad274fcef77b@redhat.com

---
Luigi Leonardi (3):
      vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy
      vsock/test: handle MSG_PEEK in `recv_buf`
      vsock/test: add MSG_PEEK after partial recv test

 net/vmw_vsock/virtio_transport_common.c |  5 ++-
 tools/testing/vsock/util.c              |  8 +++++
 tools/testing/vsock/vsock_test.c        | 56 ++++++++++++++++++++++++++-------
 3 files changed, 54 insertions(+), 15 deletions(-)
---
base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
change-id: 20260401-fix_peek-6837b83469e3

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

