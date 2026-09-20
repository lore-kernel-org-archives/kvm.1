Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007F847209C
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933054; cv=none; b=D25yOCrT29smyQfAKJ5LE65mviPqzz80CUrToQiPuKF7/nu9yiOKn5/ONXGpdQMcC2nyBcWxVziHIAXkQ96H8KWrZMVO9dGUYjY+DyKcO92FCbT0ew5tC1cCLziGK0uX8XS5EEOtxbNmHE6EP2Ydf/bnBHHhV5KlVwr8WkU+nEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933054; c=relaxed/simple;
	bh=xr/NZJKBK6CUnL1RnXkkMJeJUXfe0jmUB3ZL22elyF4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rN9ymychK6cgoDAmV4lsXJn0WC4bupYhzHNB50bvy0RuXn7xA3E7tz4y8gkZid02jib4pCxI8+Qgc2AlO/e07EjgK5Dx62A8T+ezJnCh4cKSZGrwSFKYlO1VISl37WhHE+oVFZbt16j0jZAFk1eTmwenwgjH3NY0Y1mnh1nzvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=SOBbeJIM; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="SOBbeJIM"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aae314aso1691183d50.3
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933050; x=1790537850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qTv8uFL1FYxhccWvDyiinfq9K+eUMO7fyy31bgvC6E4=;
        b=SOBbeJIMCs38dv8ZImJY+/7eltfI47qWOWzjYQxzXxAdJlAv2v/CCIDUatv+1nqw3c
         hYSbqJliDWfpOL9Igd56oFok7OvotwogIUTZ60Opz/cuqCRWDSG89RZ8V94Oa9nxKrEk
         oisxF1VcLEp8aQSIx/YAhRABu9FnA1gKzIgUIhkYijeZl4FB+23WSEumOdcyJxgaAZf5
         zuba/cQuvFK4PZetvfUYfNB5BG4Y5OXfqehUeOz4HqVIy6JxMZT6UL6AAJRwUKk/O/2m
         1TK3J3fvo8FDuVlHM2vsFvNJarglOrI1XWtKsM/Xt3VM8jZ8ih2S43qvO1/Xxiiclp9e
         aQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933050; x=1790537850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qTv8uFL1FYxhccWvDyiinfq9K+eUMO7fyy31bgvC6E4=;
        b=r42x9hN6J8U2EfRBu9S+YwcmMao8iXRjhfuIkjDm60xDPMaQCxqVGhprkyjwutlq92
         1bBA12jhMPhydSmJTJKImxQQGZqc8ApZYSWZph9jzLCDOVZ7DQIK1QmPQLIBLGpKgaPH
         46Um6TC/2YxFq4wCcTin2UU8amXP1uHzaF7ko1HR7ptsh0LvrM+qlUEC1QbNn4xwkySd
         pGF1IQ3+DSjeYGiVncMhLiTMyFIrULMmKUoNyriXgCNWF9OMnSHdOUIl8IBrptdfyzRj
         XV0fubFqRKAowWCKH5UJmNNFLaqMCnxNzcgf2/bbmhPNZ2UTGjurlOfQGL9xFhv+dSGV
         n6pg==
X-Forwarded-Encrypted: i=1; AKwUvBzmQzW7LCqYlvaX664xf97DFdJVes/FFzHTTQ1/oz1cOvWf6IWTHGP4ymMigs7rM0F0yxs=@vger.kernel.org
X-Gm-Message-State: AFuF++npWBNqSijVuvaZEw7ts1PVZ7S90NEt5CaPci1yGJ9EZBw9ZMOj
	knKNLr+3PURPdcU8EDP/C7ViNRN/cP7U5FFW3MB1RLsdJslu0A7bN3Iq89EOiNt721Q=
X-Gm-Gg: AYBFou22oUj8PgPSuUdZ5iQ9qmPXSrMxddtgwO1TFcGpWmGr1GMUpf41JkgSLCUKt40
	rPt0ikzkVCDH5F2JuVSZNpshc9oONEN9DgcavHJOqwwCDS+xk2qGgsiYR5XDpMlN479FjwlYVNq
	X+Vi3o7M2MhBCYPt9iyN2sItNloan/8sBgXkINjOd1xnPFMoXGyEvWUraVQAt+37ZDwaHwdYQG0
	Jm2BVuTedzooX21acZfG3UZ/eoy8iP+OpmMQdQdbPMQNuiWN2u0g8loN693LxTg3OYOdrEKw4vb
	HbmWR45MWfkhKFbw30yJLk0uXFoP+EOU6wWMzP9Jyn4Wk4JcKAM9BDUUzt7NLOSn8KRtmeW7Zyy
	et9ZgmZmkW7xlqKCWvnpygf7OxHJkTstNAMvdnuREbuLK54whZbuzUw0iJ1IwZro0g0FsexXwJO
	+Cgyo5LdbMFRZ8pW54Xg1Fg31in9F63bAKMgVIOfxIsVhb3FTBm8WcEFbVgLI40OpQ4E0/Yk14I
	8MdiklIVJrrxMhzCAX//e8LtZBlG+EpPrb6gi53GEslDZqYqe04hlKRP6dqzO6j/7S+Zx63JVni
	t+LF0WQeQhXKKRHZKx1L
X-Received: by 2002:a05:690e:134b:b0:671:70d1:d6e5 with SMTP id 956f58d0204a3-6717fe597a3mr2639510d50.87.1789933049997;
        Sun, 20 Sep 2026 12:37:29 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67298f64c7esm2656294d50.2.2026.09.20.12.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:37:29 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 06/46] x86/smp: Skip offline CPUs for REBOOT_VECTOR in native_stop_other_cpus()
Date: Sun, 20 Sep 2026 15:36:10 -0400
Message-ID: <20260920193650.3373435-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In native_stop_other_cpus(), cpus_stop_mask is initialized to
cpu_online_mask minus the calling CPU. However,
apic_send_IPI_allbutself(REBOOT_VECTOR) uses the APIC broadcast
shorthand when enabled, which delivers the IPI to all physical APICs
including offline CPUs.

Use __apic_send_IPI_mask(&cpus_stop_mask, REBOOT_VECTOR) so that
REBOOT_VECTOR is sent only to the target online CPUs in
cpus_stop_mask.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 985103cab16c..2449d15c6667 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -192,7 +192,7 @@ static void native_stop_other_cpus(int wait)
 	cpumask_clear_cpu(this_cpu, &cpus_stop_mask);
 
 	if (!cpumask_empty(&cpus_stop_mask)) {
-		apic_send_IPI_allbutself(REBOOT_VECTOR);
+		__apic_send_IPI_mask(&cpus_stop_mask, REBOOT_VECTOR);
 
 		/*
 		 * Don't wait longer than a second for IPI completion. The
-- 
2.55.0.1082.g2b9226bbc0-goog

