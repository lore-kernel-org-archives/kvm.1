Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895533403E1
	for <kvm@vger.kernel.org>; Sat,  5 Sep 2026 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788598741; cv=none; b=X13bia5Yl4Hn6HojXaWsSABPOQOacJ2ckAVbmMC5wgdT7eGQS2HIyJTJlBPW24mnY/Cp3LMxNdoAN8k8Xz6NfBi8VBakL2vzUUOduGBksc+n9eirVcDbxB6BQhYp/iG7s6ceV380yOJKaifvybdveMqZoyqaBAXNpz0hIRu5C20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788598741; c=relaxed/simple;
	bh=V/NeoGBnmEdvp3k4w8PCcy5SvGN/W72/Vg9D5399iLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OviNyxCPLn/ohcme1veke330FxI3p+aTaLNXcQyC2RYzdTZTKLYM9r/JOnG1Lcp/KMXNi1lyrjVTP5qm4gwgk0NGFJC5qm6Fyuqq5TxTKLUeIIuKmlHu1/NRkEDvj1hJ5QbKvPGsSvVTYcQBblsUJeUV9K6vGvxnvE7tl1MPVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJfdRVUQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJfdRVUQ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b9320423cso19815715e9.0
        for <kvm@vger.kernel.org>; Sat, 05 Sep 2026 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788598736; x=1789203536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k5DmudKMyqruC0Fs8Lcf8OMZE9n3CdnS0WF8To3bTtU=;
        b=TJfdRVUQDPDvYZ3oK86Lt/jk6JAQBCA+fN8pYVVabfWN3WNrLN5MN2nzt9iFFWgSTc
         VUrIXLucmhZcEE/5kVC/JPIOCLL6fu1HCUmdBl/80RgbjE4+5OYfhtbPDaIPWjUwkeVU
         vprLZTPvKWEbr065NXWoq14zYriaSzMBaAmyZC1X0OcGndmXHFW+SuDi7E7e+zLZnR+L
         tBhdimAnoYlowEhIdcKd7rR8kyDd1KFyRe3frnwXL0chCS7ny8nr8tbL13HpbAEgfb63
         wRsimO4McQFvsW8fET9zxhO70sTLmYI2V8zsSt7/6QWt/BU1lkluIicPeneoupOzNJfB
         ACCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788598736; x=1789203536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k5DmudKMyqruC0Fs8Lcf8OMZE9n3CdnS0WF8To3bTtU=;
        b=DiP757o5Puai4iPsWgSVKl91qm+Ujy+fL5Zm9O7eUFK4YA4wtegqgdSWJoWv+J1rtv
         inJt2oTPIWBUZT+n09WS8wa/PX3WTjGvHyNwv0/BzhMru86YhQKz97dAdxl06dVn/2Mr
         s+NBX/uYYKiPvsTwImOiKm7GGm58A8xsQJg2hq5w+lHVj3FQZe2yS+C4aj+fNWSpF/dA
         qife946aus4ss5N0/W8WQDDDpMsKXyObtvvQKi0fOToURufLCCcZnBpghgYp2PzFqFAb
         hnz/n50okrqpwwU9h9LNU/u+ZHh1RM32VbO4UD/qETp6OKJOT+Vop71ls9PSY+mrED6n
         jGdA==
X-Forwarded-Encrypted: i=1; AKwUvBx9H0Zw3492pRS1JR85HB3sQ0ZwJzJSC1cj3hRjW0zBT2498/z1hgLvtpxy8c+CvYqOS5g=@vger.kernel.org
X-Gm-Message-State: AFuF++m7pgDI8oAdohev2ohIlwd3GUjLttFhqQs2n/X9o1au8wu28Gyb
	3G94DZzGEnzJ043ApeMLI9YXPnrZwsMKgrLPZLXPpUs219UNEIQWcyxd
X-Gm-Gg: AYBFou2ai/4USPgOqQEqdJcPB0ElmgawfaJ31gHv9EVTxXEH+OOtQOeN1zN8hdHbjzh
	mSqMbfpUvMX+8H54vOfX1Na+N7Iuah8EYximMVsuuJqtI+T+mIF8ol+CZjWBaN9pfyVi9TwO1hi
	eT8X2BqR5sPoi9x9sm2RXv6CqLoK3rkvRV1Ysmimhq9UdibmqNdob6AQa2+kMiFlJX1EBL5rNFE
	HgVaeNAUE4E+bgVtWMwkrXOe9FEd3RjYz85ljYUluGSjPds2hzzoB6U/zXD16WJ/5WpeJlEm2pw
	thr4aMrHDKjEMPB3vpwRE7gag/eNxHPoADWYSR4412YC6sI3eq7+okc/mRYLuaLicUbO8085/mq
	vF/XUeFjUxPtfDf71y99JklySPzOH4LILvLu6KUzKN1BrS9R0hVlmk4JBu+ZoFk0BlZHjyZ3wbL
	3DNrNB7i7428iqtTo/fGo1Zkl4iNzCJbVzbNguuuc0YnYHapyMs4gkh3UaAm1PS+ikIigtU6tsw
	HOyHqJ0di9yCQHHADRypOv9pMiA5hdOjH/a37ZDKm8Af55dKP42YTpmX0MFDzwdgXhvCCwLwOXh
	mr+8hxx7UdKmvp3YvBfON3j9TQzUPwpnAJXpfs9HbL0nqECwCuwiJ7Xo9djs5SVFTco=
X-Received: by 2002:a05:600c:3f12:b0:49c:c8de:96a9 with SMTP id 5b1f17b1804b1-49cf7fdd2dfmr200970085e9.2.1788598735989;
        Sat, 05 Sep 2026 01:58:55 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7febb4sm233053035e9.14.2026.09.05.01.58.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 01:58:55 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	kvmarm@lists.linux.dev,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH] Documentation: KVM: Fix the event_source sysfs path in the PMU attribute description
Date: Sat,  5 Sep 2026 10:58:49 +0200
Message-Id: <20260905085849.40479-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PMU device directories live under /sys/bus/event_source/devices,
the document spells the bus even_source.

Fix the spelling.

Fixes: 6ee7fca2a4a0 ("KVM: arm64: Add KVM_ARM_VCPU_PMU_V3_SET_PMU attribute")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/virt/kvm/devices/vcpu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index deb5c51bc00c..a3f20a4ee4b1 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -135,7 +135,7 @@ after selecting a hardware PMU.
 Request that the VCPU uses the specified hardware PMU when creating guest events
 for the purpose of PMU emulation. The PMU identifier can be read from the "type"
 file for the desired PMU instance under /sys/devices (or, equivalent,
-/sys/bus/even_source). This attribute is particularly useful on heterogeneous
+/sys/bus/event_source). This attribute is particularly useful on heterogeneous
 systems where there are at least two CPU PMUs on the system. The PMU that is set
 for one VCPU will be used by all the other VCPUs. It isn't possible to set a PMU
 if a PMU event filter is already present.
-- 
2.53.0

