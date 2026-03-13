Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D0236E47B
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404549; cv=none; b=S1Mjnm3Jidxyamnp9u2afMrqM2FKUrQGYfxxIK8uW8EqlqVhOsABoJePGyjwkGWcvAz7o1gKOBKjLx7dhrZMpGS9dHKk6aTzL0994JFKdWFSmGtblWJCLE2yKtplcXxRaqzTc9RAo/FxWvAYCuvEMccyCb3yKgSPRxv41oIj9ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404549; c=relaxed/simple;
	bh=rHYSTRvVl3jkaJY+Rc50jd4GbtyXtvRDfnKNy4y/sYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIEVGP3uaLc73Rz/oSSFzrBTZwFgr35/OHt+Zq3jb/P1VeSY56jjF2C6FWKWI6M4VQGhx+jp8N4ZvF/xTstpnTBJFpHJ4fwSJwX47JunzixShKUulSthhHMIq1HbHJRq27Y9cNBxE3f24QyXmX13WRmrwhkPltu86FAb/aGgzIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF0464D2E5;
	Fri, 13 Mar 2026 12:22:25 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 878ED40507;
	Fri, 13 Mar 2026 12:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qHNDHoEBtGmEPQAAD6G6ig
	(envelope-from <clopez@suse.de>); Fri, 13 Mar 2026 12:22:25 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org
Cc: alex.williamson@redhat.com,
	pbonzini@redhat.com,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] KVM: VFIO: clean up control flow in kvm_vfio_file_add()
Date: Fri, 13 Mar 2026 13:20:39 +0100
Message-ID: <20260313122040.1413091-4-clopez@suse.de>
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
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: DF0464D2E5
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

The struct file that this function fgets() is always passed to fput()
before returning, so use automatic cleanup via __free() to avoid several
jumps to the end of the function. Similarly, use a mutex guard to
completely remove the need to use gotos.

Signed-off-by: Carlos López <clopez@suse.de>
---
 virt/kvm/vfio.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 9f9acb66cc1e..2c91bad3333b 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -144,33 +144,26 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 {
 	struct kvm_vfio *kv = dev->private;
 	struct kvm_vfio_file *kvf;
-	struct file *filp;
-	int ret = 0;
+	struct file *filp __free(fput) = NULL;
 
 	filp = fget(fd);
 	if (!filp)
 		return -EBADF;
 
 	/* Ensure the FD is a vfio FD. */
-	if (!kvm_vfio_file_is_valid(filp)) {
-		ret = -EINVAL;
-		goto out_fput;
-	}
+	if (!kvm_vfio_file_is_valid(filp))
+		return -EINVAL;
 
-	mutex_lock(&kv->lock);
+	guard(mutex)(&kv->lock);
 
 	list_for_each_entry(kvf, &kv->file_list, node) {
-		if (kvf->file == filp) {
-			ret = -EEXIST;
-			goto out_unlock;
-		}
+		if (kvf->file == filp)
+			return -EEXIST;
 	}
 
 	kvf = kzalloc_obj(*kvf, GFP_KERNEL_ACCOUNT);
-	if (!kvf) {
-		ret = -ENOMEM;
-		goto out_unlock;
-	}
+	if (!kvf)
+		return -ENOMEM;
 
 	kvf->file = get_file(filp);
 	list_add_tail(&kvf->node, &kv->file_list);
@@ -178,11 +171,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
 	kvm_vfio_update_coherency(dev);
 
-out_unlock:
-	mutex_unlock(&kv->lock);
-out_fput:
-	fput(filp);
-	return ret;
+	return 0;
 }
 
 static int kvm_vfio_file_del(struct kvm_device *dev, unsigned int fd)
-- 
2.51.0

