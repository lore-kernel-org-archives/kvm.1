Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795394053;
	b=Kr6m5J4IfgLFfqG37uK0JUx5LvlwGSTkRQNCzqqzdYxTNIjAIcVUU0YrbB8FmXhm1KNj
	 B1h1D+wsFH2fmZGSokNp6pKv68RYhAmDz+oFprZU0Aptqwh9uqjvrOBQluhEPj4Sd8X4O
	 V59iclwNoVMmc/jtOZoEY2Z+7TV8mPrDB2xKkI1/A/Cqa7vRYaQaL9WPIr9+g/rNZLFmt
	 k7wBKDiJnOr7haJbuxwO0YssRua9VCUPqbBBZ0/dA7qv17LI7rJYt8dwmz5lUbhWVJKZp
	 jfSqPY6KtvxqYo6I8UiVzjyKJXgYW4t4kuLHbCAQOyXA+bMLgIHls10PNk/3+WEBTow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y2zkbDuNdyLgS9VK0BRjp9YHIzBcoYoYpmcLinVfQTY=;
	b=lz0ACX8R25Yk90OURly5MqgsHn5xpi+Lq0MVmiE4bsG7UNQpc8Rxw5epCuYIOrozyqKL
	 tYNdJWsSLBTLWL/mXdSVnVSsgi/Hsj5keNhaul/oYOVNYFmqRO7cYmhv8o6kXs2Asg5JG
	 HLHGdMiJ2s0IPwhJQ9jfQtzlBklqI38m5JuS5r4XJ/3bH7L8ZXLAYTpxEbXhBaVEXHlaI
	 fvNyFcm5hnNVCwdpfL6V6+B6HPfc4o7xVHl55Sn+Mum7ov2M2quTynxH1kSVwFgFqdctb
	 TXMnyliF/Cj8iF16BGI/xYuDcbaVdDKYfwTlHNwuB6u7BZ6IPzKnH/eOD9CWTEl/Ffw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iMotbwmo;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F3606A31D
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 00:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 028F3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iMotbwmo
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so10769055e9.3
        for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 16:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795394051; x=1795998851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y2zkbDuNdyLgS9VK0BRjp9YHIzBcoYoYpmcLinVfQTY=;
        b=iMotbwmoucrMKCJdQ6/o309j1Jw40JxSU6aZshmDWO+iadVDisK6gU0bHp51Gmo4V8
         3fIC+ghxhZr4ydlcMGJmo2YvCUd+dA8b0a/qUh7RE4RDaaYnQryjPWxQAb1g7eIwZrCL
         g5FBbU3y+cwL7xNaBi2TYbs7gZ75bPGjhudjl1xkRVCbI5LEB4LkNP0Dnmgbc0Om3CeY
         3i8OvVNsd/LM184DAHMBGnigHUxucvHQ9mv8yZdNYmFV2n0fcEJUrJeqI7NesEpNS3Bw
         kpAI7wUcwRD/q42wlIKJqyPjQpQ1vlYVRXccU2fPGxfODMxzRaopYeA+BTnm/ZyuTGK/
         cYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795394051; x=1795998851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y2zkbDuNdyLgS9VK0BRjp9YHIzBcoYoYpmcLinVfQTY=;
        b=H+VT7gH/VYUrbYi1ltIeRB6hqqZrgLxNBAKPXG3bc/fCFcCrxQENSQFhevoa+fq3bE
         cpT+ipWYOmq1kMKXMgqrgyrQlipbLPrNqWiidFXHSVDBEujxDyvldn3MAF50+ouqYEdP
         qjXoQvfU+CLLuwtK27Tl/zX+9E0As1wrLSvOsViq50NU4iK3SJ8sDHcAC77+RSpQo1ZF
         bgQq5/cNEXVP11YD4LVBt/pKgNk/snQDBe/4sINchsbWCsKGsmusVXuS28v50M8RoCQV
         4KWmhUJ1waDvSnLjdXuPOtLi8lCmTy77RFHH1vuR2/vOnZt/AVf8LJtvAlOykdtJY5GL
         0vfw==
X-Forwarded-Encrypted: i=1; AL+hErEmk9yqK06eD0yI85NpEJThxht1cOlNYGo+u+NeZUwMJr+JcXngZA7gzDVRuHU5gtGARKE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gAkJRG5g2iLQtiUrURosxMBHmWpV1ggtnNAldFAy2EgyO+BMY
	7yVHcDLz90o4J8jZ3836VFDNRvWlq4onE4TWj4Wp1X9b6xhmeH84DYhJqnhM3WeEEFY=
