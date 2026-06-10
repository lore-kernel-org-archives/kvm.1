Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0E11EB5CE
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781051445; cv=none; b=rNgnkHplLje99DUp+mTlGbSeVatWHNQ0Rw+3GdWJPECZU63y3DO2B6b4hqX1D1ZMz5ZpoD0zZOcDESLzW5wIAfJQxbrhWHy63epuc80fnZbuIhD7EFLww9vWfs97ZE60BfuYi6GkrhK0BitXyrWZOP6WSKxb4bYK22EY1JooiMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781051445; c=relaxed/simple;
	bh=JCtiZjmY4OkEjqJhiNZu5/8IUMYQ+m6GibjNsNyaBx8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WXt9hwMMohN8y3UFuiIJ8WOPeJ6A/Nv0qouhfROCzPxs0o05y6eDkzedREtSvQT64AV2TtJ4XiFSWhhQ0hKbdsybLfyuk1wrNejLfajI4/8e+hUXyYLcbxzBqHSHw96fKpUT8pPij3AVeLvrGTyXJ12b2frq20knk4VeQXnTb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lynT2rhE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lynT2rhE"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so86364365ad.0
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781051437; x=1781656237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=do2TUutmZnLPdNANAnUC8W/tz3zTrIIAME11eTVG70I=;
        b=lynT2rhEzZeiwbIWee44XVLVCp494xiIKTjfgS+PC4Q7vmd3aqrUpo1R79xbs3rZYY
         gNWyq+8HPbmmhGwPaRnhIuxvxckyyXT7kBZB5OswpJZxYWGmn90hBqHWH+SgLFuhp9Uo
         62bBD/VYAAeWPsNI7EHOVMqPlpAo8mkYFSM51dnX2XgjOWPvUw4prEArgGvgi6LKUeSJ
         GDTo52cfo/gtrylBB1cmt7CKs00vxNf4SAa9Fr8C3t9uUBuQDcMYnottJAltpYv9jAMg
         3fyAoojITaqnGwoehJgzPgyFElQDLo5a2ELeT9OK3t4QbsTAh/pPhF4ZHq6qdHSYXpDD
         2/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781051437; x=1781656237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=do2TUutmZnLPdNANAnUC8W/tz3zTrIIAME11eTVG70I=;
        b=nmfT7bIhy3kWAm2ECOCtrlgWegOPqEvu2HjwiIUeVyWkLsXwv1mE1Wo9LjofBIoL+v
         osTtsqVbg47SC/8HQhwkJAGw7Hbs8BjUpZd5YbvcwJsvHsDCxWkreY1UrC9+kELnE4ge
         a7C1yXkbsOt6UEvbQALoGgWUe/an6AW7rmgTWXmwTSMBWSRunD3KJW3PcsDs3JRn60r7
         f4gjXLj2e4tsDtFaGHkiMFo/0PpPZ+6VKlKJEWNQtlbKdUCPTJywZFgrzJYI3onqvo63
         DyLDfNydF23Ncc0janNNlbAFUoodQxjowBWJ4u7yUgXtWQurI2894CI1MjC7Nz5k0BK/
         novg==
X-Gm-Message-State: AOJu0Yx92g/vo371Lf32xyp941ks2diNSX59i4C3hKFiUkDiQRCO3SdM
	oF+JBG41GHn+DRpBw8DnSWtKDoA7HQOQmqFTL0LuSckdSL0otBjNaC2XD/g7n7NhO3Vnq4MFd13
	uQquBeQ==
X-Received: from plblq12.prod.google.com ([2002:a17:903:144c:b0:2bd:d6b8:a012])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f549:b0:2c0:b319:fb43
 with SMTP id d9443c01a7336-2c1e849530dmr258612775ad.21.1781051437078; Tue, 09
 Jun 2026 17:30:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:30:29 -0700
In-Reply-To: <20260610003030.2957261-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610003030.2957261-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610003030.2957261-5-seanjc@google.com>
Subject: [PATCH v8 4/5] KVM: selftests: Add a helper to query
 enable_mediated_pmu module param
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a utility to check whether or not the mediated PMU is enabled, pivoting
on Intel vs. AMD since the module param is defined by vendor code.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index e5a602c87273..7d3a27bc0d84 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1394,6 +1394,14 @@ static inline bool kvm_is_pmu_enabled(void)
 	return get_kvm_param_bool("enable_pmu");
 }
 
+static inline bool kvm_is_mediated_pmu_enabled(void)
+{
+	if (host_cpu_is_intel)
+		return get_kvm_intel_param_bool("enable_mediated_pmu");
+
+	return get_kvm_amd_param_bool("enable_mediated_pmu");
+}
+
 static inline bool kvm_is_forced_emulation_enabled(void)
 {
 	return !!get_kvm_param_integer("force_emulation_prefix");
-- 
2.54.0.1099.g489fc7bff1-goog

