Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669488;
	b=1eYD6I5wuXGMyhwtjAZ8CEt0oQIjHuG2EyAmRePh2TI17uhCiM0+LzlTZqOnh6HkPkus
	 4evNdHgrAmXvo54Iai3Sjl/hZzxqXKbfHzN2d3XSiSpZSmlIOA45xhHrqmXnrapjdEniV
	 MxpuutrZcTXTC4wEXlh4fsR/2xx8BQq53jV6e5Oo/PEI3Gs8n0e8XPVKcDnGeUVFvMNlk
	 NyzuqQh8xYT60QfpAvBW5+rXaXEYFgzqdlv2ZkQSyngU8w5NbqRMWv9sTe/X6weReLJzM
	 nYtf4u/RYe5sspSTprYRjvf+VaIAMyvZOby7Y5HlXNohMhcVZylLCnY7kvmbujj5mqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oswIDQIw5LddBDurs3uO2kKP08jbhDgi91nn5G7lxQo=;
	b=V3Qtr286lA29iaXfJ6nR3aoGq9/Y0ONysTP//Yi/dhl/bOAxj4+c4qM9WgHrrYlIo9Tz
	 KAk5r08qs5LGav9r4MGpT1qPfki8VLyOwoOSGsKTDfKCEZmXiTvj/O2hhi/6719NcD53Y
	 WCV1MZFGHI8pZF2Yshg4LpaMrwXoeUI5IMHA+bW3Ril9Y7o0VVbodyk5xaPrq21hGc5KX
	 8XqKDxGbMp9pjX7wq9Yt5k5vRQjFDQbnFAcD5wqWRm2YfWKo5iZWkfMx+ZkPl+9sDteQE
	 auHZ7hQ5gluIQu0oQ5dZZRJxaq6fXRl4C7oqIkz4L7j13vp/32nMIhjvgSlDQemFnNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x4TuT61Q;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1354606A31C
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 05:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1354606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x4TuT61Q
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso14036303eec.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 21:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795669487; x=1796274287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oswIDQIw5LddBDurs3uO2kKP08jbhDgi91nn5G7lxQo=;
        b=x4TuT61QEHzqtYh0juAuI4XvTMOyWJhGDXnal7jHIqLPCRaKduCYPALjsc7k4AGTDj
         +bBtaKbjdNLKt9pjOrWAE33W1zBx+1Io1nWiG4CR41OPvrMc3O15WtVPgu0kz+rbGH1Y
         IiguUrO2Mzm7UYQOZnsgL1A6PhM4pw4nWZs4O9m+fv7I71r+4P07VCCDUfQsQQl/LQJ9
         M601R4WfPJQmO2x5klfU4R+KNE2NHteRXVtFOi0fsEqK6mJ0II/d4NYC6xPrys1YYJS5
         VaPaMxlcxCfw3M62wFEk18593CSxtbjtSNHXIKSuyT4qWqDe5GVYcQf5C8Tp2JjcXKry
         MTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795669487; x=1796274287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oswIDQIw5LddBDurs3uO2kKP08jbhDgi91nn5G7lxQo=;
        b=qIvszB/enplQm4fIFxCftpbSsrp5jLHvysxxdTT4C395QebiWdEzFAkL5XB/p1J/1X
         PRAy90B3A2r5tkty9pPYrNQHQSruGIQpBeP2Y9KkY2oNH/tFnaCdfgNU8qbFkwZuIkuC
         XTYR2yrUzwjWTXBuWcgQmW345EPP9RV+pD0Kf27dbEzHvS92EnbBf7zpd6BFKPxEqdxf
         6HdK6r5e+yaOH79K4HNkixyjVAIilXk11puDf4tFm3OFUtFn5J9+Bex77yaw0ejl/CHm
         opls8xvueInaIyMwD3Vpc9bB2Il9i8/8hNUVSv6yZS7KVNrB82LNGZ+C1AEDB4W7I7KL
         zjOw==
