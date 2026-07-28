Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F5F471268;
	Tue, 28 Jul 2026 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250227; cv=none; b=Rz6Ulm9dd7+S6EWpP2CywzXbe3wEt4kn/VVEMHI8fQcuVytUcFoY2bQ966tNq+Jdp8dkAvquMhh07BoT8tfDnUXw64wO3oMHK8uN42+fFyUNjZZSSYjDZG0W1fENj+p8Fjz+8feo1r1hmioqahX1xGQcLVa/yUg32uIkW7+A7ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250227; c=relaxed/simple;
	bh=6encH/kyeAS7IyRKUSkmiicMoAetd9Tkv9Ji5r/3ppw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5fnujz79SEXAMe3x2IknRMW8iEQy38ocGLCr4YGFlKE7gCH+LZvFMqvtPJhcD9OXeOP94ilyHaStXN6/cULXOy6R3Z23ZE0eGclilJtkJvJqlcl/zUNxYlqkwOUjCUwAFQZR2QnfpkfwNFptEPKHrZGq9AKHuEXrlGk58UZ728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=osmvVwXK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="osmvVwXK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=u9O6eMJWPEiCuOzOKx7hWrotGcpuvpoKHiLFSq+dRQ8=; b=osmvVwXK3BKgOGHTz3sUtx96/m
	MVqS38yzmvoisPEV4JzC8iatafIsLOvPbq2WoaXL0eyurSYWe5ZpyEbk/fKjgX1Y219V0NhLiNLjy
	sfBFcLNp+K8sW9GeErWzYSt+wDd3mUdylsDI1Xn7LH7jfI0/x6W4NIsX914Bc3mhweI6xCi2PANEg
	ZRA1YaIJytIo+pGgSqv/toZ6/5C3A0M+6a8jTklX5vbPhL7B0HDJCcIZxACI3vdi+XiIUT3fQEmUn
	OqhvYfXy+wTehcYsu2OnMeXQRIetKHLG2LEWFUwd/8tlL85xjmTwJ6uEfe+n4ac0zT5aatCCpYHSS
	Qi/4nLtA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woj80-0000000DUP6-2hqC;
	Tue, 28 Jul 2026 14:49:57 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj80-00000001UZl-1jZF;
	Tue, 28 Jul 2026 15:49:56 +0100
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
Subject: [PATCH v7 30/36] KVM: selftests: Use UAPI pvclock-abi.h in xen_shinfo_test
Date: Tue, 28 Jul 2026 15:40:10 +0100
Message-ID: <20260728144954.355376-31-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728144954.355376-1-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

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
2.55.0

