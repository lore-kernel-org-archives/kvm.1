Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792476082;
	b=oUgyBnrl6R25iXxFjssqg4NKEwHHGhSQu9V3JgSvMc4HoRZ5wdss4qjxxrI2GvaLMCTr
	 0Dr+fk0CY9DW4aWW+ndAw/DmCDrV/0V6qrh3OpLcg4bAHV3MsCb8vSr34HPLXQL4MY/LJ
	 l/ozHkAPq8zamz9xeNbbibVoXmhvTQ6z7MpTkuWX8R3eP8WxqXucf1N96gpvc58RBidfG
	 ZPaPQK4WIOkhuoY9d8M2qpJ2U9F16BPNqd4Yypb+J3T3wYF0usIT5OcJo0ubQNFbHFKDk
	 RJKWl6BtHiWNH9PvboDyohU2y3huWC+fO5AcdEked22sBbjlnS2/R0LFk3R9bSWT3lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792476082;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n0lvCzzmfqsXaPehGrVPNSxhMDiKKXELU0wbhzo/qJ0=;
	b=Y4SoZCd1/ARRI6B0pPECLNiC3pXM/NgCp6XWgHV2FSAVUtoT7DPfLfeIckymFoSsTsAi
	 4Alp2iLh/HA0cL8vDLbaj13gQX+gMfsEM+m22HkS9gFNRXx9is6MADfA9IgK0q9LhZy8r
	 Pe2u1p9TBm61tJZeoJEUdugdzE0PT4VMNCfKVOS7tDwnnfuzDLeBFGrcaAJeOBykSFpYY
	 cToWrFk/lCf5QGO9Ibb2sPKx+b0R4TlbZHVtTYgCEBWxsQDEPqHYwvwDhPurcM3qW4enb
	 e+XztW2/xhI5Dqukgd9JzZ4ldeO7S76mumEvqOOGqidnWxSGiLbZ4yTYtXA2VhNrDtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="IIQ/lxQL";
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABD9606A321;
	Tue, 20 Oct 2026 06:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ABD9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IIQ/lxQL
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792476072; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=n0lvCzzmfqsXaPehGrVPNSxhMDiKKXELU0wbhzo/qJ0=;
	b=IIQ/lxQLKZ8Ip8nwtSMS48YoS3LUQRI4Cvp1HHLHtp4o0mrGT1RUH2P0V7lkWLxX2gNrmlbOLzWo9R0scwtI2EPdb5/4QgmEb3F0qoXvzOmVQ7kkXTY/iMgHSfGqBjA4negJfFpYqm9seWftpXIo/IuK0M4z37KbzuMI3S0xce4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=xiang.zheng@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XDBuaNR_1792476066;
Received: from localhost.localdomain(mailfrom:xiang.zheng@linux.alibaba.com fp:SMTPD_---0XDBuaNR_1792476066 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 14:01:11 +0800
From: Xiang Zheng <xiang.zheng@linux.alibaba.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Shannon Zhao <shannon.zhao@linux.alibaba.com>,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] KVM: x86: ioapic: Clear stale RTC pending EOIs using the delivery record
Date: Tue, 20 Oct 2026 14:00:52 +0800
Message-ID: <20261020060053.25011-2-xiang.zheng@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261020060053.25011-1-xiang.zheng@linux.alibaba.com>
References: <20261020060053.25011-1-xiang.zheng@linux.alibaba.com>
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

Use the vCPU/vector pairs recorded in rtc_status to clear completed RTC
pending EOIs instead of consulting the current redirection entry.

AVIC completes EOIs of edge-triggered interrupts in hardware, without a
VM exit, so KVM cannot decrement the RTC pending-EOI count from an EOI
exit.  ioapic_lazy_update_eoi() compensates at the next injection by
clearing the pending EOI of any vCPU that no longer has the vector in
IRR/ISR, but it identifies those vCPUs with the current redirection
entry instead of the delivery record kept in rtc_status.

If the guest rewrites the RTC redirection entry after an interrupt was
delivered and EOI'd without an exit, e.g. because the guest moves the
RTC to another processor, the new route no longer matches the recorded
delivery, so the pending EOI is left set and every later RTC interrupt
is reported as coalesced and dropped.  A guest that relies on the RTC
timer interrupt to advance timekeeping, e.g. a Windows guest without
HPET and with an unused APIC timer, then loses its timer and hangs.

Walk the vCPUs present in rtc_status and test the vector stored at
delivery.  While at it, clear every completed record instead of bailing
out after the first one, and skip pins other than the RTC, the only pin
with delivery tracking.

Fixes: f458d039db7e ("kvm: ioapic: Lazy update IOAPIC EOI")
Signed-off-by: Xiang Zheng <xiang.zheng@linux.alibaba.com>
---
 arch/x86/kvm/ioapic.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 0d59b9c758c2..803fda172db5 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -167,21 +167,18 @@ static void ioapic_lazy_update_eoi(struct kvm_ioapic *ioapic, int irq)
 {
 	unsigned long i;
 	struct kvm_vcpu *vcpu;
-	union kvm_ioapic_redirect_entry *entry = &ioapic->redirtbl[irq];
+	struct rtc_status *status = &ioapic->rtc_status;
+
+	if (irq != RTC_GSI || !status->pending_eoi)
+		return;
 
+	/* Use the target recorded at delivery; the entry may have changed. */
 	kvm_for_each_vcpu(i, vcpu, ioapic->kvm) {
-		if (!kvm_apic_match_dest(vcpu, NULL, APIC_DEST_NOSHORT,
-					 entry->fields.dest_id,
-					 entry->fields.dest_mode) ||
-		    kvm_apic_pending_eoi(vcpu, entry->fields.vector))
+		if (!test_bit(vcpu->vcpu_id, status->map) ||
+		    kvm_apic_pending_eoi(vcpu, status->vectors[vcpu->vcpu_id]))
 			continue;
 
-		/*
-		 * If no longer has pending EOI in LAPICs, update
-		 * EOI for this vector.
-		 */
-		rtc_irq_eoi(ioapic, vcpu, entry->fields.vector);
-		break;
+		rtc_irq_eoi(ioapic, vcpu, status->vectors[vcpu->vcpu_id]);
 	}
 }
 
-- 
2.50.1 (Apple Git-155)

