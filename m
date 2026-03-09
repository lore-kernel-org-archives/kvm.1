Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C3E3783D7;
	Mon,  9 Mar 2026 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048124; cv=none; b=kTqU/4Okiw7PTm3ryjehuTG/+JHDS/ZPBiIXc4HTWFOjSGue6D82YtJaGRwqPdygQd6Z57AG/ZBAV62wLiHkmyJYYNUwnW7IDdjOTTMfw5pM7o5K3F2B1ZOdTZi0V+D32QAlE8uA68oqdenxRYWyPaGyZOBvWCdnQWBjgEGwn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048124; c=relaxed/simple;
	bh=3gTHUUAfb0fSIfB4w/3/60/eQ/aOcsz7D7uG0TVMs30=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aR3dhk8HmL5nlkRst0cWMqVnxJmJtuF6GMkzuqeAS4Z6rYnbAdtvDZHdFK4jbsbpmNoWTnn7o3reUY4ufQaqab0mIRN8jfFMBW0PNnBmYywfi28vPmfJKe/GEDeK/zSvlHgbumkV3CQx3pWwxMiJFD7TIZ85Op131gLdL7EMexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] KVM: eventfd: Remove redundant synchronize_srcu_expedited from irqfd assignment
Date: Mon, 9 Mar 2026 05:21:32 -0400
Message-ID: <20260309092132.2484-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc13.internal.baidu.com (172.31.51.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

The synchronize_srcu_expedited() call in kvm_irqfd_assign() is unnecessary
when adding a new irqfd to the resampler list. The list insertion is
already RCU-safe, and existing readers will either see the old or the
updated list without inconsistency. Removing this call reduces latency
during resampling irqfd setup.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 virt/kvm/eventfd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 3201f60..facfeab 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -450,7 +450,6 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 		}
 
 		list_add_rcu(&irqfd->resampler_link, &irqfd->resampler->list);
-		synchronize_srcu_expedited(&kvm->irq_srcu);
 
 		mutex_unlock(&kvm->irqfds.resampler_lock);
 	}
-- 
2.9.4

