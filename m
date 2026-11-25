Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620982;
	b=lYb3iOags/9R7tVcb1JeLpcu/ECc3dFLqRaXpcs4J8V8Guf9Sm+9eVXLf/1vIr0MxpxD
	 4VgEcY2PnHUqyZxfvmH3mQDbI9rDsTjm0Aoa8pEJn6YerDKTFSRvTmhqSr3wrpWYwnxUo
	 92RfihLgyEh24pzBddGDghwL/6NUwR8s9XT0H6bJaezVQBxGCLrNQPk0NnQ33VOPotFXi
	 lRwMGWsDeYN+LnO5RY+Au4DEyBGcEl8e0qR+TNZ0OFiXDIwdftKv+MbK7b57H09APCy0n
	 7OKA8vLOW+K70ZTHnkJgcG/Z5/Iu398uPZrLhJOruRt4qn2NDZqY/v2AeqJDcVYIomw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=kdXtsK5oiGz6RmA/ZpSIqAQiVji6Qb7T5uYbNNT0Kak=;
	b=rUDb2W1f5n+zS7ngzS+RwtW/mwpTYodj0jVGfhdU738Iyg2BTliGAW9MPvy2NyPtnTMZ
	 JZF78Fjsx3ylt14Eg9OnBldiBtxjJeKjfqaeKXzYUviBZlcPmO8GDZod9sduCmYptmPZP
	 ye5JxdgWcBI6hW8OZCbf33rtm8xO4iB/5PBcOxqkjFLYp2fb9HbGQDSQ1rlSZV+RmTZaz
	 p6LWFVv373zeD5KXXMM9gVc/QgcycsJvL3fLy0FJ/QZmrtvJLvfnoDCaNpA7YWGYBtJ3O
	 6xU2hS1R/533QG7nk9pf7Al/pTl1MbryVeY6QmIRpXqXExmrZnutwDoOocewxUe2xeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=K2qTsagq;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28CA606A693
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F28CA606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=K2qTsagq
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a357b1c649so3467971f8f.3
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 07:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795620980; x=1796225780; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kdXtsK5oiGz6RmA/ZpSIqAQiVji6Qb7T5uYbNNT0Kak=;
        b=K2qTsagqlqoZkyqUv17dVhMa+/T8HsTgQbL6jA7TB1tsoXQ2u0ynnnjEOjxRodMK9t
         MA1Df4Wm9vd3C/xIiQkG+0KBVZ5RMzjMGLUMxLvcVRbCU9czf3E0tghI6/8rWGU/ESIj
         Igw64GMPQMbg+kFTBLyXncXMeAJ2ccEf2e0u4mJcySSywdR+fv6ZDg8kvOTt8U0pmlSs
         6Q2I6K2PQfm3CyMadKaAj7CQtzLrvhG1JFbnDZ4yUXBz1ckhh/caxa3CF6eU2mByPY78
         0LfPkfGt7DNKz3rIBq14/Gf93JLTJKjeDiw+gxs2QTTEGNZkZRWfkZYKwhnZDUel5TX5
         peDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620980; x=1796225780;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kdXtsK5oiGz6RmA/ZpSIqAQiVji6Qb7T5uYbNNT0Kak=;
        b=Ro/f9+/8m8D6G6Oi4vEFa4OmQf2oo/kjoriogQBaz4ZBiOr+n3Q/3Pj8MKDWDIMmZ8
         7Hc4d7M4t8cZR5xSyXcAdDUakO1XTcJAqCqdgbUtrFPKb3iGJPAVnueyx5FDnSyGcMXA
         Slzu2KD3jDVQhEFW4w9yDy0ROxl6UWa9Q3Zzyt2czo8I33ve+h+AoazYWSZQTGLR5gUc
         CiwdA7cqQv4IfWNx+fRJJkpWQPhP/AA50y+gi0j6gxlsEu8Emmb8AvxjeRvWUjmFplnn
         vJPwaTUWIcrA6B0cSl0C/3bHfF+UTy8wM7NMaFcOTIPuTZ+Co9fo8+Pj5v0v+h3Jmz9l
         eF+g==
X-Forwarded-Encrypted: i=1; AL+hErEjCk7Nida0tR0JNcmFZQa72p7gOJ9CxSyrOBi5hf4plwEPGGEeMYsG7OMQAf9wkZ4Bx+8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tIc7og6TD/QzVknbu63NEG+GlSEuMuZU0YlSnPbWC7iFPNFQU
	qeIEZ2wfHwttmRreRNXpZSvUzsjLFZfvg7kNr5YEvkLnJliOslimKLIbVZecWi3yaCw=
