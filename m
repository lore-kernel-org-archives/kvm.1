Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263500;
	b=c9v3K9ZVJ3SVKmudNuQ7efqatn4mYM5B/Cj96bakl8tPhwzThhWKayvcLMBMOTJ29aeK
	 NIjAe85r3hUR3SCksarSnOfef10IjLJLredrd2XmirK7SU/t2WjqUurbzs2/KaNyM7SzZ
	 bGTVCxo2J+VOyLWG3b89d0vGsWI2fPqTZ3fIwy3mOdA4PviY2wkDZ/PzhaaMa0Cfn3DGP
	 IeJLdMAXux3OzJV+7tkQ34KtSShsaXGDSvWL74XSjuluyYpk+cvHCrm0RJVH0Q9G4QmLx
	 H3PHNATSy4zCyPihyESXdH6ETxHQft9OmRJ4u+yzDUw7MP0j+6QoRpt+OXl4bYVDQ2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=i9nhvaLoCHlCTOlMzemv0u9BHztHblZnwWmHlsR6Hmc=;
	b=OEFvdTJZuVy/ZxF4T6Kd7TC5KKaJlNdLJFFWfDbKPW0nHlqcpoqhLxcSjNb1xiP+S+OC
	 p/+akWFks8RstTlKZXmNHK02NbgqWCyOLcOoEJ4UuwV3ZvOI5IcDSBhHzlL0U05Jn7P6K
	 4etBVyjA3n/ZUVVpaURdXiBpwTqFFrskaT+CD07ZKLrpqUHwXZsKmRtzw1undEbm/LI1W
	 knv1bKFD+1LQ5XEhQMfPi0j+orpiBWeIxCO43wHg4MNFBysHUJIi0ON6gzVB8lIXrNxTU
	 fAelrEl2c1iIStxfaFE9C1CP5hBFOCq2aqGmHxxNTSZ+oN9+CzO7LtCWh/lnqEMVsIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HBZGDKLZ;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33709606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33709606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HBZGDKLZ
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so639145b3a.3
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263499; x=1794868299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i9nhvaLoCHlCTOlMzemv0u9BHztHblZnwWmHlsR6Hmc=;
        b=HBZGDKLZQYwMaw1v/HYqxUga1mmuLIbYHrCOPlFgD+LZOnzRaE/NJB0Ne1josG4pp8
         eAdE29wVUGxUaLk7pVZTjpIdE5NJ70FR+URZ46dADvJvzmS5R2FH1pUhPSrEY9dsyxQr
         kbIkh/V9FuOipLGvUdq5L7k1OvhX++4//OtpNGqkLbNToQMj/11gbGOxJF7jtXiwb8jG
         ixHKHJ0uaUUR33zl7MWeB+2yX3tl3lX8tq0Q7hylSQth4is+dnwar9RvfyC/PJXVI8g+
         L31zfwce0PBNhSp8zwVmb26Ivgmj34PeqaokRJtP6tmJdt4d7g78p3XKsezsn1epRPC7
         1glQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263499; x=1794868299;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i9nhvaLoCHlCTOlMzemv0u9BHztHblZnwWmHlsR6Hmc=;
        b=gfwvU7FDeGDX1p95VZGMRZgSGLPY8WL7V9Vrzyz9qmdmhRX3uz4VjhuGsZcp3l91NP
         iIOqUU3oVK6MUD1n0QsKFdJN32l0mK2NybBcyWRTqco19ekyHoqzsRFiFk9ceOOaYDcS
         LK/zevndKEubKksc3TFMyyvt0BhTBVSReqRDNhCypOhf14NA+8wXqM+WBvOHV84gl+nK
         9pHEz/OcPb4I4/VBfOOKvLTrsFsvYXBO2TwE0oEQ5RLRUjX6xnJgGuz83uDpCbHo+Xp1
         +3yXOhfHEx/JrmZ7hNmv7gXZu7pezVLutP5kBEd656J5/68TlqLaDxxBe7j76geDMmh6
         fgTw==
X-Forwarded-Encrypted: i=1; AL+hErFOy/zaDbwwcrsktvTSUwA77fdAY5kDC+eH9PV0+6y4UJS6Vfja1bs69jV6HDm26MYLmS8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+f1PucfaC7IqDyfknCG0+VBBABOJvUG1WPkrHhuKkw2xtnjBL8
	PJibx95b2R+spdrUshsycu5PonM1NDR+9ksF8po+cE5TMf30Gj3r9ikzkAO23EQhYOU=
X-Gm-Gg: AYBFou0IJTcNBIcXdUwXMIwPOfOCgIKAAg0eccR5AVXOuK5r4CZWtEOtzGG7oHuzUUZ
	tJYHAMaQR9QsFzaPaqJV9Q9a9ED/8qsSOba0uZWRV2JYPIMzL9xyD4jtPLfY3oQdlSM4chqAzQU
	OeriPGQ5Cc8RPQV+TX7A+83mJd0Ml5zufCgPs/OqArY6D13x8gXwx5kynBI11nd/0wbsLXwrSJL
	DCj2RumSeJA/iLwa+DS6Zfy8qSNg/0lt/F17eCZl9JUkN0WTUKAdPHG7USwAdsFiU0qZqHnCuaL
	nlaKz7HrOTwtnA8VNh9sIW0YjyQg7AnCZR0B8HUKrZ3IMtnw042gNBPAq4vvbWpmLux35iuDc9p
	1x/14J6zbruLFKwYMZCSVnCSabQd9zjS3v9J0miIaX4Psdqaut3A0Osf8rzDCC2r/5AmKdDiLad
	NJNHynn8yZVVeqN4AtLvKiwfgUT2vVTyRcKhMWGMCG0FtFyz3TV5D98MlRaiaFroxFr47Wr16ur
	wp0/je4HfbfLaRT0bZoJu8issbv0sWoREGxD/oLJo80WT6o0NeHEHG2Qz7r4BRnQg7TQ9+/FpwE
	tqrLXv5RdXI+rfsOmyN07nDRyDx7Iut/sD4l+XECTOFHRnwzhZes7G0=
X-Received: by 2002:a05:6a21:a43:b0:3e1:c58d:aaf5 with SMTP id adf61e73a8af0-3f190f972e2mr456442637.88.1794263499500;
        Mon, 09 Nov 2026 14:31:39 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:39 -0800 (PST)
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
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 14/23] hw/arm/virt: Set proper conduit method for Realms
Date: Mon,  9 Nov 2026 16:31:01 -0600
Message-ID: <20261109223110.1619504-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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
index 0b11f7e328cd..0ed6df4b9b9e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -273,6 +273,11 @@ static const int a15irqmap[] = {
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
@@ -2963,10 +2968,11 @@ static void machvirt_init(MachineState *machine)
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
2.53.0

