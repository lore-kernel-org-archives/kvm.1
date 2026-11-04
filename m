Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782140;
	b=RDdbhuJovxtMwp8ue9ESGVwtvpsiB2Kf0jLcyaKWw5r6yWzMLcru+hOycFecvbEDbu3w
	 dM5jw+7I0oGIs1e+MVxltSsE1Fmdbkb1a5cra4gbBrSbMMj8zNqT8672Xnc4fLzDMhRVu
	 /lnNjClHRF7TmI1jBYYvy58TVYEAdGI6kHky9radRpS1HhwTEa0xrFr5KVb6pBj1YUCWc
	 xwc8tvwO9SWYAioSJ4uL27blqeiW5PRiyTFRWWa9zAKesalB6buCYY0XqqPCcXxz8cxMN
	 zNivh6XMcrpFV9M8ohmYdHUv28uCAWiUl8AwWHLRwshae9tle2AjPneh3MCNQijKIoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782140;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lHuHnqCqF6K6uaueK6Sr4c00lW3mD3+MLoiZXuZlni4=;
	b=ghPPoookHFxX/0LXSXXtMwlfHm30fAQzpC4zNvQQErsIcTcRHFp3MfIEMv88xoT5l5wE
	 n/p+wSO4IF8GQmUTa7fjPmtPTj3pnnnZ7V39Gd2VkmHZ7QXym6ZvB6k8vqI/6j/ZJ9i3v
	 b3F6b80vMoPNprG5S3NVsmOVLsvs8cXKEavkAo1IULbU7UjXbu6nMNihPZwhuHCbBuc1C
	 jFRxYiIMz0bK95h2lYv2F4QnS6nsc7Y7IvMD3CZpsOF+kgy9s7pv006Al6uZarGucBf7/
	 6SEcvqql/CQ8xEFe0cOVPgwsI5MhkNgiEedmgZLMtQUBg4GanRCgrUKPDtYcwQOVkPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k8mGENjt;
	arc=none smtp.remote-ip=91.218.175.221
Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A643606A328
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 08:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A643606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k8mGENjt
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cCLqiN/2yb0grwWK9kGanBFuqdVWEkSHBIBzeKIBjnY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793782137; v=1; x=1794386937;
 b=k8mGENjt6dpqYvnBkvT/loF7Zxaf3ScEyYErTu3eE+QxXOcDNiFhEVco2fqWxrsACR0kKJa3
 1R7OoXPvewqN2DBVVdOmm2wYkdK6PgiIcDMQ7W9OkmOD3cmvt0/KvI1IV8/toDTmyv/vBhvEU5i
 9uav8D7+ZITB93Tnjtqs3nak=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id afd5417ac097421f;
	Wed, 04 Nov 2026 08:48:57 +0000
X-Mizu-Trace-ID: afd5417ac097421f
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
Subject: [PATCH 02/16] KVM: selftests: Allow arm64 tests to create protected VMs
Date: Wed,  4 Nov 2026 08:48:28 +0000
Message-ID: <20261104084842.132944-3-fuad.tabba@linux.dev>
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

On arm64, the VM type passed to KVM_CREATE_VM carries the IPA size,
which the selftest library fills in. The library rejects any type a test
provides in vm_shape.type. A protected VM is created by setting
KVM_VM_TYPE_ARM_PROTECTED in that type, so a test can't create one.

Accept KVM_VM_TYPE_ARM_PROTECTED from the test, and add the IPA size to
it as for any other VM.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index d42e201eba763..96c1e70dba3d3 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -400,9 +400,10 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 	}
 
 #ifdef __aarch64__
-	TEST_ASSERT(!vm->type, "ARM doesn't support test-provided types");
+	TEST_ASSERT(!(vm->type & ~KVM_VM_TYPE_ARM_PROTECTED),
+		    "ARM supports only KVM_VM_TYPE_ARM_PROTECTED as a test-provided type");
 	if (vm->pa_bits != 40)
-		vm->type = KVM_VM_TYPE_ARM_IPA_SIZE(vm->pa_bits);
+		vm->type |= KVM_VM_TYPE_ARM_IPA_SIZE(vm->pa_bits);
 #endif
 
 	vm_open(vm);
-- 
2.47.3

