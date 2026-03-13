Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC03932C9
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404564; cv=none; b=O9vM4OiUKfXqw3s1tId6Z3CQ+9ZAZinl7Iqbd3C6TnfZcJdmEH22YnFwU203VfdzFqvMCVuevr2JTVLiAmDFlJWybJhoHho8VV8kWuaiSOf/hNnDFBM4OdJjDgJFfDyApHlFNIVdxsVHS5+kSLOfFHpiWV8neaCFNgwhsrvmyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404564; c=relaxed/simple;
	bh=MlddIfIrRTGZi6dcDuIIolCK2yhqi2fPJNrHi02bCYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpYjzooAQ3QVFsjHGZyohf9u8NyAsagpa1UQjFsHauTcK7GiMIgKDJhUwW0xzZYVobciu8kMucDc35FII7J34Vez2nh4/1YX6sSfQBy9ZZUyz3MwAn+7HUZmlFow1fHgjjoWTFi/Rq/q5xtfjWxruZad6F+gVMLhXygzGbun3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aXQyWWsG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=omxbHlBk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aXQyWWsG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=omxbHlBk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aXQyWWsG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="omxbHlBk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aXQyWWsG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="omxbHlBk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1500E5BDCC;
	Fri, 13 Mar 2026 12:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773404547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdvGc8/tf4EkvaI8saXRvLXvxh4YS3sfweiZElPr1Q0=;
	b=aXQyWWsGqltj7TKV24TwyArpBKQQYOehgDrC4fhcWIm7dFxMq1nxv3ouIF16smhBJZ9bL/
	+9U/fkYaUiSAZzE/sdcF6ThNVSy906DEeOt5qKucQqRcJaHxhKLGz6kYg8t/5BfvsxsVhh
	6oJb86Ka5dXUtny+mVwnTnnOgN4FDV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773404547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdvGc8/tf4EkvaI8saXRvLXvxh4YS3sfweiZElPr1Q0=;
	b=omxbHlBkqau6eXJ9nS1l2P56Vdb9jej1CnhZ51U5YOF7Ysim5pnUaw8/3IBlfuBclqryi7
	IDq9rAJ9noBUZ8Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773404547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdvGc8/tf4EkvaI8saXRvLXvxh4YS3sfweiZElPr1Q0=;
	b=aXQyWWsGqltj7TKV24TwyArpBKQQYOehgDrC4fhcWIm7dFxMq1nxv3ouIF16smhBJZ9bL/
	+9U/fkYaUiSAZzE/sdcF6ThNVSy906DEeOt5qKucQqRcJaHxhKLGz6kYg8t/5BfvsxsVhh
	6oJb86Ka5dXUtny+mVwnTnnOgN4FDV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773404547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdvGc8/tf4EkvaI8saXRvLXvxh4YS3sfweiZElPr1Q0=;
	b=omxbHlBkqau6eXJ9nS1l2P56Vdb9jej1CnhZ51U5YOF7Ysim5pnUaw8/3IBlfuBclqryi7
	IDq9rAJ9noBUZ8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B22AA40507;
	Fri, 13 Mar 2026 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wPCtKIIBtGmEPQAAD6G6ig
	(envelope-from <clopez@suse.de>); Fri, 13 Mar 2026 12:22:26 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org
Cc: alex.williamson@redhat.com,
	pbonzini@redhat.com,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] KVM: VFIO: deduplicate file release logic
Date: Fri, 13 Mar 2026 13:20:41 +0100
Message-ID: <20260313122040.1413091-6-clopez@suse.de>
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
X-Spamd-Result: default: False [-7.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -7.30
X-Spam-Level: 

There are two callsites which destroy files in kv->file_list: the
function servicing KVM_DEV_VFIO_FILE_DEL, and the relase of the whole
KVM VFIO device. The process involves several steps, so move all those
into a single function, removing duplicate code.

Signed-off-by: Carlos López <clopez@suse.de>
---
 virt/kvm/vfio.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 02d373f66cba..e1c88c0b82d9 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -174,6 +174,17 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 	return 0;
 }
 
+static void kvm_vfio_file_free(struct kvm_device *dev, struct kvm_vfio_file *kvf)
+{
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+	kvm_spapr_tce_release_vfio_group(dev->kvm, kvf);
+#endif
+	kvm_vfio_file_set_kvm(kvf->file, NULL);
+	fput(kvf->file);
+	list_del(&kvf->node);
+	kfree(kvf);
+}
+
 static int kvm_vfio_file_del(struct kvm_device *dev, unsigned int fd)
 {
 	struct kvm_vfio *kv = dev->private;
@@ -189,18 +200,11 @@ static int kvm_vfio_file_del(struct kvm_device *dev, unsigned int fd)
 	mutex_lock(&kv->lock);
 
 	list_for_each_entry(kvf, &kv->file_list, node) {
-		if (kvf->file != fd_file(f))
-			continue;
-
-		list_del(&kvf->node);
-#ifdef CONFIG_SPAPR_TCE_IOMMU
-		kvm_spapr_tce_release_vfio_group(dev->kvm, kvf);
-#endif
-		kvm_vfio_file_set_kvm(kvf->file, NULL);
-		fput(kvf->file);
-		kfree(kvf);
-		ret = 0;
-		break;
+		if (kvf->file == fd_file(f)) {
+			kvm_vfio_file_free(dev, kvf);
+			ret = 0;
+			break;
+		}
 	}
 
 	kvm_vfio_update_coherency(dev);
@@ -308,15 +312,8 @@ static void kvm_vfio_release(struct kvm_device *dev)
 	struct kvm_vfio *kv = dev->private;
 	struct kvm_vfio_file *kvf, *tmp;
 
-	list_for_each_entry_safe(kvf, tmp, &kv->file_list, node) {
-#ifdef CONFIG_SPAPR_TCE_IOMMU
-		kvm_spapr_tce_release_vfio_group(dev->kvm, kvf);
-#endif
-		kvm_vfio_file_set_kvm(kvf->file, NULL);
-		fput(kvf->file);
-		list_del(&kvf->node);
-		kfree(kvf);
-	}
+	list_for_each_entry_safe(kvf, tmp, &kv->file_list, node)
+		kvm_vfio_file_free(dev, kvf);
 
 	kvm_vfio_update_coherency(dev);
 
-- 
2.51.0

