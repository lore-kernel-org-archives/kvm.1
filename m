Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959F637F726;
	Sat,  9 May 2026 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366930; cv=none; b=P2UslaYADjiR7imdYGW8kcQVkWjwynSucuTcNymEprnlKw6WZaDrOJSEol28jtpb9tSPf2IpF/IAlVWpB0dWfQkIzFX/f2GloRxY9sVg0MQVg0+xkhOuX2DcDcXbuWR8UlwnxJLVMPp/Usu8Vno2HueO04ZggZ25jYQcrC2maK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366930; c=relaxed/simple;
	bh=50xkEmTcBjdx/7TmzehlINKs8OAnf3ri0Cv244yKYGg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNSrSTW68s9YtORQupolUpEiozJ9PL0gXQy5jQ24I1VI2uMgxCtA+7tif6E/FfMYDtv1d4dX8H9aHGFr18J56OLc1H56JBfzHOc4RfGePNzEG5pjL1DPESdjCXH/6rQKwBstmVvOKzLGh4tx1MMDQeWBVkPfMZpiXQPUeSAStAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nkedMhJt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nkedMhJt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=zKn6rM5SNp1NUsYTwVeNP1ZCWEOK4E9JR5PloHDb+Ck=; b=nkedMhJt8F9vSW46ftqs+afk74
	R2kXr8DGF/BR2ZbLetJk7cK8mb7U8wrd+BjH0SLOd2HT+EGkf+eHfiV6BHYj9S3aMKR1w+7RbmCgL
	WfZdFYRkUyitRkvhEwFbn8/RZK606OSsjn+RxBhvg4DRPETaEapIcUUaSBInJkB6+TK5nUtBNgb72
	fA3ZOT6czVLlApEuNGzRjCGH87yrxPogqqE0x+gC0ah5O5nNxLIWkSQaGtRdHx9srHNiP4bM1d0lV
	h0qnlA792499cVUurkX1eNKfWL1N3jMb9S/HMH93MHG6mUxkvvyxBtKCKH195l2JIeGXuHxtogYJU
	dinfu75Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTD-00000008wzE-0SAJ;
	Sat, 09 May 2026 22:48:34 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTC-0000000DhI1-2gsb;
	Sat, 09 May 2026 23:48:26 +0100
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
Subject: [PATCH v4 12/30] KVM: x86: Use get_kvmclock_base_ns() as fallback in get_kvmclock()
Date: Sat,  9 May 2026 23:46:38 +0100
Message-ID: <20260509224824.3264567-13-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509224824.3264567-1-dwmw2@infradead.org>
References: <20260509224824.3264567-1-dwmw2@infradead.org>
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

If kvm_get_walltime_and_clockread() fails unexpectedly (the WARN case),
restart the seqcount loop rather than falling back to a raw rdtsc()
which would set KVM_CLOCK_TSC_STABLE without KVM_CLOCK_REALTIME.

That code path could never actually be reached in practice: on 64-bit
hosts, use_master_clock can only be true when the clocksource is
TSC-based, and on 32-bit hosts, use_master_clock is never set. But
the fallback to raw rdtsc() was misleading and the resulting flags
combination was inconsistent.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9b395c00ccf2..f2653eaccdf8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3225,7 +3225,8 @@ static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 				data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
 				data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
 			} else if (WARN_ON_ONCE(!read_seqcount_retry(&ka->pvclock_sc, seq))) {
-				data->host_tsc = rdtsc();
+				put_cpu();
+				continue;
 			}
 #else
 			data->host_tsc = rdtsc();
-- 
2.51.0

