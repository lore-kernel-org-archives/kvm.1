Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00BB3A4F33
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352646; cv=none; b=Kpc/EE6fJXxrrVS4g/FbYGT7/zc7EYtWshg6tW9zkT56+EkSNAc4CeQOAO6XdlBFvpIFyE47iI2mjdFIqywmjFyNmxqpwsgU6fTszSFYztpuOZEuR//Fgc6YRMiggElUl4hstJliGFtE5fFvTwAcUZllUFfMW6GhH0/V1AK4JMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352646; c=relaxed/simple;
	bh=gLYJ/tvikVJD261WQ8Bnm0r9paDoP2JeP0aFQhh4qUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZczPndR7NpyM3fzKWcg6XwLcbjLdCXY56UvkNxOFnO1Y7YgYZwbT7Jf3QMDjCh+TuKo0vNnbmwoCbNPjCcMIV4r3hHsOvUtrkCwH3zKgmbu82iQRH79MlQdRQoeWOgMxWFlhptAp33tIJZGycszWG44JhkbgqfEGzSpMxOCjHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJH1K8iK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJH1K8iK"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1362980a91.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785352644; x=1785957444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8cYrrvUoYS01HckamENfIVCtypmUIu/Ic6/OpmpgsnA=;
        b=cJH1K8iK2Z4qXyMtMIlJoWDxLCGs7RfVxAWhHyh/4M+Co2CZHXVTP6ZcjFT7fBi52k
         DFjIeqEDRIuvUssqPkmRwP7oe/ERPoR4DXfCPrZsx/XX1+ms73kqnoPvfYOrSDhj6Do0
         /skIvKu63mwdYMuAoGef82PcG7uzUa6BRMV9oVV6c7HgyOskfywvenUFWEZpZ/L2XIza
         5ltpU4CXTR9c0NyB7HYuauLoS15AX2u66hK0dAnJy4JWeHWhB/Hmp2IWCDDbLHbMDFM2
         olgEFdgbnDOJ8Kk5ZT5+Q1lx+cObfyFAg2wTdYzXKKkwY4xNPWvSrRWIDnbYdi8oRGjF
         8Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352644; x=1785957444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8cYrrvUoYS01HckamENfIVCtypmUIu/Ic6/OpmpgsnA=;
        b=SvZx6lxkg4mtrEv9lFMF1zNVa35vT5tFvBYAmntiurGk7piLTbSs3qxTV32/atJdTC
         kb0NaiuLG0w0/j/jk+8G2z+fIxVAB0w7I6DJsp8QNMgnXpQ9R4YPSArvg18ytrumZY2M
         NKKSj0tBJC4J0QIm2afouRKbenbckxmcpmoNzKUvcwKcDL/v7NA15vEtDMqfK37Z69Hf
         vj9nkvdqs37/+NC8KIXnLTJckL8JDRC/DhoOChL2odNJlpOzLSYCmbiRqbezjX7GYExU
         gssKlBuc/s1k4HNq+09wSUqDRnW8wMTbdRY+d/GTCP0hD8isiYvfjkFcFRmU+iYqOWgZ
         iCzw==
X-Forwarded-Encrypted: i=1; AHgh+Ro+OanSvWxYbvWOORuKJdi/z/6mv1srogau9SGp+qRiuGi+UCRTLB4gfawmVa65RSjc1aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyBAgpp/v1dmpN7kYpBOgDWciUc6SeuD/Ms58DktpzWNPfAe9W
	tI/DJ991/yad0vB/5XI7xQuTfz6JBvTZQyawoksP63zdIIQulpDKMtUQ
X-Gm-Gg: AR+sD11Z61dyGNY3N4YE8wySDOrf3cXh9yvbZOjBRlE/y2GMbbF9GQ/M7PdJcsF8oiN
	1Ok2OdqVL5zF3CK81yFjtchrfhNc8XPx+e1edd9QSukgfO05V+a8Ezb5AeJqT4NhHVx3x9Elzwe
	ufDVUxksU1STnZd+Q2npnZ1a0PKPHjn+JRdkHJhFRmlJKnje+tSecqusg2FVwU0ZkICSH3fR0Up
	euvAPbLC6xJdkPt3QVrGDCeAVm85Pj1WTWtEkZ5sTaW3kpZodDkRoB7ysYjPTgguhq553uuztNA
	g2oNf/5VXqTd7NNlbOLaDhG7rxWiUlmr2ShEdNmK4zDhK1BUXoXEe6ErYl4thc4MSsqG65KhG/j
	ySrSqh6540cb83+2woEQTwXXFZwnQT6g0HLglwlc3YPNh4aZExUvX2LNVUHxJMrX8R6gbnFGayB
	HglEDAFosn5htVhLLyb1NUul6mJ+WYwVFyOucMfO/a5pFEWFHEWi/fPTxZfKkF38oBO73o/u2dP
	bfe4c4=
X-Received: by 2002:a17:90b:5484:b0:38d:a150:ee04 with SMTP id 98e67ed59e1d1-38f99384981mr116539a91.30.1785352643745;
        Wed, 29 Jul 2026 12:17:23 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f81543abfsm833349a91.4.2026.07.29.12.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:17:22 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v3 0/2] vsock/virtio: fix worker access after virtqueue teardown
Date: Wed, 29 Jul 2026 12:16:53 -0700
Message-ID: <cover.1785352330.git.bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729185831.3247971-1-bestswngs@gmail.com>
References: <20260729185831.3247971-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio-vsock workers can remain queued while freeze deletes the
virtqueues.  This series prevents workers delayed across freeze and
restore from retaining pointers to deleted queues, and prevents the RX
worker from refilling its queue after teardown.

Changes in v3:
- Resend the series with proper email threading; no code changes.

Changes in v2:
- Split the worker pointer changes from the RX refill fix because they
  fix different commits.
- Use bd50c5dc182b as the Fixes tag for the worker pointer changes.
- Keep b917507e5ad9 as the Fixes tag for the RX refill fix.
- Use the suggested out_nofill label when rx_run is clear.

Weiming Shi (2):
  vsock/virtio: read virtqueues under worker locks
  vsock/virtio: avoid refilling the RX queue after teardown

 net/vmw_vsock/virtio_transport.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)


base-commit: 51b093a7ba27476e1f639455f005e8d2e75390e4
-- 
2.55.0
