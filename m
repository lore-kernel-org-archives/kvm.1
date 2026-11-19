Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074486;
	b=OnDucQHFisst94MZEh5/SMroGeuN5OxePn+exvSLrcuYobetDa/lJqtSyHuew+6yDuEJ
	 aVJbHzzkBbOqi9a+dQ5BRwiyXX6GZj3CvgevW8smXaJn+trtVAMTjqnW39XXal7jnvRQx
	 jx0v9x6+NhApnietPY+ERd9PGqlu4gmjEcPN5RtmTLsbxfOniq0NWhzEm2PprczpdVSja
	 c6MyoWlYWewwPLt0Y/J28X9qPn0ClPP+rOa1LEXdeFC9zX6GOAD6sbKWjZBWK3yL7WLHI
	 w/6FxTsHF7+wwn2EBDG6qPqlnf3nPT/sdhArRB9Xih9Gyiq3APY7JGORPcwqSnBv8wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074486;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jA4EnlN8vX+Zi77g4vST5DH/Y6mCJwZUgtH7iydfQVU=;
	b=eMegqFYOHn48GdNa/hS6BgMaBMpLyYtLpz0ZipJ2iYllvSRzNY80andPS56ASFsXfCBh
	 3bvvd04CBDfuo74yB7IKunI7HTddjWC62ZGq7UzDA5YyE359PQsWADsnlY/1T9YOKtG/a
	 /RNLsV+g0KWPX5KYOZhS9rlCwhXmbOiNQAAf6oDLsInDY2COozu2qaSulhTRZG/stjPhT
	 V/Nc6vmuoFg9v8QlkbEnvEqosNGby66tf/pAo3oZPT42pnnikccERDxBbKPbe51YTEngR
	 47bGmAQI9/a/DualRGNitRlHD3fXTgqMAgcrztVHLPhKRfCTBxL819qV3+vVN9kFBgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xEpsA2MW;
	arc=none smtp.remote-ip=91.218.175.34
Received: from mta0.migadu.com (out-34.mta0.migadu.com [91.218.175.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB74606A338
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 07:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCB74606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xEpsA2MW
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=b8dCz3xyQcdyBq/RUyCmROZ7uxNub0ykavW4CBAhTVY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795074482; v=1; x=1795679282;
 b=xEpsA2MWKYMLJeHwPe8vVyfcA6CJq3up6Vr51FKZ0ElLm3kxez9HLTy8iajIyNE6eZdYebYu
 h4mKcBMS/ebmVPhhBMkC7p+PC8+XlMboeEOi9oPcvbFC41aGbSuKx3LnkUASBpvLl7K1UOhoE5i
 +Za9sdHxd6Fut/LnZrXd3ZBk=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9def377e580dbf6d;
	Thu, 19 Nov 2026 07:48:02 +0000
X-Mizu-Trace-ID: 9def377e580dbf6d
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-mips@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH v2 2/7] Documentation: KVM: Fix lock names and a lock type in locking.rst
Date: Thu, 19 Nov 2026 07:47:47 +0000
Message-ID: <20261119074752.1027729-3-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119074752.1027729-1-fuad.tabba@linux.dev>
References: <20261119074752.1027729-1-fuad.tabba@linux.dev>
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

The x86 lock ordering refers to kvm->arch.mmu_lock instead of
kvm->mmu_lock. The entry for wakeup_vcpus_on_cpu_lock gives its type
as spinlock_t instead of raw_spinlock_t, and its comment uses the list
and lock names from before commit 12a8eee5686ef ("KVM: Move x86 VMX's
posted interrupt list_head to vcpu_vmx").

Fix all three.

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 Documentation/virt/kvm/locking.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
index 662231e958a07..df0db74630976 100644
--- a/Documentation/virt/kvm/locking.rst
+++ b/Documentation/virt/kvm/locking.rst
@@ -54,9 +54,9 @@ On x86:
 
 - vcpu->mutex is taken outside kvm->arch.hyperv.hv_lock and kvm->arch.xen.xen_lock
 
-- kvm->arch.mmu_lock is an rwlock; critical sections for
+- kvm->mmu_lock is an rwlock; critical sections for
   kvm->arch.tdp_mmu_pages_lock and kvm->arch.mmu_unsync_pages_lock must
-  also take kvm->arch.mmu_lock
+  also take kvm->mmu_lock
 
 Everything else is a leaf: no other lock is taken inside the critical
 sections.
@@ -297,13 +297,13 @@ time it will be set using the Dirty tracking mechanism described above.
 
 ``wakeup_vcpus_on_cpu_lock``
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-:Type:		spinlock_t
+:Type:		raw_spinlock_t
 :Arch:		x86
 :Protects:	wakeup_vcpus_on_cpu
 :Comment:	This is a per-CPU lock and it is used for VT-d posted-interrupts.
 		When VT-d posted-interrupts are supported and the VM has assigned
-		devices, we put the blocked vCPU on the list blocked_vcpu_on_cpu
-		protected by blocked_vcpu_on_cpu_lock. When VT-d hardware issues
+		devices, we put the blocked vCPU on the list wakeup_vcpus_on_cpu
+		protected by wakeup_vcpus_on_cpu_lock. When VT-d hardware issues
 		wakeup notification event since external interrupts from the
 		assigned devices happens, we will find the vCPU on the list to
 		wakeup.
-- 
2.47.3

