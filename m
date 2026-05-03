Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7E1F3BA4
	for <kvm@vger.kernel.org>; Sun,  3 May 2026 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777830345; cv=none; b=sogx0y/aPsSFqTIMMb5iDTiaI7ZTfs3BbAqhzkgdIeDthk5aYeF/7xBAs/0xcV7bGJXi+1oeKMMF8WoaZ61FkJ8UXC6RaxIRYU/qrif4VmgYagrIeMUtBnKhKM8UnFWFtjWdLe7bfQQtigUFd7lM2NaCP8p3qiSuwafaqfCxgh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777830345; c=relaxed/simple;
	bh=slxAIJ/9m7d5tViTXHw+nq9RUZiw7WQ0WulVeufHZxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRGykU1wuxiYZzURjNOSRpio43QcL107s7T8HxjUNI2bA03zGQVlChuV5KI6HdXzqgWWo3kQ8lABHbmX8NuR8TkI3QZuaw5zmbmTQk4POXrKIVfs4lYJpWhFXBbGcaijaTbt9/dRbggJ42afqg2oP1C+oj51iutYq+zinekqpnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrV4PtCO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrV4PtCO"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39393ec4ed0so5594831fa.0
        for <kvm@vger.kernel.org>; Sun, 03 May 2026 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777830341; x=1778435141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0pAbuXkaje+IS6OCmtgXn/l2V2cPnyfblkxm5XAVQJw=;
        b=IrV4PtCOEewCehvRSkLgR+LM/51N0+TCgkZT1aoxJM+o5gIaj90YTCvJ41CHa2leMG
         uHsAFqeTuLP/RDslcYwEVS46n+Dv2vVcMqLygKzDXI8P85aB+XNEd/B0K8ENw8wi6d/c
         91JT/Oik8oCDnnTmcokYl709D+oiTWdvdPm5bm+J6vhykpM/ZClOsZt3wSzODeNTYDzb
         VYR7c/QrmrKkY3YA9vouuR09kw+CWtnzO1jfW0BH+N5QpDpTWkSwK8x9uf6EQRFzwtcr
         OxxOSuInn/zZZTWfGhDxMKlKNcxKE9oB68/1+Joj6/bVU6766b/tbFunHWErMAHdJqSb
         sPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777830341; x=1778435141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pAbuXkaje+IS6OCmtgXn/l2V2cPnyfblkxm5XAVQJw=;
        b=GrCEdBzR2kh1Raf/qYhQN2VWTjC8dy1RiIwurJrpZ8mdpTsSZBlIcLzSaUxiUyFqk8
         9B1N4ZQMDx7wXOquEYoTCpi0jRcFJTmzpG+gwRoZobA/mHeBjaYvvPSEyMWJ5HFToTVY
         BQED7IrH9vdSoD9/Blgo9PuckojWBmtWzEEx/hV6gKa+2wKGH6foKJi84T0xlxZVH+VO
         Xa0rkaiHhweL/JSoyOg16TC5A9YTqw4qNfjKmjz5gAfpLkHKdWJT+7EAitLt7P6ZASRD
         LAaJKETyqZ1oRhOFulTj0b61ylVS2VVW1ouihRPB2Ylres/s1xi9Ko3KTmuCPqFT9hrx
         zD3g==
X-Forwarded-Encrypted: i=1; AFNElJ9RoDPyw5HFZJqHaGEllXaa0/YYMOjA2pSUFWkEWLzScAVVZdUVZitA4eChPE3+5nSjePU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89GFYJNj7gHHALEc2VWqVonaK74lRmA4Vzs6imDvnhv3haHLg
	Y17qguysybrNveNPNKuebP+QI8xEo/QeWHitTXl4MzWzpvB43p+oRTAe
X-Gm-Gg: AeBDiet4ojo3ddNhxjzth4BJ2dl08RzQgfxplo2lUY+VbFhP2zFJNR8CpVCLvJrhg8Y
	Vbn0ZzFDDXVa2olbbJ3xiEj1zSk/NpgFfAZr1zkWtTgQvNEshbIh1mWa7A5nG1PAZvS4h1TQ6Uk
	dwrJtpdUVRNWTK/zVto0dFv6nm6sLNeMgSMX90rXW+A8mJ3+hkStTxW2KUo+Fjqga7cNzqmD1T1
	zORFPwzvyJgvE90S6La3/Jh56Ho+9nvvc/3DagEi7QAgZGc7d3heWOLagiJ1FFRN3P/7zbwKI9d
	aroAKh5m8VQ+mHahJoAln0DozuDoyxGE8BNXQw5fMMiDArpDjo7x+nXs3HDZaVuRj2W7Vp0ZKcn
	3Sca01eO355vvUKTiWl/+DtledShg0jZwb/g8XEu5FQ4HXvwPpUYEL/EyETyPTkMGbkpQOTkmA+
	oPOGd2Ovqb5WOc4kpvAWXkFm2kZZj33z6kDiKB15St83Pg
