Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB1149B473
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972458; cv=none; b=YNxqJUK0TkH7WjEr6vk/EI+eqKzw7DzU6j0Nh1qhpfx8miO+j8RwSg6PAkHzZOwhSbsIw+g+qWB07qZVveOyTOIa3ypagQ9EfnE1CTfLcvZCNJPI3VAiTDH/DWeYYK/ev02wYfM2PFqnGGZIdBuLHrg8KBnOdtMJBPokx7M3Ah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972458; c=relaxed/simple;
	bh=wJ7hDclMxFGYwu93vK+NbzO53mXW22dtvGNnL1UPMK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/oQQNkIfekFGWrr1JZvFabXMS+BeCBEXIllIEDy1Z5UEhqrmVliB5nTtkiDDMfVaevhL8Mn2kqdVoRAj64A9Tc2ocJwcPYKKUmbcknlGh0fvEWIlm/UbK9JgsJBjvhf7/gFbJk5hfP7YIPl6F0BlyLcPyBYI43PwHEX/ewXlL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xhbHzhWy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xhbHzhWy"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2dd76b1361dso17303685ad.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972457; x=1791577257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vuH6P0OStc/UzrpQmtoJOgA5ex/nCeUuUbaOQvlKUg4=;
        b=xhbHzhWy1IAPbrKXp+Bo5O/rsH959JQsdikZ0/AEPYPqRyZcpwA5AtGPsdjDm6i81N
         yLObwV30bEuu6ytOK4n4ppbORnbjemVn4UaaG2eGBHciQb/a4CsJs8OuK9cslPjivado
         kjax5BMySkGI5Bv7SUBsXuO8Xb5+odLkQGgNiLVixvmO8MN55G0Emo1OFaykBlvVuEW7
         2JFDsXuctur0N65/0yyP+ROV28Q17ZHuonR2QG3SRUEuKo3zwwkh132JUhzo4fwSnOsk
         /wzxCPSx26sqY+ivnbm9a++wPRVG0nlNQo/mhdpnTA1XKmdtMcpV/lInsoXYSegMECjy
         21DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972457; x=1791577257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vuH6P0OStc/UzrpQmtoJOgA5ex/nCeUuUbaOQvlKUg4=;
        b=F/kOxA06uSocmF5XCNkjeex2ZrkEbrAcEZL1jMaMAHcymVHeLJ8jnfE4ToEDzrVI99
         HY9mz25eYcg5+zR7LbHUbKNj6HVyANZomBJ9dRtaAYWfsKLRAXxTN0NPqja9EtGlfy3K
         eMueEPWcRC98UvaySsapkqtjkw0NOxppNJ7SX+asvJfrF9/iPhQkWvTWzrqjEBBq9lsf
         bgaHg2l7bEmfxvfDnxXDywoCc28NhFh5CgKlqFQidQRLE+NYZJnNYMYE/B8T8qIhIDtM
         9DGfZW2MBt0ty97mrPO1snPvguPuD4Ro6/RP0MmJsaBgQ7PCaZI+OsZOK8v5maDpZXHa
         p79w==
X-Forwarded-Encrypted: i=1; AKwUvBwmEF9Jhkt8CULwqK3ZMFzMs8/0thKfTtmq/bZxFJHgvZd+YZfNqjTlGjwjysY8pVAAqkI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoqthKEzZZ5YXjG3cVEDCvkzk9s7vXl4oTq3hJWGBbZ1zRaSxE
	OSNIdueklgW7OQHv9qjV/IptWVFqJtUB1rwOYNUnG+aAK8Yq+1XSGPBIvy1yUInH3UY=
X-Gm-Gg: AYBFou3aBRdXU7GvNHpL+MxXTKJvURtQRzF/TH5ckNFeqbGyhhYdko1ivM4xwr8Gcfv
	4ZVfZFoOYfjE6X9YYqittTy5Glfg7HxwCy0OtLQCuQyAafpt4LhN2lnW1fGPlLFKxzgYKsQCYy3
	e+RqFTmc40LIfCg5ZfEtjH8CIcKrn92UKsyrlcEnPpGl69+1hoziv/lrBhk4tBaprBWdWIOPOll
	riqMam8/pKyCMyIMVD7clgH/MfNGODkte/8qecBpmFB4m1suU5lps6PYmqARPHwhAc2bLgun0Vl
	B7gw/gzCiu8EQ+z+qZP35JAwUJzkYwTjU6O+1CPJVPXSSliED9KC8Hbv5qSBDdx2Z5FB6q5r6YH
	xGcL+IZrWzohfMF4JgSvsS/kQaHzFjoWcFk/ebm6h9YC4zChGmuIpdzC1KO+WkaF5riiRiF3E+a
	A+XnIQgBYuv65ujsFqFZsRV+GQ1jf3HRSBac9UlRJEIzaNOMMGwn1zYG2wR9xfh54aZkdLofXsr
	QWhALRk147OnhVf4pOtPjAL
X-Received: by 2002:a17:903:3d89:b0:2dd:c100:4254 with SMTP id d9443c01a7336-2e510562a17mr4146125ad.56.1790972456622;
        Fri, 02 Oct 2026 13:20:56 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:56 -0700 (PDT)
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
Subject: [RFC v5 15/22] hw/arm/virt: Reserve one bit of guest physical address for RME
Date: Fri,  2 Oct 2026 14:20:19 -0600
Message-ID: <20261002202026.1204110-16-mathieu.poirier@linaro.org>
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

When RME is enabled, the upper GPA bit is used to distinguish protected
from unprotected addresses. Reserve it when setting up the guest memory
map.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cdfb71ce97d3..b2cca73dda6f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4048,17 +4048,27 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int max_vm_pa_size, requested_pa_size;
+    int rme_reserve_bit = 0;
     bool fixed_ipa;
     int vm_type;
 
-    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
-
     vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
 
+    if (vm_type) {
+        /*
+         * With RME, the upper GPA bit differentiates Realm from NS memory.
+         * Reserve the upper bit to ensure that highmem devices will fit.
+         */
+        rme_reserve_bit = 1;
+    }
+
+    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
+                     rme_reserve_bit;
+
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
-    requested_pa_size = 64 - clz64(vms->highest_gpa);
+    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
 
     /*
      * KVM requires the IPA size to be at least 32 bits.
@@ -4067,11 +4077,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
         requested_pa_size = 32;
     }
 
-    if (requested_pa_size > max_vm_pa_size) {
+    if (requested_pa_size > max_vm_pa_size + rme_reserve_bit) {
         error_report("-m and ,maxmem option values "
                      "require an IPA range (%d bits) larger than "
                      "the one supported by the host (%d bits)",
-                     requested_pa_size, max_vm_pa_size);
+                     requested_pa_size, max_vm_pa_size + rme_reserve_bit);
         return -1;
     }
     /*
-- 
2.43.0

