Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7235AC37
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404548; cv=none; b=iwcPT3LvVeF3GSdABB9afUFSpD7oEJhwwLo90KoHldXZ4TFXaRppeLhAHvUki59tUUo+qsOY/YV8PHEtlZqPGXvENd1g4O/e5DmYdSIprH7CNRjDt+MlcL7D4c7yuq+MX3rkmuwZa23NDduJFntRQXmO+jx2fg1eIzoKDHZ7woc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404548; c=relaxed/simple;
	bh=wEmkZnRugDmEPZUO8JNary4kx4U0kk1AWogTfuBYAk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f9kyCMLQVExe0koaOQ2vKeQwkAqpZNqdKJjEovfnSYNQnDLVII0/GgmAWxD0GMybedCDBs3DMqMHsoG/mljMaIJtv/kZ5E/8kS2FBkWT9aGSegG3ckg6M88pPRIuXBMv9sn9pU1Ttma51f9Z/o92Ba3BkqoZc84U+MuJ1zAXOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IPHnMKzu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kkXj5b/x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IPHnMKzu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kkXj5b/x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IPHnMKzu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kkXj5b/x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IPHnMKzu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kkXj5b/x"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C6935BDAE;
	Fri, 13 Mar 2026 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773404545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eu4RQxMOiV6iipRCCWw33d861NDRsOjNtVtDWOpR5Y0=;
	b=IPHnMKzu7DH/iTxbvkoZ4j7UO4LeKd63+GnDOwR7XvUmC2Iu++2vXZs1JzuKDYKcGzhoPF
	gjUWNiv9owm//bXTHbxsR4BsY3kPdJxFD47DzeCmvoiAGmVa32DYVU106hoOfDnrFNTO5R
	al8/2q5gB2McAOwVQCzRadnFrkFWRco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773404545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eu4RQxMOiV6iipRCCWw33d861NDRsOjNtVtDWOpR5Y0=;
	b=kkXj5b/x0R9r1DC+NkRUpYv1F6dM7vRBkmTVOQZuX9OoXnVujcBMFxIX2Zb9kbnQOmM67u
	Bq5lcxS6MIxoiGCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773404545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eu4RQxMOiV6iipRCCWw33d861NDRsOjNtVtDWOpR5Y0=;
	b=IPHnMKzu7DH/iTxbvkoZ4j7UO4LeKd63+GnDOwR7XvUmC2Iu++2vXZs1JzuKDYKcGzhoPF
	gjUWNiv9owm//bXTHbxsR4BsY3kPdJxFD47DzeCmvoiAGmVa32DYVU106hoOfDnrFNTO5R
	al8/2q5gB2McAOwVQCzRadnFrkFWRco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773404545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eu4RQxMOiV6iipRCCWw33d861NDRsOjNtVtDWOpR5Y0=;
	b=kkXj5b/x0R9r1DC+NkRUpYv1F6dM7vRBkmTVOQZuX9OoXnVujcBMFxIX2Zb9kbnQOmM67u
	Bq5lcxS6MIxoiGCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0E6140507;
	Fri, 13 Mar 2026 12:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pGwXMIABtGmEPQAAD6G6ig
	(envelope-from <clopez@suse.de>); Fri, 13 Mar 2026 12:22:24 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org
Cc: alex.williamson@redhat.com,
	pbonzini@redhat.com,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
Subject: [PATCH 0/4] KVM: VFIO: use mutex guards to simplify control flow
Date: Fri, 13 Mar 2026 13:20:38 +0100
Message-ID: <20260313122040.1413091-3-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

Replace several uses of mutex_lock() / mutex_unlock() pairs with mutex
guards, allowing removal of all gotos in virt/kvm/vfio.c.

In this series I also include a small refactor that allows greatly
simplifying kvm_vfio_file_del(), and skipping an unnecessary call to
kvm_vfio_update_coherency() if the list of files managed by the KVM
VFIO device does not change.

Carlos López (4):
  KVM: VFIO: clean up control flow in kvm_vfio_file_add()
  KVM: VFIO: use mutex guard in kvm_vfio_file_set_spapr_tce()
  KVM: VFIO: deduplicate file release logic
  KVM: VFIO: update coherency only if file was deleted

 virt/kvm/vfio.c | 97 ++++++++++++++++++-------------------------------
 1 file changed, 35 insertions(+), 62 deletions(-)


base-commit: d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf
-- 
2.51.0

