Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C938330B
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405463; cv=none; b=dOANF151ji/35RPsGWUuZU1wty5Y05ZWIueufDYYwxSOqCscHkZrgP33ixE0XqCFu74/MAg0oJWn8VpO7R9RJgaI7NPImSk1rdFvLoTPoa6fCNU1+dJVMis8U++GAVMixea9uOter0abYcHQS77KPzzsN7ojPxDp57CSocc7X6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405463; c=relaxed/simple;
	bh=+rj8HdSHGEhojQ7IgQAe3od4Bm4zlB5m+0z7Vws2xRc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=paBn1q96KtI/mJ1/9BRC1/aBlI1u+xS6K4ZEHhkr4/T1Ac7rZ382Y4VSN2vnno3FW/54Z2dDqhasYto7YN9ecEs0RWTMbEs4zG/gCiavKUVzDwHkq3RV+G15ruXAyUOw9abdl7+bqsostQr4t8O0iLqcmDmVL8aHmVaDzdkFd0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFmgJxAC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFmgJxAC"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8271fb43d0so3743413a12.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779405460; x=1780010260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhGG2DtcnCiC+oKMx1JOkOpW3lOdHy6oBy4GULprYek=;
        b=bFmgJxACJRDZeR3oNBSDf86wGctjBX/ycFTGaI4QypixXcc8MESCXB+Bb4XN83cGsP
         90s6FJP258nnc5absq0R7G+9dbPURycfp5CZOrBtAB8XMZeJBxm1yO5Y8kSR8+l2FBMF
         7pTxmFSp7kQ9DfB+6ThMXXRP9qHwxjVdjQVZEiGAuiciEUMq6VNBZvg0tWSXdqe72mj0
         Vv25Fw7lN70X4QB+vpUshMQiylWTqEHPdil5grHrNBBv/CoT7EQXRO5av7NNaczk0Rk5
         +d3XmmafcD+CzCDZwXHzVqLBIBrjId0sVp1sD8R1iqsnpV/ixJDym/IfqbI0JvHAYrqu
         IN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405460; x=1780010260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhGG2DtcnCiC+oKMx1JOkOpW3lOdHy6oBy4GULprYek=;
        b=q5fQehZAbCjpV5HNTZIAtC+f8UNuPOA2IgGXv+hBXPaxhFJcPr0o4J59xkiu9I57ez
         q0jrPluckZOnNqkAcAtgc4faIhDcP+l3OsI4ZvAj5fsZkHPAJY7IzHidCEb+mr4z9qDk
         Wslb2FlDtuTPAqb+wj12Em1dReH4vupeNfQUQTXThg/DMPwQLIenwPG/wsEp3p9CK//Q
         KV56HyZS0bPNIqZ137vBokZbOIF5mXAM5z0meYTffA8K+q+3Kh/VrXb47skwYIa1vRvv
         ent72mniLvBM5U2zvz3aa43R2Lw+R9XQjhykHFMEEFJbOcDgbeoB3dx8iZ6eac7Z3lb0
         HN0A==
X-Forwarded-Encrypted: i=1; AFNElJ8CgVBbKKGliHrv3MMzyYPozC9r/QxeK/9KllZzxu8AZSgHYxU/Ka6eEewCFKiuaJimPQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/t0Ewu83Xj0ZxbcTHECuw7fMnNMSSCHTT+u4YeYPyTDRwmuJV
	8A0cUmqXIN37KkdDGkldJ9GmhdHKXebVQ1sWtp78XOFiVspQbJt/lNEvq3qcknV+ZDBO8vgSlnN
	sqZI8hQ==
X-Received: from pgsb14.prod.google.com ([2002:a65:67ce:0:b0:c85:ee9:99c3])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:710b:b0:3a0:67d:bba9
 with SMTP id adf61e73a8af0-3b328ee2ed7mr1019403637.45.1779405459717; Thu, 21
 May 2026 16:17:39 -0700 (PDT)
Date: Thu, 21 May 2026 23:17:00 +0000
In-Reply-To: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779405439; l=924;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=ccR5ndGS6WaEGGKnDriFBQqfNdifwiO8tnHvq+Owx3g=; b=5LfgH9iFywMpz+YNeOHtbEmwTzX+pz7DIQLwELzaq4GRtVPAoB/4CQiStEg7wk3xvZ2lvPtff
 h7VGW9tRei2DOyJ2e+8GDbhY0R5t+W2EUeToVlbgyz7F53tcXI2BvZw
X-Mailer: b4 0.14.3
Message-ID: <20260521-tdx-selftests-v13-v13-19-6983ae4c3a4d@google.com>
Subject: [PATCH  v13 19/22] KVM: selftests: Finalize TD memory as part of kvm_arch_vm_finalize_vcpus
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

From: Sagi Shahar <sagis@google.com>

Finalize TDX VM after creation to make it runnable.

Signed-off-by: Sagi Shahar <sagis@google.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index d84c629a1945..842cac168e99 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -1479,6 +1479,12 @@ bool kvm_arch_has_default_irqchip(void)
 	return true;
 }
 
+void kvm_arch_vm_finalize_vcpus(struct kvm_vm *vm)
+{
+	if (is_tdx_vm(vm))
+		tdx_vm_finalize(vm);
+}
+
 void setup_smram(struct kvm_vm *vm, struct kvm_vcpu *vcpu, u64 smram_gpa,
 		 const void *smi_handler, size_t handler_size)
 {

-- 
2.54.0.746.g67dd491aae-goog

