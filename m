Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E03E959D
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183029; cv=none; b=fMnDgfsMQdZhQrkEjieO+FxWI5jCKvWvJvw6QGiEwJ/hDzGt18NHkkjFgTPAljf3IDbqIEx1NIHWQe/Cd5dlVN5ry8CoarpDTLmNbX4ej1KVSimplPqZPnQ/3FiJbC1eZkfaT2YuXaOjet25ff/luNLu7C9mXb5vtwMH6MY9tLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183029; c=relaxed/simple;
	bh=2xDcIT3f78H7eKHRPribLJ8e2LZJl4ii3oNMP2ytE+A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ghc+F586sabU+shNT47uAslswMONvXf3xm6kqT3qmy50buGUZnSnK6KKRTZps2BRhl9t7/+Efij8xIl+c8iKaPB9RvfETbB6eo67EgVgnvqXuJMXOFAkxhDLg4jc8oPSadHsPtmEXCCGQKw6BMwrglDTNTMMSqyaXqvkByZDGwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxFx3XK+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IY2rJ+zm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxFx3XK+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IY2rJ+zm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776183027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dXlPrnMYysHI4EKQcfAK7A0hsCX8t6PffR9osO+JIF0=;
	b=TxFx3XK+H7CxAj0fPQCvS6rLNFkeoUnw9PMEXl8FdZtj3LUqNu8Jz4zliQoJd+3iUNlRiQ
	LHq9T4hG4DejCoQihKvq0/G//IvvxVz+YRxPNcc3Gq2vRfOoXg7X5erpOSpPlCoSrdrXSr
	/tVofu7aZaxmAcnZsyNg5eisLYWsdhU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-OrKtOIJAOPyAqygcj1itQA-1; Tue, 14 Apr 2026 12:10:26 -0400
X-MC-Unique: OrKtOIJAOPyAqygcj1itQA-1
X-Mimecast-MFC-AGG-ID: OrKtOIJAOPyAqygcj1itQA_1776183025
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d00dd913cso6299391f8f.1
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776183025; x=1776787825; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dXlPrnMYysHI4EKQcfAK7A0hsCX8t6PffR9osO+JIF0=;
        b=IY2rJ+zmhY8nvEQzW6RRWXpktAcoH9E/S4apYcd3qEHsCvcl0tTuKq++jMiEL9ywJs
         RQ31BXOgtor9IRbKng9AFqgU377NOJbSxi74c4hWdPb4f5dO2f6NMBEBC2mtS7OjVBkS
         7hM70qn4NE6yr3UZG5WeluE8yaSx+iSlzgDh1UUOh9U5lQuexeQZMQRfL3xyXFZKx4S5
         n2KBLfNkN/kXAeKCVHN7lcmxLLbDJYfhkd+1OK2NwIoNwiN6p/DPA9n8CHjfT0lUrakK
         tfvgtm2HcaF+qoe3YiarIlJl/t9O2f/ZIm8Vj5NYfNlf8nNLSZpdNOKva7J8sxH8b7HT
         zMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183025; x=1776787825;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXlPrnMYysHI4EKQcfAK7A0hsCX8t6PffR9osO+JIF0=;
        b=VuazuQmFc2uj5XgUxoKAYdKJOnoqhVrpdaBsJ8ABvVbRT6ylanXga+brFQPjBbvH3V
         E2QMTTVnD0u3FfaWjvGd3CZGn18qhZHU3xoDvwqB2xBs3kN7eWZyqcLMfWbh5a2IQOfM
         rAZVR//o/gH5fBDk6mOu7sdTtCxHGMhMQCpam6K1uRCnHuIF8Pp/X3hh1z9uTVB2tRxt
         2B2Ac8fKxSHJgrIvJieg5+oqm65l07HtkZlZydbGDMVDKLOZJw/6Es6DJdpt0/t193vU
         PoOLErg3whPbWdRPup0rjtQJ5MQeGkcI1XHZySy69FEs8ALfX7Q8qju1qYSP/W47Q7Zi
         r25g==
