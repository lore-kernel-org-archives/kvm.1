Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C13890E7;
	Fri,  8 May 2026 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264261; cv=none; b=g0OcH6OOGREk9hV8fB82Dvop/aY3rzXSVjf2jrwZSSGNnxUG0wHwtgwhbkPkqEyrjOyIYO0jQ3omtR6j7aeu+m48cCrM1zsbH5wlOBkWfM8YxzeW+zoFp51/u0vC6Ro17zUl0R1NmMGzc0jRi2Jf4SKieyLOQnSnl9/nqn5HLik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264261; c=relaxed/simple;
	bh=+Q8fYgfGx0JQyWahkuakw0voj2ae6I7/Wap02lr1D/U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAlStTztwbzZi2LazhtmlU7NT8YiGlEjN7V5gnk6ibsxR1/XvVCdbljAVyCmHduoUF7fC6u4L5PbpOnDwyG4HxlCLRyOCvEqEYiqgygl794cIxHkv7ZJhhpN4fGkmS5x0jnYV/0jsUEXcghN1X0i8G0H34nUhoxJaKjcpA24AwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VO0DdZJd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VO0DdZJd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=kT9LrUUPvgw7yF7JUGVt2eIItVMRgHFKo8Fq70KxKGs=; b=VO0DdZJd2SLjQdm0Rr2aX2nCF6
	aaUqJRYAUfbnYVGyvCMoMa/Vo472SGHURL4S40xOFRmg00YjlKY3RL9zZNpkmEm7gxozODJBtHLAM
	foJYRqOzkggps/J62IKSTHOOOQfmMh6WvfZW7JulKUjXSw8zRNY1KbTIzNRAJ13ZQvxzascS4pTvA
	B6qvusgYe+6cu+YYrGH0w9CwP1HeJ9AHTJH0cv3orw7AaDWCyZSVnORH1zzUq7f11vyAw//mzWdVS
	dQsgeg4Oq8QtBcpQ+EEYlAHKJNDaETjsVHp/oy6gTyumUg2YDlwkj7Qy4f6huXn9i91+Tu4dAddqx
	dH5qyRHg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLPlH-00000004XFL-2CuA;
	Fri, 08 May 2026 18:17:20 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLPlH-0000000DYYt-1BgU;
	Fri, 08 May 2026 19:17:19 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paul Durrant <paul@xen.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Mauricio Faria de Oliveira <mfo@igalia.com>,
	kernel-dev@igalia.com,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Subject: [PATCH 5/7] KVM: x86: Remove unnecessary irqsave from kvm_setup_guest_pvclock()
Date: Fri,  8 May 2026 19:10:07 +0100
Message-ID: <20260508181717.3230988-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260508181717.3230988-1-dwmw2@infradead.org>
References: <20260508181717.3230988-1-dwmw2@infradead.org>
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

kvm_setup_guest_pvclock() is only called from kvm_guest_time_update()
which runs in process context (vcpu_enter_guest or ioctl). There is no
hardirq path that takes the GPC read lock for pvclock, so irqsave is
unnecessary.

Convert to plain read_lock()/read_unlock().

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ae71f28cc1c5..e62f4a9ad334 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3270,18 +3270,17 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 {
 	struct pvclock_vcpu_time_info *guest_hv_clock;
 	struct pvclock_vcpu_time_info hv_clock;
-	unsigned long flags;
 
 	memcpy(&hv_clock, ref_hv_clock, sizeof(hv_clock));
 
-	read_lock_irqsave(&gpc->lock, flags);
+	read_lock(&gpc->lock);
 	while (!kvm_gpc_check(gpc, offset + sizeof(*guest_hv_clock))) {
-		read_unlock_irqrestore(&gpc->lock, flags);
+		read_unlock(&gpc->lock);
 
 		if (kvm_gpc_refresh(gpc, offset + sizeof(*guest_hv_clock)))
 			return;
 
-		read_lock_irqsave(&gpc->lock, flags);
+		read_lock(&gpc->lock);
 	}
 
 	guest_hv_clock = (void *)(gpc->khva + offset);
@@ -3306,7 +3305,7 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 	guest_hv_clock->version = ++hv_clock.version;
 
 	kvm_gpc_mark_dirty_in_slot(gpc);
-	read_unlock_irqrestore(&gpc->lock, flags);
+	read_unlock(&gpc->lock);
 
 	trace_kvm_pvclock_update(vcpu->vcpu_id, &hv_clock);
 }
-- 
2.51.0

