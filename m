Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED61D275AE4
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011325; cv=none; b=grC4ndo0HBD+h9VmcVyuIbYlw4v6lgLe5j/8HqjODIkvuhfEQ4Ba4v+aqQ6SVvQSeqKkc6hdejpgdPGSVcLxCYfB1Cp6EQCcSiVCvl5eGAfR4DACoJKlkK5kwzfczWNhkprjewU+Tr/qxSOIYk9gMKQdCz6MYtfKgy4ibXGC4I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011325; c=relaxed/simple;
	bh=n1HfwzmLCDEjixLYv512DuLRgTPQMI58+azga0nM+i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L9YMdDROnrhXuthKaXjpoXNICEHMU8bUxNhOXpiZ+cMci2K6HmynhiN40U1d4X7W9NqmiPOCtdgjEe0Dh/l5nFA/+oSApESQBVfrtHYY6lhJkF+MfgrdM5O6tsU+BRJX2GCpqfj1mDAakCCmBYOTa9nmiY8S8GB8NIjRuEa94uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ubkxQnl0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/tX9bgkY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ubkxQnl0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/tX9bgkY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ubkxQnl0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/tX9bgkY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ubkxQnl0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/tX9bgkY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4185475A6B;
	Tue,  9 Jun 2026 13:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781011322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WfGqBX6jXv3/tORLJ9xsfYAvwBj/xTgS2ppNVbV+pBE=;
	b=ubkxQnl0SZXCmzcmzZGIHmxD/fmG8779G9CRuhA/WIb4mG0Em70p75CVpAMzm2ESd5Y6jS
	ZQ/vL4mXuznUkD+ZZ/PXPcxjVOTMFcHRPh0SkojnhzRnYcIUGuB5GLSGA1F3ua9eNGEXHW
	hlvvEHE/xcC87Qp/YbSZdT+X5FHr2M0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781011322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WfGqBX6jXv3/tORLJ9xsfYAvwBj/xTgS2ppNVbV+pBE=;
	b=/tX9bgkYpAQkqKHyZnjOCHqoWuIeY0elMYZxSz77/861lEkPm94sNtMnIGrrJPLep20YI0
	ImvzwjAhhWQAmWCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781011322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WfGqBX6jXv3/tORLJ9xsfYAvwBj/xTgS2ppNVbV+pBE=;
	b=ubkxQnl0SZXCmzcmzZGIHmxD/fmG8779G9CRuhA/WIb4mG0Em70p75CVpAMzm2ESd5Y6jS
	ZQ/vL4mXuznUkD+ZZ/PXPcxjVOTMFcHRPh0SkojnhzRnYcIUGuB5GLSGA1F3ua9eNGEXHW
	hlvvEHE/xcC87Qp/YbSZdT+X5FHr2M0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781011322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WfGqBX6jXv3/tORLJ9xsfYAvwBj/xTgS2ppNVbV+pBE=;
	b=/tX9bgkYpAQkqKHyZnjOCHqoWuIeY0elMYZxSz77/861lEkPm94sNtMnIGrrJPLep20YI0
	ImvzwjAhhWQAmWCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93A6E779A7;
	Tue,  9 Jun 2026 13:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iI7yIHkTKGpnDgAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 09 Jun 2026 13:22:01 +0000
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
Subject: [PATCH v3 0/2] KVM: x86: MCE fixes
Date: Tue,  9 Jun 2026 15:18:54 +0200
Message-ID: <20260609131856.2562222-2-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -3.30

These two patches are somewhat unrelated, but patch 2 came out of
Sean's suggestions from reviewing the first patch (see [1]). Patch 1 is
unchanged.

v3:
  * Address Sashiko's review. While incorrect in pointing out MCIP's
    role, it was partially correct in the sense that the MCE logging
    rules were still not fully compliant to the SDM.

v2:
  * Add patch 2.

[1] https://lore.kernel.org/all/20260516163412.601908-1-clopez@suse.de/

Carlos López (2):
  KVM: x86: Fix array_index_nospec() protection in
    kvm_vcpu_ioctl_x86_set_mce()
  KVM: x86: Fix MCE logging rules for KVM_X86_SET_MCE

 arch/x86/kvm/x86.c | 65 +++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 24 deletions(-)


base-commit: de3a35be92d2391ece4bf3143ef2887192625fd0
-- 
2.51.0

