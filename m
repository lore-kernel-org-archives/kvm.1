Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86D33D7D7E
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964480; cv=none; b=PNHdSr8SmCgkIKQM3QFzezXOawCIJnO85cXyFJmJrwU2r7D8/Pow+1tTMu5bibLfEGbBz9RiUJ3IaJFj43sVSIDf3gjDcJYj5OvVLDlnf23aqUMmQ6+33LGiLHq2apwJ+kzc2LUS/wt6tNPexyaUIp09JhOnxMEwYy3eJ9OjmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964480; c=relaxed/simple;
	bh=ZXDWnHLtm3KRURI80SC0blsHz4wd8Ojq9dZflBeq7xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOILZ3Q1cOC7TG1i7167k0GGV8Ln5P4SgDlFzlazR8KcOzYG35q3QZw+qA+Q1uIfrBHNnyr/HA3HoGq1c1l7KejO+fh82jVSPXxSo2QCMSsdlL/XJyQELXzc7rqQsFtj+SixfEBRgm/w1IPVZ6cqBr7d4UowIhuknz0VhPwjMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5qoRFKh; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5qoRFKh"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c801b30188dso877684a12.3
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 00:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777964478; x=1778569278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jJf4WhXUUpmHUZbkU4wz6LcSFbd7dc9g4L9gytS1OMI=;
        b=D5qoRFKhruygFeWAGgzAMggVumrw3lH4AmA9s1UMN0N+hzF6dWRuF/5gZI4TWBdcFE
         5DaL3e+MC5FH8iSvo1vuREqMKaSoTHBPWnOxPE2Ur7IJNdgwX+kbbZ1alHxBLMlL+uwZ
         vCab/N9PKyBj0DpFzjRKG8FKaaZju7q8TR2eCUhAGTNDAUSDKVIpt3hmEIV97KNTeiGu
         rtmkKOfSs+r/ZCg+289kaTSK5xryPkN59AH6VBlVZlPnkW2vwsx+K3o5ToLe29sbesgh
         NSL0mk9lksELmCpzH9nJdYhxEQ4L44M8WfIwbB1pe43aQyyrCQwpPBI/nMIpCuhyWVbN
         3Ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964478; x=1778569278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJf4WhXUUpmHUZbkU4wz6LcSFbd7dc9g4L9gytS1OMI=;
        b=IFUffHZCc2RXH0HgiSbeFtzv1iK2I6ZR/CX7HeouE7nT8ZGAb+DNcYViEsvlqheWLV
         +hp/gz59evHGUhK0iWEJUFxF06IiTZM/1su4I7aYgoKmo8HU1sgVhjg6S78pnJISP7Vi
         NlaqYOw/evcgcikeJKBEUZQrJ3DuJTd5M9NpL9+pFMDjM2NMjdxS+fuGo94iTaoARWaa
         cl3uxdiCDpsGEAQfN/Ke3h2+765l7fNNHzJpjdhYqbCmXNFW7P2pPMcc2B2m8r6LNJXz
         3QBj9Pp47EPVVJQiKeVBdFeq1rLQ3mAu7rIEf6472OfkamfQo6rKalRqBYJt+Lt6+rxd
         J6EQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vL4dgjhyuY2KJQ35WDVlSdc9s33D+TQ/vm6ZdGnGTWiEUByAU2Zqa5HFWpnEbJ+EhhQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFw/NjwjxdMD8h5Kh5vXaMcYkeJX8HYg9WA346+PUMqbtKUQT
	UkXb1pd2S3KIqUCwlFnNAaXAVU7hqRtvCWsZK40n1wZLKWvZeX/CrRo3
X-Gm-Gg: AeBDietjdrxMfW3jtUeba4ecv8EhpqtTnutj1+kuMPihHyWGXk5XRoGs9geueeOdpeS
	vDTqFFYYh3USnQrF2ck08BZSupDRyJDQHli2N7CgKTAwF8+hcVJupDZSN7DkB7UyJoX4OL8A0eV
	NxIjYE7wgUPTg6YErc52Evcxm7zaL1BIBxtrRrjr1ZTPOaWlJQHUTgGL20YtUcEU1XTufU8ghpq
	5EK6hRkbkWUwF4rPNUI8xVv9Netc8E2O0qSeeZI/uJmUgQLCENYF68hwwzXOEEncp7UabF9r3aK
	GIV7RLcimsZ+p/sjml5nR/B/F9N/PA8I3iKmTwaebLPU4NHjcV80WBfhd276cGlk11Mu+bYiQQg
	hv0SgHLpucyA6kdLXPbBrIHGgcJKaKyh7077wsa44I6rgJDhTmVQdhnLZG+gI5gFezQH0RibJal
	KUZ6Q8v6dxLT+MbMj2IR8yNuYCKb8H8PuuwRmTuSDaWtaIAxQmM2JuuVlnXzg=
X-Received: by 2002:a05:6300:210f:b0:398:a76e:4ad4 with SMTP id adf61e73a8af0-3aa3b4bbc15mr2149659637.21.1777964477939;
        Tue, 05 May 2026 00:01:17 -0700 (PDT)
Received: from honglab.tailc96cb.ts.net ([140.123.97.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8c1bsm1353445b3a.34.2026.05.05.00.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:01:17 -0700 (PDT)
From: "WEI-HONG, YE" <1234567weewee457@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: vkuznets@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	thuth@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hank20010209@gmail.com,
	"WEI-HONG, YE" <1234567weewee457@gmail.com>
Subject: [PATCH] x86/kvm: Include linux/types.h in asm/kvm_para.h
Date: Tue,  5 May 2026 06:58:48 +0000
Message-ID: <20260505065849.81691-1-1234567weewee457@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch/x86/include/asm/kvm_para.h uses u32 in function declarations, but
does not include linux/types.h itself. One user, mtrr.c, carried an
explicit workaround for this dependency.

Include linux/types.h from asm/kvm_para.h and remove the workaround from
mtrr.c.

Build-tested with x86_64 defconfig.

Signed-off-by: WEI-HONG, YE <1234567weewee457@gmail.com>
---
 arch/x86/include/asm/kvm_para.h | 2 ++
 arch/x86/kernel/cpu/mtrr/mtrr.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 4a47c16e2df8..26e86db37b05 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_KVM_PARA_H
 #define _ASM_X86_KVM_PARA_H
 
+#include <linux/types.h>
+
 #include <asm/processor.h>
 #include <asm/alternative.h>
 #include <linux/interrupt.h>
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 4b3d492afe17..cdba5bf4a51d 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -18,8 +18,6 @@
     System Programming Guide; Section 9.11. (1997 edition - PPro).
 */
 
-#include <linux/types.h> /* FIXME: kvm_para.h needs this */
-
 #include <linux/stop_machine.h>
 #include <linux/kvm_para.h>
 #include <linux/uaccess.h>
-- 
2.48.1

