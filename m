Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CF7388860
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966843; cv=none; b=UKj0NPbyxCM0kGA39ySAPpyEo8lmWRuI9Zj5rvsyQs3j/eFbqSy8BzdQxsKquTnkWdRMH0DJs1mchMZ0gCjpWJfQBW9nN4kdAgmW+mDAYkXejEQOtXLuJZIBTyecdfu++FyYAJpyZoGP6dM7Z8c1n4H3Xb7ino60jgKDK62cyM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966843; c=relaxed/simple;
	bh=XCVRrieoR1gwC/o8Aoj+i0L7PmZyHaqGJ4GidetJ1H0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d+NOUGyAOcAOuwedrVbBr8Tk/i9S4dZzSxoSxKnLbieKJaobJ3ZNsKRhCIlrZfzI2sD93yolEFAnJZZ9A6OrmQFrDXDBoKsxaOcAtAueoJju6x246mLNMRHWjEVybvQwjTqppYRx/zWLWaiq0kDE7r3oaEt+4Rl35oeUHvQtT2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SQZjCH9D; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SQZjCH9D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SQZjCH9D";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SQZjCH9D"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 03F1966E71;
	Thu, 28 May 2026 11:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779966840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=owMz5j+HeAd11FbGOb/Ex+IRPMPwTMBWgU6EL1hRCeU=;
	b=SQZjCH9DSesrM8PFSt9KePK7rJ5FJZFyByA7dz8QgP6rivU0C9H1MI+V+l8uUdUKHpH10t
	sbBQnSspLJUIM2/iLsB6wNAxa2SJ0Lh/1u5/hX5LeGKf2NoteGy+uoAvR/Pe6L+H7OKf0n
	jfazzelO0r0y6jopxunMYs1uOx81A0E=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SQZjCH9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779966840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=owMz5j+HeAd11FbGOb/Ex+IRPMPwTMBWgU6EL1hRCeU=;
	b=SQZjCH9DSesrM8PFSt9KePK7rJ5FJZFyByA7dz8QgP6rivU0C9H1MI+V+l8uUdUKHpH10t
	sbBQnSspLJUIM2/iLsB6wNAxa2SJ0Lh/1u5/hX5LeGKf2NoteGy+uoAvR/Pe6L+H7OKf0n
	jfazzelO0r0y6jopxunMYs1uOx81A0E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A24B95AD61;
	Thu, 28 May 2026 11:13:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M/ZzJncjGGqcMgAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 28 May 2026 11:13:59 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v2 0/5] KVM/x86: Drop "1" as MSR emulation return value
Date: Thu, 28 May 2026 13:13:52 +0200
Message-ID: <20260528111357.264809-1-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 03F1966E71
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.01

Get rid of the literal "1" used as general error return value in KVM
MSR emulation. It can easily be replaced by negative errno values
instead.

This is meant to avoid confusion with the literal "1" used as return
value for "return to guest".

Changes in V2:
- series carved out from initial "KVM: Avoid literal numbers as return
  values" series
- don't use new KVM_MSR_RET_* defines, but 0 and -errno

Juergen Gross (5):
  KVM/x86: Change comment before KVM_MSR_RET_* defines
  KVM/x86: Return -errno instead of "1" for APIC related MSR emulation
  KVM/x86: Return -errno instead of "1" for Hyper-V related MSR
    emulation
  KVM/x86: Return -errno instead of "1" for VMX related MSR emulation
  KVM/x86: Return -errno instead of "1" for SVM related MSR emulation

 arch/x86/kvm/hyperv.c        | 72 +++++++++++++--------------
 arch/x86/kvm/lapic.c         | 39 +++++++--------
 arch/x86/kvm/svm/pmu.c       |  4 +-
 arch/x86/kvm/svm/svm.c       | 36 +++++++-------
 arch/x86/kvm/vmx/nested.c    |  2 +-
 arch/x86/kvm/vmx/pmu_intel.c | 16 +++---
 arch/x86/kvm/vmx/tdx.c       | 10 ++--
 arch/x86/kvm/vmx/vmx.c       | 96 ++++++++++++++++++------------------
 arch/x86/kvm/x86.h           |  4 +-
 9 files changed, 139 insertions(+), 140 deletions(-)

-- 
2.54.0

