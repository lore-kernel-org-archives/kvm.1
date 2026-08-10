Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E33090D9
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369262; cv=none; b=lxnxmFOyJi+nOSYmCei3IGk+iwDUmJKQkUu2W4cdWqT5Z1C3jTfhnjUWCKtIpSxABfMA6KwHmsAObcC7auhAkOjz1ZvSuP80NIUFBhP6tAmPPd2Zbf+YO1goboskI22TWh10diIun+OqA/EU49vyTllLW2ARVuUDElE8Ankb6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369262; c=relaxed/simple;
	bh=AUbwQjIMvFKx3j6iyCHUmQeCfVu5WpUz9Qg7tHjkwWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CKFyqAgM5d9uv4VHRk016G0X4wjYagXMX5CzXJ7A520wUy8Ih1wgS3m6HlLeFWIdpmSgLxvHhubjeco+BK2Xq7RSw0o2rFIeUcImLj1rw64BfZK+dI187mFPopVu8+by6RR5OyP1RJYOm1yQtJRHGrLd7K0YB8N5g26p3c3upIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=plw+cpYr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plw+cpYr"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e507b079dso1088517b3a.0
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786369259; x=1786974059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rN0NY1JfJxx/3rIRMWpYI9WN4m1+geIAl9racAyY7U0=;
        b=plw+cpYrYXm9BoZSdXeu3JQfMsv8d5lG8nFYBQOoQ8cVCj8f2JvKq9H4R49uUeVoTQ
         RX7cDvT9SWYpoNerZulWyJvCJ1vYA4/Y4Xsg+K5kshOCblHI/w73XG8xHbf2ZQuNEshs
         m621IqNH6/HMQqhtAtM+yLg2dflSQdlTr1gwAskrq7+VKqP5lSkaSv5mmoiwinaeDq1N
         P0kdS0BVNqgbWSqo/eLOYxCqYITBGc8ZaFYuZk6O1p7V7fiYGiupKQY9jDqOB6YwvyeI
         ct/EnAgEXrQLjVSQO2Zv6/U/zvEU6+pnjsQlr+8+FQGdd8fVvr8bPh1KEJf/614hUS3h
         lBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786369259; x=1786974059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rN0NY1JfJxx/3rIRMWpYI9WN4m1+geIAl9racAyY7U0=;
        b=VQwYBcq5SMEYLN0H9pJ/vk0mBNmx8P5dOzEW/MeTuhVkDREW/5G0QRLUN5mQd2C/XF
         ZOB/b5HW5vmVeVpd5rQ6RrweZhO6/RTwGJG3tujNRwcxfWLPk37dNaNPXeKaGF/uf1WP
         Jk2pDhVsaafiqNEVPz1FClJ9IjVc9245uURzMLxof4bvp+DaPhEQlek0rpE9TwzrgxIA
         vtNd5uJYfLQDf4pb/kwixr5E4wmHwF0hMvJ0AKKXYjiqRQViFlx6vSoleEjxB979qYwO
         iYgepdD7/1gLiC6HYHuDq57X/Tx+8NHmqKPs4Ipo0qJZcyCMJzbbWgkP3FC2PQhDsk/H
         dX/w==
X-Forwarded-Encrypted: i=1; AHgh+RoEodpX9rNhfZX9MV2HaNQCcchDfQ5sWsmyvXKwyQFbdV9xF3wshl35A4nJDdLSaJlu2BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJtFChxHOSJUE6joFur8q0tfnZqPFytg4mqgs16/wEi1OJL5n
	fTMPnRq67FrCgxzEJeSscBCdvS9wpraO2w14TdjBWkLF4Dk10J5+qauG
X-Gm-Gg: AR+sD13ZP/VzdBgDgNumRtcVSXxvFB2dOlkNPGiClhIJ22iATdG0Vl3hoCgWkSTlJps
	6k1bHhtu6atHllCnGCHq1SKD/2fhGgjS2nF4igvSBA193GTcqQivK9CHbIMReneHTNyAgks7faE
	nR0xOmtksAW2ujj+rdCFfwMFa3BXFrgBg7hcoW8+AGRCDXFnFIXBZZt0dh6fILoiBbGPMDfuM4p
	4gU6N3A0T0j2WjFyLKR9ZIV1ZwN6M1TaPH7U2FuZFXOGibFOFW2Ko20SYeoatqltd3tOn9vXs1k
	QX4C28/462K7j27ALZBjgpYmxQkpQBiDKHrhgdJFkfFtvZFNRGwRBcTN/psDXmcCY6FnN29qXWe
	qWtHbu1JS6XxIbMtX6SDkmMErIqty4bzkLCgmzFeRgtXY6KRWtHaHEqA2dYrmrjay7uAhvLieIV
	RuPn+3yi+KajoxRtXbFTObhb3gAKns9rrbs8+TK4yUMpgoi36ueeOKkK0eTQokG8vmL+cjrKc=
X-Received: by 2002:a05:6a00:982:b0:845:3d82:10fc with SMTP id d2e1a72fcca58-84f6926b235mr20673646b3a.0.1786369258800;
        Mon, 10 Aug 2026 06:40:58 -0700 (PDT)
Received: from gmail.com ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51f166sm4006236b3a.35.2026.08.10.06.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:40:58 -0700 (PDT)
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
Subject: [PATCH v3 0/2] vhost/vsock: fix device IOTLB feature lifecycle
Date: Mon, 10 Aug 2026 21:40:16 +0800
Message-Id: <20260810134018.143973-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost-vsock leaves the device IOTLB attached when userspace clears
VIRTIO_F_ACCESS_PLATFORM. It also replaces an existing IOTLB with an
empty one whenever a later feature update keeps ACCESS_PLATFORM enabled.

Patch 1 detaches and frees the old IOTLB when ACCESS_PLATFORM is
cleared. Each virtqueue drops its IOTLB pointer and metadata cache while
holding its own mutex. The old IOTLB remains alive until all virtqueues
have dropped their references. Queued IOTLB miss messages are then
cleared and blocked readers are woken.

Patch 2 keeps the current IOTLB when ACCESS_PLATFORM remains enabled,
so a runtime logging update does not discard valid translations.

Changes since v2:
- update each virtqueue under its own mutex instead of locking all
  virtqueues at once, as suggested by Michael S. Tsirkin
- keep the old IOTLB alive until all per-virtqueue references are gone
- clarify that the teardown drops queued IOTLB miss messages

Changes since v1:
- discard the existing IOTLB instead of returning -EBUSY
- split IOTLB teardown and preservation into separate patches
- clear queued IOTLB miss messages and wake blocked readers

Jia Jia (2):
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/vsock: keep IOTLB across feature updates

 drivers/vhost/vsock.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

-- 
2.34.1
