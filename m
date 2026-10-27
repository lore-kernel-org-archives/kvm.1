Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793082372;
	b=SHjecElrNNI3mYdUeKV4doE/c6UbJCKcNwD4wDGy7M4+6CYx2VpAd/kaRB0YbTCIceAC
	 zqCvq6E+ON7AhXYFv2shU/rcif/Grwo4Wmq+aSgOi+e/gspzv85X/OUom0erLIyj0Bbcl
	 0qLyar1IoyAfOEtPH+y3lRUqJx73qTPDwC9vrJeFznGAZ1hs+KxZV2Ma4XhDOqnzna2es
	 TVNOOSVsWSQNOR6mlN9utzQzrKjjlLc3iiHQIV7GeFzhfnfZ14UNa+UX95+KWI9i1g4ZB
	 KQtOjpx2cgHLH7OACDnG7ZQuaGL/wQjbbi1XfnuzWp663Ckczxy1ze3olnhKUKNjC2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793082372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FNh04yRIP0CE19slce4i4RIxfhIIH5488gtyMIknFlY=;
	b=Dep02cqgnmb3NF0JaPefcet4A2jGrD3sEBpSY53EWo/qsCWDRTABg06j1wCiKPy1b8g+
	 MjNu4qyPY0JFaO0qTpnD7lvyFheVIsADimtBLr2h3HwTtgYnzrgmlhe+mQpw0I8wb02ps
	 PLXiHFOs5Y2+uM3S7TzDJckeXbj8vnhzOEY/qThq+6r2McjtbSCLq7rGBEgoZDYcXqvJO
	 lcygkb2In5ztFXZItq3qgGZWd0U32WofjKJMtGoJG8Ajsuf828duJgyGPEIcIJyvkckT6
	 DTaZ6hPtujNg7CBmadA9sSv6ENObWbDj7FuNdtmrr6lOBKG0KLWJPXKyJuYP/WsVKRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Tr1UmgNz;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D0F606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 06:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2D0F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Tr1UmgNz
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9eb579c0eso21350455ad.3
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 23:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793082370; x=1793687170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FNh04yRIP0CE19slce4i4RIxfhIIH5488gtyMIknFlY=;
        b=Tr1UmgNzIFhIsCU53Vk9vUO8r4O1V3ENts7ePvhxZMYpyYaVBPcya6VHQ5OYtx7VHr
         P4lxvBf6YbylTIa3oPLxR0/Gs7jJbEPlMLNcLoEcq+nd81Jeknp7hvVR8A0WpbQSDoGu
         2k6NdFQyFhQ2Urb/59gH9YO/f5I9EI+9W9wxTqwSEka+Y03BLaxQADiw79HgPY2N+uYf
         6fuZ9ntD0FklhKVg0BrQ4npz8f370IPwre0uUlF+LSDfxzflTtW+2pVTtXOsGhpVrxVH
         iICHBwq69gKP6QOxlon5RpqIuNWIL5S0lJ4L71vdSfDeERINYyP9IjJcruFd1694tCaF
         dLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793082370; x=1793687170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FNh04yRIP0CE19slce4i4RIxfhIIH5488gtyMIknFlY=;
        b=A6g3KimIbkWX92OL7mRf8TGzNV9evtapL147SdvrpdR91CzGlWHOUduxYtanYVuALy
         A1Y3Wo2X7Tc/wzWkmbj6G80Y9wk/gN7vz2ZzhM+kqQTrvk9Vnq48wC5v0HFH2I6Bz2oT
         1DslAVcTmNfSsLgOUCXTzfJmsSBBlUXhJ8yBuDfKPTZ8iheCffPPkZKk2MQrCTRADjKg
         qjXOwx0J469vf1rK6KkYBA0DoP0LE9dc4Xnf9GdjYWojRyhtt0mDLICw0nu2hs5fyaum
         g1vmT0DqjVxE6ytCObz/Ufitm/lrlsP41BSkIkhzCLZFUe/ztjFTPsVuipGsEio9IctG
         UEqA==