X-Gm-Message-State: AOJu0Yw4DDULy2D/Hm80OFUMCCTRqHHNmturcYQ/TkuMaY7F6v2dJQzc
	PCBtvcVy5tEDYYeA0O7RaoaWjCL1BOrBK6XRJzMiWd1uYOtb6MwPQjNcjZlsMEvvhuhN+EfQsmW
	jMkXChonTKRXOX0e182Abd0werD0kvob4kOTneDnbKocfwJqU1fE4hw==
X-Gm-Gg: AeBDiet4RBCDgMS+KwOfY/EUQAP8k2oaGeND2vUxZrWvrYXIOnHAK0Ej6MdU6Fw1dCm
	dcom1JRcVclFZ3kjKdMz+MtMQ7WpkMMT2sJ9rSmEzFjsNwSuYR9pNho7hwmUYZC1hd4xuB8//d7
	OesIM+FYtLin2bkPT1egkBaR2Y+rvEfRft4Tfs7rxGR3ZJ0fHaJoXSHtUNt50t/FGfdLOhTSlcN
	+cZKes9aTyTUCW7vEqUM7i1gGRWltOWmdMolljVbV9SiiMQro9aDrwgjqHVWKod3Op0M4mTvgWY
	KQeMwGIz1DlQS5CXEwDcf1WKJpfXK/CbcUTzx+w9FHaUKMvBVUEK0UBiocKV/0sYIv9fQjFwCPv
	NC99Mx8aKTNgF4EcJjKKEN0BOuokpt8MFWOPe4yaHy1Z4TgUGpiP7SfyS4HXq
X-Received: by 2002:a05:6000:24c2:b0:43c:f90b:5668 with SMTP id ffacd0b85a97d-43d642a7a6dmr26523581f8f.23.1776183024778;
        Tue, 14 Apr 2026 09:10:24 -0700 (PDT)
X-Received: by 2002:a05:6000:24c2:b0:43c:f90b:5668 with SMTP id ffacd0b85a97d-43d642a7a6dmr26523479f8f.23.1776183024220;
        Tue, 14 Apr 2026 09:10:24 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec090sm43035268f8f.12.2026.04.14.09.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:10:23 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net v3 0/3] vsock/virtio: fix MSG_PEEK calculation on bytes
 to copy
Date: Tue, 14 Apr 2026 18:10:20 +0200
Message-Id: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WM3wrCIBSHX2Wc6ww9rmld9R4RselZk2gOHVKMv
 XsiQevy9+f7FogUHEU4VQsESi46P+YgdxWYoR3vxJzNGZBjw2suWO9et4nowRotVadl3RxJQr5
 PgfJWVBcYaYZrLgcXZx/eRZ9Emb4m/JmSYJy1FlXdG+qV6s6B7NDOe+OfxZJwS6oNiZlEwoMW1
 uhOmT9yXdcPjfM9XuAAAAA=
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
Commit 2 introduces some preliminary work for adding a test and fixes a
problem in existing tests.
Commit 3 introduces a test that checks for this bug to avoid future
regressions.

For disclosure: this bug was found initially by claude opus 4.6, I then analzyed
it and worked on the fix and the test.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v3:
- Addressed reviwers omment
    - Dropped test client, reusing the one already existing
    - Minor changes: added comment, improved commit messages
    - Rebased to latest net-next
- Link to v2: https://lore.kernel.org/r/20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com

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
      vsock/test: fix MSG_PEEK handling in recv_buf()
      vsock/test: add MSG_PEEK after partial recv test

 net/vmw_vsock/virtio_transport_common.c |  5 ++--
 tools/testing/vsock/util.c              | 15 ++++++++++
 tools/testing/vsock/vsock_test.c        | 50 +++++++++++++++++++++++++--------
 3 files changed, 55 insertions(+), 15 deletions(-)
---
base-commit: bc28831d7a09f7058cdca4658d81e5faf635bed7
change-id: 20260401-fix_peek-6837b83469e3

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

