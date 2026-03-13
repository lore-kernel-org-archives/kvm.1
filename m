Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153C36E47B
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404555; cv=none; b=exYnDie/aDXUNIEsYF1xzpOIpq18NObKRWidLa267fN0uxgjFZHc7jp0hjjyhAOS/xWM0fc8DYIjxskq8x3UiV0qghX+e2MCyujAu+1g/Xi+dNC3VMgOd2NfZjPGHANuXODzI8VAy3Dm37xuM39su2bx75ICZdyqW7e9TXm0ttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404555; c=relaxed/simple;
	bh=QZ2BGObGct5P2WfCZD0H1BfJtN3xeUH0kmeVxlFr72w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9Sdxd0l+wZwR2jmuqw3rcF9KXSoRXv9w8cOgxXjrrBey7ZkFKvZr/a29oUfE31JYxhesN1CwrTiBgTAgW7kxh4vmSmnvQYkpWiqbkMU6EGMZZsOuZCD4dCVf44jAGg9wseNtD79HyymaKLz2WR9dRAZ7Z7Ja6K8LF0kqN35YnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AF044D315;
	Fri, 13 Mar 2026 12:22:26 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2156D40507;
	Fri, 13 Mar 2026 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2PVFBYIBtGmEPQAAD6G6ig
	(envelope-from <clopez@suse.de>); Fri, 13 Mar 2026 12:22:26 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org
Cc: alex.williamson@redhat.com,
	pbonzini@redhat.com,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] KVM: VFIO: use mutex guard in kvm_vfio_file_set_spapr_tce()
Date: Fri, 13 Mar 2026 13:20:40 +0100
Message-ID: <20260313122040.1413091-5-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313122040.1413091-3-clopez@suse.de>
References: <20260313122040.1413091-3-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 7AF044D315
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Use a mutex guard to hold a lock for the entirety of the function, which
removes the need for a goto (whose label even has a misleading name
since 8152f8201088 ("fdget(), more trivial conversions"))

Signed-off-by: Carlos López <clopez@suse.de>
---
 virt/kvm/vfio.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 2c91bad3333b..02d373f66cba 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -225,9 +225,7 @@ static int kvm_vfio_file_set_spapr_tce(struct kvm_device *dev,
 	if (fd_empty(f))
 		return -EBADF;
 
-	ret = -ENOENT;
-
-	mutex_lock(&kv->lock);
+	guard(mutex)(&kv->lock);
 
 	list_for_each_entry(kvf, &kv->file_list, node) {
 		if (kvf->file != fd_file(f))
@@ -235,20 +233,15 @@ static int kvm_vfio_file_set_spapr_tce(struct kvm_device *dev,
 
 		if (!kvf->iommu_group) {
 			kvf->iommu_group = kvm_vfio_file_iommu_group(kvf->file);
-			if (WARN_ON_ONCE(!kvf->iommu_group)) {
-				ret = -EIO;
-				goto err_fdput;
-			}
+			if (WARN_ON_ONCE(!kvf->iommu_group))
+				return -EIO;
 		}
 
-		ret = kvm_spapr_tce_attach_iommu_group(dev->kvm, param.tablefd,
-						       kvf->iommu_group);
-		break;
+		return kvm_spapr_tce_attach_iommu_group(dev->kvm, param.tablefd,
+							kvf->iommu_group);
 	}
 
-err_fdput:
-	mutex_unlock(&kv->lock);
-	return ret;
+	return -ENOENT;
 }
 #endif
 
-- 
2.51.0

