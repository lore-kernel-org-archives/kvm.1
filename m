Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFCB3F65F7
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745580; cv=none; b=GN+Zvi4BmtMf1DPeDCLv0cXmKeaHF0T+3PqLcrmML9Tsk0LhgNQvPui2tMYfWbBSg1iECEaJJrx7bgP5opVUQwOVVufdqimD4Qn0/l2S8ZJdPR97jdbk5DdC9VwRxy0y89MV23fxkUNZ2kOC7683BmYdwvbRTQsy4cOrxXGHfdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745580; c=relaxed/simple;
	bh=gMaVgfPNUsxe2suAiFliez055qKOvUgJIR9Bqte105A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hs6EnUlyA2BUjq237uig/XMqMwrVEqLRfKhZEpAqN3Y3IiN70iNyFDKJa5uA0g20wHSHbcK9EytT/DbTdddRvPFMEwfMeEbQBKXgbyOjBRyyzdvwJ/tMrEZys3pGthvz38zCZ3M9cl47DzISF7XFh8kXUu7GK0XtK9KrSM4mvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zeo/Y6Ac; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zeo/Y6Ac"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1550100a12.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 04:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787745579; x=1788350379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bc8my8FbiDqjxCZcE9P0+mYGbrSku1wnrvIHI1ZOYos=;
        b=Zeo/Y6AcMExyqFo+LPlJ80uhXawjYFjKMHPFkElDVfveh7tAmRoDclznnOvFR5DrHB
         JgX20MATZM74In7MGvP1FRKxbZh2NGLHrnAduiemj+q4nMaqOs17ds/DvwGULibJD+lE
         AXkxJFY6Eja5MM/9KDze5UdkPR94WAORFm2d6sGFaqwdpOoUFNklukx3OPSyovyJXGOb
         gG9lOsoMpYahNBCu3sGcl9a40CnCzW/zhYkMy68NtnShNS8cTwMFhRyXCfa4V6Po1GKl
         pfBRiBuAslbs2NQKSvn+xANYSXOAFefhGgeUXZP3hKNXqCAwqHPCL2yYod3aGL4GvpHO
         2+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787745579; x=1788350379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bc8my8FbiDqjxCZcE9P0+mYGbrSku1wnrvIHI1ZOYos=;
        b=jeitEkZY88JawwxYvuuD1rE4bBmk3SLynMFaLvDLJVnIvyu7Zl9hAP3mE4IPL949Ec
         Xg5Kj+tngxqbTSfioMAqnDXOvp0T+EH5ZkDrkWtv4PRRfTU/Ng40ulu/j3onQLa0WJFi
         Fqpw4JS9K9s4CUpmllco6vhJvApjl6JXcBox3b6tbO2uqzSaG0mcNKXD7C2QEO+sFbt0
         suAf7mbrXB3bQBQnlIgrxp76XLXfGDpA67261ezJIFeAioU16oGNMeeYZmrqeeF5Q6dv
         Eem+ZMQ7Hr0CiA1y2rpOBlMwmNz+9WL/5PjpmAW74a29HjP3F56yyweVqdzFJkrs/QAl
         rXeQ==
X-Gm-Message-State: AFuF++kdRGt7jeewhK8FOlqAToAs1y16ysHpmjlBHCJc/CmPlN1Xa5YZ
	FQyoATZEVimw1FDMqe5o7LfzHoppWyAYBhaWKs6Sd7+h/sRDC3rR2waj
X-Gm-Gg: AR+sD12//yXMZ16oBFa/RvW0yLl/eTSl3yioCT0yNbmGBHTfTvwr6wV8/zBMYolR8KK
	Ix76Q9CUlaeDfTIxyUpmUqP91pTNlrlMN/uBgEKH2n/sL4IP8ZpHWQAVeBLYGjGKCy7YEcOjcQv
	j9Dn2gj75kqoOQphx8gomAI67sC7ReeES54PgMUThD9e5wyQ2klFsLArot+AX5NJis8kxWoF1I3
	j/eR3t5x+xzThEBDlK1hB9joO+SyRD1rvSbUWEEUaxSfiq0ot7/pSw3QUtI1wtLvNQEXRT8jaL2
	rf52eRTweZ9CFo1/sZ56h5B851G6ylf2kB3c3x91tKwMly3Qz86Pxlwj/3qxD0hmv4wEPtBhYhi
	O8yKl0Xyem6BAYntBVyJ511Kd7hU59pO6cC15qLB5OFS9ODzLmqfO6ronm1CNWTosV7KH7mM77q
	9jZD2rbKHxly+NE+MLofjnA7Ym17CNAmPPFM+X+oQrtr6BpsU3iihj/6Sqw6RdsYAYa4Kcrrhx6
	n0Dv2enMzM=
