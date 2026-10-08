Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D9296BD2;
	Thu,  8 Oct 2026 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418485; cv=none; b=JeuFAku29H6XFVspf8UKj10SgKqmGkbxJg4qxwqn5tMzfHXQceTQxnkG4HXXUyH1EJ/aAkbsDdN+F3YJwVpe8hSDGNp2wIiLDwLxOnENkbqX5QAJfEbneiMvtmCUJH25k14O84/9r5IaJTHkvvKlis8U/b1VtNSZxFWvr+oOo0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418485; c=relaxed/simple;
	bh=ytASzjmCTrRVlP/3wK4lc7UhZVsmVK3sIdkremiya8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCxmvjIqVJ6+9LR4uMQqRUxV7Bs9Cr+3Dlrj5ETavHiJDq82Z7nNGvQFIKPHyCErW55Nr7RZULYvZLH6Hh9LXv/cBlHq8b+Gu9ad+NiwSS/q1yjGkE8YhcIy0/zk77X4qN8c66/qkqD29R9nd5t4+nBuM4EzNkNrkL58b06VTCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neZcwZ0E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neZcwZ0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC2D1F000FF;
	Thu,  8 Oct 2026 00:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418483;
	bh=N3BDfxMqgunXQam39bIhdeeFUXMT3+sSwtOm0pD1OPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=neZcwZ0ELLx86wlhz1EcLtjyJzHF0G9ehY4T4uBZmLl9tuYUKrn3olaeaVjUCt49Q
	 Lzj40Ras+ztv7TdC8vfZ+YcqsXLq4x3CW8TtgificF+IDrQQtAnF3nG+z+/PXHw1Px
	 HmWU6MnO+qB2bhMR2Y+N2fMDSYP+0K2thBrtjQqAZIs5NXyo7czhYxbgT3s36P1HF/
	 oLsDy+0ez+6/Rss3S9vMa2MCKvtNU2kc/u/PSdK13ejqKT0FvuykN6w9O//fiKN4lD
	 222hN/MEgZKzaYJxN5OaK+SvwTkYlFvvbjNpnWYs4+dDj5AlB7dYauICjI9GWmWO6H
	 gsaaI2d57Xb7w==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 09/29] KVM: SEV: Explicitly initialize the per vCPU ASID on SEV VM migration
Date: Thu,  8 Oct 2026 00:14:05 +0000
Message-ID: <20261008001425.2458927-10-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261008001425.2458927-1-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly initialize svm->asid on the destination vCPUs as part of SEV
VM migration, before calling sev_init_vmcb() to make sure the per-vCPU
ASID is initialized before the VMCB. This is currently unnecessary as
sev_init_vmcb() initializes the per-vCPU ASID anyway, but will be needed
when the ASID initialization is moved to vCPU creation.

Add a helper function for the ASID migration as more changes will be
needed with incoming changes.

Note that svm->asid is left as-is on the source vCPUs, even though the
ASID now belongs to the destination VM. Clearing it would be a nice
hardening measure, but it is not as simple as clearing src_svm->asid, as
the source and destination VMs do not necessarily have the same number
of vCPUs (e.g. for non SEV-ES), so NULL-handling would be needed in a
couple of places. Leave it alone for now.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 706a91db7b44a..0fbb72d57e6da 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2032,6 +2032,12 @@ static void sev_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
 	atomic_set_release(&src_sev->migration_in_progress, 0);
 }
 
+static void sev_vcpu_migrate_asid(struct vcpu_svm *dst_svm,
+				  unsigned int asid)
+{
+	dst_svm->asid = asid;
+}
+
 static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 {
 	struct kvm_sev_info *dst = to_kvm_sev_info(dst_kvm);
@@ -2096,6 +2102,7 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 	kvm_for_each_vcpu(i, dst_vcpu, dst_kvm) {
 		dst_svm = to_svm(dst_vcpu);
 
+		sev_vcpu_migrate_asid(dst_svm, dst->asid);
 		sev_init_vmcb(dst_svm, false);
 
 		if (!dst->es_active)
-- 
2.56.0.360.g66cac248cb-goog

