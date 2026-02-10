Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F06474C14;
	Tue, 10 Feb 2026 06:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770704528; cv=none; b=rQ9EbIAG+/NtOAFhXoxUQ/21P6XLbBl2NIE0p+qrxcpD/ueIT0dSEDkzmjeS1yGGFjeHTbWLgNUTOkX7yP1feEPdqKLoulXhomMVyTbbJQTJvWyVsuouQJz6ri0SFsdXq3XoTkoVPAybZ+c1cG2uqNyri4/YjiomPgU6HkRbYSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770704528; c=relaxed/simple;
	bh=pnsIXn0dPZD0cppFzmIGCLwB+d0yqvZJN3ShCklfyOI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dJ975/B43jmQO/voVwLRxcSIkXFbDHJ8oBK0K2vzPBKQE5gF+gYvsUM8jA989dx+kchVTYTfAdYa+f5OodsVRTX5G3th4LzI85SspIrvwgHFdDN8vaiHnS+B+bZeeRpmpBxSAFThVuknFzBMpAtaswlPdTrcJO0X7oRtSLeRsc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] KVM: Mark halt poll and other module parameters with appropriate memory attributes
Date: Tue, 10 Feb 2026 01:21:43 -0500
Message-ID: <20260210062143.1739-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc9.internal.baidu.com (172.31.3.19) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Add '__read_mostly' to the halt polling parameters (halt_poll_ns,
halt_poll_ns_grow, halt_poll_ns_grow_start, halt_poll_ns_shrink) since
they are frequently read in hot paths (e.g., vCPU halt handling) but only
occasionally updated via sysfs. This improves cache locality on SMP
systems.

Conversely, mark 'allow_unsafe_mappings' and 'enable_virt_at_load' with
'__ro_after_init', as they are set only during module initialization via
kernel command line or early sysfs writes and remain constant thereafter.
This enhances security by preventing runtime modification and enables
compiler optimizations.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 virt/kvm/kvm_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4fa8611..6b2f126 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -76,22 +76,22 @@ MODULE_DESCRIPTION("Kernel-based Virtual Machine (KVM) Hypervisor");
 MODULE_LICENSE("GPL");
 
 /* Architectures should define their poll value according to the halt latency */
-unsigned int halt_poll_ns = KVM_HALT_POLL_NS_DEFAULT;
+unsigned int __read_mostly halt_poll_ns = KVM_HALT_POLL_NS_DEFAULT;
 module_param(halt_poll_ns, uint, 0644);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns);
 
 /* Default doubles per-vcpu halt_poll_ns. */
-unsigned int halt_poll_ns_grow = 2;
+unsigned int __read_mostly halt_poll_ns_grow = 2;
 module_param(halt_poll_ns_grow, uint, 0644);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_grow);
 
 /* The start value to grow halt_poll_ns from */
-unsigned int halt_poll_ns_grow_start = 10000; /* 10us */
+unsigned int __read_mostly halt_poll_ns_grow_start = 10000; /* 10us */
 module_param(halt_poll_ns_grow_start, uint, 0644);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_grow_start);
 
 /* Default halves per-vcpu halt_poll_ns. */
-unsigned int halt_poll_ns_shrink = 2;
+unsigned int __read_mostly halt_poll_ns_shrink = 2;
 module_param(halt_poll_ns_shrink, uint, 0644);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
 
@@ -99,7 +99,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
  * Allow direct access (from KVM or the CPU) without MMU notifier protection
  * to unpinned pages.
  */
-static bool allow_unsafe_mappings;
+static bool __ro_after_init allow_unsafe_mappings;
 module_param(allow_unsafe_mappings, bool, 0444);
 
 /*
@@ -5589,7 +5589,7 @@ static struct miscdevice kvm_dev = {
 };
 
 #ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
-bool enable_virt_at_load = true;
+bool __ro_after_init enable_virt_at_load = true;
 module_param(enable_virt_at_load, bool, 0444);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_virt_at_load);
 
-- 
2.9.4

