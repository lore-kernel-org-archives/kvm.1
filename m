Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5654519AB
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517592; cv=none; b=hwN4Y9x3reLei/ROQvZ8BeHx8bd/iOrMCVHB5mETee1n5dkaVhlwm1gM0xieYm36ZVUamP88J/FmsxixAbYwd66AE6M2iK8Zns6G7epV22q7nNgAFQz1xVkxbIefmxz2a7H3t3RJNbarrn7CnuZ9+AsOHSftcXIN/1812HnvwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517592; c=relaxed/simple;
	bh=atVzo7J4szz2vu/UetIPVOdW3jQWtD74LNLShVxaLFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l2IHKxJYj1ZlzFKVJrrA7yg2+37tvScRohz7MeBwEbLErL5JYfuehU1h+JslOfPz1POzdraiP8vUkbPeD5yHkoPQUQUIzoN6BTCCnnw38jxTzypdkno72P9ezCD21U4Ob70xuDgIQYzyIRkd+4ybvld2DipUqHZ+VD44AhAG2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVXWkOpd; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVXWkOpd"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee894b3d8so21416115ad.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785517590; x=1786122390; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9BfMO7lDi/jb9f6SoYoHXqiGNPLVG4w0N20HXOwKIiI=;
        b=mVXWkOpdh2URIG9DjXaAvsa8d0vLxYEfMfce4LvuEKQAURJVu/szuHTQphibaelSK+
         aku5OTJeHR/SjM4Gx+ehS7ejNpdhB6BBmGD0rN7ksl684fhxQduiDXWH92AWqxOBggop
         +MfRjaumNUEUrsA7cGiUwUFEchyp2I8qyNRaggyMCrPsJp5XxrZ5nWpgurCuocof9O5X
         2bJ91v1/M1GSVJ29JGRWkCNxRCoaFZcH7YqETeF9NClUEIL7I3k+3iM1oLdnJ9lIV7Tu
         0QatfoOJtnaz4Jxjz91Uxzy2VyxIxLKw6VSvQVLkvZ22dekk36PEe4xlpRPAWOWg+5Xk
         MDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785517590; x=1786122390;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9BfMO7lDi/jb9f6SoYoHXqiGNPLVG4w0N20HXOwKIiI=;
        b=kC6Cs1s/99W06keHCFlpxZkx4w9xLRknwI/h50ENE1/EGCW6n++vCVL+APmAM4/zVK
         C8Vl9Z9uNlfMfJ6qD7JsxNtIXHLYpQFLkNxelUrphvDtGr5+dkZru8U03SDrjRtbUpn4
         iVKNFxSfZr+MmEu3rpzST7tWje2T01f6xe0j32+RKBq+SAciMvPe1+RImVI0mnbCVmzW
         DZ9itXbJfzEECd86UY9+poMEcBSyc9Jf3U/HtGmbvb4O/jod6ujT5M+G078oJHrFoeSM
         e7I1zMOEEBTdl5FOCoVX11qON/7Fu6ne3ldkfEUB2AGK08ML21C8Wj+ymZHLGIJqVISC
         pMwg==
X-Forwarded-Encrypted: i=1; AHgh+RrTc1tsZsQ1R5QerRChvYz1pfHRgAOS77XW9g+wKbQuJ8SRFSTOVFjFLkgCQbhP8Dw5sW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcYMMr54FPg95mv5aPlm+8YHkzQBAd41UV9M5VKAhwc0mRdvpU
	vPxKT290HCsWpjxNCM7uQms7pDqcAk4crl6FVz9PuLK35DphamTIF2E4dJbY9VzwSjOUZAUBfMP
	AuEVhoA==
X-Received: from plje10.prod.google.com ([2002:a17:902:ed8a:b0:2ca:e62e:eb94])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2d1:b0:2cc:6817:d9bc
 with SMTP id d9443c01a7336-2d0523e6ee5mr6994735ad.38.1785517589951; Fri, 31
 Jul 2026 10:06:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:06:13 -0700
In-Reply-To: <20260731170619.2620845-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731170619.2620845-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731170619.2620845-7-seanjc@google.com>
Subject: [PATCH v2 06/12] KVM: selftests: Affine threads to random CPUs in
 hardware disable test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Affine the worker threads to random CPUs in the hardware disable test, and
honor the starting CPU set in the process.  Hardcoding to CPUs 0-3 is both
wrong and less interesting than running on random CPUs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/hardware_disable_test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index d8288147b0a6..bd23c1300370 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -149,12 +149,15 @@ void wait_for_child_setup(pid_t pid)
 
 int main(int argc, char **argv)
 {
+	cpu_set_t allowed_cpu_set;
 	u32 i;
 	int s, r;
 	pid_t pid;
 
-	for (i = 0; i < VCPU_NUM; i++)
-		CPU_SET(i, &threads_cpu_set);
+	kvm_sched_getaffinity(0, sizeof(cpu_set_t), &allowed_cpu_set);
+
+	for (i = 0; i < VCPU_NUM && CPU_COUNT(&allowed_cpu_set); i++)
+		CPU_SET(kvm_pick_random_cpu(&allowed_cpu_set), &threads_cpu_set);
 
 	sem = sem_open("vm_sem", O_CREAT | O_EXCL, 0644, 0);
 	sem_unlink("vm_sem");
-- 
2.55.0.508.g3f0d502094-goog

