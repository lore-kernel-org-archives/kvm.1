Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E53AAF57;
	Mon, 31 Aug 2026 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212242; cv=none; b=KdTltqBcVX7eGDMtOXccg4MMWP5ii7AtdjdfRaG6zf/OCK2HeTtvs/vgvyMI2bxKtMn3lqjP35G5STWQHYmDlrnTIed39dsJC2L19kuFbe4EuQkTPde1kc2EhZcyhCQQTJ7WvV4iCjKMpWEXkcWvNH8O84Vpl+eRhgXNdVhmkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212242; c=relaxed/simple;
	bh=zyAx8eZ13GDhnrcrqG2fUVmM7Gop0NfU6zbthdEU0A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuFlQFuq6tWA2yB841Q6hng4IXxWLkgsgYlsdJWIPE2SJa7ZAFIw50PpgEm9moWEUnLT3TvHXAS/pJK0f8+xlqP0/p/6x51/k4h4Vwx+eKmUvQh1UyX2K3YZVrUQGZa7Hn3JTA7sr8ShPQzFRIZTgb7rex7laKEGI2CpKisEM/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I/G1/hFg; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I/G1/hFg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yLC782TRJZ0oX+soOVc4AY0IvW1m29fq17tbF18Z8kQ=; b=I/G1/hFgHNfB7/TJopLPC11E5t
	jbf1KP32VFXwqCeJ6yh2lV7Q7WJrO5CJYw3jfRTL8pOSYDsNqK6cN7u8EjgdTEq3vmiUR813QLjwB
	Upm+PKE6fMxXQi5td13KQ8uFaoxN2JzZ3YBKad/F0NC+Jwys/2077aijMt82/M52kqceXDYuJHmjz
	gli9zwG/msBeoas7sTrHbpbANd48ud5EvYpANgzbCnLXPBuOCxmygFOXz04HaXAwqS/jwyLgYssmq
	OsaxqTFeFvGzHRs2nxk4p1oPDBkuUVdYgyG0rEtr2IBd3XQCsou1j1viyfyBNy94E33K0uS5Ft84u
	2W43YGGQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x19gG-0000000AKcA-31gn;
	Mon, 31 Aug 2026 21:36:41 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x19gE-00000000LD6-1Vj5;
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
Subject: [PATCH v3 08/13] KVM: x86/xen: Use 32-bit atomics if vCPU's evtchn_pending_sel isn't aligned
Date: Mon, 31 Aug 2026 22:26:39 +0100
Message-ID: <20260831213632.81023-9-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: Sean Christopherson <seanjc@google.com>

When propagating pending Xen events from KVM's "cache" to the guest-visible
structure, use two 32-bit atomic operations to do the bitwise-OR into the
guest-controlled structure if the structure isn't 64-bit aligned, i.e. if
the guest registered its vcpu_info in 32-bit mode and then switched to
64-bit mode, in which case using a 64-bit atomic OR will generate a
split-lock #AC (if enabled).

Opportunistically isolate the clearing of the bits from KVM's cache, as
that structure is KVM-controlled, i.e. is guaranteed to be 64-bit aligned.
This will allow dropping the open-coded inline asm blobs in the future.

[dwmw2: Cast to u64 before shifting; evtchn_pending_sel is unsigned long,
        so >> 32 is undefined on 32-bit even though the branch is
        unreachable there]

Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608071502.rYOi3Pg8-lkp@intel.com/
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index aa49b45dd8dc..b0fa74f2cbee 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -679,13 +679,28 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 	if (kvm_xen_has_64bit_shinfo(v->kvm)) {
 		struct vcpu_info *vi = gpc->khva;
 
-		asm volatile(LOCK_PREFIX "orq %0, %1\n"
-			     "notq %0\n"
-			     LOCK_PREFIX "andq %0, %2\n"
-			     : "=r" (evtchn_pending_sel),
-			       "+m" (vi->evtchn_pending_sel),
-			       "+m" (v->arch.xen.evtchn_pending_sel)
-			     : "0" (evtchn_pending_sel));
+		if (IS_ALIGNED((unsigned long)&vi->evtchn_pending_sel, sizeof(u64)))
+			asm volatile(LOCK_PREFIX "orq %[src], %[dst]\n"
+				     : [dst] "+m" (vi->evtchn_pending_sel)
+				     : [src] "r" (evtchn_pending_sel));
+		else
+			/*
+			 * The cast keeps the shift well-defined on 32-bit,
+			 * where evtchn_pending_sel is 32 bits wide and this
+			 * branch is unreachable anyway (this is inside
+			 * kvm_xen_has_64bit_shinfo(), which is gated on
+			 * IS_ENABLED(CONFIG_64BIT)).
+			 */
+			asm volatile(LOCK_PREFIX "orl %[src_lo], %[dst_lo]\n"
+				     LOCK_PREFIX "orl %[src_hi], %[dst_hi]\n"
+				     : [dst_lo] "+m" (vi->evtchn_pending_sel),
+				       [dst_hi] "+m" (*(((u32 *)&vi->evtchn_pending_sel) + 1))
+				     : [src_lo] "r" ((u32)evtchn_pending_sel),
+				       [src_hi] "r" ((u32)((u64)evtchn_pending_sel >> 32)));
+
+		asm volatile(LOCK_PREFIX "andq %1, %0\n"
+			     : "+m" (v->arch.xen.evtchn_pending_sel)
+			     : "r" (~evtchn_pending_sel));
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	} else {
 		u32 evtchn_pending_sel32 = evtchn_pending_sel;
-- 
2.55.0

