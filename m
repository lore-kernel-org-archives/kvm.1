Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640CD4C10F1
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791216998; cv=none; b=EmzRbFTM9S0jTE6dbWnZJqJre0xBcmxidPPcYiOUme/MHzGpWudz14W79jewi409v+jxC4G8Kg3hXqYTVso29q1bQOE4iRp9DDf0/7ys5J6/g9kCJLF3rwgtFFg52+4arKD01hZLyaG1hkM1qF9kUqc6t2JqccT0y/I5mGNdIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791216998; c=relaxed/simple;
	bh=RKzP5xYHx7ykUWadWThP1j3Bv7bddgBrpR4XChhQ9Og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ivbA2R0zEEx5id2sBd4Rz/VT30M56+TFi5rW2reEAMIy/oLsIVJKctiijgofn5E7aNWppOLT6Lh3i/75KbZPiMIbFOh66MwN5RIrzIocRdsqucYcasYF7x1JdSPD2rer5y4/DwobAvg0m2bjC5elsS2mt5NYskIxb40me8zPyX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=FUfxR+Vf; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="FUfxR+Vf"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a7d725ca09so668470a91.0
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 09:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1791216997; x=1791821797; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9v042JvYwgrOTfMUZGh7htN3q5uPdutTlCAPZEqWoc0=;
        b=FUfxR+Vfxkx8f4sAk3lSX1Y/+LGNAsVXecR7zzQua+vPSPHBbmkIwDlmopuBxrwUyF
         3fxu3/Avd+EGom2aINYipK1XsPXQGcMUUcBxvn79K/UMftkB2rruo522RSgtmbOJD2/R
         DUwWIjBFBtvau6cnN8Q5OHjOcBGwL6rgJZ1/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791216997; x=1791821797;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9v042JvYwgrOTfMUZGh7htN3q5uPdutTlCAPZEqWoc0=;
        b=dETWa1fhMZ+C4FMILAV1DNxhc1GrbK7OA/xDhx45GIvlhkuhODFHEZOzjevYZbztyC
         20ht2qaVPvKbOs/jWQluuqAoFzFbp1jM7FB5DBH8EbN8XOcSFEbSUWn4b+8cCiTfS/fi
         SwoYfxSNpvz7Is6l5a4mluOnzEetR/bbG2XdmfwFmT0vg99m4fcqfLz3B1CqKjuFRnnT
         TAdNjRe6T7bHuJ45z4DYEznaLHUT2KUkozJUbNkWktiFRQYMLMhSMEUHh46NVRWuobv7
         8Ks+CqXU2KSh4Q7OUJVTequvxEJCy/g5/HxyHoNur9yZ5+5KBex9dxL2WPcEnt+3oP6g
         ZxXg==
X-Gm-Message-State: AFq9FYK8WCm+CulBTgFb269CU9fvn58fgoRfCvfwIrNNKJwoTMEs3dEU
	q122aKpWtPTjI3ftB1ciRTJb81aSmRNCkmDLnyhEv+0i/LTfk7+KcSQ0V9dsg9jlmkM=
X-Gm-Gg: AYBFou2vUDxC33hk/+YUYoG6yAt8yPf5wTJA5iVKdpKTLNrkk+TMF88N0GvkrAdLNVo
	boMJyn66jLrVGRmnx2Yh3hggELSCTC95GtePwAxoDbE9oT8NXJ77g7+XJFits4Cc2mjoGM1ODbE
	w5Ff/brq7HPMHNP49q3TH/aeY6mgoTs9wqKHy8XZ0bREWUNdnDgxSe8czOUjlHTShZgKJ2h47Xh
	oWgH8EJdd0yNhlnMf925DlLmm82W0orXKGHPi23n8TRzNfVP6fBv3TYWvcvlUYnCvxzMt0TqNiH
	s6evr+EMfxGXuzC0gZP9hSsi5P4ACA/muxrYLd8875mEANCGRtVeS6zO8ErCoPuL2gl0B/JR7uP
	87Ts5LKsOz4BF0MilLdciV9JM92HZSdBB0joUsPfO/WIt2ptpF8xIylw0fJQjNzGhgVMzQ2DLuT
	VOw++NUQb1KslyoSgbeQ3eC7roteSZ390fx6IipTfvpCeIILtR64AdzLGf+DeOxbMC
X-Received: by 2002:a17:90b:3b84:b0:3a4:948d:9dc3 with SMTP id 98e67ed59e1d1-3a6ce6b409fmr9088604a91.21.1791216996658;
        Mon, 05 Oct 2026 09:16:36 -0700 (PDT)
Received: from [172.19.0.2] ([49.142.45.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cde769sm130688a91.13.2026.10.05.09.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 09:16:36 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
Date: Mon, 05 Oct 2026 16:16:29 +0000
Subject: [PATCH v2] vfio/mlx5: Fix boundary check in set_report_output()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-vfio-mlx5-fix-boundary-check-v2-1-75599d2f4497@snu.ac.kr>
X-B4-Tracking: v=1; b=H4sIAFzNw2oC/42NTQ6CMBCFr0Jm7RAoP0FX3sOwKO0gE7QlrTQQ0
 rtbOYF5q+/l5XsHeHJMHm7ZAY4Ce7YmgbhkoCZpnoSsE4MoRFsWRY1hZIvv19bgyBsOdjVauh3
 VRGrGuquuupWkBhKQFIujtDr1jz7xxP5j3X6+hfLX/ikOJaboauioaUhU492bNZcqnx30McYvF
 ucc98gAAAA=
To: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Shameer Kolothum <skolothumtho@nvidia.com>, 
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Seongjun Hong <hsj0512@snu.ac.kr>
X-Mailer: b4 0.13.0

Use > instead of >= on boundary check of recv_buf to avoid the bug which
the full message in the last slot of recv_buf is ignored even though the
received data size does not overflow the recv_buf.

Fixes: 9c7c5430bca3 ("vfio/mlx5: Align the page tracking max message size with the device capability")
Cc: stable@vger.kernel.org
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
Changes in v2:
- Drop the max_msg_size readability change. Keep only the fix.
- Add Cc: stable@vger.kernel.org.
- Link to v1: https://lore.kernel.org/r/20261004-vfio-mlx5-fix-boundary-check-v1-1-1d3b8e55e23f@snu.ac.kr
---
 drivers/vfio/pci/mlx5/cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index 5fe0621b5fbd..04180035a7fe 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -1644,7 +1644,7 @@ set_report_output(u32 size, int index, struct mlx5_vhca_qp *qp,
 	int i;
 
 	buf_offset = index * qp->max_msg_size;
-	if (WARN_ON(buf_offset + size >= qp->recv_buf.npages * PAGE_SIZE ||
+	if (WARN_ON(buf_offset + size > qp->recv_buf.npages * PAGE_SIZE ||
 		    (nent > qp->max_msg_size / entry_size)))
 		return;
 

---
base-commit: 6addb4f385570ebc11c4eb499a4f1c149f313e84
change-id: 20261004-vfio-mlx5-fix-boundary-check-4839d6aecbe2

Best regards,
-- 
Seongjun Hong

