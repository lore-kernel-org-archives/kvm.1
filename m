Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.215
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782135;
	b=yklthcDLCL0ZpewETXAehbO5bAzPg3/rhmQjP88qH/PENPf+u0yGm6/5sA2cCY39AJvj
	 cTprTbCR4eqBcERZK6FrFqYvPpHljPRabeFWOpceos5JVNSOxCgdsuMbttFdKp1/xsI4O
	 3yfVPERlb2M8CBi0rHyrDfa+5suShwJAQNvkOeTiB1OW7rrE2P5yNLABCNNUS5Bzm7bbf
	 GfEbRZtKBA95b+xN/lnpSPCGeg1LD6eH4RjYp1GELpXdEC0hJnVD7ggSHzo3Q9XBD6HjC
	 2mlGy+aW4t5H9DKy51uS6GpgcKsBTaOjrCviDFM5ejR0Yzh16NMgi1V/M0267nbTl2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782135;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n7dKS3uLxqz3hFWxQ/Hr/z79HJ4aXd4+1+IODE3lfqg=;
	b=Qt9VpDTj1CgFwJUYr0qcH3f1mpJ2yAnO4gFePAF3Wi7X+/cw4w38pVIJ7prF1d8Jeswh
	 zlXwE9iVVKf4yXI/fqZW7JdIGBE49AT+doOuQ3iLqNaDNA2HVG9zRlDHspDK/TEUdMiyu
	 m+G0uSDfMryDmr8Tws19VXh+OXmQ3weLVb3a+SBVsFJjFEChx+WJLWmodZgy5X5oqzBWz
	 8ft5iHdsCqeiOjnpwE2TF9Tk6dj6nzY1WJ/L8+xsK1vaLebU+cQ3XPTrFi+6E+u1nweT0
	 QPmTNMZ2opY0PRvW1wZ+UcrEtV+5qj+2RjmWGXRL1R8oeVnlLmCjI25jJfCNPvM9dAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="T4d6Fo3/";
	arc=none smtp.remote-ip=91.218.175.215
Received: from mta0.migadu.com (out-215.mta0.migadu.com [91.218.175.215])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E596D606A32F
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 08:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E596D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=T4d6Fo3/
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZJp1sWID1Y8h4yq9sHvxEkK5gbfl1wOQbzOgvALLC6k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793782132; v=1; x=1794386932;
 b=T4d6Fo3/hNK2uXQwUMot6YCj/ZodRvUBFeb4ywWwwFOHQd+itPMsvqE0eoQFVuWo4k4ZxXAH
 VXJxBPVgI1or6TMyiVonLMWqIPE3PdDPPrTEHiXOS+trnFekxJc11CSwT8Nv+7FSCn9XkGlz8f0
 cY2klbT9eiG/jGq6/4tqq70g=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fbd8c9a40e5de126;
	Wed, 04 Nov 2026 08:48:52 +0000
X-Mizu-Trace-ID: fbd8c9a40e5de126
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>,
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
Subject: [PATCH 01/16] KVM: arm64: selftests: Inject an abort before a vCPU's first run
Date: Wed,  4 Nov 2026 08:48:27 +0000
Message-ID: <20261104084842.132944-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104084842.132944-1-fuad.tabba@linux.dev>
References: <20261104084842.132944-1-fuad.tabba@linux.dev>
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

