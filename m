Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B2C3BB671
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093378; cv=none; b=Fxpq2wuh5CvnsmVYaxdKujj8l8XMyLfFGwMUfNFLUoh23LzKsfmqQgsaMwZ+dzBJzEuEURXJ/A23fZktEJM7znG7DBD7XgfE1W+JJIkDBbLVDdeVY4jeygQ1cdb96SdLnzD6HdRwvq18gGAcU76yw6S3YcdlutGbjb2xooREOew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093378; c=relaxed/simple;
	bh=yAMlD+Ut9Mr5Vv3GBz5a6xiUa7kPP+TY0iPeK2IZP3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cXbBU/rM8GoyTgwVxzrIUQ4Lgt1QiJv/fho77iiF0CGJhGcUU7sdjsGwaIIHWtuTTE0KZiVwGmq4oS+1+2zyBix90E6qZlIp+OBzXqL9UKlu9iBXjHf5HHMmZztoocoW7KcHA1M/y27ZEx+jrm2JqWKvtdwYI6z/vJasVBVNP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXci73IX; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXci73IX"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8397b14a689so9148536b3a.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093375; x=1780698175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TO/Qd/fwKscqv3OevgPA+uIhx1kFfn/8CSAsDvSeZD0=;
        b=qXci73IX+54/z3/rLmqRUQeSmg/ZPdxhomI9rOPgHzmDl0B1/SWainOJPYYkhUJ5Zs
         3qhv8sLCmI0G5yiiIW/PunEysWjG0/JarVyfkVgplxOhl9vP4+h4qhD5pxs8YwZYv8Kf
         Fcbc73vnjASbwriUEkz45swcgql4bp4CB3MNI9hxPP96MrnCDLUPzjRgA0UsYMW8CQ+o
         5DHZhtd8MUEow7KrI8c6dFJ7itOkgbavIWoKxNmG3bdqfct9TGsJS2n4FCIW318QpdsU
         T2RzZyq6QQ0CGzMJhY0WNjufSE8RUCrbwmdgQdTuJdpTcbAyn096tDqlC9cNMKtL8NRL
         8o0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093375; x=1780698175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TO/Qd/fwKscqv3OevgPA+uIhx1kFfn/8CSAsDvSeZD0=;
        b=FLniDm4XfDYqyAkyMsyIXK6gtlDict3dtPgOkjLbuq2exB78OSP23n1dxcmrbcRgqH
         /jIfcto9D5MN1MuwOqPg8JuaBrJEAWiEjW65dVCoPtqG5S0IEVEff/kFI3OEwRrxbyc7
         49/n0Vb1jkiCE42F9HoRun+AEkYnzgYHfw52AhVbdQNpPdsUldFSoW0hX2/nFAvxQATt
         VmTwRDzNqda2dTCGiUg3EE8ht/xV5SazlcNZxismfce7Rd8XlRgw9Hvv+lXrdb2tGMsQ
         /1LxD9YQKhC0NkCZKEucCJSeIlvj0IgP+6Q2qVvZ/ZuN0dLBvmCiFqns50nvC7Hrmzou
         +k8g==
X-Gm-Message-State: AOJu0Yz8s8ZB/re36mBWwODYR5pIv+qpM0TS9Zk3YhIpN4txfhdUr8m6
	8RNUy7DI8KH+y6QgF9QcwhoKYOU4Ky2GCSJH+Vip1T7znNWnflg/CfjwjpxdkRBgjnu3/rmB00M
	Qj+x31A==
X-Received: from pfbhu46.prod.google.com ([2002:a05:6a00:69ae:b0:82f:344e:386a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4196:b0:838:127d:a16e
 with SMTP id d2e1a72fcca58-84225394e9amr1230292b3a.17.1780093374509; Fri, 29
 May 2026 15:22:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:53 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-11-seanjc@google.com>
Subject: [PATCH v3 10/40] KVM: nSVM: Use kvm_rax_read() now that it's mode-aware
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Now that kvm_rax_read() truncates the output value to 32 bits if the
vCPU isn't in 64-bit mode, use it instead of the more verbose (and very
technically slower) kvm_register_read().

Note!  VMLOAD, VMSAVE, and VMRUN emulation are still technically buggy,
as they can use EAX (versus RAX) in 64-bit mode via an operand size
prefix.  Don't bother trying to handle that case, as it would require
decoding the code stream, which would open an entirely different can of
worms, and in practice no sane guest would shove garbage into RAX[63:32]
and then execute VMLOAD/VMSAVE/VMRUN with just EAX.

No functional change intended.

Cc: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 2 +-
 arch/x86/kvm/svm/svm.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index d817dbb350d6..1ab8b95975a4 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1135,7 +1135,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(!svm->nested.initialized))
 		return -EINVAL;
 
-	vmcb12_gpa = kvm_register_read(vcpu, VCPU_REGS_RAX);
+	vmcb12_gpa = kvm_rax_read(vcpu);
 	if (!page_address_valid(vcpu, vmcb12_gpa)) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8402e94ac094..526e0fdcd16b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2218,7 +2218,7 @@ static int intr_interception(struct kvm_vcpu *vcpu)
 
 static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 {
-	u64 vmcb12_gpa = kvm_register_read(vcpu, VCPU_REGS_RAX);
+	u64 vmcb12_gpa = kvm_rax_read(vcpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb12;
 	struct kvm_host_map map;
@@ -2326,7 +2326,7 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 		if (nested_svm_check_permissions(vcpu))
 			return 1;
 
-		if (!page_address_valid(vcpu, kvm_register_read(vcpu, VCPU_REGS_RAX)))
+		if (!page_address_valid(vcpu, kvm_rax_read(vcpu)))
 			goto reinject;
 
 		/*
-- 
2.54.0.823.g6e5bcc1fc9-goog

