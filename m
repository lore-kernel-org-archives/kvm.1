Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4B61E47CC
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011331; cv=none; b=S8MklneqyPIB/QVmNZOsVRApusi7Fr9xHVYVdvCNwBwNuS0C6N/RLrkiLcghXamXacbzJ5cPdKSl96nv7bewI1fe9Cm+ikkWZVQFdNKlhkwkh0MKqvD/F7yr636jnRdRqDDwjfbztD/4EkUrR0wryy05gQB+K4MxycpfANslarY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011331; c=relaxed/simple;
	bh=SBBwcY3M5GETY5uU9vIBNJrw02GL3sbPJ/2TYaLM2bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVuWAZTNS86eTC+cAwfaNmIClZJm+lbHGLChsFEGFo/XueeAvWKQNJjsT51OpaUTYE1T2FX+6I5f7cYCSPx+ZRLN/VRs2b6cav5Tu4QTWvip3Exd9eg0VKij9W8j3chUvfcNSuHGMV9GjyIycSO1LZ2bOZAXPD2NfZtSB4JeQrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 39B7A75ACA;
	Tue,  9 Jun 2026 13:22:03 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EE64779A7;
	Tue,  9 Jun 2026 13:22:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0PgVHHoTKGpnDgAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 09 Jun 2026 13:22:02 +0000
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
Subject: [PATCH v3 1/2] KVM: x86: Fix array_index_nospec() protection in kvm_vcpu_ioctl_x86_set_mce()
Date: Tue,  9 Jun 2026 15:18:55 +0200
Message-ID: <20260609131856.2562222-3-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260609131856.2562222-2-clopez@suse.de>
References: <20260609131856.2562222-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 39B7A75ACA
X-Rspamd-Action: no action

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

