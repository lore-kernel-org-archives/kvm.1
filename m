Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0618F4C77C1
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619404; cv=none; b=iqugzHV3cJP5r6Ppt+rkOqUzg3621Zl2i8fasQWgviIjnGAkDJeR1H/y3camiIBQeaqwxxopow/QDrQqPvrBW/d3JyRLudUpW2J8K24Pe7+zzLkZtZv0aStJAq5wnym+qNz8VcS/W3Clo9PNjVnMt1lNhmYyBc4NXDXdGJJWnWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619404; c=relaxed/simple;
	bh=RHIFkS5bIy/SpZfntsDxPdmrMtdDGggrbSjRzG9iFFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcBwV7wf3hzaezXIQo0WlSeO5673zZeqUfwRthg98wvCA4p/HDcoJtZVfuCQLAMlwd2sdF830U6y+S/1jWp1ni4tiQTZ2Aeh2t5sYAlqygRSIJLKexeXJnZFivdCRWl8QBmVDxJQNNWA4iRM3KGvnx3wOR9/j+sw9mhW63+BlBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCkRqPyk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCkRqPyk"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3811f512167so227931a91.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 10:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783619402; x=1784224202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vhCE1WQAfzh+0PXxIbWqFOicy2jfr4E0e1kNUeNK4VU=;
        b=VCkRqPykrbI3X0Erw6W4UnHtXTXlVpes4BQMuUb5GH2Lq+J0FTLiK7BKicAVArcZos
         gLGMvetk5ohhg/Pk+Ob8S8eS5ppGdrGu4RDDGKRILTkobbk3vkC0z+5hblzGgCRJ76Tg
         uaOvnKGxIEX1EvpSfLGuRx5h2CWhd93+iqipCl2UpvUR3GKSwM4i7BjvJtTtr/7LAqaE
         mXaNgoP0YlUHfJurg4F8h10IpnPcupVl3W6gRQ1gZ5JmLaC5oPKB1ZARVJtQVW9X4por
         /ANlDHVahb+0wiEyrsGw4l+4aR3pobOj9DDbtpLHSsStU4nRPmHja4GFffpHn6zBSnSx
         qsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783619402; x=1784224202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vhCE1WQAfzh+0PXxIbWqFOicy2jfr4E0e1kNUeNK4VU=;
        b=n7YyTvIdHRLB4E1AQrOSfua/EBu1FBT22j1ePlne2ASPp+i8urusDsc7zY4XEE0s6p
         L19v7SPcy6Em3svCwJreh5ykN8syrGJtVtfpRB0PiQnihJidc4XxEP2p6KlcDBfPIt8N
         xCAO4eGwJHVl/VBnFKLTV5UGtVlRSNtpLo43FqSk2VTs71uhlDboX1VrqOumEmAM7V0P
         MBuV8JTQUZQdtsnB/28zanESE6Ny+9LrkUZ4mOby8fCy2PpovTEIpKPnF0NZ4KamJA1I
         KRfa03tnJYE6jbPp0SGaoIVSh6YISeFUIwJV7BPX6f+J6loLiyTLzXFIMtb/4QdFT4GY
         v4ng==
X-Gm-Message-State: AOJu0YxSEwn/i8h+i6Sc6SPKS4GxHKuYmobavinwAIlHuUfhYvve+dtQ
	2aW3CqEN/z8ULHKDwd3CV6p7Z9XYcN33Vclp1Am++6bVwknrKODiSSzi
