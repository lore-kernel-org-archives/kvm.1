Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413258;
	b=sr6xkIT+f1SsFUT0BzUn3RpBTvZqXn86N1ZjtNu1BJjvvdR4r2ebJ+EgJ+1y3zZzij8D
	 hzYFxfGNY36U5txdt30bOagGBN0jrf1RUEvPfcg36+l176MwliT1TXyNtkv+4GSOZK7fC
	 94vfA3Q/8heq3DMhs0WiVMehCiNUxx5zQfMz6E0vZe+h85sYBKu0iWLUpUm45HMS0uuwa
	 VVJvOPVyaIKUKxIjsytyL0j1TGiYJZPaH7KdI/TpfmLCKH7s3F/BvG6EKSwAN+c3Qab/4
	 1mk7GSaHJMfWljo9rJtV8ZmQqT4uO/MRLgy5dhzRe6J08AeBuyHVrIrSpsN88jc3D2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413258;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=u4tp7FuL+QA4IRSATROInmoClybc3SdOmQVxKbbZt40=;
	b=3vqKlLSJiqaTlw3mRg912EkgTurYhupjmHLQflKPdNb/iIKgraB+JifbbarykDeXrof0
	 MA3ZmgQ/CLnf6JEaqLonPEdU0j7C5EUMNsrsi7TeIQ315jwbvxGE6x/3QN/8YN6JrUxAc
	 KiNcRUqTtrAnm1b42412IICJDtNTrEF0StQueOkg/sv7T8b0S32HJplv2PuYD+4zxliQL
	 x5pWwX8G54JP5tPa5xRBXsN0QjH0Adk8tyVGJcrNftgBN2Ql8Xi7epTD0bLQShoK5kCEn
	 +sq4icISfHbFF0a9KlwooYLFkA7koDvJz1OTBc5dOb9nUMmxt4e0NGzG9fTvPlG4iyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=cYnS6lN9;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E9A606A326;
	Wed, 11 Nov 2026 16:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42E9A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=cYnS6lN9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=u4tp7FuL+QA4IRSATROInmoClybc3SdOmQVxKbbZt40=; b=cYnS6lN9WBfoMQuTryqsxjD6QE
	EcJC01nMpTgz0RV+a+mxE1CvOzMF3K8znZUkpXljwP0CN1ws5m4v51X0Jfvw4mSpPHDIVgYsjGJVz
	y/O3KHMaDv9AHv4mxDdQjCdK+JB0hoaEmsBCeKE781grp4dNi1J4NveC7REb7GjEXBIOnSbhPDah5
	1t/KSlHCwaJQuZkLP5i2DKvUYIhIFBg/cO+xirnIEQLuxmMFfuyXq0pFL85yWnUTyYe5Dn7rSyud8
	H55cZlGDbY+wPdQGg27u36vfku8IsN1ymf76EI1wmwZ+A7s1Gr3vmYJI6NJwQiK7KdyvGPZus1FI/
	b1KeN5bA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRAqr-00DIh0-2F;
	Wed, 11 Nov 2026 16:07:10 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 11 Nov 2026 08:06:21 -0800
Subject: [PATCH 6.18.y] x86/cpufeatures: Make X86_FEATURE leaf 17
 Linux-specific
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
Message-Id: <20261111-stabe_srso-v1-1-45512320ba5e@debian.org>
X-B4-Tracking: v=1; b=H4sIAIOS9GoC/x3MQQqDQAwF0KuEv3bEiKQ6VylFrBPbbLRMRCri3
 QXfAd4B12zqiHQg62Zuy4xIXBDG7zB/NFhCJNRVLczMwdfhrb1nX0LXjtNDmtQkERSEX9bJ/nf
 2hJTcljte53kBiRy1IWQAAAA=
X-Change-ID: 20261111-stabe_srso-98cf764d4d66
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, vlad.wing@gmail.com, 
 security@kernel.org, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5720; i=leitao@debian.org;
 h=from:subject:message-id; bh=6iOcje7eFMs0vxBJ4o4Q9M1sDODh+GkzIm8xDs6R1/c=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9JKpuahyr0nKqZkbUb/BXdkXBSn1KFodkj4IH
 6Lvk0Ify92JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavSSqQAKCRA1o5Of/Hh3
 bZzFEACwQrUzrPrIe29iG7u3BElBghxHGq9S16I3aXG522ICcMck9F9QecZ6VpXVHN9wq6bAqgW
 zhDdV3H90o5jQxvmw0PahVtY0F+/SzHxbhWiL0EucNovPNwHwSouS1BY+UseMRi6SjQwyKSalIJ
 RQy+V55mYfEc3RFfvXaIwz37Bd+6MDpvryTskIPqA9hYXcWOTQeu25nEvzgrJVKnuRdoYRYRGO3
 W1luUFah7FQRcpLg0uCeIougvL9WIF1CzCYodBzdY8dAIu2Y42KDmpr1lnzjmjwKuWbR3MFlGC9
 ghIzh7nWLAFGLnSfnHTLfQTiBgbl1cjZYcFKGMbTK6M6mDM/6/C3ZvaOfLpvyW6ccvjepXzCwOy
 YdC/XiVmWSdwGF0rSTazAcpJgikL9+EnOJ+6HBaZnlU0R28/1Dtukky2Tv3GYfnueQAiLK5Xz7i
 ZOOE3yJhBfTCjfiA1VL72zHEXo3uy6tR78mVwgEBPPAhMtSomv5F+LQ3ERnrdwgswcQyl+QWBvN
 roUc1mXFxmczeckmlJoD9+1oH2d+2FqPt0C0WD0j2c9hC/kO+dv7I4uZ0XGRMEbi8wkyJXfKUAf
 lCamAYlpBoP3asTlhVYS079BY4SZBdywWN1Kpa2Zm2r7Rjz3pvRdaTWZmHYjXGNq8tvwTD5WHkh
 bGEvWbWH6O00OvA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

