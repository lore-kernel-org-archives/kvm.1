Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DE5212542;
	Mon, 18 May 2026 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088195; cv=none; b=ZzNxssEA8svyz6vuTRbQAGjDz84/taVOWPIwpVPdsFj0UUPFPOrSvdoz1IDIJMU9FDRFHS++vZD0xOeLTm1RYSytlZDURvYR2q0bOyrfCVLTMQwDQz+t2u8LlvIHaGAkh/tOjajYvt3UUdnDEGZDendIuXaFzLVScAmpSWQtGdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088195; c=relaxed/simple;
	bh=MZt3zrrOuQ6j3aSkcjKxapv8kh1Jmcafl/bVwPzOnBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nH/e25NhhSFgq/s0MPZhFSFxwxvrlI6kQrzUzm7vPY7u4oU6EdNVZHwtRn6euDZOBAZOpf3hwEUnLipEQ6DebkigQpdiDM3rC4QF0DVhhuD5ahLkPzKSDdOOwordsTvDMYIb+rLdx+QIl0qxNWDDW3sOPE3j1IUQjEFWkcJ1VIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DvCERlVb; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DvCERlVb"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779088188; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GGus9qqluPrxEpYVBgD/gRXbj00WM39RLXVF9HVjWlM=;
	b=DvCERlVbsvEzIAjf6Yhey+S1XhGikC10VmAZFp2BKGgkVD0yhnf+lfWVlrWWdALVJ4LzSNi/qo0GCICxrfZ5Oe4P6RTMLaWOcdYtq6y26je+1PV/1sWZGz/7wW1azGf5j4zkvxvuOcjQ1JpcTJWLQnog4vVWpyXqJ5F1wh3TD/k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=zongyao.chen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X35JQ6v_1779088187;
Received: from localhost(mailfrom:ZongYao.Chen@linux.alibaba.com fp:SMTPD_---0X35JQ6v_1779088187 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 15:09:47 +0800
From: ZongYao.Chen@linux.alibaba.com
To: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
	Zongyao Chen <ZongYao.Chen@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] KVM: Fix guest_memfd binding overlap errno and selftest
Date: Mon, 18 May 2026 15:09:41 +0800
Message-ID: <20260518070943.2091287-1-ZongYao.Chen@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>

KVM rejects guest_memfd bindings that overlap an existing binding, but
currently reports -EINVAL from the generic error path.  Return -EEXIST for
binding conflicts and adjust the selftest so it actually reaches the
guest_memfd binding overlap check instead of failing earlier on GPA memslot
overlap.

Zongyao Chen (2):
  KVM: guest_memfd: Return -EEXIST for overlapping bindings
  KVM: selftests: Test guest_memfd binding overlap without GPA overlap

 .../testing/selftests/kvm/set_memory_region_test.c | 14 +++++++-------
 virt/kvm/guest_memfd.c                             |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)


base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524
-- 
2.47.3