X-Forwarded-Encrypted: i=1; AKwUvBx+dIgCwJOLjO/+mUMiTym4XcaaGFfTpxBk2MIO3cXVyHR5G3lXA6zyqcsz5L5qydinrUk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtm5IpJ16svzqkuuoL7HRE9IITfF4gKRFLvJNHH8fTcNy9HMj3
	VLy2SCt5pnVh+B2oRMxkJAr1Vr8myBr3mwjlcGU1I0t2E3QLC8Tgg60vA4Jv5yel+7E=
X-Gm-Gg: AYBFou0At0CZqOATEFk62AeTWIiNqUmqM5+GTDmOd3cL1Z4TR3C1vDql2C0ryXuvNEO
	XVCKeI3DAaEayuxhxxn+bMYbI+bE0/qYq61RpLhpqJpz+nCwWiv235ZYelBNQI4OBaX4+cJQLw6
	c7+QFo5odjIs5l+lmteBoVNabb8uUBAvIlEDZLPymL8TqX28GdXJjKEnClwsCeqHDvyDco+f9b/
	pw2gfoYRGP8bAoSqXNWhe7Oip3fhmCVn1OsnzLWkPO1A1UqyOinHfWsHUbKCUsr9rEz5M4VXvyy
	IypKJH2RmETpeTyMBZ6RW42reQ8yIR6Gl/EkGevhHU8jNGILxoNTnagr4obshQ9VDXQlGKJs4pt
	rNSNNdP/VWENlobYzJOek2DxeaIFvBDEs8/x0w4U8EJ35FI/RMf8lzzvpIP0L9wn9b5Z9clgKlC
	yeIGF9B6O/LbmLzuvb3lJVsSOCjANEF6yXq7QbQVHFOwHAPELNHCWuTmdI1NQGa0nxIJEIjjh8D
	/Ia0wWeuQhb2SzAJLfN8lY4hyg2IA6TwSzBxyKQywsYeBjENSl0IwMHCmUzK7u/AW0woeJ7jCYC
	83dTVQiRkIofNOlGtQVIQHSRxkGFP5tko1yjkK+YxzB4njVfAg==
X-Received: by 2002:a17:903:26cc:b0:2dd:c0ff:e727 with SMTP id d9443c01a7336-2ea9c913694mr67964825ad.57.1793082370138;
        Mon, 26 Oct 2026 23:26:10 -0700 (PDT)
Received: from n37-012-226.byted.org ([115.190.40.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b79ce2sm4079055ad.21.2026.10.26.23.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 23:26:09 -0700 (PDT)
From: Qingwei Hu <qingwei.hu@bytedance.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qingwei Hu <qingwei.hu@bytedance.com>
Subject: [PATCH] RISC-V: KVM: Validate PMU counter info using available counters
Date: Tue, 27 Oct 2026 14:26:02 +0800
Message-Id: <20261027062602.323691-1-qingwei.hu@bytedance.com>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

COUNTER_GET_INFO validates the counter index using the pmc[] storage
capacity rather than the number of counters advertised by NUM_COUNTERS.
When fewer counters are available, a guest can query an index outside
the advertised range and receive success.

Validate the index using kvm_pmu_num_counters(), matching the counter
initialization and read paths.

Fixes: 8f0153ecd3bf ("RISC-V: KVM: Add skeleton support for perf")
Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index e095d1ff439f..ea788619091a 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -560,7 +560,7 @@ int kvm_riscv_vcpu_pmu_ctr_info(struct kvm_vcpu *vcpu, unsigned long cidx,
 {
 	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
 
-	if (cidx >= RISCV_KVM_MAX_COUNTERS || cidx == 1) {
+	if (cidx >= kvm_pmu_num_counters(kvpmu) || cidx == 1) {
 		retdata->err_val = SBI_ERR_INVALID_PARAM;
 		return 0;
 	}
-- 
2.39.5

