Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631229;
	b=j/ouQdsCaHJJ/MRQTSoB+Nr62Z9Bciz2USZTWoiw3IeaSQY5UdbrWUwDundntnhR15ZI
	 IzQhFuC36B/qYCxg5B1qusvukAyGuRiU4iurWeKgisAFrqRcqat9ha8F7OQiNqXQW87QI
	 fFF5V1JsvtnoNAm4AUiIPzPekP8ZqeFY853uqfPKj7RnX1dXEdU+j5/KU4IddBGhsVTL+
	 QNc+acgPcDAoOGtjbb4KiLoGAYVcz8FqiB0/HWpyt91BgGJGaGVZYQIgojfPTUFmM3ZDR
	 /ftbV1mGWCsAvHmnH2bTmfcMxib4jOsSpq1quYfnfLujLzJ+SU8sinFk0PuwqOVxDyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631229;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4ApeS1dpxE/iXP7GhIQ/uP7arI7DrfHwE127tjX2Tls=;
	b=LbaGV1/kYeinqsh/Tra3xvwkl7zqkaoA/2vJ3+gs3zaAP65uKdFwXCvwDG1VTS+PJ6UO
	 L/1uJORremCYlw/mG2xH5BKlCZnT9GBTn26Xym6LyhchaqjBc/taq+aMdl3etKhekaefS
	 ZcmUPwKvzI6K6rSVQrpDUL8z8R0SHIUREKtk5HIWKmnZ4HrJWnlpxpqrXVp5S7rrImT2O
	 z+m6uBfp/OzeCDzOEcnESeh3s4L8/CVeebAsic7GSLI7SX2z1wZCz7oPwMNV/KD4kyyKD
	 yt6yRA22QtXMTrIUjj94cp3MTcFP7ycpDpXrrUwWj+zrG5PZmdj571Y+BIzCYLm/PYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6QM59HN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0D9606A321;
	Wed, 25 Nov 2026 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6QM59HN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA741F000C0;
	Wed, 25 Nov 2026 18:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631229;
	bh=4ApeS1dpxE/iXP7GhIQ/uP7arI7DrfHwE127tjX2Tls=;
	h=From:To:Cc:Subject:Date;
	b=W6QM59HN+UQvUnjADcWPdIQm0/rdmnE+SrlefTmW7C1QJnMCEqDSTE7RB7kJvS5Wi
	 Ssj1t32g7Ksr1eh72l4x0SKZ/JBMlWXg7+tthhHyJNLkoSRQZaZwps/6qOnGWgCbmV
	 PPeqrk2lvYUGPFpM3I7nQvT7KwK4CZo9ewaRwZdVDqrokOkMq3hMr7o7dT4WHqD7wQ
	 lWEjjOygGPuTKXmF1wFWHEmTL+wquilS40Q14uH22e5NcaTMOxCQutQkkyjik8KaSu
	 a6ThRDsdNld/fsAbKfVAUPbcAoVm35w0p9/kB79AtKhoZDotzNKmPBnF6M3P4e8sXD
	 6lO9TjL1QKsVg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 0/3] KVM: x86/pmu: Always defer PMU reprogramming on nested transitions
Date: Wed, 25 Nov 2026 18:27:00 +0000
Message-ID: <20261125182703.1694998-1-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.911.g883d8bcb20-goog
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Host-Only/Guest-Only bits handling was added [1], we went back and
forth between deferring PMU reprogramming vs doing it synchronously.

Deferring all reprogramming is incorrect, because on mode changes (e.g.
VMRUN or WRMSR(EFER.SVME)), this would only update the to-be-emulated
PMCs after the instruction is emulated, which would count the
instruction in the previous mode. Real AMD hardware counts instructions
in the mode they retire in.

We ended up with a hybrid approach where architectural mode changes
do reprogramming synchronously, but force-leaving nested defers it, as
it may not be safe to do it synchronously.

This mini-series unifies all nested transition paths by always
calculating to-be-emulated PMCs synchronously and deferring the rest
(e.g. similar to WRMSR(EVENTSEL)).

The motivation for the series was an unprotected SRCU access from
KVM_SET_SREGS -> svm_set_efer -> svm_pmu_handle_nested_transition() ->
... -> pmc_is_event_allowed(). The obvious/simple fix (and probably more
stable-friendly one) is to hold the SRCU lock in kvm_pmu_handle_event()
when reprogramming the counters. However, I think this is a nice cleanup
to have regardless of the SRCU bug.

[1] https://lore.kernel.org/kvm/20260527234711.4175166-1-yosry@kernel.org/

Yosry Ahmed (3):
  KVM: x86/pmu: Recalc PMC emulation when deferring counter
    reprogramming
  KVM: x86/pmu: Always defer PMU reprogramming on SVM nested transitions
  KVM: selftests: Set EFER.SVME via KVM_SET_SREGS in
    svm_pmu_host_guest_test

 arch/x86/kvm/pmu.c                            |  1 -
 arch/x86/kvm/pmu.h                            | 32 ++++++++-----------
 arch/x86/kvm/svm/nested.c                     | 10 +-----
 arch/x86/kvm/svm/svm.h                        | 18 ++---------
 .../kvm/x86/svm_pmu_host_guest_test.c         | 31 +++++++++++++++---
 5 files changed, 44 insertions(+), 48 deletions(-)


base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
-- 
2.56.1.839.g22a8290db9-goog

