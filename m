Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3943DD520;
	Mon, 18 May 2026 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088216; cv=none; b=rB0Q4uqRy7sUg5IsBgWoDIuixCUn9QuW5WRXkdSN3G31G0HaGKS8F/LB/QxRNgGqaGamSjqdWDVZzkAeJkpTt9+ZWjDAB0LNXRDLBroz5mlijsbSAirLgEcDbp6do1CTQcXQobByUdrDcissa6KnPiODhHvzldnkJSlafDAGz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088216; c=relaxed/simple;
	bh=xtIH/4mERXH2wvxslvtKq1AdxEHv7sj4R6drGYQC21A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nCIvqnJOPpg9mY1xEZqdqUVlQkiwtsZuy44RPaT7v5IkR4jYatbBL7NCQtMXuFxXf3VCUQ2Zph1NzupLCaMau4QPgSPT20no2DoDzWh1IUBWhRXI0gdMy75f+SR29ix5RYrgJHzhPqzRV6y8Zwsb/qHTc4QRFJ7A0kgM3+ZfzZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tn+ppsfv; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tn+ppsfv"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779088211; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gUwGrpFMltA08R1NHB2JZj7EPV6l6F6JkAn6Z5kjg0w=;
	b=Tn+ppsfv+8XHZflefKubGXkzMKJycMVd/XBwEMRadrhcxRaZw88pMBxrBnNd4YcIiGDI5n6Sq2C9izJ4ecC8DIos+q6/QB6cr9z34rcJ29TvL6PEdvWwzxNRF77Av2T5Nr2cnrhpeYTb67ULnrk+bLVA4U5KSsTFEIlTuTA2n1g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=zongyao.chen@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X35823W_1779088209;
Received: from localhost(mailfrom:ZongYao.Chen@linux.alibaba.com fp:SMTPD_---0X35823W_1779088209 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 15:10:10 +0800
From: ZongYao.Chen@linux.alibaba.com
To: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
	Zongyao Chen <ZongYao.Chen@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Fix vcpu_get_stats_fd() ioctl name
Date: Mon, 18 May 2026 15:10:08 +0800
Message-ID: <20260518071008.2091335-1-ZongYao.Chen@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>

vcpu_get_stats_fd() invokes KVM_GET_STATS_FD, but its assertion reports
KVM_CHECK_EXTENSION if the ioctl fails.  Use KVM_GET_STATS_FD in the
assertion so failures point at the ioctl that actually failed.

Fixes: 1b78d474ce4e ("KVM: selftests: Add logic to detect if ioctl() failed because VM was killed")
Signed-off-by: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 2ecaaa0e9965..04a910164a29 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -876,7 +876,7 @@ static inline int vcpu_get_stats_fd(struct kvm_vcpu *vcpu)
 {
 	int fd = __vcpu_ioctl(vcpu, KVM_GET_STATS_FD, NULL);
 
-	TEST_ASSERT_VM_VCPU_IOCTL(fd >= 0, KVM_CHECK_EXTENSION, fd, vcpu->vm);
+	TEST_ASSERT_VM_VCPU_IOCTL(fd >= 0, KVM_GET_STATS_FD, fd, vcpu->vm);
 	return fd;
 }
 

base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524
-- 
2.47.3

