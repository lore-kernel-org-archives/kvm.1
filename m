Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67285263F44
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011337; cv=none; b=mmSEYfe9spfTurGcVzSFWI0vvy+NjQ8J+c28ls7/g6HEe2CztU1kx4HohB6nU6igRufczmU8oHGhmemZuyZ+ma2GCqpG3Kalx/NS/fAPhrPv48obXjyv/5p+NA0+qCiTocXaaDXk/VYmruZyAxRdgU3nQNBZoiy2873hDFhiJYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011337; c=relaxed/simple;
	bh=jfur8W2/jJmXQXmQYMc1WcSww6zoalcw7gOFGxnmO5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkJNt3Kjfr63OZxFRSJJd1MyTg+eoRaoPOs4Tf2PFP7HQljT2s1pmVnn150RKiGjTdbwNXhqRKu+zOxO3nq1Q/PM6PlcO6HLKHI6aRox/vY9xBbd//muy/SxTJRC64WtWtjtEBhXXCgNmMOsM5ed5doDbWm36Q+qcIUtAr1lJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4267D75ACB;
	Tue,  9 Jun 2026 13:22:04 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A66C779A7;
	Tue,  9 Jun 2026 13:22:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EGjlGnsTKGpnDgAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 09 Jun 2026 13:22:03 +0000
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
	Ying Huang <huang.ying.caritas@gmail.com>,
	Avi Kivity <avi@redhat.com>
Subject: [PATCH v3 2/2] KVM: x86: Fix MCE logging rules for KVM_X86_SET_MCE
Date: Tue,  9 Jun 2026 15:18:56 +0200
Message-ID: <20260609131856.2562222-4-clopez@suse.de>
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
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: 4267D75ACB
X-Rspamd-Action: no action

When userspace issues KVM_X86_SET_MCE, kvm_vcpu_ioctl_x86_set_mce()
decides whether to log an uncorrectable MCE by looking at the
corresponding IA32_MCi_CTL MSR. This is not the behavior specified in
the Intel SDM (17.3.2.1 IA32_MCi_CTL MSRs):

  Setting an EEj flag enables signaling #MC of the associated error and
  clearing it disables signaling of the error. Error logging happens
  regardless of the setting of these bits. The processor drops writes to
  bits that are not implemented.

Perform the logging before checking MCi_CTL, unless there is already
a valid UC error logged for the bank, in which case the SDM (17.3.2.2
"IA32_MCi_STATUS MSRS") specifies that error information should not
be overwritten.

To avoid even more complex control flow, hoist the logging logic into a
separate function, which then enables the removal of the non-UC branch
in kvm_vcpu_ioctl_x86_set_mce(), which only existed to perform logging.

Note that the SDM is ambiguous regarding the effects of IA32_MCG_CTL on
logging, so preserve the existing logic (i.e. do not log the error if
MCG_CTL is disabled).

Fixes: 890ca9aefa78 ("KVM: Add MCE support")
Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/x86/kvm/x86.c | 62 +++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 77a780177c4e..af3662aa3ce3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5462,6 +5462,28 @@ static int kvm_vcpu_x86_set_ucna(struct kvm_vcpu *vcpu, struct kvm_x86_mce *mce,
 	return 0;
 }
 
+/*
+ * Record @mce into @banks per the SDM logging rules:
+ *   - Per 17.3.2.1, logging happens regardless of IA32_MCi_CTL.
+ *   - Per 17.3.2.2.1 and 17.3.2.2, a UC error does not overwrite a
+ *     previous valid UC log in the same bank; only OVER is set.
+ *     Any other prior state (invalid, or valid non-UC) is replaced,
+ *     with OVER set if a prior valid log was overwritten.
+ */
+static void kvm_log_mce(u64 *banks, struct kvm_x86_mce *mce)
+{
+	bool overflow = banks[1] & MCI_STATUS_VAL;
+
+	if (!overflow || !(banks[1] & MCI_STATUS_UC)) {
+		banks[2] = mce->addr;
+		banks[3] = mce->misc;
+		banks[1] = mce->status;
+	}
+
+	if (overflow)
+		banks[1] |= MCI_STATUS_OVER;
+}
+
 static int kvm_vcpu_ioctl_x86_set_mce(struct kvm_vcpu *vcpu,
 				      struct kvm_x86_mce *mce)
 {
@@ -5485,34 +5507,28 @@ static int kvm_vcpu_ioctl_x86_set_mce(struct kvm_vcpu *vcpu,
 	if ((mce->status & MCI_STATUS_UC) && (mcg_cap & MCG_CTL_P) &&
 	    vcpu->arch.mcg_ctl != ~(u64)0)
 		return 0;
+
+	kvm_log_mce(banks, mce);
+
+	if (!(mce->status & MCI_STATUS_UC))
+		return 0;
+
 	/*
 	 * if IA32_MCi_CTL is not all 1s, the uncorrected error
 	 * reporting is disabled for the bank
 	 */
-	if ((mce->status & MCI_STATUS_UC) && banks[0] != ~(u64)0)
+	if (banks[0] != ~(u64)0)
 		return 0;
-	if (mce->status & MCI_STATUS_UC) {
-		if ((vcpu->arch.mcg_status & MCG_STATUS_MCIP) ||
-		    !kvm_is_cr4_bit_set(vcpu, X86_CR4_MCE)) {
-			kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
-			return 0;
-		}
-		if (banks[1] & MCI_STATUS_VAL)
-			mce->status |= MCI_STATUS_OVER;
-		banks[2] = mce->addr;
-		banks[3] = mce->misc;
-		vcpu->arch.mcg_status = mce->mcg_status;
-		banks[1] = mce->status;
-		kvm_queue_exception(vcpu, MC_VECTOR);
-	} else if (!(banks[1] & MCI_STATUS_VAL)
-		   || !(banks[1] & MCI_STATUS_UC)) {
-		if (banks[1] & MCI_STATUS_VAL)
-			mce->status |= MCI_STATUS_OVER;
-		banks[2] = mce->addr;
-		banks[3] = mce->misc;
-		banks[1] = mce->status;
-	} else
-		banks[1] |= MCI_STATUS_OVER;
+
+	if ((vcpu->arch.mcg_status & MCG_STATUS_MCIP) ||
+	    !kvm_is_cr4_bit_set(vcpu, X86_CR4_MCE)) {
+		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
+		return 0;
+	}
+
+	vcpu->arch.mcg_status = mce->mcg_status;
+	kvm_queue_exception(vcpu, MC_VECTOR);
+
 	return 0;
 }
 
-- 
2.51.0

