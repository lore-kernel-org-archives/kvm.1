Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D263E3D99
	for <kvm@vger.kernel.org>; Sat, 16 May 2026 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778949276; cv=none; b=lEpxw1LOHNdLrAnWboleLiTKqkP30yKnaIoJ4Iga3j95Gpqk1ZaRyhM4XqxlMl+r1haRXTFZdXgbOc+iFpw/n12mAKdwkA/ac9QlGChi/CjC5xQ/wmtB/+KU9IIh4dILSQoDTABYhfLDw2lB5VXr0FIS8ZjH3IxkyAVH7ZgIpiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778949276; c=relaxed/simple;
	bh=ULnw3NN7INb58UYB2pLIPDzzAfwi2mUZCZrZ9Qf2VT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uP12u6fiL/tr3HR7S75hwdIXL/rtABnv6pn7MSlxRv9pKPbfyVn1Js3YxJJ6dhLvqUkwqgijNtqlVef1ddg2E8AaELtFCjeLr4/fBBsd+i+OZnHrgScr9jiabTbqwEJ9Y/kE+un0frn028WNgEia++iZdUVQeY5juYzXOgtpJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sn4mObjY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2WudjVMS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sn4mObjY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2WudjVMS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sn4mObjY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2WudjVMS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sn4mObjY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2WudjVMS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 410286BADE;
	Sat, 16 May 2026 16:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778949273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BUPDNdf/gbPSEsfuVSYEDFC8szZ6vWKFT58zEEULitA=;
	b=Sn4mObjY1M/C6pSmtPwFywTYug3GPcRylcJ5S1GWViE4k3yWk+G/Xo4+VpTnkgPipSUPhU
	tN88wX8CPhEbDRMQgJuaMCOOFzZDhtVKFxTe6dU9cTFnnmgzc3NpNL90SfnZY3PVqWKYmQ
	BVcsaccVTtzch5O/iEtzN0stz+Vq1no=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778949273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BUPDNdf/gbPSEsfuVSYEDFC8szZ6vWKFT58zEEULitA=;
	b=2WudjVMSdBzrhObjxzSmTwFNb4DuqIwyQsshIiutSq5Amns1W1EA+JIKcH4cACuf5j4dT3
	B3svI4RTb9aS0dAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Sn4mObjY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2WudjVMS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778949273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BUPDNdf/gbPSEsfuVSYEDFC8szZ6vWKFT58zEEULitA=;
	b=Sn4mObjY1M/C6pSmtPwFywTYug3GPcRylcJ5S1GWViE4k3yWk+G/Xo4+VpTnkgPipSUPhU
	tN88wX8CPhEbDRMQgJuaMCOOFzZDhtVKFxTe6dU9cTFnnmgzc3NpNL90SfnZY3PVqWKYmQ
	BVcsaccVTtzch5O/iEtzN0stz+Vq1no=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778949273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BUPDNdf/gbPSEsfuVSYEDFC8szZ6vWKFT58zEEULitA=;
	b=2WudjVMSdBzrhObjxzSmTwFNb4DuqIwyQsshIiutSq5Amns1W1EA+JIKcH4cACuf5j4dT3
	B3svI4RTb9aS0dAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E1C6593A8;
	Sat, 16 May 2026 16:34:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HGwiH5icCGpyfgAAD6G6ig
	(envelope-from <clopez@suse.de>); Sat, 16 May 2026 16:34:32 +0000
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
	Jue Wang <juew@google.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH] KVM: x86: Fix array_index_nospec() protection in kvm_vcpu_ioctl_x86_set_mce()
Date: Sat, 16 May 2026 18:34:12 +0200
Message-ID: <20260516163412.601908-1-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 410286BADE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.51

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
index 209eae67ab18..2d2415031267 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5497,7 +5497,8 @@ static int kvm_vcpu_ioctl_x86_set_mce(struct kvm_vcpu *vcpu,
 	if (mce->bank >= bank_num || !(mce->status & MCI_STATUS_VAL))
 		return -EINVAL;
 
-	banks += array_index_nospec(4 * mce->bank, 4 * bank_num);
+	mce->bank = array_index_nospec(mce->bank, bank_num);
+	banks += 4 * mce->bank;
 
 	if (is_ucna(mce))
 		return kvm_vcpu_x86_set_ucna(vcpu, mce, banks);

base-commit: a9512a611bd030088f13477258d1f8103cceaa40
-- 
2.51.0

