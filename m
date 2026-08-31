Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C793A9DA3;
	Mon, 31 Aug 2026 21:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212241; cv=none; b=CueuN7nl9QYN5WyXzeGHFc4kfW2z0Tjanpo5bK6yYM5w/Uho8XXT25zRkDhOVG0sQmw+ikzH+Os0eNEzKasnYTywKMnNLWf2USmTgsODgmyXidFC2LeRpvXn9EQ5+1Ur39AnKBSb0tSOXREcQG/Xd0Ba7tbJ/4KbB6KSY3WyXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212241; c=relaxed/simple;
	bh=SxWTqWJLA4EYv1W/Tnp93hs6EQMLr0AUAl/ERQGIEsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3sTQeiGnoSgfkB+Cnm3gOEHZF7w2cLK/9Lv6VOF1TWE+BL49DAVtmdPDB3Qurmnq0nCpQzdDb0yNCKsbd0U4JXBFRZ4FjhA/tuUXsizDeDBlBYB/sCGychezj/4CqXBoYd/yaiirVzFJV5j09uptBLT5j6IMQZEcv6RFV0qSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E7QOMc/I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E7QOMc/I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vsoHQOlZpmRNmqcjtCJQ7H8C74QH3xSJ2M5dEfr1dAw=; b=E7QOMc/I4/dzvWhbI9kRJELWZq
	M+QyKZPrFFagDoc3cBacL+9oWlVpC2TWijm2MU01g1MJXaun59onCPy+A+rteJFT6VeLOuukgEM+0
	GU4n7P1dXJ8JvG469/jEs2Zgo8IXvbCSF1JCs0KZwuJN9Um+azkhJMOVnX55X6jOOxUSoaj+s3Js/
	E3ZSSdV7tkuFgcZVts/YBfqDTk0V4L6eV/Kc/KqQ9WyFU1HXwJr/2aDnqUvdQsdDVpR3/RWC81IB9
	K+dY31ry/WNYg9UVZUmQwxXKxZcuutub7LkRbrokSeQxgAkUk0slTU2ySqSxWDQwrWDBcXBwN6D71
	ZPWtDFeA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x19gE-00000003sv8-2uI8;
	Mon, 31 Aug 2026 21:36:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x19gE-00000000LDF-22ZE;
	Mon, 31 Aug 2026 22:36:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw2@infradead.org,
	paul@xen.org,
	joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com,
	ankur.a.arora@oracle.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	x86@kernel.org,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	suryasaimadhu369@gmail.com,
	lkp@intel.com,
	nicoyip.dev@gmail.com,
	frn1furkan10@gmail.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH v3 10/13] KVM: x86/xen: Take kvm->srcu in __kvm_xen_has_interrupt()
Date: Mon, 31 Aug 2026 22:26:41 +0100
Message-ID: <20260831213632.81023-11-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831213632.81023-1-dwmw2@infradead.org>
References: <20260831213632.81023-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

kvm_gpc_check() checks the cached memslot generation against the current
one, which dereferences kvm->memslots and therefore requires kvm->srcu to
be held. __kvm_xen_has_interrupt() does not take it.

Most callers do happen to hold kvm->srcu, but not all of them:

 - kvm_emulate_halt() on the VM-Exit path, via kvm_vcpu_has_events() and
   kvm_cpu_has_extint(). vcpu_enter_guest() drops the vCPU's SRCU lock
   before entering the guest, so it is not held on the way back out.

 - kvm_vcpu_block() -> kvm_vcpu_check_block() -> kvm_arch_vcpu_runnable(),
   which is the case the existing comment in this function describes.

On a PROVE_RCU kernel the former produces:

  WARNING: suspicious RCU usage
  include/linux/kvm_host.h:1092 suspicious rcu_dereference_check() usage!
  ...
   kvm_gpc_check+0x344/0x3e0 [kvm]
   __kvm_xen_has_interrupt+0x83/0x310 [kvm]
   kvm_cpu_has_extint+0x1ff/0x370 [kvm]
   kvm_cpu_has_interrupt+0x16/0x100 [kvm]
   kvm_vcpu_has_events+0x4ce/0x690 [kvm]
   kvm_emulate_halt+0x52/0x1f0 [kvm]
   vmx_vcpu_run+0x988/0x2630 [kvm_intel]

Use guard(srcu) so that the three existing early returns don't each need
an explicit unlock. SRCU read sections nest, so this is harmless on the
paths which already hold it, and srcu_read_lock() does not sleep, so it
is also safe in the atomic case which this function already handles.

Fixes: 7caf9571563e ("KVM: x86/xen: Use gfn_to_pfn_cache for vcpu_info")
Cc: stable@vger.kernel.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/xen.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index f8730ee48ab8..871cbaf8b68d 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -732,6 +732,16 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 	BUILD_BUG_ON(sizeof(rc) !=
 		     sizeof_field(struct compat_vcpu_info, evtchn_upcall_pending));
 
+	/*
+	 * kvm_gpc_check() checks the memslot generation, so kvm->srcu must be
+	 * held. Most callers hold it already, but this is also reached from
+	 * kvm_emulate_halt() on the VM-Exit path and from kvm_vcpu_block(),
+	 * where vcpu_enter_guest() has already dropped the vCPU's SRCU lock.
+	 * Taking SRCU does not sleep, so it is safe even in the atomic case
+	 * which is handled below.
+	 */
+	guard(srcu)(&v->kvm->srcu);
+
 	read_lock_irqsave(&gpc->lock, flags);
 	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
 		read_unlock_irqrestore(&gpc->lock, flags);
-- 
2.55.0

