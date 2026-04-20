Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16CB344029
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700103; cv=none; b=jPVUQd6PPE/TdDWU2mSGNDT3GXd1QPPVOCkTQhLKECv3yPWMmjGNcwMdtsllZQxo/dohETRPKWLvQFx/SfWkUtXQaiqwjRNaUBgJuHJ/EAzxSvQha1ExT/KGAB0zonnRs/2wXiRjV3ktSYZyh6rE8xd22KmyGGcM0lNkXigsi/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700103; c=relaxed/simple;
	bh=b5WtUpEzLBRMj4V64KGDzPkPwhUvxVS1cZT2Rp2/kK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVoKTLbtQVZcPuZJvsDC+Xq+8JuzsifHiZVtSIJPcGU0plcwbCId+AKGyLHbFHQ6MpZNS1pYW6Hsxl+wnv3rd5V9uJ5rQ2iqyJ6Ng4/N1jVRbHXLwZEirnjYxD8UqwxvVnIcx5d4cNzZOtibn+oXJvH6IfaPQke1oRzDggeAz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=HI78sr8e; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="HI78sr8e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776700101; x=1808236101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ap/3E+KC5NaGv9ckPfeKoob64EO8BuXGSWUQDqkhYLs=;
  b=HI78sr8eJZoMyDGdcbxBIsb+iV2yCKhPdS++TpcRygqZkzWZGzIhQ2mT
   2/YHWYFYLh9vLQgE8J+bSIksRtGeuKA+TYbFLVow3chF8ZIWkkIbQvNXT
   oMO3IuNTq7sjJPj1otqauHCLC/vcPO7YPp1SHo05ykaTJR4FJXDjgMS4P
   cdh2s/3u+ZReWmmUJSO0ZmimVmW/YeCX/wn+psmropIPwoSm4WwvGqyOX
   /6zWIVajDL4Ci3NCPHf4Ihp+yK8sCBMiZTJvq9vYGst+GamGRFYXSO/cP
   qScFT9ZUOeda2zB+84DxIvsuAskPcau0F1uq6/ThXBH4TNcUDfFftegc5
   w==;
X-CSE-ConnectionGUID: KfRh0mmUQnKhf1zoKWyY9Q==
X-CSE-MsgGUID: MTGyuerVSASqBG4+YOa/8w==
X-IronPort-AV: E=Sophos;i="6.23,190,1770595200"; 
   d="scan'208";a="17734817"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 15:48:21 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:31316]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.49:2525] with esmtp (Farcaster)
 id 61c1d64b-f89a-4431-9b09-17099686a02d; Mon, 20 Apr 2026 15:48:21 +0000 (UTC)
X-Farcaster-Flow-ID: 61c1d64b-f89a-4431-9b09-17099686a02d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:48:21 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:48:18 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>,
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>,
	Nikita Kalyazin <nikita.kalyazin@linux.dev>, Patrick Roy
	<patrick.roy@campus.lmu.de>, Patrick Roy <patrick.roy@linux.dev>, "Derek
 Manwaring" <derekmn@amazon.com>, Alina Cernea <acernea@amazon.com>, "Michael
 Zoumboulakis" <zoumboul@amazon.com>, Takahiro Itazuri <zulinx86@gmail.com>,
	Takahiro Itazuri <itazur@amazon.com>
