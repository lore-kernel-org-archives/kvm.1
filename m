Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DE368D7B
	for <kvm@vger.kernel.org>; Sun,  6 Sep 2026 04:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788668515; cv=none; b=giSGWoKgPK9PglOUKTX6DFk5M+KPUoAWRMULrKnuTNRYEVqVpGkPTwpxdSTQBYfZDLyEgw80bRYgrVsqFtjZdBz0BSjSRyeoAtnFmJ3xlm7Z5i2MmbY9//pk5kQc++u6HaGVUvUG8962w4xKKrHFlkuo0pf4sB1+impifugee0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788668515; c=relaxed/simple;
	bh=vdK3wtpjZYQNeaslASnAOYg/PCjcSi/RbT91Z1Uest0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UN1bBHBXvFpoblNlNMdkg3darqLufgoW3K4MECZmRJwCQbRzM8l8rEgWypfxLkNp8HwO37NMG2XNc/SzXuZdIIficMnRFB21YH7sEO7AdfqYpD/Hxv6P5cspeuCIkb0s57Wg7aM2IRbXP48pYID1eL0emexN1CJ2z3PVXSnBXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JO+e6Hc6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO+e6Hc6"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381b831d535so3948497a91.0
        for <kvm@vger.kernel.org>; Sat, 05 Sep 2026 21:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788668513; x=1789273313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VVHZoxQnI4RGBc2Se+Rzzto/jsA46jGgtEifAbeG3A8=;
        b=JO+e6Hc6KGrWCldK6My/o+Bquds45AKpAqktRB6N61AflFaGAoLtY8IOjZwRj+Rz23
         mDSEf7BjNvelbembqo72Y/e+uZk2mK6MD9stlrPEtU45OoNmsEaAY1foYEKdYMA9fhRs
         0p19GdDHixuycMJto/tLitHjHwGvVRG/0pAjVkTvsvELP7NFXh6+cuSKiGYUeumEH6tr
         Un6qVsnyJmXy+vroLP/osFxDt/JUhQ90XhzJ1gcPn3uNIXgr1D9RpqNjxnu2kdgyNr5e
         xQpxxAnUS39woI1skNacI7f7e0+TOfmbsS0Xj3boMc4Vq4Pr4/gLfYmqP6NcAT5Q2ri1
         GtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788668513; x=1789273313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VVHZoxQnI4RGBc2Se+Rzzto/jsA46jGgtEifAbeG3A8=;
        b=qSeQED2Wlg0FMgbUh8ZwT+M2FHVhM+f3P0SN7ssW4YFnF+vhWA1sW8yfAwYKNR6RTZ
         KMjFnmG79OWcJ4l/ZylxboTv2Sa/X/dMn6/vu4LjK1CgEod2N68qEd4q7/AQFmBVjQC3
         qBLmGk3dbmAd2KhgKW8UZeFBD0y/5VKnJCnrq6XBiaHPXVQX/jYwnyG0Vvs3/I2Q0KAO
         auaUsL3X7aqSmQq4p24diBaFimNUvfsu2Sqiux6o4fV/zIvOE7lx1poFsGSIRC4hfjl2
         NKBW9mI47Pc1H1D9zqHXvZFqvmHFmRi2g/11yf0UKgrRK6YGQP5SDAbObWqfxBlYV0ji
         I5Rg==
X-Forwarded-Encrypted: i=1; AKwUvBwMGFooMCxnuQafXkEhIEDIarWzec8kOopLOnXu8v5LxFbeebQTzPezQPR2rSUhoerJ4Lg=@vger.kernel.org
X-Gm-Message-State: AFuF++nGPp2WWkdJra7r7GcX7GYrwdeY9yYmDHwX7VF9Ep5318/96Qim
	I3L/CU0jEGgOJLgAlNq49Qygu3bNIMPQG7/ut9jmPUOZyQ+Y5un9i6uT
X-Gm-Gg: AYBFou26DqIv4/fBnSwijR2z9H7DuuFJM0nKNc2m8Z0hQxDSnLaYfGDnsp36bSW5ttS
	jKPL3RTFDxmhSEJ2UrZIxPOwVj3vvyMvbc9P9ASuJasfQgF1/Mtd4Pd/t5rrsV9DWYakd/PlP0F
	9uPsbIXt4lHo8SehanZLUhv3ohon2tN9pvjDxOsNN0NrwshTBTFND7YTdp3WLcr74/o+QA1sXNV
	UHqiQ3MnKdnb6AADwOucEVYv82/9k6yQCtS9gO4XEUKnPxlqhvJmBo82emPQPQX3ZvxtNNhxqf/
	Ebl1MbzuAkWYT3QmZ6rtLrOMTkRRJT3rqi5cyPDhwlbF8xf/x1YA/gcPhXkUbCuJfZtVcI7lkse
	RnyNGTx/+D6RKZB79tZsfJHjGLB5a3tfGYqvmlls9Br2wR+lf16tyvCgNgg9jYmqU4M9DHoClAk
	PQrm37hxKkieH21dgoks90QZqZQO+aUFrkAn2Wb6L+2NtEvrfaoA5PFsHdh/7sZbhyIU6lWEdfT
	68uvtjZjiL3bKE6kG+PLXUF0yGyJu0m5dIW3E5UeG+ivyT/ZpoZqDU=
X-Received: by 2002:a17:90b:1e51:b0:399:ecd:d68d with SMTP id 98e67ed59e1d1-39b26260f7dmr22268351a91.22.1788668513437;
        Sat, 05 Sep 2026 21:21:53 -0700 (PDT)
Received: from debian-rockchip-rock5b-rk3588.. ([27.130.10.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14332405e92sm9412489c88.8.2026.09.05.21.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 21:21:53 -0700 (PDT)
From: Tharit Tangkijwanichakul <tharitt97@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	Tharit Tangkijwanichakul <tharitt97@gmail.com>,
	Gokul K <gokul02k@gmail.com>
Subject: [PATCH] KVM: selftests: Fix reg_list and VM leak in get_reg_list test
Date: Sun,  6 Sep 2026 04:21:31 +0000
Message-ID: <20260906042131.630-1-tharitt97@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling the test with --list or --list-filtered causes an early return
in run_test() which skips freeing the reg_list and vm.

Use a goto so that the early return joins the common exit path.

Reported-by: Gokul K <gokul02k@gmail.com>
Link: https://lore.kernel.org/all/20260808081050.408657-1-gokul02k@gmail.com/
Fixes: 17da79e009c3 ("KVM: arm64: selftests: Split get-reg-list test code")
Signed-off-by: Tharit Tangkijwanichakul <tharitt97@gmail.com>
---
Tested on a Rock 5B (RK3588). Running the test with --list and
--list-filtered now exercises the goto path added by this fix and exits
cleanly.
---
 tools/testing/selftests/kvm/get-reg-list.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
index 216f10644c1a..6eb91d5c739e 100644
--- a/tools/testing/selftests/kvm/get-reg-list.c
+++ b/tools/testing/selftests/kvm/get-reg-list.c
@@ -189,7 +189,7 @@ static void run_test(struct vcpu_reg_list *c)
 				print_reg(config_name(c), id);
 		}
 		putchar('\n');
-		return;
+		goto free_reg_list;
 	}
 
 	for_each_sublist(c, s)
@@ -306,6 +306,8 @@ static void run_test(struct vcpu_reg_list *c)
 	pr_info("%s: PASS\n", config_name(c));
 	blessed_n = 0;
 	free(blessed_reg);
+
+free_reg_list:
 	free(reg_list);
 	kvm_vm_free(vm);
 }
-- 
2.47.3

