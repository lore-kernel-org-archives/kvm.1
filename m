Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A22B42A141
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298137; cv=none; b=BoBD7fhKVOEMy/ql1N2PTAl8yF3phSUGDBBCDjq+ySBt+ZXvaUnMYduTDWWX0C425XoCKR9VxVWuXUnsj3iSOkMTFFmzcltvVVj/D/fG90PX4XZiQ0JQekFnw+FLMHytZZjIHoHzIcVUWsZQJMvGUMa2jxTZumuaRkXny/0nLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298137; c=relaxed/simple;
	bh=7kow3xJStgv3CCEwPVH94AHQZCvexA38wioGE90Sw6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fjjtFpnLA/i6X54Lb21DWwwn9AT/kvCdaH3EVKbrUQOrGkOv6f8N63rA+3T4tujrQm9+rvCa7rs9nbaK4XR/qp3FMP/I3k1heH9CCcnETevBCxA0kJMEK5LJqkNXqsFD7+SwiEpN+zEQkPyBYqwhkqIf4wXcJft05jBtIbQPCLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+uDacnM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+uDacnM"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso4880228a91.1
        for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 07:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784298135; x=1784902935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ye+2o/nLKhbl8EFiB/65QBjN6Z27bE/oD+7iGYaj4l0=;
        b=k+uDacnMuUWqF/WA/cN2H1c7Ym5Sg2/1g3VJJvl+SvPGxKBv44jXNlYUFvcL0A4Vv2
         Aqpzu1WaNnU0V6AQsrSTvt+z4Xv2txDIxViGjHj4iYKAW2UTdb7HGkwJ75BF2PYCw44b
         KktPl/U2XgAVYUa0903TwsTRFvvC96e7wRzUsWkpcSBrI1HNTnwOvsH0yIf9Rmiwr7xz
         +czaKSfSCDQEUgYeKc5BJCkD8HLRfvNC/JUjrrCTmqxi60Tsz7clQOT5chEpGqrZ9ws0
         UCT1tg5nZBKtOZVYI2x3ToWVyJ/oUjWQntzMqtTS8AWAytixyU7djLtjTKVDzJn3X5n1
         w0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784298135; x=1784902935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ye+2o/nLKhbl8EFiB/65QBjN6Z27bE/oD+7iGYaj4l0=;
        b=J/7Cg4gq+beQLJqvRQMk8kHUYtPoWY3BSdZqmtXvPLTcRw/tdQvrjiEkqKuSQy2eok
         fLw1OYbHUsxX45xXdf0SdVYGI9FfINmYddDxb7gv1K2h2Mza48vPPBQh1/ozIW2N7FLb
         08XHBI3pyU0TsTI9rOjuEZQalDj5cMv0w2LHAVPMgSENzeF/Cn8u+zGQqu25eCgLelY6
         KYgEOP+n6bsMisAq1AFWLKoP1/n5d6lEIUaBCeJfs8GD37OVKSDIZs6LEDa30biFGHNW
         9fTZS7E4HZ+lfbwJ5ZRT6IgFIT+bwhvzsJ/nXGMZF43SUjrdGWweSErx8gU81Xcxi9GX
         LjOw==
X-Forwarded-Encrypted: i=1; AHgh+RpCZkBChBd0ZY8NR8BcdNXyJTqm1XL40kVx7P+4LqvsqYAmhIv5NvA+NWkviePbP6JmiZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBOEHgxhWHiH4hJ7dogAdz9ea8dJkNYu7jW/KmdTSyTjCYBykH
	+iGNWCCeCfg+r3AowVakHPzCu7ZQtbjUWvudQ210iPX59nfZXLLMXgdL
X-Gm-Gg: AfdE7cldAm/U/eZJCDa4BNihAm2RBjZF6QIGKO7v+3oXn5ZHPy7WH/HPaRIMhtfeS1o
	peegxiq226BDbf9JIiZp2wyyXc8AP8ZTChmEaeYbBhGe8y8F08fInKVXY/k2vtitEbazuUUF7b1
	kjUR8MqYxCQFhpX9twyjCHM3DKaH9R/p8fnUCceP2iPvIgWr3FJO7YMjKneGTHgmwTBSZBQ0dTS
	htAHbOJWyz4fLA4gluIIIdFM/G1IfvBs1mwDHPM6wjcajmNz/mphNKqQUXs9+NgG3grNAIdJnjg
	4w6RKAMoMgTDVqkPAvMcsUaOGAo3ZP5JmkhaMU2IEW9jFbj1bMmg2IBu/z7ee5b5+91/6jQazow
	eCP8roQD1Yn9ncs4WeJzNsTgwUlyevxUF+b9L3l7JKbS7b71rVbHosxcytySOWsZ75ZI20wNjuf
	KNiAEH
X-Received: by 2002:a17:90b:1dc3:b0:384:5b5b:3465 with SMTP id 98e67ed59e1d1-38e4b5792e4mr3066215a91.29.1784298134525;
        Fri, 17 Jul 2026 07:22:14 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39de785dsm3009325a91.4.2026.07.17.07.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:22:14 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	michael.christie@oracle.com
Cc: pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] vhost-scsi: Prevent OOM from invalid protection SGL count
Date: Fri, 17 Jul 2026 22:22:05 +0800
Message-Id: <20260717142205.103515-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The protection SGL path passes the result of vhost_scsi_calc_sgls()
directly to sg_alloc_table_chained(). The helper returns a negative
errno when the iterator is invalid or the request exceeds the segment
limit. The negative errno is then treated as a very large unsigned count
and sends the request into the SGL allocation path with an invalid size.

Repeated malformed T10-PI submissions from a host-side application caused
memory usage to rise sharply. MemAvailable fell to about 200 MB, and PSI
full avg10 reached about 1.46. The OOM killer terminated several userspace
processes before the endpoint cleanup completed. The kernel log included:

    [17036.451028] Out of memory: Killed process 2345 (systemd)
    [17036.493325] Out of memory: Killed process 2349 (sd-pam)
    [17078.265127] Out of memory: Killed process 1793 (networkd-dispat)

Return the calculation error before setting up the protection SGL. This
keeps the protection path consistent with the data SGL path and prevents
the invalid count from entering the allocation path.

Fixes: bca939d5bcd0 ("vhost-scsi: Dynamically allocate scatterlists")
Cc: stable@vger.kernel.org
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d..8486652fd 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -972,6 +972,9 @@ vhost_scsi_mapal(struct vhost_scsi *vs, struct vhost_scsi_cmd *cmd,
 	if (prot_bytes) {
 		sgl_count = vhost_scsi_calc_sgls(prot_iter, prot_bytes,
 						 VHOST_SCSI_PREALLOC_PROT_SGLS);
+		if (sgl_count < 0)
+			return sgl_count;
+
 		cmd->prot_table.sgl = cmd->prot_sgl;
 		ret = sg_alloc_table_chained(&cmd->prot_table, sgl_count,
 					     cmd->prot_table.sgl,
-- 
2.43.0
