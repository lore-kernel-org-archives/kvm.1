Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB97322A1F;
	Tue, 11 Aug 2026 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454575; cv=none; b=WZoFBRki7Etxi7PMHJnw3d2PLmG16BGhN6ERKF9fbnhbNsnX/LLTvt9JydtOsvAK3WlVjap/tGEzHOspzc2JfCe38uVM1HX35EwKb3BnHEdxABsSh23ktLXUeJ+8ePRMQKHBM2UwDoBld/0xJbANMjo7joLzG0UmdjLj3oRT16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454575; c=relaxed/simple;
	bh=V4aDRjWyUwTroHQeRzDrQcTmf0XJT8FUZsPZw6WqftM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLRP9NeC62OhvRSLf+f0wJCoukEvminTmZSzX5dSxE7ZqA4ygvf9JpcvcdE1L4BO0pY5wK3CHkZ/2VnKWgBCo1eGWMPlzuNMnvat/zR7ML5Lwz0AARbfSwTr3A8oESDKXYULQ0rrhZv1adlWueASUTEj+7VzvwEx2YSpqUUMkHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BSOINfUC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BSOINfUC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=LwRSUKXXSKjG5ftUYDBBrK8NlvPko6QM5e1CCzNNyAo=; b=BSOINfUCZkUGuxmqAtgtFfFWGc
	D5LHAIz8GqehtE3bQ8s14hcUcUn8q0cILlrzqrretFj7yp3GkmSusNHBCHLnR0IqNBH/5rxbageEf
	YKsmjudX05erlQgk44ZhnvSqueHZQouZZEfxyywIaJ5fXIS8ma5PUO5/pUZHxo3cIn8Yh+nqoEsLf
	2SNzgGlgasMwN7QSOCOwKK1pbrUaITnJxf03La1v6rGLwhnCW2cBkDnaVGV2VLZl7YiTkKW+z7KXF
	VrnlAVfme/BpB9P4n5vzA8o0I2mk+YGnB1TDxt1f3gMMXaRd2+w6fxIhz0D6OXIdpKH/4wW9qdELG
	S3fvDkVA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wtmRF-0000000EbSc-0uYh;
	Tue, 11 Aug 2026 13:22:41 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wtmRC-00000000Qlq-1oN1;
	Tue, 11 Aug 2026 14:22:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw2@infradead.org,
	paul@xen.org,
	joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com,
	ankur.a.arora@oracle.com,
	stollmc@amazon.com,
	paulmck@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	bigeasy@linutronix.de,
	syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] KVM: x86/xen: Don't dirty track "vCPU info" page
Date: Tue, 11 Aug 2026 13:49:54 +0100
Message-ID: <20260811132237.102400-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811132237.102400-1-dwmw2@infradead.org>
References: <20260811132237.102400-1-dwmw2@infradead.org>
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

Give the Xen per-vCPU info page the same treatment as the per-VM shared
info page, and never mark it dirty, as KVM clearly relies on userspace to
assume the page is always dirty.  While the page is marked dirty on writes
via kvm_xen_inject_pending_events(), it's not marked dirty when written by
__kvm_xen_set_evtchn_fast().

Furthermore, as was the case with the shared info page, writes in the event
channel fastpath may be done without an active vCPU, e.g. when called via
timer callback or irqfd injection.  I.e. attempting to fix the fastpath
would run afoul of the same issue that was fixed by commit 55749769fe60
("KVM: x86: Fix wall clock writes in Xen shared_info not to mark page
dirty").

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/xen.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index fab215a522be..5618e2ccf4c4 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -666,7 +666,6 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	}
 
-	kvm_gpc_mark_dirty_in_slot(gpc);
 	srcu_read_unlock(&v->kvm->gpc_srcu, idx);
 
 	/* For the per-vCPU lapic vector, deliver it as MSI. */
@@ -2375,7 +2374,7 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 
 	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
 	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);
-	kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm);
+	__kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm, true);
 	kvm_gpc_init(&vcpu->arch.xen.vcpu_time_info_cache, vcpu->kvm);
 }
 
-- 
2.55.0

