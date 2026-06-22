Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACAB377EBC
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167299; cv=none; b=iElqiCHOdJRUTlUTjFbXaYxt1Bts48+Q6agJu5d7bOp71TEvS8IT20cToNrxDR9s7oV+R/PH/Y9Pv2nnPoJLA5QX7Ux7UZ8/k8irYBj4SK5rxoytPSmtnKAEZhvjUeaddZDhzWWIvXz2z37CdbZe4n0rugUorXS7TqGmfd8tNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167299; c=relaxed/simple;
	bh=SihlRBBTVD9/sumreJgofJm7EYPORk4CoiN8TCjcnAY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mZTHxe2LkWWGATPcqxZ7DajK3CEs21NDVlUP4CMOh7UztFMDam38wFgZUKYTt5VhxVLHbI0KsldZxtx/Wd9HB6/RO6BU2gGu8vQ/noVN46kHSJ09d/PIXBFfxFjRT+4raaOVjWoLB3GwKYFHHJd9zGxuHOfbKsvl26oup2rU9u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GHV7hX84; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GHV7hX84"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84540760dc9so6789150b3a.0
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 15:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782167296; x=1782772096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fVIN0Q4+496+/EZ2BPsuqq3VkPJBQAckK67gmjBeUzE=;
        b=GHV7hX84p7i39M/dJzX+Uufo6fjpaodtB9Cxt49JgOWcoh5TMOEG2K4UGbdxQzlBQZ
         75ncEQ8rC08+PJhFBssca3d9GSOZyYnDn0WUai9jTcbUn7K1uz+FCwIw+eNWdqtXN/dN
         mLjxPtJ11qzfshtPkKVtBLNwzsi5JEcDl8gvdzMh/JyfSfEwuWM2IuRkYrCMKVCKbaLE
         uP93Vl0IA1UEpQJnlUCFQm4zkewGvchZG1lbJHy0kU76f5dlvuOgOpeNNOFW7wNyb7Ld
         7Wuc/cxMDv1r/MC0f8IV9b03alLSURxwhKsgs3WFRta07hCL2+nrzXrgkAgR487vmoVZ
         iOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782167296; x=1782772096;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fVIN0Q4+496+/EZ2BPsuqq3VkPJBQAckK67gmjBeUzE=;
        b=X8tQ+ZCUp0oprNs89lFjQAi8E7ANAJWFs48YfLzf5QR2u2g0EvOoevPzCvUQHdaEKX
         4m0eHMfmbK9Pl4d0vp4YwmNCY1XAQ/JsEyUixGN0zZCTSSIu2dmRVwPFNbMkYjRHrXB7
         WERB0nJqpBnqjFH/AZg31GIha+7yx6GVfl/aEBw0z8qLJf90pY8tEgKJhoix0ejKdZe+
         g9n8r7138khODnL4bpg4v8eFsjWtfMwtd5Clv0zedI8lKn/XXXEugheKXjgbCL1ief+v
         NmLgLLsuR+vydIehKy/wXce3HZq7WQcVzcxxsSVwUCpAZtkFD32sZNF6RTKCnT7Qe0LU
         +ScQ==
X-Forwarded-Encrypted: i=1; AFNElJ/iTT1c/4JhhU8BT+CaMEJx3ui2V9V67Er2UNuLI8smJ9o0AH0vZnzT7ueiZ69erbAbj/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcS35H4o/3QxobvGEfE2JxR+++FjnTYpC/NyFEesfk25yiZgK3
	WFgsM0l2SGA/VbdbYJrUVzwTUI7dJiCu8UYsG7ZdseM8rp+6Q83OSwO5FB3ZrPH7kNe58F2wVzc
	VYA==
X-Received: from pfmb6.prod.google.com ([2002:a05:6a00:1146:b0:842:8ec2:ef16])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4004:b0:845:4c76:e46a
 with SMTP id d2e1a72fcca58-845952108a1mr266932b3a.3.1782167296263; Mon, 22
 Jun 2026 15:28:16 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:27:55 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622222757.2130402-1-tavip@google.com>
Subject: [PATCH net v3 0/2] vsock/virtio: fix msg_iter desync on transmission failure
From: Octavian Purdila <tavip@google.com>
To: netdev@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Jens Axboe <axboe@kernel.dk>, Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

This series fixes a msg_iter desync issue in the virtio vsock transport
that can lead to warnings and eventual -ENOMEM under specific failure
scenarios (e.g. partial GUP failure during MSG_ZEROCOPY transmission).

To fix this, we need to restore the msg_iter state on transmission failure.
However, since virtio vsock transport can be built as a module, we first
need to export iov_iter_restore.

Patch 1 exports iov_iter_restore.
Patch 2 implements the msg_iter restoration in virtio vsock.

Changes in v3:
- Use EXPORT_SYMBOL_GPL (Jens)

Changes in v2:
- Use iov_iter_savestate()/iov_iter_restore() (Stefano)
- Use a single restore point (Stefano)
- Reverse xmas tree (Stefano)
- Added comments in the code (Stefano)

v2: https://lore.kernel.org/all/20260613000953.467473-1-tavip@google.com/
v1: https://lore.kernel.org/all/20260609004809.1285028-1-tavip@google.com/

Octavian Purdila (2):
  iov_iter: export iov_iter_restore
  vsock/virtio: restore msg_iter on transmission failure

 lib/iov_iter.c                          |  1 +
 net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

