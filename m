Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669962DC765
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 04:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756290; cv=none; b=hwUqla+eGpMRdw6gSd82640+XRC48v7hTsGjJOApqlVAlMm+vBCwd00v6oHZFPb9KrmDhFmDL8P1zmRSYJemjuTumrKyGhN4myFnkzpS9zrnPMAgBrNO/TwBIia1NBn/j+lK4fFTPX2SI1Y1FuvuzhGVWOgu2iQaYG3uO/ORW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756290; c=relaxed/simple;
	bh=r/Yb1TwYqrAmxqT4G7QAMIstgXNzCAcMpunOKlup3Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mb9SLbX/0MjxXBUGCapny3u1gh6v/s7o7MxryjVY+uQTwu1KnA+KHITghIlk+esIJBbIy8GE73C1qgKgcK9VXhvHjZDwZKS4Xysl2WgKmrE+IlRg2hvLydgpSEYXUDkDDLIX9PTG8KXptrEDgtyKU0PscPpqUYd7KRvbX9ZpFbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imcqLLlX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imcqLLlX"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d71ae3455aso45251255ad.1
        for <kvm@vger.kernel.org>; Sun, 06 Sep 2026 21:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756289; x=1789361089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ieAuNZcZYYBHRZ196owNjlAruJ8erVXUUQKh5uVkow4=;
        b=imcqLLlXgHNZDrZ6nULWcLPgtC/h83N5LI6NIFElx5hE1GwTI9N6lOYkROpKn/Va0n
         pXPaie7Xj1Uxe15CxMrVs7ClUCwes7KF1ONpsLY1oOEpzqnqGZLmuQdqRGEtdjLGVKtC
         YUCohzNykrdTmTaz7L0hMx9/eIuhK/rnmYpkLYXmC52aV/b2En8wWLaB6CgsRbfZd/qo
         7GP48z5ApDg8gA7Nl/BdG9yZ7PicPRZy/4HsOwPKjr7TanVwX23nSvRDUGPI2bS2toOW
         NXqwNJrcqoHNpDsfgq9KSIe4O1djkFQ3UrVDG/MFkaV0RGRJmNo8lDSatWlzfMcpFUas
         OGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756289; x=1789361089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ieAuNZcZYYBHRZ196owNjlAruJ8erVXUUQKh5uVkow4=;
        b=fBePcGg4TyFAHBkWulCgJAzCKYvuAxmtuVyyQA35lirSQLLJ8iR2IA2q1ul1lMyXdD
         gYQz55EAVnq5Rp4xbMIoXeaUa94w+s/88aTXtMicPwRJtajUoHk1NJTmVrjdSRoZI6Jo
         +kB3BHHWcOSv47MQIWaOqFlbXtDTT5tbeyDZPb+WA2rrTIVoppN+siVvkJe7xKd268He
         Y96X93fhSNnrxyJ3DFF2A+bONUrpnMXN1NHBE4bR9EG7hsdW/Ab7CazJ/kermpXb9OiA
         YDRG85urh61xBiN57NTNAAyYtWShcGgWGmZLtuCf/hm8yNJQgjR/bEZOaJIFGKR8n7qi
         NwlQ==
X-Forwarded-Encrypted: i=1; AKwUvBxnUZAqjCMnomKpdbxXLe4A1WQLQErh0qu1MQTcnnBKIoPWG+LmVFGzGCgAvj12waexJDY=@vger.kernel.org
X-Gm-Message-State: AFuF++nuUZRYw7TEGIGgotGHJeBrq+ySgDwjyFmWw4H1jKInk5844We+
	a1Wprce5AodcuM38e1ojUKVe1orLirYRynrmg+WyKwpS9g9pgMdnPFxc
X-Gm-Gg: AYBFou1GKTGZpFhT0/tgxCHzom0G2DPcx00+qOPgMyBOe/FvtXUCKyk9RLrOwS972Zg
	9wTvA1WF+d//1089SpFYtDowgapN+Tc6ALzsf5U9u/+vLNAOocTs65zY0jQ4N5bTzt2ieHqdVfC
	LFQDKhe1jujGsd6OKtZtCVWufkCExoiH47n/beOJuTXeK19Y1OCecBD3fLFBBlpkAqQgQ1UIosj
	NRsTJBGMim8JjloI44H4VVkIP5YzSryFR/pkKTu6nv/2Iwts3bSrHzPg56coqrEcvOpLbvCma1g
	xUbqCgpf/N8p0cVfitIpNG6+DiedfrjFQXo3/thCkScLBa3a26ypS+9BXQs+r3Hl6FZtGmGov8/
	DRAcF54wle8/ozsUh/CZIjghSqoUIViFZ4pfNByfG+nrYtuO5i1bltON/ablBFOp6eMb1Tkk6Bf
	pgRgRptgnkerYeAOz3+OyXywEHpqo8Cian6QQoJ6Ph+Tmz5yXpUkYo9zrIw23HsmVuiw//q5xn7
	f7+brcT+WRumxsHZ3dSWiHM
X-Received: by 2002:a17:903:40c6:b0:2d8:d4cc:5bb1 with SMTP id d9443c01a7336-2db1286ae13mr285166485ad.17.1788756288604;
        Sun, 06 Sep 2026 21:44:48 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm37823751eec.16.2026.09.06.21.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:44:48 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: kvm: fix typo "synchonized" in comment
Date: Mon,  7 Sep 2026 10:14:32 +0530
Message-ID: <20260907044434.4682-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907044434.4682-1-hemanth.selam@gmail.com>
References: <20260907044434.4682-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "synchonized" to "synchronized", reported by scripts/checkpatch.pl
using the misspelling list in scripts/spelling.txt.  Only touches comments,
no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/arm64/kvm/hyp/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 308100ed25de..9709905f21b5 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -46,7 +46,7 @@ alternative_else_nop_endif
 
 	// Ensure that __guest_enter() always provides a context
 	// synchronization event so that callers don't need ISBs for anything
-	// that would usually be synchonized by the ERET.
+	// that would usually be synchronized by the ERET.
 	isb
 	mov	x0, #ARM_EXCEPTION_IRQ
 	ret
