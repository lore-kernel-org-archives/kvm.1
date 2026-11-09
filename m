Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.247
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214140;
	b=mGeBw9ExdbNCMl2FY8EInf1I7Lbk0La0oITMgwMbpKi647bqXVeNlxbwJh2yPxshZgCG
	 iszAQrH/GRXT8VxvQ9uw+V8L1WuWPHo/m+JK2d+YGwtbPY/xJ/qwhcluEemAb8mJEkaCH
	 uz3dvQ31BJuvOh9Ymb/ClW7hGmQ3J5OJfXb4oJiju+wAwl0HfS1Vavbty0/OjGDMK66bn
	 Vynw+Oq/0UVuZrigCX/CzYsxwDfkC28ljvuI5YzDe6PXxbGOe8oM7FopoCR/XB2uECVRc
	 NJbsVYFKNrFedqEDfX6+6L1Tugw3Y9WxfDy1cQUl9fmUiJdJ2TcUgFaH2BiN0UgVTFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214140;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BcLq5g72+s7ounklw3j61AqvGiqhGMXsRHaqCza01SA=;
	b=WyRnhAGMOwSxKAebqZYuwkTgXsXZB2dVE8kZqYktWqs+e0MZC++iMml3hYgC75pC7xCm
	 4cpGeRkssXLDV/HiVTA+2hb82mz8n8f+r88S/KZvsDiw+yTzDETCAuXrLrkwOXc7hMqOH
	 Tj28Gh5gEI6Rqqk2Oi6wiM6G1OzKXbxBvoESOLelcMfxwSMq1mjhBeLC0pg6wa7PGFLvT
	 3yF4It421a+439p085Pj52Ox4NjQmd1WHh+1mvqEi0Ggh2T9AwbrASDTDQ/AHm81qF3WW
	 HC7wfYjftqAKv0wp60f/KPdrsalRLS0ntk8Pti/cnWlLeWCYiBggTASUt1CWcNGMFNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hkKMsnlC;
	arc=none smtp.remote-ip=91.218.175.247
Received: from mta0.migadu.com (out-247.mta0.migadu.com [91.218.175.247])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CC4606D805
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 08:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60CC4606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hkKMsnlC
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=te8jt4hj3WwWfmT6OnfZqS4yAyifEnlgJtAVzuRwM5k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794214137; v=1; x=1794818937;
 b=hkKMsnlC9YHHEVYjusHC2USNtLneCUCRGfnUXE57MNoPcF5cKR21y6HKN+7+aojhrIwL5or6
 cUzAO4BopmaYridgsEHWhteuykAVamolvZMOIPMWEHzQCe2N2iqxbVeOD17ew10xebz5rzYPFGQ
 AQCtipsHJHorr+4+zRcYlF2g=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1bbb010ddd9ebf9b;
	Mon, 09 Nov 2026 08:48:57 +0000
X-Mizu-Trace-ID: 1bbb010ddd9ebf9b
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
Subject: [PATCH v2 03/19] KVM: selftests: Allow arm64 tests to create protected VMs
Date: Mon,  9 Nov 2026 08:48:38 +0000
Message-ID: <20261109084854.840576-4-fuad.tabba@linux.dev>
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

On arm64, the VM type passed to KVM_CREATE_VM carries the IPA size,
which the selftest library fills in. The library rejects any type a test
provides in vm_shape.type. A protected VM is created by setting
KVM_VM_TYPE_ARM_PROTECTED in that type, so a test can't create one.

Accept KVM_VM_TYPE_ARM_PROTECTED from the test, and add the IPA size to
it as for any other VM.

Reviewed-by: Joey Gouly <joey.gouly@arm.com>
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

