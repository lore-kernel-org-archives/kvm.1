Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20283AE199
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095700; cv=none; b=AekLNUMW6CvoEx2bzVqJLDF5SqmGpTW0F3WjC3X9B22LvqG2d92lK+b3jb9CwShkcSX7FcbBn16sBRC9LXgZOgm9DMgK36WfJ+ha0Sk/2LUFc+Zg/e1iNVhF/8BN6a4LovDOmt0bmJsTXLoLU9zF2aLyx4T/MVUOp0V6D/NOcCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095700; c=relaxed/simple;
	bh=cbadhVdGENuf2REpDYOzhf+HgyWklEFQdkhkdFB9nVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9tQPNkaYiL2QrHigTLIStXWfHym0isMoCZkmrzRV2ejgT4kGhjizh+2HLByy73A4fNgmH7bfTQOCvdHk/TyBDAV7Sg6z7oeifGcWJJ2CzStUwUvOIpkfl3/YQD2IXLhDY3qgny3IH2rNDyxvHS5nCwvGA1oc72PYU9+AA7ftEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzddjn7f; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzddjn7f"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so3609147a91.2
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095699; x=1781700499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8+a22vFLAJgAuwgI2KpSatIpPOW4GGFBsrZIpdJO1g=;
        b=nzddjn7fnzgAy2zMqv2xwOTbQHkmVv+jas0/xgOGmHQKBRJy86xcyzyuwxJb507yvf
         Y+SoNDT8z64eqW6KyPRKcEIN6XtFa9RwqcESWJqh+PbQDI6aXsOZTY/gA/8MNq4cM35j
         BmRNsNbP1zzOtVuhnYJcEpHf11AOn8WWYH9NIC4rIJvdWxAcf8ohneXEWRAJUZidDuiT
         9RISX+Ce7ubvG7onr/6k3GDRuz0Et+yf/1UVPa7EemBmD6H6KaSoHbfwYZ+TCDTLI8Xd
         fw1OtJpWdjmKgrBn0L4ZEUFDNh752rCADqIUxly5b3d2Lpa0LgvgSR67ef5bVXMzgRMS
         HRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095699; x=1781700499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o8+a22vFLAJgAuwgI2KpSatIpPOW4GGFBsrZIpdJO1g=;
        b=NdBCAbeDxtzfDWzJoG1om5l/lDAkk7haQaKs9QNGYVk+8kMEaabtG0q81OLtFYjdNN
         koP5uDNZcQgT7VRxmxcLrRiuiXB/RzfrbeB8Mr5IVGVu9C36eHZl/uwNJKcg6sUNkp+1
         RvaLkgc6EmEzwC3tMfj5Lf44qy0whQRhSm+acSZgcIc+JElU4YDvM8j/di+1BcWwn91f
         nRmxNyKothfSnuIcVIuuWF7czeDOR/nz4rNQj/q7MRsMO15HER8bjpAz3ZDgq55Gn7dy
         dUUag6YcESLFl6rLNAtJLLcWVz7UDt+WRA8Ma9RS9DqpJEHZIrNkInOqaLM9k5QuPmQH
         jiig==
X-Gm-Message-State: AOJu0Yzf53AxzfqQAgtvuU1ORFLC/HYfnJAcb0wlX4ZYdDIe6kmJU4Uq
	j3kA1G1NBqCiE+y3LJEwVGey2AAZ7Byv0/ETab9Ps2Gvaq8IqeUq0bL3xxNqHg==
