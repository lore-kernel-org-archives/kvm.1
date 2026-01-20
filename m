Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B380622759C
	for <kvm@vger.kernel.org>; Tue, 20 Jan 2026 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939978; cv=none; b=FsPmES64QoCdtp86dZagbl/Kgtd1jbyO+AbOHRajl2YlxXn/z/abH2a7y3WNxgbPH3eHk/h1gp7qyMgkmYZFFB0HOZlhWETmOEm/3FXJezcpkHISP/uppcyV50Rf1ey0Yr+9qSSzICq3MZoHbEEjjAtcaASwU7IL1WxZRtcRu+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939978; c=relaxed/simple;
	bh=3f5YhV1QRCnYIZfcULkRJffzCzt3XkDHxKcbfXaJt7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e6/ONUcCf/cfjLs4H0A1wjuz3S/tkJIBHjmcsvWsYrZsqdH6bNo63xZSA85mJMROk6tP7EDIgYuMW5w/5w8MABjVudYf0QP29IOD6OCUBAytP9HfFJ8wAEgsbiO4pddJvNZbHQmYEtIQrLGv6z67ZybPULrY6gZ+KmrBeGv+vqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Quq8okwA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oVvZvMJ3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Quq8okwA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oVvZvMJ3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Quq8okwA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oVvZvMJ3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Quq8okwA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oVvZvMJ3"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5E0F5BCCB;
	Tue, 20 Jan 2026 20:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768939974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dlYXHEpPJ4jLQH+GJOt0qwm1/rfZkRFGO+xHT3yvUCw=;
	b=Quq8okwApqwduicOk6pCSeyV4EFgRd2bQvPD4Bla49pEKzHYBpRe5flYmhRFujr1+eqcy/
	ukeuAbspV8XN2H8MoudbkoNKKwKfsgu5pwuN9oxNHVDQ+KSr0cPZ3NYZx/AmrnmHr1NyAX
	ElKzCfdC4jAU7fyS8+6aRCFLzTI7Q0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768939974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dlYXHEpPJ4jLQH+GJOt0qwm1/rfZkRFGO+xHT3yvUCw=;
	b=oVvZvMJ3Y+HoM5RxoGxFjimNiJFGO0+qCxE2UTnw0xxOQc0ojlTsZcOEgbNbwDOxPC6rfe
	IxpDFySky5ELayAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Quq8okwA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oVvZvMJ3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768939974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dlYXHEpPJ4jLQH+GJOt0qwm1/rfZkRFGO+xHT3yvUCw=;
	b=Quq8okwApqwduicOk6pCSeyV4EFgRd2bQvPD4Bla49pEKzHYBpRe5flYmhRFujr1+eqcy/
	ukeuAbspV8XN2H8MoudbkoNKKwKfsgu5pwuN9oxNHVDQ+KSr0cPZ3NYZx/AmrnmHr1NyAX
	ElKzCfdC4jAU7fyS8+6aRCFLzTI7Q0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768939974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dlYXHEpPJ4jLQH+GJOt0qwm1/rfZkRFGO+xHT3yvUCw=;
	b=oVvZvMJ3Y+HoM5RxoGxFjimNiJFGO0+qCxE2UTnw0xxOQc0ojlTsZcOEgbNbwDOxPC6rfe
	IxpDFySky5ELayAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0640E3EA63;
	Tue, 20 Jan 2026 20:12:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K3CLOcXhb2nRMAAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 20 Jan 2026 20:12:53 +0000
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
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
Subject: [PATCH v2 0/6] KVM: SEV: use mutex guards for simpler error handling
Date: Tue, 20 Jan 2026 21:10:08 +0100
Message-ID: <20260120201013.3931334-3-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: C5E0F5BCCB
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

Replace several uses of mutex_lock() / mutex_unlock() pairs with mutex
guards, which are less error-prone and help simplify error paths,
allowing removal of all gotos in some functions. This removes around 40
lines of code in total.

This does not remove all uses of the manual lock APIs, only those that
have their error handling improved by switching to the newer API.

Changes are separated per-function for ease of review.

---
v2: Removed an unnecessary include.

Carlos López (6):
  KVM: SEV: use mutex guard in snp_launch_update()
  KVM: SEV: use mutex guard in sev_mem_enc_ioctl()
  KVM: SEV: use mutex guard in sev_mem_enc_register_region()
  KVM: SEV: use mutex guard in sev_mem_enc_unregister_region()
  KVM: SEV: use mutex guard in snp_handle_guest_req()
  KVM: SEV: use scoped mutex guard in sev_asid_new()

 arch/x86/kvm/svm/sev.c | 134 ++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 88 deletions(-)


base-commit: 0499add8efd72456514c6218c062911ccc922a99
-- 
2.51.0

