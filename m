Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433685;
	b=R3qA65iA9YnldxkGeX4OZ+szJH8Lq4e5Yxq5ItyBNaxbD9A9kZG4u3K6ToILqMsZAfYz
	 23zsMYs2TiqbX0r4YGvJyDDPLytqO0mTpp3Y1b+TTEmu7R44160/1AoFyIkIWwc93nxvI
	 WPtcAcEdeDFZBGuCoDGzo/PQeWe98Y0VzzA/V+W/fiyQQunJfQRx5mGXYkHwOr6FYh7aN
	 3rJyDna4fYzcfMSujpFSX6TtElWHgs63NlhpF216kmpeb0/BMBOMrrVqk+frwMrUdPxEw
	 cRYBzyCGUDFw3NMIPaxw2ZsjtP5Hu5ItiIzpHg8kkEqQ6L957faNcjuoIWZz3ZIT/vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433685;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UppeewSJQTI9wML/iAiukB2NfsE5bh7Xk8VoIJRzzKE=;
	b=oS5C49ocRzs/0FzWVaq1/FBlR23VCdDqCM3GzbZgDgI5Krq6D7H0Ue8NhVPXsn9IwbHj
	 eFJpmtDweGLHpQ9NNwPh9qBRRftlDrr9CVyckRYODAisIWrj8QSm4WCjzv17nD1FgKiQ+
	 KtJotatR4uyru+gUu7MPCqZjv2mlkAN+yMUT/F2yK1j0R0g+DMejNouZ6al+SuijXGAPk
	 vHX7CcpiEgbaBD1Oxu36MpekjhdzExQ+qJQqdoisCI1eI5TYPtU8c7gMJ2jcgalzGOUuG
	 +vy0s3n8gYQkcBaLGsO31hZ5wcsjMffbOU+JtG1jjJEFv7l8qufqJd/wq/IGCCnmJDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G0TQwbQf;
	arc=none smtp.remote-ip=95.215.58.220
Received: from mta1.migadu.com (out-220.mta1.migadu.com [95.215.58.220])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE6B606A685
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 11:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BE6B606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G0TQwbQf
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kJVYvwnmwcWNzEw2JdWH14aPDZC8p2gGMQyighOKNqY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795433683; v=1; x=1796038483;
 b=G0TQwbQf7Kj4y/R6ox6nny9M8jPCzE187Ty8ReY69/nju2wzoC+y5I9ya0vYj9QW/3FWlWyH
 G25nR7EQEz3etHUljY+sBKLfq+jmR6sCb2TE89hKrsEC2encTA8VdM4IZNCEMihAEQlDswljmJj
 inhMt+6tpk4fOfwl+SEyyLPs=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9a34595c63725e53;
	Mon, 23 Nov 2026 11:34:43 +0000
X-Mizu-Trace-ID: 9a34595c63725e53
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	kvm-riscv@lists.infradead.org,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH v3 2/3] KVM: Warn userspace against ioctls while an exit is pending
Date: Mon, 23 Nov 2026 11:34:34 +0000
Message-ID: <20261123113435.1170711-3-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123113435.1170711-1-fuad.tabba@linux.dev>
References: <20261123113435.1170711-1-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM_PRE_FAULT_MEMORY sets run->exit_reason to KVM_EXIT_DIRTY_RING_FULL
when it stops on a full dirty ring. If an MMIO exit is pending at that
point, the next KVM_RUN on arm64 and riscv doesn't complete it. Rather
than document that case alone, which could suggest that other ioctls
are safe, warn against invoking any ioctl other than KVM_RUN before a
pending exit is completed.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 Documentation/virt/kvm/api.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 89eb6be9bc6e3..980ef0cdc1c91 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6974,10 +6974,13 @@ to the byte array.
 
       The pending state of the operation is not preserved in state which is
       visible to userspace, thus userspace should ensure that the operation is
-      completed before performing a live migration.  Userspace can re-enter the
-      guest with an unmasked signal pending or with the immediate_exit field set
-      to complete pending operations without allowing any further instructions
-      to be executed.
+      completed before performing a live migration.  In general, userspace should
+      exercise extreme caution when invoking ioctls other than KVM_RUN prior to
+      completing the original operation.
+
+      Userspace can re-enter the guest with an unmasked signal pending or with
+      the immediate_exit field set to complete pending operations without
+      allowing any further instructions to be executed.
 
 ::
 
-- 
2.47.3

