Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B93ACA5C
	for <kvm@vger.kernel.org>; Tue, 20 Jan 2026 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768940005; cv=none; b=Ag/k6KRqdRXS4cATMBJy/vW8LNTGdUum6q8BfDHntQ31HLOATC7bBnCt3kJqay3SK5FP4t8c1797e9KBchy0abGzf5/zLGpRuqhZrihHPMNtvp4lceWcAcmKZU4kTc0+KQtZcYmlMErj8QkmH3F0vUg1xEtOZJ5DaIZxdmoFltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768940005; c=relaxed/simple;
	bh=qFXrG3NkyJKzCnGrH+sNdVBL1isCqyrB939wpVSCdo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJ7VzwmDX+PwvU7WC8DJoVm4oEf4CaQf7duLeUK/xeAngQhyVo972a642rOBZ5vFGMG12qQ382lVAEbESIbWkCgmwum+d03/cRnB6t7fhWWbFkjSjj4yl21jl9Xm698FW9J/cIXNEuPohVyxiSWThfdzlSICs/bvaGmEmnL77DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=awI+kUGA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jzmdzeqw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=awI+kUGA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jzmdzeqw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="awI+kUGA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jzmdzeqw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="awI+kUGA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jzmdzeqw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AFB8A33766;
	Tue, 20 Jan 2026 20:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768939983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQttywv9kkWJJ0SFatJC9sDq19fKr6EsEmunRpzN/mA=;
	b=awI+kUGAh8kUg/vo5UcVU5AhJD4f1QPaJiVwt2SBJUgJzGseShGq3KxlKRn9B55GK63x2x
	4hpICeZNksfuzG77XHOQmTQCERWwz/LT+W8DeFTt0ENPNJSlSa70mWghO9/wNBQ6fmpYyS
	832LzRh3Nv6pP6m7Uk1PYS34ykpahp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768939983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQttywv9kkWJJ0SFatJC9sDq19fKr6EsEmunRpzN/mA=;
	b=jzmdzeqwECx7aqyq7Ob7HwGNZ4uuWn3BztmysdUymsOHFiBiPPbCgiBJCdwP7eURFr+fz7
	yPNHKCxPsZqiSqAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768939983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQttywv9kkWJJ0SFatJC9sDq19fKr6EsEmunRpzN/mA=;
	b=awI+kUGAh8kUg/vo5UcVU5AhJD4f1QPaJiVwt2SBJUgJzGseShGq3KxlKRn9B55GK63x2x
	4hpICeZNksfuzG77XHOQmTQCERWwz/LT+W8DeFTt0ENPNJSlSa70mWghO9/wNBQ6fmpYyS
	832LzRh3Nv6pP6m7Uk1PYS34ykpahp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768939983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQttywv9kkWJJ0SFatJC9sDq19fKr6EsEmunRpzN/mA=;
	b=jzmdzeqwECx7aqyq7Ob7HwGNZ4uuWn3BztmysdUymsOHFiBiPPbCgiBJCdwP7eURFr+fz7
	yPNHKCxPsZqiSqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5EB43EA63;
	Tue, 20 Jan 2026 20:13:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yGjLMM7hb2nRMAAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 20 Jan 2026 20:13:02 +0000
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
Subject: [PATCH v2 6/6] KVM: SEV: use scoped mutex guard in sev_asid_new()
Date: Tue, 20 Jan 2026 21:10:14 +0100
Message-ID: <20260120201013.3931334-9-clopez@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLtm3bmjtwwfkzb5ddzerbmdsq)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

Simplify the lock management in sev_asid_new() by using a mutex guard,
automatically releasing the mutex when following the goto.

Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/x86/kvm/svm/sev.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d3fa0963465d..d8d5c3a703f9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -231,24 +231,20 @@ static int sev_asid_new(struct kvm_sev_info *sev, unsigned long vm_type)
 		return ret;
 	}
 
-	mutex_lock(&sev_bitmap_lock);
-
+	scoped_guard(mutex, &sev_bitmap_lock) {
 again:
-	asid = find_next_zero_bit(sev_asid_bitmap, max_asid + 1, min_asid);
-	if (asid > max_asid) {
-		if (retry && __sev_recycle_asids(min_asid, max_asid)) {
-			retry = false;
-			goto again;
+		asid = find_next_zero_bit(sev_asid_bitmap, max_asid + 1, min_asid);
+		if (asid > max_asid) {
+			if (retry && __sev_recycle_asids(min_asid, max_asid)) {
+				retry = false;
+				goto again;
+			}
+			ret = -EBUSY;
+			goto e_uncharge;
 		}
-		mutex_unlock(&sev_bitmap_lock);
-		ret = -EBUSY;
-		goto e_uncharge;
+		__set_bit(asid, sev_asid_bitmap);
 	}
 
-	__set_bit(asid, sev_asid_bitmap);
-
-	mutex_unlock(&sev_bitmap_lock);
-
 	sev->asid = asid;
 	return 0;
 e_uncharge:
-- 
2.51.0

