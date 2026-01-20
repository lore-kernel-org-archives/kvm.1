Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01783A9616
	for <kvm@vger.kernel.org>; Tue, 20 Jan 2026 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939991; cv=none; b=cFRSZBzDgoooMGOSv2iHgmyoREbD7n1jckS1sOSQ29kKOBgByyqJzWXnNoH8LPhv6ysjWFrGTmadA34KFFIcI+Qq2UFnLbFd5SdBwkL4HTaKg5zem70SmM4DMIunGlx0b6KF9pEji+PDTo0NCFH2jPlqwzUYJ3Qs4M3LCbMqMe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939991; c=relaxed/simple;
	bh=MbDcAPRmY8tusJkjWgDCqncDR95ihIheKu4/9dlZAys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cV/5Pk7bGFd0fUvl2j5yZQf1xmimoRAXavYM5zgwiAX0/xB5PqS3cQaLRCBCH3Jnv6q/uPUyDupii3cBFCPl1JcI767OawlOMz11qN7HifzR47kWFafVyHzcS4IxSBz5vierO4ms8o7glRFpN2LSXQK2SU1238zVsg2V8B6PK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xkbp/cjd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WCc/Feqp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xkbp/cjd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WCc/Feqp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xkbp/cjd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WCc/Feqp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xkbp/cjd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WCc/Feqp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A9085BCD0;
	Tue, 20 Jan 2026 20:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768939981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XMjqsQFSIHe2r3eVttMF6hQmBpLtd2tPqBH0k5t4FE=;
	b=xkbp/cjdU2989uKONKIZTnEaHTtUsx3113g4iXjIrO7xI4cE7ENZs4KBDrcJyJaUlTTAwl
	FEaqKTxpcN1M1JQTZjyEK/t1NX2o1kPqWKEkEMxmgFOdqLlVGYblnWtZ3K2rvg4WnepPhq
	cltaRur7RBS8cp4p+hfTgJW2oA152xQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768939981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XMjqsQFSIHe2r3eVttMF6hQmBpLtd2tPqBH0k5t4FE=;
	b=WCc/Feqpy4EZXXV9iuXh8/Xq5Pi6DfZTXm+/hFOKo+5NTEAd+GziIrNTu3OH0gnPRBZUA0
	mPkj6tOXvZByGyCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="xkbp/cjd";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="WCc/Feqp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768939981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XMjqsQFSIHe2r3eVttMF6hQmBpLtd2tPqBH0k5t4FE=;
	b=xkbp/cjdU2989uKONKIZTnEaHTtUsx3113g4iXjIrO7xI4cE7ENZs4KBDrcJyJaUlTTAwl
	FEaqKTxpcN1M1JQTZjyEK/t1NX2o1kPqWKEkEMxmgFOdqLlVGYblnWtZ3K2rvg4WnepPhq
	cltaRur7RBS8cp4p+hfTgJW2oA152xQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768939981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XMjqsQFSIHe2r3eVttMF6hQmBpLtd2tPqBH0k5t4FE=;
	b=WCc/Feqpy4EZXXV9iuXh8/Xq5Pi6DfZTXm+/hFOKo+5NTEAd+GziIrNTu3OH0gnPRBZUA0
	mPkj6tOXvZByGyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8E293EA63;
	Tue, 20 Jan 2026 20:13:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gLxsKczhb2nRMAAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 20 Jan 2026 20:13:00 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com
Cc: pankaj.gupta@amd.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH v2 4/6] KVM: SEV: use mutex guard in sev_mem_enc_unregister_region()
Date: Tue, 20 Jan 2026 21:10:12 +0100
Message-ID: <20260120201013.3931334-7-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120201013.3931334-3-clopez@suse.de>
References: <20260120201013.3931334-3-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.51
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8A9085BCD0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Simplify the error paths in sev_mem_enc_unregister_region() by using a
mutex guard, allowing early return instead of using gotos.

Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/x86/kvm/svm/sev.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 30f702c01caf..37ff48a876a5 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2745,35 +2745,25 @@ int sev_mem_enc_unregister_region(struct kvm *kvm,
 				  struct kvm_enc_region *range)
 {
 	struct enc_region *region;
-	int ret;
 
 	/* If kvm is mirroring encryption context it isn't responsible for it */
 	if (is_mirroring_enc_context(kvm))
 		return -EINVAL;
 
-	mutex_lock(&kvm->lock);
+	guard(mutex)(&kvm->lock);
 
-	if (!sev_guest(kvm)) {
-		ret = -ENOTTY;
-		goto failed;
-	}
+	if (!sev_guest(kvm))
+		return -ENOTTY;
 
 	region = find_enc_region(kvm, range);
-	if (!region) {
-		ret = -EINVAL;
-		goto failed;
-	}
+	if (!region)
+		return -EINVAL;
 
 	sev_writeback_caches(kvm);
 
 	__unregister_enc_region_locked(kvm, region);
 
-	mutex_unlock(&kvm->lock);
 	return 0;
-
-failed:
-	mutex_unlock(&kvm->lock);
-	return ret;
 }
 
 int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
-- 
2.51.0

