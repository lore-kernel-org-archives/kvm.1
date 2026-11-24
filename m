Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562583;
	b=zEQt5RXvhBYgWQM4lyp8DDbL8EeJS+Bz/do7/sLMCrsUx74TbhmMgV5Ll0zJVuzJweY5
	 ALwuBPocNGU/RYzS5lVCQapkiVUWaOIemXwXbMWxUqD22n3RLq2JcIbprVpfUi/caWANy
	 Fc7DFXvdM4QvExgabAi/shQa0buj6tgoh/1S8CImtaNVqYHDsMTMgE6mrLbHSAvOyRvW3
	 G0XlpO6IQYHsouMI5X788qXQYS5CKKWZk8pUccPocU3HpaN+Y9vMuqON0ouPecmpkqlNL
	 22XclWhNWmCjjK3XuKv29eQHIa/iN8NMMph5H06w/x0PcTp/uELvpJIp9NHQMjPLnhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562583;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=OFnO+yDa1ZmaA/R14QNLcscazCGJjNcIgEoVI8ugoEQ=;
	b=Q8hhGWoyq9FA/bZ9u9ind9+YVf2T70QGkkql1QfNjWGN9KrG/4Y6V54v0JTFVx4xWvG0
	 U9uIpjClHiss8mcU5+LcnNEHTHV2rd6B+cPBAK/9/2QO7eLUbEbhgYsXqNtIn549PwNgW
	 lubuk2CWBesnCIQdAM9OxIoT58S49gAxHWwKTgQMo1byYX5502hsEivL8SQ4SpKS1AJIC
	 AQJ5H+N/uYbxcpoWts5JS67RmvODws0slyCeQZITRF/ljOnPGy8+CWxqdmfy3IrzqNuos
	 d9Cg6xiuijbzXI3/ouVNYQEziQqEVUsf3PsI5160rOBscScgRtz0CKQ83Af49npsSog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=psysTftX;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E663F606A69F
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E663F606A69F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=psysTftX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=OFnO+yDa1ZmaA/R14QNLcscazCGJjNcIgEoVI8ugoEQ=; b=psysTftXmhA2M/i2DJl5n05FHQ
	YEihJUcA70x2jaMkwy7shi63x1e+4RR2zpn9A34T+C2xx4UmrkzE41sjhqPOzFbP4rkKS6B6/2EIK
	KIB+0q5IeoWJV+95HQf6PO1/9had2W/fybDhqxoPXMjnGScMoZdLhJ+OKglpSLbSEs+VzjwD9nr0b
	qjO61STD8KCMk3m9fosBpIk4ATbqXltZabXfmQgct2oLJg+jJjOMT3qvju5Lg2P4UBmlI1tbvhGbb
	4pKfhXfHQ5nW/F9oFNTtnNVqsutodaerl05oORbETSyQ26DCWmQ0SGNngFdSqMe1Tuie31OGp8NX2
	cTMZC1EQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqc-00000004eUy-1kfJ;
	Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-0000000061w-1JuJ;
	Tue, 24 Nov 2026 23:22:47 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
	kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paul Durrant <paul@xen.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Anthony PERARD <anthony@xenproject.org>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Hui Peng <benquike@gmail.com>,
	Mark Syms <mark.syms@citrix.com>,
	Feifan Qian <bea1e@proton.me>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v1 03/21] i386/xen: Free Xen vCPU timers when a vCPU is destroyed
Date: Tue, 24 Nov 2026 23:22:29 +0000
Message-ID: <20261124232247.23169-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232247.23169-1-dwmw2@infradead.org>
References: <20261124232247.23169-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

