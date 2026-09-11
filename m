Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E672F12AC
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 04:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789102638; cv=none; b=nUmElq80khXFXYFaKe93prFDT3W18Ojw1tht4h+Yuts1AM7TbHsaV0m+HTMxsYvb2Xg5vx5v/huxP0VXMuKsmOd/Z5Bh0+BRBkU3VdbfB0jMHuvNRDuUcja2C9VNTrRmMLwljXJ+kelmTfjnSLdtz6CFOyu56VwcIwh9CveTowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789102638; c=relaxed/simple;
	bh=82Pov49TQUI1uX+1GPdDGeVOa0XWO1iz7hV6LXJ6Mak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aLELUDH/TpaHHKSCcww9WmJY0TgQJpCJ4204xI51gsaUYdPcAhu58GJ8G+Jo+oaQ3dNUZkskVnkO5J5iUpS4zU1ImNSH6wuMEz91C6Kp4lAkLyS2nsWRVB77UjvqHlnd+KV5xKTQyyE7V+DLTTZcuZA1M4iGpAXOFLBilx1GklM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcZPuy9x; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcZPuy9x"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38759bcd877so572744a91.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 21:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102637; x=1789707437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNCb33ZXLrWvVF+B0ZOBHM6IgfnW37C+yUxO/5EOyVA=;
        b=bcZPuy9xSFaBeqXF539HFWtQdhLa2fJUA96Lti/kYPhxzgPiQikFor4XzvnPy6PoRO
         ys3hS0cyBB7SwqnafS2EVpgdFD2PxjAQ4wD5w//JNbMJeXJ1GpeQHRM5CaIson0gT3hA
         u8mQ9HnJtO9VHCAR3ZLfRmwhOJZol/K1uW+WeYXwGQDikJARqOoyVqGK/gf8+LK3EXyR
         1cyk/hFE2YtSUf7oGHNOlD7WTgn5/HOu1py310a9SJCplP9wnD+xSMWrReBMf70TWjGG
         zD9Z4KGZiOjNMLHgo57sGUZzotI7LXvqyA6ze86F+K7M8Dx304uUcU48FXgS/+6l/8we
         rudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102637; x=1789707437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bNCb33ZXLrWvVF+B0ZOBHM6IgfnW37C+yUxO/5EOyVA=;
        b=hrJhSs0gIUr34c6K6jkIDbfakgQIUvIDHvJtTjL9P1hjbjqWUiWN9YK6fUSJeS8y40
         1XT2TxJhuQRmOqRMhi46QNNA5dED2M5VcyhHkLYWbwt+vbjSwwjzDFSmDOJRQLuaITyF
         AYlPU+kSnpjITOxPwcqnzz4YOg2KfwelMyD8/FgAOOnuA36jWJXuBQ6ZPXDSCbDv0+/9
         M4UJC1HikLlj/yrtTHJhx2EieERiBCxIjhgx6SA4wvd66JME5KW/Vg5hJ8zuDAwidHkk
         2gmkeuBBJX8wf6XzadSTY1tgmyZZfw4nasbFEmB5qEHrLs/90cvLpMcVHgsXoMaE/dpG
         +sQw==
X-Forwarded-Encrypted: i=1; AKwUvBxJ/QZCcqydioAup7ktX77zage9Hc0bkweoPNiHBqDBh3Vrif/5zxJ8u79vzyQ3oi+tXew=@vger.kernel.org
X-Gm-Message-State: AFuF++nMsTXXjxYzR3iKitxikdfZKgN6Pv/B1Dzv2lyEzTZwUqf+vh1R
	ZJSIUhj3ERb1iNHsx0ixGfMiwJQWKZ8oVb2bMlQw2YrBzrgxs7wag4kH
X-Gm-Gg: AYBFou0gWn4WRxdXKnyQA0popOy6pkO0N1UvHzNv8ylMbh5a/d2jUIpcHofJMJHDlHX
	d9aByanjfrYrB6uByJcPJ+NjlV5Kt983j6zTTHVXTVl/JSHkU5cQYfO0b70qH8ekfyiK9nT3Qi0
	80oeNNIpMdQhvEJfZUSIOv6IA2cZXjL9aDJVhrtzHj++IUH/iWTYcL2pt8dAS1mLkUWprNmdK80
	Zw2VPzmRixdAIw0puvj5Sj0cJhULGPHCCZPDE0bYMTxAFusDr7u3GkSxCSJSPqz0Zt9kg645KTU
	Uoh55NA8i5zel2kwmFc+lR3nfRh+gehLeiG/p7hIiIZt0ooyi8o31ojNtexFAPQTfp9W6yQ+tRc
	oEh5blU6rZZ7ysV6JmAdPWLu0gKAlcDr3xZnbbp/L6q6u1wc6gZio1JeAj2zTyLEGjNqqfXkWbF
	AZGAJxsIuSfLwODfGxOSjPLqPAALlk0hsX33YKqvXmTrBCwhroyn6QkMVnGnBco3qKmAy8wjmad
	SR/88/BmFESz8bqnrjQTpiaibiTOxrGASVTMNoJfcwtTTcYM2YlgRLKMiH2Ow==
