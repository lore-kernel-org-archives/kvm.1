Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C9230D3FA
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481712; cv=none; b=rraK/xpOOcaZrMqQfu05a7YfFeyp21D3kH2fXQW7R+3l7QkudVrMvSASueq9D5hBjQriR3NdQQbn2P6fw26t4plqMsJailUKUCedJ/ADtEsX6QZvSyhaBNngDWAFdiUSTQ6kNqq1clexzHUOy34+9/EARikKRbnwKjbh8wLQnfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481712; c=relaxed/simple;
	bh=Z0WPHV8/Mv0LIJVrKuAdJ28C6sgGsMyxIyrReBvVNTA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ISlwX4PaS8ny+kuEANi/JVsjRlG7M9JyNoXxC4QNtpd/Ce+JXZxETxmqSwWlq1ASuZgdXUiXySWtYrph+D35q1b1+ZKILGh7RVrsZ22VYA3KyGx2DULgx9KP2BjP0C/o4l61V3BzGUXdnmIFFgUcFV7sXrBMCJt1PRvCGhjga+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONintaID; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rjAFw1E6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONintaID";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rjAFw1E6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782481708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fZNpqQhDRtZVJSfSiG/V88dl8frC1MRUvBsYP5nVWQY=;
	b=ONintaID594/C4Yz8IzoOSuR0ase3z/+1poefy0Do+BEvp+DFiWbePM5692a0I47NZ3T0k
	kWpRMf/7ApIv4LIahq/Gh8l70CsA9YR+ktajwEiNgiE4F4+1XIaj9VPqiwo5PPuQMiBPAp
	mGayviLSzG/D3NX8v+zAW4zcAwdPse0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-uLMgSi3ROBC4hX4MRVxYCg-1; Fri, 26 Jun 2026 09:48:27 -0400
X-MC-Unique: uLMgSi3ROBC4hX4MRVxYCg-1
X-Mimecast-MFC-AGG-ID: uLMgSi3ROBC4hX4MRVxYCg_1782481706
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45f3d008865so710780f8f.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782481706; x=1783086506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fZNpqQhDRtZVJSfSiG/V88dl8frC1MRUvBsYP5nVWQY=;
        b=rjAFw1E658uQsQk1AcBH0QsphNx6dHH2WyoaVxn8D9JHB3RVm2qCS3jGLVLq6UmhF9
         Fgf2Hb7EAvmCE0axwO9+HkDZWUNvN+vYL46RYctwRflS5XdozIht+PuSQ69ckb3dq2WH
         Dw/SpR8D8lOUM8RSWNWHgFEdx+F6olMBtzFcmrLvWEQBj3T5ZI2yY8PYzpeeTvCWVRfQ
         CnWCtKSzeXMoZOXtFn5tXgfHz5aMBoH+AFya7d9FGYHiUphX/c6z5o4c+J973X2Nh5Dj
         +MgZluAcIJ7E6LOOxbl3LNL5CWVO/jAkX/S+7fIFF+SM5EYnIq7v1aAQ2UpSlVwgGa6A
         BbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481706; x=1783086506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZNpqQhDRtZVJSfSiG/V88dl8frC1MRUvBsYP5nVWQY=;
        b=JKqD9HVv6iwErl/1mtEhO6xkQPD3jdC3tTfn2+BMCIGr2qUalfDU/3s1dfazKs4BvE
         O7WqjEj+eCeXCpvD0yYb7X017snlUHexTQZC0i//JO9z0nc4/v2dj9xq2U93hrLKFppG
         M3KWJX8h28fNHOJhvY8zuqQtNjiF02g2v9lVMUg6ooHiIddiXJhASeGKAYfKSu6tEq+8
         p5lDZOPR/n34V0Z/1orASU9Pc+MlGFTJtyEkXee6456C7hC5dzX+ru1MwJYMAWaKx5PJ
         MPWhu3wLzrMZ7093TGTnas+fUaiYc2XzMtPqkl9tZj1+lPcPMQrAyaPfea2C0s84Nqro
         SDRA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4oBORw6u09TPh4WXWlVVnwo+7nHyTpkrs5hwiOcgchdcsFuVL+5PokhU1nmaOrl2baRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPk0em0cp6zxcZaGVBajM7GqA0KpV1tCVr9Yb8C+QGsa424PnR
	7hJCU7nUcZF4rwDaa8T3joCmiwy12HGJcMX9d/CgAM5iU+NPUgkOx+r/saRP0+0Ex2LG/EPmCvo
	UURZikog4Neup1/dSwwd2xGabH4lPjtZWWr77nlzeu6Sq2qUeWC0PVkRr2Q5fZQ==
X-Gm-Gg: AfdE7cmLlAOCbtw8HbPtXxH8HGGHKVt41OjaZExmG0GLLTWMbB2UHmpX1tEjapVGZ8b
	1lsEwofy/exelX84xRpU5roU+W16H0Zz61okRQnle3rv0k7EO/BTU8U9xo0fApeb65U1VLtIgtS
	1BDRxPbPLkLovr4P8PbYSq9eiBV6CmUMh6CWjuZGnYJCDkc1DehxnJ8UJEeCNIEoCXKP80tD3uO
	k6bJwPq4Jp86OFNFWYd+GAepaLqZj4qyPThOKp94S+KCA8bLPGxhZxGa5uAKYF+1kL45xUxLPtt
	G/XISO84KO1oIsVthBw4zsvDge1k+7Vg41Mt3jA2CKJfU9nScFM4orp8eopgsO76w5BfdHs2ieD
	AUL4CzxLVvvXOeoOo/O/lwSyFqn1dHoEHVRXztH5Vr4SS6Mw=
X-Received: by 2002:a05:6000:46c8:b0:45e:dd32:92fa with SMTP id ffacd0b85a97d-46a7efb7522mr18779373f8f.12.1782481706440;
        Fri, 26 Jun 2026 06:48:26 -0700 (PDT)
X-Received: by 2002:a05:6000:46c8:b0:45e:dd32:92fa with SMTP id ffacd0b85a97d-46a7efb7522mr18779337f8f.12.1782481705917;
        Fri, 26 Jun 2026 06:48:25 -0700 (PDT)
Received: from stex1 (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46caa798f43sm22722884f8f.8.2026.06.26.06.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:24 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net 0/2] vsock/virtio: collapse receive queue under memory pressure
Date: Fri, 26 Jun 2026 15:48:21 +0200
Message-ID: <20260626134823.206676-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
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

Thanks,
Stefano

Stefano Garzarella (2):
  vsock/virtio: collapse receive queue under memory pressure
  vsock/test: add test for small packets under pressure

 net/vmw_vsock/virtio_transport_common.c | 148 +++++++++++++++++++++++-
 tools/testing/vsock/vsock_test.c        |  87 ++++++++++++++
 2 files changed, 233 insertions(+), 2 deletions(-)

-- 
2.54.0

