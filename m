Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106D13AA4E7;
	Mon,  6 Jul 2026 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331967; cv=none; b=L3BkrugsmeL4ae2JrHkDMFgYAPrRVLJ5OFXpDuPuAvEvKIeDYVytxkWfOK/rp66Ik1EXy3oCEoYvyy8fu1BKTzLIUc9i/Kk6mN5+a2pS3tlEMOuSQQjrsPP+2o562S+I24p6GzDF6N98BOvowrhxG9FrJ90ZnLXPKSugzIBMWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331967; c=relaxed/simple;
	bh=rtA/CXpSgjL5ydYxVqK1RcP+cHljTvb/4fDpyCZF2as=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4yYZduJpcNwUlQmAiU3wdwIFTLvCH8W7h2shh35tGQHNrvofNfCcxrVfxvQppCr0/eSu9C/YE1eU2XkIM9ze7cEaVDnV1tNPVdzz40iudH/TV9Tw7XzHIM3S4dCrWsTcUyCbojKNsOXnoQb97jINN0bXs6i5USJDYv+hP3CXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5839ffa4792111f1aa26b74ffac11d73-20260706
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:731d1704-01e6-4351-828d-a32dc87f4b34,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:bcc43e2ce238dc8462b7c61ded204ce2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5839ffa4792111f1aa26b74ffac11d73-20260706
X-User: leixiang@kylinos.cn
Received: from ninol.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <leixiang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 935198767; Mon, 06 Jul 2026 17:59:14 +0800
From: leixiang <leixiang@kylinos.cn>
To: 
Cc: leixiang <leixiang@kylinos.cn>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: Remove kvm_debugfs_dir on kvm_init() error paths
Date: Mon,  6 Jul 2026 17:59:06 +0800
Message-ID: <20260706095910.39798-1-leixiang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_init_debug() runs before several steps that can fail
(kvm_vfio_ops_init(), kvm_gmem_init(), kvm_init_virtualization() and
misc_register()), but none of the corresponding error labels remove the
"kvm" debugfs directory.  Any failure after kvm_init_debug() therefore
leaks the directory and its stat files for the lifetime of the boot.

kvm_exit() already calls debugfs_remove_recursive(kvm_debugfs_dir); add
the same at the err_vfio label, whose fall-through covers every path
taken after kvm_init_debug().

Fixes: 2b0128127373 ("KVM: Register /dev/kvm as the _very_ last thing during initialization")
Signed-off-by: leixiang <leixiang@kylinos.cn>
---
 virt/kvm/kvm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e44c20c04961..d4420ebfd972 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6559,6 +6559,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 err_gmem:
 	kvm_vfio_ops_exit();
 err_vfio:
+	debugfs_remove_recursive(kvm_debugfs_dir);
 	kvm_async_pf_deinit();
 err_async_pf:
 	kvm_irqfd_exit();
-- 
2.43.0

