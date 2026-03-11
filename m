Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3632BF41
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222859; cv=none; b=GViDYmWKnjK3hdwS4Zu5YeMdCwiRG+rdIgyuMnwWesV3boGE1zaR0t8kA0AWj/xvfgLlB0mjkSV9rGRYMwondr1DK04hxdWxIIT/aEZ82WMdeOYeFcpFduuUcueTYdVfX/BPizv+/iI6rotBtBFN2bFqS9M6TGcxei5iL4dPIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222859; c=relaxed/simple;
	bh=UN/yE6Ce0RPZJ3e4JvIgGSKqVUUyw8g1ClQU3J+6Z2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XWe6/uj4tPN9mDkVxCwMo3edj5qMMbhUbHQOQvyMEkS36KMGM1qg0Wmj9/uaemsPvOYzXuNBsj6EeM2/+HDEFoE4VDNhqBFxaE29VSrp7ocYq5FqyQO4dKLWbSMcDWRKbVFUyxVASbm1TLpXFS8UV4aAMH8Tpbt1YXa6YZXehuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=jkicxceW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EQ6RXFCc; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="jkicxceW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EQ6RXFCc"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 25A0DEC053B;
	Wed, 11 Mar 2026 05:54:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 11 Mar 2026 05:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1773222857; x=1773309257; bh=P4
	OySs5EQSXB5RyhkSiCa+1SDn4AAfaohkRKSbCu8J4=; b=jkicxceWwvtaTg04sl
	lMqWlAYjN8cgbPWwryidN2PltY95C4tSfkK737nalCcUBpmKPLs/Q9Vb5P0ANPZ3
	VmKoJMS2qZbIyP9P6ghkTaj6y6G/uqJVZ4mFNfgTRAD/uOJKlua2Mi6qli6RtxO3
	AYu8Pu0hMBq0FoI+3KAwnFo1CINkcXZx/JAxLdAGfBg8axysoM/8Y5+gpIIHLLii
	jTX6uiWw5Suj9zzBWoTG6nmRnNtyRr5WWLtG9F5Bhy3Da6EHeHOM9Iwt/p0BW9ac
	eyQqg8xqr340hmgPCsQKz99rj9/SQSC0x4OI7KpGG6jFYCKfCRAXyeMwgIOCr+IP
	DPGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773222857; x=1773309257; bh=P4OySs5EQSXB5RyhkSiCa+1SDn4A
	AfaohkRKSbCu8J4=; b=EQ6RXFCc1/meDHZrlqAFmylPvj36Q/6Ofb1CqvBjtbjJ
	7T8C1QM2XQdC2z2bkbIlXuXjAEjzYP8KBawFzmsuj2Qu95mDk+ti5RREmsO+g7sH
	2TaLq+JXNsldxP/7uJSFdabm2swXFDjMX6sVKhBwLkUq2tt70VaqGBGkPLh+NO8e
	hXu+/rI2Ca5+HYLAR5+RlU3u6vEIuB1wzX3IiQ9iIMg2UB0GK/gGdfiVaAQakzvo
	MwEq2wnLzEv5u9bKQvo7E/KuciO8b9hSYxWObTfeUmlsnLRQ4dtbVOuNZbcoiPSw
	jggyoAb0919yFqxzSxy5j+YWMrljWukDHgrW45Hd4w==
X-ME-Sender: <xms:yDuxaWFNt944ESiQ1eMvQO56r92tpTI9AzMGMHJBOlR16xrPxaHk3g>
    <xme:yDuxaZkcy_Xz6KUxRT7JjxiXmvzjbvb4NNkUNJd_5mWAlzGaR_HkFGHZ8O2ZozSeb
    RIUDOlZovRwk_m4q6673gQrMrakcyBVECeNKQJg5_jVrRsxxs33>
X-ME-Received: <xmr:yDuxaSZ_fBmL34gqlfRwxO2kmfmse-tcawqop11witI7wxnGFCgOo2Xnl5fjevAc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeejfeehff
    ehjeejgfdtffetkedtgfefgfefjeegffekjeejgedtveejleehleelhfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrd
    hishdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    phgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmh
    huqdgrrhhmsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhes
    nhhonhhgnhhurdhorhhgpdhrtghpthhtohepmhhighhuvghlrdhluhhishesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtohepvghrihgtrdgruhhgvghrsehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkh
    hvmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yDuxaWG19W0Qi6FzeJHs118xgpSzZdyofYj6QKaV77pmVw2tOPf3ZQ>
    <xmx:yDuxabI0tC0S6_436k3qwjTZh0ehlDPym86r4klrPpkaRlVtfczibQ>
    <xmx:yDuxaZO7d58vMG4Unf5bzuRA2wvlXG2zR2ex2rxHkRfr8Lf83CHXNA>
    <xmx:yDuxaTlL31FbJYuCkVVqSJZ9weozYFODYiXcBaPKblrOK3Zc2QDDaQ>
    <xmx:yTuxaSqT2472sOmb4DKlPqs_hxj30VxLrRRGbu60yKHz71oEoiVuuDK3>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 05:54:16 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 4D63C7706B21; Wed, 11 Mar 2026 10:54:14 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Cc: Eric Auger <eric.auger@redhat.com>,
	Miguel Luis <miguel.luis@oracle.com>
Subject: [PATCH] target/arm/kvm: fall back if nested unsupported
Date: Wed, 11 Mar 2026 10:54:05 +0100
Message-ID: <20260311095405.26297-1-hi@alyssa.is>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If I create a machine with more CPUs than KVM supports, but specify
multiple accelerator options, QEMU will fall back to the next
accelerator.  This is great, because if I've explicitly specified
multiple accelerators, I've told QEMU I'm fine with any of them being
used to provide the machine I want.

When I create a machine with nested virtualization enabled, though,
this doesn't happen.  KVM often doesn't support it, but TCG always
does.  The nice thing to do would be for QEMU to fall back to TCG if
KVM can't provide, like it does when too many CPUs are requested.
This patch adjusts the behaviour to do that.

This is very helpful for OS development scripts that run an OS in QEMU
— I want everybody to be able to run the script, always with
virtualization enabled because the OS requires it, but for it to take
advantage of KVM acceleration when available.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 hw/arm/virt.c    | 6 ------
 target/arm/kvm.c | 8 ++++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7456614d05..0b63b2eac3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2372,12 +2372,6 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && kvm_enabled() && !kvm_arm_el2_supported()) {
-        error_report("mach-virt: host kernel KVM does not support providing "
-                     "Virtualization extensions to the guest CPU");
-        exit(1);
-    }
-
     if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d4a68874b8..20dcc6a820 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -615,6 +615,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         ret = -EINVAL;
     }
 
+    if (object_property_find(OBJECT(ms), "virtualization") &&
+        object_property_get_bool(OBJECT(ms), "virtualization", NULL) &&
+        !kvm_arm_el2_supported()) {
+        error_report("Using ARM nested virtualization with KVM requires "
+                     "a host kernel with KVM_CAP_ARM_EL2");
+        ret = -EINVAL;
+    }
+
     if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
         if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
             error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");

base-commit: ae56950eac7b61b1abf42003329ee0f3ce111711
-- 
2.53.0

