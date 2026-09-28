Received: from mta0.migadu.com (out-50.mta0.migadu.com [91.218.175.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416DA4EF151
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609183; cv=none; b=AisuMK4gPrvCtIS0WVyYrBDBUEM0Rg1KeHFWEmMuMByXzUYi91kSCKxE4AtGYDknHpE85rDj7TjOKSf6rl1DmJd9cnm5bqBq5Jd5XBypi77rSd/bG1zKG3s2w52t+JZeWquZxjQBRr0Jju/VsF7jVm7T0BQAcRuCjxtaok5kyTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609183; c=relaxed/simple;
	bh=gCZ4+xDzVSAKXpVOsX9KJAGTjtUx6xvPoFZNvNTGzOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NFyr9Zvv22ijPnbT2eyCrgJkjFsJNLzwmdeQf+v9jnq+daIFnpJDLi0GbkUzJDpDp0Gz1FMhcvDwL9XhAde7FG1GKEC3apGLIoFQq4A55QkreWWJJvPY+jSegQ6N9A4BSCBVTXWQFXmIszx+2DygXXks8a617+Z4bOy8pOH9zMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AT9jcM7Q; arc=none smtp.client-ip=91.218.175.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AT9jcM7Q"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gCZ4+xDzVSAKXpVOsX9KJAGTjtUx6xvPoFZNvNTGzOQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790609178; v=1; x=1791213978;
 b=AT9jcM7Qb7MVac0xNbLN2XpMVJzWexGkjlsRZBfPM4eZ9YjBEOmOjPuFeyEFfvDvaSiTCQ0V
 pB/heBaslEVTk+8x2ASGL4xQ6gsNjOmniWZl1dNa6z93fBb4C+XM559RmHGQrKdfWXKiAMkCzev
 soUuKHZE2vX0fTuntJ42Bh9Y=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 741b53cb36a0a279;
	Mon, 28 Sep 2026 15:26:18 +0000
X-Mizu-Trace-ID: 741b53cb36a0a279
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jing Zhang <jingzhangos@google.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/10] KVM: arm64: selftests: Free the thread arrays in vgic_lpi_stress
Date: Mon, 28 Sep 2026 16:25:07 +0100
Message-Id: <20260928152507.2116110-11-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260928152507.2116110-1-fuad.tabba@linux.dev>
References: <20260928152507.2116110-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

run_test() allocates the vCPU and LPI thread arrays and never frees
them, while destroy_vm() frees the rest of the test's allocations. Free
them once the threads have been joined.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c b/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
index 9a69c439a0f8f..d09db95db3bd5 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
@@ -330,6 +330,9 @@ static void run_test(void)
 		kvm_pthread_join(vcpu_threads[i], NULL);
 
 	report_stats(delta);
+
+	free(lpi_threads);
+	free(vcpu_threads);
 }
 
 static void setup_vm(void)
-- 
2.39.5

