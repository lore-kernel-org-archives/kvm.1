Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287D63DD86C;
	Wed,  8 Jul 2026 06:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492510; cv=none; b=mRuRvzUb6mSZ0etr/ag3FpmHopaeHDhN24Lq81kSFnwVPdCI1QX//03nnDgLx3cZ2vxjKf3zw4H5IX01p7UqEoqNJQntqJk7gI5b2EH4sc6r7TDDhhiUST/6Y1V8EfeFgl27xc5ojc0ehmHhBGH3/2pgdBsV6w/U2/FW2v1KbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492510; c=relaxed/simple;
	bh=mB/1W/u4NO53+Zcz/hctCtLvsyEn7/xhgpOGGPDJpoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhiDRdAHdJQa7T5mytdGN/n5kXEvQ8p45yyspKKEwkHjSboltikpuW/pdFwbwedB4BACyR8lSHnrMSmJbCM/QxbVfGC8pZUwWnTlcJLinRlw9MK1y32KUdiJGzUWy1uusm9jm10UoXiVZJVSZEM0cG1/7+zXozmXVpN+HM14XLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nrs3oeaw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nrs3oeaw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A06E1F00A3A;
	Wed,  8 Jul 2026 06:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492508;
	bh=+T6wo1l/Dmv0TXGiHBOcGNV46hTOklIJZxpq7bdhS9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nrs3oeawEgb88Ttp6hwvOKvAgsAi/RW53h1HlkqkKRiuoM8azlYBGKQL5Aqu0SpdU
	 O40LNJyR6MdZwneeMhFhf6eggWKCnzaz11kS93RuMMITzOCyG/TskHxQWgwWI1U/Lb
	 1VT00ZvTO7HQvcB6exek4tCFvxAyeVGps7o9nEvgD/9LXHoH/67O7stUsFEv1002YO
	 a/CcH109XuGzC7xth28WUfWnhcMTPiIbX5YyMucXYMEp2L75JRJ2iBL4BJo7uMJdkw
	 6ezsD6Bmg2KXp/MzVRSuL7ZqJoVs0tquJ8OB275S97E35uPx4E/7F3MAXBi4wJ79H7
	 3PJxaQFf2707Q==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>
Cc: <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH v3 05/27] x86/cpufeatures: Add Secure AVIC CPU feature
Date: Wed,  8 Jul 2026 12:02:03 +0530
Message-ID: <0aa478fcd5cdf5f6835b1ff943d9655fdc8822a9.1783490022.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783490022.git.naveen@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

Add CPU feature detection for Secure AVIC. The Secure AVIC feature
provides hardware acceleration for performance sensitive APIC accesses
and support for managing guest-owned APIC state for the SEV-SNP guests.

Co-developed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 35a2a0f9ab32..d538db618f24 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -457,6 +457,7 @@
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" SEV-ES full debug state swap support */
 #define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
 #define X86_FEATURE_SEGMENTED_RMP	(19*32+23) /* Segmented RMP support */
+#define X86_FEATURE_SNP_SECURE_AVIC	(19*32+26) /* SEV-SNP Secure AVIC */
 #define X86_FEATURE_ALLOWED_SEV_FEATURES (19*32+27) /* Allowed SEV Features */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 #define X86_FEATURE_HV_INUSE_WR_ALLOWED	(19*32+30) /* Allow Write to in-use hypervisor-owned pages */
-- 
2.54.0

