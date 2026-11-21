Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293980;
	b=WPdb7j54DHd74sJ1I8ZY3cqtqiF0ZE9zFlAKCEFnfkntKu2XWCYH+ltLs2ghFVslcNIa
	 nkNgaTMSLYiPKD9nJ8ojECheLO3N/CIOhRDOqpVVq2OwgMyBtvKU4xR72aPZG6JGii1hP
	 oZT4r3Tdhd18Ivjk/L0LOx9YJ9AUuWVRCqNgO1X6WelAfI5gP6Tyqk6DYr9ns5TAp4e8v
	 3ZjYIDEu2wHbF7jGGahEKdpkEOODAdsdUXkFcTaNvVPSQY4oXXiYSwECk7NChSsh/Mag2
	 pebYp8ujo7g/x+90lEygfYgfTUCGhB63hFmwEyM7xe6j3p+3YNmwdBHfN6Wn1XFMToA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AaHxvjxuFM0ZGMpfN7ZubYdgVJfxHgv6fA2HEiSYIX0=;
	b=Uug+Ng2ID+xxMX9Vhgv6qo/rYiCN9eVXYXfVhdhl7w0HTwJkBlcsWP1FQZfN7a6HESJ2
	 60L51ck8Hx7FXFwM+1Se4w7hJyZthUrQfggjThG/8BvmviVfj0IiF6zgiJ34msZ/0t9tD
	 +hDTsU6abKx1x9Rp2ASdqoeNa/aHMG/j3HConD7lXLybGWn9I6OOhlE9ZA+YM6vEs+ITn
	 1QKmKLBLTu49uXBHe5BnjOeJtr5zPCKmmh9yWczmFqq2jeH4RjOFiclnf59fP9TVbk8s+
	 S9sH2hCNIyucm8n9RRafR0Beej/49KyDc2Sm0FgWFyF4+WZQXYxuBS60GREvrTeYZbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c0j1YSTq;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45CD606A320
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 20:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B45CD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c0j1YSTq
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so11020005e9.1
        for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 12:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795293978; x=1795898778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AaHxvjxuFM0ZGMpfN7ZubYdgVJfxHgv6fA2HEiSYIX0=;
        b=c0j1YSTqWmgHraf+M88X29t3glgNvPRAukpmP1KnwaLuu2YB2GlcSY5gtFRYykiHXB
         k2lx8QbF5w7AN8e5nsE2u3R3FesvwslWZsDuPMuJo2R5s8ckXwwNLlYFnD2qdd4rpMgx
         cxYXhptmdBLmiN+FcpQM0g/Sp+G2HvRv7RPVmKmWgw0c6mAbJiTL7/Pjh0Tgnhy8WxMw
         WVfjX34qPxX6OiwFI0rJ5jPYRSJqUisICn4CO/NtgrcT6fK6/JVBXadP48CheZUrfsNI
         n5utH2Sv6Y8B49KZTN+lVyZt4pd4XXlhcnBe9aLkPuRHs9xbjdfw6cnmnWjDrCRuYCu2
         RivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795293978; x=1795898778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AaHxvjxuFM0ZGMpfN7ZubYdgVJfxHgv6fA2HEiSYIX0=;
        b=eVkaNw2i16v660sXhzWBF1BqnAIFzOXhbuorKplMWHXseIjvZbuPW0FQck4qGRCf7B
         rQp068a6jxPnntRrH4GAZQd2NcRtOwdu1SLAlRGxDfeg2nX6EwJNbPw949cPeei6zxX+
         bwPuDmdIdlpEKs+9lkbYsIxcWQlhSA1yCNQCBSBYyAWc9aigsIlVs0rWB8CSXmE8h2E3
         4668jL39T4TYyvoC+g2JZaVy3oKGyLy3o1ce9ACeTag/QWiag5v+9Yc1RwAmpm7zZ7iR
         WdWYLONe0L+iQGRIwsjisXNTFOSocGuW0K6IqSFe/M3O7KAOTuV/PTfh9Gnv1B0UisrW
         PtRA==
X-Forwarded-Encrypted: i=1; AL+hErFs6qo4YpZDdT3aswCQctQaSJ0hhZ62qP2fPO6Wb6u8cqMhqu+ozXwk4OxFRDChrFmTWFs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5VT3h8ERu0LE1AY2tK97QfluVWgEXdtb3iF4T+3ldO67nD+Ya
	Ir2s6FWOqI/ueZxa6eytuf06Htc5Sw7SULVohnix0UD6HOu8QpPiDIpT
