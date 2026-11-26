Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670883;
	b=HYekYZ9OHQhg1b+RsQPaXu3ykpFhuELaEOtuLasULpaX4/FgE83S21KisOVWJc3XZWcJ
	 mqhIYVomlHj5F3GTUNB448aLrvZaleY/KI+YtGaAfKpO4+u5xHw4FEPftpcelKGYqZLeT
	 +uSjdgNnBpajQ0HAk7EOToYOYUseE2xSbDg3OlmC7H/2fVdHT67NlQk2vLWIbVXmMoPzE
	 Vj6pMDNvKu9sWAoC4rAX1XUo4y8kh+MqImzDguuO54FbTole4ZDB19yDRqZeQhmSX/jj4
	 qSLlib/zWUEJqeNnxABH5tcXqPRfe71kgHo8SPe4uUiaPCrkz1EFJmJDR2Z/nmraQ7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wH5k6QNkmArm5XncmyqLpKEC7bkf9J2bWJ1i2xZA5VE=;
	b=rwlNT85fRwX9ZMAyaeogl1mB4/GDXqNQujSVSoA7YEI1zaqRIdNb5WYpjIOwY2/N+b7m
	 UViND8O75MfY0V6p61H+U+s2Jv28Qji7xBA/nUFph8tfpFF6uzwdru33rGjbOpBKFZsha
	 dsVivAw6BCsJSmqziTzvSIKQJuZPYL0dGtgQSOKhHvABUF8u2FKIXj3IN4yC8kOHevFUc
	 yjFYXSn4WLqJaY5X7jAuSRbRQvaU10IQUsu04PHC1OJv9lAurSnd2qVBaSQyFB7TN/hlP
	 mW0DtvNlgJVvRaTKSivF4DOm+SpxU9VsFiPK8Leq1beC01Aupifuwm6OGOuuBDkZXbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yh5KqnoF;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F617606A31C
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 05:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F617606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yh5KqnoF
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso60717425e9.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 21:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795670882; x=1796275682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wH5k6QNkmArm5XncmyqLpKEC7bkf9J2bWJ1i2xZA5VE=;
        b=yh5KqnoF72qkNIIsHih4qKp7CajcwjcDXNIQgvvgtewNilzcx0GU2PHWaD8Owsk1Kq
         R0mUmMLm+ITgplJtmvWHH4Rof3TPlVAvL8yHqR1824UBrhT2Pzoc9qriiJp2UzQPDmGW
         XlgsJK3JFPXRoaFF9b8XA0sUuN5ne94tg5XS5HN2yZD7Zx1oR9JUTrWAjOktIWB/c+Qj
         y5VSlu2apYdNI46EgOfI9+S/1EHRFBum8ui0D7++mv6HEUQNpODwmCe6TbN/InnXH1zE
         ejyGTlSy6ceAI6jTMyZQCofHeOk2E/hTh1CG+T7iT8Inrmw2Qp8dYfAGYfUDHo+nJz2t
         k6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670882; x=1796275682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wH5k6QNkmArm5XncmyqLpKEC7bkf9J2bWJ1i2xZA5VE=;
        b=tGcgRuUh3gXkvyq/LSlpMbzz6tNgHibPZAITmgzQX5U2fv8keXAfQz50yUyYHezGcB
         66qCBnQhUCdWROYCnB/YVX5ijxJobEwOsRtLxHcVGNYHLEJJU8N/2eXXgqu1iUsEbjDo
         vdPpqdmqTF90oPdQuSW+PeJeeupeLhhhkKBGesDbHAzjNK2cp0KzjCqOG8ULqNOkSZW0
         LKqiWgqslvlp51AML09e4Crr26PJB9Q+fLS5UuhHWJgBTMT8hg4PXDIdbI6Wg5UulPEM
         dd+DG5H+Rxk3f8cHQntqyHS9W4AAel/eE3hZSj5COb1nPv/OfTBlb95sKitPYX+fcrXt
         5vKA==
X-Forwarded-Encrypted: i=1; AL+hErGB4cBVhX4b+algD/pvjl62CefmlNhd5oS2S5IBtC7Fb2cn7wkaxSOU2cKcRytu6mAJmQY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CxU3iKzgwdSf2WFxCWHwKpXP9JL9rb1aL/JGU2/jIO1E1Y1Vt
	AUgye/rtpPwew2s4PqhQ0dBOnz9OszjmYH2TumQLonkM59/2Il5n6pqa
X-Gm-Gg: AZFdTZdOyjmahHJF1Cifp8Agx3qgpX0gkvivTOPf+kpEUcobGoWAm5rGouXb08BAZm9
	GxT44MHeV/XqdBlKQi6EAzY/Y8eZ6GQ2gaI8uTMfayTkfGmdcCDvKfXmBucHeEuykVmn+9OBcpF
	I9JixfwkmtQk8noeTQB1LY2QmVzkzq3FPkH0OU9xF8Jsg6nLTkKFpFwMjLU73zDy7+iTee15xHY
	7+YiWMHCuEu4Osq9JAFZDoCOZgEm2MREkFvgyRBcHTXVWQ/zA+BFJ/yV/AiM6KdmSONAxJAcyxQ
	mYjnwCg5GJzY4zjHFfgX5CJ/DqW6mH8Jtnnpf3+ud0Z6UXkWSnpl20RfmNhUo/P3iRW1aHpQw/+
	XO6iHgXEb18/ClfrzsBZyu5yka0VSgOiQE69cRbTMQs9V7Xmwokdygv2I/9+L/UZ+FrNR1+zBV1
	D77rgcYHYyesJScU679QQmO8/AB6CM9BTKGGhRmvZxi8TaVFyVuP0RnrDQCWniqE7PllCDtw+N1
	jObxLMexKH2zWBxBBbJRw+2AvmVof8Cdn7ZeTEPEqTOmRYlf2bh59GhMrlvAJoz0f7i7181GYJv
	8rsrwkxyE5UUx2+WjQQzZnxSOAqRKEMH7+F2HoBCzlH5M439OsAItB+vSU9ohMj5L0tlC1rL6Rg
	QNXjIwU648wmCVvJA832fyHTFKXFk7lTehT/NixJToK1vCw==
X-Received: by 2002:a05:600c:1d29:b0:4a9:2a92:231f with SMTP id 5b1f17b1804b1-4bb88804d4dmr428985945e9.7.1795670881703;
        Wed, 25 Nov 2026 21:28:01 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm808310475e9.13.2026.11.25.21.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:28:01 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
	Eric Auger <eric.auger@redhat.com>,
	Khushit Shah <khushit.shah@nutanix.com>,
	Marc Zyngier <maz@kernel.org>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC PATCH v3 3/3] tests/functional: Add a KVM selftest for an nVHE-only EL2
Date: Thu, 26 Nov 2026 10:27:41 +0500
Message-ID: <20261126052741.90607-4-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126052741.90607-1-haseebashraf091@gmail.com>
References: <20261121204601.741616-1-haseebashraf091@gmail.com>
 <20261126052741.90607-1-haseebashraf091@gmail.com>
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

v3:
 - No changes from v2.

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

