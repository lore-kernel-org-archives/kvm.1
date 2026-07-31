Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9A8456E17
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517597; cv=none; b=X1OiFsUzvIZOg+Vb7RGjlgJkzr2oVDUWgChoRngN2PstWN9yP8T3u8vPOdWmTcSCb0qsbEoNQ84cetoem78LhNxK+ARnnYTUUhzCC9rpgBpHmjnUj/VXKh6OxEws4FWuCu0YpKE6Itjt6sGjxsV/g7BPWc/2lrcfi0I6Si+YLac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517597; c=relaxed/simple;
	bh=eFedP1FKrSCUz33LyUYB/hbFk56NqWKwZqQkDaFxLJ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bDO7nHrrJZHgpsFPFfqYuSRM92I5jbg/NFNmq7rQYYFn5Fo6i46W0gZY5QlTZ4IIopKNb05V0F8DY+AYWoFN++ug5M+KpICxFanGOF6YuEuvXChwbjkqyT8H2pHowXZ9E7X0lAUvIxdgPCy++yeKBKHvRnmnCweibJMKE9weCsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=la9G6CjZ; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="la9G6CjZ"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb5cc1e13f8so1466994a12.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785517595; x=1786122395; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t+9CTldHkmPcTJwS5mSWfk0XaYsDahSdFAriIqs5uQo=;
        b=la9G6CjZ10kIhQel1dm5ViW8w5W6H3vMUXc1gktJVgwAYfDyRoCdzQzlx4W4Kgjsgb
         vJXZ4eXZoXbOemWE4QzYOCjaH0G0VDO/hkSepg7nKuUevFqACuZ/dKryfQ49992vM86n
         6Frxn6BipRIO4Yl/ir9OXcZ4yaLcgA9PCZU3PqkNCMmRHYfcka67/IDV3TR5WCe4AqWr
         IzUkxfy6uEdr0UmYYZnAzM5guu7f5t/fqoFkfetljZEscHzDzQ1rQF2nWi0ff484zswe
         MZYVPrL96zrRXD5ezPDnUzPz79BHJBr6Tl1OiSMWnUImsP0OYPMra8c4V2wwNooo4ho1
         YOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785517595; x=1786122395;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t+9CTldHkmPcTJwS5mSWfk0XaYsDahSdFAriIqs5uQo=;
        b=YNoCQ1EgqeoIGTB4SgszYQ+JxSwaW8ozxzaEOvqfEz61StyA9z41ELbmoC9rpZHlPe
         ZIaNC3xtdFqlOUH1yr6CqrS44D3boA7exNxSMed5aefKlmTk44U4SE/pl8wde7aVdC3f
         wUWMIe6Jz6WpBsQExJsxNJsP857Bo+KrP8ru+6eV5epbdhyZDkRh3ILcoM3aINFeZBcR
         DK9ad3+NSaB3OwtX/8BJtfwnVEACCoJWMH1Py6X5skApQm9BKLsiaonVDKEifp5fH7Tt
         XBFUGE/Myqe+Hu7+RE06C7WAXuE/KzJ+o0JYp1S9PKgy0TJ0LV/d31oposSCHWT2mBxu
         x6AQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYqvo5Y8zZs6E/uMmxK7hnsPnaKuT/nBMhXNHFoPj9A4226LrtJ4V+BpcTx5gjHN9GGXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWEujwf3HFrtrg+0kkgGpo3Mo43YxM7BRakYLGi156WCREn2ak
	vz/ab0UiUaOA0U7m3r9jTibWlM8jPttF+XzG4CJyHrjd6Jf/liFROLWXoeQRBts7iTiUNpqrbjg
	sosz/Cw==
