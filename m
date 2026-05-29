Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5E401485
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073507; cv=none; b=qxtjBbverEI4iwUl1WYf4OGSwv8uQ1hgKrg/29Hvg/pVn+l6K7t7SiB3MQe4mfkH04EJJFb/W8eFT2s+QfmZEzt58+GPCQC9ZV3oPZq88RYftQTSGov+vO7yuNS2/0P8HguwOD4NLYp1xx6xarsJr6m/sdjnsezV7Mjqc9qLlGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073507; c=relaxed/simple;
	bh=awAqPvTjCGvtOfeH1l05uKfVpQ07Yx7AEqRp/zyuH+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l/Sbx4HtpMv6HSPz0fz5vIKJxOit7g27fIyECh1Hjlh148LpHEGzLsVw7wJGpruMseS9sRtLOrJGzd/cv+lJG+9CK/0GeTeKJzlgg4nwwYpwruEwhl0mGmzXWrQ++i4JbeK1Q8kVUbetknVCgQm1HFEQOdNbID52z0meQTZd8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gq/PnM/u; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gq/PnM/u"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8514f8ed5dso6222889a12.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073500; x=1780678300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=L2n+V0FsqyljLxYaD1QETdWONVMaFI3jjVM3JkMpLz4=;
        b=Gq/PnM/uii80Y9krtJYYAvxTK/6GFJJdINFVpUv/gd8iUACCznnrZHcPB6Qd2gMN8R
         oKNCmSSKchadZIWIkrLY1sN3bWymkvVZhOEdGhtlnTIP0+DNAbs4odlHCYTk7tWYjgqu
         R6EBYqxXM3PRgWdapZwF3L0/HGpzNK9HQpmB4DkZ5aVIhBepTQAlZ9DUjgX+EZGDUgAG
         gu00JxTNKw68uTM96YldWcatkd25UcW36ZvlyrZz/GrK8XNaTTXPaIRfcLzRsTlgc60z
         slc5Qa3m64IzXLRZOwsfkTOe941jndEgWPPhKNnwMtlYddxTn4QskbLooRSkmpL2mPk0
         p4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073500; x=1780678300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2n+V0FsqyljLxYaD1QETdWONVMaFI3jjVM3JkMpLz4=;
        b=YXc1a2n8WXt6jNyCLgGcX09kKvBBHt8Ex/jia7Rj62LMTr2/95DoNWq6OI+ypeXbVA
         dFTWM8ig1vEEJhERNDRQQAmD7umO/7W/2J7SmaQe7ZyBPgu2SXK92WW7/vD77T4Em05i
         m2OiJ+NXdsRTaeUkoJAAv5TMChdhJmjpBOV/MpZ8133303FVkpK1PA0pBHnJAcb6ly2S
         O4PNhlavfiEXkHvTFMnNMT6sOVT/9VSghgBSDPZm0/hZsSdvsV8bU8xGWho4NdYRBjw2
         VZ67DdcA+ZFlyj/pvhYeV31vt8gup59mHOjAVNetN2+/Z5krkmYAdnfffsqe4sQ3bvsU
         hN9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9i1Rdj5H0dtYLThwel4RLRrz6vcan+/2tg2bKEPvnQu4nTTwwUcqX/FYiki1ox6/Zzk/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY6wHXH3/NxciBF+HtnAfX4x6M2ATlbNQIlSvNHrZmhiVfnuzm
	gvUFUBvKqopo3TinWzulHE9dgag68WVNu4uS8MxH+zyNsCrRtYcDkJS68ZtUTKZ7t/gpVFxMPtP
	KeY1Qxw==
X-Received: from pfki6.prod.google.com ([2002:a05:6a00:46:b0:82f:790c:3922])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:198f:b0:837:80a:5ab4
 with SMTP id d2e1a72fcca58-8422571af4fmr275744b3a.44.1780073500104; Fri, 29
 May 2026 09:51:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:51:09 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-16-seanjc@google.com>
