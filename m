Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDEA3A0E84
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986092; cv=none; b=b0qcoiZ7ctA9s3ozEa2neBg7AUA6mV2sFxJ1iJO1dxvWW+ENVaDcAmsY4S4/k8A8pwTtnYGVSvJpo3s2iKsspJUjyM78OB5Xn4NtuGdTc/oCPB5ja26AQ4VjC2mPfW8TSe0G+t/vxxgRz+0tHL69L11AicWVXemftiOoyAjbwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986092; c=relaxed/simple;
	bh=58cFLdpitxGGWcLke1cml+qI2XyT37EYeRp751zQOLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LKv4DeOwud27m8WppH8o71gedBacy9Wm5UGDPoNac/yeTbOz2QX9VNuKoAwUYi1KRfM2RbEclkCEr1wuPNvldMryzF+e5K6SxSYO3aBrLevubvf2JdmVBjlItbB6oQ4Ig6MejAP5V4ZClVSJv1KLP2FCQPDBEnIoJH83ePpJgUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hztrblSv; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hztrblSv"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82cd9fa608bso2605946b3a.3
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986090; x=1775590890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=njfCCiI28ABRtdawHv/3+1Vm0xQbr2N/1Tf3iGIg3/c=;
        b=hztrblSvup0nQi0Wm0fZPeuko0mayh/nG4te1Kjk2qtF4VDpPiJQ+YgA/RbQtMSd25
         B1orml9wYTduT9lBKhCmceKHjw1AO/VmglBPoBRtz9q6dH52qgLfnVmEVI0zwow9CjB2
         m4ZhvtUimTvJx/M1pYhhsbqWGjkqLVE8PBg8BghvpsUe1/kdPKDBkfMA5jV0WRUEDKhL
         uDVhsJBeW8i4DjXwrJ+HGN+QzlFbepDpL47Z9aQM2Q3WuGFLLjWn9LNxkEFRKYDttIWN
         KcUwMMTbnFBpIxiIK6nrhvbE511NRATvrpLiAcBoLDR7HUnRKAXurgM2sbcsaXOVvoN3
         NHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986090; x=1775590890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njfCCiI28ABRtdawHv/3+1Vm0xQbr2N/1Tf3iGIg3/c=;
        b=ezC/5f2vQfDXHsLt5TOAHLGhC8WC2LzU/D8hNhdfDwC8Kxeobn7PihdFBFpKyG59i0
         PdUDGtKyl/KmjI2mu1DiXThzLsR+s/7SFY+LfUXck2gi9VDwdh48+IeQokmYwaG9UQdZ
         1+SvJzR2TvnkAGkzbB+pMsD/KNETIER3b7YZVJTPZlPzGXIBdztRr9Y5myU7ERPL3KXL
         gh917/8Qp73++OR8kMOhUcUI0QDe4q8qfR8mWfF+WesPT7sl6TRlnpdjPpLM5D7vJhX7
         drWJuHLz9QKA1KahShcA6ja4uh4FrV5j7N7mVDiLHKVTTk7IOmirJrv0u/eYjaiFk+AM
         TcfQ==
X-Gm-Message-State: AOJu0YyTHIM4l3B5W2pXBH6E6V9VWyq8MOtIeUlgaz/yZ05L+byq5J0P
	gCaN0bcSXPG9NvKx0cR5NwN4byKYnpfZg31GZHeJ9H5yGnYpqEDGCHnkoKoZrvh/YnfIC0lX0SO
	V24LHS13H
X-Received: from pfbfk3.prod.google.com ([2002:a05:6a00:3a83:b0:82c:213e:7964])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4086:b0:82c:dc17:2918
 with SMTP id d2e1a72fcca58-82ce88e077emr878462b3a.13.1774986090175; Tue, 31
 Mar 2026 12:41:30 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:40:23 +0000
In-Reply-To: <20260331194033.3890309-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194033.3890309-5-jrhilke@google.com>
Subject: [PATCH v2 04/14] KVM: selftests: Reproduce tests that rely on randomization
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Seed srand() using the KVM_RANDOM_SEED environment variable during
selftest initialization. If KVM_RANDOM_SEED is not set, seed srand()
using the current time. In order to reproduce a test that relies on
values that are set using rand(), the test must not call srand(), as
this will override the call to srand() during test initialization.

To test this, run a selftest:
$ ./selftest

The first line of test output should look like:
Guest random seed: <guest_seed> (srand: <seed>)

Then to reproduce, run:
$ KVM_RANDOM_SEED=<seed> ./selftest

The test output should show the same value for the `srand` seed.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1959bf556e88..63c882b5f743 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2349,6 +2349,8 @@ void __attribute((constructor)) kvm_selftest_init(void)
 	struct sigaction sig_sa = {
 		.sa_handler = report_unexpected_signal,
 	};
+	char *env_seed = getenv("KVM_RANDOM_SEED");
+	int random_seed;
 
 	/* Tell stdout not to buffer its content. */
 	setbuf(stdout, NULL);
@@ -2358,8 +2360,15 @@ void __attribute((constructor)) kvm_selftest_init(void)
 	sigaction(SIGILL, &sig_sa, NULL);
 	sigaction(SIGFPE, &sig_sa, NULL);
 
+	if (env_seed)
+		random_seed = strtol(env_seed, NULL, 0);
+	else
+		random_seed = time(NULL);
+
+	srand(random_seed);
 	guest_random_seed = last_guest_seed = random();
-	pr_info("Random seed: 0x%x\n", guest_random_seed);
+	pr_info("Guest random seed: 0x%x (srand: 0x%x)\n",
+		guest_random_seed, random_seed);
 
 	kvm_selftest_arch_init();
 }
-- 
2.53.0.1118.gaef5881109-goog