X-Received: from pgbcp10.prod.google.com ([2002:a05:6a02:400a:b0:c99:7baf:125f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:10d:b0:3c3:96dd:9ecc
 with SMTP id adf61e73a8af0-3c92a867734mr515731637.57.1785517595183; Fri, 31
 Jul 2026 10:06:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:06:17 -0700
In-Reply-To: <20260731170619.2620845-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731170619.2620845-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731170619.2620845-11-seanjc@google.com>
Subject: [PATCH v2 10/12] KVM: selftests: Add helper APIs to cancel+join pthreads
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Deduplicate test code that does cancel()+join() on pthreads by adding a
collection of syscall wrappers.  The tests that asynchronously cancel
pthreads, i.e. use PTHREAD_CANCEL_ASYNCHRONOUS, are particularly ugly,
especially since it's not immediately obvious why those tests assert on
the thread being CANCELED, whereas others do not.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_syscalls.h      | 24 +++++++++++++++++++
 tools/testing/selftests/kvm/x86/hyperv_ipi.c  | 15 ++----------
 .../selftests/kvm/x86/hyperv_tlb_flush.c      | 15 ++----------
 .../selftests/kvm/x86/recalc_apic_map_test.c  |  3 +--
 .../selftests/kvm/x86/sync_regs_test.c        |  3 +--
 .../selftests/kvm/x86/xapic_ipi_test.c        | 15 ++----------
 .../selftests/kvm/x86/xen_shinfo_test.c       |  3 +--
 7 files changed, 33 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/testing/selftests/kvm/include/kvm_syscalls.h
index d6c18e13b9c8..c0657e54aee5 100644
--- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -104,6 +104,30 @@ __KVM_SYSCALL_DEFINE(pthread_create, 4, pthread_t *, thread,
 __KVM_SYSCALL_DEFINE(pthread_join, 2, pthread_t, thread, void **, thread_return);
 __KVM_SYSCALL_DEFINE(pthread_cancel, 1, pthread_t, thread);
 
+static inline void __kvm_pthread_cancel_join(pthread_t thread, void **r)
+{
+	kvm_pthread_cancel(thread);
+	kvm_pthread_join(thread, r);
+}
+
+static inline void kvm_pthread_cancel_join(pthread_t thread)
+{
+	__kvm_pthread_cancel_join(thread, NULL);
+}
+
+/*
+ * Cancel+Join a pthread that was configured with PTHREAD_CANCEL_ASYNCHRONOUS
+ * and is expected to exit only in response to cancellation.
+ */
+static inline void kvm_pthread_cancel_join_async(pthread_t thread)
+{
+	void *r;
+
+	__kvm_pthread_cancel_join(thread, &r);
+	TEST_ASSERT(r == PTHREAD_CANCELED,
+		    "expected retval=%p, got %p", PTHREAD_CANCELED, r);
+}
+
 #define kvm_free_fd(fd)		\
 do {				\
 	kvm_close(fd);		\
diff --git a/tools/testing/selftests/kvm/x86/hyperv_ipi.c b/tools/testing/selftests/kvm/x86/hyperv_ipi.c
index d2efb1043534..a2fc0bca8011 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_ipi.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_ipi.c
@@ -222,17 +222,6 @@ static void *vcpu_thread(void *arg)
 	return NULL;
 }
 
-static void cancel_join_vcpu_thread(pthread_t thread, struct kvm_vcpu *vcpu)
-{
-	void *retval;
-
-	kvm_pthread_cancel(thread);
-	kvm_pthread_join(thread, &retval);
-	TEST_ASSERT(retval == PTHREAD_CANCELED,
-		    "expected retval=%p, got %p", PTHREAD_CANCELED,
-		    retval);
-}
-
 int main(int argc, char *argv[])
 {
 	struct kvm_vm *vm;
@@ -293,8 +282,8 @@ int main(int argc, char *argv[])
 	}
 
 done:
-	cancel_join_vcpu_thread(threads[0], vcpu[1]);
-	cancel_join_vcpu_thread(threads[1], vcpu[2]);
+	kvm_pthread_cancel_join_async(threads[0]);
+	kvm_pthread_cancel_join_async(threads[1]);
 	kvm_vm_free(vm);
 
 	return 0;
diff --git a/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c b/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
index e4fc9bb6f329..dc9d40830a7f 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
@@ -548,17 +548,6 @@ static void *vcpu_thread(void *arg)
 	return NULL;
 }
 
-static void cancel_join_vcpu_thread(pthread_t thread, struct kvm_vcpu *vcpu)
-{
-	void *retval;
-
-	kvm_pthread_cancel(thread);
-	kvm_pthread_join(thread, &retval);
-	TEST_ASSERT(retval == PTHREAD_CANCELED,
-		    "expected retval=%p, got %p", PTHREAD_CANCELED,
-		    retval);
-}
-
 int main(int argc, char *argv[])
 {
 	struct kvm_vm *vm;
@@ -652,8 +641,8 @@ int main(int argc, char *argv[])
 	}
 
 done:
-	cancel_join_vcpu_thread(threads[0], vcpu[1]);
-	cancel_join_vcpu_thread(threads[1], vcpu[2]);
+	kvm_pthread_cancel_join_async(threads[0]);
+	kvm_pthread_cancel_join_async(threads[1]);
 	kvm_vm_free(vm);
 
 	return 0;
diff --git a/tools/testing/selftests/kvm/x86/recalc_apic_map_test.c b/tools/testing/selftests/kvm/x86/recalc_apic_map_test.c
index e3e397f32bff..6252a96320ee 100644
--- a/tools/testing/selftests/kvm/x86/recalc_apic_map_test.c
+++ b/tools/testing/selftests/kvm/x86/recalc_apic_map_test.c
@@ -65,8 +65,7 @@ int main(void)
 		vcpu_set_msr(vcpuN, MSR_IA32_APICBASE, LAPIC_DISABLED);
 	}
 
-	kvm_pthread_cancel(thread);
-	kvm_pthread_join(thread, NULL);
+	kvm_pthread_cancel_join(thread);
 
 	kvm_vm_free(vm);
 
diff --git a/tools/testing/selftests/kvm/x86/sync_regs_test.c b/tools/testing/selftests/kvm/x86/sync_regs_test.c
index 99a5bbeffc5d..ed0c21b427c9 100644
--- a/tools/testing/selftests/kvm/x86/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/x86/sync_regs_test.c
@@ -199,8 +199,7 @@ static void race_sync_regs(struct kvm_vcpu *vcpu, void *racer)
 		}
 	}
 
