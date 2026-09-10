Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473452D2D9
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057452; cv=none; b=Uxp2krGRY1/zJski5DhO48WXjsaedmnk5e1s8FLCS0vlNc9o68E97U2xYxtXDoO9dPj/bkviIYhFN/9lZ5WyUf5aG7quN5hSqwWERf7F1LYDBc5LocfrBHV3kTSNKgMgBwflEwadkReov9ShteboE2pENgHBeGwcldfbrjFC8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057452; c=relaxed/simple;
	bh=Uw18xgi0BxdfHnCsIhuDM+SwgIYJ0SP8g/ovgWkILJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o+lhtkKPmyHaSjv0+L4Y/mRDSpEVPt/Yxvo/0eXZdrry81WXrYzaZH8TgHrBBAr2ZECFFKTlMEFHi0R5gyWVf4rF7X1CSAQQ4nU9BA1YOgSxmuNqnjFbesbJeLN2yOTap2OWHGxebFmXCXSRAvTvjBprq3qEtDn/5+H7CuGlZc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7TAiWc8; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7TAiWc8"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c2942fa0995so168318166b.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789057446; x=1789662246; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KnZriOrx76oWc7IbFKP8WTxfBR0BHG1CwkYJSO6Ivsw=;
        b=q7TAiWc8wCSCe26DpL8+PXoZ6NhrB/sxGstZdjN4DZ4OgqGfMRBRDTuYXsbmD5ETCV
         0uQHtb1IuQycvP4jRYZrOQIMGJHwg1Yrr3A0bUMuB2rXiHaItDTPchvAbTPfy/D8UsBS
         q3Sej2ZQXqbcxDPp3S3D3Bh5WEVFerAlyn++tJET6deY23IxFb523leFG69VHZoHVQ6k
         Wjs0wZEv/fAnM+ngBoomLa9LG2eq4isiwwA+x03XAWtNc4PR3uV3H/DE7XrE/5+u254n
         wfZmxZUiC2d9Yg4v23GLMtVUR91BAQY/oGr/lPGiPyYiPLgzeeaNicnqwHDoeqxgrhV2
         Loeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057446; x=1789662246;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KnZriOrx76oWc7IbFKP8WTxfBR0BHG1CwkYJSO6Ivsw=;
        b=KGCJS+TnL+wYDGrxOX+f+r5dCItTYk0uFOdIwCJ6r4IHyxpvSlne7zaHq4hA7kJSYV
         7uGazQ8hoTP2Cb/f1qtc7fQQJDrlKOT8ZLoxwFlvakqgQIv3D1xQKCI54FsPTwCnrO+g
         4XUM+MjU4y20GrzFJGctehB0fON5bgxkY8HJMi8mryVHVknEjMBnc9zpiW30qfBYLI75
         U4drCZ7NH2BtNVSEYfetwv9SWQh5bsQhdq86VWSQbkSjIEPp5btsj9aRlzZYDZTHJkSY
         RPQsq3hUD4yJQvmYYpZBlq0o8f76qxEwFYTNi6vDCD4rNdPqzDrTWs3z+bClE4ugBYin
         4Zxg==
X-Forwarded-Encrypted: i=1; AKwUvBwEKG0YAuLkl9yoZuBo30hRw0j+WYRXu7WmwP60gQc4vfMwbkL8csIKfeCDfG9zfwrKtM0=@vger.kernel.org
X-Gm-Message-State: AFuF++mt2HLdf00sTujAVFlI/WjOJex+GL6mgRffN9Cl+cXEGXoCPbmq
	8rwibE98jpdoz+TAsXIVEOvrYr9NybsNCN8/Qo87MOSSzly3r+KItXqCip0zhSaZKJw1k0TfoFm
	38w==
X-Received: from ejcey15.prod.google.com ([2002:a17:907:b8f:b0:c25:1e06:d698])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:9709:b0:c1c:4e36:eec6
 with SMTP id a640c23a62f3a-c260ca22ce1mr1766102666b.18.1789057445690; Thu, 10
 Sep 2026 09:24:05 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:21:42 +0000
