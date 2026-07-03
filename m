Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED40354AEB;
	Fri,  3 Jul 2026 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113847; cv=none; b=R0grAe+iu7Vor9auVqGOM1B2JfGo8JsZYuunyDjFl7neHOV6nqK7/jMIUF73IdLvP+jBhQYV56JgdSQboz0IblPrvkO0n+mp/PGIWjKjUN6c60fzHhRsw8CVEngtB4gn+IfBCVgnATsJqaYMawOJ6dpy7bwLib57dM6d/EwsoSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113847; c=relaxed/simple;
	bh=9WucuRjmFigLVBvc+AnU2nY2aTMZF+aQnYUyWhYFKU8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWQeHyeCA25mEacjAv02hdrIIRBUlJ9Hm07oudUATsPDi6Cg9AbKnc0F+JdYcIFXAut3SA/eXdY7Z5hWMk/8P34/GmsIlZTFOryO1RhrviL2JqHdCdj4pZ5ublGh4hZqtyrR1dl3lvUWgupiCePuf+oVo9UHG1wNBH81TB7ljTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ag/RZYPY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ag/RZYPY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=hH+knYn8nTd+TnpfZC0k8V0fYdXUF8AZtKckehaVSow=; b=ag/RZYPYcN4fVre9EsOS+cOhgG
	SwK+HBXd1dgEt76oRFLUyPps4X6KBXzSXwZeG8u4bPBlS1lY6kQQvAcw3N7JBu/jgw5Oe4TmfsCbY
	cGsWk+shyieTGRcnmmdvQW3sYKZmi87gbtyJxTa9TzZQfKD6AJliCrRLqmacRh4oYvoPEd9VQZYHP
	+EBg6NrRc7a+h2xbCvCY2ik3TtHc7gqWcC1e6ZFSOkCHviU9BxUopFV+Av+rB7l/zJUI5VuUCrOlH
	sKBpN9uwsn5Q2ooxq1gQ5H+fO3FvAsMOJ+0Fskg5ceKnccVTWZJB6lTZZtjdD9iLxY8ozyYLaNuNg
	BCA7oq3A==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKc-000000059Nw-41Pc;
	Fri, 03 Jul 2026 21:23:11 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKV-00000001RO1-49DP;
	Fri, 03 Jul 2026 22:21:47 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 04/36] KVM: selftests: Use UAPI pvclock-abi.h in xen_shinfo_test
Date: Fri,  3 Jul 2026 22:17:43 +0100
Message-ID: <20260703212145.343527-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703212145.343527-1-dwmw2@infradead.org>
References: <20260703212145.343527-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Now that pvclock-abi.h is a UAPI header, use it in xen_shinfo_test.c
instead of locally duplicating the struct definitions.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 .../testing/selftests/kvm/x86/xen_shinfo_test.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
index 5076f6a75455..2f241ca4f096 100644
--- a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
@@ -98,22 +98,7 @@ struct sched_poll {
 	u64 timeout;
 };
 
-struct pvclock_vcpu_time_info {
-	u32   version;
-	u32   pad0;
-	u64   tsc_timestamp;
-	u64   system_time;
-	u32   tsc_to_system_mul;
-	s8    tsc_shift;
-	u8    flags;
-	u8    pad[2];
-} __attribute__((__packed__)); /* 32 bytes */
-
-struct pvclock_wall_clock {
-	u32   version;
-	u32   sec;
-	u32   nsec;
-} __attribute__((__packed__));
+#include <asm/pvclock-abi.h>
 
 struct vcpu_runstate_info {
 	u32 state;
-- 
2.54.0

