Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341F3E3D85
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282619; cv=none; b=jvTQtYY+fslWyrw5jXWPNs86J6sXSW4kBzQxj4a8CRMwtNu+iCxQusfzWQJW7Fnp4b68NcGgRpbRrJGWkCapmNrPtL1pF1jYLZIyzvoQu2r8Yb6VdQtURk0H1urp8TVHVya0O2323h/g8aljNpjbcK7ORu469BozF9imfuaoc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282619; c=relaxed/simple;
	bh=HMaTu5dap/in+IMb7xSYXgqwggJzp61fMmk5d6fvDHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n90V1uucg7RIoVm5Vm73SBLanE9CW9gTFdWvzguDt8UtkU7JqOOUKialQPPOmIIKag4StwT5DX9U6rHR4WZSp6FZkpGy3GA3rik2LCrCWKx8GF6x7l3gWT6ZV0Xo5Xh37Hu1fVeuep/RrEvwDjhVLTttLLQ6wcMx7tZitGhEfoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMyxJ/gM; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMyxJ/gM"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-31490970b97so647418eec.0
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 03:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282617; x=1791887417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f2zCsQ/oYn3ghBOOGUriCrZuEtWUXY39VXZEGkJ0WUI=;
        b=iMyxJ/gMUv5Ce96D/YOn2Rdn8MRRxKSyXBDzVEaG64gmYj34pyQlaZmM6XBMgbwem+
         wp6CIL/Du1v5sflYThYJChNVq8dXmQQXo6YbKewV4S+gxsFNQ3DNZYeikxIWTKafom58
         DlGO82WtoSbfCj9H8g40ppuVjCuc9RdlEn3n6gXCLi5HBpSWlKNXRRD4zcBm+RSj1CND
         EvpKDTyKztq/44wjB4gFFLUJ3gmg6eXHa9csivrRBO5RMVGxBHAC9SGG2ZRjp8I8uR1D
         Wi3GdwqgWLAkViCrW+tXXYuKWY8WhowY8iwtEW8Ax3HNCLlCS2FilNjuKswPCxSdcrSn
         371A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282617; x=1791887417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f2zCsQ/oYn3ghBOOGUriCrZuEtWUXY39VXZEGkJ0WUI=;
        b=Jj2/wyQBJI3PLhGHL527BTjoBqmnPC8BFUCSIJmkl0Fi+sMI5IPlMYXAgzpL4Azu1g
         TeEfWrtx3tjbMT7EIpFRXBbZ8Q3AQceZJmsPVmfgTdSmXHiQIYfpa+FoLKEyxTDCzFX6
         ODSvfnviCFCHel4WHhqMoQHdO07K8H9KHxONXGOQscb/DLhAVxjQpO11Vt4n7l/YvUz6
         ogJMogWxjrS1IYosqmdvdzfdnxshrPhF/dCs2d6tKf5is7npRqc5wv+e5/cB4XzJHcUj
         F5isjxWMN8HeqOUhR35megFe0pd8g8tF1y4mFykWdHAfPWrQ4tkdpQlnIgx2eTpWkEyB
         05tg==
X-Gm-Message-State: AFuF++lTpiSb8QQywexMce+bRfeaYv3UIaniO32IkWptLtuxXAo6fcX6
	aLZamG0z3/deBBXR8Rz1fM3MqNoP4OXb2J+AIgw6fa7rjPoODBlPkQUHu0VcSfyU
X-Gm-Gg: AYBFou2j7X27NxN65470DERkinBIv3RlJjTiXI8slILxApweUcadZzdXKcq8f9T2nJp
	PScXREo7t3KhmX/cQqgs0c2ByNYYZB4cpB2n/+NqLQiJ4+ObGJK5fVhbpmZIgUcH8NzlYzP3Qog
	Capg6LAwOQX4gY6RZ7xXgBnaI/7I9i2Q6kyyG6/syJqOqe0J23lqS8QTf77s5gicdvACOW4ocL8
	K+MsVt/7LEk/CPDHOVa7lDccJzep0PnWTVoHEYh6AFinTZa14g4EwOMTwr7aCrXKiwtRf+k5sTd
	iL4GJfmQFVX/AZ3fkD4o3Wb+4IpToqSwuvKVJMTu4R6Gix0rm+6Q7SKTKMQ0QHNjsMQhwrJ1Y1g
	awjUVYTnL+/11Yv7zv9KepMYrfaPcF/pvn4dnqtOJV2+vtpVW9plOaBdw27vZ4sl8l+dHkn8ayh
	xqzn6c92a6mXXYGrjPUDK8jAbya7n7BRkjFKXhCLevJ68rTf73C0CFA3ti52YOUhYk8kUlIgKdI
	xOoJWT6ionSzPs5XGfYzVvVP8RQmdAn9eWcX/BaRajvmzWYAG7VHvRe0T5iriVujOBZKCU=
X-Received: by 2002:a05:7301:6790:b0:351:248d:d63b with SMTP id 5a478bee46e88-3514e2b30dbmr1487049eec.11.1791282616520;
        Tue, 06 Oct 2026 03:30:16 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:30:15 -0700 (PDT)
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
Subject: [PATCH v7 6/8] KVM: selftests: Skip kvm_create_max_vcpus on powerpc pseries LPAR
Date: Tue,  6 Oct 2026 15:58:40 +0530
Message-Id: <c8856b73b06bd4b44ff31e7454c8fc56dd402428.1791280439.git.ritesh.list@gmail.com>
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

On a PAPR LPAR, KVM_CREATE_VCPU is H_GUEST_CREATE_VCPU and
KVM_CAP_MAX_VCPUS is only the vcpuId range but is not a guarantee from
L0 i.e. because L0 Guest Management Space can be exhausted before that
many vCPUs exist, so creating MAX_VCPUS is not a valid assert.

So, skip the test when powerpc is pseries LPAR (running nested i.e.
ibm,hypertas-functions is present).

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index 1b95027d41ba..22279c638d06 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -39,6 +39,12 @@ int main(int argc, char *argv[])
 	int kvm_max_vcpu_id = kvm_check_cap(KVM_CAP_MAX_VCPU_ID);
 	int kvm_max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
 
+	/*
+	 * PowerPC's PAPR L0 does not guarantee KVM_CAP_MAX_VCPUS when running
+	 * on pseries LPAR (nested kvm-on-powervm).
+	 */
+	TEST_REQUIRE(!kvm_is_ppc_pseries_lpar());
+
 	pr_info("KVM_CAP_MAX_VCPU_ID: %d\n", kvm_max_vcpu_id);
 	pr_info("KVM_CAP_MAX_VCPUS: %d\n", kvm_max_vcpus);
 
-- 
2.39.5

