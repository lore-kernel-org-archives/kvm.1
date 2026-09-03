Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5088750C2A3
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464209; cv=none; b=Zkhr7F8bKudmpitZGtnHknXIHe4ApSUd/B/9NoAF56EkTWSnkiI9rr5iItynWJUMyUnmHeVBAsEQUpMFd84tlULvLmT7oRLDzzxPFAhYou3Z3oMAT/gisrKBhSI2YfkT1eKG0fZ6cvCi3e6pWjdqr5eftreqyHNc7449DTTpjEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464209; c=relaxed/simple;
	bh=IMBvm8HZV4HPb/Gb62LPWpq1+oIqa6VGOWF9uplKIs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNWa0vARt/Yrmv8W+G7S5Rx6+xJj2PMPfee9aWYoUJ1BJDR9S59ucI1zk+X5xoV7++aByEDBIlwvNfdo4z5g/N/L9gCjRsay9oT+Fa9GmfimOspxioAjmHtccsacZlnvdips7mKZ31OUPMHC1WGEsaUAgVYKblv76JSubw8BJOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zTPHiUI7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zTPHiUI7"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-39682983a0fso204761a91.3
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464200; x=1789069000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jnpbPx5FmdZp5NVb3i561iSd61Y1NnaCqk0khHU6ssM=;
        b=zTPHiUI7NkEledWzpFOHRArU34UTzvSrdURvEjA9i45OgQf/oiIRAY+cKH2CSnquqo
         4d3JgbpAKmhc6UvQ7ye1EtYUMnZlvu0g8wFjGMhxXMNZ/9vwGBvcI5HYd/kKf6upKega
         kbW/IWY0E1RrBzmVuGxMJXN/5SpZCLlMMr7Q7kYfYP2ZTd6qr+D/e8mllXz26+j5MX0p
         4avX8d4sB3zEn3mLdJvETYqcxR0rG2ZIC7jhNJQzMfj7TGFfMAjCyWesQTfVcgnvn9tI
         iXeuWcc8dPE/2o9J2RX7c8hBjC/5SLYohMLD3FgVcz1hIRv8cThlz63u4haDqfsoGQZF
         ASHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464200; x=1789069000;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jnpbPx5FmdZp5NVb3i561iSd61Y1NnaCqk0khHU6ssM=;
        b=O5jz5cUJgjigKoFdZgcwTuFLUO2oAI/tqCSLr3/rbU57+4I8AxQDiTi4rqTTQ9/a/s
         jIMptq+uIK9+GsqiFWkY2Vj7gmk9c7mj5TUkS4mneHqgSzfDOVi2hR0ecGt4uk1k4lci
         j68BHZQwzg7NinTx4vOh8s7GCTiDsiOZZwKHtsHSjOKlvKoP+5LwQk27bfp7ZJ2eYrI+
         yZOepd2/HRrj3kxS5kF/34wWM5SGvX1mgWD85TATnI+CV5yhVheyVhwtKpwOTXRU6zQO
         e6JRDANS2pmj0ZCvAmGPjWfXb70WuDuiJKh9CG4PoVTxxkQkcSLrchibezodYs0um1kN
         XOZg==
X-Forwarded-Encrypted: i=1; AKwUvBx4DIA/7anB6YVVPYTb70znZxCEH/XceB3AXfcG8EeLOcISfGGkGn9RzIhQy/AIJw0sECU=@vger.kernel.org
X-Gm-Message-State: AFuF++n7NNbmKkYW+XLUxqq5gdvrnRcXRX9ZgAKueJcCjR6+pF1cfLsf
	cMibwAS/3PZlsw5Ox+WJ3xh95SXvxVvpxQa3ML+j+BMFcCvbLLjCKRoIMpKbiW2ggfJLiRIrQhP
	7UpMv
X-Gm-Gg: AYBFou35hEzgLHx43WKD7HT/blYZpUY8lfeW1Nv9gjMdyKMpW+aZltCHsNLpARDyms4
	tOmVaKB3qlmE00A0By2tlqR3kHyD+1yqrgnTQNb78kDW4qrzX0yB7CmNxOY3fWVRlx8kWyiKZIa
	VjkLea18VYAIBUahVuOOqDQy4/Qhrhy4F3p4yEGlExxSVmfoNqwQNS5nrTm0y+1JkfURsxLx6VA
	tb9MrSpow+HWOKsjTQMvOH2EDaKlq8NgBUHvZ+AM9mz+kpi0GmvJcGc2mErQM8p+G6brjwDpEWj
	EJ2H4y5P8GCK9vQbVzWiDeYwgIuaG6DQExU2StC+OR4HtdBSzy5znSNYaxMgbKbkpftUQiwgs1y
	Mz8bnuqU4JB+sF3uYKnroqUnIoFRnfRDcpv/w2sUl2+vpA3Wp7+9tymGFDX29asb1oToPPYzuvM
	xjD4ThQJZgE7nwoJjaH2OhkeTj8t+Uy6H0IbfuCjs3WWT5lo/6paU2c6ZHomID7y/EpRJZ9euEH
	oQGT7PzXPmKKKU=
X-Received: by 2002:a17:90b:3c05:b0:393:288:29e3 with SMTP id 98e67ed59e1d1-39b26106c44mr1332861a91.10.1788464200324;
        Thu, 03 Sep 2026 12:36:40 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:39 -0700 (PDT)
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
Subject: [RFC v4 15/24] hw/arm/virt: Set proper conduit method for Realms
Date: Thu,  3 Sep 2026 13:36:02 -0600
Message-ID: <20260903193611.1058589-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The HVC conduit for PSCI is not supported for Realms, so default
to SMC.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d738b95c7264..37211bc81926 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -274,6 +274,11 @@ static const int a15irqmap[] = {
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
 };
 
+static bool virt_machine_is_confidential(VirtMachineState *vms)
+{
+    return MACHINE(vms)->cgs;
+}
+
 static void create_randomness(MachineState *ms, const char *node)
 {
     struct {
@@ -2952,10 +2957,11 @@ static void machvirt_init(MachineState *machine)
      * if the guest has EL2 then we will use SMC as the conduit,
      * and otherwise we will use HVC (for backwards compatibility and
      * because if we're using KVM then we must use HVC).
+     * Realm guests must also use SMC.
      */
     if (vms->secure && firmware_loaded) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
-    } else if (vms->virt) {
+    } else if (vms->virt || virt_machine_is_confidential(vms)) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     } else {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_HVC;
-- 
2.43.0

