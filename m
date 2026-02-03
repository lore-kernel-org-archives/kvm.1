Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBE1366DDB;
	Tue,  3 Feb 2026 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142655; cv=none; b=oERWXQqHIgRYElir+GmW2h9XNLaQfluI7SaiZWMVBs4qERlaabniFVgvcp31HIiUmq43gTnF5vFt9yZXvw618T6XUaBrHl1er1sOkIrcqqmQmne5ttJaFO6BBnVLLTbPecp80M1+fux9k8KZl7aqStpsdBTU5xr8bTVZ6nO/4d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142655; c=relaxed/simple;
	bh=COE8kPmigj/LgeZHfmEjw88aXbrjj1fBsgrpEydMIZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/vb4lRlJY7R/k+nDwhi8vt9oYXER2kYkMy8eaUCPROBLxM05G02uDidlko2VDEijy++sdb0HbryITjMXcQeMCWd7u7tORuxf8lqzk7KrQh8w42dzoAeHS9L95wQsDY/mxhFKUKuUERUAZs9pVb2fy2D4R3IVuc/basTQ9vb030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uwjph0f1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uwjph0f1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770142654; x=1801678654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=COE8kPmigj/LgeZHfmEjw88aXbrjj1fBsgrpEydMIZo=;
  b=Uwjph0f1VoGPQqepr7MHa/3g/vVWhv+6ycfiufWnP+hJgRZTg2OfYy0X
   1+wY3mpzjCOoBVjGDhjum4NXh7t8+U3MDzk/Rbq2XipMqBlQOOO/TaGks
   WZMHbMSzudPdkGmGBDA/rubo42FeLyeqBec3VAIdRHNrKsn8uCknaJ46/
   qnHwuNUasAvPQk4yIUmcc6iGt2GpZFIe4d+u+hlAPmqjpp7H7JcumKUjq
   p1PoJsUGSYZbUfkbfvmE3oeW4AN+OASVoRyYSVGEhW416kntozU7uQun3
   ZFaBJ4UcWobSinjhHjM+PNiWNoKxhxu8kevxC0FLacPwxXJ6E9uxM/nVH
   w==;
X-CSE-ConnectionGUID: Y1L6KhuvRUOQJd5d8ECl4A==
X-CSE-MsgGUID: +HpU4BDdQ+CzlMbs1Lxp1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82433170"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="82433170"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:17:33 -0800
X-CSE-ConnectionGUID: MiaA+CieTfC3TibqOcqdeQ==
X-CSE-MsgGUID: qbmYqY2MQ42De7w57vsxfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="209727481"
Received: from khuang2-desk.gar.corp.intel.com (HELO localhost) ([10.124.221.188])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:17:34 -0800
From: isaku.yamahata@intel.com
To: kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	isaku.yamahata@gmail.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/32] KVM: x86/lapic: Wire DEADLINE MSR update to guest virtual TSC deadline
Date: Tue,  3 Feb 2026 10:16:47 -0800
Message-ID: <799fefe0c582ac5f9356a9a9a3dbf521b03cf39b.1770116050.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1770116050.git.isaku.yamahata@intel.com>
References: <cover.1770116050.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Isaku Yamahata <isaku.yamahata@intel.com>

Wire userpace read/write (KVM_GET_MSRS, KVM_SET_MSRS) of TSCDEADLINE MSR to
the vendor backend to update the VMCS field of GUEST TSCDEADLINE and
GUEST TSCDEADLINE shadow.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/lapic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index ee15d3bf5ef9..080245f6dac1 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2754,6 +2754,10 @@ u64 kvm_get_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu)
 	if (!kvm_apic_present(vcpu) || !apic_lvtt_tscdeadline(apic))
 		return 0;
 
+	if (apic->lapic_timer.apic_virt_timer_in_use)
+		apic->lapic_timer.tscdeadline =
+			kvm_x86_call(get_guest_tsc_deadline_virt)(vcpu);
+
 	return apic->lapic_timer.tscdeadline;
 }
 
@@ -2766,6 +2770,8 @@ void kvm_set_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu, u64 data)
 
 	hrtimer_cancel(&apic->lapic_timer.timer);
 	apic->lapic_timer.tscdeadline = data;
+	if (apic->lapic_timer.apic_virt_timer_in_use)
+		kvm_x86_call(set_guest_tsc_deadline_virt)(vcpu, data);
 	start_apic_timer(apic);
 }
 
-- 
2.45.2

