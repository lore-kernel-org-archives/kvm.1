Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9A3B38A1
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222811; cv=none; b=cScYIpsBfiOfVhdrAq9eu/+42FRgMEPB03PuwzV4mJrHux75Ps1RCSBWKVxHhCwwiQiYmNdCGYPlJTM03BqzCDseHPJQRMBqzmwakctf8mwvEI5KfxeiPFhEsjh5eGG/iAzX0UhNMbpcx/XvyhTvq6GaRtH3Q87+Wdv056Bzngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222811; c=relaxed/simple;
	bh=xNAR1oY5GPYb2AH/6EgGmUAxXtSoINJqBF0PCKkKPdI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hNOHrRt9sSw4IsU/6u0GncOmSHibSZDOM9TTJmrIIjJZcD+kw5O4nGOuTKm/b90eayPGcV1CT8pdQdzMuAuSP7cvChBwkwh728Sh5Yc4tuhzRHnm6RnePARfiriOAnHtf5KtUR74D1ZM2j4WWl+4hUlORqkxNXW+eiX+pmd5xEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=0pJhXHuQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gI1wRbZL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="0pJhXHuQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gI1wRbZL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7B122EC008A;
	Wed, 11 Mar 2026 05:53:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 11 Mar 2026 05:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1773222808; x=1773309208; bh=T35/pHyYPS70b8ic0/kKg
	iGDEA2/xcvof0QAFQ3O5ew=; b=0pJhXHuQjbByY7qiApc92CsoUiHttW+kbei3J
	dk2ViTQfOMwhE5hZJmmcF21UEf0lPOClqePlcddGvl3Y3RHUH8z6BR9G58BP90lj
	VktXzPxf71dZHFnjIK0+VF5/s31psjeOjLe86UW2f1s8T5x5OvI2kH3nkqhp99q3
	wYAlRvaIQ5TJDLm/LCZKfY5QvhuVkyAN6I+aR/rkmUEp1CC3ifY6xB0w2SVOdM8B
	zFmlcC7anCQeT6YCj4W9hGdMUCbrQYDY0ZVBHQoRy4Y3YmNYc6UoUDThOn3BDaF4
	H1p8fx/Et02FR0EcGbCK/6KIrrUPgF5CDbdBcXw30NsYuCsoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773222808; x=1773309208; bh=T35/pHyYPS70b8ic0/kKgiGDEA2/xcvof0Q
	AFQ3O5ew=; b=gI1wRbZLeYw3gGf+I+rDjKq6/ZsxFq4z9XgSfzbmtsYz0f2TZqZ
	/oqr3aYRPo95HWZbwEneRms0UZmujqB4tC3d3WPLCd0S40fyJcb7CUdNMDRHWk1V
	Zj5M/JF6iG0gco0ZWxWrQpAzA9wvCByu9Jg9tRhAV0bFJL/dTfvr54O5ioA6DoUD
	YV+TtO3d4yAKyAi5g26X5UyB18M6Y6SLbxVvCv9tigtdV5/exyTPONwpLShR3aag
	jursZcvJ3P0BDk/tVxQ0jKe2xoXXglieKLpckeHjTa1iaNMv/G9fqSYCpRK+6g70
	gzuRdxJLv3+eTN4Wsrt8pCQK/SdM5Lw8XKw==
X-ME-Sender: <xms:mDuxaeRA80nXfUaRUm5YObdwKIn17weCjNMMLMBDb6w2dn4axCtOaQ>
    <xme:mDuxabNw4USKpXqHW-aenG4u_W0_cfNHtc1bIFk_y1dZ1NUXn9CEROVDbbAIYJgv6
    2pYnrsjnjZPzZ7DFeb-SkqfFdCj4T46xnI_QU6P1_pf8NBX_ecJ>
X-ME-Received: <xmr:mDuxaZPWvzITlBCF9aTfoR8qXp6j8wvQVDbJIhV_pyXTyHmTCy1N3UcrhO-uGbm2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhihshhsrgcutfho
    shhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeehvdffgffhte
    eijefgteeftdfghfdvheeuhedvjedugfeggfeljefgleefvefgfeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
    dpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgv
    mhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehpsghonhiiihhnih
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:mDuxaTvyxCgnzxkjUuedZcBiiNJvKLO1VFvB96FCc3c-7i2AnTnXvg>
    <xmx:mDuxabWgQTDbsSAfb3OOJCi6q7W8wb8HFgZg1QZAtFeIFKLa9VpewA>
    <xmx:mDuxaTuMwalHFL6VyuEuovTto6twygXUK7tTWwCsaC82C3YKLAXO1g>
    <xmx:mDuxafXAnAnJFEMnnaYbHvyMNuJTLfeiw3tdPmdwv0PweiclTfGfUA>
    <xmx:mDuxaVZceeB7RcdDjpgi3h-LE2_1rmRuootjeMGrH5i1stkirwLiWnAl>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 05:53:28 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 085D87706AD2; Wed, 11 Mar 2026 10:53:25 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH] accel/kvm: fix typo in variable name
Date: Wed, 11 Mar 2026 10:53:15 +0100
Message-ID: <20260311095315.25013-1-hi@alyssa.is>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 94a8d39afd ("kvm: Consolidate must-have capability checks")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 accel/kvm/kvm-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 984db97779..774499d34f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -111,7 +111,7 @@ static uint64_t kvm_supported_memory_attributes;
 static bool kvm_guest_memfd_supported;
 static hwaddr kvm_max_slot_size = ~0;
 
-static const KVMCapabilityInfo kvm_required_capabilites[] = {
+static const KVMCapabilityInfo kvm_required_capabilities[] = {
     KVM_CAP_INFO(USER_MEMORY),
     KVM_CAP_INFO(DESTROY_MEMORY_REGION_WORKS),
     KVM_CAP_INFO(JOIN_MEMORY_REGIONS_WORKS),
@@ -2992,7 +2992,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
         nc++;
     }
 
-    missing_cap = kvm_check_extension_list(s, kvm_required_capabilites);
+    missing_cap = kvm_check_extension_list(s, kvm_required_capabilities);
     if (!missing_cap) {
         missing_cap =
             kvm_check_extension_list(s, kvm_arch_required_capabilities);

base-commit: ae56950eac7b61b1abf42003329ee0f3ce111711
-- 
2.53.0

