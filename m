Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423903DEFF1
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647067; cv=none; b=pwavJHirOt4nm8IifqW6sBESTtvr+sObNDKoyI4q1Bzm8/UysadcfGdiBazKI04Hyig8/gxWwIjPuJffih+SJH2hTDNFdFjYGe2a/dR/mvZ7RLYltB+oweaRUa4l4Cy+DJTsn8eH9YIJ8/NLZkL2smWqtWx2lt4n3ZZ9c3Jkb5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647067; c=relaxed/simple;
	bh=0iAVbxJH3sBm1IgSAaYTJfu2cuy78yxvo5wsLfXwV28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8XNAzU+lChOT/yb0fp2ZxceT9DI58jcI9oFf+5i98Vot+oejGwQhG0cCzDdVk684lRWJmfyX8jrRS+luoK1Stl/+POVpE5S59gvAv23v4wPGJ4km86RUhaNjNWtd1MkhBq2f4RKqlLHkuu7J/DO+aNMGZtGH4k/9ERWoDfkYjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pOiMVnoM; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOiMVnoM"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so4721334b3a.3
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 01:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787647065; x=1788251865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EKUnc+hCH/m96lQyJ3IHIfrh5f9TDgQ6D60NAJmR+nI=;
        b=pOiMVnoMgnKWz08lKUBi1dzlFZM0rCoBbT6G4hXhEgjAulrKXgFKIWD/eiQScfuBhW
         NTWpObtorNCgrGijogsplP9wvEqWNn/s8fjdNO8eq9bs+vD1T4q7DiRL2LjLzdi9xjGj
         54Ar64QqzuBjLvgRvV//dn4qCk69fVuG+40ih0O57FwEmvcVcuikFvo/J3JWFnoshP0z
         W/Mw6+SC3L/2eyjpeePQPScMzESxlhZLrk+K4yEVJPcGMy+9BtGkv+klCBnDIIxc2Q5I
         Fm1GXH33Cyh9cJgfVgyfZoroFJYqDBwCRXKtUNv/VoyDoqbZtrjrM08LzSTRvoJ6IVTp
         Bv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647065; x=1788251865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EKUnc+hCH/m96lQyJ3IHIfrh5f9TDgQ6D60NAJmR+nI=;
        b=oVbqNfImDSkHpFAm2BJzj5wHHu1ylr++2i184M92mJNLUqwCoLkbGD4dz1Nuzo9gBr
         iBD5AYdeAV9EjbbALDTFVE0MUWQpvESoSzHl39qfvxGSkxuCNk83JHTSc+yEDndFjRip
         tOLpnEWWcN+SImrXkR/DNz2K0qrepUdaXlJ0PgZychdOV0l8Xxfq/E/9m1yf/d+vAjN/
         iZlehp8i/MOM7I6hE7DwOCoIKiYq2ceq5x+yWTObhsDChCCMsXdB5vMqWMzVpIlaIS+k
         raFvRfvbaP7NRaxrwZvQPZK3nBTeTQ1MLZG2LG/V4ALYm/M/qzmafNGpslEME1YoBpxb
         p0Zw==
X-Forwarded-Encrypted: i=1; AHgh+Root9xrxBMdlV5qh6h+Fr4MOhOo3m6zDcuqyrjquyxqzoozO412aMcCpha+0yz0++WE5O4=@vger.kernel.org
X-Gm-Message-State: AFuF++mRWI4c80OltwDB9oOirz88kCg3G+1l5RfdhcIJdhWDmhYOWRSP
	vM+HiAQXOsRZeb7aBc47zoALNKGFRCluEFU48Kqjy8XYJAzpmXoiNKps
X-Gm-Gg: AR+sD12pe7nlap13LTteNnkUd24LHokAOR0noWWVaB6tZXeHUOsYxUA+YpvpNWFFm0+
	PkWyQI8R9imfKDVhsNdPK4JvkNqYrc7n6vLsajAzNrwE6wthxS+toHtmaPnESDx5FJ6Bl1BXyjt
	aCPqh3W9/yMzpj+KrUIUdbz9jKiDfPx47mS6exXwV38UvkArika1xB0Fhp3EjT4S9r8CeT9uflJ
	cjUhRF49eT0AxlgszcfKN4hfvppYw5od3k4ja0j4vY+F8t0DQxdKt9xWTUpIA4QJqvtBQ5wvo6v
	eSpLDLIRmZaM+vy08TZWxDSLhXnwr+vIlLiS0SdwbMpSmrkncH/qU2Rypwh4UXcqQh1lGqSD++k
	YITqvdo/ySZtEO13DqNrVqy7NGi4th2xDUQ7sFOUxcJgKXrl/NHzTZmVFyXOOkfaoCC1W8Ae8lg
	dmWij4P6TACyCbDowhUOmQ/JcXntk/F5pR8tnnhBH3AAiZPQb3bnU0al+FbmPkZ79M36/93V2fZ
	3zmUdfAXCqg
X-Received: by 2002:a05:6a20:6f04:b0:3c4:1916:9d3c with SMTP id adf61e73a8af0-3cd301428ecmr16874917637.15.1787647064570;
        Tue, 25 Aug 2026 01:37:44 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e60abbsm1835887a12.23.2026.08.25.01.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:37:44 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linux.dev,
	me@brighamcampbell.com,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v1 1/3] RISC-V: KVM: Preserve firmware counter value across stop/start
Date: Tue, 25 Aug 2026 17:37:17 +0900
Message-ID: <20260825083719.643970-2-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260825083719.643970-1-suunj1331@gmail.com>
References: <20260825083719.643970-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware events accumulate in kvpmu->fw_event[].value while running,
but counter stop only clears fw_event[].started without saving the
value back to pmc->counter_val. A subsequent counter start without
SBI_PMU_START_FLAG_SET_INIT_VALUE reloads the stale counter_val into
fw_event[].value, losing all events counted so far.

Save fw_event[].value into counter_val when actually stopping a
running counter, and remove the now redundant synchronization from
the snapshot path.

Fixes: badc386869e2c ("RISC-V: KVM: Support firmware events")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 2025b664961c..56dd5b1b2846 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -671,10 +671,12 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 				goto out;
 			}
 
-			if (!kvpmu->fw_event[fevent_code].started)
+			if (!kvpmu->fw_event[fevent_code].started) {
 				sbiret = SBI_ERR_ALREADY_STOPPED;
-
-			kvpmu->fw_event[fevent_code].started = false;
+			} else {
+				kvpmu->fw_event[fevent_code].started = false;
+				pmc->counter_val = kvpmu->fw_event[fevent_code].value;
+			}
 		} else if (pmc->perf_event) {
 			if (pmc->started) {
 				/* Stop counting the counter */
@@ -692,9 +694,7 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 		}
 
 		if (snap_flag_set && !sbiret) {
-			if (pmc->cinfo.type == SBI_PMU_CTR_TYPE_FW)
-				pmc->counter_val = kvpmu->fw_event[fevent_code].value;
-			else if (pmc->perf_event)
+			if (pmc->perf_event)
 				pmc->counter_val += perf_event_read_value(pmc->perf_event,
 									  &enabled, &running);
 			/*
-- 
2.52.0

