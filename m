Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5323B71C5;
	Wed, 26 Aug 2026 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787738616; cv=none; b=RM2iWRQlpD8fA4dIAtXqnl3BG3m8S4LUNNg/eR6oS/CHlnIQAgWB8iXNZZ/WLBtlGjsos0iQsFFr+FaWnAnt85y3qWmkDBxTB+JxAWi9R7gbOheevUDkhIT5Hs1HY9LkBiTcH1NWgDYZqufUurPkja65Wu646HjkcmDNEXvqaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787738616; c=relaxed/simple;
	bh=+GwMphw2F80K7bthWopcNeaSAr/FcE1lDh1YVBMhgQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mc7HuKIQir/987sZyThmFHvC3dhn+0HhKo3HeYtySjGeBy9dpr8sfaSY2PTjRzr83RVsnm4SodAukFISYTuRaTxsg9KtqQhDqUSpFgIWSNKaJ1v+bTMiwMWuIAWEODr6IO5LGQUHTfaleSO54dWhAiXdGuNZeYFrlLEeY/so8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CLVX/pZb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QjtIwvBz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CLVX/pZb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QjtIwvBz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 158D987371;
	Wed, 26 Aug 2026 10:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787738609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iwfdj/HssFr5xJSF8Pmh46mdif+Txeget3/ePNIgav0=;
	b=CLVX/pZb5nirnL6pvrMSmsdKA8zPnhtV07Co/1zf5WYiIkms2PUVPtrW0imywRycZdmP8K
	FHaObZdOlSactVQe0EEGzweKoH1GMoWiFjdtF6f6X/VZmzj1KRC7EYHQXu3Auu7ffyB0so
	y1EhNYEy9McacP/ZXakVjBZNP3p46RI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QjtIwvBz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787738605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iwfdj/HssFr5xJSF8Pmh46mdif+Txeget3/ePNIgav0=;
	b=QjtIwvBziCIhjmqMVzYSTwSM7vJUUq3inT9qEzuhBNXmBHowC3XAZotIhh3tR2PvF4bojf
	a/Xldrq8gOr/8nKpkA8rejVT+Nhc0NjfEyaWyudx5zQuoFGzP5yzhJttsjint3rnHwzmHQ
	5oo3IvMjY1Rj6Xcf5Bdh/6Ft1r3g6B4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E41513354;
	Wed, 26 Aug 2026 10:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ghr+Iuy5jmreEwAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Wed, 26 Aug 2026 10:03:24 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: seanjc@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] KVM: TDX: Remove always true ifdef
Date: Wed, 26 Aug 2026 13:03:21 +0300
Message-Id: <20260826100321.1309685-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.com:dkim];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 158D987371
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

CONFIG_KVM_INTEL_TDX depends on KVM_TDX_HOST, which in turn depends on
CONFIG_X86_64. So it's guaranteed that any code under ifdef
CONFIG_KVM_INTEL_TDX is also running under CONFIG_X86_64 being true,
remove pointless ifdef guard.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kvm/vmx/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index f204a0fc0a57..e9cca303c855 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -799,7 +799,6 @@ static void vt_write_tsc_multiplier(struct kvm_vcpu *vcpu)
 	vmx_write_tsc_multiplier(vcpu);
 }
 
-#ifdef CONFIG_X86_64
 static int vt_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
 			      bool *expired)
 {
@@ -818,7 +817,6 @@ static void vt_cancel_hv_timer(struct kvm_vcpu *vcpu)
 
 	vmx_cancel_hv_timer(vcpu);
 }
-#endif
 
 static void vt_setup_mce(struct kvm_vcpu *vcpu)
 {
-- 
2.34.1

