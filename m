Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D5527F4F5;
	Mon, 13 Jul 2026 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966229; cv=none; b=jXH2hhRDLiBjRVMKdHJfoaTgmp4bceTk8HKCO7CJFEdix3WOL/4C2UkwYvjNui0kUThNOag74LwXoXuU8aC8Hkxu2vgnH58MPyuElJgX0BPvhDNNLupkN4XSw8erlEG9uXkCGaiovg5lPvMEgYHBwTd0vyolLFrtwrb97tFWVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966229; c=relaxed/simple;
	bh=H8YvJPL8D/+XwbRhPG2zfGkOP+SCLc6sogqsvE/qL8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVIFlqFSw1rJzTB/N4B/xoooFJufrP805FC84QmhhiFyAY+G2KGMpLZ/Ed6GlA/BBg/EBn6xueijdEFv8+QKdpIcih/tXQCpJ7qlBNcaHRT2bqFa+HIB945kINA2ZwLvvPMTwH1Poq1ZSukNqfSRlz5ZzNimZoTuqUoUyKKx8TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAAVf0nh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAAVf0nh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49091F000E9;
	Mon, 13 Jul 2026 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966227;
	bh=mXZymBGM38r+PXU4iSlomN/r5INpz1Sz0LOtidC+pTI=;
	h=From:To:Cc:Subject:Date;
	b=oAAVf0nh0lMXRU5GbuFbnGQkjT0ZyRSrD7CzW+8ILBYzp3A8aztrl/jUayn1K+5g2
	 72VZeMuDptXS2VxRAc1I8JjUfPVmSEV9J88rc/AxG0OpylkvW6T8sTHip3fxV1Q0dh
	 IHY7UeKfVQUm1ZMN0t/nIg4S/wZEiMpGkZ62An6x+gZP5GPY78vSO940CI4zxKbHlg
	 oP5sTI5JLfODcSHdCnoag+EeeDqJnEYKfcWM4o5wKXN31IxBf3btmvOVOUwMW3TFvj
	 dRnJhN2a//rWPAAn7gyQXCUKCu1UH7N3xFl7H65WBIQsLowRmFqP27z066Kpzhf0wT
	 611sPlr3nUN9w==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 0/5] KVM: x86: Fix EFER reserved bits initialization
Date: Mon, 13 Jul 2026 18:10:15 +0000
Message-ID: <20260713181020.2735367-1-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3 of fixing EFER reserved bits initialization on vendor module reload,
and move them into kvm_caps. I reworked and reordered the patches such
that we go straight to reinitializing the EFER reserved bits, instead of
first re-reserving the bits on vendor init if nested=0.

The motivation for the previous approach was simpler backports, but
practically the fixes don't apply cleanly anyway to most stable kernels
due to EFER.LMSLE handling being introduced very recently.

v2 -> v3:
- Drop KVM_SET_SREGS* validity checks fixes, sent separately.
- Re-ordered and reworked the patches to re-initialize EFER reserved
  bits right away.
- Drop the per-vendor op for EFER caps initialization, instead move
  EFER.SVME and EFER.LMSLE handling to generic x86 code.

Yosry Ahmed (5):
  KVM: x86: Move enabling EFER.SVME and EFER.LMSLE to generic EFER setup
  KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported
  KVM: x86: Always initialize EFER reserved bits on vendor
    initialization
  KVM: x86: Reverse the polarity of efer_reserved_bits
  KVM: x86: Move supported EFER bits to kvm_caps

 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/msrs.c             | 21 ++-------------------
 arch/x86/kvm/msrs.h             |  1 -
 arch/x86/kvm/svm/svm.c          |  4 ----
 arch/x86/kvm/x86.c              | 18 +++++++++++++++---
 5 files changed, 19 insertions(+), 27 deletions(-)


base-commit: 3aec122bdcaf6f8c4ecfc7f6adf6773015ced676
-- 
2.55.0.141.g00534a21ce-goog