From: "Borislav Petkov (AMD)" <bp@alien8.de>

commit ddde4abaa0ecc8395e0fcfa3e92f65d481890cc8 upstream.

That cpuinfo_x86.x86_capability[] element was supposed to mirror CPUID flags
from CPUID_0x80000007_EBX but that leaf has still to this day only three bits
defined in it. So move those bits to scattered.c and free the capability
element for synthetic flags.

No functional changes.

[ leitao: Required on 6.18.y: the 6.18.61 backport of ae1d2082d93b
  ("x86/bugs: Adapt SRSO mitigation to Zen6") put BTB_CTX_ISOLATION in
  word 17, which here still mirrors CPUID 0x80000007 EBX. The flag is
  then falsely set on Zen3-5, and Zen5 silently loses its guest->host
  SRSO mitigation. ]

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/include/asm/cpufeature.h        | 2 +-
 arch/x86/include/asm/cpufeatures.h       | 5 ++++-
 arch/x86/kernel/cpu/common.c             | 8 ++------
 arch/x86/kernel/cpu/scattered.c          | 3 +++
 arch/x86/kvm/reverse_cpuid.h             | 1 -
 tools/arch/x86/include/asm/cpufeatures.h | 5 ++++-
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 893cbca37fe99b..96acb669bed48b 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -30,7 +30,7 @@ enum cpuid_leafs
 	CPUID_6_EAX,
 	CPUID_8000_000A_EDX,
 	CPUID_7_ECX,
-	CPUID_8000_0007_EBX,
+	CPUID_LNX_6,
 	CPUID_7_EDX,
 	CPUID_8000_001F_EAX,
 	CPUID_8000_0021_EAX,
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index de7da218835e6b..7f909b771dbe84 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -407,9 +407,12 @@
 #define X86_FEATURE_ENQCMD		(16*32+29) /* "enqcmd" ENQCMD and ENQCMDS instructions */
 #define X86_FEATURE_SGX_LC		(16*32+30) /* "sgx_lc" Software Guard Extensions Launch Control */
 
-/* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
+/*
+ * Linux-defined word for use with scattered/synthetic bits.
+ */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* "overflow_recov" MCA overflow recovery support */
 #define X86_FEATURE_SUCCOR		(17*32+ 1) /* "succor" Uncorrectable error containment and recovery */
+
 #define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
 #define X86_FEATURE_BTB_CTX_ISOLATION	(17*32+ 4) /* AMD: Branch predictions contexts isolated */
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b0de3aabcd791d..3c2a748f684dbc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1025,12 +1025,8 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_8000_0001_EDX] = edx;
 	}
 
-	if (c->extended_cpuid_level >= 0x80000007) {
-		cpuid(0x80000007, &eax, &ebx, &ecx, &edx);
-
-		c->x86_capability[CPUID_8000_0007_EBX] = ebx;
-		c->x86_power = edx;
-	}
+	if (c->extended_cpuid_level >= 0x80000007)
+		c->x86_power = cpuid_edx(0x80000007);
 
 	if (c->extended_cpuid_level >= 0x80000008) {
 		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 083403886da225..2a1a1513054989 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -44,6 +44,9 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_SGX1,			CPUID_EAX,  0, 0x00000012, 0 },
 	{ X86_FEATURE_SGX2,			CPUID_EAX,  1, 0x00000012, 0 },
 	{ X86_FEATURE_SGX_EDECCSSA,		CPUID_EAX, 11, 0x00000012, 0 },
+	{ X86_FEATURE_OVERFLOW_RECOV,		CPUID_EBX,  0, 0x80000007, 0 },
+	{ X86_FEATURE_SUCCOR,			CPUID_EBX,  1, 0x80000007, 0 },
+	{ X86_FEATURE_SMCA,			CPUID_EBX,  3, 0x80000007, 0 },
 	{ X86_FEATURE_HW_PSTATE,		CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,			CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,		CPUID_EDX, 11, 0x80000007, 0 },
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index dcd8ed7c5ed4c7..8ff2a37016d6ce 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -79,7 +79,6 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_6_EAX]         = {         6, 0, CPUID_EAX},
 	[CPUID_8000_000A_EDX] = {0x8000000a, 0, CPUID_EDX},
 	[CPUID_7_ECX]         = {         7, 0, CPUID_ECX},
-	[CPUID_8000_0007_EBX] = {0x80000007, 0, CPUID_EBX},
 	[CPUID_7_EDX]         = {         7, 0, CPUID_EDX},
 	[CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX},
 	[CPUID_12_EAX]        = {0x00000012, 0, CPUID_EAX},
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 4091a776e37aae..80b68f4726e7bf 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -407,9 +407,12 @@
 #define X86_FEATURE_ENQCMD		(16*32+29) /* "enqcmd" ENQCMD and ENQCMDS instructions */
 #define X86_FEATURE_SGX_LC		(16*32+30) /* "sgx_lc" Software Guard Extensions Launch Control */
 
-/* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
+/*
+ * Linux-defined word for use with scattered/synthetic bits.
+ */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* "overflow_recov" MCA overflow recovery support */
 #define X86_FEATURE_SUCCOR		(17*32+ 1) /* "succor" Uncorrectable error containment and recovery */
+
 #define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */

---
base-commit: 1cdda838e8475edf89b73ff0cc952005dd0b1fa7
change-id: 20261111-stabe_srso-98cf764d4d66

Best regards,
--  
Breno Leitao <leitao@debian.org>