Subject: [RFC PATCH v4 7/7] KVM: selftests: Test pfncache invalidation for gmem-backed memory
Date: Mon, 20 Apr 2026 15:46:08 +0000
Message-ID: <20260420154720.29012-8-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420154720.29012-1-itazur@amazon.com>
References: <20260420154720.29012-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Extend pfncache_gmem_test to verify pfncache invalidation paths:

 - punch_hole: fallocate(PUNCH_HOLE) on the pvclock page's guest_memfd
   frees the backing page and invalidates the pfncache.  The next
   vcpu_run re-resolves the PFN with a freshly allocated page.

 - file release: kvm_vm_free() closes the guest_memfd fd, triggering a
   full-range pfncache invalidation.

 - private-to-shared conversion: KVM_SET_MEMORY_ATTRIBUTES changes the
   pvclock page from private to shared, invalidating the pfncache.  The
   PFN is re-resolved via GUP instead of kvm_gmem_get_pfn().

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
---
 .../selftests/kvm/x86/pfncache_gmem_test.c    | 39 ++++++++++++++++---
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/pfncache_gmem_test.c b/tools/t=
esting/selftests/kvm/x86/pfncache_gmem_test.c
index c61b161f3e0c..a63940c36b15 100644
--- a/tools/testing/selftests/kvm/x86/pfncache_gmem_test.c
+++ b/tools/testing/selftests/kvm/x86/pfncache_gmem_test.c
@@ -36,11 +36,10 @@ static void guest_main(vm_paddr_t pvti_pa, struct pvclo=
ck_vcpu_time_info *pvti)
 {
 	int stage =3D 0;
=20
-	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, pvti_pa | KVM_MSR_ENABLED);
-
 	for (;;) {
 		uint64_t clock;
=20
+		wrmsr(MSR_KVM_SYSTEM_TIME_NEW, pvti_pa | KVM_MSR_ENABLED);
 		GUEST_ASSERT(pvti->system_time !=3D 0);
 		clock =3D __pvclock_read_cycles(pvti, rdtsc());
 		GUEST_SYNC_CLOCK(stage++, clock);
@@ -97,7 +96,8 @@ static uint64_t run_and_verify_kvm_clock(struct kvm_vcpu =
*vcpu,
 #define PVCLOCK_GPA		(1ULL << 32)
=20
 static struct kvm_vm *setup_vm(struct vm_shape shape,
-			       struct kvm_vcpu **vcpu_out)
+			       struct kvm_vcpu **vcpu_out,
+			       vm_paddr_t *pvti_gpa_out)
 {
 	struct kvm_vm *vm;
=20
@@ -118,6 +118,9 @@ static struct kvm_vm *setup_vm(struct vm_shape shape,
 		vcpu_args_set(*vcpu_out, 2, (vm_paddr_t)PVCLOCK_GPA,
 			      (struct pvclock_vcpu_time_info *)PVCLOCK_GPA);
 		vm_mem_set_private(vm, PVCLOCK_GPA, getpagesize());
+
+		if (pvti_gpa_out)
+			*pvti_gpa_out =3D PVCLOCK_GPA;
 	} else {
 		vm_vaddr_t pvti_gva;
 		vm_paddr_t pvti_gpa;
@@ -125,6 +128,9 @@ static struct kvm_vm *setup_vm(struct vm_shape shape,
 		pvti_gva =3D vm_vaddr_alloc(vm, getpagesize(), 0x10000);
 		pvti_gpa =3D addr_gva2gpa(vm, pvti_gva);
 		vcpu_args_set(*vcpu_out, 2, pvti_gpa, pvti_gva);
+
+		if (pvti_gpa_out)
+			*pvti_gpa_out =3D pvti_gpa;
 	}
=20
 	return vm;
@@ -139,16 +145,27 @@ static void test_no_direct_map(void)
 	};
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
+	vm_paddr_t pvti_gpa;
 	uint64_t clock =3D 0;
=20
 	pr_info("Testing pfncache with NO_DIRECT_MAP guest_memfd\n");
=20
-	vm =3D setup_vm(shape, &vcpu);
+	vm =3D setup_vm(shape, &vcpu, &pvti_gpa);
=20
 	/* Verify kvm-clock works with gmem-backed pfncache (vmap KHVA) */
 	clock =3D run_and_verify_kvm_clock(vcpu, clock);
 	clock =3D run_and_verify_kvm_clock(vcpu, clock);
=20
+	/*
+	 * Punch a hole in the pvclock page's guest_memfd backing.  This
+	 * invalidates the pfncache; the next vcpu_run re-resolves the PFN
+	 * with a freshly allocated page.
+	 */
+	pr_info("  punch_hole on pvclock page\n");
+	vm_guest_mem_punch_hole(vm, pvti_gpa, getpagesize());
+	clock =3D run_and_verify_kvm_clock(vcpu, clock);
+
+	/* Smoke test: VM teardown (closing guest_memfd) doesn't crash. */
 	kvm_vm_free(vm);
 }
=20
@@ -160,16 +177,28 @@ static void test_sw_protected_vm(void)
 	};
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
+	vm_paddr_t pvti_gpa;
 	uint64_t clock =3D 0;
=20
 	pr_info("Testing pfncache with SW_PROTECTED_VM (guest_memfd-backed privat=
e memory)\n");
=20
-	vm =3D setup_vm(shape, &vcpu);
+	vm =3D setup_vm(shape, &vcpu, &pvti_gpa);
=20
 	/* Verify kvm-clock works with gmem-backed private memory */
 	clock =3D run_and_verify_kvm_clock(vcpu, clock);
 	clock =3D run_and_verify_kvm_clock(vcpu, clock);
=20
+	/* Convert pvclock page from private to shared */
+	pr_info("  converting pvclock page: private -> shared\n");
+	vm_mem_set_shared(vm, pvti_gpa, getpagesize());
+	clock =3D run_and_verify_kvm_clock(vcpu, 0);
+
+	/* Convert back to private */
+	pr_info("  converting pvclock page: shared -> private\n");
+	vm_mem_set_private(vm, pvti_gpa, getpagesize());
+	clock =3D run_and_verify_kvm_clock(vcpu, 0);
+
+	/* Smoke test: VM teardown (closing guest_memfd) doesn't crash. */
 	kvm_vm_free(vm);
 }
=20
--=20
2.50.1

