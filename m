Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4345A2AA
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762070; cv=none; b=ABE/4NY5lm5qhv4dEQ/XDj9+YFBRAnBE3/O5zRX71nzcZu69DRHNtcxod/xc+W/N+JbXs6Oln6pOW8ZkWZVY6VBX3JBZphjkjNe2RqtROK5AAa+DnO7lJY4WVNeJbfEVnvky+g5sgr+xNWuvooPPbf2oGxbWM8RGQjDY0BI7tpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762070; c=relaxed/simple;
	bh=4m9jJUUx20HUvUYZ55bE2QIcvUUJfZhkkL8moJZpJhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b9BWXSIBEHOkI3x7dSkDvbdBJJ7smVkHCAu/uYplBG6+i9IK/8jgBN61XyMVLSiRtft8qiVBQuKW+Bh4T5w3FC2cFMhI2ES8k6oTsVLGlfi6jQaF4nRyfPjeUiq2j0wnmQWK+DKv0sutE+OP/ydRPN30hywFuyMJt7Ldtrg3tLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XETFDfpV; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XETFDfpV"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce8a76df2dso779535ad.2
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762068; x=1785366868; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tzvQ8jRcrNAd6P68kZVjEL1nagqI7IcvfUtkmDMDbV0=;
        b=XETFDfpV9M2/0uzLta/jTFq6ldAjOcf4iRYrzCTp7g2MwUeZPrK5o38hdIdYRY0zCa
         SaBaOBG9VDYPdzs3l3XLDmhGDRraTDGrsPkA3DpepgzlmzLsaxtQRwbSigIB0wDmGCqy
         n0fHGY6f2nir2v/jt8mj2rQ6h1Wa0245WFucFyy0pvnMJU+q2eLS/EDIkroqjV70f8BH
         ix+pcu+fqu4QOznWu/htTP3nWdi0EagVm/Q0U6PEJRV4M2kbxLRjT333YASBXidfXl6o
         z4sk+l8oyhzZ1zWyOzOapwMAm8OwfaaT4h37jwZBMkYRA5EWbaRJ7g9eEllvdgj4Z45v
         +niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762068; x=1785366868;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tzvQ8jRcrNAd6P68kZVjEL1nagqI7IcvfUtkmDMDbV0=;
        b=RqzWAIlQzcbsy1slrbzOZ2DDz6myA05FZryUGmBiCaBtmVINlT2lQ9/a8cb2nIMFt7
         /abcQo0G2sVVL7DtfBrn6VI4KN+/p+Qk72qpt3fYVWR0nlZR1GytYSrWgqcdQ8QtUIeo
         aJcqGat6EQ9XSYnKUvKHeE85sqz8Xk1bnysgC+D3fEKmWkRjsbRQ7yWpdXO4LOG4xa34
         vN3qqjAEmPvbFwn2GiD0LHxgAaSYvhvcDuOSlrmGJjnQVBMG+bN9fdP3UIyDD/iXtsDp
         2S6j14HHxdaKOIqsNnARcBHPfzFfkrMlLccQDY2bB0VU3HwDlCwZ82D+5+1ZkieF09Xc
         +gkg==
X-Forwarded-Encrypted: i=1; AHgh+Rr5V1Xk+GvpqIWMRgXbtB4T0kn+sHPsrkIBwQJOaLeJTK0bsPahx/Jm/k1kjX5a0eW3AMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVZoaaTQqO9lBa1ukQWTSvLg6ohiGaS/Z4Nqwa3LzWIqNZjl0n
	52xdVBUDEFZ817Po3vPaaFr7RynQuwWjbv07x7H1M5TjUs2kePTx0yVv5F8iWohdZa2S8e4YrBZ
	xvf2LVQ==
X-Received: from plhy6.prod.google.com ([2002:a17:902:d646:b0:2cb:97d4:2e28])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fd88:b0:2ce:d1dc:1e1
 with SMTP id d9443c01a7336-2cfa71ab679mr9360555ad.39.1784762067858; Wed, 22
 Jul 2026 16:14:27 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:17 +0000
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=1977;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=4m9jJUUx20HUvUYZ55bE2QIcvUUJfZhkkL8moJZpJhE=; b=jg8wnH2/CuGyuZGXQUBITd5uixrwtWUIbt5Ngu1T63Xs2cmb4aRxg1YCojWtxgBJjdBYsn5Qr
 fz0QSonWIMsDUWf1LLIMyq278xjq2VOm5swBjhdtOOYYCIHx35W0MT/
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-12-15ad654a50db@google.com>
Subject: [PATCH v14 12/22] KVM: selftests: Require guest_memfd for TDX VMs
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

Force guest_memfd for TDX VMs.

KVM supports guest_memfd for TDX private memory. Without in-place
conversion supports, all pages default attributes are private. Thus,
set page to "shared" for shared pages.

Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c     | 2 +-
 tools/testing/selftests/kvm/lib/ucall_common.c | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 0b9d2d383bfa..4a48c4b42095 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -472,7 +472,7 @@ void kvm_set_files_rlimit(u32 nr_vcpus)
 static bool is_guest_memfd_required(struct vm_shape shape)
 {
 #ifdef __x86_64__
-	return shape.type == KVM_X86_SNP_VM;
+	return (shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM);
 #else
 	return false;
 #endif
diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index 029ce21f9f2f..c03dfc763172 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -27,6 +27,7 @@ static struct ucall_header *ucall_pool;
 
 void ucall_init(struct kvm_vm *vm, gpa_t mmio_gpa)
 {
+	struct userspace_mem_region *region;
 	struct ucall_header *hdr;
 	struct ucall *uc;
 	gva_t gva;
@@ -37,6 +38,13 @@ void ucall_init(struct kvm_vm *vm, gpa_t mmio_gpa)
 	hdr = (struct ucall_header *)addr_gva2hva(vm, gva);
 	memset(hdr, 0, sizeof(*hdr));
 
+	region = vm_get_mem_region(vm, MEM_REGION_DATA);
+	if (region->region.flags & KVM_MEM_GUEST_MEMFD) {
+		size_t aligned_sz = align_up(sizeof(*hdr), vm->page_size);
+
+		vm_mem_set_shared(vm, addr_gva2gpa(vm, gva), aligned_sz);
+	}
+
 	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
 		uc = &hdr->ucalls[i];
 		uc->hva = uc;

-- 
2.55.0.229.g6434b31f56-goog

