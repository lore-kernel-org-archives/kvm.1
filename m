Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB6B5335A3
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883535; cv=none; b=Ghge2eIcx54nebi+K596wo5Nyrw63papvW3b+C/yVDgnVAaIYqougriGvcrzeD8/jbDDH7azVBplMbjDSgJ2Vh8bB4njPHkhASh5Vg+hO2iT6WAx4FAm9oWw8SOmYKamo5hMT6TuPZWdQBM1zxjkFKpNap4+Lb0rbMuOvqtHo2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883535; c=relaxed/simple;
	bh=GD8eVUHbm2E1vh85lROmRD5KVeuFQfSEqLamn6H/rZk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DsMu0L9LA5aHRFX1aXMHJk+tDfSvg9wPd8a6eSnBVsL14XbC/l97s6g7dggxux6qbFdc6FzWa85ckRJkZg3VjI361PXJefffVZLjuEAOh4t7DfQCDvv2uAqH9iKiI5ijMD2T0VVEQ3i66B7d00X0qS3K1WfIucneHJLgFqXq4RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bsc2/Nh2; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bsc2/Nh2"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbf293831so10647749a91.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883532; x=1791488332; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TnnRJIDUsVUbLKISIXMcfczhIdduLdshUTyAvRHb9LM=;
        b=Bsc2/Nh21lfoH+sjjD9eMLdYGRTINOb1Ko0f/T2GXy9fi0O0+yX9pWcw/sVf7Uxyp5
         kfsunsc/q5wrXk6r1IxS8ZNOwMeclwFNxYymCOdZh03HB4YvBLM7UWmunKixUn+qTrfJ
         ZcwxDNLRsgHxKntUrShVU8jHXD3c2hHQNLay0qRmuaHd6wudgzygJ+LWuYwvOH4CSnQr
         a3qcgpK20wpJVPqT5/aKKzfzPLUDlTeFKYqInfN9BZfkPWVmfk7e6+rL+FFKgfuKgW6o
         bxefJWtvbhXQT/GEDYYHbDeMMznIhz5HcaBmu26TNff3f3HDcDQThgaYH4rRrvH4rWsn
         jsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883532; x=1791488332;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TnnRJIDUsVUbLKISIXMcfczhIdduLdshUTyAvRHb9LM=;
        b=TUWu2SsetHXi2I0ayefuQYqIMYVGX1PVHHO8BKrjqoGVSH57faUFCUPTQZOI15xakg
         w+0HCRJpSkjG7CGeqv+NRHG6YJZqH4e8wC8ITV5EgfXxTnVgbM03KhaK2/C6EzLJ8806
         Win4/d1tHUpiCQgg0zif5vbEq3LbcGORO4/LQh9ATnTxODl99HSJ0vrgRi6c3eIhd/gl
         p02ntHHijExBJn0Kmelxp1wtcvfaYJ9krQwEEWPzDL7cY2JHlCHtFdgjvNTQvpVUQd5j
         Ram9sx28RaN7WP5q7i2vKweBfJHv3DBe0Qnp7Lg0h0QqHuws2IucUSGNGJjPQ0FHQm55
         PE1g==
X-Forwarded-Encrypted: i=1; AKwUvBzOU+XIF+3BcuD8VPlDI6rm9GI+5olH0rZRFwQOQZ3dPMDhXinEvgCkuHj2GPu7Dr+U1wk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbCZpLmZoVWxZxf44OInSfPp3ME2zmCP6di0nxRyCPriJPSPsA
	80eZ5PNt5qoJ1dn+1hGZfYzOiJl4C1hkP3d6DHZcGbHmiz8y9+PD2Yb/eCyMTKqgpPI4TNAZWgX
	nx4O3fQ==
X-Received: from pjbku19.prod.google.com ([2002:a17:90b:2193:b0:3a4:a466:3257])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33cc:b0:3a4:b6c2:b159
 with SMTP id 98e67ed59e1d1-3a6ceb0535dmr521634a91.34.1790883531608; Thu, 01
 Oct 2026 12:38:51 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:38 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=1350;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=GD8eVUHbm2E1vh85lROmRD5KVeuFQfSEqLamn6H/rZk=; b=YFYTIoWEgUhf/GRK2Iz6EQaeyq48ljFzlCso0/5WO5ziGBOVCzKutFUrZsehfwngXTev409nj
 dbjMGq6KjkHCDuGuh5TVwHybQ5r3XmlHNWJTQrL1+SKldNctSsNvPJK
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-11-7c62a5d8a992@google.com>
Subject: [PATCH v15 11/23] KVM: selftests: Set shared attributes for ucall
 guest_memfd pages
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
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

The default attributes for guest_memfd pages without in-place conversion
is private. However, the ucall pages need to be shared between the host
and the guest. Thus, set them as shared.

Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/lib/ucall_common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

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
2.56.0.rc1.315.gc6ed9934b7-goog

