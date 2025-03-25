Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44C9266B51
	for <kvm@vger.kernel.org>; Tue, 25 Mar 2025 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938808; cv=none; b=WP5yYMHf/JceP5hQ2SsnHDgb3mcjBPHkVGNZxsP1Ge6xZlWkcZT4PKf7Hhiq5YNG2yHg1PBfLE7C2UDFCpzboMxbAjBmNvWMXChuqUNZENd6983+K+RGLRiER5jmcORVCtC4rHRa7g++/z7NHX9ayMFt1+FWSMxY0Keg5Y30DPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938808; c=relaxed/simple;
	bh=ptYRt89sgou4FpaEtUAOMprqib9DDbfe6Q/dbNifWHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oMWMVCE1DAd6rsqsrAOPg6HjDIIBsQImVa5serknrUhL0DgnwY1O3ya07PCeX7ZNJ85PpuE3o6BgJfVTmgqIXkvuf3AdHUTQCcNJ0xr2sRmGhHVV0f1sAU4ReqDEQXVodlqxbNnjlc2hugHMhB7Zq8KMnlWCxXXWRzYE/J++FEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EprJpRog; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EprJpRog"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742938805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOvg56wudx30L0mZ1KHo5OKQo6JZQ2J4gWt09byKS9Y=;
	b=EprJpRogyPfdiRVOZrInUodVdDdN+OCvMPf+aa5HBLPlSUpG75jh+71kQCs+e8UjDJcSO1
	mQwYnQ2DLDiGKTyW8rL9Qf94FKElGe+2nG+XQEYdUwDttWDHv+IMaK3p8kXx8DVvuBWuOR
	aoUE20HKYB+alrmiDT1Q/CG7mgtonFc=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: kvm@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH kvmtool 7/9] arm64: Move asm headers
Date: Tue, 25 Mar 2025 14:39:37 -0700
Message-Id: <20250325213939.2414498-8-oliver.upton@linux.dev>
In-Reply-To: <20250325213939.2414498-1-oliver.upton@linux.dev>
References: <20250325213939.2414498-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 Makefile                                    | 1 -
 arm/{aarch64 => }/include/asm/image.h       | 0
 arm/{aarch64 => }/include/asm/kernel.h      | 0
 arm/{aarch64 => }/include/asm/kvm.h         | 0
 arm/{aarch64 => }/include/asm/pmu.h         | 0
 arm/{aarch64 => }/include/asm/sve_context.h | 0
 6 files changed, 1 deletion(-)
 rename arm/{aarch64 => }/include/asm/image.h (100%)
 rename arm/{aarch64 => }/include/asm/kernel.h (100%)
 rename arm/{aarch64 => }/include/asm/kvm.h (100%)
 rename arm/{aarch64 => }/include/asm/pmu.h (100%)
 rename arm/{aarch64 => }/include/asm/sve_context.h (100%)

diff --git a/Makefile b/Makefile
index 25ee9b0..3085609 100644
--- a/Makefile
+++ b/Makefile
@@ -182,7 +182,6 @@ ifeq ($(ARCH), arm64)
 	OBJS		+= arm/pvtime.o
 	OBJS		+= arm/pmu.o
 	ARCH_INCLUDE	:= arm/include
-	ARCH_INCLUDE	+= -Iarm/aarch64/include
 
 	ARCH_WANT_LIBFDT := y
 	ARCH_HAS_FLASH_MEM := y
diff --git a/arm/aarch64/include/asm/image.h b/arm/include/asm/image.h
similarity index 100%
rename from arm/aarch64/include/asm/image.h
rename to arm/include/asm/image.h
diff --git a/arm/aarch64/include/asm/kernel.h b/arm/include/asm/kernel.h
similarity index 100%
rename from arm/aarch64/include/asm/kernel.h
rename to arm/include/asm/kernel.h
diff --git a/arm/aarch64/include/asm/kvm.h b/arm/include/asm/kvm.h
similarity index 100%
rename from arm/aarch64/include/asm/kvm.h
rename to arm/include/asm/kvm.h
diff --git a/arm/aarch64/include/asm/pmu.h b/arm/include/asm/pmu.h
similarity index 100%
rename from arm/aarch64/include/asm/pmu.h
rename to arm/include/asm/pmu.h
diff --git a/arm/aarch64/include/asm/sve_context.h b/arm/include/asm/sve_context.h
similarity index 100%
rename from arm/aarch64/include/asm/sve_context.h
rename to arm/include/asm/sve_context.h
-- 
2.39.5