X-Gm-Gg: AfdE7cm8Br4xF4pb5UxNJSDXpCHSf8zbbtnQFbw+REEeUTQrV90q8ezRRrtxYsgCdQf
	2FriycOA3VA6vuCyg2hCuO6LOoC6GD6g6Xq0EFBvOu2SMX5cJrTaPaqdLxQrDI2fVTYisEuBFHe
	Pnq6ppJZB2JVy8MjCovP3kt/VwSxPt2qDDHwX3eYn7+lzUzwXAyDndbsuWlgjTNI7QrtqKImzO0
	bbrn4q2M628+0G52tTrbwnWrby49jDJ/XIsw1yWEz5toUaTRQ0f6Eo/W4vMNoeYvDKtXmFNOY7A
	azZ+1YJPzUOK7LJ4jRvpUO+eQAhclzbl3Laj3czBUnqiqTwVtkFjIqSMpOdrAGCpImmmM1AkG/r
	NQ1oWC7BMi69zUMmhr6ub7SkdAK8AeHiKLLRn/FqBKpy3UJH5nvkUNI5jem7U/B7C+DZoD3epkD
	F0DlcP3KX8/iys6aDdj1MC+Vzt2JM0Mc7zE64=
X-Received: by 2002:a17:90b:58e4:b0:380:9157:d6c with SMTP id 98e67ed59e1d1-3893fd5f712mr9180284a91.10.1783619402465;
        Thu, 09 Jul 2026 10:50:02 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3120c8e41fcsm2206765eec.15.2026.07.09.10.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 10:50:02 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hemanth Selam <hemanth.selam@gmail.com>
Subject: [PATCH v2 0/2] KVM: selftests: SEV: address two TODOs in the SEV tests
Date: Thu,  9 Jul 2026 23:19:53 +0530
Message-ID: <20260709174955.628913-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260709164751.621326-1-hemanth.selam@gmail.com>
References: <20260709164751.621326-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series fills in two pre-existing TODOs in the x86 SEV
selftests. Both are test-only changes; there is no functional change to
the kernel.

Patch 1 adds negative coverage to sev_init2_tests: when the platform
does not support a given SEV VM type (SEV-ES or SEV-SNP), it verifies
that KVM_CREATE_VM rejects that type with -EINVAL. Previously the test
only exercised the VM types that were supported, so a mismatch between
KVM_CAP_VM_TYPES and the actual KVM_CREATE_VM enforcement would have
gone unnoticed.

Patch 2 makes sev_smoke_test capture the launch measurement returned by
KVM_SEV_LAUNCH_MEASURE for SEV and SEV-ES guests and asserts that it is
not all zeros, instead of discarding it. A full attestation-style
validation is not possible from the selftest (userspace does not hold
the transport keys used to derive the measurement), but a non-zero
check catches a PSP/plumbing failure that silently leaves the buffer
untouched. SEV-SNP uses a different launch flow and is skipped.

Testing: built and run on an AMD EPYC 9755 (Turin) host running this
tree (7.2.0-rc2), with sev/sev_es/sev_snp all enabled. Both tests pass.
The new rejection path was additionally exercised by reloading kvm_amd
with sev_snp=0 so the unsupported types are rejected: under strace,
KVM_CREATE_VM for the SEV-ES and SNP types both return -EINVAL and the
test passes. checkpatch --strict is clean on both patches.

Changes in v2:
 - Patch 1: fix unreachable fd cleanup in test_create_invalid_type().
   TEST_ASSERT() aborts on failure, so the trailing "if (fd >= 0)
   close(fd)" could never run; close the fd (and latch errno) before
   the assert instead, so an unexpectedly-created VM is not leaked.
   Reported-by: Sashiko AI review.
 - Trimmed the added in-code comments to short high-level notes and
   moved the detailed rationale into the commit messages.
 - No functional change to patch 2.

v1: https://lore.kernel.org/all/20260709164751.621326-1-hemanth.selam@gmail.com/

Hemanth Selam (2):
  KVM: selftests: SEV: Verify unsupported VM types are rejected at
    creation
  KVM: selftests: SEV: Sanity check the launch measurement

 .../selftests/kvm/x86/sev_init2_tests.c       | 27 +++++++++++++++++--
 .../selftests/kvm/x86/sev_smoke_test.c        | 23 +++++++++++++++--
 2 files changed, 46 insertions(+), 4 deletions(-)

-- 
2.43.7

