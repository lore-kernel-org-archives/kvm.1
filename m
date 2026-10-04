Received: from mail-pz2-f30.google.com (mail-pz2-f30.google.com [74.125.228.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3063DA7CC
	for <kvm@vger.kernel.org>; Sun,  4 Oct 2026 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134431; cv=none; b=I9i+Eue4eX0EM9+e6sJL/UhBuTRtJPVcBrZgpZH3LTVLgGYpoK3ribHHAK31JfGerOWVvqXtAitkwOUTfca2VoN2XzTJUjr/ASyr1H2Fkx3LTixQH/YkjGn6Qbky42lpD7eOF111dI7kRHnt53zL82slslz4DmxOOuS1pY+jJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134431; c=relaxed/simple;
	bh=KAXZBx+vMoqzIwrf2B+z+XaUwa7q7Z784M6ZiaaYhy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JnIpEDaTKAc2BEzoSRyCWKdQSxpRJZRAnHt+w2gJwlw/4ceDyGBCPE8AcqwH43+FeWG7WiUDtkixDaCR0VgvM0ZV2uKFWGBSVuRh3dJ8/KjHdMDVHxieGCGDL4YGa2jmZFWz0IlIGsgOa2kkdhaqGCU0zr+58+UoOGE3gN5nhlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=MsdH2Gr0; arc=none smtp.client-ip=74.125.228.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="MsdH2Gr0"
Received: by mail-pz2-f30.google.com with SMTP id d2e1a72fcca58-88c687cf1adso152856b3a.3
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1791134425; x=1791739225; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9llYwK8ATqeQ0l/9KM8Jc4lwes7XVac/+xvUv1fpjIw=;
        b=MsdH2Gr0t07rStMrr5r2L1mwvjNMWKy6sohb8bwE7Gqyyb+WukYwkhGzZyAcBD+LIY
         BVsEF2PIH819OEQgiU3ioL7rCO1oBpnxuQw2BmUilf0i8ifjmUeEmRuuhA1HUJuy8mGY
         F0KdE+byBJ7BjQNyc87fX+Vrtb3eRvFNsZvlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134425; x=1791739225;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9llYwK8ATqeQ0l/9KM8Jc4lwes7XVac/+xvUv1fpjIw=;
        b=yJP1NyU1ciLJSaHF/cyc5T1DjP6A3CKExrdw3Ff5KQRWdNxvrgLDFzZlH5W04FniOR
         806+IciQc30NYrzU5ZJA578hvgcbB4AF0QvPsX4zlXbkJj1iYSCEqEYBKmzhmFg8AVHK
         RfXgdZg0MiroP6TGKuSi6j9hmqoiMywSz79Q81v8Y8k5F5taL/hiqhjIo9k0FmmWxR33
         tlSHGAxJbGZjsQas5Rne8hPQuoDmKWaxEfhCJRTgy9MI/IWRL7bvNCCt71BFvH9gDz5O
         7+O41lFQ7xOP6+0wcPMznR7xgrE4uNPLVp6Jfgs37bDQghkvvFbhkcypMcoAJN1ajN5I
         ngmw==
X-Gm-Message-State: AFuF++lfbRC0IIswP532K57UrsSbiXsFCoFFjLKkOj9eDGyPHneHusZZ
	4k0LAQjawYSMgHCp2RE9fNfwevYrGFycP2d5lrU1qPqQ5Tpxw2F4i+TmlBd2y63j7R0=
X-Gm-Gg: AYBFou0VJMPnftxRDwUs2jq/iESerNc7Bi0uirhGatDRLi1bcr7Pz9WO0lq0FwKD8Px
	k+ac/UUIw0mvfbFFoS48KzCSKkioO/fF5w/CzvB1+0WT7WMb6CrpXKdyv764qCYncnHQ7O7ESGc
	tyH/rlzN0UIefPvecwl7QfTeJYu/4mbLiglnEST0HSV3+PgTzsE/z3pg9l5zfgxGpsv0SDPUup/
	YT/pv/wjRf03h8ko84lKToX77Ki2FFvmEYEDwWbWuNu7y86xBrSLKR0042oSNpB+c2daqZrDFAZ
	ouDKOP0JiBaNNVWu/+Z2HiFazkg3QAT0kTf70rt7OWfT1GL8G9X7kerhXxSLNKpAM6/7c3ER07I
	iodjm7I9+WsZRnvse2FXgjHrf+9vcE+jmkPzuZNg8c21wy2s/xplOc2o6trTsiBeQWrsCupUxjA
	GIhdpjfe8fOsfQAl0H2Ip2ov3u+KYclt0eKPGaBnOiLbcccp3uFEQM8oXKXTh9TTLa
X-Received: by 2002:a05:6a00:1144:b0:880:5fe5:a818 with SMTP id d2e1a72fcca58-88af8377fb6mr7571704b3a.59.1791134425036;
        Sun, 04 Oct 2026 10:20:25 -0700 (PDT)
Received: from [172.19.0.2] ([49.142.45.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88c88759fc5sm1263302b3a.56.2026.10.04.10.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:20:23 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
Date: Sun, 04 Oct 2026 17:20:10 +0000
Subject: [PATCH] vfio/mlx5: Fix boundary check in set_report_output()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-vfio-mlx5-fix-boundary-check-v1-1-1d3b8e55e23f@snu.ac.kr>
X-B4-Tracking: v=1; b=H4sIAMmKwmoC/x3M3wpAMBSA8VfRuXZq5k94FbmY7eCETVtE8u6Wy
 199fQ8E8kwB2uQBTycHdjYiSxPQs7ITIZtokEJWmRAFniM73NarxJEvHNxhjfI36pn0gkWdN6Z
 SpAeSEBe7p1j9+65/3w+PkIRwbgAAAA==
To: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Shameer Kolothum <skolothumtho@nvidia.com>, 
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Seongjun Hong <hsj0512@snu.ac.kr>
X-Mailer: b4 0.13.0

Use > instead of >= on boundary check of recv_buf to avoid the bug which
the full message in the last slot of recv_buf is ignored even though the
received data size does not overflow the recv_buf.

Clarify the second boundary condition by removing unnecessary division by
entry_size. It directly shows that size should be within qp->max_msg_size.

Fixes: 9c7c5430bca3 ("vfio/mlx5: Align the page tracking max message size with the device capability")
Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
 drivers/vfio/pci/mlx5/cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index 5fe0621b5fbd..a49531666e6d 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -1644,8 +1644,8 @@ set_report_output(u32 size, int index, struct mlx5_vhca_qp *qp,
 	int i;
 
 	buf_offset = index * qp->max_msg_size;
-	if (WARN_ON(buf_offset + size >= qp->recv_buf.npages * PAGE_SIZE ||
-		    (nent > qp->max_msg_size / entry_size)))
+	if (WARN_ON(buf_offset + size > qp->recv_buf.npages * PAGE_SIZE ||
+		    size > qp->max_msg_size))
 		return;
 
 	do {

---
base-commit: 6addb4f385570ebc11c4eb499a4f1c149f313e84
change-id: 20261004-vfio-mlx5-fix-boundary-check-4839d6aecbe2

Best regards,
-- 
Seongjun Hong

