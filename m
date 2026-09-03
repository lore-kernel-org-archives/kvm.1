Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3BF4ACC78
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464219; cv=none; b=nnWoufT7oVpQF5VOOs8g8N8UGnmc3aNKvgEqz7BNCCluHS+PmCdDpOnexQUbUSJel9hWYC2HseDMLDgomQekjd97j/1KDfEaAEkGsGDHKURVleCidWDlpZSIiV7plUbqXvykKrJnaSofvnlKq/+6ZDzthO969JH15l8RF+kX+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464219; c=relaxed/simple;
	bh=iL4LwTv6jpagSCEbFOJxY6wYTYCRxlWMX+RJhMh9vxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzgAovLwqB4Pyu6tLIQ4h38/6hzuuwCS0s8lpUT9rLwDb9FCb7jmEn1ZsD9hqfkctYB851CratL5qQbGk+GNvKLhStf8Z/8mCCnjtFE+J8YzAyWjl9YtoCTBZD9xQjp2lVoEJbI5aswOvWe1ytDku6+evRh7Om+0LehC5T8HnAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FpnnLp7C; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FpnnLp7C"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-395cf2535acso237732a91.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464202; x=1789069002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yYE9pOet48lRlcAA3fKM0Js3n1ztODOyy6XvoWvQ26M=;
        b=FpnnLp7CQ3xfI6s1ylRHY9OFWoGRIWDdNONhl4iGziHZh1ihSLAqZkwJiT7GtvMcs0
         +6cuBkzm5tOxx3UUdLJh/x2OhwLaAzCNWnBnY/JvZOLH6e/8nB+ERBjjLQXCc+YYkJPc
         nHTjuozrYuf6A6a4sIbT2Im4mpXOXKtXlthEFHQANw4RS6s64wtB5jXrxn+dgVNUrnwI
         jinHloK7SxLITZg2ntNq2weInw1uHmFaQOjJfyH2dUXjvVmB6D7WIi4A27FEb9yneHOB
         zD41QRdUkAdUhYxp3INT9BIxP38x/yJvtinzuPhpTC6/p2lEcX99b3qoz+K4CQdu1wtl
         XNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464202; x=1789069002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yYE9pOet48lRlcAA3fKM0Js3n1ztODOyy6XvoWvQ26M=;
        b=ImstH1U/Sm6J90Zw3QZ5/SKRaIUIkMCii6MFFeRfE/POvPBQrcyho5sP3b5luocvfT
         ktfNeb58SVXxnICFPKjERVIPz9rqAvRA0XoBXpIPNxh2BbRO6puX5R9pOKWTaZMQhQkz
         1DhtL1XlOU5jXAbmyv1vpg4pRhS20gOZr3DtKDwMKYXzl1on6/xMdOXStjrGpn8d5tbs
         VKl5z3aqwOIc6G4krgsp8Mqk/938Rn68drYS3c+XARLfolPH897qwR9Fxcydnd/EvER2
         RPI7JeHyWYBlZNDrIKlPzvuBG1d/+IHUOEkmPpROh3O/r8otFV/laG4ZbOZs+6KgSGu4
         wEgg==
X-Forwarded-Encrypted: i=1; AKwUvBwOGifiylA/7F+ChUd8/3jWLES549k8gxKjK2CF8GVBt7y+QfXqn24QCxI6XWMLliV6pmQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nxl28AsG8aJttd1psrGzb84cs9XMv6IdC3B6npMJ8NFFVtVrBn
	O0u7bO5Wf3ntAZ/spE50+y98yrtg041icaGcwZI6zn3iWDsXR59RokaeE8uXFHQeSFs=
X-Gm-Gg: AYBFou1ib00299HxQAfry1vZretKkstmNZN9fBY9/ztmJBioIIDf/s6WpVFzqExYAFp
	wSFzJG2uN6clIeaFAfXmYYNcvJkFNQdRofPDiLRPfKEb1mSiO71wIBXHoRfTHBcg8n9mxxcnSjE
	dtMjEpyhlLu48yeknZh9RqV2EekERO0fS8fK9RnvxUuhGnL2jYGuNmjFKhEXD5lTJe4c38GONKy
	xQ2ZoScWfIniOYN4pgQaGNtKkFN2ekQ+iu/0423qi7FvZYt5OqdX7Vvo+rB+l/D5/k4Xd26/xGa
	0zsIUcRifaxb2lqFgMRZ1zfZw1CHih8Q0f/kJ8LeOdMJEUywSdLH5g22Zah/zfGxF1xdtGbnqc5
	SiEsiDtgC2hIZeR6cs+RudAuv4kcT2zNVHNI0aKA+apILNlKXmQkxYsnjiadPFFHhPHaDgiYTEE
	dKbwSQW0C3vSj+8RtFOxAXU2zuhE6H735bRzaVosleklAX1bTCyW8rjzRjQW8ja8TN08DgwI1sB
	0eno8lxCT44UlM=
X-Received: by 2002:a17:90b:5484:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-39b27c0fa43mr86643a91.1.1788464202333;
        Thu, 03 Sep 2026 12:36:42 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:41 -0700 (PDT)
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
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v4 16/24] hw/arm/virt: Embed Realm VM type with IPA address space
Date: Thu,  3 Sep 2026 13:36:03 -0600
Message-ID: <20260903193611.1058589-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Set the Ream VM bit in the IPA address space size when needed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 37211bc81926..61751aa31e0d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -97,6 +97,8 @@
 #include "qemu/guest-random.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 
+#include <linux/kvm.h>
+
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
 };
@@ -4053,9 +4055,12 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int max_vm_pa_size, requested_pa_size;
     bool fixed_ipa;
+    int vm_type;
 
     max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
 
+    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
+
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
@@ -4080,7 +4085,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
      * the implicit legacy 40b IPA setting, in which case the kvm_type
      * must be 0.
      */
-    return fixed_ipa ? 0 : requested_pa_size;
+    if (fixed_ipa) {
+        return 0;
+    }
+
+    return requested_pa_size | vm_type;
 }
 
 static int virt_get_physical_address_range(MachineState *ms,
-- 
2.43.0

