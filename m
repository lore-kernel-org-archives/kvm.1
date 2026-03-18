Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36F368940
	for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860533; cv=none; b=uJYmSDo8wg9FKsbw3elqvllPO9ZZj5R/ym3f1GiCSw3UAwbwHmtPjMNc1ru4kDVZ+2gLtcrUiPYi+sKZEEBGyN9FB0m5Gp7RB5qafzm4I6Je3UCQPc9WJyYPDv13Y7vO7IsGxa9uFRx2yaCj99tBoWDo6Y9RA7JjxGiCv1LESbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860533; c=relaxed/simple;
	bh=z+2sf/5km6HTWQdHuHjaRmn83kq0xn9ypsPl2UqNUbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uvqsGOxQSWvsxHKvn4iwEt5LIun+fhqLdRf2jZdBje3IqPihRvmKxRwAeCDHf8f/WfLZiwnrJnqPD9TKU1bJfaR3KPgq9tsUb/OfF3g842caukYUw2HB1LmMwBmQe9VEl2QD6DXNdr8SM0DThiM8NqPIVCKRwR+HXhggqSMYVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gIPaBGBj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gIPaBGBj"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so1798375e9.0
        for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 12:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773860531; x=1774465331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4pIf+VLPRohGstCaliNQzf45fwV/wxcML8JuOKn3Xfg=;
        b=gIPaBGBjiuOmg8wjnpikbLqaU9OSDaMr9/0YUGjUIBjMuKSeu4Znzx03u9EVBRxTgx
         bP45HH7H9/FC8ZkYDVoO+jKggPig2G2BP4+uJ3IMKOFLo7sryMk1LAS310ZxokWn/l57
         p3MlmhO+OqYTvFqy0vXTcvW1aIjpzvsM+zeTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773860531; x=1774465331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pIf+VLPRohGstCaliNQzf45fwV/wxcML8JuOKn3Xfg=;
        b=GWrQucNjtaL8CGJv4KNFqK0capDHsjH9YwUXNsoQ6G4QuP86SU5c8HzQnvR40Fd6RB
         nUI7OgQ6ykWea39rRYSErqFMAEBFklC1GBJfuJuH003QXrFZCeZT/1sKGHmUq9HyG63r
         TGvfKzEMVexzNKaeYbSDQ9xiOQLOPknLuKgF2Upi1H5n7noubuGX1QPCKAGcfQeWjcdM
         kqmk9QM5gEY0MsQAodOiTVnZLUTV/tiVR9Mdu9AzYujPzf7UdFInBmuNalo8LHrrdWiA
         PblbnLu5Cnmt3+F73CfrUZIaUTqLzKMd91EYNzUObGOoM41VIqTpq+TSPXDL7CDQhj8i
         HGMQ==
X-Gm-Message-State: AOJu0Yxt8EkI9UA+SPi4nAfUx1e853zG2luI2xuXhxFs1Xb7cfnDI7Wr
	q4FoTQVJ7m7k9V6fZasT/25lCYvW+9vBwqI7Z+bNd1bYBuZTHITrBQZdzemEvBDdAkyhoUvcVVB
	/K8c=
X-Gm-Gg: ATEYQzz1hTheW1kvGLIjTy88tELr6YhTIqEBpl6VeYGKesMUJyT/4pYAtTXP/kCZyqa
	CpgD9qTUJKP5Xp7+lAG3zWlL+QS0FHdE/iEuuMAYNogkBGaZjhukGte7IdTx2TcXT17jAWQMVQd
	1vzL4/XRbN63ATxmCsfP0m86Icfr10In/v/JpBeXwSSSGKkpg4u3SLPTaYoYhOjA0XXvKpNwUQl
	mGLhidFIdMnJ6KE7EPtf7VUoAs2VSy21vejeaq7ODUT4C+hYMN+7espoNaqfO720O+j0NxBcQoR
	xixXvRopiMTOG+WndecbK5GaKYtnLkG6JQh5iusGdrB14DUegiWbv8OGRtF0w2+trWHwHGHjnx5
	QlB73lBjnpbw24wFeuXTMZ80e5fArZ9D4ReHLCn4IPpv5MMXc+yLU0r1Cz+I8W6vbvZrMce4usH
	ZW4l/I9nufdHxobn6BI32WHVX96Gql8y/3hRklBvAGAVK8dLjsA+MmJW7rDBGen3Vd0aEU4vTAU
	aXyUINAlcbN
X-Received: by 2002:a05:600c:8b65:b0:485:34a2:919e with SMTP id 5b1f17b1804b1-486f44607e8mr76256695e9.33.1773860530585;
        Wed, 18 Mar 2026 12:02:10 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (202.88.205.35.bc.googleusercontent.com. [35.205.88.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c35057sm8461275e9.5.2026.03.18.12.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:02:10 -0700 (PDT)
From: Dmytro Maluka <dmaluka@chromium.org>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-coco@lists.linux.dev (open list:X86 TRUST DOMAIN EXTENSIONS (TDX))
Subject: [PATCH] KVM: TDX: Fix APIC MSR ranges in tdx_has_emulated_msr()
Date: Wed, 18 Mar 2026 19:01:03 +0000
Message-ID: <20260318190111.1041924-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note: compile-tested only. Bug found by code inspection.

X2APIC_MSR(APIC_xxx + APIC_ISR_NR) is incorrect, since APIC_ISR_NR is
0x8, not 0x80, so shifting it in X2APIC_MSR() results in losing those
lower bits, making it simply equal to X2APIC_MSR(APIC_xxx), i.e. making
the entire range consist of APIC_xxx only. So adding APIC_ISR_NR needs
to be outside X2APIC_MSR().

Additionally, since "..." ranges are inclusive, need to subtract 1.

Fixes: dd50294f3e3c ("KVM: TDX: Implement callbacks for MSR operations")
Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 arch/x86/kvm/vmx/tdx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index c5065f84b78b..466a7de660c2 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2136,9 +2136,9 @@ bool tdx_has_emulated_msr(u32 index)
 		case X2APIC_MSR(APIC_TASKPRI):
 		case X2APIC_MSR(APIC_PROCPRI):
 		case X2APIC_MSR(APIC_EOI):
-		case X2APIC_MSR(APIC_ISR) ... X2APIC_MSR(APIC_ISR + APIC_ISR_NR):
-		case X2APIC_MSR(APIC_TMR) ... X2APIC_MSR(APIC_TMR + APIC_ISR_NR):
-		case X2APIC_MSR(APIC_IRR) ... X2APIC_MSR(APIC_IRR + APIC_ISR_NR):
+		case X2APIC_MSR(APIC_ISR) ... X2APIC_MSR(APIC_ISR) + APIC_ISR_NR - 1:
+		case X2APIC_MSR(APIC_TMR) ... X2APIC_MSR(APIC_TMR) + APIC_ISR_NR - 1:
+		case X2APIC_MSR(APIC_IRR) ... X2APIC_MSR(APIC_IRR) + APIC_ISR_NR - 1:
 			return false;
 		default:
 			return true;
-- 
2.53.0.851.ga537e3e6e9-goog

