Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA873D9DC1
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792324352; cv=none; b=bZmtRL4Ziru9pmxHAbH3xms36LGN2pvJiOLI1iJVjgCuGwR0jGJ861rKA0v8j1Gcqor4PyFs+CkMpfZbDAE9dXBg6ZSp1xZaqjgGu7CwXR+IYBcb44gndkxj1h7urK/GTcuEztjNq443wT27b+NDC/HOA4ZBfx0fJeYTU4JipUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792324352; c=relaxed/simple;
	bh=UTOFL3UMMmeEDwyhHDJphSf/jxDDcayvXDj6GTrHqFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UcAmMcyxZIF+4NwqjRmCyEjABsfK568wIqYakkbDCh+pWV3gTX+DRA7vbgss/ltuNRwfVeKagWacP3iZO5d8dE5dj4ZuR5zMW11lhFvi5wAmXm0UykXNHK2sXAVj7Zp3BRDT7eTj/D+0egVtg8AinGsJEeoRGazkYQwdVt9hKhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9SLCtaF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9SLCtaF"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso10499605e9.3
        for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 04:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792324349; x=1792929149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5fz0hjS0Cuz5EKajD02nVOvhLNMRne7PopgwKvfBOKM=;
        b=R9SLCtaFY6aax634Etv6BrvN8ovMlfaJuVtdGmN1gVsi/ADGWRFrdnVrfDXvGPA3A2
         f1wxz9vq0uCCSGzU2QBpCX7npgl+/vqSKCLYbhQdxlk0QjqpT6he9LSMy4M25rZvniIM
         wAoOrPhL9CF8W+k3VBbtxY/JAKHzAEKnWQTkvcAlQyNYd5lGPTA9T/kTjw7ihtd0L4XH
         EXLYKlt/9iA3GbkbF7JLrTpu26B2+enJMgQRtU95Yp2wCVAnOis3s0SQ6JtZk1GliI+N
         orNwBMILhkVH4YNNkda9leMM9UUS43ctcZxU5w+aAtp1vYZ/Y0syHcMRbkn7k6gTONqG
         WxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792324349; x=1792929149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5fz0hjS0Cuz5EKajD02nVOvhLNMRne7PopgwKvfBOKM=;
        b=nzzRRcOCT496rq5ejy3juocckAcFw0itvQeu4cjypHlJWI5ZYzgJWiD29TI8Dqm2lp
         9/dApVw2VEKE56VNbDoWCaJ7ogbiu8MrrRQKxlUgKRWI5ZTtK1wmgrYZZ29TiLGP8VCV
         NmWF9RWFgaQAEJ4D/UGCanIF5sPDJxPPDxfaS6Z1Tx3aMCxImK6GFmbC/1r+il6NmIZc
         Sx9Tsm75eq3/2QApyDL0y5IZ0sUaYBvUgZVm6hBR2+dkAdk0vqyIejisLEv01C6r9Hr1
         QKCsw3cC9YJqiypdzw63N/1sFYTivaJGxSEAygM8dYCrtVon9HCTceLS5abnPk3xsTjI
         UTrg==
X-Gm-Message-State: AFq9FYKmWHU/Gy+5ub9pmDsP6hOUlNelcLdrRmMrkkKKn6quBrB9+jGA
	qyZirFjZzaer8UXSmbValgNDoG+tdKDJZI97FZ6JltziMuiv8CMGjEBbUWIsxq8i2J8=
X-Gm-Gg: AYBFou3HThJUJoc6bwWs7hWJwyRQlBYGkrE+vw4VIjvxtOcANgr2CwtRuNIERsoLGxG
	O23q7vTTakLP4MWrWE7GQdV/1rcEiz+Pcl75U2dOeIQPEbnq6kaDELD4iqYcOWUhmN846O+r93D
	A6frZbAOExdNpKKIgjwlY2zCfP4ib2V3/YgYZgA+TlFX6sd8tZAsUM3zly7G1HDLoYVBOUPcrq2
	cSsUAl6eA8dUrSXRyWvHMzBAunXW/46n5oNAb5poJhvlSx8bhewM8LsnomZPev6HzbcPyzHQX9m
	bdAp3FWaIg2PclImr1n9P9sTZlVpAuLt3C8uPk6uNkQF+9TJrk1Rm3dI341mOSLm15vOAsGVOnD
	EUWzeQYd7gYfRuwC96ZzAUTIW5+RXSI7M8DkbdwBxfgTOTl52KyNb7Rnd9arg6O7e++c1VJ6eQ4
	sVwShXH/alIY9WRxQGdPphEvegQrSUpTgKk0ZxJb42k8DcR1fKXHvfhMzasl/ICjajhGjL9i/Sh
	gZ9Sfw66EKhWIyHv1XGruo/SrxElub5QCZifRZjH/kj/wEYzf4Wxq1lkx1CVEKWiEBvQWtmX+em
	D42J8T99YOCw0jfhp1lUlDJPNDVlfDC+GWQirKXqev+5vP1TyOd5q57B6FInhXRZeArj9zKTUV2
	uQl7FTjHVKoZHeKHnFdPH+fa3cZ3OhgJS2naAWmDd255OWpEfWR57+wG4AnI=
