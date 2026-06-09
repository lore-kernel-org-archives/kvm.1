Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799353FFFB3
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002675; cv=none; b=q+Nlfp03AyxGSvw0EM7yTP+qAc4GR4J5F5WkR7tPw7BWLpJzBuqzdDDBqsb060dxZfd7YexkDN+9VeWfqbxs50TFCu7xeZ31auRRVj/KjANPm/UET+8nrE/xACXFBKgwyTyR4Zq0KZi/dgrClKjpQewLK7BwUTV+IRfe9ccoK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002675; c=relaxed/simple;
	bh=0+hCJrR+Kk5hWVVRyMb8mErOPqcZoJ7vEPDKobvngn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2vW+bGG6TaAeOenwRKm2tiLXi9RHf9Gvlxc6Vko2vD5/+9zHPeJ8tVpY/Vd8fXofnqs7dj+9Nn9GW49Q6YaDzzDC9eRhuUrU+awX7m94tgynqj9fBR4YKcfYua9KAsHm8vPiW8uLyuq44Ul5tq4H9XNvPaLZ9xB3e+ikvkZkR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LVBGWlF6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XwHQVGNB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=omUoP79U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jc7NG0u7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LVBGWlF6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XwHQVGNB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="omUoP79U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jc7NG0u7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDA8A6A9FD;
	Tue,  9 Jun 2026 10:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781002668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGlWtYgrO0YxufvHwO0YTY8OWVNzkXDp7S5Vn+Qlx0A=;
	b=LVBGWlF6C+jHmJjnU3dEiiGA3pRM/MWD1+00CKUvNiIQE93mSRz4AN+AaXWG/VfMc2TbI/
	BzJthHGKxptDg37RX18n4kBgNeoqZsLcCEf740oEi5BJnQDkBnyiWg2p5UCYn3VbCLOKWk
	0nVc9rEt+s/nwsar2TSs3pjQV+WTKKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781002668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGlWtYgrO0YxufvHwO0YTY8OWVNzkXDp7S5Vn+Qlx0A=;
	b=XwHQVGNB/tAh4CrKCCCSz/WJdoXznpW2Hm3Xdf0k2ksJVGGIepnXUz+eB8kWnvAcDm0VNy
	cijt7AAxkno/mwCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=omUoP79U;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Jc7NG0u7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781002667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGlWtYgrO0YxufvHwO0YTY8OWVNzkXDp7S5Vn+Qlx0A=;
	b=omUoP79UceVEKKmMLXO/xm6HRbbaoHtEJOhap910J9/SL3hXuQPDzbfpWqgxK9F99JgQii
	1ErLIP7I4l5NGaUuOkUQSpFQ4Gck9wixw7cqS58AXgvqQRSF30743kBIjxI61S8u70+Bnw
	D+GxbF6gqaSMOGtwmkSpggfK4vpmE1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781002667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGlWtYgrO0YxufvHwO0YTY8OWVNzkXDp7S5Vn+Qlx0A=;
	b=Jc7NG0u7ZNDVUD2JE4pyP2onkLrPo38pHpxKAo8uLRu5Ha+zpOXTzBd+yqhj+cDraZIh60
	ki/q/wlrdBXqBWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30CF7779A7;
	Tue,  9 Jun 2026 10:57:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IP4ACavxJ2qYewAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 09 Jun 2026 10:57:47 +0000
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
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Borislav Petkov <bp@alien8.de>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Avi Kivity <avi@redhat.com>
Subject: [PATCH v2 2/2] KVM: x86: Do not gate MCE logging based on IA32_MCi_CTL
Date: Tue,  9 Jun 2026 12:55:26 +0200
Message-ID: <20260609105525.2545638-4-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260609105525.2545638-2-clopez@suse.de>
References: <20260609105525.2545638-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EDA8A6A9FD
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,linux.intel.com,zytor.com,suse.de,alien8.de,gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

When userspace issues KVM_X86_SET_MCE, kvm_vcpu_ioctl_x86_set_mce()
decides whether to log an uncorrectable MCE by looking at the
corresponding IA32_MCi_CTL MSR. This is not the behavior specified in
the Intel SDM (17.3.2.1 IA32_MCi_CTL MSRs):

  Setting an EEj flag enables signaling #MC of the associated error and
  clearing it disables signaling of the error. Error logging happens
  regardless of the setting of these bits. The processor drops writes to
  bits that are not implemented.

Hoist the logging code, which writes to the corresponding error banks,
above the MCi_CTL check. Keep the #MC delivery after the check, as this
is correct behavior.

Fixes: 890ca9aefa78 ("KVM: Add MCE support")
Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/x86/kvm/x86.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 77a780177c4e..722bead405b5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5485,24 +5485,31 @@ static int kvm_vcpu_ioctl_x86_set_mce(struct kvm_vcpu *vcpu,
 	if ((mce->status & MCI_STATUS_UC) && (mcg_cap & MCG_CTL_P) &&
 	    vcpu->arch.mcg_ctl != ~(u64)0)
 		return 0;
-	/*
-	 * if IA32_MCi_CTL is not all 1s, the uncorrected error
-	 * reporting is disabled for the bank
-	 */
-	if ((mce->status & MCI_STATUS_UC) && banks[0] != ~(u64)0)
-		return 0;
+
 	if (mce->status & MCI_STATUS_UC) {
+		/*
+		 * Per the SDM, error logging always happens independently of
+		 * IA32_MCi_CTL
+		 */
+		if (banks[1] & MCI_STATUS_VAL)
+			mce->status |= MCI_STATUS_OVER;
+		banks[2] = mce->addr;
+		banks[3] = mce->misc;
+		banks[1] = mce->status;
+
+		/*
+		 * if IA32_MCi_CTL is not all 1s, the uncorrected error
+		 * reporting is disabled for the bank
+		 */
+		if (banks[0] != ~(u64)0)
+			return 0;
+
 		if ((vcpu->arch.mcg_status & MCG_STATUS_MCIP) ||
 		    !kvm_is_cr4_bit_set(vcpu, X86_CR4_MCE)) {
 			kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 			return 0;
 		}
-		if (banks[1] & MCI_STATUS_VAL)
-			mce->status |= MCI_STATUS_OVER;
-		banks[2] = mce->addr;
-		banks[3] = mce->misc;
 		vcpu->arch.mcg_status = mce->mcg_status;
-		banks[1] = mce->status;
 		kvm_queue_exception(vcpu, MC_VECTOR);
 	} else if (!(banks[1] & MCI_STATUS_VAL)
 		   || !(banks[1] & MCI_STATUS_UC)) {
-- 
2.51.0

