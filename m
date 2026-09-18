Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424164E36F4
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731405; cv=none; b=lDNRxhfIAPpdHMgnshd1Eki+zOQkH7L0mU9ZFoPd5hKhZbVnl3fVshiJ4oYp/FMRJdbMQAjcA8hwkBIBFJw1BSKxpPbt0ZSmy5jSOfhdlUcxtFtx1RltBVzcO2stiVUrL8sK1VymQPgoB9nH/Osahagrha4lRJ4+dNNbAtfGfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731405; c=relaxed/simple;
	bh=UV2MS265JeG/XFufAaOIglzfguLQfCex0JpmNsNklXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ToYVRaZoopRa+HAT6gLneKPpTlaCBD2iL6y2rB+W1ma/pIYWgqtcnTwQlilTlPH4HCxLXLBbzY5DvHw2STHlk30xmpepyKrrmzqaPPHr0WQBVMGWAzecPXuV5MtwokhAStT3UaInrLNhi9j5PCIdPHgPHyVo5vQ72EdS9+92y04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANcyKfNn; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANcyKfNn"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc515bef69dso379846a12.2
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 04:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789731403; x=1790336203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K3/YTpNBvG9JEca/s1uHfv5ByQp08abPn2Zh1wtqNdk=;
        b=ANcyKfNnJsqUL/riu3aFN9O+kzhsJDwxyhf73w6aJgSejjbt5e7dWZKaQ0Vv6LtXQt
         RqhAmbFRoZr2upqUEUiyV7PmSxbC3NGlXaMR0tB3cmKO8KDMh3v86rtLDUPeoWTPqGi0
         XHMtj4efJX/i17f1YufN+aTFMICFZss9L6oPglwPxb1+3PulelXNvoVFsq3kodoSLVCJ
         GtYx3cOufcIf7mvjzKeCVAIFK+RAxGzCMqWEfVvD01gnJ75Jrrsbam2rkoEdv4D6DeUU
         p8CrUuFHYbl6RpEdXoBTy5J/m0xPRHHlkSOyYOZ0YX7YijVmdNojYKzxuGy27Fp0cGJR
         1x3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731403; x=1790336203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K3/YTpNBvG9JEca/s1uHfv5ByQp08abPn2Zh1wtqNdk=;
        b=WGqe8j7FIHIoZDCRQoqa3b4GDtP/S2IFHXi7jWcvtHkhxTvidOXJPAlOIUagyItMsg
         T8dTKFFAj6oqnQ/0pu/PZp/DaEEFY+AyoU1ZodDcsORStODL6MRjH88MHopuz7DD9gvd
         iDMsEYBOTJCAeg1UTfosSZDYt43SNwDnFdlPXfK9ZtW945gg+YP44hph21Rd7iu+t1KY
         Hu9fXq543gnrVkEbamIDrLqT2KUH8IUvuALj0y3zC2TSsSjcMTfUR/QGpXEQQPYUyPoD
         zZzQiQo6R6iypyMAbICUfl4HSb25oXUo02iCEV/o6LQ8y4ghlGHc57lxfkAJv2d3OTJG
         vDMA==
X-Forwarded-Encrypted: i=1; AKwUvBzNDA4TgqilrW80sp7TJNK2HJeuks/2317HYKai48iusRkBql2gx1+dJaPlDQ4N23AUULI=@vger.kernel.org
X-Gm-Message-State: AFuF++lYm5ZVtbWoE7kaFhHGf/ME90kPHcnczbFKvBlb0tLf4Y8MtnFX
	VF+3pOzbDf9W0eVCgVfzrS8cxrI6N/lpxyWxN9xT5kVy2vH02Xe/ngCb
X-Gm-Gg: AYBFou380Xk3267W3GimvTcJeojfS3VihfsUwG60CD11Adg9S5mYhNzqvqlh3OJ6iPP
	+gV3OhX1eWTwb0iOMnACoF0EblbZm/1Jfl10R+lrzIhiA4JBWM8HDWhL9p6R5X/Dn7RxSYgI2YZ
	dIbtA2JbYM9NoXxaNfSh7B3VT7WIVpbx3vB04zarGL4Z9O9atqSaBJRWzL0l1Hsy0TfqzouDR55
	Rlpg2Aw0JtQbzrWGQAImp0HjJXXnRVoZIldqpMWKSCGgr+MzHTftNCQjwP8EMwGnrnNS9KVLW+I
	cAH0f8GR7EzrfyUAfxPCPE34QhG6RhD1KeqQMskRuA8oGchL7FyekLiqNLp6QJz6i7YhKi+z1E3
	usvkw4Bk/U8oH+Vb5+Zi+6ZGfReH6a2eFKZ4DKx29+6qkxYgjP1U85mtIOken7uCdcAvJBWwEk6
	Xo1yow9rRo0quh74xgFvZOsLlKi9n0JcG1xT7TCH5wakUtDiVUC3iS9isZkg/NfH5jHUGqJnNbJ
	I+fORvWI2uhpV2dcjnpo0I=
X-Received: by 2002:a17:90b:4e85:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-39e54d5ca4fmr4800851a91.24.1789731403361;
        Fri, 18 Sep 2026 04:36:43 -0700 (PDT)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce069246sm3922628c88.15.2026.09.18.04.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:36:42 -0700 (PDT)
From: Gokul K <gokul02k@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] KVM: selftests: Delete three pieces of dead library code
Date: Fri, 18 Sep 2026 17:06:28 +0530
Message-ID: <20260918113631.634233-1-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three unused things in the selftest library, found by asking the linker
rather than by reading: build the selftests, then look for global symbols
in lib/ that no object refers to, and check each survivor against the
whole source tree by hand.

  1/3  sparsebit_copy() and sparsebit_num_set(), neither called
  2/3  the declaration of vcpu_set_cpuid_maxphyaddr(), which has no
       definition anywhere
  3/3  guest_snprintf(), a varargs wrapper nobody calls

Each is independent and they can be taken in any order.

A note on what is deliberately *not* here, because the same scan turns it
up and the obvious next step is wrong. sparsebit.c still exports nine more
functions that no caller outside the file uses - sparsebit_all_set(),
sparsebit_is_clear(), sparsebit_validate_internal() and friends. They are
not dead: they are called from inside sparsebit.c, mostly from the
assertions in sparsebit_validate_internal() and from asserts in live
functions, so deleting them would not build. Making them static and
dropping their declarations is a defensible follow-up, but it is a change
of intent about what the library exposes rather than a removal of dead
code, so it does not belong in this series.

No functional change intended. Built with and without -Wextra, and a
sample of twelve x86 selftests gives identical results before and after;
kvm_binary_stats_test and the rest still pass. The two that fail here fail
identically without the series, because this host's kernel is older than
the tree.

Gokul K (3):
  KVM: selftests: Delete the unused sparsebit copy and count helpers
  KVM: selftests: Delete the declaration of vcpu_set_cpuid_maxphyaddr()
  KVM: selftests: Delete the unused guest_snprintf()

 tools/testing/selftests/kvm/include/sparsebit.h    |  2 -
 tools/testing/selftests/kvm/include/test_util.h    |  1 -
 .../testing/selftests/kvm/include/x86/processor.h  |  1 -
 tools/testing/selftests/kvm/lib/guest_sprintf.c    | 12 -----
 tools/testing/selftests/kvm/lib/sparsebit.c        | 63 +---------------------
 5 files changed, 1 insertion(+), 78 deletions(-)

-- 
2.51.0


