Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C793AD531;
	Wed, 16 Sep 2026 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569261; cv=none; b=mmbH7UmbMm920KB09kENujL/ZaoXzvexKKwwUYBqktCyRIyBSbUPV6HaUqy7dOBrWDKIP7AvaI3crQ7cQUyU67JVOow99RoRQ88/N35dzkk+OuAIfMT5VxUm+HzDaabQ6rAWL2+aT1TkJX09hCrFvmYW7SWryZU4xA7i9hAQd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569261; c=relaxed/simple;
	bh=P/6JmgkC/eGjiXCFKS++iNZcRu2fzyewG1DpZXQZAKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WzP+/LtA2YMgziJ/kZCETsnoPRXxMV8uUtRU40r3iRkdPY1fIolr8kgFJeG9faS2LFEpAhqJHanCmZn5M2ifkRKDZdHw1jV2S5gGUWKD9FABObodfTFSOO35iayhQYr4T0QzbICiFQJYPHhbhLWrALobwTMFZog0K67RnxgmUp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t8ThbfRo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uEBtw5dY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i4QQb4lb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EhzkEqkG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t8ThbfRo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uEBtw5dY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i4QQb4lb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EhzkEqkG"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EA211FE1D;
	Wed, 16 Sep 2026 14:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789569248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l1KoFo1jZUuR5c3PI4zxC7N8dNS1kx3KhNK1KaEqmjc=;
	b=t8ThbfRoKpWhYYJeLbXSvCIcMErlZd5iuxNNeU7btT2fyUNUazeu2tvPbpprlNcTqh/Jtf
	JazNOQy+Sm1PViaXsy0X+agPcFxcmYFqVnGA/UJWrRmPFAmlFcMvGeZaa3LonWpqGZw9tz
	5FeQz7Bvv60gm77s+6sX9oqOppmS7NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789569248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l1KoFo1jZUuR5c3PI4zxC7N8dNS1kx3KhNK1KaEqmjc=;
	b=uEBtw5dYpvlhtpp89hHaM2nrVkMg2b+TFeKgtJp8hHoSMBRpvqmgoNCDDBGEEKEUOp+3lQ
	Em0KGH6LTI4e5EDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789569244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l1KoFo1jZUuR5c3PI4zxC7N8dNS1kx3KhNK1KaEqmjc=;
	b=i4QQb4lb3qhulcgrHdEOUxaWQj9j115MwwXmigmm6T3wTy1ueEgzwXcSxnPc1eMBtc2nOa
	A7N6Nfuea4R+UIky3gVcnH6iTa7zn5kAESfipNI2zE/dXkDhNL3H2wzzlvkqU/7hsNPliY
	YRkZKqmqmiNjfW9R7sw8tYH3L6hQNHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789569244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l1KoFo1jZUuR5c3PI4zxC7N8dNS1kx3KhNK1KaEqmjc=;
	b=EhzkEqkGfPqNYbsvqsJYYGBoStb3Fcm6tprlogAaydQYq4UMgA2MH/4eTrBX+0Fy6CeXoD
	DUEEIlLsmHVcJnBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56D15136A5;
	Wed, 16 Sep 2026 14:34:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /VHeCduoqmrVZQAAD6G6ig
	(envelope-from <clopez@suse.de>); Wed, 16 Sep 2026 14:34:03 +0000
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
Subject: [PATCH v3] KVM: x86/mmu: Fix NX page unaccounting for TDP MMU pages
Date: Wed, 16 Sep 2026 16:33:11 +0200
Message-ID: <20260916143310.1909993-2-clopez@suse.de>
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
X-Spam-Score: -3.30
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]

unaccount_nx_huge_page() unconditionally passes KVM_SHADOW_MMU to
untrack_possible_nx_huge_page(), which is incorrect, particularly on
the path from kvm_recover_nx_huge_pages(), which handles pages from
both MMUs.

Fix this by passing down the MMU type from the callers. Note that
__kvm_mmu_prepare_zap_page() is only used for shadow MMU pages.

Fixes: 6777885605e1 ("KVM: x86/mmu: Track possible NX huge pages separately for TDP vs. Shadow MMU")
Signed-off-by: Carlos López <clopez@suse.de>
---
v3:
  * Pass down the MMU type down from callers (Sean).
v2:
  * Use a helper to retrieve the MMU type to avoid referencing KVM_TDP_MMU for
    32 bit builds (Sashiko).
 arch/x86/kvm/mmu/mmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 9788ff180374..f811b1ee0b2c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -864,11 +864,12 @@ void untrack_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp,
 	list_del_init(&sp->possible_nx_huge_page_link);
 }
 
-static void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+static void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp,
+				    enum kvm_mmu_type mmu_type)
 {
 	sp->nx_huge_page_disallowed = false;
 
-	untrack_possible_nx_huge_page(kvm, sp, KVM_SHADOW_MMU);
+	untrack_possible_nx_huge_page(kvm, sp, mmu_type);
 }
 
 static struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu,
@@ -2829,7 +2830,7 @@ static bool __kvm_mmu_prepare_zap_page(struct kvm *kvm,
 	}
 
 	if (sp->nx_huge_page_disallowed)
-		unaccount_nx_huge_page(kvm, sp);
+		unaccount_nx_huge_page(kvm, sp, KVM_SHADOW_MMU);
 
 	sp->role.invalid = 1;
 
@@ -8055,7 +8056,7 @@ static void kvm_recover_nx_huge_pages(struct kvm *kvm,
 		WARN_ON_ONCE(!sp->nx_huge_page_disallowed);
 		WARN_ON_ONCE(!sp->role.direct);
 
-		unaccount_nx_huge_page(kvm, sp);
+		unaccount_nx_huge_page(kvm, sp, mmu_type);
 
 		if (is_tdp_mmu)
 			spin_unlock(tdp_mmu_pages_lock);

base-commit: 70c944caf570fda2d79baa71435589a8db39f048
-- 
2.51.0

