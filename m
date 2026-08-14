Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86772E3FE
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718822; cv=none; b=V/3NZl/Vdflh3DWYQMFExqsNK1uYdV1S5Vgoi8E7RFUaL6V9GtMNw1eSWeoXriFCghMCHyDasunsepPxhvw+oqfaDF6eEVNrYL448wk8YgeR51WCcTQzHCXpw2CAaN/5k0vYPX5PyZReKWaiP5n6sZznmzPAXewITI6pHGJx2Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718822; c=relaxed/simple;
	bh=AL6Q65vw+ZJt4TGaGgMNlD2ik6ILvC2I2FVHjTJiIRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ceZd3V82PlJHnLSW8BMJsM5RhDIQz0aBOUXMnREb6AgFynrLuEDW+YLUNqZIwdTE/hMwpfBNExuuQ9qkPBhHQO4qcY0j9z1FTtoHHgbvj7Z5jRbQ58fCtMNTFzr9vPQij7ZQEWqiDHYEflLjlGVIo0sfYub8kzlIo8r0SSZXQV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlJs5qbp; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlJs5qbp"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3900e39d935so1065987a91.0
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 07:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786718818; x=1787323618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xLjQg6E2MSVykNQCAn00xe/LP5TgPchFkGhjlJGqvKQ=;
        b=qlJs5qbp905lKSmzsXw8P54X7WIpLnYmXJQDiFBZnV35yodpiBtg2nt3LQZj42mcbm
         C/NMK3fPr6knkSiRtvER/P4TYtUg8ywRAYghgRjh4btmIqKslS0sddqBP1ukC0HEVq+a
         HpQgte3JG/885v7Ej7JpJnXbl2Wk23dKsnS6uw1vATP7e+mSTcckG6UokMUiQCgprBFh
         sYQQUAgXZ4gusGNovqmHhxQsK+Q2UbI9scGXqK15ODw5nR84KQgAvtUsslWqJlT2xWNV
         RJvDjJVBfkbe6nqWaFt71DwkhoZtJKp+pxszHGzuXNYXwQ6+wbOzF93S3AbfWb79I1zF
         0jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786718818; x=1787323618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xLjQg6E2MSVykNQCAn00xe/LP5TgPchFkGhjlJGqvKQ=;
        b=Y2MJ1cPQI15fBAhJNc33dIVLQ8mHHYDbwq9Fd/rACSlIeITez+GdIf7dZcw3O1VU+d
         Q2yYrMc3CRx5HTv7mJ0Y0MZs3XGw/Xg4EtbDC6iiSMKMAmNqBIybFguLbzjt5AxLHvvi
         2RDp5UdzHDnYsA4yNdGKFvfEr5QKqY1/jxhW7Xn1fTz5GuR2vvvC5hA1X5gI450ySTXw
         a2R0AeE9tnq/iwstyMSN8wPbDi+kyAVFoxoMqLhv7zQ9yzOt/OPROXY2ya0QFR+GNQ9F
         2thO/sExJA5DhaSXO6zWanIFnQXgeVXizf6mTZvl/Hi1lqtfBS/s0C9izeqJbiXaHn69
         qf5A==
X-Forwarded-Encrypted: i=1; AHgh+RqeFy88WCMmdVoF9900SmdTEsXd9iTUls0eLsM133qqMeOBENdseQwJbkRAT6RMjWr7Gz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDSkMzK4kYvBgLUZNzh8ZI52qct/VsGDLfBfm0kDIDSfBLy1z7
	bmXK4g09l/0qDvowW/WG9jGvOBM+Ko4Qvg3/K3+O4eDiKEl8k3oBXnsj
X-Gm-Gg: AR+sD10Q4+XJ4NPdqgkXi1zKpItmPEWAJRccTkrltUBoCWp7k47taITqWq+9C6RCjbl
	SQf2pYQD2EL8AbFM1wJosI4G+KUlS3FZmwr4M7roYtPgXylIbmSAr3eGEVybKHeGxXR7QB4pb1c
	2brFq37C9nL+8hXltbik1aXJdZQ1W9tiTJCKeqbFqVEnvDVVEKNmp93+pw4EKwLI/bncnzXNJgz
	WRR4f/C4pmM/tzt44rlEd88LI6Kv8bjj8PspyLBS/CpbtbHYmfNqM9axzIgXZgEpZxttSW4APrs
	Rp6KPk4rlTeIFcAXwjXFI5EwvAnIwJlIpwqwWBeKKpr3u5If/djOkWAV8n4Jdwz7QjYiSiG3EOj
	rZ5SLUyCHpwF+uH2VAVpMAjAWtUjEH1PaJB13aNkBhL60kKRdjnnrGSTZuxt4alGQTTBC9TacgC
	I9/B1r6m/m0+GeKmI4YY12weTfXjXOVma1VCjc1aF0iRSHrDoQgVYft/lxBiPb0OI=
X-Received: by 2002:a17:90b:2c8d:b0:38f:caa2:5721 with SMTP id 98e67ed59e1d1-3933e62f4f8mr7303910a91.17.1786718817623;
        Fri, 14 Aug 2026 07:46:57 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413889bca5sm14642249c88.12.2026.08.14.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:46:57 -0700 (PDT)
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
 [PATCH v5 3/3] vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Fri, 14 Aug 2026 22:45:58 +0800
Message-Id: <20260814144558.134314-4-physicalmtea@gmail.com>
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

vhost_net_set_features() leaves the device IOTLB attached when
userspace clears VIRTIO_F_ACCESS_PLATFORM. Later descriptor translation
can therefore continue to use translations from the old IOTLB after the
userspace memory table has changed.

Use the common vhost helper when ACCESS_PLATFORM is absent. The helper
handles the no-IOTLB case internally, while the common initializer also
keeps an existing IOTLB when a feature update retains ACCESS_PLATFORM, so
logging updates do not discard valid translations.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Link: https://lore.kernel.org/all/20260726141158.1652386-1-physicalmtea@gmail.com/
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c6536cad9c4f..8d6f530f49b3 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1687,7 +1687,8 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 	if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
 		if (vhost_init_device_iotlb(&n->dev))
 			goto out_unlock;
-	}
+	} else
+		vhost_clear_device_iotlb(&n->dev);
 
 	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
 		mutex_lock(&n->vqs[i].vq.mutex);
