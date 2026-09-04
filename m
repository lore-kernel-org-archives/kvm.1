Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057C4756CA
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522676; cv=none; b=HC6jBQsPQNq5zncHYmH0flZOibMgHSdKbLGQvU6MeYiv760doTgoIbRZVquWR9fXHY/KYOGJdkHmtvbiMfLRwX7LyrzRzG6oUo3aUef1x/kjCywZx9KspYDA+9B9Bl7zwwl5ck/dSVDye3kqbucWllFh9Pj3cRErnDKZe7xKWYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522676; c=relaxed/simple;
	bh=jTpms1YZuuw/EGVMJxJxkFdM1Q2Q6bKCmKEsPM3xqL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4vHgHZwnfxnTKtn1VxkiIaN5sPVL2psfWbdgPiUYO5DHziajoe/zHjleHLfDQHT8ZTA9S+zBxF99z1p00bbgm5wAVi/s/Rj3pHnI2Zd4ZbwXPpulIx913KgN6GtjXGc5/OX9STb4LlO4y8OkqZgsYvsIJZf0RZh2Irl6kIspUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjcVNoV+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjcVNoV+"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-398d2b28acfso655800a91.1
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788522675; x=1789127475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SeC+fdJ1IuG4HBTKinIorpYHJblRORtXEeUMokNHbRw=;
        b=VjcVNoV+uHO1lYRq+H4p++/zkWDxBS5cWAk0g2bCzjf8LLDSXAKIB86kpokylov4Zo
         f5I/YyIqz2m4yjGWf2oJ/dTntmZkYxXmTUjY8ZUzTSIfg6phKFNBiIcxMD5u5vo8BzA2
         boGOCIbX2ew+PnT+SbmoXI/ncE675fWT46cRCehK+IwJV3Pi1M5zoevkN8aI9kkFHZIN
         qspoxisLa1ytJHM0PfxTbJBME4PXd6uzbtZVmHAR8QCXLq6o22LC5Pseu1F2KgPB5izt
         Ht91QPXm0Yg/C83nybJoSTtqCKyeKAyFSCqeofZaQhI1Ofsr8ImbhN15biMq3tt5sjnb
         hQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788522675; x=1789127475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SeC+fdJ1IuG4HBTKinIorpYHJblRORtXEeUMokNHbRw=;
        b=Byx67JLe6XY60Pvf1kz3vAsvv0BxmCmdXzDQoYrV3G8x/PQ1BEJcEW5sMFBUiCEZX4
         GSyj3cMbtJNwIDD3KEh4Zw1HkQLDhC8U59nh9MUVEQzlFU8APQrGh2/b3nH6yWHy0KaR
         4ktLnzhrAnC8iKd1umENg4kN348pgj9RB+cQatgEl35kjjh/J2T7BdNuC4x2G06xE9ui
         CiqZMBs73qM0eDPGfd6xN6AN6M2PHFPj/6ZhRgPDzGn9LtjXj92iKawEF0kEWDgk4200
         2RKiHO5D3vtdIDafrRRUurt97dAc5s8jTBRgxyIAQBphF+RrIKIEtt1hTNKxAdN/W1hy
         b/Yg==
X-Forwarded-Encrypted: i=1; AKwUvBxJCpo0bycSGqg9Su5iEsDxYvGfLYPrCvGyfjrb7q0qyRY4FpRFglYBpZpVjvwlhjok6Gc=@vger.kernel.org
X-Gm-Message-State: AFuF++kQ40vALyz683kejS+k5B5pONkQqqCAorJ9bn/nSMMnV6eZD6iA
	JiDkANF50Wdu3g9Q9wXEWDqE4LcS+Sl3pRL+UmrF+xLcNMZcOCOXYbhD
X-Gm-Gg: AYBFou2083h7EI8nb0wGZp+wj0O4qTCSL61MrE34BEboQde7RHkGXUkiJPi34rl/zPz
	r5XHyVUM692YGQm6azkqOudtMbv1G3rnaUX2D6soHAO5Rj/x7Zmv3mlFaP4NSCuefJrP6GmTkhm
	PQ86nvtpnibmmBcq+hbVi1PQJIxSJPzLMGOw6x3Ek4qEFF6K3w6nd86Y43eASzbyoUqo5W+roeo
	C8T9EMmsKrICBsX94bMd1X89xacN9ZFKpnkWFy50O7GCm0fLN3pWYeqpewIRElGQbv8I9BQHe4s
	wsuXeFGnp5kSjd3x/tmxiC2Dv9O/H2glTOSlJZDM2aVTqscM6nciDNnkgFCJCpHmDPrNIfTZzQ8
	wikf8Yrexx8Rnd9lNAgdwZOSUI/+2UCwkmRsPmmI18d7BaBq/sL1GUnvNi5uVESZWzBtqFxoBOM
	IJ4M1W8Z2nIaaHNTehOYD5EdkCmSLwwdckq/d3Tv/sDGqQadRBw4ZWwoePf3EdNtCL1hD0d3Qrd
	vVIc5XpH2Z3MtU=
X-Received: by 2002:a17:90b:564c:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-39b2612338dmr9493372a91.4.1788522674427;
        Fri, 04 Sep 2026 04:51:14 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa37dbdsm5552932eec.11.2026.09.04.04.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:51:14 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Kirti Wankhede <kwankhede@nvidia.com>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH] vfio: fix typo "stucture" in comment
Date: Fri,  4 Sep 2026 17:21:08 +0530
Message-ID: <20260904115109.6170-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "stucture" to "structure", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/vfio/mdev/mdev_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 3b4aa0632fcc..34337292a9b1 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -50,7 +50,7 @@ static int mdev_device_remove_cb(struct device *dev, void *data)
  * @types: Array of supported mdev types
  * @nr_types: Number of entries in @types
  *
- * Registers the @parent stucture as a parent for mdev types and thus mdev
+ * Registers the @parent structure as a parent for mdev types and thus mdev
  * devices.  The caller needs to hold a reference on @dev that must not be
  * released until after the call to mdev_unregister_parent().
  *
-- 
2.48.1