X-Received: by 2002:a17:90b:1a86:b0:38e:9784:dd47 with SMTP id 98e67ed59e1d1-39645829233mr18130835a91.1.1787745578549;
        Wed, 26 Aug 2026 04:59:38 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eefd98sm14607883c88.3.2026.08.26.04.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 04:59:38 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] KVM: selftests: Actually test PV_UNHALT
Date: Wed, 26 Aug 2026 17:29:13 +0530
Message-ID: <20260826115915.2882221-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_pv_unhalt() only checks that KVM clears KVM_FEATURE_PV_UNHALT from
guest CPUID when HLT-exiting is disabled; the feature itself has never
been exercised, hence the FIXME.  Patch 2 tests it by halting one vCPU
with interrupts disabled and kicking it from another, so that reaching the
instruction after HLT is proof that KVM_HC_KICK_CPU was delivered.

Patch 1 adds the helper that patch 2 needs to learn a vCPU's APIC ID from
the host, rather than open coding KVM_GET_LAPIC as a few tests already do.

Changes in v2:
 - Pass the APIC ID to kick in a1, not a0.  KVM reads it from a1, as the
   in-kernel guest does in kvm_kick_cpu(), so v1 asked KVM to kick APIC ID
   0 and only passed because the halting vCPU happened to be vCPU 0.
   Spotted by the Sashiko AI reviewer.
 - Halt on a vCPU with a non-zero APIC ID, so that a kick sent to the wrong
   vCPU can no longer pass by accident, and enable that vCPU's APIC, as a
   guest using PV spinlocks would: KVM only routes the kick once the vCPU
   is in the APIC map, which is also why xapic_ipi_test enables it.
 - Move the APIC ID helper into apic.h instead of keeping it private to
   the test (new patch 1).
 - Report the return value of pthread_create()/pthread_join() rather than
   errno; they return the error directly and do not set errno.

Built and run on x86_64 (AMD).  Untested on Intel, though the kick is
handled in common code and delivered through the generic LAPIC path.

 - On kvm-x86/next, the whole selftest suite builds warning-free and
   kvm_pv_test passed 10 of 10 runs.

 - Also run inside a VM booted on a kernel built from kvm-x86/next, i.e.
   against the KVM this targets rather than the host's.

 - Whole x86 suite with the series applied: 61 passed, 24 skipped, and
   set_sregs_test failed with "KVM allowed invalid efer bit (0x100)".  That
   one fails identically without the series, i.e. it is the host kernel.

The test was checked against four deliberate breakages, to make sure it
can only pass when the kick really works:

 - pass the APIC ID in a0, i.e. the v1 bug: the kick goes to the wrong
   vCPU and the test times out, so this version does catch it;

 - drop the KVM_HC_KICK_CPU call: the halted vCPU is never resumed and the
   test times out;

 - clear PV_UNHALT from the kicking vCPU's CPUID while enforcement is on:
   the hypercall returns -KVM_ENOSYS and the test fails with

     0xfffffffffffffc18 != 0x0 (kvm_hypercall(KVM_HC_KICK_CPU, ...) != 0)

 - remove the halt: the bounded wait trips and the test fails with
   "vCPU never halted" rather than hanging.

Hemanth Selam (2):
  KVM: selftests: Add a helper to read a vCPU's APIC ID
  KVM: selftests: Test the PV_UNHALT feature, not just its CPUID bit

 tools/testing/selftests/kvm/include/x86/apic.h |  9 ++
 tools/testing/selftests/kvm/x86/kvm_pv_test.c  | 97 +++++++++++++++++++++-
 2 files changed, 105 insertions(+), 1 deletion(-)

-- 
2.43.7

