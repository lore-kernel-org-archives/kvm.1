Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF85349A3
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883536; cv=none; b=Y21Z1dhDo7KyEV+bAIU/zBw6FY94uIgNUNztx623l3rqspYBmVJXQOL5SPMmE9Mu26Mv52mLNUAH6Iwfs0vACLwooPHgSOKmzYiQGFfXuMfejiJYWvtQvc498Uf8ff6otpvJXpY7YLVrfZ+2LW8fpQrhGt9rk2fCTx0uqXavo3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883536; c=relaxed/simple;
	bh=rVoqZdUCo2KLCZ0DuRpcvKXgw+ek6KfWqB9aZuvQsSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bjyv+9zvrcrP7oVD5ElXleJ2IVc/4X1Lj1g/Fdnx27PYo4Z7lMv7/tNmSuwY8WKmnU9TWcvvYkjbGwkOtudfNdAuGz8DQG9DhzV0OqS1I1XGOTLQTGPSsGRt1bT8pFj4yF/mgxq8ytOjqqQiOseDSLNQ46+58X7dWVUQy6rzSvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mker/Wte; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mker/Wte"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39d865b11b4so7321890a91.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883533; x=1791488333; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U9nVGqEblihe3RvMwmuzVW7+thHX4Pda1dDAZe/9upo=;
        b=Mker/WteagJ7zXK23NoxEsvzjzbtdOr9uj9UDem8o+BqlM2kzQNAUIYN1nodnL6Cbd
         gZlx5XfCWTz2YsAlmh+GUNiACUx3EJ2BHdkfbRXjb0t8z6Tv7AEcVWgnVt2F24zqJeXp
         rs1PVgi9us5hHy4+xx2nB/LX50PmUiqUPliBt/xpAeYUbA10OSyfdOBQZiIMoLAmA7tx
         CJMKpQ5JzScCZdujqFrFQjHcE/WzUVEzmGaSdoxCU2kfnwh33LsW9YZs8mFP2KSnfMqA
         u5funVVNa6LLQtBu2W0sr8oo961pl7kK79CVa8Lj28wlTOaIIWDrTZT2nOi5wvcwGi6/
         ysOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883533; x=1791488333;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U9nVGqEblihe3RvMwmuzVW7+thHX4Pda1dDAZe/9upo=;
        b=PP4+Ygt+/2PXu5V2A3gHskJdzd4LNDiOsY6fq5Pi4GC2Ho800ynvT02mE4x7I4mYpO
         eIoXetMqn8OY1Bj8deiNx7G2P1FP7GlDom13szFsO+um/9yxIz77QpPJlwqizOazAPol
         C5aYEhScFPtACbX0jU6/bbgGN2qVeNyFsDXKjyqVGu5WJSdMor/XavrtRKL10OdMi0+R
         hwHXqFqBlF9zait9KUL8Uts6GCTFTDa8MoLs5n0WR8YVluII5rcOF540e1h0x3Rhc2Ur
         2pEesqUbiDfzwshjpCW1XhpDRdy8IQjpD0MGYvIzYNNkw9IlV2nytaow4ApGZH4t9I/O
         /xsQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKnguoDGLPquPX2qar0z+GH6dfKVhJK6fveao0UPRMYTRQxDyjb99ZT2Dq4J3yam/Nobo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWm1bYGBK8iFmhEXbtRZEyzlkF7F207VVR+Q5WymicFbsIwodd
	4n/WLLOlumjQ2BXGR+thXeBs5DDhvpKdnVtr7fVyPl5jzmiLAfV+53l9QH5ZtMALbEhr/eQIUu7
	Qw+jweg==
X-Received: from pjbkr14.prod.google.com ([2002:a17:90b:490e:b0:3a0:ab35:7895])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c06:b0:3a4:a2f9:f2f9
 with SMTP id 98e67ed59e1d1-3a6cec2c079mr518533a91.52.1790883532437; Thu, 01
 Oct 2026 12:38:52 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:39 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=814;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=rVoqZdUCo2KLCZ0DuRpcvKXgw+ek6KfWqB9aZuvQsSE=; b=XlRY7AWBOUyhMCsHhrBnJ4ws7Y0Oy7c2izI2AnJ10Jo7DjZMksQQ6ELZsUa5n5xjQUGWTnd0d
 3EVQL/48+8ZD8BDU8W1EV39wxfLZIL3YsuulJzqoEdiwJIcfVgEqUJi
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-12-7c62a5d8a992@google.com>
Subject: [PATCH v15 12/23] KVM: selftests: Require guest_memfd for TDX VMs
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
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 3f559f207408..7625908caf21 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -482,7 +482,7 @@ void kvm_set_files_rlimit(u32 nr_vcpus)
 static bool is_guest_memfd_required(struct vm_shape shape)
 {
 #ifdef __x86_64__
-	return shape.type == KVM_X86_SNP_VM;
+	return shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM;
 #else
 	return false;
 #endif

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

