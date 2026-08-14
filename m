Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D5B47ACFE
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718774; cv=none; b=mH1eZsfcxKdWK82dQHtH/thZgJz+rGgvooNzVsn4sfN9hwIE0e3AqNhXNmV9p3pwfAKbvtcBWAb82VAodVT0FquvkAMkoIuMS6+Wns7itGRKoGCDkmiYdKlkRyC2dSc+UU0/KypYNTS8vXEGWDYmKOhHGPyjAwl7JzqgFz3F38g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718774; c=relaxed/simple;
	bh=j/48CqOv5Aa/AgwEHKe/KPlAizt7dHvsChDRKjlkCf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j+srU55RDKXWqV2Anl7/O9SVoBRNplqvQb5Cs8btRVEdp9l7L8Yhu0tF3LaiF2MnUY1lvDjkcvdKQA1VP1OTgEH1kNHGBTizRFF/MPfIOXxNnVyKa6VbSedssmp8s3RUuxrP6hS5/k/fk4/f7dHTyhbxONYdsNtw8Nk0twau+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAP8DK/G; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAP8DK/G"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc73e322dbso17334515ad.1
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 07:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786718772; x=1787323572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ktbN0mlbgnTk1vGFkp72jrY6OVL4246SkIwlC5oRky4=;
        b=RAP8DK/GufnOjCir6ZqbbpbWfoQar+pEL4RsGpQcBSPHOJKnIn4EX0QSB35N6Pk5cm
         BgArLTE14CLbyxP/vJ0zD4qEg7LQXj7cAS/lE21FuN7V8LqRTIoB6bVF+wjNGa3BGNS3
         lf6uraxdHHEgi3qonzY0VFfesqq+td2wr5VBTEWi/6uTz7m+oJGCRHNZ3OewouU4sU1T
         fHVERZEAuuxCcyTrEK5Uexivyk+s1LfQE5DxPP4d2JilTBScBWrYG0oehy4WwPxVAzQN
         sCPkkTVSkEDwizj+yNWw2aZBRXhrKKn3k3/heG4udP1JkLfcgdvBbrNIQzTcTmTYIl0W
         luFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786718772; x=1787323572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ktbN0mlbgnTk1vGFkp72jrY6OVL4246SkIwlC5oRky4=;
        b=ijHD+HCl6oF6dgTKsSu6reu7eA7eV6ih4ufI83afb+hJBP/ry4xu77weY8Yo3nl9tq
         U7H7x9mIDL7BL2Z+ALj3FGnDd3EcYp4fbW7e1j0BKLlbPz/IupNnFN+D72Ouk6ZcNEjT
         +Cjric0ClWggJCwoDlomeUvrZItsjAuU0pd9wrkDP188K3P9hWD3oWnbHUFIIaBMdwq8
         9AEnB7D0kNiD6tBJOaq8IbU33SQK4sLjpocSNH0tLYHXogO2fJ/LbptG5hH/4HAAVRSR
         4wY3D6YV5Dxd/cgFvF0Z4BKyTffWa+9QvccDp/hNic/m0fp4xVNWeXb+6YEwqW+pjfh8
         sDwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpg3vKBAQgVzbDo5nj6ex/dUFGOPzeyq6fJf/lGkUAGXA60gTrOEKjmU4FuD2GaMvZo0DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGitR7AhgYPwAk8tX5DjmrfqOlwl6gVjMQ8Gep/SxCCV83G9Hn
	mr/0t3p/OYUpXtZS8uLLLbK1YRHPcXVaflO8KDN/t0hWxqP8Z1pcjGwJ
X-Gm-Gg: AR+sD13QiTyvXFNtRJJMBVssX4+N6Al8qvZfPvRf1Wp4Bss3gc+J/dvEV8qnOtX7bOS
	VhtJy7k1w3eIX+ELr17ShqWpsPtWdwUKhIhVP1J+9gLPyQuUN9yhy3hvroLUNGLekjiLk+lt/Ya
	vTLwEvZ7T1Jn7C6kqcCLrg02SP1xL6EZ5B35GzpungzTjLPr0g/aIfxAOxfCcCczudtbIRJkreu
	HY7pQ1DwGUx6K+FXsFwXhbO9zEQqPSUDtMZnA4+cUPkeKNYLsvq+0lYrv1weEjLS+01lDcMhym7
	Taw0whOMSsmIhxMeKgETWegj4ZBrM9/4jj57+oZSc578PsDzpz9e2hRfcCez99vy5Eq/sJAA950
	lcIN+UYwdfD+kpBqsO5op/ku3EwyfmbkHh6p4pKMmgEXjdXdfep4uaIcxUy3p3G0bm5cWiW+OQg
	IWsdnZGnvULXo9NIBzMd9r0dcadGNXjyDdk2Mu3tW0DsBDdUvCNE5hqubWI4JUk/g=
X-Received: by 2002:a05:6a20:4325:b0:3bf:7eb5:9459 with SMTP id adf61e73a8af0-3cc71fa8cd1mr7381930637.20.1786718771362;
        Fri, 14 Aug 2026 07:46:11 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d60eb8eesm5547344eec.10.2026.08.14.07.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:46:10 -0700 (PDT)
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
Subject: [PATCH v5 0/3] vhost: fix device IOTLB feature lifecycle
Date: Fri, 14 Aug 2026 22:45:55 +0800
Message-Id: <20260814144558.134314-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both vhost-vsock and vhost-net can leave the device IOTLB attached when
userspace clears VIRTIO_F_ACCESS_PLATFORM. They also replace an existing
IOTLB with a new empty table when a later feature update keeps
ACCESS_PLATFORM enabled, for example when updating logging.

The stale IOTLB can keep old translations active after a memory table
change, while replacing an existing table discards valid translations and
causes avoidable IOTLB misses.

Patch 1 makes device IOTLB initialization idempotent and adds a common
teardown helper. The helper detaches the table from every virtqueue,
resets metadata caches, clears queued IOTLB miss messages, and frees the
old table after the virtqueue handoff. It is a no-op when no device IOTLB
is installed.

Patches 2 and 3 use the common helper when vhost-vsock and vhost-net clear
ACCESS_PLATFORM. The backend-specific code continues to update
acked_features in its own virtqueue loop.

Changes since v4:
- move the existing-IOTLB check into vhost_init_device_iotlb()
- remove the vhost-vsock-specific keep-IOTLB patch
- add the corresponding ACCESS_PLATFORM teardown to vhost-net
- make vhost_clear_device_iotlb() handle an absent device IOTLB

Jia Jia (3):
  vhost: add helpers for device IOTLB lifecycle
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared

 drivers/vhost/net.c   |  4 ++++
 drivers/vhost/vhost.c | 28 ++++++++++++++++++++++++++++
 drivers/vhost/vhost.h |  1 +
 drivers/vhost/vsock.c |  4 ++++
 4 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.34.1
