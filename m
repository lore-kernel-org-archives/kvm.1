Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478B42820C6
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968174; cv=none; b=O/asOB4Y0w5AEImwsDB236GKXGlxatuTHrSxaVtwhXolhww+CZKHkSXRfKFFm2B/6KpHER72SEzPLDK856PeCGLYplDl4Tyw/YtdbSR7dKhThzfy8j9WtBPqLhH/vddR98gZbO3lVS/Cm2OkIhT5qxDjStgg8uD2JlLO6yQkhRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968174; c=relaxed/simple;
	bh=IBUMRJlxMwi5mm23kLA1njVvmiE37jM/W1cQ6l34pZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9+iOwL0gkS/UStPfT4YMxyWE2X0GpY4aITVsXtuIFfb/W4p8IUEPSr3gf8jtD4yVVaWqEKDayhXCTSWZFVB/ynhD/z8xiZcCEDfkvGvHLQpUEYQ0aRDxgQt+V62J7g5iQivdXq/756v+FeRXpcoaaoZ62v3baz42qv9WDOJw/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RRMlyVQo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RRMlyVQo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RRMlyVQo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RRMlyVQo"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B49456ADAA;
	Thu, 28 May 2026 11:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779968171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8g+IoMYGtseSXdYEdYEwB4gxLfim4Xtqq+TjJBHgovU=;
	b=RRMlyVQorimkYCcH/WJQBM0LitvatGbeARFGM9Mpb65L2JYNqKFPMnD2JJW9WCuzBlf9Vt
	uBJ9zpwObBGIw5B6motK1qtn2pup406Nl/8wgSgKerCF4Fm0JfVqZACGm8OCXoZRbaVgrF
	pBVcYz/NlBx6NyoNUnVvgr+hUEgOq3Y=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779968171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8g+IoMYGtseSXdYEdYEwB4gxLfim4Xtqq+TjJBHgovU=;
	b=RRMlyVQorimkYCcH/WJQBM0LitvatGbeARFGM9Mpb65L2JYNqKFPMnD2JJW9WCuzBlf9Vt
	uBJ9zpwObBGIw5B6motK1qtn2pup406Nl/8wgSgKerCF4Fm0JfVqZACGm8OCXoZRbaVgrF
	pBVcYz/NlBx6NyoNUnVvgr+hUEgOq3Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57D5F5AD79;
	Thu, 28 May 2026 11:36:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fLRbFKsoGGpbSQAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 28 May 2026 11:36:11 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>
Subject: [PATCH v2 0/6] KVM/x86: Drop "1" as MSR emulation return value
Date: Thu, 28 May 2026 13:35:59 +0200
Message-ID: <20260528113605.267111-1-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]

Get rid of the literal "1" used as general error return value in KVM
MSR emulation. It can easily be replaced by negative errno values
instead.

This is meant to avoid confusion with the literal "1" used as return
value for "return to guest".

Changes in V2:
- series carved out from initial "KVM: Avoid literal numbers as return
  values" series
- don't use new KVM_MSR_RET_* defines, but 0 and -errno

Juergen Gross (6):
  KVM/x86: Change comment before KVM_MSR_RET_* defines
  KVM/x86: Return -errno instead of "1" for APIC related MSR emulation
  KVM/x86: Return -errno instead of "1" for Hyper-V related MSR
    emulation
  KVM/x86: Return -errno instead of "1" for VMX related MSR emulation
  KVM/x86: Return -errno instead of "1" for SVM related MSR emulation
  KVM/x86: Return -errno instead of "1" for common MSR emulation

 arch/x86/kvm/hyperv.c        |  72 ++++++++++++-------------
 arch/x86/kvm/lapic.c         |  39 +++++++-------
 arch/x86/kvm/mtrr.c          |   6 +--
 arch/x86/kvm/pmu.c           |   8 +--
 arch/x86/kvm/svm/pmu.c       |   4 +-
 arch/x86/kvm/svm/svm.c       |  36 ++++++-------
 arch/x86/kvm/vmx/nested.c    |   2 +-
 arch/x86/kvm/vmx/pmu_intel.c |  16 +++---
 arch/x86/kvm/vmx/tdx.c       |  10 ++--
 arch/x86/kvm/vmx/vmx.c       |  96 ++++++++++++++++-----------------
 arch/x86/kvm/x86.c           | 102 +++++++++++++++++------------------
 arch/x86/kvm/x86.h           |   4 +-
 arch/x86/kvm/xen.c           |  10 ++--
 13 files changed, 202 insertions(+), 203 deletions(-)

-- 
2.54.0

