Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246E64BE45B
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643255; cv=none; b=Xv68bhr40xwJdgSuxo8iwmJt3KPVBkj82l5OMQYpdr/UZH7Nlkhi40kY4x04G4KTNG8PdAsXn3Q94KhauacHYmzuFtlPeql08xivl48gzKdptyWWjSQLyZlsQInS0+H78Z1X5po4P5Xdwst+GA5htfy8h7n5VtWURaJhy8kYX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643255; c=relaxed/simple;
	bh=LPfTiP5eZhYBDsgX09Kp9oTMToyQZEwRpy6GC2d6MUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OZQYBRXrzGdrZR41PPM+TLoAUSM4dZbYzgRkr09urimpqFA6MhV+1FQloGMCr4mJsq0D8K7bJJrhcAQCKBL6cIuHCoXqVi46vWXiaI9lMoELWWOlysiiGN1ossVQtBnzpxO/9bmp9wgPJVMgGgokhKKD8SDuH9FGLi3cjvTa6aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bXiOGAV2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lvBZUv1A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bXiOGAV2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lvBZUv1A"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF44821D92;
	Thu, 17 Sep 2026 11:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789643240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ts/BDG58KMU8+guDo80ZtRRRgwr6pxvwaMgGTNXR5H0=;
	b=bXiOGAV2NKiBdxUNXL8oo683km+WC15JZFCg7bTxSTqP5LIQGUVUizMb32yNigmpm/oewI
	jBwrDGS61ycKzHNPiOdg11VHfIAZPr4htKe7V/1FBnSI5qB3gjoYcaEDXUADupR86yOkyY
	hHtuYmNBgHaODp9c5p9zmpiOYbWxJvw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lvBZUv1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789643236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ts/BDG58KMU8+guDo80ZtRRRgwr6pxvwaMgGTNXR5H0=;
	b=lvBZUv1A23rVmRTtbXieSZzKyeT0hLvuXKvYSpxMoobbW1PPUp/SodYrJhIkMMWcZ1f5O3
	ix3ItBlJhlPvMav8MEI8N/FZE+rNEPiTnRBLi5Md8JOKDRrfnQ7YiCBEyZCP2XUSjl5QcL
	0bUZ8eWPKRtMALFGgM+Ru0Dy9zh/sPk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29CD3134B3;
	Thu, 17 Sep 2026 11:07:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PUDkAOTJq2rmGQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Thu, 17 Sep 2026 11:07:16 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: dave.hansen@linux.intel.com
Cc: rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	x86@kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v2] x86/tdx: Harden exports
Date: Thu, 17 Sep 2026 14:07:14 +0300
Message-ID: <20260917110714.1587301-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.55.0
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
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AF44821D92
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:email,suse.com:mid];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:email,suse.com:mid];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51

tdx_* function aren't supposed to be used by the kernel at large, rather
they are mostly used by KVM and a very small number of them are exposed
via the tdx-guest/tdx-host drivers. Reflect this fact in their
EXPORT_SYMBOL* declarations.

Reported-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---

V2:
 * Drop the change to tdx_kvm_hypercall

 arch/x86/coco/tdx/tdx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index f904a636d449..a38e44401840 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -139,7 +139,7 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
+EXPORT_SYMBOL_FOR_MODULES(tdx_mcall_get_report0, "tdx-guest");
 
 /**
  * tdx_mcall_extend_rtmr() - Wrapper to extend RTMR registers using
@@ -175,7 +175,7 @@ int tdx_mcall_extend_rtmr(u8 index, u8 *data)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(tdx_mcall_extend_rtmr);
+EXPORT_SYMBOL_FOR_MODULES(tdx_mcall_extend_rtmr, "tdx-guest");
 
 /**
  * tdx_hcall_get_quote() - Wrapper to request TD Quote using GetQuote
@@ -196,7 +196,7 @@ u64 tdx_hcall_get_quote(u8 *buf, size_t size)
 	/* Since buf is a shared memory, set the shared (decrypted) bits */
 	return _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(buf)), size, 0, 0);
 }
-EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
+EXPORT_SYMBOL_FOR_MODULES(tdx_hcall_get_quote, "tdx-guest");
 
 static void __noreturn tdx_panic(const char *msg)
 {
--
2.55.0

