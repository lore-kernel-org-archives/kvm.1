Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D8B37BE63
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320868; cv=none; b=ci1CtPGApt4NJmtXOuL6VJlHdq9yfs92D1wySnH2yKGbDBgOBgu1bcsNGF/lyl7irLMqPGOYE6byoZU6YH9bNZlyKNIldYNbai4cE8/uH5553YfjVu1HgPkDWwNesV4U3f4EImorTMJ+mQTWfNpugh48Jzs9AzzG02A87V9lKXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320868; c=relaxed/simple;
	bh=YwRNdnVIKZ4XKjqk5/e8kdJdiJOXCwat5tQNgSc51i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y5+TaWzhtW1WTEZowk4B5IbdGxs7Mn7jzc5pEAsfeXlPDE5xMmq3k8/o7KVY4wT/pfWBYdbGHuEQZAhc4TPLsC32sIUhpNQUS3jbSb5mupG+Gqr9B9EvUhT6SFfafm/mEAR61B/TFr48Lr8nUzFj5CViYOJsV4sdBmlnXP3oVX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K2QCwuJo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WR9y94Dy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K2QCwuJo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WR9y94Dy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K2QCwuJo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WR9y94Dy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K2QCwuJo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WR9y94Dy"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AE15679FB;
	Mon,  1 Jun 2026 13:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780320866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UIN6KOcpG9Dt9K6CC2W8F/dOdi/K0Wh4lLwVNp2FS+o=;
	b=K2QCwuJookviIKs2oeMb0sqJy4FsPsM2e0BD6e8e0lAP/v3hWxu9Xga1caxOdZdkIVmsov
	AesGnRsA0jnBYWYTn775rYZsLK0mS5jbeQ2Vam7jU9hCb125wThiUt+PsNXWRbeAGC6KVD
	KsYxaiHG610p4y8kCkJjheDG7itd1EQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780320866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UIN6KOcpG9Dt9K6CC2W8F/dOdi/K0Wh4lLwVNp2FS+o=;
	b=WR9y94Dy/XcrG4JwoviIbFQfNxOZo8I693bl2Nt9vsg3Z8vw1mJeJxd0pxyXBvqLSWgrD0
	OPYAvkKdCEXKUmDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780320866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UIN6KOcpG9Dt9K6CC2W8F/dOdi/K0Wh4lLwVNp2FS+o=;
	b=K2QCwuJookviIKs2oeMb0sqJy4FsPsM2e0BD6e8e0lAP/v3hWxu9Xga1caxOdZdkIVmsov
	AesGnRsA0jnBYWYTn775rYZsLK0mS5jbeQ2Vam7jU9hCb125wThiUt+PsNXWRbeAGC6KVD
	KsYxaiHG610p4y8kCkJjheDG7itd1EQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780320866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UIN6KOcpG9Dt9K6CC2W8F/dOdi/K0Wh4lLwVNp2FS+o=;
	b=WR9y94Dy/XcrG4JwoviIbFQfNxOZo8I693bl2Nt9vsg3Z8vw1mJeJxd0pxyXBvqLSWgrD0
	OPYAvkKdCEXKUmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68C76779A7;
	Mon,  1 Jun 2026 13:34:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zDeiFmGKHWreSAAAD6G6ig
	(envelope-from <clopez@suse.de>); Mon, 01 Jun 2026 13:34:25 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com
Cc: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH] KVM: x86: fix #GP check in em_dr_write()
Date: Mon,  1 Jun 2026 15:33:21 +0200
Message-ID: <20260601133320.91479-2-clopez@suse.de>
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
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Level: 

When emulating a MOV to a debug register, em_dr_write() calls
@ctxt->ops->set_dr(), which is forwarded to emulator_set_dr() and
then kvm_set_dr(). The latter checks that the written value is valid,
otherwise returning an error, in which case the emulator is supposed to
inject a #GP fault into the guest.

Commit 996ff5429e98 ("KVM: x86: move kvm_inject_gp up from kvm_set_dr
to callers") changed the contract of kvm_set_dr() (and thus
emulator_set_dr()), returning 1 as an error instead of -1, but the
caller in em_dr_write() was never updated, checking only if the returned
value is negative. The end result is that em_dr_write() does not detect
the error, so an invalid write does not generate a #GP, but at the same
time the register value is not updated.

The practical impact is limited, as check_dr_write() already checks DR6
and DR7 manually. However, it misses DR4/DR5, which alias DR6/DR7 when
CR4.DE=0.

Fix this by treating any non-zero return from set_dr() as a reason to
inject #GP.

Fixes: 996ff5429e98 ("KVM: x86: move kvm_inject_gp up from kvm_set_dr to callers")
Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/x86/kvm/emulate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 585a8ceab220..de138ef92dc6 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3299,7 +3299,7 @@ static int em_dr_write(struct x86_emulate_ctxt *ctxt)
 		val = ctxt->src.val & ~0U;
 
 	/* #UD condition is already handled. */
-	if (ctxt->ops->set_dr(ctxt, ctxt->modrm_reg, val) < 0)
+	if (ctxt->ops->set_dr(ctxt, ctxt->modrm_reg, val) != 0)
 		return emulate_gp(ctxt, 0);
 
 	/* Disable writeback. */

base-commit: d1568b1332b6b3b36b222c2868fc102727c12a34
-- 
2.51.0

