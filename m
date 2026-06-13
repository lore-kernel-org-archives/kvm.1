Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AC327FD4F
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309042; cv=none; b=ZzcE0g6sUwpBDqtQuydvQbyMdEbZJDXZzvj7jsvlE1k0eNsd6g6Kz7ZZafhDgr9+bKasbU1kNcqL798QzFkMdLuqJ5+Kswke70M2t4qAadC85CLhJwmA09DPJ5CVHDLqzflX/iq7K0BaTbOMGIqMGXjyakEs10sHr6QPexm9SMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309042; c=relaxed/simple;
	bh=+k8eAc2ynqCJOXA7Hou1UHoPM2wmYgGl88l+uTv4zhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j0Ie+D/PlfuUgYnkyH4uFBIAUzIbZh7jfTpjjhVbIO47Jzy7+YClNodrFQ9JXx0j9KhKS3V316Y0j24Yx9//eZXs3bJ9hRLdNk0FsJrkSCNgGUCYbsgv27iWpUs6DF0oC92xwXy4/dwusWLjT0l9+h3expUTVT5UUP6aY7nAtjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qPKwh3TI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPKwh3TI"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bc380fbf9so1472454a91.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309040; x=1781913840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SYyJm6MD81P2mCuA1sw9aPrFrsPNQ7H8qIthy1i4Jvk=;
        b=qPKwh3TItllce3XN0yTt/QREydVGC/hMg9vttihSz+Su/OGVLf6E8zdRcBntpgdGo8
         1cbxrVQUW2N49DXp6RQ/DroliZtIl1q17U3uzUBzX/jWQdKr4+DZdSwSoNf8urufqCqs
         ZYyrrVBag/UPaMTNkoQo00CUTKyxyDrkDvqajsmhuKxt2/1Pr8CcbRlU9nmd+WtFWJSk
         1ihVHn8i5mZ+OZWbSN4vin+FH4J7UbiJ9bospIOda90bKL3HYa2vKXo4wS0EmBK7Ullw
         j+/zEbE1vzy3U2P8UqaOXg+falUkxGiXHBsjIMkcl50jFL62plrHz81rdEB6+IEfx390
         RylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309040; x=1781913840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYyJm6MD81P2mCuA1sw9aPrFrsPNQ7H8qIthy1i4Jvk=;
        b=L+bfT/wjmT8Y+j+Sp7ZiKej7QmAGM/ppwo1aGbZwrvOi6gqL4fRTGhPTsIZzKIuwLZ
         qz4QBwRxaderyQQ+INRr8iojvIbU9lF0mlnCxXMVTEKyb6qwABubC2iFoG1/05j4gb/m
         3uox6vlti4KetxCK6AAhgXG7sxswBwN/fqJoBlPqua2roZA8H4FkY42X8DzVV7uNd0pF
         /BQWxvrXiEV7/ET9EMjSNL/JAblu42Xk/zpQORnqjGVewZ54+TfSx8mrx9tAUGQDn7fM
         5zmIro6jZ4RgOA3hh8sPv9coxcz0cdJZ6O9U2ppPfnLZGxDQebeiVCyq4L3GQtE1qE/T
         Dw3Q==
X-Gm-Message-State: AOJu0YxdqbLzpsQddQHfJYBQ+rN7TR8rwrfX50Tbv3Oe8SmkifC7Aiq6
	Y7a8cz13AyFNKb5gFw9H52uRWjDybAiXX4DT+xglzjmcDNT/O/InUJ7htoQaBxwmWN/TTgbvXrg
	HPDm68Q==
X-Received: from pjbmi16.prod.google.com ([2002:a17:90b:4b50:b0:374:e2b3:6e25])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2749:b0:369:932a:2b8a
 with SMTP id 98e67ed59e1d1-37a01e2e4d2mr4979035a91.1.1781309039973; Fri, 12
 Jun 2026 17:03:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:18 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-20-seanjc@google.com>
Subject: [PATCH v4 19/30] KVM: x86/pmu: Move "struct kvm_x86_pmu_event_filter"
 definition to pmu.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the definition of "struct kvm_x86_pmu_event_filter" to pmu.c, as the
as the details of the filters are very much implementation details that can
and should be buried in pmu.c.  While the _existence_ of filters is public
knowledge, almost by definition, the contents don't need to be exposed
outside of the PMU code as the filter data is provided by userspace, i.e.
it pretty much has to be dynamically allocated, and thus never should be
fully embedded in a globally visible structure.

No functional change intended

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 13 +------------
 arch/x86/kvm/pmu.c              | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4ff6304c02d0..211958914cc3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -316,6 +316,7 @@ struct kvm_kernel_irqfd;
 struct kvm_kernel_irq_routing_entry;
 
 struct kvm_x86_msr_filter;
+struct kvm_x86_pmu_event_filter;
 
 struct kvm_caps {
 	/* control of guest tsc rate supported? */
@@ -1323,18 +1324,6 @@ enum kvm_suppress_eoi_broadcast_mode {
 	KVM_SUPPRESS_EOI_BROADCAST_DISABLED /* Disable Suppress EOI broadcast */
 };
 
-struct kvm_x86_pmu_event_filter {
-	__u32 action;
-	__u32 nevents;
-	__u32 fixed_counter_bitmap;
-	__u32 flags;
-	__u32 nr_includes;
-	__u32 nr_excludes;
-	__u64 *includes;
-	__u64 *excludes;
-	__u64 events[] __counted_by(nevents);
-};
-
 enum kvm_apicv_inhibit {
 
 	/********************************************************************/
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index b92dd2e58335..62d0ed99ebe9 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -43,6 +43,18 @@ module_param(enable_pmu, bool, 0444);
 bool __read_mostly enable_mediated_pmu;
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_mediated_pmu);
 
+struct kvm_x86_pmu_event_filter {
+	__u32 action;
+	__u32 nevents;
+	__u32 fixed_counter_bitmap;
+	__u32 flags;
+	__u32 nr_includes;
+	__u32 nr_excludes;
+	__u64 *includes;
+	__u64 *excludes;
+	__u64 events[] __counted_by(nevents);
+};
+
 struct kvm_pmu_emulated_event_selectors {
 	u64 INSTRUCTIONS_RETIRED;
 	u64 BRANCH_INSTRUCTIONS_RETIRED;
-- 
2.54.0.1136.gdb2ca164c4-goog