X-Gm-Gg: AZFdTZfJLWHvrCuu89CaEx7dCSkEYKnWhCvWKOMgV9B09nW2VknkFcw9nAsjT3Up6XK
	fSx559osX8fx6Kvn35Rstov4ASJ7v6Br8M3blugvnDqEZeHEPvNvj4ZXcdfbtc85itHsCWSQPMs
	CMOSfl44hxY+mJNjfmnUKryUcVKSdDGyCdu0V/XR57wnI5dQ+3yLlVaFagpGUJRMBhSk5RrXu0O
	i2vN+I2AXvFUlNo/WRZv4ydc6MjhdMOyiJ4W1KEmqSgRocz1QkGztaZrb2JEF5aTtWULOZLZ1U0
	1nIDEOrtSxWZu8f2KBjX+OehHBcj25jpklTd0Ahl4Iwn+NZ5zIrhCnTvcdh9c8I5R9p2Kd2c4zB
	DiqqSte9rtFFF+kpcyA+QTRnfh7jpt2VD3Qd4L/BYyLh7Os+NGBUgJVtvmZsJv4qYrqQ4NYDmuE
	XoOv8ut2gZ2Apt/6Rqjrlp+6iAm8V2z/BqiM1BpT/nj1opUREEWUW0J/KnAJcvgCu+XwR2NNEwL
	HsM2WFoDWLzirZAKaPImwY/T+oNZKcqs4CMEOs1zKyWon4nBH9XLSLFlP5xiIQYNS7xOjrjCbgo
	+vB3Yn9JXxOiqmjMm4pFrcDU0Og0s7aigfXPWrs40Xcjf4G/0uye2ZvN6QDjYT9/56xChiAEaF8
	EDexQSpVjusIiY2+bTrZioTE=
X-Received: by 2002:a05:600c:848d:b0:4bb:52d8:73ef with SMTP id 5b1f17b1804b1-4bb88940f1bmr154944795e9.34.1795293978122;
        Sat, 21 Nov 2026 12:46:18 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.59.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b39b6sm180652385e9.12.2026.11.21.12.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:46:17 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
	Eric Auger <eric.auger@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC PATCH v2 3/3] tests/functional: Add a KVM selftest for an nVHE-only EL2
Date: Sun, 22 Nov 2026 01:46:01 +0500
Message-ID: <20261121204601.741616-4-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121204601.741616-1-haseebashraf091@gmail.com>
References: <20261121095636.289814-1-haseebashraf091@gmail.com>
 <20261121204601.741616-1-haseebashraf091@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

Run the existing kvm-unit-tests smoke test with VHE hidden from the
guest hypervisor through SYSREG_ID_AA64MMFR1_EL1_VH=0.  The SYSREG_*
properties are available only for the host CPU model with KVM, so
select the accelerator and CPU model explicitly, and check that the
guest kernel initialized its hypervisor in nVHE mode.  The test is
skipped when the host kernel cannot limit EL2 to nVHE.

Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
---

v2:
 - Select KVM and the host CPU model explicitly.
 - Verify the guest kernel reports nVHE mode.

 tests/functional/aarch64/test_kvm.py | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
index c977e8c6d2..b7a4aceb66 100755
--- a/tests/functional/aarch64/test_kvm.py
+++ b/tests/functional/aarch64/test_kvm.py
@@ -30,7 +30,7 @@ class Aarch64VirtKVMTests(LinuxKernelTest):
     # base of tests
     KUT_BASE = "/usr/share/kvm-unit-tests/"
 
-    def _launch_guest(self, kvm_mode="nvhe"):
+    def _launch_guest(self, kvm_mode="nvhe", cpu="max", accel=None):
 
         self.set_machine('virt')
         kernel_path = self.ASSET_KVM_TEST_KERNEL.fetch()
@@ -39,7 +39,9 @@ def _launch_guest(self, kvm_mode="nvhe"):
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                f"console=ttyAMA0 kvm-arm.mode={kvm_mode}")
 
-        self.vm.add_args("-cpu", "max")
+        if accel:
+            self.vm.add_args("-accel", accel)
+        self.vm.add_args("-cpu", cpu)
         self.vm.add_args("-machine", "virt,gic-version=3,virtualization=on",
                          '-kernel', kernel_path,
                          '-append', kernel_command_line)
@@ -50,6 +52,9 @@ def _launch_guest(self, kvm_mode="nvhe"):
         except VMLaunchFailure as excp:
             if "does not support providing Virtualization" in excp.output:
                 self.skipTest("accelerator has no virtualization support")
+            elif ("SYSREG_ID_AA64MMFR1_EL1_VH" in excp.output and
+                  "not found" in excp.output):
+                self.skipTest("host KVM cannot limit EL2 to nVHE")
             else:
                 self.log.info("unhandled launch failure: %s", excp.output)
                 raise excp
@@ -73,5 +78,18 @@ def test_aarch64_vhe_selftest(self):
         self._launch_guest("vhe")
         self._smoketest_kvm()
 
+    def test_aarch64_nvhe_only_selftest(self):
+        # Hiding VHE from the guest hypervisor is a KVM feature: the
+        # SYSREG_* properties only exist for the host CPU model with KVM.
+        self.require_accelerator("kvm")
+        self._launch_guest("nvhe", "host,SYSREG_ID_AA64MMFR1_EL1_VH=0",
+                           accel="kvm")
+        # The guest kernel must run its hypervisor in nVHE mode
+        ec_and_wait(self, "dmesg | grep -Eq "
+                    "'Hyp (nVHE )?mode initialized successfully' && "
+                    "! dmesg | grep -q ' VHE mode initialized'",
+                    self.OK_CMD)
+        self._smoketest_kvm()
+
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.34.1

