Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACADE3DAADA;
	Mon, 12 Oct 2026 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848212; cv=none; b=FHuHqe7AmCJQliMDtI7D9RzqG6QPdojqESpBvoaHTpce6FRk9iemptlFAYoDuptE2bT+JY+j8IBosjFVDNfZcp4/ON/zfqUgM0e3C0ptbX9VCLa+X3USGcHPg0pJoVAVfx4mUefzmoyd/Vt3wdBZLE4yssd+Vbry6/GMpqnr/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848212; c=relaxed/simple;
	bh=Z+7HxNVVDEDUqQ0uraUYoplUjaNk1JkKpE2+S2rZ6Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQ7V+/Rk7lUFIL4fHbmU6h5BbzjJmInl1x9qz8LWczBjkIiJOwmlrwFzI/8b0ivIUKHzL8JHKq6h9jrAMqguQREB+kQ6yIbgQupD0A5+Yisqcu8WX0TAJu2Am5nztCWLUNAvsFYyTWTy0rIpW+Y3STiaVGj/kGS0kp7n84k/MrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbDGDc91; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbDGDc91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC231F0089B;
	Mon, 12 Oct 2026 23:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848210;
	bh=yn/l/jHVz0HxYxSKndt25mol6ON83bHd22MPf5anbuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZbDGDc91VwIH2sVKqFez1aG32f7TP/Iv6JRqUQTiFt3vrcrVEB2voz7uTxNHvNB0M
	 k5fi8gvUdqa54wS6M8jD+gaTzuHEZIQx3Hju49bApzaL493uvfpIuJHcA/73tOnwYN
	 PU5VzP/jB+RnCmY6OMuMy/TON734u4ZG8vMFCWZpxHUSKVJpr96kXpLJUbw47kiqN1
	 neEt4t/K/dexCCDOovy2/H9bOjcjiDJeTiMmL3omx4PBhiocvG/kLB6cQPF8WNUypv
	 GyDuGljBnPJcYM3URIDdi24uLZS0QgWvVUd8MeZp1mfYTNgqbNB6myaJw40obqvddN
	 yCVlZQ4DBboww==
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
Subject: [PATCH v3 09/27] KVM: SEV: Explicitly initialize the per vCPU ASID on SEV VM migration
Date: Mon, 12 Oct 2026 23:36:20 +0000
Message-ID: <20261012233638.2546339-10-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012233638.2546339-1-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
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
2.56.0.385.gd3acb90ef8-goog