kvm_xen_init_vcpu() allocates the per-vCPU timers with the CPUState as
callback opaque, and nothing freed them on vCPU destruction. So a guest
could arm the periodic timer for a vCPU (VCPUOP_set_periodic_timer
always reaches QEMU; the kernel doesn't handle it) and eject that vCPU
via ACPI hotplug, leaving the armed timer pointing at a freed X86CPU.

Free both timers in kvm_xen_destroy_vcpu(), called from
kvm_arch_destroy_vcpu(). That runs under the BQL, as do the timer
callbacks, so it cannot race an in-flight callback. It *can* race a
timer hypercall from another vCPU — hypercalls don't take the BQL,
which is why xen_timers_lock exists — so clear the pointers under that
lock and have the periodic timer paths return -ENOENT when the timer is
gone, as for a nonexistent vCPU. The singleshot ops act only on the
calling vCPU, so cannot race its destruction.

Also move the timer_del() in do_set_periodic_timer() inside the lock,
where it should have been all along.

Fixes: CVE-2026-123069
Fixes: b746a779264f ("i386/xen: handle PV timer hypercalls")
Reported-by: MyeonghunPak <https://gitlab.com/mhun512>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4098
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 target/i386/kvm/kvm.c     |  6 ++++++
 target/i386/kvm/xen-emu.c | 36 ++++++++++++++++++++++++++++++++++--
 target/i386/kvm/xen-emu.h |  1 +
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 76528f1123f..302621f30af 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2556,6 +2556,12 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
+#ifdef CONFIG_XEN_EMU
+    if (cs->kvm_state->xen_version) {
+        kvm_xen_destroy_vcpu(cs);
+    }
+#endif
+
     g_free(env->xsave_buf);
 
     g_free(cpu->kvm_msr_buf);
diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 7337561b159..67d1379e024 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -276,6 +276,28 @@ int kvm_xen_init_vcpu(CPUState *cs)
     return 0;
 }
 
+void kvm_xen_destroy_vcpu(CPUState *cs)
+{
+    CPUX86State *env = &X86_CPU(cs)->env;
+
+    /*
+     * This runs on the vCPU's own thread with the BQL held, and the
+     * timer callbacks run from the main loop thread also with the BQL
+     * held, so freeing the timers cannot race against an in-flight
+     * callback. It *can* race against a Xen hypercall from another
+     * vCPU targeting this one (hypercalls are handled without the
+     * BQL), so clear the pointers under xen_timers_lock to let those
+     * paths observe the vCPU's demise.
+     */
+    QEMU_LOCK_GUARD(&env->xen_timers_lock);
+
+    timer_free(env->xen_singleshot_timer);
+    env->xen_singleshot_timer = NULL;
+
+    timer_free(env->xen_periodic_timer);
+    env->xen_periodic_timer = NULL;
+}
+
 uint32_t kvm_xen_get_caps(void)
 {
     return kvm_state->xen_caps;
@@ -1079,10 +1101,15 @@ static int do_set_periodic_timer(CPUState *target, uint64_t period_ns)
     CPUX86State *tenv = &X86_CPU(target)->env;
     int64_t qemu_now;
 
-    timer_del(tenv->xen_periodic_timer);
-
     qemu_mutex_lock(&tenv->xen_timers_lock);
 
+    if (!tenv->xen_periodic_timer) {
+        qemu_mutex_unlock(&tenv->xen_timers_lock);
+        return -ENOENT;
+    }
+
+    timer_del(tenv->xen_periodic_timer);
+
     qemu_now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     timer_mod_ns(tenv->xen_periodic_timer, qemu_now + period_ns);
     tenv->xen_periodic_timer_period = period_ns;
@@ -1120,6 +1147,11 @@ static int vcpuop_stop_periodic_timer(CPUState *target)
 
     qemu_mutex_lock(&tenv->xen_timers_lock);
 
+    if (!tenv->xen_periodic_timer) {
+        qemu_mutex_unlock(&tenv->xen_timers_lock);
+        return -ENOENT;
+    }
+
     timer_del(tenv->xen_periodic_timer);
     tenv->xen_periodic_timer_period = 0;
 
diff --git a/target/i386/kvm/xen-emu.h b/target/i386/kvm/xen-emu.h
index fe85e0b1958..467b9f088ae 100644
--- a/target/i386/kvm/xen-emu.h
+++ b/target/i386/kvm/xen-emu.h
@@ -25,6 +25,7 @@
 
 int kvm_xen_init(KVMState *s, uint32_t hypercall_msr);
 int kvm_xen_init_vcpu(CPUState *cs);
+void kvm_xen_destroy_vcpu(CPUState *cs);
 int kvm_xen_handle_exit(X86CPU *cpu, struct kvm_xen_exit *exit);
 int kvm_put_xen_state(CPUState *cs);
 int kvm_get_xen_state(CPUState *cs);
-- 
2.43.0

