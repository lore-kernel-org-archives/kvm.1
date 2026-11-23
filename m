Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428460;
	b=Lj1c+pjmBnh7wmQFm7JIvQaw6KScYpQ2rhiHZJj6dZBcInIN20e8+Nyekf5PVEneYGR+
	 mdqO8lnGRKP8pe3Cldk4lpXwxZ19sEtLvvEwuafe8+5pA+GHsHbvaU0Ma9/b/qU0alQUU
	 ZCr/ORLgnWluGAHNR3au2tZOtD7tEa3TarKWNQ/F/qlh54sbHLvsVxJU9y5UHqD6ejdY3
	 3Is+iske4trVD0ZhXcBKFqTwGbMxnjpo5dncMdrVXh1ZbOCOixGJVygruHnaM9+0gWXeG
	 sl+iYJcIrTDEnY2up9zJr6j1QAI6tmk/oSXrj4UX+9V5fjlsJMfzbGQY6uUDMu7LiGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oswIDQIw5LddBDurs3uO2kKP08jbhDgi91nn5G7lxQo=;
	b=LWJUMRVCCkELpI3yriuTQaw4ymo0gB4q3dqrZJRfyJhZnnzye3dQJEjf+4R203WTO+6u
	 6PuGIeA5HFLwBuxsAHRbOjgMb65b8fd5IC8MFha9SwqEXcBttYM+0ONzKXFzvrlktdhLA
	 nomJ5tVadwAgqmIti87Vz+HbDH/wPVaTuV8lp00rE1g86adcSJblzHK+mzT7pLVyLdOAe
	 qyF3Lp/sl6nG6bNJfnIiwSsp7RNYPD+Flb37ofDYtzhCFosOm5zYFdjKPLMERE+eKV3Hl
	 1hJ/JmBk3uVf4tSq2iqkiJuyXPuf60RpP/bbeP26NM/I0gm7nzQ89n/HGTY9DtZqVpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z3nz1+yd;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B190606A31F
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 10:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B190606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z3nz1+yd
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-385d8a00598so4215257eec.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 02:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795428459; x=1796033259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oswIDQIw5LddBDurs3uO2kKP08jbhDgi91nn5G7lxQo=;
        b=z3nz1+ydzssLuojMa86t0bCUsF5pTBTdBhCoMsI06c4k7BgL++xywHGia6rmUBwduG
         jGsRyq+4uVjVFQxWTtHpRWAkCcLD5bMkzBb05FZUhbxXRxhVu/hg/dlaR402sqnrFxY6
         uYFdsdTfSjMCLFlM6gMtIFcdyUPMuT8ohBP94dkkF0EaeMjwLcARuKAtmbIPcb313wt3
         J0P/ORHRu6QQpmEkiUNLHol24tRbddAwa8TiwqsD+0mmmhV6qMOYb26FPjEbRCkk0yj8
         9S0FSR7PLTdkGWkNy8mPtcl8Fr8tnlRxGNQ5iGHrUV2oS79vWB3neZfMPiYMFsiLUkcV
         yvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795428459; x=1796033259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oswIDQIw5LddBDurs3uO2kKP08jbhDgi91nn5G7lxQo=;
        b=R1EYnHqTKAVKY1sSskVFTDaQjLi93DVPme/YvoJaZNEZL/BtRQlK+0IWbff4BOZZHa
         YQLv4fjIuBVRrOc0DyGfFHqFNay6L3VGyETRwVyDS7zTK+9+dfWeZTiTxlThYdtCF7bH
         O8p51Ifcgc3puvydiNJL15mKgBooqaD7NpAy5LI7mVKa6uhCn5MrtgxGejnCLm5HST7o
         DfIW0OY2vWAdx7AIZWRHbGew4afcUiKOkyNh7oSbkQdrwJxHXB+UHyQtaSiq6yNoD4cd
         s5nvDbXWzxVhfFaC7+MG9OQhQXN/97pnmVQE4plwKCdih49DzGTLjyhAIziUtPtOvQ91
         8exw==
X-Forwarded-Encrypted: i=1; AL+hErHP3bXkRjloYdW78Yjm2l8EZuBWHSAkYBK60O3Sot4wdIqUMBhnzs2VN2E5uQ8Eb97ZS6s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XDCKHg5n+SU7Chn/+YGhgP6kIGPrbgojIsBVj89EjG4YLf4BX
	OoBoGgGnWrBjxSRq/F5YJebEs1PWNhpHHvIYc4Y5LW4OANutBKD5dmlL
X-Gm-Gg: AZFdTZeb9wxpFqQ05FTqZC8f5bzycz7vQg7du1ae3vIY4z2rlzLl3G9zTNTkKCm2sFy
	bjSS+xpPpfaTr5YaOoNz0B131Fpisbm9JfU5qo3s+YfEbxOZEMDBReKfC0s7gRCJ2WXxcvg75f0
	/BSdmKCZpmoM+wzp1nmGxae2gVuYpSVW4H9emSVIhCAyEKQbwz2Wq2BhveU+DEue0M32VAl/w1U
	azfl0GTK/pLhxrEVoKdvrW7UL9HfGW+jGAFDyli8zZuEZgmOzeGXSnWy+iENrB/mZtM+IFL1rQD
	kfDqw/OgLVqNOcIpy0A04Kfcv3gFvTi9/sd2F8WaJMVcekRtjzqtcI2aRXFd4FFOyl24TFwL2t9
	S649jVYloE+dD5ANqGt2Cg4S+0DJcycm7qn6gKcmy361X+hCh/qppTupI/NaB+A4XedD0jVVeuE
	yz23x/Kv9WideTbM+adO4npp86mSGuzQoJvA2Q0IUI9zV3DVLQo7YU10wH00IFtj/3Ke5Q5OB2J
	R1Jbp6TNmojzL891ukMbNWngOR8m47eFTDNVM1gP7rQdUP4JPcmuJVXdKrIHoWNgOJ4O+zOi7e2
	IG6d65gHYZ7v81Gae/zB7+yJqmiLGmsIpV9Ds/LhWA==
X-Received: by 2002:a05:693c:8843:b0:386:b429:fe0 with SMTP id 5a478bee46e88-386b429175cmr1773472eec.16.1795428459292;
        Mon, 23 Nov 2026 02:07:39 -0800 (PST)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7fc3sm30929402eec.8.2026.11.23.02.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:07:38 -0800 (PST)
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
Subject: [PATCH 2/2] KVM: LoongArch: selftests: Free the VM when the PMU test skips
Date: Mon, 23 Nov 2026 15:37:01 +0530
Message-ID: <20261123100701.1679376-3-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123100701.1679376-1-gokul02k@gmail.com>
References: <20261123100701.1679376-1-gokul02k@gmail.com>
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