X-Received: by 2002:a17:90b:5807:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39d9c1befffmr3979865a91.16.1789102636722;
        Thu, 10 Sep 2026 21:57:16 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a3casm2837953eec.12.2026.09.10.21.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:57:15 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 3/3] KVM: PPC: Book3S HV nestedv2: cap max vcpus to PAPR limit
Date: Fri, 11 Sep 2026 10:26:47 +0530
Message-Id: <e2c1ef05eaa19beb28a3db08fb697a80528cd43a.1789099725.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1789099725.git.ritesh.list@gmail.com>
References: <cover.1789099725.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PAPR spec for H_GUEST_CREATE_VCPU says:

 "Only 2048 VCPUs can be created, and the specified ID must be in the range of 0
  to 2047"

However, KVM reports KVM_CAP_MAX_VCPUS as NR_CPUS and KVM_CAP_MAX_VCPU_ID as
8 * NR_CPUS. It also passes the userspace vCPU id through to the hcall unchanged.
On a nestedv2 host (KVM on PowerVM / pseries nested PAPR) built with
NR_CPUS > 2048, kvm selftest e.g. kvm_create_max_vcpus will create vCPU
2048 and fail with EINVAL when the hypervisor returns H_P3.

Following error gets reported (with a debug print added to selftest to
print failed vcpu_id number):
    ./kvm_create_max_vcpus
    Random seed: 0x6ec3f539
    KVM_CAP_MAX_VCPU_ID: 65536
    KVM_CAP_MAX_VCPUS: 8192
    Testing creating 8192 vCPUs, with IDs 0...8191.
    [   62.655458][  T302] KVM: Create Guest vcpu hcall failed, rc=-56
    [   62.655458][  T302] KVM: Create Guest vcpu hcall failed, rc=-56
    Failed KVM_CREATE_VCPU for vcpu_id 2048 with errno 22

    ==== Test Assertion Failure ====
      lib/kvm_util.c:1395: vcpu->fd >= 0
      pid=302 tid=302 errno=22 - Invalid argument
         1  0x00000000100061d3: __vm_vcpu_add at kvm_util.c:1395 (discriminator 6)
         2  0x0000000010001a6b: test_vcpu_creation at kvm_create_max_vcpus.c:32 (discriminator 3)
         3  0x000000001000160b: main at kvm_create_max_vcpus.c:59
         4  0x000000001001b713: __libc_start_call_main at libc-start.o:?
         5  0x000000001001bb47: __libc_start_main_impl at ??:?
      KVM_CREATE_VCPU failed, rc: -1 errno: 22 (Invalid argument)
    [   65.316986][  T302] KVM: TLB LPID invalidation hcall failed, rc=-2
    [   65.316986][  T302] KVM: TLB LPID invalidation hcall failed, rc=-2

Cap both extensions at 2048 when kvmhv_is_nestedv2() is set, so
userspace never requests an id the L0 cannot create. PowerNV and
nestedv1 are unchanged. The issue is only seen with nestedv2.
While at it, this also fixes the limit for KVM_CAP_NR_VCPUS.

Fixes: 19d31c5f1157 ("KVM: PPC: Add support for nestedv2 guests")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h | 1 +
 arch/powerpc/kvm/powerpc.c          | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 2d139c807577..d48232557259 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -37,6 +37,7 @@
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 #include <asm/kvm_book3s_asm.h>		/* for MAX_SMT_THREADS */
 #define KVM_MAX_VCPU_IDS	(MAX_SMT_THREADS * KVM_MAX_VCORES)
+#define KVM_MAX_VCPU_IDS_NESTEDv2	2048	/* PAPR H_GUEST_CREATE_VCPU vcpuId */

 /*
  * Limit the nested partition table to 4096 entries (because that's what
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 9194cf492d1c..cf620b6534de 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -663,12 +663,18 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 			r = min(num_present_cpus(), KVM_MAX_VCPUS);
 		else
 			r = min(num_online_cpus(), KVM_MAX_VCPUS);
+		if (kvmhv_is_nestedv2())
+			r = min(r, KVM_MAX_VCPU_IDS_NESTEDv2);
 		break;
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_MAX_VCPUS;
+		if (kvmhv_is_nestedv2())
+			r = min(r, KVM_MAX_VCPU_IDS_NESTEDv2);
 		break;
 	case KVM_CAP_MAX_VCPU_ID:
 		r = KVM_MAX_VCPU_IDS;
+		if (kvmhv_is_nestedv2())
+			r = min(r, KVM_MAX_VCPU_IDS_NESTEDv2);
 		break;
 #ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_CAP_PPC_GET_SMMU_INFO:
--
2.39.5

