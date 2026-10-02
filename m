Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0F3859FC
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972441; cv=none; b=cv2u8TaamHZeJt6Wh6Ea+l+GPhowBSp7BM51qYJj4kHDDt9mwgRh6HCSXgmtFmoZFtmgNKECc0jVlKz7BYH3cEgcIfsUHy2ZVpqt81NIQaZ2tdrv/KzFrBatvv0mIz7HS3G6qAqyTQ2TZe8s5Oz0QV6NH7ywyytdiUmBx7XX0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972441; c=relaxed/simple;
	bh=jhWR9oFi6+VxU1yXg6eOBwwTu3AC1DdeuTyAdD973Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t26rUYBq7+DYcGM/TKOXQlaXwHNCQGoOFJW3gRggylwCputFmsq8KU/KqRGbWcG6+etgTVEJ8UrFMhVyA5zEGFSJnhGzRIesJ64LocpZmZ04PnQsyvuITgHjuwJ5RRKTCv3pubBwUPRFbSUJSNTGm8tGSsTra4nUzK9ql0y7wt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ujho1cin; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ujho1cin"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd77300825so43532925ad.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972439; x=1791577239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gzLwnH4jDzrX8kj8UPASW2z1d+DNR/ChcuS1IhF3HHk=;
        b=Ujho1cinitLILwyfEKJVgOtuox6nrzbwNrdL+viEvb1ZcSEfy+M2SgIj4xj7ND66Dm
         6xZesWbawxZ8sj5Xg8W2YA3CcN/LWMDAExaigoSeXAS4EdXArBor6G85g/DfPjVZhKHR
         5KeNRlFChjzWQab1VLdbrhaCAMOo76pQ1igLg+q6Hi5XnofrBfAIfWzTfemiqNRCRaJC
         Z5kw6KHBgESe4KTJIjluY/KLcwMniKt8Z73aWqe96ttJaaId30IDivJGCOcvSd7Os/bY
         KOgbyDb05i1wY+Z09bUzve7GovO8mHCCCXXDjQyG5wrjy5xSswC1boKM6HjmtUYbHE0X
         D6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972439; x=1791577239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gzLwnH4jDzrX8kj8UPASW2z1d+DNR/ChcuS1IhF3HHk=;
        b=k5c3t2wQSF9uLafCatVRIMAC8DKkmpeRdKmQZvrPT6rPoa4CLvF5G7ijm0JGTBBlOX
         n9eO36FW2nwHi9GhWNUQo+oH65OaP6A9GkGrlMEI6e1Jb/qQ1MI4coSVtu1qQJlUjXNx
         J8ZeKR0RjtNVEiRAGDW44CzKWEmS4HvC2lLh94gH6LKr1exzXfhLWcKFkM96y6IbHs78
         DxJq3a02JMugFCVaBRkjgGE7Oi2eTO4e7Dfeb4JXEkJXcLJPYMJN1e/gJcETj5F/ye/C
         5p7hwjD05BfAGVM1IwTcUZlKUGtclOJC/yv74aI+WO5owBRv+tsMgiUxuYSEibZbr1Ih
         EVdQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuqEKG/N6fYkK40dOQa63Tuie3eoJI3nEaHTPSzC8fzItOEqfzw0DQP9VIfigwsAVsRIU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWr8vI6VC9i7JX3wn+IVlyKipQX9+IU6Mp5RB7xECkpm4ZxzRN
	HXa2VzIJjoKF5UdyMLRmdWBplBveRV8uqd3NQooHSDH6JZ3VKgYSrU62I/redYYlRKg=
X-Gm-Gg: AYBFou0lxu7Uc0yMCeWFrh8BZ6rsY1eAGz2hPpciL8KSSxlOrprqF7hgcj2tMGvsG2u
	oKDnjC0LOTJ/AWycx51o1WVo9NsynQYKd3tWKg38ydJOgtXGqx+jzmHwu3lVeEqKi40ftB2VS4N
	DQKzkzmlvxL/2ieV5n7GwjlOg5zfQDvVL/0NhHRgbtVzixpP0Ta7yVulSiYnsL0qbp/MmANpsYi
	yCxD1kDNYJtLDdJUGW+XPowDDkoKnNVH+zWjEFHwxQzu4JXht6NR+H5pIhti77IsxC/FFlF08lZ
	zhJx3OE8v8UspV7uyTprRxd/hMQzg+EgV6/Enl2U1V2AVWz1+zVVMAEsWcMyVSVuR8rnjf5nf6r
	CwiQMqp+jzqrmpcCj8LxRSX/ck4k4EU+RKgkCZSn9YvKoM0i88/lQdPwtRyxbCq8fSd1n/HAl0+
	O+8JI7UFjjEXaKtwGNlhHc8cLgFOkpIAxZDRcKA4FQFCgiZjJeqdK/PzZeufFCrDGKJQqnUS9je
	FcJv/9ScrsY/Swta01M6+pS
X-Received: by 2002:a17:902:ec92:b0:2dd:c100:a5e1 with SMTP id d9443c01a7336-2e49b684416mr31187295ad.53.1790972439265;
        Fri, 02 Oct 2026 13:20:39 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:38 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 06/22] target/arm/kvm: Create scratch Realm VM when requested
Date: Fri,  2 Oct 2026 14:20:10 -0600
Message-ID: <20261002202026.1204110-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

When a Realm is requested, create a scratch Realm VM by setting bit 30
of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
for the guest PA size.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index cfee9fe99f79..8c74785998c2 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -108,7 +108,9 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
                                       struct kvm_vcpu_init *init)
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
+    MachineState *ms = MACHINE(qdev_get_machine());
     int max_vm_pa_size;
+    int vm_type;
 
     kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
@@ -118,8 +120,10 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
     if (max_vm_pa_size < 0) {
         max_vm_pa_size = 0;
     }
+
+    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
     do {
-        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
+        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
     } while (vmfd == -1 && errno == EINTR);
     if (vmfd < 0) {
         goto err;
-- 
2.43.0