X-Received: by 2002:a05:6512:110d:b0:5a4:1672:59d0 with SMTP id 2adb3069b0e04-5a8631b7976mr1933888e87.19.1777830340972;
        Sun, 03 May 2026 10:45:40 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a86b5d8ae8sm985036e87.52.2026.05.03.10.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 10:45:39 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Dan Williams <djbw@kernel.org>,
	Chao Gao <chao.gao@intel.com>,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] x86/virt: Fix RCU lockdep splat in emergency virt callback path
Date: Sun,  3 May 2026 22:45:34 +0500
Message-ID: <20260503174534.45699-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86_virt_invoke_kvm_emergency_callback() reaches rcu_dereference()
through machine_crash_shutdown() with IRQs disabled but with RCU not
necessarily watching, which triggers a suspicious RCU usage splat on
debug kernels (CONFIG_PROVE_RCU=y) during panic/kdump:

WARNING: suspicious RCU usage
arch/x86/virt/hw.c:52 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by tee/11119:
 #0: ffff8881fa32c440 (sb_writers#3){.+.+}-{0:0}, at: ksys_write

Call Trace:
 <TASK>
 dump_stack_lvl+0x84/0xd0
 lockdep_rcu_suspicious.cold+0x37/0x8f
 x86_virt_invoke_kvm_emergency_callback+0x5f/0x70
 x86_svm_emergency_disable_virtualization_cpu+0x2a/0x30
 x86_virt_emergency_disable_virtualization_cpu+0x6b/0x90
 native_machine_crash_shutdown+0x72/0x170
 __crash_kexec+0x137/0x280
 panic+0xce/0xd0
 sysrq_handle_crash+0x1f/0x20
 __handle_sysrq.cold+0x192/0x335
 write_sysrq_trigger+0x8c/0xc0
 proc_reg_write+0x1c3/0x3c0
 vfs_write+0x1d0/0xf80
 ksys_write+0x116/0x250
 do_syscall_64+0x11c/0x1480
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>

The RCU usage is correct: writers
(x86_virt_{register,unregister}_emergency_callback()) serialize via
rcu_assign_pointer() + synchronize_rcu(), while the reader on the
emergency path runs with IRQs disabled (the only caller is
x86_virt_emergency_disable_virtualization_cpu(), which has
lockdep_assert_irqs_disabled()), which is a valid classic-RCU read-side
critical section.

Use rcu_dereference_check() with irqs_disabled() to silence the splat
without weakening the protection.

Reproducible on a debug kernel (CONFIG_PROVE_LOCKING=y, CONFIG_PROVE_RCU=y)
with kvm_amd or kvm_intel loaded by triggering kdump:

  echo c > /proc/sysrq-trigger

Fixes: 428afac5a8ea ("KVM: x86: Move bulk of emergency virtualizaton logic to virt subsystem")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 arch/x86/virt/hw.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/hw.c b/arch/x86/virt/hw.c
index f647557d38ac..57eebc99299d 100644
--- a/arch/x86/virt/hw.c
+++ b/arch/x86/virt/hw.c
@@ -49,7 +49,13 @@ static void x86_virt_invoke_kvm_emergency_callback(void)
 {
 	cpu_emergency_virt_cb *kvm_callback;
 
-	kvm_callback = rcu_dereference(kvm_emergency_callback);
+	/*
+	 * Callers invoke this with IRQs disabled (see
+	 * x86_virt_emergency_disable_virtualization_cpu()), which is a valid
+	 * RCU read-side critical section. Tell lockdep so it doesn't complain
+	 * during panic/reboot paths.
+	 */
+	kvm_callback = rcu_dereference_check(kvm_emergency_callback, irqs_disabled());
 	if (kvm_callback)
 		kvm_callback();
 }
-- 
2.54.0

