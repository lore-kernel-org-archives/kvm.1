Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849B3DEAEC;
	Wed,  8 Jul 2026 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492471; cv=none; b=QHhzH6GhHE2LquO2LpGAz4QiW0w8FSehzJKoce5Izbxhu+eukP+YljIizomIAFLZWR1jlBwYARltjajxFuKYDtc2SSsmaIJiA+rBqOzHm1j2qZkhnXLLyftUR7SwoVkH8CGfAXbCYqmSSwqNAXgWcXU+/D5PyLJIF8Eht1grbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492471; c=relaxed/simple;
	bh=/IB9Aj78qwvB31Dyv1TdWyZ9W6ZFeT+jIiVpiTRdw5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7jxUcl+gbFD5cMf9bng2xh6AOSNmQ36Z924t4cpLADHUolilQ/wiPe6UZ7phwShsL8wW0CVtCrd5TU19ZMcgE6SQJH1ksPql3nj9VDtjXKJGi2wMU/GxAlhrbv4x4bU6dJE3jpgtdk7AIQBB1hPi4f0vgA4xwjSeTUpdyXlix0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afiGWhg7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afiGWhg7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5D01F000E9;
	Wed,  8 Jul 2026 06:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492469;
	bh=kgk0XRPkH5eCQvrqwZ6QBXJjJHL/a36ev7XYctnP59Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=afiGWhg7uFaQwPfXk17BJ9ujB//KeHbZFlViFUYyR8ot4oZXumyMuFO8lQABWSRqk
	 4xclES2s7EwZDJkm3TzjqICWBxUP0xAsC0wk5X6tizY/KwksUHl52rKEVFOcNNDdXn
	 Ai8kQO0++JCYKvUhI1a2mKVwQW8wyXAFz5c3v7P86lftTzbdWFlTrqBw1IWu0kc/CW
	 qVpeUty2ScGjz/KfSo0mpYzIM0NP5WFIxze+5RTBSHHQCiCYCk2ir+7KZavpPOwxQG
	 LNy4HvYgjJyxLkW1KltpxfWPLC2b8ezlZ1g4wIHsZoie20yh8dcIyydwJ75iQr59sm
	 M8tAVWGn/Lu5g==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>
Cc: <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH v3 17/27] KVM: SVM: Do not intercept SECURE_AVIC_CONTROL MSR for Secure AVIC guests
Date: Wed,  8 Jul 2026 12:02:15 +0530
Message-ID: <6fee207b64997da3ded9c1a0de37592eef6a2471.1783490022.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783490022.git.naveen@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

SECURE_AVIC_CONTROL MSR is used by the guest to configure and enable
Secure AVIC. In order for the guest to be able to successfully do this,
the MSR access must not be intercepted.

Co-developed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Co-developed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/avic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index bf701e604a85..6b3983d4f45e 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -437,7 +437,9 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(svm->vcpu.kvm);
 
-	if (!snp_is_secure_avic_enabled(svm->vcpu.kvm)) {
+	if (snp_is_secure_avic_enabled(svm->vcpu.kvm)) {
+		svm_disable_intercept_for_msr(&svm->vcpu, MSR_AMD64_SAVIC_CONTROL, MSR_TYPE_RW);
+	} else {
 		vmcb->control.avic_backing_page = avic_get_backing_page_address(svm);
 		vmcb->control.avic_logical_id = __sme_set(__pa(kvm_svm->avic_logical_id_table));
 		vmcb->control.avic_physical_id = __sme_set(__pa(kvm_svm->avic_physical_id_table));
-- 
2.54.0