X-Forwarded-Encrypted: i=1; AL+hErECMyS84VTRJpAYGs7Ah2gdYCIN/zIx/gBBYNhZ/7T4L6mQZchP9jZMgwHAx46ODh0A8so=@vger.kernel.org
X-Gm-Message-State: APuU4Z88aUh59D0BKDmnPkfnmAsDEo8L+/Go5MeJxpWAM8AvgIZNPmLC
	zCzPKgZNycZboBOLU/ETV4DQekN8dqdaK/pJOrret5AYLOFcJjKY/uHa
X-Gm-Gg: AZFdTZf7EydflyYAGziLqO6mA/lGcsB4Wgq1vV2EbKZ34qsCkVlzc9hYDYbVMGGuaPT
	CmhfWoQ5l1pxBfmzexmzsiN6mGHY3lTIvQ0WOBnvR8c574rXEmuHVRBk1emHTnAVe6cKPb3F0WU
	AugJm7r70CjGx5mcfJhFu9ivU3wT747LrmJ8lYE3WTzlUNewwik4tUodmK+jLsl/MYTuBI95kbH
	A5lZCcGh6s30FjvUPLZwz8HTlXmcaN/EiWhUEzoTGj451bxUswxyCWs3INyyuS+Fji88C7x+f4b
	N2qd4ihc23aw+OBn8RCZGEXEvQhPFHAju94/uzC+AnR9cLxVM4Lo7rHJSOP42NNDQ6LEonzYf4t
	HDDwj5zYuZyxw0jbQ9I+VMhy8tilalGP9RNsaPmOcagx2WiYQ8GptczmIZFIpj06ar2RMj5vvCd
	Zgi+yvUotAwhxHfgAh+xJg5BgFMqJ5Ikk90Y/QF8KPT9dZry2NUE2pHMz8svDEKTc4f04AuMkG/
	EzzwZNxmbz1U27Sr4cqJZfJNNBtmbUImgFf8jRk3RtRXoR6XqGmahZorEKXSvvt6vketFC1G9hK
	hITlRXWXV+WmycD8guqAA3d5NoWW76HzXDOBsmQkMQ==
X-Received: by 2002:a05:693c:60d4:b0:360:5f7e:2eb9 with SMTP id 5a478bee46e88-3857111f65amr22517783eec.32.1795669487141;
        Wed, 25 Nov 2026 21:04:47 -0800 (PST)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm17154865eec.17.2026.11.25.21.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:04:46 -0800 (PST)
From: Gokul K <gokul02k@gmail.com>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Song Gao <gaosong@loongson.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] KVM: LoongArch: selftests: Free the VM when the PMU test skips
Date: Thu, 26 Nov 2026 10:33:52 +0530
Message-ID: <20261126050352.1957454-3-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126050352.1957454-1-gokul02k@gmail.com>
References: <20261126050352.1957454-1-gokul02k@gmail.com>
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

main() creates the VM before asking whether it has the PMU feature, and
when it does not, returns KSFT_SKIP directly. That skips the done: label
through which every other exit frees the VM. Set ret and jump there
instead.

Fixes: 11c840192768 ("KVM: LoongArch: selftests: Add basic PMU event counting test")
Signed-off-by: Gokul K <gokul02k@gmail.com>
---
 tools/testing/selftests/kvm/loongarch/pmu_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/loongarch/pmu_test.c b/tools/testing/selftests/kvm/loongarch/pmu_test.c
index ec3fefb9ea97..c9dd3cf5de06 100644
--- a/tools/testing/selftests/kvm/loongarch/pmu_test.c
+++ b/tools/testing/selftests/kvm/loongarch/pmu_test.c
@@ -176,7 +176,8 @@ int main(int argc, char *argv[])
 		pr_info("PMU is enabled in VM\n");
 	} else {
 		print_skip("PMU not enabled by VM config\n");
-		return KSFT_SKIP;
+		ret = KSFT_SKIP;
+		goto done;
 	}
 
 	while (1) {
-- 
2.54.0


