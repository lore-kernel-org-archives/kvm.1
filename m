Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760E387372
	for <kvm@vger.kernel.org>; Tue, 20 Jan 2026 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939991; cv=none; b=jQlrHdtzwgFU+Vz1fiUVcLqUjsBUYciYkv9P0gnsSBsvVz0QcR6ubnQS412Tv4t4SvkACqM5f96YNymogrebKnhDhylwwSswXDVC7/WUv+i9EtGiSxPpYVwpjxjXGCFY12BZkEzNsHAgVcaMEXl/xk/Mn2DqeveRtsNGgIR4vog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939991; c=relaxed/simple;
	bh=KxCkJm2SpY4xHZq78uUaGcwf/wWSqXZC/SlJgCd/qCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bel+c0zM8LeyNzaDpL5EiF3hOx/jc3N4jfVaMxbvnWuqQf1WrLLiE7DY/3TDp8PNX4g/2OFTHoePBdVV91IsYD5SHw3gnlsadDnIvoirlX7ZsSty4heotIWWEm6H9xpGhJC19eK5YLE4WmmPBtqt2tNI/LCcYHdOCSJe1fwI/fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pW52/uMf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UOaUWeKE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pW52/uMf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UOaUWeKE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pW52/uMf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UOaUWeKE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pW52/uMf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UOaUWeKE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78DBE336BE;
	Tue, 20 Jan 2026 20:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768939980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GDq9x24P3V2ERsKLShNWJSb7NtBBH1+qJAIRRPhGtg=;
	b=pW52/uMfKT6GgZsU59ZMMQwQVujYFpQ3bGqm28tfVhztjzxauhl/QNF9hDUQhtjhyPpxKk
	Nf1mxL7wEC0gWHWd4nJe5IJJs98foDkkAW5I7eQhrO5o7Yn7+MlhstshYZo513J/aHI4m5
	LR436oQyD0R3iKbEgfDSIjUoMW5knxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768939980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GDq9x24P3V2ERsKLShNWJSb7NtBBH1+qJAIRRPhGtg=;
	b=UOaUWeKEsNXFYlpX0zGivl8OifSQmk1Fqn6F86ZVNsoJ7Tt1hbGC2qBWiHQQdiKXjB11Yz
	iffsMPwTwy9Kh/Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768939980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GDq9x24P3V2ERsKLShNWJSb7NtBBH1+qJAIRRPhGtg=;
	b=pW52/uMfKT6GgZsU59ZMMQwQVujYFpQ3bGqm28tfVhztjzxauhl/QNF9hDUQhtjhyPpxKk
	Nf1mxL7wEC0gWHWd4nJe5IJJs98foDkkAW5I7eQhrO5o7Yn7+MlhstshYZo513J/aHI4m5
	LR436oQyD0R3iKbEgfDSIjUoMW5knxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768939980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GDq9x24P3V2ERsKLShNWJSb7NtBBH1+qJAIRRPhGtg=;
	b=UOaUWeKEsNXFYlpX0zGivl8OifSQmk1Fqn6F86ZVNsoJ7Tt1hbGC2qBWiHQQdiKXjB11Yz
	iffsMPwTwy9Kh/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0CB83EA63;
	Tue, 20 Jan 2026 20:12:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kOOQI8vhb2nRMAAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 20 Jan 2026 20:12:59 +0000
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
Subject: [PATCH v2 3/6] KVM: SEV: use mutex guard in sev_mem_enc_register_region()
Date: Tue, 20 Jan 2026 21:10:11 +0100
Message-ID: <20260120201013.3931334-6-clopez@suse.de>
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
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

Simplify the error paths in sev_mem_enc_register_region() by using a
mutex guard, allowing early return instead of using a goto.

Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/x86/kvm/svm/sev.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index bede01fc9086..30f702c01caf 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2690,13 +2690,13 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	if (!region)
 		return -ENOMEM;
 
-	mutex_lock(&kvm->lock);
+	guard(mutex)(&kvm->lock);
 	region->pages = sev_pin_memory(kvm, range->addr, range->size, &region->npages,
 				       FOLL_WRITE | FOLL_LONGTERM);
 	if (IS_ERR(region->pages)) {
 		ret = PTR_ERR(region->pages);
-		mutex_unlock(&kvm->lock);
-		goto e_free;
+		kfree(region);
+		return ret;
 	}
 
 	/*
@@ -2713,13 +2713,8 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	region->size = range->size;
 
 	list_add_tail(&region->list, &sev->regions_list);
-	mutex_unlock(&kvm->lock);
 
 	return ret;
-
-e_free:
-	kfree(region);
-	return ret;
 }
 
 static struct enc_region *
-- 
2.51.0

