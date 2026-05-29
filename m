Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586072BE05F
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063390; cv=none; b=V0bExF9ctoGB5K4zDo4hyR+ABl5kW/B5Fxmxx4CvR9s4s8ggv4azt9wqqFaEThDgiPXrgslI2MWbWkbYhg1gfsxPt+8rYrq6Mr20QCkdYVJsE0mlFPHKeL/0WmKu/D5p76YvDjRlibyBw36bgSg6zZbUN8gz4Axek72Amz1XCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063390; c=relaxed/simple;
	bh=gGn5PjjFPgCZcJzrpPsaEvs1RZTbgD70Ap223771QWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N0MqKxBzXmd8Mk4Yi/dX6d4Vna9dgkx+XIMYYM6gpbljO3RBla6Dtf+gcZ0M4CfY4oIICnqBPCLwth2EpxYH+wrdEd6+oSPeJ2AOQQ46pqfIyFEhK7fBBtyFlgxtRuzkJDhwn+dHCfEPryWwzOE9trcNdbtDc1HYr5jMEYuU5Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ckJ7ANPD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=21vSk4zR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BU8nVRwM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kob/4WnR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ckJ7ANPD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="21vSk4zR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BU8nVRwM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kob/4WnR"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 38A7166E02;
	Fri, 29 May 2026 14:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780063383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vFmASEw7X5QxlDyGMNGJeKWnDPoZnIA+xWfbfA6yacI=;
	b=ckJ7ANPD0wWospwJpW5wBbZ0BxXB6AGjmBUeNZG7N50N6+FGsgWqD7OZJfir8DQ4ceZNQX
	kN156bib8CCshesgmtTJ6JDk+WUUXJbPG3tNN1yN2NTFJ+vZtpJcz7BuMWTP0RcwPFujAx
	ulHkUrt7KspKHnctZTyyH6bjEGCxgXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780063383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vFmASEw7X5QxlDyGMNGJeKWnDPoZnIA+xWfbfA6yacI=;
	b=21vSk4zRA+RjGfX0KIKWz6yApTXdd7GgUPbvW3z0DyZQaJeTxsGzkcP0ydN7cNeCo5h7xA
	xroRE0u8Ps2YhhCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780063379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vFmASEw7X5QxlDyGMNGJeKWnDPoZnIA+xWfbfA6yacI=;
	b=BU8nVRwMhr9yQ/uMFdJ71aD87SUfaqgkUlIcPNefYFugpf1OvsARtMu6whUC3VG9T7rGZX
	8yJdOPqz80njXu+mY1wMcaSOpoCCi9u6kRTWMxHdps/O+nzbHP6eIPSfKm5qKSN4+SgrHM
	W2/hLpEzXCh6Dcqg78txFfYJD3I73H8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780063379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vFmASEw7X5QxlDyGMNGJeKWnDPoZnIA+xWfbfA6yacI=;
	b=kob/4WnRQR9bZQc83a5ChMZPfvh7a9iJZ9Vh4SoZZPPDAFl1nHG3tCH8xXC5Raugs+HBIo
	DCOA2X4OaFe/5HDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D945779A8;
	Fri, 29 May 2026 14:02:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qr8fGJKcGWohZwAAD6G6ig
	(envelope-from <clopez@suse.de>); Fri, 29 May 2026 14:02:58 +0000
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
	"He, Qing" <qing.he@intel.com>,
	"Yaozu (Eddie) Dong" <eddie.dong@intel.com>,
	Avi Kivity <avi@qumranet.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH v2] KVM: x86: Take PIC lock on KVM_GET_IRQCHIP path
Date: Fri, 29 May 2026 16:00:14 +0200
Message-ID: <20260529140013.14925-2-clopez@suse.de>
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
X-Spam-Score: -3.29
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-2.99)[99.95%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

When userspace issues the KVM_SET_IRQCHIP ioctl to set the state of
the PIC, kvm_vm_ioctl_set_irqchip() grabs @kvm->arch.vpic->lock before
updating the state. However, the KVM_GET_IRQCHIP ioctl to retrieve the
same PIC state does not grab such lock, potentially causing torn reads
for userspace.

Fix this by grabbing the lock on the read path.

This issue goes all the way back. The bug was introduced with the
addition of PIC ioctl code itself in 6ceb9d791eee ("KVM: Add get/
set irqchip ioctls for in-kernel PIC live migration support"). Later,
894a9c5543ab ("KVM: x86: missing locking in PIT/IRQCHIP/SET_BSP_CPU
ioctl paths") added the locking for kvm_vm_ioctl_set_irqchip(), but
missed kvm_vm_ioctl_get_irqchip().

Fixes: 6ceb9d791eee ("KVM: Add get/set irqchip ioctls for in-kernel PIC live migration support")
Fixes: 894a9c5543ab ("KVM: x86: missing locking in PIT/IRQCHIP/SET_BSP_CPU ioctl paths")
Reported-by: Claude Code:claude-opus-4.6
Signed-off-by: Carlos López <clopez@suse.de>
---
v2:
  - Remove stable tag
  - Use regular locking instead of guards

 arch/x86/kvm/irq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 9519fec09ee6..8c62c6d4d5c1 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -585,12 +585,16 @@ int kvm_vm_ioctl_get_irqchip(struct kvm *kvm, struct kvm_irqchip *chip)
 	r = 0;
 	switch (chip->chip_id) {
 	case KVM_IRQCHIP_PIC_MASTER:
+		spin_lock(&pic->lock);
 		memcpy(&chip->chip.pic, &pic->pics[0],
 			sizeof(struct kvm_pic_state));
+		spin_unlock(&pic->lock);
 		break;
 	case KVM_IRQCHIP_PIC_SLAVE:
+		spin_lock(&pic->lock);
 		memcpy(&chip->chip.pic, &pic->pics[1],
 			sizeof(struct kvm_pic_state));
+		spin_unlock(&pic->lock);
 		break;
 	case KVM_IRQCHIP_IOAPIC:
 		kvm_get_ioapic(kvm, &chip->chip.ioapic);

base-commit: d1568b1332b6b3b36b222c2868fc102727c12a34
-- 
2.51.0

