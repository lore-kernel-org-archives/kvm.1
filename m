Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8941F349;
	Tue, 11 Aug 2026 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441762; cv=none; b=tBzNs6Yd/fS+D8ITn4p+GqvzAhg9UzGC8dROivt0+3sAtd0ZAxGBN+f0kROncBqc1/o+99yXwP8/EBjIYSR0RWYKyao+9ZfWqYm/yvxtonJI9Dej//sHn7aBTAsWadx/AebDULo/RqqFADfMxQ/sV1OmV/QA+Kyb2dCm6tYiMmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441762; c=relaxed/simple;
	bh=uq1DNqYomQFdT1BWaGwFYLT/qILzlomnOSXCpumGnAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3XK0Me/WyE984JI2zOCWC4hJXzcJk4Yz9UOG3oQF3yrQQW9QLL4lX77AXDqScEbmY15zglEBQWkWq4i+mnjFV4965/cY0sGrEqKS70sRVcaYxzwUQ+H3XBNffqa4l584WA7pQ0kcwxqEJprIw9E371OAApLzEIwg7PVZnCa6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ovoen+Dl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ovoen+Dl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HkHpKY1j5MQrV8meOqWYb07EFaYUTTeiKv1xcOb7w90=; b=ovoen+Dliggi4EszTLf97NjiRT
	RjwuvdCPffjUZAD4oakIwVnd8zvxtsU28HwizWXNDbjorVKX5T7WB/0hSwsNXV+hmXuzA4UCUY6jc
	kSxdaHiCljAQWqCaYAxwAeku1aDwoIGesmtkgbM9Fe9maQVXYJZfjdkuN6CsxWTs4gCw8nsG1NmwC
	+R68JS2c1glKbHJ4QT2YK173RUWbUdJ5ufTjKVDGHwXWJM8IsvPeZYwAbLba0wpRgDEvBpi+jJmmP
	iM42yYweDIfvEk132Dcec5qQIdFjP6JUWWFF+xvcaMTwiSUw7Ix8GYvHUNeI959otuSaCppCZzP3H
	Sg1khRGQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wtj62-0000000EU1S-46H3;
	Tue, 11 Aug 2026 09:48:35 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wtj5z-00000000PjV-3qNk;
	Tue, 11 Aug 2026 10:48:31 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw@amazon.co.uk,
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
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/11] KVM: x86/xen: Use 32-bit atomics if vCPU's evtchn_pending_sel isn't aligned
Date: Tue, 11 Aug 2026 10:37:10 +0100
Message-ID: <20260811094829.98794-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811094829.98794-1-dwmw2@infradead.org>
References: <20260811094829.98794-1-dwmw2@infradead.org>
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
index c935651906ec..419b07fdaa3a 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -663,13 +663,28 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
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

