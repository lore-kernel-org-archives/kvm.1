Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C033F5BCF
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002670; cv=none; b=f1/UMaVvm3vCAhqSF3zm+xi0lJO2VOP5yEiDQsc8yJUn9vklL+rMq5Rd10KbhiS3c2HKcHyb7p770Gxph8tfowBRLIeCTZ30X1hhklT7M22zP/3/Juh5URzYzasi2nUoUt3d+nxkJnMa/F+L3BWTXPQc/4wD3Ia3aijLSQUtg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002670; c=relaxed/simple;
	bh=OL3c3WJznoDT2rK/2sYKi7MyEIgWbC46spTocz86Scc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=segQMTW8bFzgrTqzggBK+uBmR7SgXW+2MnYn1q2hR01nsG728Co3JLOLWj9OWLF63ZOt/jBOPrg0yyvo2aV40dfwGqCqxmAMQhpoq5O6EY75LpCOxkrSbwrTTDWeoEYk9RcC6CXmugqmCTSHv00+XnSbWvUg1Zp3WPwJpJwgH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RhoDZa8Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i0VNsBeW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KMw9sp+l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fAKBlq6J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RhoDZa8Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i0VNsBeW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KMw9sp+l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fAKBlq6J"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF8AB6A97C;
	Tue,  9 Jun 2026 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781002666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wPv3o28yiumDje5vQ0CaS9kuTA0vxaxFw3I1ExvAgQA=;
	b=RhoDZa8Zv9yj/KAqoMuLPJLgYX2hA/pPY+cqVtio7ZvcOiIGv7qyGdxtrvsf4XHWMKV1BI
	U8sxBOenscrXkY9U6s2LP7Ifn9UoemJmpq1rN27sifOcjOC9zhD/PiXHYHsdTgnh1bNMA3
	IQ/eAMrI3s9H4XQ+sH6Zy/LaGpR9b+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781002666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wPv3o28yiumDje5vQ0CaS9kuTA0vxaxFw3I1ExvAgQA=;
	b=i0VNsBeWAI8czWB7Iygyse1yxtiNfX9+pFuK+42LHEwxrqZI1hUVoLOzT0QaLpIsU5SHzE
	zOXPg1bTawWXK0AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KMw9sp+l;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fAKBlq6J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781002665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wPv3o28yiumDje5vQ0CaS9kuTA0vxaxFw3I1ExvAgQA=;
	b=KMw9sp+lTJKro2WRGHBsx8uy1CI86Wu0Uh7yePHONgEhDAgNNg5e4tEdgLoh6518AEM9nE
	fgvJPhqS/1KfwJqALjs6dawpZqchfoTXAU9HFGE8kbK0fXV/x3qJg2l3gJvsGRLuNuBQ78
	dcUZfpnmhzyD1OLzY+ybjaUi7BJciTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781002665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wPv3o28yiumDje5vQ0CaS9kuTA0vxaxFw3I1ExvAgQA=;
	b=fAKBlq6JN2ZtI+6cSOzJ3o5FDqODih7uzHNfKgk1c+sng+N1gCHKBd9nncwQ20+rBSvlYX
	2u0biJw+L4RCGyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CFC0779A7;
	Tue,  9 Jun 2026 10:57:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A9vYD6nxJ2qYewAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 09 Jun 2026 10:57:45 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
Subject: [PATCH v2 0/2] KVM: x86: MCE fixes
Date: Tue,  9 Jun 2026 12:55:24 +0200
Message-ID: <20260609105525.2545638-2-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EF8AB6A97C
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

These two patches are somewhat unrelated, but patch 2 came out of
Sean's suggestions from reviewing the first patch (see [1]). Patch 1 is
unchanged.

Note that the SDM is ambiguous regarding the logging behavior for
IA32_MCG_CTL, so additional correctness fixes may be warranted on top.

[1] https://lore.kernel.org/all/20260516163412.601908-1-clopez@suse.de/

Carlos López (2):
  KVM: x86: Fix array_index_nospec() protection in kvm_vcpu_ioctl_x86_set_mce()
  KVM: x86: Do not gate MCE logging based on IA32_MCi_CTL

 arch/x86/kvm/x86.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)


base-commit: de3a35be92d2391ece4bf3143ef2887192625fd0
-- 
2.51.0