X-Gm-Gg: AZFdTZdZFcTpjP3Orc+1FHAExommmjdpeoojKV0fg1F3qygU5sDQgOXW5+F7csDc/FO
	20IBsWAkOkkWO8D8a6c9RGjDVMDBlfi0pSc0209/ki1LPD/+IXjt2c85INqFM2P4pub00C/lqhU
	QAN1E+cNv0XQDf2gwGR5be6SdxB/gdFkEvw/qO56kHtmoOOa36AzzDn1o25ReJGqi4iyTx/btOS
	2ks8RRUoHNMo8Xu4PDmtkr0atxy8LOqJFrEXrR01NKA7O+q4u2j8gDNY75BMhaK61Ec7OVErrPD
	9eAv5kNz6L1XaMjQiKxnvtzElMfTTE+1f1mn1tsAm78dPLJvWpGt+85ZEgp1+d/KJppH1o//FJa
	3ycfzR0ji89R2uMXnwZkEo2fRSInAv9vlK/8V5B8lSVvIN8Yth/JC0HKuBPRyoR0Og4U5NAD+Hr
	ptgleP9ljA+5cwZ502zaDPnBm0/9B9qjyyVsGAqOpo5FBpSfGdwTzQD/bZZgF3FdhH5fPhk6T3Q
	H4YkZZlSDAsia00No7lYht6FDIQuKhxPj02lAzwPlNpsBPajZfMOtyJPgOM+ys+sbXiKv0XBQdu
	PdhIsIp5LKqii+yAaEOkIIPFUTVCGXsxP34DuxOEfChVwCVIiNKqkg==
X-Received: by 2002:a5d:5849:0:b0:4a4:4229:c3a2 with SMTP id ffacd0b85a97d-4abaf7401bbmr39868108f8f.11.1795620980437;
        Wed, 25 Nov 2026 07:36:20 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b8e564e39asm5382635f8f.57.2026.11.25.07.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:36:20 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 25 Nov 2026 15:36:03 +0000
Subject: [PATCH] KVM: arm64: selftests: Pin vpmu_counter_access to one CPU
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-james-kvm-pin-pmu-test-v1-1-c3ce989233fb@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGIAB2sC/yXMTQ6CMBBA4auQWTNJW1B+rmJcIIwykJamU4gJ4
 e4UXX6L93YQCkwCbbZDoI2FF5eg8wz6sXMfQh6SwShz19rccOosCc6bRc8OvV0xkkSsjCqaoqm
 VKktIsQ/05u9v/Hj+Letroj5eNziOExjFhCt6AAAA
X-Change-ID: 20261125-james-kvm-pin-pmu-test-720393980044
To: Leo Yan <leo.yan@arm.com>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oupton@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
 Colton Lewis <coltonlewis@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

The vpmu_counter_access test reads the maximum PMCR_EL0.N from one VM
and then creates new VMs for each number of counters up to that limit.
If the test migrates between CPU types the limit may not be valid for
the new VM which causes:

  ==== Test Assertion Failure ====
    arm64/vpmu_counter_access.c:483: !ret
    pid=9165 tid=9165 errno=22 - Invalid argument
  ...
    KVM_SET_DEVICE_ATTR failed, rc: -1 errno: 22 (Invalid argument)

For example on a Radxa Orion O6 with 20 counters on the big cores and 6
on the little cores, this happens on most runs.

Fix it by pinning the test to the CPU that it starts on before any VMs
are created.

Signed-off-by: James Clark <james.clark@linaro.org>
---
Assisted by Claude Opus 5.5.
---
 tools/testing/selftests/kvm/arm64/vpmu_counter_access.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
index 22223395969e..e7eac736260e 100644
--- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
@@ -626,6 +626,9 @@ int main(void)
 {
 	u64 i, pmcr_n;
 
+	/* get_pmcr_n_limit() can be different across CPUs, so pin */
+	pin_self_to_any_cpu();
+
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_PMU_V3));
 	TEST_REQUIRE(kvm_supports_vgic_v3());
 	TEST_REQUIRE(kvm_supports_nr_counters_attr());

---
base-commit: 5715eba4f80a7655d85581c6c951b71d2abbd725
change-id: 20261125-james-kvm-pin-pmu-test-720393980044

Best regards,
--  
James Clark <james.clark@linaro.org>

