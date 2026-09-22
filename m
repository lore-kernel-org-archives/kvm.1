Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FF3493636
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101783; cv=none; b=g9TbTaTMnm0FqQRBs669Q4k2dZ6MImbuK380rQBRHou97DJdksRqMv8ImeLxAe4Crx4IKpwILI0pCJHLiQ3A9lQQWbGL9aTN44DtBCAEFR7n0hfbzdW4F2mvkjxdx4wWCNlh4kS5bUw8nM9jy5FTVPbRszDGDrDJKDvUXwt8Yy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101783; c=relaxed/simple;
	bh=GWNjedkibxumoHAK01mIQABSW7U4B9phhkLLwIwFVQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cvgbCMiH//BGC6oWOECwBN6ePOi+lpUfe2KYmonTf4p4uagzndc/Qg9rIc4/2YokcAOmWS6lKjT5bmGBOyzLTWROBpA/JGgam4XKsym+MLkuUndRUwFeiviNuXCpaUeDCE/mRmtkSGPxOAko92omn84k5cUCfCLmtsfVlAtHlAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LM8MuOIx; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LM8MuOIx"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3286624d194so81168eec.3
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101781; x=1790706581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dSFKUXBkZGZNQnOO0S3ETacf8WntsJLIZhJqM465+7c=;
        b=LM8MuOIxaMQEGJFVVfLpBjbzR7nZQzEoFHX9URU040LXzdYAs6m9CA2qe72HHK206x
         z5nX7CeVBuS/oQvsEAYce7qsWPSder0Q9fhL9vDahSfn2BY+uQJqfje0b5M8eTQDGyqY
         xyDG6QwU1khE3pyVMbuz8ikVs2jJIaaZTCdYTM3/SOg3nTBnvm7eF6imssJzyFZi230z
         YfalgQakYy2WUnnFzthnoscJ60y7lyOqU7U9XjlRTwYTUX7550mhy+g9WsDc6p5tauER
         xfe/sAs3MdehQe0OhcHblU712aKa5BhmHslt6lAUp5Y5VdmqnZQ/WAZ8Bmk9kKvcTwDP
         ShMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101781; x=1790706581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dSFKUXBkZGZNQnOO0S3ETacf8WntsJLIZhJqM465+7c=;
        b=lJRWEF2BwjW3KwJV8GdhK+9zOpeXXlvEmIrqcQS/nKtybSOKajoeu/9jsWaI7xaALn
         ja6b8XRMhadCkajsRpRVLpgktoSeogGonJFL6YmCtUe/etaeYbBUxAfxe0oNFb8I+dzy
         knK0ITWMBInoAvHPSweHXKj28DvlJHnpoP6U4Z8WNtYgElk4TzOcNOk7kAghVQ/njgm1
         I9NFftLotCN818bhaDdZTW5fTZQs4BVQDG05weWapekihEZDi/DIS2JXoggW824PTF66
         pF2qzOtX3zFUQfkRZ6VedEK3EEIAk4XWbZFneHVOCuVWhNFx7iN70FFdgGNboV3pZtKV
         pOEQ==
X-Gm-Message-State: AFuF++lOTKmPHAG0OgkiyPTHKCL62rzEXRf28MGKXKsNelDw6SsmeAEW
	85q3bNKS8xJHkFQPpvTy7D2Q+t+PUQYQYASuGKIJA4PhJcO4XEDApzYqvs6V1Q==
X-Gm-Gg: AYBFou2UW4GLdsPkyXAZznznK6aD4XTAAUq+Md1QziH8RIY+mc8txsgV+OoSxn4giuh
	Ovzhf25HGrDTkwXZouDfONWz+AREonBJ0DGDi0C74GBZ0+EfQqRNe+QbYVG3rSh0D89KgpvpXMU
	hClysL5jjeDrju8wTa25zoUMOEzRWLcUn9avYBn0XBWy50nURufR4cOukk1xLZS8L3GddWx7z3z
	Bez5BW6s/6Q0/ZTwKneJd9+oOOB0m1E/0eARvGAf56vtX/cTEDhskS+VPdDC5EJmtv5d52QQusb
	0MaNDzyrcNLu/NUlYIE2rWC0TARYS1hyTbiBkLivJOu4EwQmSv4VxRnJLUwatsQoCMlgaBDLog/
	Ty69Xj/6iD3T0RnfEVFh8xAC2nbcrqY/0rMF35VIEzUUrrABf79jIyOBA9k5d5ly4dlqIUl5noM
	Jk76CMzzZOdaOuhy0D9rJL++8RpG36GRs/HdvUsHSUrZN5YovdGUoGIZLkMd1fo4Ipe60q/1w1w
	OhYQzJZ6qCeBU0fsUdB3A/93iChifOj+PmSlCtJow6zC3EmAOvHnT3RrtYt
