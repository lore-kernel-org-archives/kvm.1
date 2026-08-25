Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E73E4C95
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695298; cv=none; b=L1+Jj/pfvBs1PuEtaYLAXYNTQpbEMpeNaIkF8VfSVyeXkG0BHJdwUzU5r4tTUPTUZGBsunYyoZnI200l1D37uBfAh39e224fbVjYezSz6sR3ljcO+8KRgiS2jbYJ6IcqtTuzHFlSGooIvlcDfGHT2YiZ1Tu3qusT/kkxp7ohxLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695298; c=relaxed/simple;
	bh=snL5gDCnz7CzL7Q4L9mr8WIxf6RejbGTB3IRM3ffXvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYywbPgKIA1uXWwWslpLOatgINElNh7Q2cml9cgqXQP3k9Hv6wnudDryAX026sZdgBgRhJnZaPiO3Fo6uDjjmC+IQf7dHSOrEyOQJppSVExfHCwAB5EAC1c5UayUpGBHQ0yWK0d3LkrA7AZX2zs3/MPCXC7+VVUpYUveAIhPq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Deh/pX4u; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Deh/pX4u"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d6efd73032so9616495ad.0
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695297; x=1788300097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OQr0iH6TQlLlru7OkuZsYY/GXznu3bXNhzmozCgXXt4=;
        b=Deh/pX4uEz5sLJT8UG9DrKnClGC1o0cxVd6hZeaxAby36/H3eDPCfI6HQaCAG5Sxuy
         ntDZtxpszfe2F95Wqz94PqY0o5o623kre06/Ok1OElPWALP97HqtbWYSFk+6hNWb3NaA
         WxEAyDthBXHxCqg2fi/zLxvW91bEeW7Y2Wp8lL6ZRqUxBDKYDbL2bqVLAemRKUrAOjHH
         afZs1IaWBCht/iLaXGh95gv7oqDwCmgbBSLxOfH3gPmUEhuMIQCoF1PfkbPlX6XTNdfV
         4eJoH3UvDxJGoA90DWwXH0+RZPiuCl1QR3O/44f/z+Jxoxz7l8JEGYO94q/kgOJZPtcV
         26yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695297; x=1788300097;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQr0iH6TQlLlru7OkuZsYY/GXznu3bXNhzmozCgXXt4=;
        b=kG+e6ywHRQxNpjUu8tz+N78jLY9ocjusfAfm3l2kD8XC+7ZDLGtWnswLBmzjsa32xw
         Ffw/RMTIr0r/DXrg1njLKJCPGe0BaiNCzGl++AlLhxnSWxskUei7+hGTMWc5pM8vyiu0
         tH+etFPDdUTEwNvPejfwXp//Fdp15aJR85O2r71cAnysPHcPPPXjxpkgwtlOHzekW/KT
         1rwHe0rkdcAvsJafWxUN8Wk2VlC3OKP16K4/KA7ohDPfSdPY3vb0DdvDYYPLEIsVxXOR
         kVVsx5ydu98iWZYFm3vHqc/O2MUx83uKInNOtYuzmY5veqmYqxZzoZaRUFcxcP0F1T4r
         dDjQ==
X-Forwarded-Encrypted: i=1; AHgh+RozVuBMmCcYlEEcTHem3VCxNXNVCFSA5gACoc0NlzQAJGtoE+myIHLEeq6r+WKAG/lc0p8=@vger.kernel.org
X-Gm-Message-State: AFuF++l0bPl8Iy+JaxQVlFFBtJZXnhsMphS0IJfayh9B0IOCkrFpgLkW
	kC503Dit0TuinzS6LmN2fGgWmL92sdGPRb3YAxgLIUYmqw2JmXzhaOg3poVKeo3PETI=
X-Gm-Gg: AR+sD11W8I/rajCDdlPqPmk8TXKgdCsck899g+EmqKNBjdyY1COgBP5hdJi+R0sCITj
	mpREfRAevHdBVoE0b8m3tmIFCQwkBIykpoSUjXY+gMCKPu+v+TE2xa01TSED1tGZPb1Y82UhHp0
	+KfzL3LrMMTD2IrjO1kIR0RnETvpF93vO27emo6RDmI/o6WS9nmfCi0EMJwfIz+6LmX9ojFXNdz
	USadtpqfeH7O5cE2NUnftp4nSCDwVcSf4bslDTaTA6rMgD4rhGQf9nhj9nDydYTJD5wlKGeRA++
	oqQ0dGa8ibkFXWw/X6mc97V8nY5afx9Cis+/YO8Et1c0e8MZH3Meb10MmzQiGafAZZJV8a/mZ4/
	s7K8L/lfuqEEVGaeRngi54T84QOfGiuVqoor2rq4tCRh/CLeNz/Z3WdrQ+CrGvMcoAnhcKRhc3K
	KFLeQqQ2RHmpttihFT3TwrGiw7XbB0dVnZ2meZ1MpZAJ/WcEa/Yk5s46q33Bt25luizcFapbtbH
	TBoQjg55HfnKnE=
X-Received: by 2002:a17:90b:4d81:b0:38e:7297:a92e with SMTP id 98e67ed59e1d1-3966d8e8063mr2162748a91.9.1787695296731;
        Tue, 25 Aug 2026 15:01:36 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:36 -0700 (PDT)
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
Subject: [RFC v3 15/24] hw/arm/virt: Set proper conduit method for Realms
Date: Tue, 25 Aug 2026 16:00:52 -0600
Message-ID: <20260825220101.3443954-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
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
index b090233893c5..3418d75eccc4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -267,6 +267,11 @@ static const int a15irqmap[] = {
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
@@ -2902,10 +2907,11 @@ static void machvirt_init(MachineState *machine)
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