X-Received: by 2002:a05:600c:5250:b0:4a0:1c0e:b136 with SMTP id 5b1f17b1804b1-4a1d7616bfdmr98387255e9.29.1792324348909;
        Sun, 18 Oct 2026 04:52:28 -0700 (PDT)
Received: from DESKTOP-42GVE6E.localdomain (206.red-88-16-64.dynamicip.rima-tde.net. [88.16.64.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d3e2e602sm193311215e9.5.2026.10.18.04.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 04:52:28 -0700 (PDT)
From: Pablo Azuaje <pablo45154@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eugene Korenevsky <ekorenevsky@gmail.com>
Subject: [PATCH] KVM: x86: Clamp guest MAXPHYADDR to the architectural maximum
Date: Sun, 18 Oct 2026 13:52:22 +0200
Message-ID: <20261018115222.315090-1-pablo45154@gmail.com>
X-Mailer: git-send-email @GIT_VERSION@
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpuid_query_maxphyaddr() returns CPUID.0x80000008.EAX[7:0] as the
guest's physical-address width without any sanity check.  KVM computes
the reserved GPA bits from that value, e.g.
kvm_vcpu_reserved_gpa_bits_raw() is rsvd_bits(maxphyaddr, 63), and
rsvd_bits() returns 0 when the bit range is empty.  A VMM that
populates CPUID.0x80000008.EAX above 52 therefore makes KVM stop
treating the upper bits of guest PTEs as reserved: reserved-bit fault
checking on guest page table walks silently degenerates, and garbage
nCR3s/PDPTRs are accepted instead of faulting.

A MAXPHYADDR above 52 is architecturally impossible on x86-64; clamp
the queried value to 52 so that a buggy VMM configuration degrades to a
(very wide) but still meaningful physical-address width instead of
disabling KVM's reserved-bit accounting.

This is hardening rather than a security fix: the actor is the VMM,
which already owns the guest, so an over-wide MAXPHYADDR is not a
privilege boundary crossing.  The motivation is correctness, not
containment: a configuration value outside architectural limits should
not silently change how KVM validates guest page tables, and clamping
keeps the degenerate case well-defined instead of subtly disabling a
whole class of fault checks.  The unclamped read predates the
introduction of the cached value; no Fixes: tag is attached for that
reason.

Signed-off-by: Pablo Azuaje <pablo45154@gmail.com>
---
 arch/x86/kvm/cpuid.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 851f151efb35..f0166072968f 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -477,8 +477,18 @@ int cpuid_query_maxphyaddr(struct kvm_vcpu *vcpu)
 	if (!best || best->eax < 0x80000008)
 		goto not_found;
 	best = kvm_find_cpuid_entry(vcpu, 0x80000008);
-	if (best)
-		return best->eax & 0xff;
+	if (best) {
+		/*
+		 * Clamp MAXPHYADDR to the architectural maximum of 52 bits.
+		 * A larger value is a VMM bug: KVM derives the reserved GPA
+		 * bits from MAXPHYADDR, e.g. kvm_vcpu_reserved_gpa_bits_raw()
+		 * is rsvd_bits(maxphyaddr, 63), and rsvd_bits() returns 0
+		 * when the range is empty, i.e. an over-wide MAXPHYADDR
+		 * silently disables reserved-bit checks on guest page table
+		 * walks.
+		 */
+		return min_t(u32, best->eax & 0xff, 52);
+	}
 not_found:
 	return 36;
 }
-- 
2.53.0

