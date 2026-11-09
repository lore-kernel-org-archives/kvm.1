Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214139;
	b=tFHp9LhmU3RSzNx4Mgm0FiShH+cRNLBoLlhPlZCGlRihSsB+x2RQHlMfmayWnoLbvcUD
	 6DctA+K2KNe9eDtxELteL0w5YdISNdLwPeY1g4Njt5vDOJ7p922jS+gpGvM0ENcUsmOMd
	 kUXKegcqUAVhryqFwlbb91zC9swgdvUA2E5GoqTC+CikWGQN39AlXhxnOiScgRbUkLxkO
	 ggkP+23BsbE8GFMrGq+oUuW9C0etd9aiCvahP4bHE8XIEaUajah/AwHZD2XMWNDQtFwiA
	 USvJ4uLuv+bYFtuxlAlNIbAudbR7lChqX/FY4Z5pOwTN3Q1hO0wFJirhOV4QOszO8bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214139;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n7dKS3uLxqz3hFWxQ/Hr/z79HJ4aXd4+1+IODE3lfqg=;
	b=IUDXCTHt4SJ05njWgJ7/la2fyogMMJiFZiBZ3AR9PAnLHX1g+fXRQmR3DRvr6PZv4Hdl
	 FreW14cIpTI85Ti2j69YnXIFuLrE+GXYYmIEpWRg0WRHFCmcWNDDjzjmTuqBDqm1U4h9X
	 8CI5r9+mwdcrpNoO85alhiSxL02SWE5l73e2Y3cqgrRHUfmYXG47N4BQJGLld55Gua9tR
	 KdWWupsrpcfUUCoKAjdVNiLeDe9rFSsK82wD7N7TkpJQWzS3yqYIvNMcKCB0BHASyYDIA
	 zEGqbjorGmTn1vk5GRzl79f4mqckzU1oB/4As5EB+y0wQXFekClQv55+KmCz3FIBExg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JYmoB1rv;
	arc=none smtp.remote-ip=95.215.58.105
Received: from mta1.migadu.com (out-105.mta1.migadu.com [95.215.58.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B82606A333
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 08:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93B82606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JYmoB1rv
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZJp1sWID1Y8h4yq9sHvxEkK5gbfl1wOQbzOgvALLC6k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794214136; v=1; x=1794818936;
 b=JYmoB1rvb1NwrRmhDmfRkFPQsb7Ofvk+pfQwPzft0tj53oNTU9Q2T2h959A+ZfnOr1izEMM1
 c7+Mei6o3PKNMYEZ57XqIUhxHCCE44FJsU1fXN17A64PbOvHKMmGm0XzHmLzZ1mRBbQCTK7TfZe
 GIEHXnvnMo+r1HKdpcklITR8=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f659de905a07cf78;
	Mon, 09 Nov 2026 08:48:56 +0000
X-Mizu-Trace-ID: f659de905a07cf78
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Quentin Perret <qperret@google.com>,
	Fuad Tabba <tabba@google.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/19] KVM: arm64: selftests: Inject an abort before a vCPU's first run
Date: Mon,  9 Nov 2026 08:48:37 +0000
Message-ID: <20261109084854.840576-3-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109084854.840576-1-fuad.tabba@linux.dev>
References: <20261109084854.840576-1-fuad.tabba@linux.dev>
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

KVM commits an external abort injected with KVM_SET_VCPU_EVENTS
immediately, even before the vCPU's first run. For a normal VM on a pKVM
host that path panicked the hypervisor until commit a2bb5f5c67a95
("KVM: arm64: Pin the host vCPU before adjusting its PC under pKVM"). No
test injects before the first run.

Add one, checking that the guest takes the abort at its entry point.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 .../selftests/kvm/arm64/external_aborts.c     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/external_aborts.c b/tools/testing/selftests/kvm/arm64/external_aborts.c
index 1a858d0d82968..45c9300b2ca0e 100644
--- a/tools/testing/selftests/kvm/arm64/external_aborts.c
+++ b/tools/testing/selftests/kvm/arm64/external_aborts.c
@@ -113,6 +113,26 @@ static void vcpu_run_expect_sync(struct kvm_vcpu *vcpu)
 	__vcpu_run_expect(vcpu, UCALL_SYNC);
 }
 
+static void test_sea_before_run_guest(void)
+{
+	GUEST_FAIL("Guest ran before taking the injected abort");
+}
+
+/* Test that an abort injected before the vCPU's first run is taken at its entry point. */
+static void test_sea_before_run(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm = vm_create_with_dabt_handler(&vcpu, test_sea_before_run_guest,
+							expect_sea_handler);
+
+	expected_abort_pc = (u64)test_sea_before_run_guest;
+	sync_global_to_guest(vm, expected_abort_pc);
+
+	vcpu_inject_sea(vcpu);
+	vcpu_run_expect_done(vcpu);
+	kvm_vm_free(vm);
+}
+
 extern char test_mmio_abort_insn;
 
 static noinline void test_mmio_abort_guest(void)
@@ -420,6 +440,7 @@ static void test_serror_amo(void)
 
 int main(void)
 {
+	test_sea_before_run();
 	test_mmio_abort();
 	test_mmio_nisv();
 	test_mmio_nisv_abort();
-- 
2.47.3