In-Reply-To: <20260910162343.4092060-1-elver@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910162343.4092060-1-elver@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910162343.4092060-10-elver@google.com>
Subject: [PATCH RFC 09/10] KVM: x86: Add guarded_by annotations for kvm_arch,
 kvm_hv, and ioapic
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add __guarded_by annotations to a subset of fields across x86 state
(struct kvm_hv, struct kvm_arch, and struct kvm_ioapic) where the
protecting locks reside in the same struct scope. Mark deliberate
lockless updates with data_race().

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 arch/x86/include/asm/kvm_host.h | 32 ++++++++++++++++----------------
 arch/x86/kvm/ioapic.c           |  4 ++--
 arch/x86/kvm/ioapic.h           | 16 ++++++++--------
 arch/x86/kvm/x86.c              |  8 ++++----
 4 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 683bb8bf43a9..a0d2d6c08e47 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1073,20 +1073,20 @@ struct kvm_hv {
 	struct mutex hv_lock;
 	u64 hv_guest_os_id;
 	u64 hv_hypercall;
-	u64 hv_tsc_page;
+	u64 hv_tsc_page __guarded_by(&hv_lock);
 	enum hv_tsc_page_status hv_tsc_page_status;
 
 	/* Hyper-v based guest crash (NT kernel bugcheck) parameters */
-	u64 hv_crash_param[HV_X64_MSR_CRASH_PARAMS];
-	u64 hv_crash_ctl;
+	u64 hv_crash_param[HV_X64_MSR_CRASH_PARAMS] __guarded_by(&hv_lock);
+	u64 hv_crash_ctl __guarded_by(&hv_lock);
 
 	struct ms_hyperv_tsc_page tsc_ref;
 
 	struct idr conn_to_evt;
 
-	u64 hv_reenlightenment_control;
-	u64 hv_tsc_emulation_control;
-	u64 hv_tsc_emulation_status;
+	u64 hv_reenlightenment_control __guarded_by(&hv_lock);
+	u64 hv_tsc_emulation_control __guarded_by(&hv_lock);
+	u64 hv_tsc_emulation_status __guarded_by(&hv_lock);
 	u64 hv_invtsc_control;
 
 	/* How many vCPUs have VP index != vCPU index */
@@ -1232,15 +1232,15 @@ struct kvm_arch {
 	 * preemption-disabled region, so it must be a raw spinlock.
 	 */
 	raw_spinlock_t tsc_write_lock;
-	u64 last_tsc_nsec;
-	u64 last_tsc_write;
-	u32 last_tsc_khz;
-	u64 last_tsc_offset;
-	u64 cur_tsc_nsec;
-	u64 cur_tsc_write;
-	u64 cur_tsc_offset;
-	u64 cur_tsc_generation;
-	int nr_vcpus_matched_tsc;
+	u64 last_tsc_nsec __guarded_by(&tsc_write_lock);
+	u64 last_tsc_write __guarded_by(&tsc_write_lock);
+	u32 last_tsc_khz __guarded_by(&tsc_write_lock);
+	u64 last_tsc_offset __guarded_by(&tsc_write_lock);
+	u64 cur_tsc_nsec __guarded_by(&tsc_write_lock);
+	u64 cur_tsc_write __guarded_by(&tsc_write_lock);
+	u64 cur_tsc_offset __guarded_by(&tsc_write_lock);
+	u64 cur_tsc_generation __guarded_by(&tsc_write_lock);
+	int nr_vcpus_matched_tsc __guarded_by(&tsc_write_lock);
 
 	u32 default_tsc_khz;
 	bool user_set_tsc;
@@ -1370,7 +1370,7 @@ struct kvm_arch {
 #endif
 
 #if IS_ENABLED(CONFIG_HYPERV)
-	hpa_t	hv_root_tdp;
+	hpa_t	hv_root_tdp __guarded_by(&hv_root_tdp_lock);
 	spinlock_t hv_root_tdp_lock;
 	struct hv_partition_assist_pg *hv_pa_pg;
 #endif
diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index d6865e557abe..7affe2584036 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -739,11 +739,11 @@ int kvm_ioapic_init(struct kvm *kvm)
 	ioapic = kzalloc_obj(struct kvm_ioapic, GFP_KERNEL_ACCOUNT);
 	if (!ioapic)
 		return -ENOMEM;
-	spin_lock_init(&ioapic->lock);
 	INIT_DELAYED_WORK(&ioapic->eoi_inject, kvm_ioapic_eoi_inject_work);
 	INIT_HLIST_HEAD(&ioapic->mask_notifier_list);
 	kvm->arch.vioapic = ioapic;
-	kvm_ioapic_reset(ioapic);
+	scoped_guard(spinlock_init, &ioapic->lock)
+		kvm_ioapic_reset(ioapic);
 	kvm_iodevice_init(&ioapic->dev, &ioapic_mmio_ops);
 	ioapic->kvm = kvm;
 	mutex_lock(&kvm->slots_lock);
diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
index 81b576513116..1f87396c0a79 100644
--- a/arch/x86/kvm/ioapic.h
+++ b/arch/x86/kvm/ioapic.h
@@ -70,19 +70,19 @@ union kvm_ioapic_redirect_entry {
 
 struct kvm_ioapic {
 	u64 base_address;
-	u32 ioregsel;
-	u32 id;
-	u32 irr;
+	u32 ioregsel __guarded_by(&lock);
+	u32 id __guarded_by(&lock);
+	u32 irr __guarded_by(&lock);
 	u32 pad;
-	union kvm_ioapic_redirect_entry redirtbl[IOAPIC_NUM_PINS];
-	unsigned long irq_states[IOAPIC_NUM_PINS];
+	union kvm_ioapic_redirect_entry redirtbl[IOAPIC_NUM_PINS] __guarded_by(&lock);
+	unsigned long irq_states[IOAPIC_NUM_PINS] __guarded_by(&lock);
 	struct kvm_io_device dev;
 	struct kvm *kvm;
 	spinlock_t lock;
-	struct rtc_status rtc_status;
+	struct rtc_status rtc_status __guarded_by(&lock);
 	struct delayed_work eoi_inject;
-	u32 irq_eoi[IOAPIC_NUM_PINS];
-	u32 irr_delivered;
+	u32 irq_eoi[IOAPIC_NUM_PINS] __guarded_by(&lock);
+	u32 irr_delivered __guarded_by(&lock);
 
 	/* reads protected by irq_srcu, writes by irq_lock */
 	struct hlist_head mask_notifier_list;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9893705d0dfa..5d4b2c7aa9b8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9813,8 +9813,8 @@ int kvm_arch_enable_virtualization_cpu(void)
 			 * you may have some problem.  Solving this issue is
 			 * left as an exercise to the reader.
 			 */
-			kvm->arch.last_tsc_nsec = 0;
-			kvm->arch.last_tsc_write = 0;
+			data_race(kvm->arch.last_tsc_nsec = 0);
+			data_race(kvm->arch.last_tsc_write = 0);
 		}
 
 	}
@@ -9927,8 +9927,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.enable_pmu = enable_pmu && !kvm->arch.has_protected_pmu;
 
 #if IS_ENABLED(CONFIG_HYPERV)
-	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
-	kvm->arch.hv_root_tdp = INVALID_PAGE;
+	scoped_guard(spinlock_init, &kvm->arch.hv_root_tdp_lock)
+		kvm->arch.hv_root_tdp = INVALID_PAGE;
 #endif
 
 	kvm_apicv_init(kvm);
-- 
2.55.0.1003.g10538fe699-goog

