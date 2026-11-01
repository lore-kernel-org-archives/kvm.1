Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793546920;
	b=LL+M2XKeMMXTDn/Dthro1m9o2W448BEoYRasg6rVTIgSau/uJ+VPeUDYY5nvzCLoijP5
	 HwAVaVV2+AYqO75Pr8vw2zFx28oj/f3lvZkZAz13tymsiXImzeIj9U3vHlq6TKLO3sXyL
	 homBj3SbVDaFPqKpeRHKJq9/F3q/SwCUxCfNKCmPBcxPal//0czzjLJZHp1Q6Gpxg6t5x
	 jpQa5IvkdNfmDCnoAAYXGXhj1w5FCVO8sEWZfvmXAnPPjLJKF7yUW0jFamDXquY2Po5a1
	 W8u2jtZqg3uJqYdd/p8TdUhVK+wvE1SkCka0R7kuEi6BtGEs0+Jlz973lCO3ky5fTrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793546920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FazxrWHX2Tn7PurYTqREXzQh0pHc6RTMEU3g/b7/CQI=;
	b=uitCzSoGXc+qixQLTKw5K8wEG3gRfUremnE2uIWSLEf0Fol2GLagqtVwcKlOnl8fMIt1
	 iVSxGcP9ptnYV+PVpTr5kPPAMvT7pUQlgCaG4lO+lTxAIUJ8IklC6tYrhoRurukPlyaUR
	 0BaoW8Znkvz2OtOcILhdiDoQ1DJ7NJhLJFa+cEjziRMXalHDjNd+U+2/M08dlLn8uBoob
	 LsBrVjUuH8UguJ8nkMw5SFi73tXF4o3re24FFwAMI+zooHWYB3MfQCV4LWmsoRvpY6bxr
	 RnSyKK/nBeyNcS5HJq5z1buSdcvfbDNd5HPAK/c97ZmCQ2/hIYlXZM8qZpAn0Ig0eMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qBW9a+HM;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69105606A326
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 15:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69105606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qBW9a+HM
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-18cdcfc05ffso2540340c88.1
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 07:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546919; x=1794151719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FazxrWHX2Tn7PurYTqREXzQh0pHc6RTMEU3g/b7/CQI=;
        b=qBW9a+HMHFBCEdcvlDdr5Fp9FTU9BjJvUFlJbdChqvsPgPQ7vrRWIdttW2upYiSR5Z
         584Q1D5LAo9+zzHLyUGji+hwgfw2pK9085tg60nHm9+QshPJ9/UdwetiuIjYS4GcQU6r
         6ddZy7FH17QRh0SvfSIj+Qe6XM7tKZJDAw/Zv3wpi6wRLeW9vVWwTFPMiYh8Sq5Vz3+z
         fK3nEKuICgkej4LfChbnMGdeCQkDt+GTTgy2mIc3MbTV3McW2Dzgfb53fMxR9m7nGuWD
         4nX7f0UO9EZ3e372UemI/xw1xgtA2TfyAYCd6omZPL1jhuseT3S/4lpwpQE1rojIAOWG
         +1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546919; x=1794151719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FazxrWHX2Tn7PurYTqREXzQh0pHc6RTMEU3g/b7/CQI=;
        b=KlwO250HuMn3bRStaBY3E2xLQ0yLUFhHkyMywVCh/rdHHrms6NvG0mCtxq68+Tv4Hn
         Hc3UMxWqp4M0KWw5Re9i0VecY+xvTlqiohDOrlAuXRVZkrubGNEkWkYcxz4//KVBAQoR
         2qNDIIGalmihhGbCmoi+uVb/B6UrusIDvEXbeFpTzrk+9zn/US1xQCjRXAvAAM+A71NF
         sa57yYt6Jpg/XR+dygHKj/NJsMVbJE/CLZA8uFuxV3ICINFLJ8Se7klxev91qYdGPN3N
         saAsknpCK1cLR4rNIeF3iNi6ypF1mlnh278o87N8VDQ/IFdM11rBu+ApC1QmqHfHaZAi
         9Lmg==
X-Forwarded-Encrypted: i=1; AKwUvBxdYdy8AXAGhbkAz9uMaBDsfJ9WlzC+eRIj5wr9JcKz/Jw5jrCnnndPL9+TLMZtKaqb4A8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLu7ZtF/co/1OQizu4nuR1INv6p69vt7wMl0ewNP7AqMGu6JfYa
	Ku6XFjg6hgsWZDo0UbO31ta4/ed14Eg/X5F4r4URTPcW6TVkIy3XaZFk
X-Gm-Gg: AYBFou19wBmsMYr1YCE6n8oUFsyhj6Cz3MCKP5QJzcbeZEwV1/YgpS0BxCXivb5CWF6
	aLrdXnsQf0YshDaB8dHTli/K+xYrcanBcv1kO8wXAlvvOurse0WrozMEDAh+fuy7joPOkeI4JoU
	h4nucuOK68oN61tNntU+qfkwNFhA1woyszVh5kgvGRydCQ2O2zCso3BjJRtarycfy7WFOIVHPob
	0al+tLjx7vfPz65lde162xrfEhxck2w6y7aSOu4KgyUUeufwG5AptC5HL7sKcGFNIeeIv5eM51c
	lSADq/kgHlf8C479mOpyelGeOnN5FIgjAYfEez0emxY4F6OQx3qPdr7AzUFgrOVNEOIQcnQr9fs
	LKq02q8KREJ72p6c0ShpSbCs+AwUBAFgBoPWM3SPfB/ccl6HCxE3r0YmdHaQRKK1XuaL8yVy3xc
	GapaWPlJJoPVGqip8daay/ikntg/PAXaYdJZgT/wu8+Fivugoeo3/4grruZcO+6ZnPy7rMEuqP+
	hkN6xjt4gj/dYipNL0UCSV2VPZOvvw/NAkGHVhNGDU0ViVdmyfzgRcru2ytnDEggR1Kt+l66CbZ
	KD607Ilnk6Lt+lW5c8WEEIIMUFQYSU7x58U=
X-Received: by 2002:a05:701b:4193:10b0:15a:4155:3d9d with SMTP id a92af1059eb24-1ac5da76f61mr11637801c88.31.1793546919481;
        Sun, 01 Nov 2026 07:28:39 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:38 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	kvm@vger.kernel.org,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 4/7] KVM: PPC: Book3S HV nestedv2: cap max vcpus to PAPR limit
Date: Sun,  1 Nov 2026 20:58:09 +0530
Message-Id: <f9c26aefa325bb4b6a3222718d6d605aa4993dff.1793546707.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793546707.git.ritesh.list@gmail.com>
References: <cover.1793546707.git.ritesh.list@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h | 1 +
 arch/powerpc/kvm/powerpc.c          | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 708a32f89776..c068cc1dd51f 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -35,6 +35,7 @@
 
 #define KVM_MAX_VCPUS		NR_CPUS
 #define KVM_MAX_VCORES		NR_CPUS
+#define KVM_MAX_VCPU_IDS_NESTEDv2	2048	/* PAPR H_GUEST_CREATE_VCPU vcpuId */
 
 #include <asm/cputhreads.h>
 
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

