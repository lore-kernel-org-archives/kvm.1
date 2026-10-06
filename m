Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEF53E5A17
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282601; cv=none; b=Rmnxv5uLrXFxHxzRwAwMgPZtciBPR8FD/eI8YPn6ml4KVbCwZG9EYKn+Gao2yKGa2RkOwbw15PH2DL+sbHK9s/rO45D2GzbYE6ToLcovCZFYAOixU/vBWnxOY7nlMLzAWgPYyiKCnXcdUFQkpImzmtouuc8jAMS8hfv2eGcIsAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282601; c=relaxed/simple;
	bh=/ezbbM0TGZs2GhJUb0V6eMysvRv1UKp2GDpJMsjkpuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Abzcd4gsZVUd9qxWDepV1vwLZ/SS50sATpnPyrMIcNAWFlFtiYYCG+3i59Pevyu+PlP99WTZe3F0NPe2fLqqadqJmVdGmz/+/Ezd2Y1W5ZR9+84H1lC8th5Y5d9Gl+qwf9rvQ4Jhdw5rCbcvy0sy+tLXj4/0U5z294cfI/5+7VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOrAJtOI; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOrAJtOI"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-351348eb579so904392eec.0
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 03:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282599; x=1791887399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZcbRoP+uea/9OIqckWxSVeGmNCVXFZup7WqyFdJFlC8=;
        b=GOrAJtOI2KAlhiZzvl8OpV/V5k3czkkmHGheWn88TZ5wiR/2ywj657ExeAqin4WPrl
         gu2iYv63hqKFXCp8TbETMIBpD7aPMt56KiKuR2NB5wDJ76rNeuFGuUKrEst5wBMcMn6A
         InWZ2MDoDGOBKVj3VSl9K7lPk+C0A+8d/30+IkCA9bzu3pxAQAvAqwWwMH3WOFoa3aec
         INmoyz+RW+Kqb+ElECZnV4jRwH2lVcfXciBTfGI6c68Qila8fdKJwIiCF7NxaZ9oLZco
         ryeCgEZgYUcx50bWMH4aNqP5Ax8NeBFYB1fz+jt2x7Id5X4oKl2XWKl3pe559E1ZKxGO
         hJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282599; x=1791887399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZcbRoP+uea/9OIqckWxSVeGmNCVXFZup7WqyFdJFlC8=;
        b=adoAKNepa74L3SAGJB1jHRFkB3hS1Rk7MrNtSwj9nQ4Tzoau2HxplOh7AuTjdfcBCn
         xbXKL1lJS/OS7bV6nlDD9/t7iLaQLJTKKhqfqUtYVEbsoxCztib1+eyylpaE3p3nYzgE
         fLQVWDZTYouIJmYYAhI0Xy5jxDdUoTmkpAdcBamejdmXbf4Dn+xRdd51mCeO4Qi4QI7S
         HTnjInTWwZPKKur4zwlFpIRiBWgVyMIfYxVnA2o1hUYTDgPJGb21K0Ov2oOivaaTklp0
         AUpoY1OQOwp7cyInLtMa0kGRaaYWTpKtAobw4Av/1xcdySBSAJ2rNInnI+H3+jopn7Rk
         0GNA==
X-Gm-Message-State: AFuF++kpNthwRr7Xi9Pwdbh4N9Hq5lC0bZ1tiZq478vgsWXEpjDTbssL
	bGVP/S3yJ/kpaOxXx+sFLf6YmecjcEuCXzCBaIhIo7hQAVApqH4AXsichVO3pmmG
X-Gm-Gg: AYBFou0U5uTWKzRDAS8MJ3qz9WibzhScQ/rfwZ+AD4d0k9tlz5L7qg5EqR3NfLJOUEt
	7bgMargiNkNwXoRXm33bTc+hKU6UU47USIcgsgLQ8V+Wr3v0U3PE+sTsXWtX5Dwe+1/FK+mdMbN
	mQPCYMeV6fIdGmz95R7nDoKwvdWCUiiB9iru7lo0ddNNe1qDLbHWfB5HFOXcIP7MfxZW8POyTo8
	jkVuI40lF9ggbDlbSJsie8lMwExzoBNmNUPl3nkIHkuK70k4mx6+obofUGciSDqE0lZZ+PhfHNN
	dYc6vuXMESqn+4M2V9UgJGgRF3ryNQos6DW+swsJMtV/YyFFmHu4Lrp2XqIG+ibx87Z8PkDvRPq
	l1tXSHklbrGoHFI5de/s/9OrsWSgRGwse8DPiFY2MbO/Mz9CAjChemLHX6a6DZgPwg+NZy+no2f
	ToGeRtux60bAxxWO3ucbG90YIKNTmGX8k6jTXXRT9EegyfV0xX3yDXlS6U466iXuKjduBD28jpF
	dbOVy+3Trv7phIgcDTADzFNbGo6iZx5cf62XAkquzMhc8eeHsE4Ms0kIjHN
X-Received: by 2002:a05:7301:9a90:b0:351:54a:e320 with SMTP id 5a478bee46e88-3514dc8203cmr903000eec.2.1791282598999;
        Tue, 06 Oct 2026 03:29:58 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:29:57 -0700 (PDT)
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
Subject: [PATCH v7 3/8] KVM: selftests: Skip the max vCPU ID test when KVM_CAP_PPC_SMT is set
Date: Tue,  6 Oct 2026 15:58:37 +0530
Message-Id: <bbfbaa9fb2eca8c92f59dc980546c2587dcfc130.1791280439.git.ritesh.list@gmail.com>
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

kvm_create_max_vcpus creates vCPUs from 0..MAX_VCPUS-1, then again
with ids at the top of KVM_CAP_MAX_VCPU_ID.

On PowerPC the vCPU id is not a flat index: it encodes SMT thread plus
core. So on powerpc maximum permitted vCPU ID depends on the VM's SMT
mode and the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple
non-SMT VM's limit.

So, skip that second loop when KVM_CAP_PPC_SMT is non-zero. The cap is
0 on other arches, so they still run it. The 0..MAX_VCPUS pass is
unchanged.

Suggested-by: Sean Christopherson <seanjc@google.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index c5310736ed06..1b95027d41ba 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -58,7 +58,13 @@ int main(int argc, char *argv[])

 	test_vcpu_creation(0, kvm_max_vcpus);

-	if (kvm_max_vcpu_id > kvm_max_vcpus)
+	/*
+	 * Skip the vCPU ID test when running on PowerPC with SMT support, in
+	 * which case system topology is encoded into the vCPU ID and so a VM
+	 * can't use the full advertised vCPU ID range without crafting a valid
+	 * platform specific topology.
+	 */
+	if (kvm_max_vcpu_id > kvm_max_vcpus && !kvm_check_cap(KVM_CAP_PPC_SMT))
 		test_vcpu_creation(
 			kvm_max_vcpu_id - kvm_max_vcpus, kvm_max_vcpus);

--
2.39.5

