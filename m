Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E379479895
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465383; cv=none; b=QKwcikpq9Nf1Da7wDvHU4e9UPH5FxVMkEZHB1aEo0wPjEwNWvFjp54sxldj2avdB9fsm4eAn0wSgH96C1+uSRPGDUMPr/bofJxn7jjCItS+P2jji9hBZgvA+c4PX9cgKt4WhKlKGRzLp1RG2rLlEl0gBiVDrX7VjXdPtmUxByi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465383; c=relaxed/simple;
	bh=DSm67Fef0PwVMY0lwmqgSFdetPGHsbit/KuByND9Tmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NBrPr7eRMWePDyoTXapB+KFWWIq+U5D+E4NXo01rz6WqTXIrQW09nG3GvOl2IB/cf2IXnNbz9dDDW0EBNmur8d4cMzOy4ZkUkr0vsjgTc09nH5VIxnLvfARC2AR/b8ITOKZw3CHTnR6e6VpwZ1Kq/U7A9gfkJLR+NB4HdCDiErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI8eZHYD; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI8eZHYD"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca06a25so490645ad.2
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789465379; x=1790070179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=69mrxJexhH+mB0/KG77Jb3FUWESkIXl1gYvn5Rky+CA=;
        b=GI8eZHYDA8tr6ZKf7vo/6vL2yl/VSbS98x3fvHXa0oiyucAXH2adJ0jcM85gSlU+QQ
         BDSf6ajoKmgp4gmBETr2zw0CvPAlUNGpaCYXS9oA+ZBJ50JChUHGpxrJ0joC3NaIUrKQ
         IvZJO2mXNPvlQ+EupXmUO+ldGvUxDCa98ch45KuO57WIZt3yqRXOgRPTCUIjP+rX6D0M
         DMQu469klJGcSAyvWifHxFglHtGlZxS1trsK9zhptDGIXrzlsBykmrUVE+FY7yhfQIsr
         DCZYnm+fw8Gp09gSkM8ad4C3aERvOwWQvusYNw8Gt3CrjWBduIc/JXVTrNRovYiZwRwY
         5p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789465379; x=1790070179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=69mrxJexhH+mB0/KG77Jb3FUWESkIXl1gYvn5Rky+CA=;
        b=Bu5kZYkCWYTYBjWQL88G6G3RBLE7lLAWMeNDUPHjCgZd6neqKIQFwjitfLxXtYNF+u
         5/bv2NDs7z/dNTO+m/m4e+tsCrvqWAYR/zsUPQUCou5HbewFp6cEaT/4JxAiAUsWvzr6
         U8OP+JFQUKujHyc/r4b315omChOUuHG5HFQUxPGEdLI6/8sSpFiNyj1E8/sCYStlRzQY
         8+lzxXFC1XdVYFCk/C6u0VQ+EitNclQbPJblUbfQwk1j5ckUzpzDUGvQ14M3QDf1nFX0
         C86RnJnQOQLZKc5E1RFsekz54iVv9xm0qAE4tYQc1R4GxYMNUSN8QXsMLW+anyhmySTp
         z+Kg==
X-Forwarded-Encrypted: i=1; AKwUvByBA+QtO2PJxqTxWBPBVn2iJ3vIz0FUUOJOUHMuYD0ohYHt2s3W/sOP8O/vtGpcZnoQRz8=@vger.kernel.org
X-Gm-Message-State: AFuF++kkXdramfaHGL1kMpgem3fwWtLACeppkRCuPVEPCapCNR90ApMl
	iDgyKls5PJ0EQYWgEynUnWqU3ASEOJM9ZZfIJFaV2i7DFsf09VH5/LOM
X-Gm-Gg: AYBFou1JaJ7lb7S/Ak7IakGU7AvgTZfcfHW9yEQVrm4e1Vxty7jka+3vAc3D3yKcCjB
	871JLzMKOLVwqxMO1VrFnvf/ipdZuUBbOOFD/zTyW9JkNHsZXZmeIx+j79Ne/ecfeZIPVhHnmmZ
	otipUQ+lH27qZBFXnUyAH4XUM5gi83MyEu0313HZwjztX9TKoMXeUcnAivHDciqhRvBp9kfyaJO
	q4eVe0yMLQeyPgTNsvSZvsZA6LcET6AuZVtaUKH55cS2Yw60bEEn/BIiIY65MOEX8n+Wg3zAQPK
	DOvmnCxOQUy2CnQ1uEZhbGwnC/ImEI5yyRa4w94BbpMe/jCEKcdCrX24IaU+3ErYXarHDXh38+y
	+lZy3M19oj46GWuNKcDVIqPqoCH12ZQaWXSszkRI8H+nArQqC05c/pq9sObdCBUEXIqCIs6I87l
	8CFkWfi+92niW6FcLXEn3J1IpqHgh+oBo6pFn2Tsy50CTxLCpOjhAp1Vs4oCdQntg=
X-Received: by 2002:a17:903:40c6:b0:2d0:cc92:f7a9 with SMTP id d9443c01a7336-2dd837a6aeemr5238465ad.4.1789465378664;
        Tue, 15 Sep 2026 02:42:58 -0700 (PDT)
Received: from jia ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfbeca2sm63625345ad.45.2026.09.15.02.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:42:58 -0700 (PDT)
From: physicalmtea@gmail.com
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	michael.christie@oracle.com,
	pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	nab@linux-iscsi.org,
	asias@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] vhost-scsi: preserve event ordering
Date: Tue, 15 Sep 2026 17:42:43 +0800
Message-Id: <20260915094244.7900-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915094244.7900-1-physicalmtea@gmail.com>
References: <20260915094244.7900-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Jia <physicalmtea@gmail.com>

vhost_scsi_send_evt() uses llist_add(), so pending events are LIFO.
vhost_scsi_complete_events() walks the detached list directly.
This can deliver a later hotplug or hotunplug event before an earlier
one.

Reverse the detached list before processing it.
This keeps delivery in enqueue order.

Fixes: a6c9af87363c ("tcm_vhost: Add hotplug/hotunplug support")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 7a1f39a32..37f681aab 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -637,7 +637,7 @@ static void vhost_scsi_complete_events(struct vhost_scsi *vs, bool drop)
 	struct llist_node *llnode;
 
 	mutex_lock(&vq->mutex);
-	llnode = llist_del_all(&vs->vs_event_list);
+	llnode = llist_reverse_order(llist_del_all(&vs->vs_event_list));
 	llist_for_each_entry_safe(evt, t, llnode, list) {
 		if (!drop)
 			vhost_scsi_do_evt_work(vs, evt);
-- 
2.34.1


