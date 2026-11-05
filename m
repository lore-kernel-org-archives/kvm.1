Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922477;
	b=yUHdgzokUlgmU3HY7c8dynWrIIgW0eW/KYFH3HH20QIZjFNK7z0Hwq6iZ/0rW4+2VLde
	 AFXFCqPizFcS2X+ZNhU44Jpg058AAe1j8Qhd4in7lopCyZFpemwVOoMV4nwCJJqI+wOrP
	 HsdyjVWYiikG0Cfz01eOziOFiCnTSpFt+M7guTBAztvfB7gm/bFknt3B1UKTnNOK6/heX
	 DJ3tL2plPk0isXpBl9v2MS/sMoZmAwzpiqE0YTOVataLUJLJeYuatgBMJGTv5Mp3DLS/o
	 7sgHRW/1AoXDtaWo91/we1uya+A0AmirN1tFtP5PFTyfwM0vK4rRBK19McMnX6m3nGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=1FN4tBVcJFBQsla2n8tME6jrjpUGnwmxW8ysKp7MZ+A=;
	b=HWnHsBvffAGo54wtHDlyg/mIVcnA9nZxngQbEHWceWm94smHxQHr+zlN38Q5D2Knl1iZ
	 Zj+m4xunDSTR8zSCSN3wavcCjMb3JOeDlfHNTVgWtVZdGDqaUYD08Vq0GHpYG3+EuPgoy
	 F6SPHT74WlXcK+JYmCnQLknKmnS1Bh6mYNXRxf9WgG0sSHxXEq2p81a2I+mHYHNDiMZcB
	 daY9y4eWBIwQ4Bq5up7mmbb07jLQ0vfsBaNVTCWPWdr8XHR0/wA1mBtWrl1OzzygC9hZn
	 vpv2CLubLmfuN6F/DT6y44iMgr7Q+JJ9i5W6LTPc4Y1uPqXT1lbLAaHdDeplpX2/J3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jy6Y5LoA;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EF9606EEBC
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07EF9606EEBC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jy6Y5LoA
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ea63087d79so508335ad.3
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922476; x=1794527276; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1FN4tBVcJFBQsla2n8tME6jrjpUGnwmxW8ysKp7MZ+A=;
        b=jy6Y5LoAXvg4vE7inRX70Fpp79JhbAQ2adAOHZouP1MhbtECMUVlcmyVdD49ePg4GA
         t2O3CYYWOkuCDo0s7sLCEx1nnPW8YXoU5BeJ3RQmWg+KODmTcvOhk/KaGvfUjcAmetc0
         2vXlYL8sPNfjT1dAA8dFx6u6Hao6l6PFK7+iK4x2CIQYQ0WyW8SBNWtmRMWEaV5+3BNU
         fuB/zTzFkVpMlu/FkI+no4yHv1JAefNZgwL7kXRFDQCkDIA6GwI9+hcx9cRZFYYf8LNq
         66dEWiy3AH6xVoCVSwPOeI++wTUuyHKv9nYw48DZQwsjBrMS6QjKBjoDXE+vKPK4C6mF
         Z6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922476; x=1794527276;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1FN4tBVcJFBQsla2n8tME6jrjpUGnwmxW8ysKp7MZ+A=;
        b=OEwAWO1vY3nkymy6xZPWsVLhUoKVqnBTLmNYTCh3VXHP5uuKmLqMuTq50ohu73KAEW
         zD8xQ3Lgh4Kp7he+SaKXihGzW/9k0x2iAlY5QSIRcyZXn3NokQ9EjLXD1/h+7vpzhGv1
         1LwKoL2VX71wv/7EaJIpqVzQvn7Q/daItdyfe/MmCxL3MY7aTe4rsNmfJdYAY6QGEcg7
         6yS41i6dPSJCvpK1snZKCV3fdNZrRNCKzsentG3tBq3848dJPomJ0ulJwYDisnPL3U07
         WK5vRotU15qLTUjs6qSbsHnRuHPSwP0RjFA1DexHjPVxAUnWX+PZ+Ylqxmwp/ARaarr9
         atnQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGmeyVjRAitmmAQ4X/yIXryDpOU6r+vBN3rWzzYIgcMRDYa9O9fRUNosLZaB/J/PylZOI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/u8bQQzf3FAxbxDFEz0qAIpQ0DBcD/q5xAuh5SiGmW36rnigzS
	/FyA5RRJei56XH8fU7YmpwL1Z5lifoWZdXLeHn3BvTemfpbMbUH2tKRW2eMCuS1oM7VY/8kq6/5
	yvbAC3A==
X-Received: from plnu5.prod.google.com ([2002:a17:903:1a45:b0:2e1:326b:da73])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ced0:b0:2e9:6645:e99e
 with SMTP id d9443c01a7336-2ed40c48331mr10886805ad.28.1793922463383; Thu, 05
 Nov 2026 15:47:43 -0800 (PST)
Date: Thu, 05 Nov 2026 23:46:55 +0000
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793922452; l=858;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=d6A7oZjd0INte2bacSdXjbStFoBPPx7rvs9xlbLb3u0=; b=9jtIvl+Z+cMjsx274/HuhhAQ0MpGSG0pXW90v5FO8GZuKjRtHljxjeF11lqZ99IZQl8XR/8JE
 EqPOy1Nb/shDDVDDDMoSkur5WKepYwfyJnbEp+GLF3pMlsAKq9tFrTh
X-Mailer: b4 0.14.3
Message-ID: <20261105-tdx-selftests-v16-11-2024e8fa517a@google.com>
Subject: [PATCH v16 11/20] KVM: selftests: Require guest_memfd for TDX VMs
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

Force guest_memfd for TDX VMs.

Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index d42e201eba76..b73a7bfe8531 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -494,7 +494,7 @@ void kvm_set_files_rlimit(u32 nr_vcpus)
 static bool is_guest_memfd_required(struct vm_shape shape)
 {
 #ifdef __x86_64__
-	return shape.type == KVM_X86_SNP_VM;
+	return shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM;
 #else
 	return false;
 #endif

-- 
2.56.0.455.g6c5a503b38-goog