X-Gm-Gg: Acq92OF3ADv8BL81WbDgUGOMo3D42T34YPYcr/aMmu9b/gDDwA3iP7pMGhyS9XZwBzz
	Q8YAA79MHfN6gidtcEv8tqmuQfmNxFhw+iVi7cB6KA0ozi1qxIMx2tRr07GI0b29USlwRgm7NVp
	RG2KNAn4/9QDHae/Hkt2QdeFXUTQM3K22CyEEEjP5sneniFpYJCbxiRROumyo5O39N0orTlO6yC
	+oiK32BQt7aMOk/5WknZhT8KfKjaYgRVlUhsoPiYxKXvpIMGRozKcSmcLQ6mfCsyo67C0u/xJZ6
	eWb4oUNc4zMGULoB6tr218ylf+3pP2Hnkq/3e7oa87Zz2bcbIFwY+jrQPybI++6z/RdP1BBBRht
	K5bCoTtWklFP9d7j1Ou/+rD3VQIEBmW2LClC8+gdjYPJErllVCVBYMHVRiDqe2HMqOxDfcCIKKv
	iVHxcE/TNY/zQrcclCnqovMGVuumAG3nRNEMwi6AqgWl/gid3DIWPA+xPSyerWG5AofSPx0wOI
X-Received: by 2002:a17:90b:5747:b0:36b:9798:4f67 with SMTP id 98e67ed59e1d1-370eee03facmr24853662a91.8.1781095699281;
        Wed, 10 Jun 2026 05:48:19 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.48.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:48:18 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 07/10] KVM: PPC: selftests: Use s64 instead of int64_t
Date: Wed, 10 Jun 2026 18:17:23 +0530
Message-ID: <851c5eaf017e29795adc5681ea568a78182cc0ac.1781093720.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1781093720.git.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 286e8903aed14 ("KVM: selftests: Use s64 instead of int64_t")
made this change from int64_t -> s64 for all other kvm selftests.

Do the same for powerpc as well. No functional changes expected.
It uses the same method describes in above commit.

  git ls-files tools/testing/selftests/kvm | xargs sed -i 's/int64_t/s64/g'

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/powerpc/hcall.h | 6 +++---
 tools/testing/selftests/kvm/lib/powerpc/hcall.c     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/powerpc/hcall.h b/tools/testing/selftests/kvm/include/powerpc/hcall.h
index f923b3f5e233..21b2bf9180f1 100644
--- a/tools/testing/selftests/kvm/include/powerpc/hcall.h
+++ b/tools/testing/selftests/kvm/include/powerpc/hcall.h
@@ -10,8 +10,8 @@
 /* Ucalls use unimplemented PAPR hcall 0 which exits KVM */
 #define H_UCALL	0
 
-int64_t hcall0(u64 token);
-int64_t hcall1(u64 token, u64 arg1);
-int64_t hcall2(u64 token, u64 arg1, u64 arg2);
+s64 hcall0(u64 token);
+s64 hcall1(u64 token, u64 arg1);
+s64 hcall2(u64 token, u64 arg1, u64 arg2);
 
 #endif
diff --git a/tools/testing/selftests/kvm/lib/powerpc/hcall.c b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
index cd10022572a5..d5f5282654ee 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/hcall.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
@@ -5,7 +5,7 @@
 #include "kvm_util.h"
 #include "hcall.h"
 
-int64_t hcall0(u64 token)
+s64 hcall0(u64 token)
 {
 	register uintptr_t r3 asm ("r3") = token;
 
@@ -17,7 +17,7 @@ int64_t hcall0(u64 token)
 	return r3;
 }
 
-int64_t hcall1(u64 token, u64 arg1)
+s64 hcall1(u64 token, u64 arg1)
 {
 	register uintptr_t r3 asm ("r3") = token;
 	register uintptr_t r4 asm ("r4") = arg1;
@@ -30,7 +30,7 @@ int64_t hcall1(u64 token, u64 arg1)
 	return r3;
 }
 
-int64_t hcall2(u64 token, u64 arg1, u64 arg2)
+s64 hcall2(u64 token, u64 arg1, u64 arg2)
 {
 	register uintptr_t r3 asm ("r3") = token;
 	register uintptr_t r4 asm ("r4") = arg1;
-- 
2.50.1 (Apple Git-155)

