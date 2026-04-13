Received: from sg-3-111.ptr.tlmpb.com (sg-3-111.ptr.tlmpb.com [101.45.255.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFF3395D8B
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065834; cv=none; b=Y/R4yE3Uq/s4iVFekaofQabcOcPpoKzqW87odlgu+Km9TAiigcUGe3pFoQFVHqpEfzswTkI5zwZZrus1oLh1QwVPbvg+TObfDyv1+051An6SA5+RePydujVxA0tNBWAiZ7ARFqPp6NvMW4tDUuxPWd2PFqzaQaaWAwgS721fY1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065834; c=relaxed/simple;
	bh=udLn74JxhDF7Sr+0RcIAAIJPKdt0g6+Cyo54JAMtr2c=;
	h=Date:Content-Type:To:Cc:From:Subject:Message-Id:Mime-Version; b=jWTcbPJoKF9vRhtUOSaIYUHQI7oDXbcokEizh+2+9wm/BXSSN7KRNjEOpnco2AmZRsje++KnrPgISc8JtL4/sdJWMAYeXk4Dfs64uuw8p4wHxYQoynVp0kDQZZDJcG2Fa2YTgCZky9xv6uzzYj+mylJMZYzgdBWj7TDFwQzh0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Iw8uUTFY; arc=none smtp.client-ip=101.45.255.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Iw8uUTFY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1776065789; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=rhZEIiDegqUPaC2rLzO5r5Di1IByvlqQfj2KNidppxM=;
 b=Iw8uUTFYnZ2FIz3xH412JTtnCTT3a07t5m4OUEVKuo0W6L63oTrfCiwXfwz93tnRtqXIhe
 w6s8E8LrQz6Z5bhPifuSbtdKy3ZkLtstf8cWBoPzwVng4rHuXgfMbKYFEFHx0pi6usT1MT
 My3/QShXwhlMD9xvqd31rXnmeZdXxRS7LGPMSmUe9qaEajcTgnP/Mu61d41ET1SK0huxmy
 6T+uyLYLVhD0SOaS+tXdtPHrYmNKgAJ5Q0g0z/wi2+E04P9/vtc8Hq7OrHqu7hlw8YK7H0
 1v9xeg425XQ6rqgjj6XXp1ussarS1KfbQHLYBckP4fkf79N5m+5Tr37r5QRBYw==
Date: Mon, 13 Apr 2026 15:36:03 +0800
X-Lms-Return-Path: <lba+269dc9cfb+b71271+vger.kernel.org+guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Alex Williamson" <alex@shazbot.org>, "Jason Gunthorpe" <jgg@ziepe.ca>, 
	"Yishai Hadas" <yishaih@nvidia.com>, 
	"Shameer Kolothum" <skolothumtho@nvidia.com>, 
	"Kevin Tian" <kevin.tian@intel.com>
Cc: <kvm@vger.kernel.org>, <virtualization@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, 
	"Jinhui Guo" <guojinhui.liam@bytedance.com>, <stable@vger.kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Subject: [RESEND PATCH] vfio/virtio: Fix lock/unlock mismatch in virtiovf_read_device_context_chunk()
Message-Id: <20260413073603.30538-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1

virtiovf_read_device_context_chunk() takes migf->list_lock with
spin_lock() but releases it with spin_unlock_irq().  This mismatch
can incorrectly enable interrupts if they were already disabled
when the lock was acquired, leading to unbalanced IRQ state.

Fix by using spin_lock_irq() to match spin_unlock_irq().

Fixes: 0bbc82e4ec79 ("vfio/virtio: Add support for the basic live migration functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---

Hi,

Sorry for the noise. Resent with "Cc: stable@vger.kernel.org"";
no other changes.

Best regards,
Jinhui

 drivers/vfio/pci/virtio/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
index 35fa2d6ed611..9fc24788fc04 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -621,7 +621,7 @@ virtiovf_read_device_context_chunk(struct virtiovf_migration_file *migf,
 
 	buf->start_pos = buf->migf->max_pos;
 	migf->max_pos += buf->length;
-	spin_lock(&migf->list_lock);
+	spin_lock_irq(&migf->list_lock);
 	list_add_tail(&buf->buf_elm, &migf->buf_list);
 	spin_unlock_irq(&migf->list_lock);
 	return 0;
-- 
2.20.1
