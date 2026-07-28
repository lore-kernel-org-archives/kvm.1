Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BED466B7C;
	Tue, 28 Jul 2026 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250221; cv=none; b=VGsigt9m0XbNrNC9avVu3kF+ZXiK+9TFuQIkjpH9cPujV4KCP+NBaW5JYh6jK66ZsL/Dgnhit+Q0fi+rXC21go3tbVgQdxkxxcerNLdLhMaK0KRJZuIdyYfZQww0AkSpkeiPK32ByGQF1sLirvCAIk7irw1ZJm45Dx+CiYjLUu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250221; c=relaxed/simple;
	bh=8GN+lsbybtgcR9dLotBpQHYBZOG0KiyS9gcCpR8jlEo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDy6P4ZNbxkUXUfaltMYcpLFayKkaNbNZ4r1tKY59agtFYj3FoyEZs4Shyw+D1TGFtWZKichDfzz5aPvcdiyvUPTPBd3To6frhXSJJreWq4hAeEKvXXv5FPahtqhECUTn3+unj4SWoewNM9XzNYup08ll6GCGASlvL/NLKY52i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EZXf/fjJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EZXf/fjJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=qkfTVUiMDU3wKVqEggFLaaqFoc9wZ8/CDkXcDl8wfs0=; b=EZXf/fjJb4bOv4RLTciNzKGITv
	yW5CZm7kcCdngyDq5Eqa12QMXVZh9we9s4k6WdQMnX+WVIczKVbyAnkS3W91RTszUtVKEzCBw4UL8
	VkshZUr3RNILQ1iQnos08xmZMd3rmjXrQRxTBVqSNbhZhDK59AnNSEiJ1uHmKgbDqKU2HPTUya0Q3
	wDz7oviobriZSOeV+EGQXokzr0bSE1RXIcwHLbw12rlpI6+UiExPionyLGoUJRBj3f39waio0KBtz
	Ggv5MCuUvBMMOZUcBzDe8SPB44Hj6+uR6JNFtW/AqpyaKvZXHmS8ZVgy1gjQraBTJu5fNxkrRxskV
	Dc5DUoAA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1woj82-000000052VZ-34kc;
	Tue, 28 Jul 2026 14:49:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj7z-00000001UY7-18gQ;
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
Subject: [PATCH v7 06/36] KVM: x86: Drop CPU pinning in get_kvmclock()
Date: Tue, 28 Jul 2026 15:39:46 +0100
Message-ID: <20260728144954.355376-7-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The master clock branch of get_kvmclock() pinned the task to a CPU so
that the rdtsc() and the __this_cpu_read(cpu_tsc_khz) would agree. But
ka->use_master_clock can only be true when the host clocksource is TSC
based, which in turn requires a stable, constant and synchronised TSC
across all CPUs.

Given that, the open-coded CONSTANT_TSC || cpu_tsc_khz check is
redundant (with CONSTANT_TSC, cpu_tsc_khz is tsc_khz on every CPU and
KVM does not even register the cpufreq notifier), and both the TSC read
and get_cpu_tsc_khz() are CPU-independent. Drop the condition and the
get_cpu()/put_cpu() pinning.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1a598e99852c..590a7ba723f7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1659,12 +1659,8 @@ static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 	do {
 		seq = read_seqcount_begin(&ka->pvclock_sc);
 
-		/* both __this_cpu_read() and rdtsc() should be on the same cpu */
-		get_cpu();
-
 		data->flags = 0;
-		if (ka->use_master_clock &&
-		    (static_cpu_has(X86_FEATURE_CONSTANT_TSC) || __this_cpu_read(cpu_tsc_khz))) {
+		if (ka->use_master_clock) {
 #ifdef CONFIG_X86_64
 			struct timespec64 ts;
 
@@ -1685,8 +1681,6 @@ static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 		} else {
 			data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
 		}
-
-		put_cpu();
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
 }
 
-- 
2.55.0

