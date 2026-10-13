Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6853F54EECB;
	Tue, 13 Oct 2026 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924514; cv=none; b=Pvu6rgS4797H1bJzaDUcbbruWEBiUvZ+LhInFqmFgrpKaQK28uYZeeoAq1/imKkyiOlfKc0/roWEuoeq9DTfo+7fB4HKfrPqzGpZU+Y/EdcDSF8k/LG2L5i1jr+ihnUyRU3G1kQiMya7bxyOLwpvK24DzfXwAl9UXKmtiw1U7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924514; c=relaxed/simple;
	bh=EnhxD+LWNnhWyE9YN2CMbuwe5f1Jhsf7zQTTGO2Dedw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kd7W1GBp1B9nukfRWKJpDBFDUpo75wrQaiKA7Lfladfybv/nioHKYf6/giLNVkLB5MLEgcTIoC2RflAdsh6ONJw8AJnJnvKTay1EU4o/ZI4y9xYfaYvhjbns0vfqNIBMPuDYxm5+oaerwD0kCjsVTUBkFjkBwh+Rwv/e1u2azyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ejH7M4Zs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ejH7M4Zs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2v5mBlVK392iL/Y43x3cPeO25GmK/+93NMJMoT0UAh0=; b=ejH7M4ZsbUYhoYFjsPnn1k6Jmk
	I6Bbaoq6l34h1+VP9LtzNd2cpxeqv6AlW08WnzDOKvaluDAwBHrLgD/KQZW8w3JF6dFZZUQCwsn0t
	CFS9VKQyeNpIFmdWtpzWnmEdJ/R+LvqHu9vtysn3qeIEpFmMur/+Kry6Cf9AE+yCpdETJHcwa46eZ
	xUzZ7PMYaHij4XaazSMpgfQji7RZNB6sRFlwtOtgcAoVpswoLz3P23uPXzyJKo5U0LL1jRQpIyd+s
	WCHxwmCfnjHr96y3UQEn7wJDiqMZz1TotA9OlaTi5jGNcH/kpNz+E+idQ52DHv+TKvY8Bobk3a/mc
	tcUj7ugw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGjQB-0000000G4C7-0wr6;
	Tue, 13 Oct 2026 20:48:28 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGjQ8-00000001uAU-3rs3;
	Tue, 13 Oct 2026 21:48:24 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 08/10] KVM: x86/xen: Don't dirty track "vCPU info" page
Date: Tue, 13 Oct 2026 21:48:21 +0100
Message-ID: <20261013204824.454208-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013204824.454208-1-dwmw2@infradead.org>
References: <20261013204824.454208-1-dwmw2@infradead.org>
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
would run afoul of the same issue that was fixed by
commit 55749769fe60 ("KVM: x86: Fix wall clock writes in Xen shared_info
not to mark page dirty").

This also covers the pvclock writes kvm_guest_time_update() makes
through the same cache; userspace assuming the page is always dirty
covers those equally.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/xen.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index f8162914d6c6..ef0d59ebc6a7 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -715,7 +715,6 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	}
 
-	kvm_gpc_mark_dirty_in_slot(gpc);
 	read_unlock_irqrestore(&gpc->lock, flags);
 
 	/* For the per-vCPU lapic vector, deliver it as MSI. */
@@ -2448,7 +2447,7 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 
 	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
 	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);
-	kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm);
+	__kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm, true);
 	kvm_gpc_init(&vcpu->arch.xen.vcpu_time_info_cache, vcpu->kvm);
 }
 
-- 
2.43.0

