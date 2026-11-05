Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922479;
	b=uGU9Y6kWCL4A1yipjAM1eOR24ZFnN326LJzUdhea1JuQNIfZDDsRZcPUwVsezh0hAssa
	 8VA743fvYxHP+8ym1KDI04ci5sAgOC2f8v+qIG2LMMU5+4yE15csxbmLK1W/f3HLttE/N
	 ZOq4fPb25VgzYmOrKOdJRoJ13Ic+t5MZoqbaj0EK1wa4iZAcYsvypyFVxY13fshwUfcKO
	 JznCkXorMrU1ON1X+5mURqelmMb6d8HosWaUWyt33l0ezAaTNp7ASD6HkaSbmq+3w1HJt
	 r8Yh8FkwnMwA3LnHBSR7pCDhfZXxcSaq4MtPjReYs9aNNen73W8DiAi0mYQ1Q3wo/9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fgvB7ryGI+VP1vEYkbqY8JtJCAmW2BQXzqaW/kbu2G8=;
	b=Nr0HH6OJHkH4MluNsRgvag/oQfj34bj1fdnlxnnHRgutJaSfyDuLSxmh1m9kKzYIrKle
	 EAieJAlW+ev1Y8M6zK5r99XPpNCLmAqUDvBRrt5CzOplK07K+DY/ovNLX73YLNId8xmv1
	 LpNqM6Od7rFO1nUsa08VL+xy3GVQjTcGYtImztut3lv9jh0vM0ugZYH5kPP7ilFXwlxhf
	 f22EvKhbluYbqkjuh9AY0ihz3+bxGMnxhXnsoWkQolrsqkzyPTlh8PcE37htU1V0+lHf8
	 Ck4fQOfY/Il0QKGKMneTMqol9wgMHKVZ/a7ZDNJnzTbeoTXow0NKg3MsVN1huskR0ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XFpuk1IN;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275186083617
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 275186083617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XFpuk1IN
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ed08904845so854415ad.3
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922477; x=1794527277; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgvB7ryGI+VP1vEYkbqY8JtJCAmW2BQXzqaW/kbu2G8=;
        b=XFpuk1INIyNr9DTXOaKWM4+hiJ9BEGdyv4p15RHayywbwn1Gn2aIPoEw8k0Bu1h4Tr
         zPrtSM02ruMyVXNRg8pxPNbpOqKlozVgyS2zGC6eGRFpilwbewiJHo9ElT6giXQ5uQAv
         cGp3dDe40QNajA7P2g6AsCiftAomRAJMoHH7zVqmVLHCTXRv9RiHoG/mVobFbcK8VhKu
         tiXJwcoM0ntEMhoD7zuuh1m9marnwNtce+10cEtNbfkD93hpJ1nQTF+gaOPmqdDQHeY+
         b9MNYMAd2cI0Py66hoXcFVGKVBvRFLtlZ91mCKww/e8egkRmOxSP3uHiZSXCxvPDDOis
         R+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922477; x=1794527277;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fgvB7ryGI+VP1vEYkbqY8JtJCAmW2BQXzqaW/kbu2G8=;
        b=ivIkY+BD5YA212D5wGXBJUfWRpRfxs3CBLHQVZwynM+1uKsKSONQFQbMTHqQU2bFaM
         zhkj19QBXfDLvd2yr1XClRk2jnPXtt4WAaIdXvaU3JWxDtdGu7puzQyFY1ROS++iV7u/
         dMeIeVsR04/ZpodGKbf8KE8KgcAS1rkRQMyl8S6GTUuTZ9Axwv7NbhwcxaaBWLiMu05C
         /dQ27OoQ6ro0YMUqBo8LqeVom3ITqgf0FoUJn9D0gIIkO4n4GUmrw3VFrs7r82knKDxB
         t/Ed+0Odyr/yT5bZxArwnVr69aLMKh8NaRVy8Qz1nt4SBhSijg9rghEKh2dDw4UU3OM9
         Zfmw==
X-Forwarded-Encrypted: i=1; AKwUvBx3KTl/ZalJleAu5ihiLnYrdmmHsBjHMenJTM4BQPHcvtWKLdDkNladRbF3ZCBszifTqm4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HcxUQH/r//iTTBnENVQxnwxoVoj3pPaJRDTbnlSn3alF+ZxYp
	dRsvG9whY5iKj51C96p/vUgWc81UDdA8kO//mXA8SKeeBhbRkd6nGFm9AAN+QeV1mOxhx3WRp8W
	q1Ku/Xw==
X-Received: from plic13.prod.google.com ([2002:a17:903:370d:b0:2eb:153c:2391])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d05:b0:2ec:ed58:2062
 with SMTP id d9443c01a7336-2ed4197e542mr11947205ad.35.1793922477243; Thu, 05
 Nov 2026 15:47:57 -0800 (PST)
Date: Thu, 05 Nov 2026 23:47:00 +0000
In-Reply-To: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793922452; l=1655;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=eAuK6mynjXU4g9scBsf8osxDUNluz16TtjfwP534Mqw=; b=fuDGD8mFk2kezyisI0w6vD9nLF5EHCz8DYL5IKWXrWQlJD+wmgeWQ+Y1ZGY0oFpDoZ71oILr3
 SeqLs8WgWFBAZOWuMvl9z1pOG4vWv/UANcVEKdCrJXru2JQpc/g3Wzv
X-Mailer: b4 0.14.3
Message-ID: <20261105-tdx-selftests-v16-16-2024e8fa517a@google.com>
Subject: [PATCH v16 16/20] KVM: selftests: Load private memory and finalize
 TDX VM in kvm_arch_vm_finalize_vcpus()
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
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>, 
	Ira Weiny <iweiny@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Sagi Shahar <sagis@google.com>

Initialize TDX private memory and finalize the TDX VM after VM and VCPU
creation.

Hook tdx_load_private_memory() and tdx_vm_finalize() into
kvm_arch_vm_finalize_vcpus() to avoid the need for every TDX selftest to
manually load initial private memory and finalize the VM. While this
prevents TDX selftests that use vm_create() helpers from customizing
memory before it is locked, no current selftests require this.

In TDX, finalization is a mandatory step to make the TD runnable. It
also finalizes the MRTD of the VM's initial memory and state, locking
them in for future attestation and preventing any further modifications.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 11db6a3b0366..ee8a1715d844 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -1503,6 +1503,14 @@ bool kvm_arch_has_default_irqchip(void)
 	return true;
 }
 
+void kvm_arch_vm_finalize_vcpus(struct kvm_vm *vm)
+{
+	if (is_tdx_vm(vm)) {
+		tdx_load_private_memory(vm);
+		tdx_vm_finalize(vm);
+	}
+}
+
 void setup_smram(struct kvm_vm *vm, struct kvm_vcpu *vcpu, gpa_t smram_gpa,
 		 const void *smi_handler, size_t handler_size)
 {

-- 
2.56.0.455.g6c5a503b38-goog

