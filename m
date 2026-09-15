Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED94D0A09;
	Tue, 15 Sep 2026 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504538; cv=none; b=ciJoHKQwgnfAdCKBjvJhlsDYMpFs4FMAiLNIY4XzoEvcRO3ErEKpdN75j86Lk9gcnV5OrW98A7S9kGnUzfFnzI9q+MftdZCStpJ19WpeWFLSq/HcM1kLK1jQlWxcjL0wHKvyjXcH8Xs3fk35EBRA2HfSfOwbEIy2EdwHWptDEec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504538; c=relaxed/simple;
	bh=bzGQhd4IF9lUwwy4ITEv2bTUw84ftLOuO4uh0h7XQ7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D3pyjcsd2lnTEj7b3gXSJ8gQZZEPzyWovOP7gUTJbw3wMxk0AZGbXclamhLQUXHB68/mGLQcymhfqCQg+hBaL8/nOEf0bN9PB9SauQinXUdlbOpva0EyKjXQj79pdvJYHWDoKH5BE1fc0zm4M0g6IClDlUOYxSVgO079K6n0K30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rvZWc1g0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fKeac2XD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C9Lw6+oT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WIl8ZjsJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rvZWc1g0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fKeac2XD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C9Lw6+oT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WIl8ZjsJ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CE1F1FFB7;
	Tue, 15 Sep 2026 20:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789504530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sc4RV53s//LUHgPB5/jPDXKngLl/CQzbD3CUJlOams8=;
	b=rvZWc1g0KYyTl3dASkxzO5GVtK2wCSgmxzXi9oG4vI8X6XUUcrNwg/d3n5DnzsOMoVXB+G
	Epi7VzuYxECbDCpPJqpnCCtMdWGWpgSbBStFY6aQwen7O8TAVVUU+6HxMfZgJLi7eE0tnk
	DWmbUrFKrTGJobncNk2hOMzQY+ewqEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789504530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sc4RV53s//LUHgPB5/jPDXKngLl/CQzbD3CUJlOams8=;
	b=fKeac2XDIgg+zHuCn+Qeq4zRvd5eA0EITwIobB4NxTgkfBQdofoBc7jgGLXQ8UotM/lomG
	65D1XzsnqQ9T/XBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789504526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sc4RV53s//LUHgPB5/jPDXKngLl/CQzbD3CUJlOams8=;
	b=C9Lw6+oTWgvb/mWvML22k8oYCI1vXyDwLC2+OkpwDiSogQhub7DI/aBvLU9G6WKSK0+OyV
	9XVbj+nINwONNwPDUZNo/UO2LRlUXHGEzzkZ02xDGM5o/kVsmGdVFhqii1BNSrTuuUihFH
	ms+fW+xl8k6HpB30wLUo4PQXy6X4ouc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789504526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sc4RV53s//LUHgPB5/jPDXKngLl/CQzbD3CUJlOams8=;
	b=WIl8ZjsJsq/DBClEY6a5aj5Ny2ujd9KJvCDYXxNPBCajQftVVYg7+Dc/gyfRRiiFg/Txt8
	LVSA78bgYRdJBDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B80513432;
	Tue, 15 Sep 2026 20:35:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E4z2Dg2sqWo3NQAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 15 Sep 2026 20:35:25 +0000
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
	Vipin Sharma <vipinsh@google.com>,
	James Houghton <jthoughton@google.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH] KVM: x86/mmu: Fix NX page unaccounting for TDP MMU pages
Date: Tue, 15 Sep 2026 22:35:11 +0200
Message-ID: <20260915203511.1808028-1-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO

unaccount_nx_huge_page() unconditionally passes KVM_SHADOW_MMU to
untrack_possible_nx_huge_page(), which is incorrect, particularly on
the path from kvm_recover_nx_huge_pages(), which handles pages from
both MMUs. Fix this by retrieving the MMU type via is_tdp_mmu_page()
and passing it down.

Fixes: 6777885605e1 ("KVM: x86/mmu: Track possible NX huge pages separately for TDP vs. Shadow MMU")
Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/x86/kvm/mmu/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 9788ff180374..61996669b6f6 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -866,9 +866,11 @@ void untrack_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp,
 
 static void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
+	enum kvm_mmu_type mmu_type = is_tdp_mmu_page(sp) ? KVM_TDP_MMU : KVM_SHADOW_MMU;
+
 	sp->nx_huge_page_disallowed = false;
 
-	untrack_possible_nx_huge_page(kvm, sp, KVM_SHADOW_MMU);
+	untrack_possible_nx_huge_page(kvm, sp, mmu_type);
 }
 
 static struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu,

base-commit: 70c944caf570fda2d79baa71435589a8db39f048
-- 
2.51.0

