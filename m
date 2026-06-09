Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8943A3FAE0C
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002669; cv=none; b=VLkh0mTuJJLitJEbpU1+17pgvVd0kG1dLBm5N3H+7idaTfKx3bsfYJUPKt4XjYKst+/SKnAs7bYMCNHz0jhBXqkgOreXprbVdjQQVrQidqRjE/tcAR2diBplao6XR5Fyz69mjv6LXaBJVeAejjzKbSmzy6SxzJBPxHU3B1CiVWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002669; c=relaxed/simple;
	bh=SBBwcY3M5GETY5uU9vIBNJrw02GL3sbPJ/2TYaLM2bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9rAtHHtvc0T+Nle4xaJtgulckb561OyUsdQ/G7UpTyz/6ovQ4Mley160lgZUJb+OsQsmxNPFGtFyPwF7iOXt41NaND9AUE8dxWxWjIt/nPg8GHqPDPeNTgHEKd3Ipcp42g0by5ZttSA62DThPxgAAQoA35gbN9PD6FcOuvRTj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pg5D0Z6C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kKX3zCkY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QTBxvz5W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vetjqRQA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pg5D0Z6C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kKX3zCkY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QTBxvz5W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vetjqRQA"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E707F75834;
	Tue,  9 Jun 2026 10:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781002667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SEaZLyVIakydgNTVKjnpez8i9Q1c+WukArifce2e0E=;
	b=Pg5D0Z6CnMH49TUbA9SuE9xy7Cw+ojcPrQnOgZWemr6z/hulEE/EiGUOs6T0N2SUMdzhzv
	tiJgVkKwsoSnp7QJ66+HZyXHpCGEQGKg5SjF+m4Eh7W0FbJcbLMIfVN8QpMtsLs5e1ajqB
	OROZDtjkb4wUGM5exijcrukVChbwF0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781002667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SEaZLyVIakydgNTVKjnpez8i9Q1c+WukArifce2e0E=;
	b=kKX3zCkY9S5sc64yO2722qDOqKR5P0eQDVRMQA8PdlsGzzL4SYmqIUC0vwrlFsNaDXQY+L
	t1lm5mpg7TmCprBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781002666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SEaZLyVIakydgNTVKjnpez8i9Q1c+WukArifce2e0E=;
	b=QTBxvz5WmHAKOmVK6XmqayG6zpbZHNDL2ANGgH/sNx+KLAxv9pw3U8LY5+NeUbM/gkRCgS
	KYMtSOFscWYDPZ0/m8KzKo1qE6YF4lcbIwFCvhy5bd9VEBzNRJlwyWTu3V735plug46ZgA
	ZMfC6fZa+qNN9R6yhtYsnJwsFfkuXO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781002666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SEaZLyVIakydgNTVKjnpez8i9Q1c+WukArifce2e0E=;
	b=vetjqRQAtoZ/PsVXMVsxkO0uQgiT86Bqsul2ZIBgbjA8ChqDEUG9JezIopGUcG1ksNwraW
	Xf5Vfv1pAkWZJODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 372E0779A7;
	Tue,  9 Jun 2026 10:57:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gO2MCqrxJ2qYewAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 09 Jun 2026 10:57:46 +0000
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
	Jue Wang <juew@google.com>
Subject: [PATCH v2 1/2] KVM: x86: Fix array_index_nospec() protection in kvm_vcpu_ioctl_x86_set_mce()
Date: Tue,  9 Jun 2026 12:55:25 +0200
Message-ID: <20260609105525.2545638-3-clopez@suse.de>
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
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -3.30

Commit aebc3ca19063 ("KVM: x86: Enable CMCI capability by default and
handle injected UCNA errors") introduced kvm_vcpu_x86_set_ucna(), which
accesses @vcpu->arch.mci_ctl2_banks[] using @mce->bank as the index. The
@mce struct is user-controlled, provided via the KVM_X86_SET_MCE ioctl.

The caller of this function, kvm_vcpu_ioctl_x86_set_mce(), bounds-checks
@mce->bank and applies array_index_nospec() to advance the @banks
pointer, but @mce->bank itself is passed through unclamped. On a
speculative path that bypasses the bounds check, the raw @mce->bank
value can index mci_ctl2_banks[] out-of-bounds.

In practice this is a very weak gadget, and would at most allow leaking
a single bit in a 64-bit integer, but prevent potential future issues by
clamping @mce->bank in place with array_index_nospec(), before passing
the struct to kvm_vcpu_x86_set_ucna().

Fixes: aebc3ca19063 ("KVM: x86: Enable CMCI capability by default and handle injected UCNA errors")
Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cf122b8c3210..77a780177c4e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5472,7 +5472,8 @@ static int kvm_vcpu_ioctl_x86_set_mce(struct kvm_vcpu *vcpu,
 	if (mce->bank >= bank_num || !(mce->status & MCI_STATUS_VAL))
 		return -EINVAL;
 
-	banks += array_index_nospec(4 * mce->bank, 4 * bank_num);
+	mce->bank = array_index_nospec(mce->bank, bank_num);
+	banks += 4 * mce->bank;
 
 	if (is_ucna(mce))
 		return kvm_vcpu_x86_set_ucna(vcpu, mce, banks);
-- 
2.51.0

