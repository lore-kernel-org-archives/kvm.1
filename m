Received: from mail-lr2-f1.google.com (mail-lr2-f1.google.com [74.125.230.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958EC47FB0D
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203855; cv=none; b=Pv19ihVbMlAMpYY1LDLlNkZ5znJ9+M5NNc9+F5Qjoc2DsR4TmGGU2e9dWaM5W62wX2f807IyR//Y8YWZKeD2NgEz2Go+fYKIyNa0nSoDer9l3SI7O7g2/mJqeF6fVp1Dc68b0Ae7gjfapnIw1/nYxiShR0UsqIvxZL9BAr690Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203855; c=relaxed/simple;
	bh=kBexbWtC4+MyoxidFkM/IIOP2Geigs/tBXSpL3HrsRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MgnL1IQNqhz9/o28fRhKlyc7e1KpM872dGVigamCNajrb0byms1TY8OayioALWHgCa+KG+X1pFXe2pvM7VN0RbS8IJQApW9dU5pbjpXPDUrlEWUNVJgwiCJ9WzYf8I2srT2viJCBDgOMV+3EKArOVC5MOiBeV/yEInS3mysufjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvzL1VD6; arc=none smtp.client-ip=74.125.230.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvzL1VD6"
Received: by mail-lr2-f1.google.com with SMTP id 38308e7fff4ca-3a772511049so13832331fa.0
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 05:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791203851; x=1791808651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gt2QZueXCtMYUg/+LdAV+X7CcqwaR0yZcibIjcXuM5k=;
        b=qvzL1VD6uM0sytgBhyC3jR+W1WlZGDTYiTyunLh2P3wWkp2PzcE4RdfxVwpXld/zLd
         SoQfOa71Netzo04XfJTOw2ZKUUoO9iX3hJcqNZY0Uq1kOknVYkSoeJs+CyTCw72rIQKJ
         oynUVidqYa7k+vnuY0eAbd1GcCtlYDPOHD2TJq0d+YSe8NaCLo2zW60+/cvMQAwia7cp
         2JyiK+M/GJwZU2sGcqUZHDlWtAVPbk+pkBRWUtqytKp+UCI/wwGUtM0sS+Rijxn71pla
         UQQyIulaUsNADU1RWpxUbWVUQ1YQXsLWnSaFnKMvRWMWErQP1QrHFhi/wTiuQRpQf943
         kReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791203851; x=1791808651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gt2QZueXCtMYUg/+LdAV+X7CcqwaR0yZcibIjcXuM5k=;
        b=Pk995Czb4uaARRTk7F6IeSEjOzLGf7duM0oh3L782n98YDRpYNmZQHKWPb23fmODHQ
         cLas4KMwsSu+xGb9GxItW/B+ow8KxiLnXFr6F2YDMmigSVVIbQRgo0tmAPSqXJZSylZc
         yqTDehAC0Fzk93s0R1Dx3QRtWMWnNtMb1UaXmezi6zEgyEe//nw3NDA0zT1XZVI8s+qc
         bxh6IZvpgrJ/NakDEC7nDpePp5SD4hETWGYcaPOkRMhjIeUIIKh7GM7k8D7Qv2mO6LAW
         zwRoscjLoSFAiRBw2nDykBVB+Eil9itEP3vZ3lSO4+6NqN9/Y2tokHJX3DeGRY/WwHSm
         LaYA==
X-Forwarded-Encrypted: i=1; AKwUvByeNrDYR3nhIA/lZJokYVCiBQXmnmFMtgJy/qZ532fYabnTkl8wqNzig53pvamJ6aZDa/0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfZGPgeIFN2tCOKQ9u1fCc6L2A2tx/pbYQebZET6zx9A1CAJ9/
	ALYzWXv5x5vj6pECOl/GgHsBfnQWR4VzoD0bWAQ3uX/wqQjuHrYiw9Om
X-Gm-Gg: AYBFou0Qm8df3fTD/5yVk+DhrZDFdTYOZFN+9JzaQhuyeMIWL26P3S3gWccqldA2dtW
	FknKA8By3Pdigf9ChJ/bzxLds7YK2lLpSw89fjsjp8fZxUI72yc7dInhp72RtAgYezrGMux7QTc
	/r8kbTxd2uyO6/WbwBu8TErmyHMTvbgLd0Z/JwEklBRG3C4o0da6XxVgpEblBl5GKzmsBSmCOTA
	EgPsUv9IpAQzyeoZoIkqbgJqeGdEscg2V3wvtmIxIY1WXHM0Kl/WdwSEBFW/Yz6a7/Pj1S/sN/p
	DmP8ubG/wrvzLW4XvExhe2E9s1gQ7YvcETeqa2r4XXq90UTZUVo5R0M7pGshcS8xMiPNWzF8kyQ
	XTZLCWPC8BXpaubn4FQL8lpQl7OlC2A0A4ajFgzfswv8kiQTO10OUATRRqrfu4E3IOu0N5KimWU
	B+Kp3pQZRGKMqH0DMDyWffJ+dI71zl+YV7b8EILVmoUTIQanZ6O4vZRJ4bJlXP8St/ZxgdTW1n/
	NaugChL+nZs8Yv+
X-Received: by 2002:a05:6512:688d:20b0:5b8:bc5e:d118 with SMTP id 2adb3069b0e04-5bb9bc2ba85mr2534588e87.66.1791203851108;
        Mon, 05 Oct 2026 05:37:31 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c718f62sm3228393e87.12.2026.10.05.05.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:37:30 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Jim Mattson <jmattson@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10 1/3] KVM: LAPIC: Advancing the timer expiration on guest initiated write
Date: Mon,  5 Oct 2026 15:36:58 +0300
Message-ID: <20261005123705.137028-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wanpeng Li <wanpengli@tencent.com>

commit 35737d2db2f4567106c90060ad110b27cb354fa4 upstream.

Advancing the timer expiration should only be necessary on guest initiated
writes. When we cancel the timer and clear .pending during state restore,
clear expired_tscdeadline as well.

Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Message-Id: <1614818118-965-1-git-send-email-wanpengli@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 54b3439c8e70 ("KVM: LAPIC: Also cancel preemption timer during SET_LAPIC")
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
 arch/x86/kvm/lapic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 8b7c3f773d70..0b6fc5395798 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2629,6 +2629,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 
 	apic_update_ppr(apic);
 	hrtimer_cancel(&apic->lapic_timer.timer);
+	apic->lapic_timer.expired_tscdeadline = 0;
 	apic_update_lvtt(apic);
 	apic_manage_nmi_watchdog(apic, kvm_lapic_get_reg(apic, APIC_LVT0));
 	update_divide_count(apic);
-- 
2.53.0