-	kvm_pthread_cancel(thread);
-	kvm_pthread_join(thread, NULL);
+	kvm_pthread_cancel_join(thread);
 
 	kvm_x86_state_cleanup(state);
 }
diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 33e78b284c67..469e3ab16460 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -228,17 +228,6 @@ static void *vcpu_thread(void *arg)
 	return NULL;
 }
 
-static void cancel_join_vcpu_thread(pthread_t thread, struct kvm_vcpu *vcpu)
-{
-	void *retval;
-
-	kvm_pthread_cancel(thread);
-	kvm_pthread_join(thread, &retval);
-	TEST_ASSERT(retval == PTHREAD_CANCELED,
-		    "expected retval=%p, got %p", PTHREAD_CANCELED,
-		    retval);
-}
-
 void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 		   u64 *pipis_rcvd)
 {
@@ -450,8 +439,8 @@ int main(int argc, char *argv[])
 	/*
 	 * Cancel threads and wait for them to stop.
 	 */
-	cancel_join_vcpu_thread(threads[0], params[0].vcpu);
-	cancel_join_vcpu_thread(threads[1], params[1].vcpu);
+	kvm_pthread_cancel_join_async(threads[0]);
+	kvm_pthread_cancel_join_async(threads[1]);
 
 	/*
 	 * If the host support Idle HLT, i.e. KVM *might* be using Idle HLT,
diff --git a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
index 3ec5e67b21ef..aaa414c677ad 100644
--- a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
@@ -947,8 +947,7 @@ int main(int argc, char *argv[])
 				TEST_ASSERT(!evtchn_irq_expected,
 					    "Expected event channel IRQ but it didn't happen");
 
-				kvm_pthread_cancel(thread);
-				kvm_pthread_join(thread, 0);
+				kvm_pthread_cancel_join(thread);
 				goto done;
 
 			case TEST_GUEST_SAW_IRQ:
-- 
2.55.0.508.g3f0d502094-goog

