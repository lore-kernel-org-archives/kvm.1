Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A866E371053
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405447; cv=none; b=cSVoSBDdNc51Nna/TdGJPOHaH0YEHLyi8jDuTht5NFkGBMphuisqKTkmSSXIsKnOxbKJTFrKd2aaAc9Pxgm9o+N4euVWAIfe68V4kZZVsKJjT88xQrGGlasaIoEoQCUq9COJj3n7jC40ZiWb1WfThT2FFHtr7tr/by2SWNiy96c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405447; c=relaxed/simple;
	bh=/ikqpmqE+DNbwk8ZasaSPnLDlqFFZVhzhj9NNBVLUKo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c0TP46jmojkbwcJ34H950OJ263Xdcm6scliWg6HtwNzigvFwFYCA4uMKVBooxy9B9nCXksDH23HeYvpTXN8JnrcnSBGyQAQTRxgGl4KDBjiNBt2lSpDWJ6EewWF+tFWvryD22KPGcfJBItzbqAtmSR0etq19d10Wj9juOdvFzS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SWpuakid; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWpuakid"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4530a90fdso119174385ad.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779405445; x=1780010245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfsTBh74zO/72fegZAfmLQ14a37FMIV7nJgHfXozZ0I=;
        b=SWpuakidvxcRQZJyefwrTLoKhlCiAKea8TNjkw8zbDsbVnA2cM6H6hhz4Enl3C2mry
         wC2QhFwPpNke34E1cQWUK8wAG/BdDZGn1DTh3w3hvazH2WJAl901ItThvwarBTbxkl+j
         O2JneZydjt0ZGZlziasHMREaoaw8Riw5qCrBXaRp/3w25F+ID+eoDSMZaAl5ILMms+jN
         qFDYP4XvRoOgebyQzgkieZZHXdFAmDg5YNszPh2I2NUGFnsd4E7DQZDZN1zpetJWTQRg
         a6+WxUrlpWoNKd5Ws8Ky4Bjbn4Tt3sJycZFzFRKPit804raL49YJRJMZbWpEFr+ff6Br
         bPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405445; x=1780010245;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfsTBh74zO/72fegZAfmLQ14a37FMIV7nJgHfXozZ0I=;
        b=anI37NOT06pN8zJ/+bxPnW6dLMxh3Osffs9Us5f/U7FRZcn3dhIEuOgtku3n0VdEZc
         Pr9KAWqZJnf+xWG5gJ0j53QZhiGWkxKFilSwLuAN9+A/W3sOoBniNQt6GKybAqpvwLLX
         eYfzKjFktr7sS7zS3CTuKSCzzP3c6jtrEUiiphJZxq8tpCGUdmTZpIkWjJ4yQrrAHhg8
         KtgfeMHO88lPLfM7M5LibhLZwWi1uYZhLQ7BQ/xuF+DjBdMvC3G2jIULaD3AYjBNu1cI
         Y+vm8dSbAYdKImgZ3mpBrcM8dKiJFlR6pcW330Mr/zsvSoJVNAh+U8b+eWyn3W37W1ND
         TWlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+30IB3rdWtkusr3Kk2mwuTZZOlVvouL1ofPIk/5BUq8iE9MF2cVYiAXW7e1ny9gS/oGwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zA087ztf0ap6roF7CFNng7RcZ5VoVmYPlzrITL+ZRua38i+p
	606AuQa5G//i/8nhclB+4Qgcdl4sbJqT+PDA9bjmSSeOExNnMVxJ9EWu31a+AIOse4+xU8oRLxK
	tA9olQg==
X-Received: from plfn12.prod.google.com ([2002:a17:902:e54c:b0:2bd:2711:a0d3])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b8b:b0:2b4:63c8:ce18
 with SMTP id d9443c01a7336-2beb05a4cd9mr9918675ad.12.1779405444904; Thu, 21
 May 2026 16:17:24 -0700 (PDT)
Date: Thu, 21 May 2026 23:16:45 +0000
In-Reply-To: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779405439; l=1755;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=/MQdgEc/h7i+uzxsvqrPX6CKbZfIx+FZ7QuCfWgiUcM=; b=zYqPKl+0PgIvqPdDBBtRymGcofvU8gAR4TrOXAPOM8BmRvbWUfMGwj0bzxV7hqNZ548vHmcsB
 dh012449LQTBUi2V/D6kMZO8+C0pOlo7VqJm5OW7mceFC2nAQeLc5VE
X-Mailer: b4 0.14.3
Message-ID: <20260521-tdx-selftests-v13-v13-4-6983ae4c3a4d@google.com>
Subject: [PATCH  v13 04/22] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
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
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
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
---
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 868ff62e22f2..e5c998874a0d 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -110,6 +110,18 @@ static void tdx_filter_cpuid(struct kvm_vm *vm,
 	free(tdx_cap);
 }
 
+static void tdx_check_attributes(struct kvm_vm *vm, u64 attributes)
+{
+	struct kvm_tdx_capabilities *tdx_cap;
+
+	tdx_cap = tdx_read_capabilities(vm);
+
+	/* Make sure all the attributes are reported as supported */
+	TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes);
+
+	free(tdx_cap);
+}
+
 void tdx_init_vm(struct kvm_vm *vm, u64 attributes)
 {
 	struct kvm_tdx_init_vm *init_vm;
@@ -129,6 +141,8 @@ void tdx_init_vm(struct kvm_vm *vm, u64 attributes)
 	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
 	free(cpuid);
 
+	tdx_check_attributes(vm, attributes);
+
 	init_vm->attributes = attributes;
 
 	tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);

-- 
2.54.0.746.g67dd491aae-goog

