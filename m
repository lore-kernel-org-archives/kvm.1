Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC72470E93;
	Tue, 28 Jul 2026 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250226; cv=none; b=Mfy3TsrOGrBqsFvdLWgzK20X6cuKR2VAAkPWfohR0R78+vUkZSk7KnrsYbtA4kB85ePz0fzGc11IYPscAyslTSKWfHy3b2uYqBa9OC/I8Tm0ir8PbhZVWgOXUJ2U6R6ITLjDsDiDRaRZknsD4Sq2SF/bgBXCeANOa4dWY4D4dYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250226; c=relaxed/simple;
	bh=yJgRDSFIsqnSj79S3dXtz3Z86Q8woSUIvon8TTss9/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsxXIJ+vWaUF9ALDJtlfqh3fDA2DBTWmAvLTw5Y8P9LmS3iXEuWGacEyBAfrTa7QSyhiE6XzN1FeAB8zPKwOSRSU4+eovxptTYr+d8G56SiTqLFUSlnQ385g12MJN9eIS8QOO4mQZZrVNh703lcuVCHB3U4vh1aU53W/4/JIJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k3sg5sh1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k3sg5sh1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=4VY/igWUqNSJOEWywP/U3Qrf0q3GjhRxhpOp9zM//ng=; b=k3sg5sh1Feq7DCYO0jDXScowpK
	bffW+fbxmlKRgpEweZ7JGgTlwVBVdVSJur8POhpUe+THC5dBHhdLdBB8xzjT+dmXGm/p2vdVM+rJd
	9WNJjogAGZy3xZWrui+kQNG7s+a6YiMPq0+AaQUmkxRBtQmA+Aq/F0N5mb2ZlImdKJ3PAa45EYTEp
	vSzc1pI1PKi/0KkJnyKgUaAaULfEQWLNTgrMsMZrKHNG3Tkkzout893NSdhu06r4NCD4wLBmC3qVw
	MdmFoAbnAmXbncNrwyVF78jJY6Rbfuc90Cy/wO9y69oDu6EvgSyPevFDxgoa9uR5qWFsADRZQzxLg
	sQKGEmoQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woj80-0000000DUOm-0ID4;
	Tue, 28 Jul 2026 14:49:56 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj7z-00000001UXy-0SWc;
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
Subject: [PATCH v7 03/36] KVM: x86: Activate master clock immediately on vCPU creation
Date: Tue, 28 Jul 2026 15:39:43 +0100
Message-ID: <20260728144954.355376-4-dwmw2@infradead.org>
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

Previously, the master clock was only activated when the first vCPU
processed KVM_REQ_MASTERCLOCK_UPDATE during KVM_RUN. This meant that
KVM_GET_CLOCK could not return the host_tsc field until after the
first KVM_RUN, making it impossible for userspace to follow the
documented TSC migration procedure without a dummy vCPU run.

Fix this by calling kvm_update_masterclock() directly from
kvm_arch_vcpu_postcreate(), after kvm_synchronize_tsc() has already
set all_vcpus_matched_freq. This ensures the master clock is active
immediately, and KVM_GET_CLOCK returns a valid {host_tsc, realtime}
pair as soon as a vCPU exists.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f7e1031f8eb0..dac9264497e8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9434,6 +9434,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 		return;
 	vcpu_load(vcpu);
 	kvm_synchronize_tsc(vcpu, NULL);
+	if (!vcpu->kvm->arch.use_master_clock)
+		kvm_update_masterclock(vcpu->kvm);
 	vcpu_put(vcpu);
 
 	/* poll control enabled by default */
-- 
2.55.0

