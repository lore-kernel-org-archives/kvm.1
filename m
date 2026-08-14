Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0F47DD4C
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718806; cv=none; b=mMe4Ckr43dd+qqZe+NOUjSumjzFnxSJnaQwL42qU9Ryao5M+ZiRK1KzqMuaWKP11eva9/6/TUFIZlC24jP6MjTw9nG/Tc3BE4o5fzAsmGs+aal4JfaTWFl1qr6IxLfw8C7GaeKuBm6KJQuHlFKQdm1hSGlDB43LDGLDbKQ8zZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718806; c=relaxed/simple;
	bh=7Y0D9/fB4CPNrZj7EyeDRq35Pf1NaBCqtEh4/sL8M4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IuHZO4IOYlTtzgRr0Z8dxCHwFqVff+gWY3mWsdo0E1WmC1ZVMr6liL8og2RRYcbRLugKFpt+lBnzVkN7k6BRsYtpG+zWZUN7prUmd9ElV7ptOiNsXxBvxxby7G0TZOxRPoxKiw2R8NnX6ClDj7WbLEuHyfA3tvK4ceg8c0qN8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHp3H0Tf; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHp3H0Tf"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38f620399a0so935137a91.2
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786718804; x=1787323604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B7vE+GY2/DQc/aiTWp62voffhOJnyDy6ZbmiuSnMuXk=;
        b=OHp3H0Tfa6zwD/kiiFqV0GAn5tQM8Fs4fgvFr5edc+m6lWGA95FLsL7ag/zjoWd36b
         ZULUgy2HmrSMArnexqXoacab/hOA7SfLYO6g6H4Cn2zIxUHHA/n4I8KtHDNRw4Ysb8Fu
         Qdr7JQvWA8+XEiVdYLs4X/EGLkQau4MAssvGYkvvh3YYzmEuBMc3SGRJQKuHPSv9T09/
         DuArat/r43fnVswLZfiOb3bA7ANOUrGCv7KfBNnY53i14lNEP8E/Mf4LoPKm6JoFIoeW
         vs+Nnnn/fGM3su7FHk7o56K7XdmlARHmHYTbQ1ZeMoW2dWWq/96MHipnhikmg6wKndaC
         MIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786718804; x=1787323604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B7vE+GY2/DQc/aiTWp62voffhOJnyDy6ZbmiuSnMuXk=;
        b=rJRagbqzrTvF7nIDLVh90Q/6L7YSBrghHIZYKYJ/uTzzSiKXGBJt7DlV/+uqRUJzaj
         HCHMlXpIVSvbEoNESJS0r14mKXXv1vgYPNHrh3pMU64BvHo3wfGzujNK6ViTCpymGfyP
         rkQ3TSmm5XN3C99Xl75KXiqqIMMSej46LjHEctuJnqLXS7yJWVB1xUAtCzeTYXSRC4iX
         B5dtQjKrZQq+J0Tx1iJGlHMUESmECnfqLA48wLxkz/wt9l3ssI6eymTYKbO99Wg0YRKM
         Oe5rGp5bPrWaxP7GK2TXPyOCjGn8mVqfTnZQDDoVeal8tSTMBEpqM526ZJn8uvvybpHv
         b7MQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqq+/yrjbtE753kuXOzOci1ta4tpvRTUXmEniN3Fm5hyb67LDGcwSI8/IUCDZ7OLV5CdCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRtNAZ5rBgwK1ezkId79dzMsyGSFIoe64QOZs8TZ1wgjP8scVt
	K81SzVccIUYuCfNj4fi8KP9B1pOo9NU6Acvqxua+zYId6nSNOjnFJjYf
X-Gm-Gg: AR+sD13ZPS9vYfm3niIAYvUgOov6baccbFZl0CjooXccvfBcBZYR9r94ttIMH7NCIhb
	uUwauDNDW8QaDkLciGyOfs3H9pM0/w0KMVLs4YqihymfmDePG+6aIfN6zXHWaFTJeVhnnMAYewv
	2gq70Fj9LvH40F/nJS660//ZtDHt9Q78Td4jjHk+9snuFE3NxoU6zXo+wqfqzUNnATiG6Zk321H
	U8KtS6/sqkdFJVk+vJhbhmKhQZlFPRpPMFyXRsxyx62NkV9gK3UnGL8+vuO1wQGPbpr5sRZ/PHH
	TuppbcJ/4jouTCmkgwRAlYzPhH8kWfzwur+gVAFNTTOsTd1GsvBPr03uOZqBFTlZ6K/DUynnXNh
	qIlWAxGCb7xgIBq84nqUVsvbLNYuP9WkQZPQgVzbv0LBXXNDgXblocEAj2c8ShgDRd8vpJ3CSkM
	x7gpIhXacAsYmtMTLD42Nsbz02CmjGZ+setaDQnKphwnKUB4b/tP1Kq265OwDXIWQ=
X-Received: by 2002:a17:90b:268c:b0:38f:2168:b9cb with SMTP id 98e67ed59e1d1-3933b84be0cmr7541431a91.9.1786718803151;
        Fri, 14 Aug 2026 07:46:43 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c6f95sm14193140c88.6.2026.08.14.07.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:46:42 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject:
 [PATCH v5 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Fri, 14 Aug 2026 22:45:57 +0800
Message-Id: <20260814144558.134314-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814144558.134314-1-physicalmtea@gmail.com>
References: <20260814144558.134314-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vsock_set_features() currently leaves the device IOTLB
attached when userspace clears VIRTIO_F_ACCESS_PLATFORM. Descriptor
translation can therefore continue to use mappings installed before the
feature change, including HVAs made stale by a later memory table update.

Use the common vhost helper when ACCESS_PLATFORM is absent. The helper
handles the no-IOTLB case internally, while the common initializer keeps
an existing IOTLB when ACCESS_PLATFORM remains enabled across a feature
update.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 1d8ec6bed53e..1a61d7db7605 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -849,10 +849,11 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 		goto err;
 	}
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+	if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
-	}
+	} else
+		vhost_clear_device_iotlb(&vsock->dev);
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
 
