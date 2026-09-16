Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470F74BC00F;
	Wed, 16 Sep 2026 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789553265; cv=none; b=dwtt4DdczjgFYuAuChK/JzzdFWAI5lfIx68D9OPblLlomfdvQwJW+8sfrTtwX7ujb14uMCG1VADpyUnbsLaxkqetKTl+JV4y2dw27z1QRsPxnTZ0I+PalWUlbHgtuG89YrTKTmp+x+2fkTTQ3HLANP4LEMtjLpu+h1ywPGEDwAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789553265; c=relaxed/simple;
	bh=FuldWv/7N+8QTueqCb5EUcuPoAbFefukanTodOzdE/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZARhsatJRKZEkQ3Zs5UOupjgyd15t4lY3Hyc/YLbTViHkQeTZsx4uDxnfyTH7xGB9MWJJZOt1uce/Um2pSIfDWxHc19tVYgOryW2y8o0acvsNRflnEIMRSx9ghZL9bELoJMfHi55N1yiBXs5g1WSZ8HeRiSvE7Gp2AY0rzWt+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EJYz02WD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Is3tv+Ex; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cLJCarYc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5Ln/VCJV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EJYz02WD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Is3tv+Ex";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cLJCarYc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5Ln/VCJV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C9C921FF63;
	Wed, 16 Sep 2026 10:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789553241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sOJgkvCcqt/iNcwffg6+XK/fKIxtEKqGgfqg9Ei64UI=;
	b=EJYz02WDj6fGxySeAOPr8L6TJydmiQauZW/w9p3GKlLtwlp/2tU8y5hWNbj6cIJ8yktfu8
	/FxKcUQR0zDjLfAh2Cp1OLCVEGcDeMMd9lQomEtMnLnl5R2/2813bAoBHZxc3uMiJFtA5g
	OTGqlAkjz/vt3rupNq5t/Haa+r6DZS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789553241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sOJgkvCcqt/iNcwffg6+XK/fKIxtEKqGgfqg9Ei64UI=;
	b=Is3tv+Ex8G5jWOg2ptfPAPy703xuddC/jB9GpVFoaGcCbn38H2hRl3GSKxV4XYvc3rV7Qw
	ajLMMldrQgKge4CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789553237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sOJgkvCcqt/iNcwffg6+XK/fKIxtEKqGgfqg9Ei64UI=;
	b=cLJCarYcZAlfQo/Vp3pGoJ8DfGAKErO8f5zAnJZt2CfMcUFIdSFRlHaUZaQRyayeR4rb58
	g5nzjNhQpcGrSk7xxdibhF1RW0QELuhGC+WOABCrVnoiZ5nWjzBzq6fd8bMYpYKiawElwO
	TZ9LowTSO88nPts4t3WuTSBRyDiOnhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789553237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sOJgkvCcqt/iNcwffg6+XK/fKIxtEKqGgfqg9Ei64UI=;
	b=5Ln/VCJVJcWj6i7mz5aike0VniVehDStydnC4fTFMpRI9yYB9ANCh6BOBuG/Q6hNjr/ZD9
	cY/oGyIk4U03hcBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D805B136A5;
	Wed, 16 Sep 2026 10:07:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uAhVJlRqqmrtQAAAD6G6ig
	(envelope-from <clopez@suse.de>); Wed, 16 Sep 2026 10:07:16 +0000
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
Subject: [PATCH v2] KVM: x86/mmu: Fix NX page unaccounting for TDP MMU pages
Date: Wed, 16 Sep 2026 12:04:53 +0200
Message-ID: <20260916100452.1837412-2-clopez@suse.de>
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

unaccount_nx_huge_page() unconditionally passes KVM_SHADOW_MMU to
untrack_possible_nx_huge_page(), which is incorrect, particularly on
the path from kvm_recover_nx_huge_pages(), which handles pages from
both MMUs.

Fix this by adding a helper to retrieve the MMU type of a page and use
it to pass the correct variant down.

Fixes: 6777885605e1 ("KVM: x86/mmu: Track possible NX huge pages separately for TDP vs. Shadow MMU")
Signed-off-by: Carlos López <clopez@suse.de>
---
v2:
  * Use a helper to retrieve the MMU type to avoid referencing KVM_TDP_MMU for
    32 bit builds (Sashiko).
 arch/x86/kvm/mmu/mmu.c     |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 9788ff180374..fa3e9ff7bec1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -868,7 +868,7 @@ static void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	sp->nx_huge_page_disallowed = false;
 
-	untrack_possible_nx_huge_page(kvm, sp, KVM_SHADOW_MMU);
+	untrack_possible_nx_huge_page(kvm, sp, page_mmu_type(sp));
 }
 
 static struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index bd62977c9199..17e506ea3298 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -115,8 +115,19 @@ u64 *kvm_tdp_mmu_fast_pf_get_last_sptep(struct kvm_vcpu *vcpu, gfn_t gfn,
 
 #ifdef CONFIG_X86_64
 static inline bool is_tdp_mmu_page(struct kvm_mmu_page *sp) { return sp->tdp_mmu_page; }
+
+static inline enum kvm_mmu_type page_mmu_type(struct kvm_mmu_page *sp) {
+	return is_tdp_mmu_page(sp) ? KVM_TDP_MMU : KVM_SHADOW_MMU;
+}
+
 #else
+
 static inline bool is_tdp_mmu_page(struct kvm_mmu_page *sp) { return false; }
+
+static inline enum kvm_mmu_type page_mmu_type(struct kvm_mmu_page *sp) {
+	return KVM_SHADOW_MMU;
+}
+
 #endif
 
 #endif /* __KVM_X86_MMU_TDP_MMU_H */

base-commit: 70c944caf570fda2d79baa71435589a8db39f048
-- 
2.51.0

