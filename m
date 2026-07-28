Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB4471240;
	Tue, 28 Jul 2026 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250228; cv=none; b=h/tp2Fy2TjpO9J5s5kLIb8Xc/Zgi2Cen2D4cskZ/7WiiOjg5A4WX66GDrypjRMHeH1bRhwDRReBA/TFzD32EafiVmzR6zRKIXwrCxF1aCG9ZRM15lqP4qUBYteZJLONNTnvxuXuLRnB9YCTHLYonfHEIzPFtCsntvH2urN9jmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250228; c=relaxed/simple;
	bh=OYAenOSwDlpEkzpw/hZuIU5NlBxY7fp1IqBeYOPZPDE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3Tbm3VDTJIGd/D3hozQ1W3lqXjOQPlm5gt3r7rrApFnfCqgMIG8KQzUkV+aFqlZb20kVlHPjI9lTelt498QZADPQ/8+F1LpUQhsGkwbRJBZhg4StLo6EF5Df1Hat29C6aw+nm0Ir16U/c9p9JZjIeXdKlhD3JAIH4SWdTNJ+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DZKx6RFv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DZKx6RFv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=TzgYEQycZnk9NREs4BkWOyKg6Tp5meskn+6VMFWWmpQ=; b=DZKx6RFvQHAQs1Ojm8AZEO8oH5
	EdXrPppB8RpLp8SjdUC5USPmltd9ZTJnJIw5OXYR+xL5uk00Wq5GotDuiSIBZWs8I7i9yKwfNhMS/
	NsKmg9j/6LwR4eRzAhx9sKuy6/J/fX7nU9Vew91XzYZFeUPOwTEyQOa+SP0vveHaHr3VzVtraDzJ5
	+KtPwFC7rybqp1C6uDODOJ4kuNDepZeX5+DXeOn8r9xA7tooRGLs+EQhChjOHFQdJY+L61w9UXoWY
	mi+pT09OFVSUvomFpPWgAhWBDSNzkLG88+gztgItGkkEceaXLXT5+vp3fctgF0m+6PyB560hhcyru
	bUk+dNTA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woj80-0000000DUOq-0Pyj;
	Tue, 28 Jul 2026 14:49:56 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj7z-00000001UYJ-1rI0;
	Tue, 28 Jul 2026 15:49:55 +0100
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
Subject: [PATCH v7 10/36] KVM: x86: Fix compute_guest_tsc() to handle negative time deltas
Date: Tue, 28 Jul 2026 15:39:50 +0100
Message-ID: <20260728144954.355376-11-dwmw2@infradead.org>
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

The compute_guest_tsc() function computes the guest TSC at a given
kernel_ns timestamp. When the master clock reference point
(master_kernel_ns) is earlier than vcpu->arch.this_tsc_nsec, the delta
is negative. Since pvclock_scale_delta() takes a u64, the negative
value wraps to a huge positive number, producing a wildly wrong result.

Handle negative deltas explicitly by scaling the absolute value of the
delta and applying it to this_tsc_write with the appropriate sign.

This is believed to be unreachable in practice; no path has been
identified which invokes compute_guest_tsc() with a timestamp from
before the vCPU's TSC generation was established. Fix it for
robustness, in the spirit of defence in depth.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f7a9fb69e69d..52c9268007f8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1054,11 +1054,15 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
 
 static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
 {
-	u64 tsc = pvclock_scale_delta(kernel_ns-vcpu->arch.this_tsc_nsec,
-				      vcpu->arch.virtual_tsc_mult,
-				      vcpu->arch.virtual_tsc_shift);
-	tsc += vcpu->arch.this_tsc_write;
-	return tsc;
+	s64 delta_ns = kernel_ns - vcpu->arch.this_tsc_nsec;
+	u64 tsc;
+
+	/* Handle negative deltas gracefully (master clock ref may be earlier) */
+	tsc = pvclock_scale_delta(abs(delta_ns),
+				  vcpu->arch.virtual_tsc_mult,
+				  vcpu->arch.virtual_tsc_shift);
+
+	return vcpu->arch.this_tsc_write + (delta_ns >= 0 ? tsc : -tsc);
 }
 
 #ifdef CONFIG_X86_64
-- 
2.55.0

