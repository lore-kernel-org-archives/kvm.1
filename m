Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085C3EC820
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282630; cv=none; b=phQJOIXb4/bjwe+5tjjrKJRpSqBFWoN1qf+0v6Rg8p/jMmvJZyuipBn87IJhnxdvTywrGmZPTiMDiJF4rxBjEUeZtfPkjWZJAqTs12fcSGaDY+xDSels32bsPzUHGZcUF9YwraRJgQwpmbcqOjfEjEfJLW1V+P5by9NuMO1VG+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282630; c=relaxed/simple;
	bh=uQmCMZwihw4Qw9mL/HHStendEYwoKyoVWYrwmVDy4n0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+/nTKl7XQz89CuT3ZwTc+efJZw3shCY5ohfjwBYwl5L0rVGOorrNo37is2Ytu9MIRENG82JuIy5jK97W8es4YugTVOvdaVx5AjpsuFvKs9bpDqIKYSopIec8LGZk2KjFpw2PQJLTOZ7hk1sK/m3C1R1Ej9+qLwvhc4OyYdrMSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7CCoq3/; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7CCoq3/"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-34ceab2900eso536129eec.0
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282628; x=1791887428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EA/0ZEGZrte27R/NKRLHTW1lEfVA+wxAewcBQb4Z8UU=;
        b=F7CCoq3/mz+ZRKa+w2CJA30W+HqSXy25kQJxdYyuaxxJajZhI7bNezA7KrnvqZul/j
         xa0Ihe/cJoZHv/z84lKParXsSwlL7PQnTkgC60mq8n5QWO6qBdsdVzyibAlYbfL8cn2D
         ZxKLCrezDr1ERo6hKjTHQavTCEMqzQLr1NykYrYi1j676uCIKpmH87XJf62Rn3MZk4Ck
         pTnvw5QLLQrokGKvlNO3LS8cW8Pq1ELUV/Az6NCEROL90kZYFLU95g9q7+Q3G69kyVMi
         +HBV7G0ct+vnIJ27aSNBP2aeLMDsz1ThDv9WCKcVSbf7Cc0WvxPAY8agkSzu4MQryxlj
         Fh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282628; x=1791887428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EA/0ZEGZrte27R/NKRLHTW1lEfVA+wxAewcBQb4Z8UU=;
        b=lGaP0obelRWpNVHPeWbS5ACVbJo7VpHkjXgY29sssYz0UcMC3e/r85R94QEeFd6vEi
         dteU/OZjwqRN4r67OqYBZShRgGbHKy++lIHY3wkxvEQVMI4BpIoZI1aYYS4v3Bv59dZt
         XjjNRy9X1t52f2mGVOcAQT0HeRqcp1Eof/BdpA0dtLBM93Y9kIJ2uzcUUEGf7Iu6uw6/
         PcASlNvtRrqwxlfbwG5zEGQSptHhItVIvP7gVJge2GwWSs1u6rraRDDdVKvBrXvlFIJg
         LoaUrAjz4El90iHnhOPiihAI81VXS+SxZ1PW+DWrghm07t8hVjB4Jbgx7xnhLr1ITGSh
         65fA==
X-Gm-Message-State: AFq9FYKI94km45Oej/Eu1xP/ImDHcIlyG/b0nwx9RSpwcbVbdsgIvscH
	MZwt5IyByieEdjkn/XcQrWdN82QITqc5zpZdb6Wb2rT+A3EVocQgswE1gKFKr3fU
X-Gm-Gg: AYBFou0xPi9XB0WU9QABCm7BbMRIfJiWL6Ho/ubGs6kkyElj+q4Pg6oHLqbEn5ISyOP
	axA/FaX7Gmch1O45fgBWJ2Sf60V0/RjUTO2Syk3DuWN1Nc6MSriQZ3aMDTIWq0H0mC9L68H493J
	ZbHhRMuvnMxsZLoupnCpaQ/qOELIkaf2tmHCAX88dz4fy6hScGb/xor4SRupwbKZrxCgsPmLNuv
	4jwgOHvGMcGQ6miaKSzqXpIXK/HxX/d12X2aw9fNm4Vj7VaEmjlKqX9zB1P++ng6Rl6M/99ggvr
	NZJPqvDqKRT9lAb6liziBnpF5q5H93ni323V95Uk5fQPTqC6L8wPkZqBQuOAnHl5beJ1w3xdvgP
	ZetnuuKZGs0QzxT426g+Nj56NT1j0F8MQq0QMrLTwL+JOhrIZqbPPPlggX89tmnut3o+dSxZuQo
	BeojUPEe7aoEp7bLzlypgoYoHJLb8eT4hakHGYzLwWEiE8lGEYouFj5B7hJDgaqca9j4duc+Ref
	UyCZVQgWFE3rSzXzaOqbwA5gMay05I/aLQO4f/DtzqJ2b8Ja9jX6GG2Ec5R
X-Received: by 2002:a05:7300:a98e:b0:351:4648:3611 with SMTP id 5a478bee46e88-3514e334d5emr1545061eec.26.1791282627586;
        Tue, 06 Oct 2026 03:30:27 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:30:26 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v7 8/8] KVM: selftests: Skip hardware_disable_test on powerpc pseries LPAR
Date: Tue,  6 Oct 2026 15:58:42 +0530
Message-Id: <23f36aab5e9c849719ffeb796e1a74e69eb5d142.1791280439.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791280439.git.ritesh.list@gmail.com>
References: <cover.1791280439.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test forks 512 children, each of which does KVM_CREATE_VM and then
SIGKILLs without waiting. On a PAPR LPAR that ioctl is H_GUEST_CREATE
and unreaped guests may still occupy L0 Guest Management Space, which
means create can fail with -ENOMEM error.
Hence, skip the test when we are running on powerpc pseries LPAR.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm            | 1 +
 tools/testing/selftests/kvm/hardware_disable_test.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 692bbae44a65..38c3900cac68 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -258,6 +258,7 @@ TEST_GEN_PROGS_loongarch += steal_time
 
 TEST_GEN_PROGS_powerpc = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_powerpc += access_tracking_perf_test
+TEST_GEN_PROGS_powerpc += hardware_disable_test
 
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index 43a36ef3ead8..0104b7e840b5 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -130,6 +130,9 @@ int main(int argc, char **argv)
 	int s, r, cpu, i;
 	pid_t pid;
 
+	/* PowerPC PAPR L0 cannot guarantee 512 overlapping H_GUEST_CREATE from fork+SIGKILL. */
+	TEST_REQUIRE(!kvm_is_ppc_pseries_lpar());
+
 	kvm_sched_getaffinity(0, sizeof(cpu_set_t), &allowed_cpu_set);
 
 	for (i = 0; i < NR_VCPUS && CPU_COUNT(&allowed_cpu_set); i++) {
-- 
2.39.5