X-Received: by 2002:a05:7301:700d:b0:33b:eadd:9006 with SMTP id 5a478bee46e88-33e8dcc70damr130602eec.23.1790101780602;
        Tue, 22 Sep 2026 11:29:40 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:40 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: [PATCH v5 5/9] KVM: selftests: Make kvm_create_max_vcpus tolerate ENOMEM
Date: Tue, 22 Sep 2026 23:58:49 +0530
Message-Id: <25cdef9c45a1270dcad7e9c4140e56b6953eb27b.1790101179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790101179.git.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some hosts (like in case of nested guest the hypervisor L0 might have
quotas/limited resources for L1 guest) can run out of hypervisor
resources before hitting KVM_CAP_MAX_VCPUS.

This patch make use of the helper we introduced in the previous patch
(__vm_vcpu_try_add()) to tolerate such scenarios where an ENOMEM can
occur.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  3 +++
 .../selftests/kvm/kvm_create_max_vcpus.c      | 21 +++++++++++++++----
 tools/testing/selftests/kvm/lib/kvm_util.c    |  5 +++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index aa521b383abe..576bbebe0679 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1064,6 +1064,9 @@ const char *exit_reason_str(unsigned int exit_reason);
 
 bool kvm_arch_needs_naturally_aligned_page_tables(void);
 
+/* True if KVM_CREATE_VM / KVM_CREATE_VCPU may return ENOMEM. */
+bool kvm_arch_vm_create_may_enomem(void);
+
 gpa_t ____vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
 			     u32 memslot, bool protected, bool naturally_aligned);
 gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index 59ddc3757943..45a9d8b369b5 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -20,16 +20,29 @@
 void test_vcpu_creation(int first_vcpu_id, int num_vcpus)
 {
 	struct kvm_vm *vm;
-	int i;
+	struct kvm_vcpu *vcpu;
+	int i, created = 0;
 
 	pr_info("Testing creating %d vCPUs, with IDs %d...%d.\n",
 		num_vcpus, first_vcpu_id, first_vcpu_id + num_vcpus - 1);
 
 	vm = vm_create_barebones();
 
-	for (i = first_vcpu_id; i < first_vcpu_id + num_vcpus; i++)
-		/* This asserts that the vCPU was created. */
-		__vm_vcpu_add(vm, i);
+	for (i = first_vcpu_id; i < first_vcpu_id + num_vcpus; i++) {
+		vcpu = __vm_vcpu_try_add(vm, i);
+		if (vcpu) {
+			created++;
+			continue;
+		}
+
+		TEST_ASSERT(errno == ENOMEM && kvm_arch_vm_create_may_enomem(),
+			    "KVM_CREATE_VCPU failed for id %d, errno: %d (%s)",
+			    i, errno, strerror(errno));
+		TEST_ASSERT(created > 0,
+			    "KVM_CREATE_VCPU failed with ENOMEM before creating any vCPUs");
+		pr_info("Created %d vCPUs before ENOMEM at id %d\n", created, i);
+		break;
+	}
 
 	kvm_vm_free(vm);
 }
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 7084ed90e4cc..b4d6b8167466 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2112,6 +2112,11 @@ __weak bool kvm_arch_needs_naturally_aligned_page_tables(void)
 	return false;
 }
 
+__weak bool kvm_arch_vm_create_may_enomem(void)
+{
+	return false;
+}
+
 gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
 			   enum kvm_mem_region_type type, bool protected)
 {
-- 
2.39.5

