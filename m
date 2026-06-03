Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E346AECC
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487139; cv=none; b=XJ6KdeGP1Ecr+DxHs095m33sznxoiqw0i/HwIq3khtvTq2j+iUC1NZTBlErRVfW+e/Fozbtml/KAcFFd0dxmNChDRYO91rB2yZDw0qi7Hn1gQGOYwa0DHC/Cob72xKkm2CSG9cnfjdeMHUzwid+6P2OlBd3LSW/usU8i4/rVios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487139; c=relaxed/simple;
	bh=nUBTUt6u+VUEoJiU2XSu4LyljZz8GesU5Adl+TGl/wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JmO5qlMjKIk1Slrf/GBWsDaOs5kEWShs82nWyiIHHAHkkn34rCu7gmYWaa4y/EheT8ZKTLO8ivE3wA6/KXXCHO0Yre4Lpfz16bDr/h3D7Qnu7l3tYJ1wjRaaLJmL8UdN78eYDh4ORyPMAjHtqB4qL8feJRKnpzCY9nz1fRs3Od0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W+hdX8NL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GocJuQlG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W+hdX8NL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GocJuQlG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W+hdX8NL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GocJuQlG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W+hdX8NL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GocJuQlG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 244616A800;
	Wed,  3 Jun 2026 11:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780487135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XT56QKdjWikMuY7gT9KrU+V0bhCS1pLWUGmQUob5E2A=;
	b=W+hdX8NLJfF1AvDGi6b+rjG+8tOF6R/UPBEfoRpOfPyr9BS+8Ct9B7/Rhp4NtuoNFYq8K0
	eUfmdTpVxbAAZLwBB+mhhuQwXw2OXgj3G9fzNOr1RobkvWmcUb533o/qcDXNpy5ZcKfopQ
	/0Akp5YJvE8oEbC1ZoYesOZMFM83+DU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780487135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XT56QKdjWikMuY7gT9KrU+V0bhCS1pLWUGmQUob5E2A=;
	b=GocJuQlGJ1HeSQfSH6PdqAotMxbCiFnZYU+dDVPw3OR7b5pZvrR/o2vxBM7Ug+vpp9sC9g
	xPU8gTY/1pKBmlBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=W+hdX8NL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GocJuQlG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780487135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XT56QKdjWikMuY7gT9KrU+V0bhCS1pLWUGmQUob5E2A=;
	b=W+hdX8NLJfF1AvDGi6b+rjG+8tOF6R/UPBEfoRpOfPyr9BS+8Ct9B7/Rhp4NtuoNFYq8K0
	eUfmdTpVxbAAZLwBB+mhhuQwXw2OXgj3G9fzNOr1RobkvWmcUb533o/qcDXNpy5ZcKfopQ
	/0Akp5YJvE8oEbC1ZoYesOZMFM83+DU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780487135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XT56QKdjWikMuY7gT9KrU+V0bhCS1pLWUGmQUob5E2A=;
	b=GocJuQlGJ1HeSQfSH6PdqAotMxbCiFnZYU+dDVPw3OR7b5pZvrR/o2vxBM7Ug+vpp9sC9g
	xPU8gTY/1pKBmlBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78C50779A7;
	Wed,  3 Jun 2026 11:45:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CdjLGt4TIGrVXQAAD6G6ig
	(envelope-from <clopez@suse.de>); Wed, 03 Jun 2026 11:45:34 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: [PATCH] Documentation: KVM: Synchronize x86 VM types
Date: Wed,  3 Jun 2026 13:45:04 +0200
Message-ID: <20260603114504.814647-2-clopez@suse.de>
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
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 244616A800
X-Spam-Score: -3.51

KVM has reflected KVM_X86_SNP_VM to userspace since 1dfe571c12cf
("KVM: SEV: Add initial SEV-SNP support"), and KVM_X86_TDX_VM since
161d34609f9b ("KVM: TDX: Make TDX VM type supported"). Update the
documentation to reflect this fact.

Fixes: 1dfe571c12cf ("KVM: SEV: Add initial SEV-SNP support")
Fixes: 161d34609f9b ("KVM: TDX: Make TDX VM type supported")
Signed-off-by: Carlos López <clopez@suse.de>
---
 Documentation/virt/kvm/api.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 52bbbb553ce1..3ec574a41f60 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -9363,6 +9363,8 @@ means the VM type with value @n is supported.  Possible values of @n are::
   #define KVM_X86_SW_PROTECTED_VM	1
   #define KVM_X86_SEV_VM	2
   #define KVM_X86_SEV_ES_VM	3
+  #define KVM_X86_SNP_VM		4
+  #define KVM_X86_TDX_VM		5
 
 Note, KVM_X86_SW_PROTECTED_VM is currently only for development and testing.
 Do not use KVM_X86_SW_PROTECTED_VM for "real" VMs, and especially not in
-- 
2.51.0

