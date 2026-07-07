Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192443FDBF5
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427166; cv=none; b=Y27+l7cC7HiYF30dTNLngypZlyJuIRmOaudYrN6IOxEGcxpZemy1BpgV7QipBJ8t24YL8RovRnEAyhMvr4knIFZgEHuu8I+haNRYaQBB/np1MOFjJTfYaW8T3m3EkQhQ1wAciwA05NRYCdA1mxSOClXLMc5M4FiqO0axzkhQ1OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427166; c=relaxed/simple;
	bh=JeD2IYjEmV8PrFVWOinMmMDJrUA3mLZsWnncCKtyl94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TJG71oL1SMX8JDYczl2w/wH9R+W+RZc8IBKT57AEVtCXgn9Y8G9hCmwDwhMR7s0CCtsJzTZBNsE3ZD5l93EN+sSBDwTgdL0u3jAVNKzyyWZWbVXnoacaH4DuOrw6eiaFfNStKdOIYXYlX0sS/GxfRME8abBZe/yS3AC2cR3rHxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XA4V0CYY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XA4V0CYY"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-385b78b44a0so2366077a91.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 05:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1783427162; x=1784031962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ed6PrIAg0FPe+WGfGcpcFPgwTg/czpiwdi1SgU6ZCUw=;
        b=XA4V0CYYJnJgBQGj9PlnEs6AMAqUkd0OykR0PzJPOIGQyVB6dUgC/HsIXMf752hj+k
         0CyDZtVg5KSjstDi72vdXxapFj+XlUUqR2HIQh8YOAoVNHNzDerCL+kK+JeLYOyXuiai
         VeeVHhg+mUZSzWpCSkNi2+ndjQlBDEJpdkkSmfZCnwH4IU3/ucxHNtkWeFuzSE68y216
         TUNcw7Su4ekq6RjO9XjhI+Zc8dQg6Is1idC7iWEFR0R+HBk5YYd7SA8/pbGih8Z0KVRX
         RXajtIZGTxlFfTuiaUmI8nHPKPYM3uc8jwMAj2uVO48Y4E4/hiB9vr6ozBLAQ5JBQ5nh
         vjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783427162; x=1784031962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed6PrIAg0FPe+WGfGcpcFPgwTg/czpiwdi1SgU6ZCUw=;
        b=ShciD7CBjTTAd09y+XVy8pEpICOdMFKlqrPwECnXpxcuAGz5way1LzjETAmHcgG/Qr
         AC02J6IWQtQKspQUFv53d/wLoSwAf2SBhdESyIVHgPPIhUgwaIHEQxfZISMVijklGexY
         yPdxapVSBzEZV8BRpzZBTxewWVQacQsuKEyV1vJm8dSr49J9cDgMLVIa/CXr7E7SJB6q
         jybVxw/lXE5H3487kF9SfpF7REwY0ze+1YVBR/lMrVz6BQHvUPSKGQ4TjQ277lLDIpUi
         0Tnq7u5JuCBGVXHQrGOJDi6s3C/kaZbOXdxaYA1I9xohrRWOb2Fy+iiFIES70hQ68bcZ
         G2rQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+keUVEdjY10GV+AyXZqzburptTHX88h8RNX+h7RZkgUY+tagPV29xVkoTk6uyGeeYs7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZXk83znZEV55pDglN+O6zGe9t1Ag5BXFvToKIu1r4NaPyReI
	YvroJJacQFeJl2TRFSnE0DDF3oqBqw9+ZxSCVt5qDI5zyYsG5dH2ewb1AVHtbpZ3QZ8=
X-Gm-Gg: AfdE7ckC75SvHHLzDPA3CY6f/yQlqblTMQG8VuK/A0Sq1j+lr7QT0KsV6sIGxLpcXf+
	KZT+LJHlsM8LXD59MkXLScyO9RXcqBZuAr7WKL+HiKiFXdqW9QeF9ff25t2dOWPvX4GXrCDWDBz
	HMBc28k2IoyJV/wcvPaTp7qUwr1nnky4OV8/E3dmYrEYVYZFxIH/vaCRxx6qINiUg37gZW/2ECs
	Hbp1rHs95OfQRzCQRPyu9GZgrjzRbi6yg9fdB52JNhYBZf7mRlEuGirRduFqVI9xjI4397F7iFz
	sXx51+ZF/nbmmV9kGNjeFy81BScQb1ZkhVJ3ljVt2yHQk/k9HZx5J6BexgR0/1SigA0DIz/mwY9
	88RysINl3G/elG6YH6yfc+fyRvVQpvoeaCIivnXZHj5yIDsS/n6W8wSP7tliSypRDnadmKCbdzb
	4GbJTRsXqieONFxFlj8H8IgqONqLI8Teht+tgtEQ+eqg==
X-Received: by 2002:a17:90b:5845:b0:387:e0cb:7f7 with SMTP id 98e67ed59e1d1-387e0cb091bmr2435479a91.43.1783427162360;
        Tue, 07 Jul 2026 05:26:02 -0700 (PDT)
Received: from n37-012-226.byted.org ([115.190.40.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d2585f34sm1028119a91.17.2026.07.07.05.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 05:26:02 -0700 (PDT)
From: Qingwei Hu <qingwei.hu@bytedance.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qingwei Hu <qingwei.hu@bytedance.com>
Subject: [PATCH] RISC-V: KVM: Inject instruction access fault on unmapped guest fetch
Date: Tue,  7 Jul 2026 20:25:48 +0800
Message-Id: <20260707122548.281685-1-qingwei.hu@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an instruction guest-page-fault targets a GPA that is not backed by
any memslot, KVM has no MMIO emulation path for the fetch. Load and
store guest-page faults can be routed through MMIO emulation, but an
instruction fetch has no data payload or access size for userspace to
complete in the same way.

Treat this case as an architectural access fault in the guest. On bare
metal, fetching from an inaccessible physical address raises an
instruction access fault for the supervisor to handle through its trap
vector. Reflect EXC_INST_ACCESS back to the guest so the guest observes
the same class of exception rather than leaving the fetch as a
host-handled condition.

stval contains the virtual address of the portion of the instruction that
caused the fault, while sepc points to the beginning of the instruction.

Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
---
 arch/riscv/kvm/vcpu_exit.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 0bb0c51e3c89..6c8530b9f29e 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -38,6 +38,25 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			return kvm_riscv_vcpu_mmio_store(vcpu, run,
 							 fault_addr,
 							 trap->htinst);
+		case EXC_INST_GUEST_PAGE_FAULT: {
+			/*
+			 * No memslot backs this GPA and an instruction fetch
+			 * cannot be emulated as MMIO. On bare metal a fetch
+			 * from an unbacked physical address raises an
+			 * instruction access fault, so reflect that back to
+			 * the guest.
+			 */
+			struct kvm_cpu_trap inst_trap = {
+				.sepc	= trap->sepc,
+				.scause	= EXC_INST_ACCESS,
+				.stval	= trap->stval,
+				.htval	= 0,
+				.htinst	= 0,
+			};
+
+			kvm_riscv_vcpu_trap_redirect(vcpu, &inst_trap);
+			return 1;
+		}
 		default:
 			return -EOPNOTSUPP;
 		};
-- 
2.39.5

