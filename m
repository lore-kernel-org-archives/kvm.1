Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795341041;
	b=eXUlZAfyyoUDMC5nnsARFXGsqyVFauRL5darPHlzAgEE5d5azv1FQSfqAMy7nmTurvWJ
	 43CUgVkeD7UrDLbyHJh1fXkwlw4ngKcO9aZBN6P8g6Hb1/YB9NRKoYfwNJq1mVbtjPOTh
	 RLbAZQTlKcvxqW0ziHoYIOroCG5UDi7PJ1nGZ7Nc8adyKl6TpxAgXi1fEScgEPG4+rVUw
	 TtuN8N2Zx5DlcH+DcEwC559UCQ8KPfDdp4SKY33OvtGZh/bvADfko6XXvLljT8u73zfeX
	 gNC/XJX56/snyixoXlRUJHEJB446H+1UHoF9K6JEBQaGE4v+5lTFE5VXh7ju03Q1J1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795341041;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ufr71PY4qGevTHv4/Xt0Aoe+LguNLXQIUPKTi4k0c3Y=;
	b=2Rzxov+B0fmn8bcGsGXiLK3d5/vP22q4mAEw+bGpJ7zdkcyHKKEUu0NA69uAKqrSo+Af
	 Ojab7nyFMuCROoTjToMsc8smeAxUxlnmVIdeRDiWTSu8paFE7dyDVSO7e8Ppbgl2qFzAV
	 x6tLyLatqIcGOVHk9juk/RkmIaK9asY/Ibv6vg8iYVKa6sLZPBEJxpdc60YbI6Ow/lJ/5
	 f8IblNjeV0jntfnVYvmXFgDlkN+/iSz+7GYGBgJbsKgawE603b1v4LEhUbS7Rr25fc4q6
	 lYSquHy4zjD1RMteh1QSqdZ9a/tXK1Cusmw6QsVnlecOBF8MnUsExzTK9Q9g6ra0cww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ajb5VSKx;
	arc=none smtp.remote-ip=115.124.30.132
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD7606A320;
	Sun, 22 Nov 2026 09:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDBD7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ajb5VSKx
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795341032; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ufr71PY4qGevTHv4/Xt0Aoe+LguNLXQIUPKTi4k0c3Y=;
	b=ajb5VSKxgRmURiP2zwcNwk8x8em7oGv1SE5tpbjvzOOi2ECCv1Xqr7bE0q6PSoGOuM4C7mnkofKkgG+N6Tv7KTPfXF13D2ibtAWCSzzupTbNhX5SHS0Ew9+tIEl5rZkUi9lfSSqYZNZiu0iQCWS0cV4hGF6KGfd0mlteOPkN6Tg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=shijing.wuqi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0XFAcuiG_1795341018;
Received: from localhost.localdomain(mailfrom:shijing.wuqi@linux.alibaba.com fp:SMTPD_---0XFAcuiG_1795341018 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 22 Nov 2026 17:50:32 +0800
From: Qi Wu <shijing.wuqi@linux.alibaba.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: irqfd: Publish the resampler after adding its first member
Date: Sun, 22 Nov 2026 17:50:10 +0800
Message-ID: <20261122095010.444794-1-shijing.wuqi@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_irqfd_assign() publishes a new resampler before adding its first
member and then calls synchronize_srcu_expedited() to drain readers that
may have seen an empty member list.  This per-new-resampler grace period
runs under resampler_lock and adds to VM creation / snapshot restore
latency.

Add the first member while the resampler is private, then publish it to
both global entries.  RCU list insertion guarantees any reader that finds
the resampler also sees its first member, so the empty-list state is never
visible and the first member needs no grace period; later members still
synchronize.  This also prevents kvm_notify_irqfd_resampler() from finding
an empty resampler and dropping a pending interrupt on IOAPIC unmask.

synchronize_srcu() calls per path (regression check; only the first row
changes):

  path                              before  after
  new resampler, first member         1       0
  existing resampler, next member     1       1
  non-resample irqfd assign           0       0
  irqfd_shutdown (UAF fix)            1       1
  deassign, non-last member           1       1
  deassign, last member               1       1

Build-tested with gcc/clang and KASAN+PROVE_RCU+PROVE_LOCKING / KCSAN
(KVM subsystem and selftests compile); checkpatch --strict clean.

This patch was prepared with AI assistance; the author reviewed and owns
the change.

Signed-off-by: Qi Wu <shijing.wuqi@linux.alibaba.com>
---
 virt/kvm/eventfd.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index f43b8b25bc85..74851accd881 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -444,14 +444,18 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 			resampler->notifier.irq_acked = irqfd_resampler_ack;
 			INIT_LIST_HEAD(&resampler->link);
 
-			list_add_rcu(&resampler->link, &kvm->irqfds.resampler_list);
-			kvm_register_irq_ack_notifier(kvm,
-						      &resampler->notifier);
 			irqfd->resampler = resampler;
-		}
 
-		list_add_rcu(&irqfd->resampler_link, &irqfd->resampler->list);
-		synchronize_srcu_expedited(&kvm->irq_srcu);
+			/*
+			 * Publish last so no reader sees an empty member list.
+			 */
+			list_add_rcu(&irqfd->resampler_link, &resampler->list);
+			list_add_rcu(&resampler->link, &kvm->irqfds.resampler_list);
+			kvm_register_irq_ack_notifier(kvm, &resampler->notifier);
+		} else {
+			list_add_rcu(&irqfd->resampler_link, &irqfd->resampler->list);
+			synchronize_srcu_expedited(&kvm->irq_srcu);
+		}
 
 		mutex_unlock(&kvm->irqfds.resampler_lock);
 	}
-- 
2.47.3