Subject: [PATCH v2 15/20] KVM: x86/xen: Convert kvm_xen_set_evtchn_fast() to
 gpc's CLASS() APIs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>
Cc: Waiman Long <longman@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	Carsten Stollmaier <stollmc@amazon.com>
Content-Type: text/plain; charset="UTF-8"

Convert the event channel fastpath to the "map local" CLASS() APIs, using
the "try" variants as the faspath can't block.

Note!  The vcpu_info mapping is read/write, even though there is no
existing call to mark the page dirty.  Like Xen's shared info page, the
vCPU info page is assumed to be dirty at all times, and so isn't marked
dirty after every write.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 8f822acb11a4..47750316f132 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1774,29 +1774,28 @@ static void __kvm_xen_set_evtchn_fast(struct kvm_vcpu *vcpu, int port_word_bit)
 	bool kick_vcpu = false;
 
 	/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
-	if (!read_trylock(&gpc->lock)) {
-		/*
-		 * Could not access the vcpu_info. Set the bit in-kernel and
-		 * prod the vCPU to deliver it for itself.
-		 */
+	CLASS(gpc_try_map_local, vcpu_info_map)(gpc, sizeof(struct vcpu_info));
+
+	/*
+	 * If the vcpu_info is inaccessible, set the bit in-kernel and prod the
+	 * vCPU to deliver it for itself.
+	 */
+	if (IS_ERR(vcpu_info_map)) {
 		if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
 			kick_vcpu = true;
 		goto out_kick;
 	}
-	if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
-		if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
-			kick_vcpu = true;
-		goto out_unlock;
-	}
 
 	if (IS_ENABLED(CONFIG_64BIT) && vcpu->kvm->arch.xen.long_mode) {
-		struct vcpu_info *vcpu_info = gpc->khva;
+		struct vcpu_info *vcpu_info = *vcpu_info_map;
+
 		if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel)) {
 			WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
 			kick_vcpu = true;
 		}
 	} else {
-		struct compat_vcpu_info *vcpu_info = gpc->khva;
+		struct compat_vcpu_info *vcpu_info = *vcpu_info_map;
+
 		if (!test_and_set_bit(port_word_bit,
 					(unsigned long *)&vcpu_info->evtchn_pending_sel)) {
 			WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
@@ -1810,8 +1809,6 @@ static void __kvm_xen_set_evtchn_fast(struct kvm_vcpu *vcpu, int port_word_bit)
 		kick_vcpu = false;
 	}
 
-out_unlock:
-	read_unlock(&gpc->lock);
 out_kick:
 	if (kick_vcpu) {
 		kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
@@ -1850,23 +1847,19 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	if (xe->port >= max_evtchn_port(kvm))
 		return -EINVAL;
 
-	rc = -EWOULDBLOCK;
-
 	guard(srcu)(&kvm->srcu);
 
-	if (!read_trylock(&gpc->lock))
-		return rc;
-
-	if (!kvm_gpc_check(gpc, PAGE_SIZE))
-		goto out_unlock;
+	CLASS(gpc_try_map_local, shinfo_map)(gpc, PAGE_SIZE);
+	if (IS_ERR(shinfo_map))
+		return -EWOULDBLOCK;
 
 	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
-		struct shared_info *shinfo = gpc->khva;
+		struct shared_info *shinfo = *shinfo_map;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
 		port_word_bit = xe->port / 64;
 	} else {
-		struct compat_shared_info *shinfo = gpc->khva;
+		struct compat_shared_info *shinfo = *shinfo_map;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
 		port_word_bit = xe->port / 32;
@@ -1888,9 +1881,6 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		rc = 1; /* Delivered to the bitmap in shared_info. */
 	}
 
-out_unlock:
-	read_unlock(&gpc->lock);
-
 	if (rc == 1)
 		__kvm_xen_set_evtchn_fast(vcpu, port_word_bit);
 	return rc;
-- 
2.54.0.823.g6e5bcc1fc9-goog

