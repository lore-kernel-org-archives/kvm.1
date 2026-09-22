Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFCF47F2FA
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101767; cv=none; b=a2QrQCQ8Gb5W01C6xcS6AwWBMqEouQyajP5cYMU29YDKr7rzhtSiBuqWnR63wSBQlpAQUUccRjpVEXb+eJikpk0ASQDsbFoj591ieoQkwH0JOxsfTXtJnXbqtJLqYq1JTlE5yd2ckgIIvz1+TR714Fgezcl3iW8ztAZ6UCLwovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101767; c=relaxed/simple;
	bh=VzWPPh2bCY861JFyY27bMmmD9NuIzarCZumP5A9xkto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O41/OUevpYg6KVTeEXge/mGhhbmRCHojnG5TAwhlvaMAVV0eQkdmrC8Ggbxr0uZ+/fpOcK7/eoYqxvfm7hJkYPMpXBQjWLOgvfuZj6ZJ9x5m2kl1O6E4XtNI73xzfv2NNZXSPnUMitHDPtfUps2/XScr0aVxVSp93/La2Yhm+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+T3sqEM; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+T3sqEM"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664d340aso60139eec.0
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 11:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101765; x=1790706565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ShzPxubAIgCFioqA8zTb5jVlls4ez8Ik0Yod6CKj41U=;
        b=T+T3sqEMsHOFuyaJgkLJjcY/+zEht5X0TfQSM1dBBlrVCt8RdcgJOa3l9x42xk1Q+t
         7L/DftWnWkloyPZTy9bdUvo7bjhixX9dDAeu/K94kncIpYtILDgS1ZPDektHJfxhEaNE
         jem/jkfH8B/9GT6W40/wPAMLEDmaGsYVV86zstGwu9UfZMz9telAk0i5mUz6DN9iTuGg
         iLPUfJUFwNX8einA4Jc03myvYjrFPVVwOPN/yS9SGA4fQgGQdHC1R2ACjoUzIillgUOt
         mxDBAu+cmk15pPaCTOxx/WLokyg9z31XvpP3thJ0+4zFjy+dJliSOYArmC0HzCdS3L6T
         4ITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101765; x=1790706565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ShzPxubAIgCFioqA8zTb5jVlls4ez8Ik0Yod6CKj41U=;
        b=QlVAivA22hCqd34bdF08aWPFekTRgUBycp153JUlVCOBgnU0BZA3c/Kx+7doHzbNEM
         xy1KzvBJgy/zV1omceOUVKtfoo3N6Y5QXAzk4Lb7pM2iOpzFNyLHxsIK8DPYXDHL+swk
         pU0JlA+jH9sd/52wvrn0bmm3mZOAR6xknGBevyoyH3C3mys1WpA0qQRTXCd27OEdQscM
         ofHrbVYixs0h0kEP1VbpO1526jl1ZIjj1l3lWIpLN2GcA2Qzv5jGWXhXyRs9bIkH82cx
         /6QJQNgIdpIYiMs2gIFWdaqOCFgu7QuAKIHasUJkO6jq4PmWfx0KDfK0A0l7c7zDv0ep
         tS0w==
X-Gm-Message-State: AFuF++mCWvOu9Ola6wMuZFmG42/xXgPwTrFpjUhQ3eyrIvHzmAZWNob3
	W2TQuAaHx+ec2bfKWQ36XLDH2XzYwcPwvL+lfNegA2r24SW75M7gZmdEH3qmLQ==
X-Gm-Gg: AYBFou2/ATtHR7sXH7O5lCtFvluDIAj6uLo97m53LpmMrpCzr07hEOXee7KHwAqr5nM
	Pl5jWaPPClYWITCIc6PQP9xWKS2TtfXRgvOuU4JDdPEutokpBfKTmnqzfPfqnMiERY4SecgOwPC
	MVf+U11fwm/GSJo/n1Wi38UHbGUQlzqyiE9o5igyKeHoef7plnM+usNr22AUnLAXicLsXDnTF44
	IFtgcTJjDSP2HZVhC21xeIObtB72cxUWmmRuwxNY8w1bDcSTtXjZ2JKOCYyPR7S99I8VcLlI08z
	3aE5h+eqn6+s1LQ3/7tdQKVAbzOcYAVlW4QCMMJ11yqm0sBWvX5vr4YozKQgBUJVWAVh/WUR5tZ
	P79RxJq+ZJvbniEWsBe/kj/KkBUH/ubZi23rNIUqhBaGSp3G8lC2VhE0A9fNhA9KKNiVsEPBd0v
	VmtYJKHr66uSnqQ8dK9zGxhGCiNuVOEvTDO9weo6mcr9ayQYJVuM0FOJFFDcfNhjHOuNhRW4EJX
	Ma8cXNNEhcu6aNW3A7bHVQzjH9DqWR6JKZ2Nj4m9RboR1tcmvBvA3MNLsgROXM+jQNwOWeg34T4
	Iyx1uw==
X-Received: by 2002:a05:7300:c72a:b0:33b:dc33:7f98 with SMTP id 5a478bee46e88-33e8c24feabmr158640eec.14.1790101764641;
        Tue, 22 Sep 2026 11:29:24 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:24 -0700 (PDT)
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
Subject: [PATCH v5 2/9] KVM: selftests: Enable kvm_create_max_vcpus test for powerpc
Date: Tue, 22 Sep 2026 23:58:46 +0530
Message-Id: <3f876f362466177e8c826e1ff656cd02d96b7069.1790101179.git.ritesh.list@gmail.com>
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

powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
VM's limit.

The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
to the kvm_create_max_vcpus test case to limit vCPU IDs to
KVM_CAP_MAX_VCPUS on powerpc.
This patch allows us to skip the vCPU ID test when running on PowerPC
with SMT support, in which case system topology is encoded into the vCPU
ID, and so a VM can't use the full advertised vCPU ID range without
crafting a valid platform specific topology.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index c5310736ed06..59ddc3757943 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -58,7 +58,13 @@ int main(int argc, char *argv[])
 
 	test_vcpu_creation(0, kvm_max_vcpus);
 
-	if (kvm_max_vcpu_id > kvm_max_vcpus)
+	/*
+	 * Skip the vCPU ID test when running on PowerPC with SMT support, in
+	 * which case system topology is encoded into the vCPU ID, and so a VM
+	 * can't use the full advertised vCPU ID range without crafting a valid
+	 * platform specific topology.
+	 */
+	if (kvm_max_vcpu_id > kvm_max_vcpus && !kvm_check_cap(KVM_CAP_PPC_SMT))
 		test_vcpu_creation(
 			kvm_max_vcpu_id - kvm_max_vcpus, kvm_max_vcpus);
 
-- 
2.39.5

