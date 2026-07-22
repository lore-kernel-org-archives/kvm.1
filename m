Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36403459AD0
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762063; cv=none; b=dwvcbUW5dn2nBXEe+OEph+Yj2p7qK68c9oIAYsMxJNCPzae+vPY7tnm8SjdL8/Mz2K5eJSS8JhZE6JAb5JeHmcNrl/sZDTWSKmrvP2zQ/9wRoqGe0ljMy3bsbcN1wxKJvpUtFFgjLMUPqaHFu0zklKwhd2hR+B9Gr0qY4o38OA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762063; c=relaxed/simple;
	bh=rn7lIDTWcxoiO6D4/Cdhdy8K/SysdSX/CMUU+rwcLOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fIRqSteaf0pkEgktYsZlHV0MmZtGcCx3PjLY6kccS31g8+5bLLoKCJWtUaWh0+8t72y+V4U5+ov/itPL+5JL2bcr/O9LWZpNt2ou68NKlX9o5y8fAbari6U7khvMoP2mpGaA/gbbdZ+uefn9v7YqJXe/VwYErvkmhovk2zW3/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sYz4lIaB; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sYz4lIaB"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so35903a91.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762060; x=1785366860; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oVBS289J/Z2jqIHEMCM1gipu2UkhJ+nCd+Y4BOZxwFE=;
        b=sYz4lIaBhgjKh7P3vwVIFuVgDh3ncPe1Fj5pPCCxZtxtEGWAkKedIyMqlneLSloW7w
         Qh2Sa+SrqTVgL8vdbAqFGazOanHFfgp4sr9I/4rtqx3DIWEbPeXXo6RxRqaznr8jEpur
         S/se+zby5hWNDlKUiYcezukt+oV/PaKR/tDGTlq+8VMcqvls+I6IBvwEgmdkOGZRjVL7
         vmnRf7Iokk+qwsAXxuMC5tyJdFjO0LIwAD3pA5zxcaGfuU9TCYvsI2+t8AtIUXFlPSfX
         oehei4WcHwJipZNPNv7S891MTdiG4qsntOkfuTTBI33eG7WUZWQWnK0gho94jvm4FJd9
         DVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762060; x=1785366860;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oVBS289J/Z2jqIHEMCM1gipu2UkhJ+nCd+Y4BOZxwFE=;
        b=L2k92aeprxPHoo7qg6QdzyJqdZK1k/OOnTMf0Hdob6DL8z38+pyam9U5u+Oq//E24A
         9V08nhDMkmdDG5CTYL2uLUUVyOrP/78r/QCHUilbFL5kcXlwkLBPF57xEIw8a4tjT9ew
         69Q1anueYAMOVWTk5Dok20TZu/Oz3p3flGFI66lqDbnSEPk0voccrJLWIEKZvCGun7cd
         7aQNsNsKZsP1yeNb/pVvBFIcgTDqbR7qnrxlSuHXn16oxAN8ofRVFDvumusPM8DoRVn6
         0mn8W3jOKEMfDFRn9L5O+W3fM2tE/Q19TUmTZfGFeFKznCWw3FvVhoyeSJLh1a9rkFPJ
         HBiA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3oRMPqaJzeLmD8JgPNJZYYt8hBt6pMMLDYohtAEKOoxvWm0KbgsFTk3vUEvVRocum2bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxiMkOfdQtMceRPVHHtd0lmuqeZhCFSVcuVsYtBHDsnjANi0bB
	VHzwdJJDYLM18ZQcGxgYSxcODoMMFa08C4TBpmsjtuwtJjlca5A2xtrQBvzThetvSA50m4z/+rU
	rW5SREQ==
X-Received: from pjq11.prod.google.com ([2002:a17:90b:560b:b0:384:aeb6:624c])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:184c:b0:37f:9ce1:735a
 with SMTP id 98e67ed59e1d1-38ec658e892mr709493a91.27.1784762060184; Wed, 22
 Jul 2026 16:14:20 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:09 +0000
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=1765;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=bOj/gnaWbqCSO1dw0E/Ufv9dZGd8nQXtcW3IYQ+RbjE=; b=Fwd4fvyFJukTctt1WNFLyHmWmkoUi+2SW/wiXay2xsIEBRQnOVDGm6MjuzZw7NYD7fl7HIlgs
 4ynYSy6pNK1DYAyNeNpv3ljZihaRfmzv4bmj+B2fCdI0PwJSdaRXzqC
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-4-15ad654a50db@google.com>
Subject: [PATCH v14 04/22] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
 validate TDs' attribute configuration
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

Make sure that all the attributes enabled by the test are reported as
supported by both the TDX module and KVM. KVM filters out the attributes
not supported by itself.

This also exercises the KVM_TDX_CAPABILITIES ioctl.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index e1ffb67a106c..c01a26567b73 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -93,6 +93,16 @@ static void tdx_filter_cpuid(struct kvm_vm *vm,
 	}
 }
 
+static void tdx_check_attributes(struct kvm_vm *vm, u64 attributes)
+{
+	struct kvm_tdx_capabilities *tdx_cap;
+
+	tdx_cap = tdx_read_capabilities(vm);
+
+	/* Make sure all the attributes are reported as supported */
+	TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes);
+}
+
 void tdx_init_vm(struct kvm_vm *vm, u64 attributes)
 {
 	struct kvm_tdx_init_vm *init_vm;
@@ -112,6 +122,8 @@ void tdx_init_vm(struct kvm_vm *vm, u64 attributes)
 	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
 	free(cpuid);
 
+	tdx_check_attributes(vm, attributes);
+
 	init_vm->attributes = attributes;
 
 	tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);

-- 
2.55.0.229.g6434b31f56-goog

