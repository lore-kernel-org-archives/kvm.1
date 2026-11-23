Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433682;
	b=Z0/dP1DWF5l7EzfbYZsGBFF4WI/gXSLs7BhVh0b3RwVcY0foAAekbp4zCHtBUFrr7bZ1
	 J+AzVth9IXv6lWfyHVj+Q/CkuJDT7UqGLhVZZPmqlTX3gffVgfGpH66lu8pgHG8SB/REX
	 Dyjxse1AkMn8E/kmHsmI7nMwjZkFUunfbYgvyLlufMPjbrgQV0YKf0sVAMJ8+TliT5LuL
	 XyJYcP7fVvX5nrbsZ7QwN8Q7v6/yPf90W+Wo9s8AiWB29ZpGU0NNC5DQ5c/JfRlLymfwk
	 mPhpnrsoV2r9yKIAmJG9bbFEGskl08UCOAZL7u7gTHPI88Hk0jDa40xTstBvUvbWhOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433682;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NPRhYDnwJRvicd4u9ac46NRRTHp7yf2uOQ6I7pysTOs=;
	b=lg8nWk9mt8bAgjbWYQVuXeNx9IaCnNBQsL3YL13V5pZ5Y7CaxU3rQxCWcMcwi+c5uugl
	 DyKFoBwOM4fgTrJ1pXTv+5gyiO+PbJq4/RoZoMKL/14M6fHIogg9JyWyfAr3uUmJ6b5pN
	 TSVyJ1grYMlKlwmcHMoEy5H9pINWOK3lsw1WMNmZ950UciiU1IXwyMKvJF3VIrOGTdinx
	 nsAQTnhhoqtysfCdAkDiavO1+LHj2vE3AGT1lgH3rJu8C/upAAc29WMrR4WFevsS1q6pU
	 VaHx3jSadTiFDHIGNSQEUU7CtyNaETt7hT1616qdFrR7eSumEPatHByIA2/LuRYHTQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LJyZfoTK;
	arc=none smtp.remote-ip=91.218.175.69
Received: from mta0.migadu.com (out-69.mta0.migadu.com [91.218.175.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E045606A31A
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 11:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E045606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LJyZfoTK
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sjV6qrYMC8GhJztUOTln5L8ygixllt0tnTT6CrNeYyI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795433680; v=1; x=1796038480;
 b=LJyZfoTK8ZtIYq9wmTcSMfhlUK4V/QQiyUq0/16fublnXDwgzY+bHufptb+40LP4Btx/jvBA
 tgXKmtXeFKVh5OcpvJu9iiFbyoBSjybXUlU/ZuYeQdOrleefE2eqzdiLKQDG/oSAAlKgTUANJKM
 GQzMMepdx6XCOdQtir/HYZbE=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b141b18848b98b72;
	Mon, 23 Nov 2026 11:34:40 +0000
X-Mizu-Trace-ID: b141b18848b98b72
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	kvm-riscv@lists.infradead.org,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH v3 0/3] KVM: Bound KVM_PRE_FAULT_MEMORY by the vCPU's dirty ring
Date: Mon, 23 Nov 2026 11:34:32 +0000
Message-ID: <20261123113435.1170711-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
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

Hi folks,

Changes since v2 [1]:
  - Added patch 2, which warns in api.rst against calling ioctls other
    than KVM_RUN while an exit is pending. (Sean)
  - Mentioned riscv as well as arm64 in patch 1's exit_reason
    paragraph. (Lorenzo)
  - Collected Lorenzo's Acked-by on patch 3. (thanks!)

KVM_PRE_FAULT_MEMORY never checks the vCPU's dirty ring, so one call
over a large enough range of populated, dirty-logged pages overflows
it. The first patch stops the loop at the soft limit, as KVM_RUN does.
The second warns userspace against calling ioctls other than
KVM_RUN while an exit is pending. The third adds the case to
pre_fault_memory_test.

Pre-faulting isn't the only ioctl that can push past the ring's
reserve. On x86, KVM_SET_MSRS does too when it writes the wall clock or
the Hyper-V hypercall page. A guest can also push past the reserve
within one exit, for example through the arm64 ITS. What those paths
should do when the ring fills is an open question for the dirty ring
API, which I don't think belongs in this series.

I didn't include the kvm_dirty_ring_check_request() rewrite that Sean
sketched on v1, since I think it can lose a request. It tests the
request first and clears it afterwards. If the vCPU is scheduled out in
between, loongarch sets the PV preempted flag in guest memory and x86
updates a Xen guest's runstate area, either of which pushes an entry.
When that push makes the ring soft full, the request it makes is then
cleared, and the vCPU runs with the ring soft full until its next push.
Clearing first and re-setting, as the code does now, doesn't have that
window.

Based on Linux 7.4-rc2 (7475ea8b58616; also applies to kvm-x86/next
cbe54fc3462b3 with git am -3).

Cheers,
/fuad

[1] https://lore.kernel.org/all/20261117074428.7544-1-fuad.tabba@linux.dev/

Fuad Tabba (3):
  KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's dirty ring is full
  KVM: Warn userspace against ioctls while an exit is pending
  KVM: selftests: Test KVM_PRE_FAULT_MEMORY against a full dirty ring

 Documentation/virt/kvm/api.rst                |  20 ++--
 include/linux/kvm_dirty_ring.h                |   5 +
 .../selftests/kvm/pre_fault_memory_test.c     | 102 ++++++++++++++++++
 virt/kvm/kvm_main.c                           |   5 +
 4 files changed, 126 insertions(+), 6 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.47.3