X-Gm-Gg: AZFdTZejYKw6cdldfg1Fo5RAj5MdGnoaZ5D1fKOUa8JYUsD0lls9XYBpWYoPdKCx7Hb
	y482xtHPOWCHB62fplpSsiRwXbranCG1XUMn2Y/hY3WdPVyr5unayZ8Q++1ygcNfm7teK3LabQz
	aF+dnWXTTZvm7SQP15jJnM/UNSBttK6DEdzCngV+O6+VSlk07pqWIQyPmssjCi97izUCSNIjJid
	PYtqp1x32BGF3lmJYPVrzQka3W7B+TEK7xP/AHsGz4g26dpukjW42uRm9k85iXYeQa2HqafpEg6
	SBtbsw7RHzSFpfyFNm6xlvPMZyPh85canoW9BKOSiemDkVdKb/4bj1cRmyZ78iXPgBeoYs6ozeN
	CmlC50JU+lAKLYidZpeXHLnZ+uIFNQbXoakDpjY65SHi/gS6vCWDPK+bJgbezmyKGE+oyzAeMRW
	f2q+L+cIMZ3clydYXVf09WO1O+NJLLp+vgcDHBDtanyKcmWrwz0uEkuZzu0mv+hivrtFiSobuaI
	RSdvOSRdD/18+Ech6b5MCQPOZ66xJGnUHh42fpSQY3dZkVbDnudp61EumGz8eHKjDvDmi7IzCe9
	lAZelougsxOFcRkp+vgAfvmMx9O+eaUno7uwb5fwZwfmsB0av/L9kh6OPfRtcdSmZFS+bZxIjx6
	fI0aHvGZEEuSjbxG8xfnqADkgz0WUNwZZnDADDsNdgxrTH8BykEif3d+WY1PaW30ADVkK88oDvL
	qe1gowT3I4
X-Received: by 2002:a05:600c:500c:b0:4bb:82f7:549f with SMTP id 5b1f17b1804b1-4bb8881409bmr227020335e9.19.1795394051194;
        Sun, 22 Nov 2026 16:34:11 -0800 (PST)
Received: from fre3dom.speedport.ip (p200300e37f1deb6597bc525ce8f19e94.dip0.t-ipconnect.de. [2003:e3:7f1d:eb65:97bc:525c:e8f1:9e94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9066f6e6sm111751525e9.3.2026.11.22.16.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 16:34:10 -0800 (PST)
From: Javid Rzayev <javid.rzyv@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Javid Rzayev <javid.rzyv@gmail.com>
Subject: [PATCH] KVM: selftests: Use __vmread() for the optional HOST_IA32_PERF_GLOBAL_CTRL field
Date: Mon, 23 Nov 2026 01:33:50 +0100
Message-ID: <20261123003350.198278-1-javid.rzyv@gmail.com>
X-Mailer: git-send-email 2.47.3
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

The HOST_IA32_PERF_GLOBAL_CTRL VMCS field exists only if the CPU supports
the "load IA32_PERF_GLOBAL_CTRL" VM-exit control, which is not always the
case.  E.g. when running on an Intel VM in Google Cloud with nested
virtualization enabled and no vPMU, VMREAD of this field fails.

init_vmcs_guest_state() copies the field into GUEST_IA32_PERF_GLOBAL_CTRL.
The write already uses __vmwrite() because the field is optional, but the
read uses vmread(), which asserts on failure since commit 4e824a04d4fa
("KVM: selftests: Always assert that vmreadz() succeeds").  As a result,
nested VMX tests (e.g. state_test, smm_test, nested_close_kvm_test) fail
with:

  vmread[0x2c04] hit VM-Fail

Read the field with __vmread() and copy it only if the read succeeds.

Fixes: 4e824a04d4fa ("KVM: selftests: Always assert that vmreadz() succeeds")
Signed-off-by: Javid Rzayev <javid.rzyv@gmail.com>
---
Tested on a Google Cloud n2-standard-128 VM (Intel, nested
virtualization enabled, no vPMU) running next-20261120:

  before: 15 nested VMX tests fail with "vmread[0x2c04] hit VM-Fail"
  after:  all of them pass

mmu_stress_test hits the 120s kselftest timeout both before and after
the patch; that is unrelated (the test scales with the host size).

 tools/testing/selftests/kvm/lib/x86/vmx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index 5a06746eb..4b3e439ee 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -348,6 +348,8 @@ static inline void init_vmcs_host_state(void)
  */
 static inline void init_vmcs_guest_state(void *rip, void *rsp)
 {
+	u64 val;
+
 	vmwrite(GUEST_ES_SELECTOR, vmread(HOST_ES_SELECTOR));
 	vmwrite(GUEST_CS_SELECTOR, vmread(HOST_CS_SELECTOR));
 	vmwrite(GUEST_SS_SELECTOR, vmread(HOST_SS_SELECTOR));
@@ -363,8 +365,8 @@ static inline void init_vmcs_guest_state(void *rip, void *rsp)
 	vmwrite(GUEST_IA32_DEBUGCTL, 0);
 	__vmwrite(GUEST_IA32_PAT, vmread(HOST_IA32_PAT));
 	__vmwrite(GUEST_IA32_EFER, vmread(HOST_IA32_EFER));
-	__vmwrite(GUEST_IA32_PERF_GLOBAL_CTRL,
-		  vmread(HOST_IA32_PERF_GLOBAL_CTRL));
+	if (!__vmread(HOST_IA32_PERF_GLOBAL_CTRL, &val))
+		__vmwrite(GUEST_IA32_PERF_GLOBAL_CTRL, val);
 
 	vmwrite(GUEST_ES_LIMIT, -1);
 	vmwrite(GUEST_CS_LIMIT, -1);
-- 
2.47.3

