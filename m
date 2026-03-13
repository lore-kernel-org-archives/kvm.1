Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375B36E47B
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404560; cv=none; b=MDh0WGDCtm+/zbJii+vZ0DWctK8UIH/QKil0wPUqUqaIlhjqoa2aVwn3tfF5kD/MUcSWPcvGeL6dxffMt5jrOjqTauyRgSFy1iTFeo9lrLoNVUuHJbJsW/odkoWqefz0egG9iyy4jGo2FnPwK68y0ULa9DnW5rUhrZhwt2baX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404560; c=relaxed/simple;
	bh=uo73HbAz9OmLu0tBPWdVW5O3p4R1TN09qsG4Dmq3Xbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mlko3p3vAxZmOcFLI6St/ovR5pbscqk0kknfUIykQU+TxJK/c6o1I9YdPTPmVFG7sUx895H87KAtvGdJVUp9iXq/XqH0ElredCbhhvIiAt+3crb5laWYy1N5W9SwrVs8ouNEbLVxk/SrySMkTDpiFnnOMoEeUWdd7p92NeOgg1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1D134D3C1;
	Fri, 13 Mar 2026 12:22:27 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BC4740507;
	Fri, 13 Mar 2026 12:22:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uI20D4MBtGmEPQAAD6G6ig
	(envelope-from <clopez@suse.de>); Fri, 13 Mar 2026 12:22:27 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org
Cc: alex.williamson@redhat.com,
	pbonzini@redhat.com,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] KVM: VFIO: update coherency only if file was deleted
Date: Fri, 13 Mar 2026 13:20:42 +0100
Message-ID: <20260313122040.1413091-7-clopez@suse.de>
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
X-Rspamd-Queue-Id: A1D134D3C1
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

When servicing a KVM_DEV_VFIO_FILE_DEL request, if a file is removed
from kv->file_list, kv->noncoherent needs to be updated, in case we
can revert to using coherent DMA. However, if we found no candidate
to remove, there is no need to re-scan the list, so do it only if a
matching file was found.

To simplify the control flow, use a mutex guard so that we can return
early from within the search loop if the maching file is found.

Signed-off-by: Carlos López <clopez@suse.de>
---
 virt/kvm/vfio.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index e1c88c0b82d9..47a3b8d82735 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -190,27 +190,21 @@ static int kvm_vfio_file_del(struct kvm_device *dev, unsigned int fd)
 	struct kvm_vfio *kv = dev->private;
 	struct kvm_vfio_file *kvf;
 	CLASS(fd, f)(fd);
-	int ret;
 
 	if (fd_empty(f))
 		return -EBADF;
 
-	ret = -ENOENT;
-
-	mutex_lock(&kv->lock);
+	guard(mutex)(&kv->lock);
 
 	list_for_each_entry(kvf, &kv->file_list, node) {
 		if (kvf->file == fd_file(f)) {
 			kvm_vfio_file_free(dev, kvf);
-			ret = 0;
-			break;
+			kvm_vfio_update_coherency(dev);
+			return 0;
 		}
 	}
 
-	kvm_vfio_update_coherency(dev);
-
-	mutex_unlock(&kv->lock);
-	return ret;
+	return -ENOENT;
 }
 
 #ifdef CONFIG_SPAPR_TCE_IOMMU
-- 
2.51.0

