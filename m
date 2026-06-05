Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065753C73E5;
	Fri,  5 Jun 2026 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669854; cv=none; b=UMazw33FXSfcet7G9Z22fd9zW0h6q7GdOBGKoKV5k5pvvbtZa4L0zlVrPT6JbOUX4SojlRAjc9f4DyjJul32Ks3B33C3cUdHHikYqWy1acBiLrG7+/SdpJ0lMn0QntvcPoNYQkgrT3lATc3yMLWpk6rve0XqKTrRXuRk70OOQC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669854; c=relaxed/simple;
	bh=N+3z0mVSciqHtHuMOt12FJAryfFDA/1ly86ZaC5Sm3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpFGg4pD1GJJsKqbjSOQTG+BCkAdGR89FqN3m+5tMTZsDu+AEX1RQXwFCu9kqeFMHyu3KjwZuwwOBPOo86/y5TF8GGdY0ssr/M2qnFu8Qfn77dLnMhMQ2gfW+S/9iYgbD3QiACXJ9wwb9DQo0e/PAiMkvQ21druVApZCN+Ztcls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CLCoCM2/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CLCoCM2/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=s5dGgb2KywZyukUWTXvEMf+VLfy7xHDKLSJ2Rh8KmBc=; b=CLCoCM2/f9aP/w6r3/PcmVsmST
	c+wmL8IBbrWCw952nnw+yASzzf0IKO8w0hiIsF8R/HAub6ZN4tpccRwrwSFC501xsjLNyQxfqKl7x
	KpdHZN8PblgSQVJuE6W/12WVGmNZXWj6tTbM7PF6zO0++ZGYScFuIupMScxRcDWgJyYs773MBBfe6
	hwTtW+IUoLdTe7Plr8D70NNaaRuvlRcyzvEQzHrIXpC4ZIpFXrQasz6RPZYEFQBPyxIyFNxAybWXZ
	GBdbETGbKCZQFUzi9hP3w1CI1irBcfLj2scBqVkpjsuZqMF/0JnP8D50VtrHk1KClLMa0X1jroZ+A
	//6dHwjw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVVZG-0000000Fhro-2HKx;
	Fri, 05 Jun 2026 14:30:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVVZE-0000000013g-1x4R;
	Fri, 05 Jun 2026 15:30:36 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paul Durrant <paul@xen.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] KVM: x86/xen: Enforce alignment of vcpu_info registration
Date: Fri,  5 Jun 2026 15:17:31 +0100
Message-ID: <20260605143034.3603-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605143034.3603-1-dwmw2@infradead.org>
References: <20260605143034.3603-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Xen enforces that the vcpu_info GPA is aligned to sizeof(xen_ulong_t)
(8 bytes in 64-bit mode, 4 bytes in 32-bit mode) in map_guest_area().

KVM has no such check, allowing a guest to register a vcpu_info at an
arbitrary byte alignment. This can cause split-lock #AC exceptions on
hosts with split_lock_detect=fatal, since the event channel delivery
paths use locked atomic operations on evtchn_pending_sel within the
vcpu_info.

Add the same alignment check that Xen performs at vcpu_info
registration time, based on the current long_mode state. Return -ENXIO
on failure, matching Xen's map_guest_area() behaviour for unaligned
requests.

Like Xen, this allows a guest to register vcpu_info at a 4-byte (but
not 8-byte) aligned address while in 32-bit mode and then switch to
64-bit mode. Xen copes with this because it only uses 32-bit atomics
on vcpu_info fields, which is what subsequent commits will do where
necessary for KVM too.

Originally observed in review of an unrelated patch:
https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel.org/

Cc: stable@vger.kernel.org
Fixes: 73e69a86347a ("KVM: x86/xen: register vcpu info")
Reported-by: sashiko-bot@kernel.org
Assisted-by: Kiro:claude-opus-4.6-1m
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index f9085612e7df..ae0713718367 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -926,6 +926,12 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 				break;
 			}
 
+			r = -ENXIO;
+			if (!IS_ALIGNED(data->u.gpa,
+					kvm_xen_has_64bit_shinfo(vcpu->kvm) ?
+					sizeof(unsigned long) : sizeof(u32)))
+				break;
+
 			r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_info_cache,
 					     data->u.gpa, sizeof(struct vcpu_info));
 		} else {
@@ -935,6 +941,12 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 				break;
 			}
 
+			r = -ENXIO;
+			if (!IS_ALIGNED(data->u.hva,
+					kvm_xen_has_64bit_shinfo(vcpu->kvm) ?
+					sizeof(unsigned long) : sizeof(u32)))
+				break;
+
 			r = kvm_gpc_activate_hva(&vcpu->arch.xen.vcpu_info_cache,
 						 data->u.hva, sizeof(struct vcpu_info));
 		}
-- 
2.54.0

