Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE023AAF54;
	Mon, 31 Aug 2026 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212240; cv=none; b=exVXW4Ys/H5/VutAGjkbRVPpveNmStwFwKKc7U4rcfHWUXTiobslcxDj99Ki0AfoRtrKN0fidGnmO6K6H+UtemPTETznP0UMaTtOBLyuBK2+fCN0JbHgqKTBKG9Bsb+3sxaJ61yFR7PeI4UfynTsRqVYwqFgU6caRIKlPkrvL0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212240; c=relaxed/simple;
	bh=l4Vw9V2R06mxcI33cmd7E+2/nIkTuAYeolBEMyEb71A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeycpA2F2whVvtehKdzoCnNy6RJ9qzRccosmKwCl3u24aKDcgNBvQVCLQ/rq4DjbCgYGYI+aKpAFf7ujTjg7ZBy4idoCUrz7G0a0l7xvXQl6RegyqjEBsQbi41znLeQgJ5PZ0QLThBNoYQOd0oF10bnst31tBUEe2iqxXBuryCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YKseSYvn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YKseSYvn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OEgd2NwKsxi42P75H3cbNLJJgy0nzXZ44aA+uvUXLJI=; b=YKseSYvn/kQ70PJjIJjLVaGwc9
	0gq3dpUjQmhDDOENOzrEYQpk2wmYG9oCqtLN1VE2N9iVeXpF2kD+cBoUN35qbvPUHslpBcMkBZgwl
	p0jEv0BkoKQFP4nG0gMsa2Hh536su2O3wE97aWIkm5ktmIHvEVS/X56tfew0riIeq2RpGcBFJ23QM
	PYEaCqjdQnB9rOvbGELaCFF9tDWHw9zYp/IB79gfU+5LutQGHqve0xHuC4PlzntNlHhN0QdYYjpEM
	MEjMlC71xsfcNiCJEZ52bAPsND3bndYPyj9CDiAJoQqKaBSfcyzDvZ6o+2Q9jlZegzkSw/Vi8X+CU
	ZOqieYlw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x19gE-00000003sux-20RT;
	Mon, 31 Aug 2026 21:36:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x19gE-00000000LCy-18vL;
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
Subject: [PATCH v3 06/13] KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration
Date: Mon, 31 Aug 2026 22:26:37 +0100
Message-ID: <20260831213632.81023-7-dwmw2@infradead.org>
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

Xen's map_guest_area() enforces that vcpu_info is aligned to
sizeof(xen_ulong_t). KVM has no such check, allowing a guest to
register vcpu_info at an arbitrary byte alignment.

Enforce unconditional 4-byte alignment regardless of the current
shinfo mode. This is sufficient because subsequent commits ensure
that all locked atomic operations on vcpu_info fields use at most
32-bit accesses. Return -ENXIO on failure, matching Xen's
map_guest_area() behaviour for unaligned requests.

Originally observed in review of an unrelated patch:
https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel.org/

Cc: stable@vger.kernel.org
Fixes: 73e69a86347a ("KVM: x86/xen: register vcpu info")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel.org
Assisted-by: Kiro:claude-opus-4.6-1m
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 5eb23127e74e..941099ed50c9 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -941,6 +941,10 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 				break;
 			}
 
+			r = -ENXIO;
+			if (!IS_ALIGNED(data->u.gpa, sizeof(u32)))
+				break;
+
 			r = kvm_gpc_activate(&vcpu->arch.xen.vcpu_info_cache,
 					     data->u.gpa, sizeof(struct vcpu_info));
 		} else {
@@ -950,6 +954,10 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 				break;
 			}
 
+			r = -ENXIO;
+			if (!IS_ALIGNED(data->u.hva, sizeof(u32)))
+				break;
+
 			r = kvm_gpc_activate_hva(&vcpu->arch.xen.vcpu_info_cache,
 						 data->u.hva, sizeof(struct vcpu_info));
 		}
-- 
2.55.0

